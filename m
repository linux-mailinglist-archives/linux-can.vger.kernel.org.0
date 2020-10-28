Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF7329D9ED
	for <lists+linux-can@lfdr.de>; Thu, 29 Oct 2020 00:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390003AbgJ1XGT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Oct 2020 19:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388243AbgJ1XF7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Oct 2020 19:05:59 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0369C0613CF
        for <linux-can@vger.kernel.org>; Wed, 28 Oct 2020 16:05:58 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id s21so1366247oij.0
        for <linux-can@vger.kernel.org>; Wed, 28 Oct 2020 16:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ix5q4KZ7Lu2GwVnJLNfmR3f07b90cZf7AR3+Q+EenI=;
        b=NJ5+YbKbxw7a2S3jqrH+iAEUaiqPEPzRPHz5j6j6pQcoMrhFRAKF0Jm0KdvWqnp9aq
         xZeyHwKGa1NfXIacD7cggjn5EyYZgSdlOM7GrIlTA7JlpoPzJRoSLgJjOsE2MRuS0uuh
         i2GZzQJayqXeJqtm8McyqsY0XhxnlJaNE5Jfj6ohhHEtyz29Wj6ygEhEtMxookUVraw1
         S8KT4+mKd35DtfiDRskCVVAeOWm7n9sbuSndWwbEHEOPE2mP2GFtYSHlRkMgx4cCgkmS
         y2qb5XRzHWY6GIWGjkFb8rtsCxm5LJCINef6il78bXEdOwnC+Uf6tBdNVJFgvIHCXVWZ
         MLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ix5q4KZ7Lu2GwVnJLNfmR3f07b90cZf7AR3+Q+EenI=;
        b=lKRSeAzrIQyaaqIwbFKOpzyubH/NB6mmx1/1nfvkql1jbqf4bvNWe1zLEji+dXDi7L
         +X635qhV4/8n/PD2I76ybRPQdwd2/3Kz98FyVNJfgWhKOOrtvC2gE7aP885P5Dsj8HGV
         7A+O6Glh5jXtZV4TVxdDZrF3X3qagO3M9Zf/+6Kipn5Ea3OG0LL/60er1Pc1RaclJrgA
         DGDqgmcj3na17z188XOlVQF11uVUDORxfv8LQJoe5HikSEniEzIawTT90kUCDhAtaOFF
         V/1sPewEgYJ6VUtxjQzD8Mz5TF7BuZVixnkCOGk4/FhmaEx/x5P2+L6Utnzbkrjm2NlG
         tIwg==
X-Gm-Message-State: AOAM531Xidtg+AaPBCiF/f1H6WaQ1vnww20xJsUnMwaq+HHwT1yosiep
        nnPfAcfTQhpdYdQZb0EDKZbIxrxywCUcARpgoPodQKHr/ygxeR1w
X-Google-Smtp-Source: ABdhPJxGqZWnb7y3SxMT48NLhBNUnHhlQsohMs5RUa/YNJ3hGQ+Dk/teCULpGzYyKxBu7ncg515qIHLc2QZWnHP3Kdk=
X-Received: by 2002:aca:b644:: with SMTP id g65mr3700652oif.164.1603856854820;
 Tue, 27 Oct 2020 20:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAPgEAj5eeN7Q9Hs7ZcrvaNCQJ7uW8kyNs3CPiVfQ=AEX9WeYoQ@mail.gmail.com>
 <CAPgEAj6nQOAQ9NNB2QBbARuqWm5K62QW+NsqPROzcQOZqe-F+g@mail.gmail.com>
 <975a3598-c229-0b9a-df95-c9647f138a3a@hartkopp.net> <20201025105808.2pltif74at3xwtjd@hardanger.blackshift.org>
 <68846197-98dc-b991-1ec8-a477ceb8d614@posteo.de> <715b3c3b-dbbc-688c-9757-578455c3a607@pengutronix.de>
 <0667516a-525e-9c4e-ec7a-e4d8a188c338@posteo.de> <CAPgEAj72jBPDGWnxOM73JLB=0Soo7uYh0FukNhpZQvDvqPewjg@mail.gmail.com>
 <CAPgEAj4DceAkPySUekDZPAKwNToxNjz6Yr66_3mqkE-0iiKAYA@mail.gmail.com>
 <92dd7044-8f0d-154b-eb04-8cec1b572dd2@pengutronix.de> <fa70fffa-7702-7cd0-dcfb-15bd18c3bb15@posteo.de>
 <2a1ddec7-ca28-ae44-dc06-f80f0017bf1f@pengutronix.de> <CAPgEAj6z_DaycgVOqvqqTv2KVRcascT8_nd+FNnZJtg0ObGPaw@mail.gmail.com>
 <CAPgEAj6nu475YeeWXc3wWO8sAmn8stz2Qr3nQ=HABd8CKR-c+w@mail.gmail.com>
 <41b606d5-5991-4d4f-bd6f-aaaf31cbc9b5@pengutronix.de> <6a7061a4-771d-6703-1e30-273050abfb9d@posteo.de>
 <2593d8e0-2d42-0461-e2e1-86a71b415476@pengutronix.de> <CAPgEAj5JheUirqr2kLrjJpwCaK3+HZyo8r8uKk25zMREVXWT3Q@mail.gmail.com>
