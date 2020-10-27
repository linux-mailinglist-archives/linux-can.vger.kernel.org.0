Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3D229A2A9
	for <lists+linux-can@lfdr.de>; Tue, 27 Oct 2020 03:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408717AbgJ0CWr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Oct 2020 22:22:47 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37536 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408685AbgJ0CWr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Oct 2020 22:22:47 -0400
Received: by mail-oi1-f193.google.com with SMTP id f7so12645993oib.4
        for <linux-can@vger.kernel.org>; Mon, 26 Oct 2020 19:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YZyAq4gaUjT6UAEtGp2iGxOUInxwXBbqfdCw5i9vlQQ=;
        b=zaILUpCJ3SyYex0a9sDm7a1bO3pTd6n1QvoO3lwExhfSB5ubXHOT8b0wbFsW0Gg/96
         t1WfDtYpEMnr/LONd62luc424sbmbc8hHdlTPTcMocL8qflb3eFnOKcp09HuNMLo6m02
         2ZoDjcpoOvDt/RMtP1hzZWECjEp98OmsyzXtV+Ac6eoLXiF9eF0Ma8io1luICxxxKzm5
         yGEb1+tDIdfDHw9vSD9hW5EAlBLiYY1Sy5qtMrnxJ/xqPFooGYJWu0P+IlaXq65urdRw
         8q54zKSKlj/92jQ+rWZOj+WjSZb/zkK1hmpyDEPAH1VUthBWpK329rWOUSCEZsXt26OX
         kYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZyAq4gaUjT6UAEtGp2iGxOUInxwXBbqfdCw5i9vlQQ=;
        b=QDtbsxB4uwSgfAF1XsVUfQPNC5xnmlKBn4oQ01nQkRQjfbswLGvPCKXhulc2rKtAhg
         P3msBfxiwJn13tLUGEpliyfXk9/EBE+yr/SjfRD7h+Dw1rxJfWQsQC0wcKjiu4lhHvZ9
         7c1JMSWUxCQDSRwm+58AE09vMg3l9biGdzhZ+blbI47I1fveeP22f/MKX/GHAKYXhmE2
         shRW1I24dUJ7CnebKc3U6Vqjb+bf/T/v3oGPSXEbhZe5MFK0bSMP+o23JywiaDEuuA8C
         jKcTqbLoKtlyrM/dhlY+UbDnd0fl1Q/aS9lM59tFeW96wmcXFpW7wTS2hRkzniG/kghZ
         0+Sw==
X-Gm-Message-State: AOAM531VFy9jTukK3/9F8ilK7tN3icvnBSpPhqZ41Uu371nq5qafRXJq
        OX8rHLVUYk/bVrWlCFZmPsIyku/hYOEGned7A1c5uA==
X-Google-Smtp-Source: ABdhPJyLOkIjqLsJMMA6FJElWPZbe9+vouWG0C2hUJYCE/Ro+NWQa+9SS1kiG3URNPL9LQFdQj2hDjwPdpglBFTmmeg=
X-Received: by 2002:aca:b644:: with SMTP id g65mr145396oif.164.1603765364579;
 Mon, 26 Oct 2020 19:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAPgEAj5eeN7Q9Hs7ZcrvaNCQJ7uW8kyNs3CPiVfQ=AEX9WeYoQ@mail.gmail.com>
 <CAPgEAj5HwFUTqhbgZ2Y5Db-_PPHNN7Rc8dnp1s+TBBALf5EwSw@mail.gmail.com>
 <3ede1c31-9436-a8ec-b7cd-65cee5fa23fc@pengutronix.de> <CAPgEAj7JLUjWiN8LdGV9OfQScsUkPVcs9bSE+w_9G0c9BNd-sg@mail.gmail.com>
 <CAPgEAj6nQOAQ9NNB2QBbARuqWm5K62QW+NsqPROzcQOZqe-F+g@mail.gmail.com>
 <975a3598-c229-0b9a-df95-c9647f138a3a@hartkopp.net> <20201025105808.2pltif74at3xwtjd@hardanger.blackshift.org>
 <68846197-98dc-b991-1ec8-a477ceb8d614@posteo.de> <715b3c3b-dbbc-688c-9757-578455c3a607@pengutronix.de>
 <0667516a-525e-9c4e-ec7a-e4d8a188c338@posteo.de> <CAPgEAj72jBPDGWnxOM73JLB=0Soo7uYh0FukNhpZQvDvqPewjg@mail.gmail.com>
 <CAPgEAj4DceAkPySUekDZPAKwNToxNjz6Yr66_3mqkE-0iiKAYA@mail.gmail.com>
 <92dd7044-8f0d-154b-eb04-8cec1b572dd2@pengutronix.de> <fa70fffa-7702-7cd0-dcfb-15bd18c3bb15@posteo.de>
 <2a1ddec7-ca28-ae44-dc06-f80f0017bf1f@pengutronix.de>
