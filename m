Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1304730BBAB
	for <lists+linux-can@lfdr.de>; Tue,  2 Feb 2021 11:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhBBKBd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Tue, 2 Feb 2021 05:01:33 -0500
Received: from mail-yb1-f177.google.com ([209.85.219.177]:41340 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhBBKBW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 2 Feb 2021 05:01:22 -0500
Received: by mail-yb1-f177.google.com with SMTP id e132so33974ybh.8
        for <linux-can@vger.kernel.org>; Tue, 02 Feb 2021 02:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JZ+HY9aYnm+XZo9XTDUdy8jDZx5P/Wc9pCuW2Gqp5F4=;
        b=sXHq5IjXsPQEdhcDcYExPm7jl0eDcz1ksR3aXYNbcNuCD8HMV5qLxMmOamy33UpAiU
         1LlDBSOUb4g0LQyD9d1VQ5ZSG9tqBA1pBFbZSZfl/C6zKZihAwhdqGjbXcUb8EmZ2S+b
         yR8cE8OIVhKGi/ZgR2or8Wq1/E4XAf3jIDYkORFw+q3jGd2IBfEkU76Ccv1FE4y187UP
         nlXvLyESMAuY24qbST/32vm5eL/G3RI1wHm0ybGnkqSRizd9qh/FQROnKqHWL6BYSXiH
         DySSW2eSf/jYgKweYhHBN1vHE81Ro2Tl6OJhmpikR65VhlOkbuu03kPUBUL/cYKMYNbO
         Bq2w==
X-Gm-Message-State: AOAM533LJqxTEqdM5/UNSmohL9A+6TAIIIQP8NhFdZaYWpuXXbWJN/DJ
        I4uBct/WpKce84hfB332uGnSyCp8W9ONNhSdK/Q=
X-Google-Smtp-Source: ABdhPJwxd1YT+pQuGwV7v3ncHbia1wpK60hFjz3rIZX3gRu1OuFJuV/R0LH8Nl9Hb8rVMpVLFQvm1zSCv3arDKyjU00=
X-Received: by 2002:a25:cd01:: with SMTP id d1mr14573274ybf.125.1612260041449;
 Tue, 02 Feb 2021 02:00:41 -0800 (PST)
MIME-Version: 1.0
References: <CAMZ6RqK0rTNg3u3mBpZOoY51jLZ-et-J01tY6-+mWsM4meVw-A@mail.gmail.com>
 <87e3dd54-50ab-1190-efdb-18ddb3b21a02@hartkopp.net> <42080d05-7ab3-99be-92e2-73ed262350ba@gmail.com>
 <CAMZ6RqJWrObGZRwyA1kD5cEZRUd_-4zt8rsMR+zZPLpxD6AWAQ@mail.gmail.com>
 <1debcaeb-71c7-6b78-88b3-7f121a33c1c1@kvaser.com> <CAMZ6Rq+ObkS2RDFbgbPP7HZH26WbN-eoLeQyiY6+CpDGYjE10w@mail.gmail.com>
 <17b14b11-87bf-9508-0da5-1031c5d5e132@pengutronix.de> <20210202082340.GA23043@x1.vandijck-laurijssen.be>
 <8050d433-591c-2d1f-f0c7-ffa92e33032d@pengutronix.de> <cac31b51-514d-462b-fe48-4c3bea8b28fd@hartkopp.net>
 <1b82f875-5884-3bf6-7891-2e4461d2a72a@pengutronix.de> <abc8923c-8cf6-c0d5-ec67-73afe183b9b3@hartkopp.net>
In-Reply-To: <abc8923c-8cf6-c0d5-ec67-73afe183b9b3@hartkopp.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 2 Feb 2021 19:00:30 +0900
Message-ID: <CAMZ6RqKx5NCFKiahb8AbUx=LC5xS6oYCdVZk8WGSAzZeAVs9Qg@mail.gmail.com>
Subject: Re: [Question] Sending CAN error frames
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Jimmy Assarsson <extja@kvaser.com>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue. 2 Feb 2021 à 18:16, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 02.02.21 10:05, Marc Kleine-Budde wrote:
> > On 2/2/21 10:00 AM, Oliver Hartkopp wrote:
> >>>> IMO, can_frames in the tx path with CAN_ERR_FLAG should be dropped
> >>>> if the driver can't handle them. vcan in this regard is capable of
> >>>> handling those, as does the kvaser usb.
> >>>
> >>> Makes sense. The implementation steps could be:
> >>> - convert can_dropped_invalid_skb() from static inline to
> >>>     regular function
> >>> - add check for CAN_ERR_FLAG and enabled CAN_CTRLMODE_TX_ERR
> >>>     to can_dropped_invalid_skb()

Back to the idea of my initial e-mail :)

> >> Which means the vcan has to support CAN_CTRLMODE_TX_ERR too.
> >>
> >>>> I think it's wrong that CAN_ERR_FLAG messages would appear as regular
> >>>> frame on CAN, as happens today if I understood well.
> >>>
> >>> ACK

If we could go in the past, those should have appeared on the error socket.

> >> What happens if you send a valid CAN frame with CAN_ERR_FLAG set?
> >>
> >> I did not check it but I assume the frame is sent as normal frame and
> >> the echo'ed CAN frame would *only* go through the error message filter
> >> bank in af_can.c.
> >
> > If CAN_CTRLMODE_TX_ERR has been added to the kernel and
> > can_dropped_invalid_skb() is updated, then a CAN frame with CAN_ERR_FLAG set
> > would be either send as an error frame or dropped by can_dropped_invalid_skb().
> >
> > So it would be echoed only if the driver supports CAN_CTRLMODE_TX_ERR and it's
> > enabled.
>
> ACK.

The echo would be special here.  We have to remember that the
payload of the CAN_ERR_FLAG frames is an arbitrary design. This
payload has no meaning for the data link.

When we echo back the frame, only the DLC, CAN ID and payload of
the TX frame are irrelevant (except for vcan).

My current idea would be to follow what Kvaser did: they send the
frame and the device reports the error flag (c.f. the example
given by Jimmy above). So the echo feature would not be used
for error flags.

@Jimmy, could you confirm my understanding? Do you use the echo
functionality for error flags in the Kvaser driver?

> So a second time Vincent found a mismatch nobody cared about so far.
> Congrats, Vincent!
> (no irony here)
>
> ;-)

Thanks, this is me wearing my hacker's goggles.

> >> This is probably not what we want for 'real' CAN devices, so we might
> >> have to take a look at this too.
> >
> > Marc
> >
