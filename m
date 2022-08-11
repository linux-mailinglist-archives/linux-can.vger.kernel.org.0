Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21110590747
	for <lists+linux-can@lfdr.de>; Thu, 11 Aug 2022 22:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiHKUSA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 11 Aug 2022 16:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiHKUSA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 11 Aug 2022 16:18:00 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC779DB4F
        for <linux-can@vger.kernel.org>; Thu, 11 Aug 2022 13:17:58 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-31f661b3f89so183636927b3.11
        for <linux-can@vger.kernel.org>; Thu, 11 Aug 2022 13:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidbol-es.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=y0K71jBH/F+qs+Ons3xDuyCCFavfgU6TIPskfCDU6GU=;
        b=uXJcr7HcJoymFBKcsYi4Lr75w4SkhunVI5R1TQdWW5g7hxd8ryfQB3UH1JSNDUFU+z
         D09nTC5LUgoQTLEJPKGCFQF0lKaPLVeDKd2MLQO6DJFJJO1Tpz3241ocLkgtnGFqNJOv
         u2ywWh4rhBNbaD4gwKFtCxYf5M6lR/MbEM4CSKZRLrSjgNzYhi3jLCH90rS58kTN1dGY
         W1cY2ddqIGJiSW2vN7IWIWBY1O7psK/h1RVqdaY87w77hIQTyvH5AVa8BCFKSX35Ce7J
         knEqcXFSpr5SX8qB7/+k4a4EVQV85nQfqMEaQ57Q0bl9fD8snRAhOUQKDXOKhi8ChXY9
         OjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=y0K71jBH/F+qs+Ons3xDuyCCFavfgU6TIPskfCDU6GU=;
        b=xbsYpkfN7GRIEnuZhL6A3NCeDWCo2m99I2w17PQLvuSVTrZLgJb8TPsGXykikCwL7N
         wllMtvUQ6Mr/KrzKTRfRRjvG/z6Hw3XvlNxfi3KTrSMm1LRLj3RIACLwneIKuPgqqkQR
         AiDaR3AV8Wm4981bPUSkrgrNGyZdckT48w2HGFW5aI2digTZ/sP+bAKrDwOeT/F+HQkg
         VLjaYyfpJpKHHpgZ4LLhY/3qTHJUOc2BfA/2FEiBjOR4Gkf3Jaj8/WAAV8yZixU4FWUF
         rsoxlfTU1+KqHlUsPtgR2n+gwxCAwQuCMLWCmWFojVhCl5tLUomPXiWALQtkatkIY9tI
         iFFg==
X-Gm-Message-State: ACgBeo0jxysQqEg2ihb9HJqH/BG4rAQkzmdIwNsw9GwQB0FgQkrpm73z
        /Is3rFyCu1rP6l71RHOgUpkrOVOtPuD2WbCMnwdE3Q==
X-Google-Smtp-Source: AA6agR6kBQSf103WLkJ8zoOP5Hd57iCYSdTVRgoN9kP7uyySbUSllPXUdR8Thi+PYgZrd3gUeiUOXNQYrMARf0F3NXU=
X-Received: by 2002:a81:13c5:0:b0:32a:8e40:d469 with SMTP id
 188-20020a8113c5000000b0032a8e40d469mr1042268ywt.64.1660249077994; Thu, 11
 Aug 2022 13:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAMgOUGpGEUQgLgAQmYbn-UdWXCkC7kRqdhW-mfg=e2gq9QfqRQ@mail.gmail.com>
 <20220810074530.or6oecnm7obmm7rh@pengutronix.de>
In-Reply-To: <20220810074530.or6oecnm7obmm7rh@pengutronix.de>
From:   David Boles <me@davidbol.es>
Date:   Thu, 11 Aug 2022 13:17:47 -0700
Message-ID: <CAMgOUGoKHJnA5KLBE5_txgEBnC6LU3zNKkok7QEiMcrwQc0TvA@mail.gmail.com>
Subject: Re: PCAN and SocketCAN Questions
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Tom Evans <thomasaevans@optusnet.com.au>,
        linux-can@vger.kernel.org, s.grosjean@peak-system.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thank you Marc and Tom for your suggestions! I have a few follow-ups:

# Question 1: Silently losing received frames if the socket isn't read
from frequently enough

