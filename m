Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6695371761
	for <lists+linux-can@lfdr.de>; Mon,  3 May 2021 17:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhECPD4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 3 May 2021 11:03:56 -0400
Received: from mail-yb1-f176.google.com ([209.85.219.176]:42658 "EHLO
        mail-yb1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhECPDz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 3 May 2021 11:03:55 -0400
Received: by mail-yb1-f176.google.com with SMTP id r8so7898288ybb.9
        for <linux-can@vger.kernel.org>; Mon, 03 May 2021 08:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cw8rj9kn2r1PhwiPVJ7jXw6YYSoWR9ZKqM/2rnSuZeg=;
        b=RjQivz0aYj0CRL89qVmjbOLfn5M8w5mf4UnV46H8NLJH8EHRspXueENq5nJ51H7wXn
         ty58VBCbBG/kPMQ2zlQ58rmnermgnIGhi9hzEgmumociZOPdelp5ElXDUo8Z+uGnM6Wf
         EJgi7kjocGh0L9WKwK1sBlLTTJRQMy/8QtBtaTw0UVsUhEmfgMHKHtOSM+Fx9sCmuUCz
         NqfDMgLlmHIMkanIMJwzkFVWpi1PbV0N9oeV60C9aOpFZ8pa0N8nZ6ZjgGCxWQre1BEp
         dRym5aHKGMRauVO+0W2S8XNuRh4MukFTSBur5+vm5EQs0lraHjQ+QyVeozabCstNB/nX
         CX3A==
X-Gm-Message-State: AOAM5333mSYNncMu8NdfEZuJ/XQx20XRrexwHP+8tII2BxahWmwWckvX
        o89MgpHNJyeQ0lsOwe47RESY8Tq2/lgWs2pvDNs=
X-Google-Smtp-Source: ABdhPJyc5+ampoY/H+kBDqkjCdfmtN3qqa8wVjrWY+fYfcI6J8nKq2OxTrjif/h4Fl8xMEestKyuhqe8yRhQt2ih1a8=
X-Received: by 2002:a25:35d7:: with SMTP id c206mr25410608yba.307.1620054181166;
 Mon, 03 May 2021 08:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210503100246.n7uu437kbabdzu7m@pengutronix.de> <20210503100810.cacbmdfmpjipgoka@pengutronix.de>
In-Reply-To: <20210503100810.cacbmdfmpjipgoka@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 4 May 2021 00:02:49 +0900
Message-ID: <CAMZ6RqLKp981zBus9K1RiLL14zC0B2BGp0U+xuQGvj1fjDMF1g@mail.gmail.com>
Subject: Re: More flags for logging
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>, kayoub5@live.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon. 3 Mai 2021 at 19:08, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 03.05.2021 12:02:46, Marc Kleine-Budde wrote:
> > The SocketCAN API is a great initiative for standardizing the CAN
> > interface API. This request tries to extend this initiative for more use
> > cases.
> >
> > Context:
> >
> > The SocketCAN was adopted by libpcap and tcpdump as the standard format
> > for logging CAN Frames in PCAP and PCAP-NG. See:
> >
> > https://www.tcpdump.org/linktypes/LINKTYPE_CAN_SOCKETCAN.html
> > https://github.com/wireshark/wireshark/blob/master/epan/dissectors/packet-socketcan.c
> > https://www.wireshark.org/docs/dfref/c/can.html
> >
> > Problem:
> > Applications that perform logging, usually need more details that normal
> > applications, for the sake of debugging later on. Flags needs to be
> > reserved/allocated in the SocketCAN API, so that logging applications
> > can make use of them in the PCAP format. The flags does not need
> > necessary need to be implemented by SocketCAN, they just need to be
> > marked as reserved for such use case.
> >
> > Needed Flags:
> > FDF Flag
> > - Since CAN Frames and CAN-FD frames can co-exist in the same bus,
> >   logging application needs to know if a normal CAN Frame was
> >   transmitted on a CAN-FD bus, namely was the FDF bit set or not.
>
> I think someone asked for that some time ago. But that was never
> mainlined. I'll look for that old mail.

The current API compares the size of the received structure with
the MTU to determine whether the message is classical CAN or CAN
FD.  If the struct can_frame and canfd_frame are stored as
is (including the padding at the end of the data array), then the
information is maintained.

Personally, I would have liked to also have a FDF flag in Socket
CAN userland API because I think it would be more intuitive than
the MTU solution. So I am open to this option and would also be
happy to see the flag implemented in Socket CAN (not only
reserved).

But, I also understand that it will create redundancy.

> > ACK bit in data frame
> > - Some logging hardware can act as a "spy", meaning that it records CAN
> >   Frames, but does not set the ACK bit
> > - A way to know for a given frame (FD or not), was the ACK bit set or
> >   not.
> > - Current API allow detecting missing ACK, but it does not report what
> >   Frame had a missing ACK.
>
> This means the driver has to set a flag if it's configured in
> listen-only mode. That should be possible.

For my understanding, when a controller does not see the ACK bit,
it stops the transmission and sends an error flag. For this
reason, the frame is not received and thus simply does not appear
in the log.

So this issue is not only about adding an ACK flag but is about
implementing a solution to report on which frame a given error
flag occured (not specific to ACK errors).

And to clarify the "spy mode", if all the receivers on the bus
are spies, then the ACK bit is never set and thus the
transmission should always result in an ACK error flag. If at
least one receiver is normal (not spy) it should send a dominant
ACK bit and thus all nodes (including the spies) see the flag as
dominant. In other terms, a received CAN frame has the ACK flag
set.

> I think we can make use of flags in the struct canfd_frame for this:
>
> | struct canfd_frame {
> |       canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
> |       __u8    len;     /* frame payload length in byte */
> |       __u8    flags;   /* additional flags for CAN FD */
> |       __u8    __res0;  /* reserved / padding */
> |       __u8    __res1;  /* reserved / padding */
> |       __u8    data[CANFD_MAX_DLEN] __attribute__((aligned(8)));
> | };
>
> The struct can_frame doesn't have the flags member yet, but we can add
> it there.
>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
