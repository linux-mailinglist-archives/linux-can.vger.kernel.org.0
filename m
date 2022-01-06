Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF3248630D
	for <lists+linux-can@lfdr.de>; Thu,  6 Jan 2022 11:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbiAFKlG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 6 Jan 2022 05:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbiAFKlG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Jan 2022 05:41:06 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7363DC061245
        for <linux-can@vger.kernel.org>; Thu,  6 Jan 2022 02:41:05 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j11so4106169lfg.3
        for <linux-can@vger.kernel.org>; Thu, 06 Jan 2022 02:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1czyie5YOXjd7iYCmC32BQc55W/Mwsn+Qdordx3yEuA=;
        b=isyVPeeJSDTNyZak0r9LN5DGiO6t7mb4h7kON0veq5+cEwvzHFYQLVpBTJwo7LMy+r
         xLjW9KZSvkhwd2LlgGPZ+T9sjvbHbXu2QTtwNYedRrDK6vvGrAWTNB8FlapCvGbHke2W
         XGwFY2kblGdRcSFUWbX79VxGwtgN/uDVYsx6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1czyie5YOXjd7iYCmC32BQc55W/Mwsn+Qdordx3yEuA=;
        b=54DJG7BH95zimx4eLoFSz33v58brb7JZDJlvSud7XaddpbiOUud2ePc6tQWZoeX1Jo
         RGxC7tQk9hJVUPmyti3zAB+zQeOYxEgJ34CHbHaE7osf1yz0EUUKWjD6mNbYkJV96eYP
         pH70WewB+fwIuvsL6WuoML/vB9ce3gw6idh1IBcIHfMtzWt3vzy0yfSeum3//pL1KoUs
         M56UrHWR7CCq8QK2kwWTmQ5twKN4C64/YIUNt7AAMp9w/njoM38AT7yvP2TvcMjtd7cD
         o1jeDv2Q03FtA3CRhPluDeTFH0rdyT3WpgFZLV3RNOF+yfCCEBPsS97iJrT+nmwJJnvv
         cxNA==
X-Gm-Message-State: AOAM5324k9KB/ZN1hrCRo4sbkAlE0abjz2w0+l8PcfO5qKisJ9vZtJlR
        /e5DP/nvT/KccM2ZKu+FEDdDPKAMRGqGNcGw9DZ1cDp9UbP6uQ==
X-Google-Smtp-Source: ABdhPJz42gYvkaguYsroChhbtLprexGvbJdUn5KIHbmyd53EIGiTp1tYosyWDvumaKcOjUldWcwNafLAsh28/VD9Bxg=
X-Received: by 2002:a05:6512:3f89:: with SMTP id x9mr25200974lfa.536.1641465663709;
 Thu, 06 Jan 2022 02:41:03 -0800 (PST)
MIME-Version: 1.0
References: <20220104154133.848784-1-mkl@pengutronix.de> <CABGWkvo+h2CASM7q8z3UXRofrY7enVXS6njFKnKyqRUjgkbB_A@mail.gmail.com>
 <20220105101414.kg7mwp2uop6rsfbv@pengutronix.de>
In-Reply-To: <20220105101414.kg7mwp2uop6rsfbv@pengutronix.de>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Thu, 6 Jan 2022 11:40:52 +0100
Message-ID: <CABGWkvo-tuYDDJv+EBzPhf5RGCyt5eMD14ePq9C9Y4de_=fX=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] can: flexcan: change RX-FIFO feature at runtime
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Wed, Jan 5, 2022 at 11:14 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 05.01.2022 09:25:35, Dario Binacchi wrote:
> > > Is the name "rx-fifo" acceptable? Can you think of a better name?
> >
> > If I am not mistaken this series arises from the need to deactivate
> > the RxFIFO only if it is acceptable not to receive the notification of
> > RTR messages.
>
> ACK
>
> > I wonder if this can be made explicit to the user.
>
> I was hoping that we can find a better string that better represents
> what this option does.
>
> > Do you think it makes sense to explicitly RTR ("rtr-notify") instead
> > of RxFIFO (rx-fifo)? And if it makes sense to make it clear that it
> > occurs at the expense of a smaller number of messages allocated for
> > reception?
>
> I see it the other way round, probably biased by the existing driver :)

Could this change of perspective then not require the addition of a new
quirk that allows to change between rx-fifo and rx-mailbox mode?

> The user wants to use more buffers at the expense of loosing the ability
> to receive RTR messages.

Can / should it be documented in some way other than the commit message?

>
> I've talked to one of my colleges and we came to the conclusion that the
> driver should present the user the option to opt out from RTR reception.
>
> If the user has opted out from RTR reception the driver can do internal
> optimization, such as switching from FIFO to mailbox mode.

Is it really always true? In the case of imx6 can we still remain in
mailbox mode
and enable / disable RTR reception through Remote Request Storing (CTRL2
[RRS]) bit?

>
> What about "rtr-rx" or "rx-rtr"?

I prefer "rx-rtr"

Thanks and regards,
Dario

>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |



-- 

Dario Binacchi

Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
