Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A61309D88
	for <lists+linux-can@lfdr.de>; Sun, 31 Jan 2021 16:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhAaPZn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 31 Jan 2021 10:25:43 -0500
Received: from mail-yb1-f173.google.com ([209.85.219.173]:33275 "EHLO
        mail-yb1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhAaONM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 31 Jan 2021 09:13:12 -0500
Received: by mail-yb1-f173.google.com with SMTP id m76so7405949ybf.0
        for <linux-can@vger.kernel.org>; Sun, 31 Jan 2021 06:12:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OpFwfC/mEPtMTaRLpPtnOcjvTlTvByr18cBYfwyEmVM=;
        b=hqxuQYqiqSHXiDORo0kgVE63Fsyjl/VQ/LZG2Wdhnn59kTvKisWMNzg5nWEx3r+c8Q
         jWb2npQBexTd3/m1x1/696PUt7PVP68oFucAH680LLCq7vALakZc7SFHPXwMbmh3UuS+
         ZSpRpe9RMC1WZl9NwjAZGh8mNyGZrduL20COiP5+sbJeAibBtP/dprHPlzsdyS0gK155
         gX3BJFGwLOzCXOiZ9BtoruzKJmHQmBJzfqUUdaRpIY9Q4RGfd4LdDtbDW1SnjC4Hd0WJ
         RD0ZywlenC0TT1ZBS0aFPUGQ/EG8BRsIBD+ezILupyaGqmV+Qaehq6atmb1+WQim1npm
         LJ8A==
X-Gm-Message-State: AOAM532tTtnEEbujAyARjv4x8U76LtZZu967kmqUO1ZPUWmARe2uTt4N
        /Tzuoi2X6saMTP9tzO3kyUfEPD80L2Aio7BIPemhXU1gT4TKoRo0
X-Google-Smtp-Source: ABdhPJzZHIRY+NQUKyM7XKCHnZmsslXwkdp77vPFfXE0U0oYxEmhR3CoPlk351DzvqjKriaATRkkduTeKQN6XZEW3SM=
X-Received: by 2002:a25:4fd6:: with SMTP id d205mr17351428ybb.145.1612102351351;
 Sun, 31 Jan 2021 06:12:31 -0800 (PST)
MIME-Version: 1.0
References: <CAMZ6RqK0rTNg3u3mBpZOoY51jLZ-et-J01tY6-+mWsM4meVw-A@mail.gmail.com>
 <87e3dd54-50ab-1190-efdb-18ddb3b21a02@hartkopp.net>
In-Reply-To: <87e3dd54-50ab-1190-efdb-18ddb3b21a02@hartkopp.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 31 Jan 2021 23:12:20 +0900
Message-ID: <CAMZ6RqKhCc9ko93Z839DmyDOW+rt3UETo54hZXqjXGYH9RyMLw@mail.gmail.com>
Subject: Re: [Question] Sending CAN error frames
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Jimmy Assarsson <extja@kvaser.com>,
        Christer Beskow <chbe@kvaser.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Oliver,

On Sun. 31 Jan 2021 at 21:59, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Hi Vincent,
>
> On 31.01.21 07:22, Vincent MAILHOL wrote:
> > Hello,
> >
> > The socket CAN API handles the CAN errors (as reported by the
> > microcontroller) by emitting some RX CAN frames with the
> > CAN_ERR_FLAG set.
>
> Yes. This is the only intention.
>
> > My question concerns the transmission path: I would like to
> > understand how drivers should handle *TX* CAN frames which have
> > the CAN_ERR_FLAG set.
> >
> > The socket API allows sending such frames. For example doing:
> >      cansend can0 20000123#0011223344556677
> > will generate such frames and it will reach the xmit() function of
> > the driver.
>
> The reason to pass the frame as-is to the driver layer (including
> CAN_ERR_FLAG) is the possibility to test the correct behavior on the RX
> path, e.g. when you use the vcan driver.

ACK. I was not thinking of the virtual interfaces. This is a valid use case.

> On the sending path the CAN_ERR_FLAG has no functionality so far - at
> least it was not defined by the community.
>
> > However, contrary to the other flags (EFF, RTR, FDF, BRS), the
> > ERR flag is not present on the data link layer. Instead, the data
> > link layer is responsible for detecting errors and signaling those
> > as soon as they occur (thus interrupting the transmission).
> >
> > While the ISO standard does not explicitly forbid having upper
> > layers generating such frames, it is not documented. Also, I am
> > not aware of CAN controllers allowing to generate error frames on
> > demand.
>
> There are specialized CAN testers, e.g. IIRC Vector CANstress that can
> generate error frames on specific conditions (e.g. when detecting a
> specific CAN ID).

Thanks for the references!

> But I heave not seen CAN controllers that provide such functionality.
>
> > My initial expectation is that those error frames only make
> > sense in the RX path and that we should drop such TX frames in,
> > for example, can_dropped_invalid_skb().
>
> No. As written above the bit is defined to be valid in the RX path only
> and it makes sense for testing.

ACK. My follow-up question would be: how should the driver handle
such frames? Drop them or ignore them?
From what you just explained, I now think that ignoring it is the
best solution (e.g. mask the CAN ID with either CAN_EFF_MASK or
CAN_SFF_MASK and send it as a normal frame).
Does that make sense?

> > However, after looking at the code of other drivers, it appears
> > that one (and only one) of them: the Kvaser hydra, does actually
> > check this CAN_ERR_FLAG flag in the TX path:
> > https://elixir.bootlin.com/linux/v5.11-rc5/source/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c#L1421
> >
> > I would be thankful if anyone knowledgeable about the Kvaser hydra
> > could explain to me how the device handles those error frames.
>
> o_O - Yes, would be interested too!!
>
> > Also, please comment if you are aware of any use cases for TX
> > error frames.
>
> Done.

And thanks for that!

> Best regards,
> Oliver