In-Reply-To: <CAPgEAj5JheUirqr2kLrjJpwCaK3+HZyo8r8uKk25zMREVXWT3Q@mail.gmail.com>
From:   Drew Fustini <drew@beagleboard.org>
Date:   Tue, 27 Oct 2020 22:47:40 -0500
Message-ID: <CAPgEAj4W61tCSkdrCP2J4dL7WwQ1NKzFCUGjY9o4_qj+NG5KEA@mail.gmail.com>
Subject: Re: mcp251xfd on RPi 5.4 downstream
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Patrick Menschel <menschel.p@posteo.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, Josh S <josh@macchina.cc>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Oct 27, 2020 at 8:57 PM Drew Fustini <drew@beagleboard.org> wrote:
>
> On Tue, Oct 27, 2020 at 1:23 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> >
> > On 10/27/20 7:18 PM, Patrick Menschel wrote:
> > >
> > >>> It is different but I'm having trouble understanding why it works and
> > >>> the new overlay for the newer driver does not.
> > >>
> > >> Have you actually tested the waveshare driver and overlay with your setup?
> > >>
> > >> If you have a scope or logic analyser attach it to SPI bus (MISO, MOSI, Clock,
> > >> Chipselect and the IRQ Line of the Chip) and check what's going on there.
> > >>
> > >> Marc
> > >>
> > >
> > > Is the target path for clocks correct?
> > >
> > > I mean "/clocks"
> >
> > It doesn't matter where you put them...
> >
> > > https://gist.github.com/pdp7/784d0ba8b9648d20ab055747ec945225#file-2xmcp2517fd-overlay-dts-L49
> > >
> > > instead of "/"
> > >
> > > https://github.com/marckleinebudde/linux/blob/v5.4-rpi/mcp251xfd-20201022-54/arch/arm/boot/dts/overlays/mcp251xfd-spi0-0-overlay.dts#L38
> >
> > The mcp251xfd node references them via the label ("<&can_osc>"):
> >
> > https://github.com/marckleinebudde/linux/blob/v5.4-rpi/mcp251xfd-20201022-54/arch/arm/boot/dts/overlays/mcp251xfd-spi0-0-overlay.dts#L61
> >
> > The driver will bail out even earlier if no clock is found:
> >
> > https://github.com/marckleinebudde/linux/blob/v5.4-rpi/mcp251xfd-20201022-54/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c#L2764
> >
> > regards
> > Marc
> >
> > --
> > Pengutronix e.K.                 | Marc Kleine-Budde           |
> > Embedded Linux                   | https://www.pengutronix.de  |
> > Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> > Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
> >
>
> Thank you for the suggestions.  I've not been as multi-tasking as I
> hoped during ELC-E :)
>
> I assumed the Waveshare instructions work but that is error on my part
> for not actually reproducing.  That is what I will do first.
> Ultimately, I want the freshly upstreamed driver working but I should
> check if their driver tarball works.
>
> thanks,
> drew

The Waveshare installer uses the 4.19 kernel with the mcp25xxfd
driver.  However, it also fails, sio I think I need to dig deeper:

pi@raspberrypi:~ $ dmesg | grep -Ei spi\|can
[    4.263765] CAN device driver interface
[    4.286258] mcp25xxfd_can: loading out-of-tree module taints kernel.
[    5.477511] mcp25xxfd spi1.0: Cannot initialize MCP2517. Wrong
wiring? (oscilator register reads as 00000000)
[    5.477530] mcp25xxfd spi1.0: Probe failed, err=19
[    5.490325] mcp25xxfd spi0.0: Cannot initialize MCP2517. Wrong
wiring? (oscilator register reads as 00000000)
[    5.490352] mcp25xxfd spi0.0: Probe failed, err=19
[    5.490459] spi-bcm2835 fe204000.spi: chipselect 0 already in use
[    5.490479] spi_master spi0: spi_device register error
/soc/spi@7e204000/mcp251xfd@0
[    5.490497] spi_master spi0: Failed to create SPI device for
/soc/spi@7e204000/mcp251xfd@0

pi@raspberrypi:~ $ uname -a
Linux raspberrypi 4.19.75-v7l+ #1270 SMP Tue Sep 24 18:51:41 BST 2019
armv7l GNU/Linux
pi@raspberrypi:~ $ modinfo
/lib/modules/4.19.75-v7l+/kernel/drivers/net/can/spi/mcp25xxfd-can.ko
filename:
/lib/modules/4.19.75-v7l+/kernel/drivers/net/can/spi/mcp25xxfd-can.ko
license:        GPL v2
description:    Microchip 25XXFD CAN driver
author:         Martin Sperl <kernel@martin.sperl.org>
srcversion:     EE1DD0B30B5F99540B43858
alias:          of:N*T*Cmicrochip,mcp2517fdC*
alias:          of:N*T*Cmicrochip,mcp2517fd
alias:          spi:mcp2517fd
depends:        can-dev
name:           mcp25xxfd_can
vermagic:       4.19.75-v7l+ SMP mod_unload modversions ARMv7 p2v8
parm:           rx_prefetch_bytes:number of bytes to blindly prefetch
when reading a rx-fifo (uint)
parm:           reschedule_int_thread_after:Reschedule the interrupt
thread after this many loops
 (uint)
parm:           tx_fifos:Number of tx-fifos to configure
 (uint)
parm:           three_shot:Use 3 shots when one-shot is requested (bool)
parm:           bw_sharing_log2bits:Delay between 2 transmissions in
number of arbitration bit times
 (uint)
parm:           enable_edge_filter:Enable ISO11898-1:2015 edge_filtering (bool)
parm:           tdc_mode:Transmitter Delay Mode - 0 = disabled, 1 =
fixed, 2 = auto
 (uint)
parm:           tdc_value:Transmission Delay Value - range: [0:63] SCLK (uint)
parm:           tdc_offset:Transmission Delay offset - range: [-64:63]
SCLK (int)


thanks,
drew