> See candump's "-d" command line option.

Unfortunately it seems like this is happening at the layer of
individual sockets. Candump was already printing out messages that I
was "losing", and adding the -d flag doesn't affect its printout
(presumably since from its perspective, they haven't been dropped).

> Run your program at a lower NICE value

Good idea!

> Make the queue as big as you can.

Yep, that's what I'm currently doing. It's probably an acceptable
solution though not ideal; I'd like to be able to detect this
happening and fail noisily.

# Question 2: Behavior of one-shot and presume-ack

It sounds like one-shot doesn't retry in the event of other problems
(like losing arbitration) so that isn't what I want. It sounds like
presume-ack is what I wanted but is only supported by very few
devices, so I probably don't want to use it either.

# New: Question 4

I think the right course of action is to detect (either via
looped-back frames or maybe error frames, or something else) that my
transceiver is the only one on the bus and to stop sending messages
temporarily. I'd like to avoid sending excessively stale frames (e.g.
if a new transceiver joins the bus five minutes later, it shouldn't
receive a five minute old frame from me) and from my testing with
PCAN-USB dongles they seem to try resending a frame endlessly. I'd
also like to avoid missing receiving frames transmitted by any new
transceivers on the bus. Is there any universal/reliable API for
clearing all transmit buffers for an interface, down to the device
itself, without affecting its ability to receive frames?

Thanks again!

David

On Wed, Aug 10, 2022 at 12:45 AM Marc Kleine-Budde <mkl@pengutronix.de> wro=
te:
>
> On 09.08.2022 19:35:09, David Boles wrote:
> > Hello everyone, I'm new to both SocketCAN and mailing lists so please
> > let me know if I'm making any faux pas or haven't correctly RTFMed! I
> > heard this was the correct place to ask questions and I have a few
> > that I haven't been able to find answers to.
> >
> > All my testing so far has been done on Ubuntu 20.04 with
> > 5.15.0-43-generic and PCAN-USB( Pro) dongles and PCAN-PCI Express
> > cards.
> >
> > Question 1: I've noticed that frames can get silently lost if my
> > application doesn't read from the socket frequently enough. This also
> > happens if I'm simultaneously dumping frames with candump (the "lost"
> > frames do show up in candump's output). Increasing the socket receive
> > buffer size with SO_RCVBUF allows more frames to be stored before new
> > ones start getting lost. Is there a recommended way to detect this
> > happening so that my program can fail noisily?
>
> See candump's "-d" command line option.
>
> | -d     (monitor dropped CAN frames)
>
> > Question 2: I'd like to be able to send frames without other receivers
> > on the bus to acknowledge them. The one-shot option seems to allow me
> > to do this with my USB dongles. What's the difference between the
> > one-shot and presume-ack options?
>
> In one shot mode the controller only sends the frame once, there's no
> automatic retransmission in case of an error, i.e. missing ACK. This
> means in the error case the error counters are incremented as usual and
> if enabled and supported by the driver you receive a CAN error frame on
> the socket.
>
> Refer to the m_can user manual
> (https://github.com/hartkopp/M_CAN-User-Manual-History):
>
> | Disabled Automatic Retransmission
> |
> | According to the CAN Speci=EF=AC=81cation (see ISO 11898-1:2015, 8.3.4 =
Recovery
> | Management), the M_CAN provides means for automatic retransmission of
> | frames that have lost arbitration or that have been disturbed by errors
> | during transmission. By default automatic retransmission is enabled. To
> | support time-triggered communication as described in ISO 11898-1:2015,
> | chapter 9.2, the automatic retransmission may be disabled via CCCR.DAR.
>
> Presume ACK, tells the hardware to presume the CAN frame was ACKed, this
> results in no error and thus no retransmission.
>
> > Question 3: I'd like to have as little latency as possible and I'm
> > assuming using PCIe cards would be beneficial over USB.
>
> ACK
>
> > Unfortunately
> > my PCAN-PCI Express card doesn't seem to support either one-shot or
> > presume-ack; is that a hardware limitation or a driver limitation?
>
> Maybe Stephane (Cc'ed) can answer this.
>
> > If
> > it's a hardware limitation, would anyone be able to recommend a
> > low-latency, full-featured option for CAN on traditional x86/64
> > desktops?
>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
