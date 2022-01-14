Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB14648E821
	for <lists+linux-can@lfdr.de>; Fri, 14 Jan 2022 11:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240302AbiANKQQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Fri, 14 Jan 2022 05:16:16 -0500
Received: from mail-yb1-f170.google.com ([209.85.219.170]:45612 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239524AbiANKQO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 Jan 2022 05:16:14 -0500
Received: by mail-yb1-f170.google.com with SMTP id h14so22598185ybe.12
        for <linux-can@vger.kernel.org>; Fri, 14 Jan 2022 02:16:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Oyn741sdaZAozINtzbvz4gTMibv3/l8R4O8IaVjqqS0=;
        b=hE9FME/+zqk0GfDfYFdPdz+zG2MlU1pxCQ8K71QVl+8dB9CQAGhVG9LaEXAS73jpv4
         i6wZjHmFPE9x8X1e7MNWYX6hUyllNb2HSZa8e+Kwz2+d/PVeUimZ5ZlU2/qhCnbl+vGH
         QI4wCoM+Fybp/w6qUWqCJWxYqwPeyCt9NJ+raUj41AhJjCu9809liT5RE1mcJ8Hg5ffq
         Lh7iZYBhaAAsIV3mrCK9s4RSykNJ1NWJGv1t1aPW3MboPMKjd7ZIhBRmXfly0iUm/If4
         ORbP98Ocwx572sttko+TVK6OzgYms8A3hAQCuSQ3WCNx/pvZSu64lbnpXLMmB1Ns1Yep
         0uZQ==
X-Gm-Message-State: AOAM53059CYp23e7IpTKMykVtaDGm5upc4xdq3j9gKPSNfCwSWjwkKed
        AYqSy62ZgePXFdpRkZjyoQmPwq/yNCtwohOCUZ4=
X-Google-Smtp-Source: ABdhPJy0FpN+aysxTI9CdEvaJ/bfp586IxBUBIncICZLTGYdj1nHunVs5fZDQibpUYUUk2eKoxcBbGW0jZ1YWMBw2RA=
X-Received: by 2002:a25:b15:: with SMTP id 21mr9783844ybl.397.1642155373955;
 Fri, 14 Jan 2022 02:16:13 -0800 (PST)
MIME-Version: 1.0
References: <DM6PR02MB538645C4ECE3BBBD3CE92A17AF539@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220113203004.jf2rqj2pirhgx72i@pengutronix.de> <20220113211018.tqddyiix3vy5q3eq@pengutronix.de>
In-Reply-To: <20220113211018.tqddyiix3vy5q3eq@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 14 Jan 2022 19:16:02 +0900
Message-ID: <CAMZ6RqJTO8X+YZBb5g0WjObeB=oR1QzguazahsBhJOTz5+1MoQ@mail.gmail.com>
Subject: Re: Queries on CAN frame work
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Srinivas Neeli <sneeli@xilinx.com>,
        Srinivas Goud <sgoud@xilinx.com>,
        Naveen Kumar Gaddipati <naveenku@xilinx.com>,
        Prasad Beer Prasad <prasadbe@xilinx.com>,
        linux-can <linux-can@vger.kernel.org>,
        =?UTF-8?Q?Stefan_M=C3=A4tje?= <Stefan.Maetje@esd.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Le ven. 14 janv. 2022 à 06:10, Marc Kleine-Budde <mkl@pengutronix.de> a écrit :
>
> On 13.01.2022 21:30:04, Marc Kleine-Budde wrote:
> > > Recently we did few experiments with our CANFD network. Stuff error
> > > observed with different Nominal and Dataphase prescaler configuration
> > > values, which we get from the frame work.
> > >
> > > For lower baud rates separate prescalers are working good, but when we
> > > switch to high baud rates(like 4Mbps and 5Mbps) observed the BUSOFF
> > > state(Due to stuff errors) on IP(Xilinx).
> > >
> > > With shared prescaler(low prescalers) we are not seeing the issue..
> > >
> > > In Iso spec also mentioned to avoid tolerance, we have to maintain
> > > common TQ for Nominal and Data phase.
>
> This is a known problem with the current arbitration and data bit rate
> calculation. They are done independently of each other, resulting in not
> common pre-scalers and thus not common TQ.
>
> > > Spec: ISO 11898-1:2015(E)  page no :50
> > >
> > > " If the same time quantum length is used in the nominal bit time and
> > > in the data bit time and the positions of the sample points in the
> > > nominal bit time are the same in all CAN nodes of a network, then
> > > optimum clock tolerance is accomplished for networks using FD frames."
> > >
> > > CIA:
> > > https://can-newsletter.org/uploads/media/raw/f6a36d1461371a2f86ef0011a513712c.pdf
> > >
> > > From above CAN-newsletter also suggested the same in recommendation 2 and 3.
>
> I'll have a look at the newsletter and see what changes need to be done
> to the existing algorithm.
>
> > > Recommendation 2: Set the BRPA bit-rate prescaler equal BRPB
> > > Recommendation 3: Choose BRPA and BRPD as low as possible
> > >
> > > Is there any possibility in framework to use shared prescalars for
> > > Nominal and Dataphase?.
>
> Not yet.

Well, technically, skipping the full calculation and providing all
bittiming parameters will allow you to use shared prescalers. But
indeed, there is nothing to automatically calculate it nor to check the
sanity of manually provided bittiming parameters.

> > > One more question. How to calculate TDCO ?, is there any generic
> > > formula for this ?.
>
> Vincent (Cc'ed) can help you on this.

It is implemented in the kernel here:
https://elixir.bootlin.com/linux/latest/source/drivers/net/can/dev/bittiming.c#L178

You can refer to the patch description for additional info.
 * Original patch:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c25cc7993243fdc00ab7e608e3764819538015ab
 * Amended by:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=39f66c9e229797a58a12ea78388cbbad1f81aec9

N.B.: the comments of the original patch related to iproute2 are outdated.

If you follow the links in the patches you will find even more discussions
on this topic in the mailing list archives. But I guess that the commit
description is enough to answer your questions.

Also, please note that the xilinx driver does not yet implement TDC.
Actually, TDC netlink framework was introduced recently in the kernel and
as of today only the etas_es58x does support it.

By the way, Marc, did you get an answer from Microchip on the relative
TDCO topic for the mcp25xxfd?
c.f. https://lore.kernel.org/all/20210817094306.iyezzml6m7nlznri@pengutronix.de/


Yours sincerely,
Vincent Mailhol