In-Reply-To: <2a1ddec7-ca28-ae44-dc06-f80f0017bf1f@pengutronix.de>
From:   Drew Fustini <drew@beagleboard.org>
Date:   Mon, 26 Oct 2020 21:22:50 -0500
Message-ID: <CAPgEAj6z_DaycgVOqvqqTv2KVRcascT8_nd+FNnZJtg0ObGPaw@mail.gmail.com>
Subject: Re: mcp251xfd on RPi 5.4 downstream
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Patrick Menschel <menschel.p@posteo.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, Josh S <josh@macchina.cc>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thank you the feedback.

I think it may be any issue with spi interface and/or chip select config.

[    6.812079] DEBUG mcp251xfd mcp251xfd_probe(): ENTER
[    6.812174] mcp251xfd spi0.0: DEBUG mcp251xfd mcp251xfd_probe():
devm_clk_get()
[    6.812208] mcp251xfd spi0.0: DEBUG mcp251xfd mcp251xfd_probe():
feq=0x2625a00
[    6.850106] mcp251xfd spi0.0 (unnamed net_device) (uninitialized):
Failed to detect MCP251xFD (osc=0x00000000).

This proves that the driver is getting the 40 MHz from the device tree
properties.  The board does have a 40 MHz osc.

It is the Waveshare CANFD Hat [1].  They have their own tarball for
download [2] with a mcp25xxfd driver that is copyright 2019 by Martin
Sperl <kernel@martin.sperl.org>.  I'm looking at that to see why it
works and the newer, proper driver does not.

Thanks,
Drew

[1] https://www.waveshare.com/wiki/2-CH_CAN_FD_HAT
[2] https://www.waveshare.com/wiki/File:2-CH-CAN-FD-HAT-Demo.7z


On Mon, Oct 26, 2020 at 12:00 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 10/26/20 5:51 PM, Patrick Menschel wrote:
> >> On 10/26/20 3:50 AM, Drew Fustini wrote:
> >>> I'm seeing this message which makes me think my issue is that I am not
> >>> setting the oscillator as a dtoverlay param.
> >>>
> >>> [    6.873081] CAN device driver interface
> >>> [    6.879904] DEBUG mcp251xfd mcp251xfd_probe(): ENTER
> >>> [    6.880068] spi_master spi0: will run message pump with realtime priority
> >>> [    6.921312] mcp251xfd spi0.0 (unnamed net_device) (uninitialized):
> >>> Failed to detect MCP251xFD (osc=0x00000000).
>                                     ^^^^^^^^^^
>
> Contents of OSC register.
>
> >>> [pi4]
> >>> dtoverlay=mcp251xfd-spi0-0
> >>
> >> Are you using CS0 of spi0?
> >> What's the frequency of your OSC?
> >
> > mcp251xfd_osc_invalid(osc) is true according to the string.
> >
> > https://github.com/marckleinebudde/linux/blob/v5.4-rpi/mcp251xfd-20201022-54/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c#L552
>
> ACK
>
> The OSC register would never contain 0x0. So when reading 0x0 (or 0xff) you have
> not read anything. This is what the "invalid" test does.
>
> This could have several reasons, e.g. mcp2518fd is not on SPI0 CS0, or the OSC
> is 20 MHz, but the DT specifies an OSC of 40 MHz.
>
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
>
