Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB92372F1A
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 19:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhEDRp7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 13:45:59 -0400
Received: from mail-yb1-f169.google.com ([209.85.219.169]:46895 "EHLO
        mail-yb1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhEDRp7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 13:45:59 -0400
Received: by mail-yb1-f169.google.com with SMTP id y2so13239000ybq.13
        for <linux-can@vger.kernel.org>; Tue, 04 May 2021 10:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MrBAUdvYVC9kD8Hgi9yFnI3rnbaEm9RLwSTQVvEXmOk=;
        b=VJu/W3EzYFSpqyUzcrtfK09Xpluly0dW6HmNZR0AJZMM9T6n+aK4KZGj4MKPU/6hCO
         QA3M9XJw19FxVzlDsougrTNMC2Ou+ZkOj0ebBMmFAk2E2TkbRC3nmIdHqkf0lEGbeTPd
         vhT831wr8WUbH02C8217no3TcrNA0w2aZ7rrn55H4oBa1cqDsOxiWMMv4eoF0nMZeCEG
         xTotOnCkM7asVjDRuc7OObvYuuNghNzMyeQDkX7tjpoaQOw83L1mq1OhonAtubJa3fMZ
         Y+XBK/ZLS7DmaHrM2EMPBwlRER7gy6wYotmRoYZdy7zuWK7/mwbguWnR7B/aPEWIF/iv
         sUlA==
X-Gm-Message-State: AOAM533jOJGBhJHlfm0xdDH6m3DTuGygUutFMtwvV4Fb3eThoQc5CaMy
        BiaeD7hXquxVK4m8RCwmLPW8dXqNINiqBNivpn0=
X-Google-Smtp-Source: ABdhPJzG61BU9z+zXNyeS/npcsQBmjgCQc+DqE/uSIA5E3+sO6m4ulH8F+B7hw1vXneydWH1uIMDVoI7sLnbPhQFxdg=
X-Received: by 2002:a25:be09:: with SMTP id h9mr37025532ybk.239.1620150302712;
 Tue, 04 May 2021 10:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210503100246.n7uu437kbabdzu7m@pengutronix.de>
 <20210503100810.cacbmdfmpjipgoka@pengutronix.de> <CAMZ6RqLKp981zBus9K1RiLL14zC0B2BGp0U+xuQGvj1fjDMF1g@mail.gmail.com>
 <DBBPR03MB70828377F51A1747B4E9E6529D5B9@DBBPR03MB7082.eurprd03.prod.outlook.com>
 <20210503154749.q3nrfjveixsqp3uj@pengutronix.de> <DBBPR03MB7082F029173018680E5D869C9D5B9@DBBPR03MB7082.eurprd03.prod.outlook.com>
 <CAMZ6RqJ0t91e-e9LwzaLWTY6G9MY7mosos9-DEs=pc0mWRf86Q@mail.gmail.com>
 <20210504074834.tki7gzr6wz2le6o3@pengutronix.de> <CAMZ6RqK1ZnygjiZ=sXf7zBSodhL1oS1GZz1rcu=92aQ_A-sFew@mail.gmail.com>
In-Reply-To: <CAMZ6RqK1ZnygjiZ=sXf7zBSodhL1oS1GZz1rcu=92aQ_A-sFew@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 5 May 2021 02:44:51 +0900
Message-ID: <CAMZ6RqKmH_thw3C6AgwUr-eVkYiz9paFZtC49M9xTn0xBkuCfA@mail.gmail.com>
Subject: Re: mcp251xfd receiving non ACKed frames (was: Re: More flags for logging)
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Ayoub Kaanich <kayoub5@live.com>,
        linux-can <linux-can@vger.kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue. 4 Mai 2021 at 21:22, Vincent MAILHOL <mailhol.vincent@wanadoo.fr> wrote:
> On Mar. 4 Mai 2021 at 16:48, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > On 04.05.2021 06:46:17, Vincent MAILHOL wrote:
[...]
> > > Are you still able to send frames and receive the echo if there is a
> > > single node on the network?
> >
> > No - But the peak driver/hw has some limitations:
> >
> > The peak driver doesn't have TX complete signaling, it send the echo
> > after sending the TX CAN frame via USB. And the peak controller seems to
> > buffer quite a lot TX CAN frames, so it looks for the first ~72 frames
> > like the bus is still working.
>
> Yes, I also noticed that when I had peak devices in my test
> lab. The peak driver call can_put_echo_skb() inside
> peak_usb_ndo_start_xmit() and thus, the echo frames do not
> reflect whether the actual completion occured or not. I guess
> fixing that should not be too hard but I do not have access to
> that hardware anymore to do it myself.
>
> I am just surprised by the value of 72 frames. My understanding
> is that peak_usb_ndo_start_xmit() should stop the network queue
> whenever the number of active tx urbs reaches 10.
> Ref:
> https://elixir.bootlin.com/linux/latest/source/drivers/net/can/usb/peak_usb/pcan_usb_core.c#L399
> https://elixir.bootlin.com/linux/latest/source/drivers/net/can/usb/peak_usb/pcan_usb_core.h#L29

Hi Marc, please ignore above paragraphs. I mixed up the tx buffer
with the TX frame buffer. Also, implementing a full TX completion
might actually not be possible due to the Peak device
limitations.
