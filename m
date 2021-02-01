Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F29B30A983
	for <lists+linux-can@lfdr.de>; Mon,  1 Feb 2021 15:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhBAOU3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 1 Feb 2021 09:20:29 -0500
Received: from mail-yb1-f178.google.com ([209.85.219.178]:43103 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhBAOU1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 1 Feb 2021 09:20:27 -0500
Received: by mail-yb1-f178.google.com with SMTP id y128so16977913ybf.10
        for <linux-can@vger.kernel.org>; Mon, 01 Feb 2021 06:20:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6x1EaUuwLV2Hd5QoGV7Xy8qzZIYLEM9GxBGasKu9kUA=;
        b=k5/CDXWpSa+4mn4pCgOaidpI+TJHh6vYpXkQAA/52kax/ZidLI71N6uEePk1xuPIem
         ChsoSDNMWVhpNRmzZbPQF9pFHZdgXR9cyORtuWz4pibsqNXtOUryDjHe4n9CIuB5ZIwy
         31BYuBm1BgFx43/1NOU6O4JqFx3arO6QDro1GsnPFc+bF8Ks57QGJOcWOkdIgeXn4W3t
         uZyXBexFdWBRAEkURLfc5aoY5I81yh2Qa2WJXeTbGqJMd4qlF6/l+KJnFwF71gPJ4nLz
         4Fwjl4ZcwlH1NBjRCDW7nWWw4aLcoea1QN5xFy8L5cOkeZvRAU36ReoBP7vaqQN0c4l9
         dwZg==
X-Gm-Message-State: AOAM531iXgp47fW/3z/i0bO0v9dZXvXU2NKBFvWIfnGt9Ve39JRq9UxI
        QsDWv78JIbdi3opun2d4NmT1gI/9hBwvDawIm74=
X-Google-Smtp-Source: ABdhPJyQ6ASZK/zm6Wd4TsQxT+eMDhq7CEIHtLjZf7Ce42Q3TaKHpu1d3QrxroH1egKzR0pK9wlDF2X1eJEIB/eyXlA=
X-Received: by 2002:a25:cd01:: with SMTP id d1mr8555938ybf.125.1612189185841;
 Mon, 01 Feb 2021 06:19:45 -0800 (PST)
MIME-Version: 1.0
References: <CAMZ6RqK0rTNg3u3mBpZOoY51jLZ-et-J01tY6-+mWsM4meVw-A@mail.gmail.com>
 <87e3dd54-50ab-1190-efdb-18ddb3b21a02@hartkopp.net> <42080d05-7ab3-99be-92e2-73ed262350ba@gmail.com>
In-Reply-To: <42080d05-7ab3-99be-92e2-73ed262350ba@gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 1 Feb 2021 23:19:34 +0900
Message-ID: <CAMZ6RqJWrObGZRwyA1kD5cEZRUd_-4zt8rsMR+zZPLpxD6AWAQ@mail.gmail.com>
Subject: Re: [Question] Sending CAN error frames
To:     Jimmy Assarsson <jimmyassarsson@gmail.com>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Jimmy Assarsson <extja@kvaser.com>,
        Christer Beskow <chbe@kvaser.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Jimmy,

On Mon. 1 Feb 2021 at 05:42, Jimmy Assarsson <jimmyassarsson@gmail.com> wrote:
>
> On 2021-01-31 13:59, Oliver Hartkopp wrote:
> > Hi Vincent,
> >
> > On 31.01.21 07:22, Vincent MAILHOL wrote:
> >> Hello,
> >>
> >> The socket CAN API handles the CAN errors (as reported by the
> >> microcontroller) by emitting some RX CAN frames with the
> >> CAN_ERR_FLAG set.
> >
> > Yes. This is the only intention.
> >
> >> My question concerns the transmission path: I would like to
> >> understand how drivers should handle *TX* CAN frames which have
> >> the CAN_ERR_FLAG set.
> >>
> >> The socket API allows sending such frames. For example doing:
> >>      cansend can0 20000123#0011223344556677
> >> will generate such frames and it will reach the xmit() function of
> >> the driver.
> >
> > The reason to pass the frame as-is to the driver layer (including CAN_ERR_FLAG) is the possibility to test the correct behavior on the RX path, e.g. when you use the vcan driver.
> >
> > On the sending path the CAN_ERR_FLAG has no functionality so far - at least it was not defined by the community.
> >
> >> However, contrary to the other flags (EFF, RTR, FDF, BRS), the
> >> ERR flag is not present on the data link layer. Instead, the data
> >> link layer is responsible for detecting errors and signaling those
> >> as soon as they occur (thus interrupting the transmission).
> >>
> >> While the ISO standard does not explicitly forbid having upper
> >> layers generating such frames, it is not documented. Also, I am
> >> not aware of CAN controllers allowing to generate error frames on
> >> demand.
> >
> > There are specialized CAN testers, e.g. IIRC Vector CANstress that can generate error frames on specific conditions (e.g. when detecting a specific CAN ID).
> >
> > But I heave not seen CAN controllers that provide such functionality.
> >
> >> My initial expectation is that those error frames only make
> >> sense in the RX path and that we should drop such TX frames in,
> >> for example, can_dropped_invalid_skb().
> >
> > No. As written above the bit is defined to be valid in the RX path only and it makes sense for testing.
> >
> >> However, after looking at the code of other drivers, it appears
> >> that one (and only one) of them: the Kvaser hydra, does actually
> >> check this CAN_ERR_FLAG flag in the TX path:
> >> https://elixir.bootlin.com/linux/v5.11-rc5/source/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c#L1421
> >>
> >> I would be thankful if anyone knowledgeable about the Kvaser hydra
> >> could explain to me how the device handles those error frames.
> >
> > o_O - Yes, would be interested too!!
>
> Hi Vincent and Oliver,
>
> When the user passes a frame with CAN_ERR_FLAG set, the CAN controller will generate an error frame.
> We got customers that use this for testing system robustness and fault reporting/handling.

Interesting.

There are two forms of error flags:
  - The active error flag: 6 consecutive dominant bits
  - The passive error flag: 6 consecutive recessive bits
Can it generate both or only one of these? Is it generated as
soon as the device receives the command or is it generated at a
predefined timing (e.g. beginning of the frame)?

Which CAN microcontroller is used inside the device?

Also, could you point me to the Kvaser hydra product page? I
couldn't find it with a quick search so I figured out that maybe
the commercial name is different?

> We also got this implemented in the early version of kvaser_pciefd driver, but dropped it:
> https://marc.info/?l=linux-can&m=154324867704480&w=2
> Is this something that we should remove from kvasr_usb aswell?

No. My intent is not to ask you to remove it. It is rather the
opposite: I want to understand more how you are able to achieve
what I thought not to be possible. For what you told me, the
Kvaser hydra is the kind of device which I would like to have in
my testing environment :)

However, it would make sense to normalize this use case in the
Socket CAN interface. For the discussion with Oliver, it is clear
that this use case is currently not expected and undefined, the
reason being that such a CAN controller was not thought to
exist. Now that you have proved us wrong, things are different.


Yours sincerely,
Vincent
