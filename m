Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888D43722A5
	for <lists+linux-can@lfdr.de>; Mon,  3 May 2021 23:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhECVrX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Mon, 3 May 2021 17:47:23 -0400
Received: from mail-yb1-f176.google.com ([209.85.219.176]:43748 "EHLO
        mail-yb1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhECVrW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 3 May 2021 17:47:22 -0400
Received: by mail-yb1-f176.google.com with SMTP id 130so9508380ybd.10
        for <linux-can@vger.kernel.org>; Mon, 03 May 2021 14:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T50dMn4q+Tn48lDdiQX2mdFPMiAnyiRZfpH1zfN35m4=;
        b=jeEoL6ZnVfgl27TtJHVF2QYuCtpbH25JYFWi4SUC/8hZWkrg9N6ACvQ9JNo3uOg++n
         Nbjad4KiWLWJujoyPRzIguYIxrk0o8KAp06/dwE5N8vtIY3BVp/WdETZ8U2+lo6fQle0
         98VgTn3cXirZl4tdHcE/2dKIb2o7OrsJ2ubRaCzwo8G5xBNl2yC2VLsfI/7/bm/bvysa
         2BISaQndxRvIV7j4e/fOyMTAoj+gbVBdiOT0M0LpqLEv2+Ny+psubTef1EGUaFC1nzM7
         pC/hQI7Sga3etpVoNdeY6ZoQy74oURAqmba7KwQtCxLAKfcvB8p/1uVf7u9zU+sx3kux
         f/4Q==
X-Gm-Message-State: AOAM5312ns9yUZ3s95XgRMgJGET7aHMd2irSMQR03v7nnx4jGapYLHz6
        /TjoKAjT8qAwJ3tuauqYd50/2JikWOuH2kK9GJxTJG9IjcM=
X-Google-Smtp-Source: ABdhPJxPsMVru4FpllOoYvI0s94sTOruwdWQPRT3qH5tm3zHtIEEfOUlxyPQXGXxBxPZrkRgtXBWlWUU6h608qWNSy0=
X-Received: by 2002:a25:dac5:: with SMTP id n188mr81435ybf.145.1620078388930;
 Mon, 03 May 2021 14:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210503100246.n7uu437kbabdzu7m@pengutronix.de>
 <20210503100810.cacbmdfmpjipgoka@pengutronix.de> <CAMZ6RqLKp981zBus9K1RiLL14zC0B2BGp0U+xuQGvj1fjDMF1g@mail.gmail.com>
 <DBBPR03MB70828377F51A1747B4E9E6529D5B9@DBBPR03MB7082.eurprd03.prod.outlook.com>
 <20210503154749.q3nrfjveixsqp3uj@pengutronix.de> <DBBPR03MB7082F029173018680E5D869C9D5B9@DBBPR03MB7082.eurprd03.prod.outlook.com>
In-Reply-To: <DBBPR03MB7082F029173018680E5D869C9D5B9@DBBPR03MB7082.eurprd03.prod.outlook.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 4 May 2021 06:46:17 +0900
Message-ID: <CAMZ6RqJ0t91e-e9LwzaLWTY6G9MY7mosos9-DEs=pc0mWRf86Q@mail.gmail.com>
Subject: Re: More flags for logging
To:     Ayoub Kaanich <kayoub5@live.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue. 4 Mai 2021 at 01:26, Ayoub Kaanich <kayoub5@live.com> wrote:
>
> Hi,
>
> > As Vincent pointed out, the device should not receive the CAN frame that
> > has not been acked.
>
> We are not talking about traditional off-the-shelf devices.
> The use case here is for specialized hardware in CAN logging, that dumps whatever happens in the network to a log file.
> Example: https://technica-engineering.de/en/produkt/capture-module-can-combo/

I am not used to those devices. By "whatever happens in the
network" do you mean that any cancelled transmission due to an
error flag (including but not limited to ACK error flags) is
logged?  How do you plan to use the struct can{,fd}_frame to
record those incomplete transmissions? For example, how do you
plan to use Socket CAN API to log a frame cancelled due to a bit
error in the middle of the data segment (i.e. sent a recessive
bit but monitored dominant one)?


> > Sure - Do struct can_fd_frames have a different ARP header type?
>
> I assume you mean “Pcap Linklayer” or “DLT”, and the answer is no.
> can_fd_frames and can_frames share the same type, and they only keep enough bytes stored in the file to cover used data.
> Unused data bytes are not store in the file to save disk space.
> So there is no way in PCAP format, to tell them apart.

This is my point. Here you took the *decision* to save disk space
instead of blindly following the Socket CAN "philosophy" of using
the MTU to differentiate between classical and FD frames. But you
are treating the struct can{,fd}_frame as if it had a flexible
array for the dada field which is not the case. So you are having
this issue because you are using a modified version of the Socket
CAN API to begin with.
I am not saying this is a bad choice. I do like this approach :)

Back to the Socket CAN API itself, one reason I would also like
the kernel to use such an FDF flag is as follows: on other
ethernet protocols, the developper does not need to allocate a
message buffer of the size of the MTU. It is fine to only
allocate a buffer able to contain the size of frames expected by
the application. In Socket CAN, even if I have an application
which only sends and receives FD frames with a data length of 8,
I am still forced to use an additional 56 bytes because of this
MTU design. This is the same as your PCAP issue: the current
Socket CAN API does not allow you to save the bytes.

I do not think this has currently a big overhead. But I am still
curious to see the figures: does anyone know how much ressources
are lost by memcpying those padding bytes? However, with the
upcoming CAN XL (which will have an MTU of 2KiB), I think we will
eventually need to use an approach in which the MTU and the type
of the frames get decorelated (i.e. make the data array a
flexible size array).


> And even on the mcp251xfd, where I receive the CAN frame, there's no way
> to tell if this frame has been acked or not.

The mcp251xfd behavior is interesting. Do you also receive the
ACK error flag? Does the controller retry to send the frame until
it gets acknowledged? Are you still able to send frames and
receive the echo if there is a single node on the network?


Yours sincerely,
Vincent
