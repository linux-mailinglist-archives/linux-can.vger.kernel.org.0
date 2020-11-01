Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B942A2237
	for <lists+linux-can@lfdr.de>; Sun,  1 Nov 2020 23:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgKAWtI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 1 Nov 2020 17:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbgKAWtI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 1 Nov 2020 17:49:08 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F402C0617A6
        for <linux-can@vger.kernel.org>; Sun,  1 Nov 2020 14:49:08 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id l62so7215620oig.1
        for <linux-can@vger.kernel.org>; Sun, 01 Nov 2020 14:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4u6HzsFNpjTzqBucYIHm+RhAqXl+q4R/unfW2BOX6N0=;
        b=efBaxIv0Fn4f0/JF3Ep0WJX6fH0ScuJUIG9GXMdemtvfhLzlV7Xo9X9l8YgDAWRL5R
         uavSdxUv4Lkcx/V4UyZ3OONWOy7iDs83hJXxzA3G/09l2noQSOXCyfrQpzQk4mxstHYN
         +N7U8Jw7DJWLhVqgrcKtid9Eclm667AeZB7oBl8BDsLgi+SHIFhzqj7mov/yXcZ2ko1f
         sbS+1XoeeMQxNRqphaKaVZr63iCzCT0xr2UzyuQsuJKcBw25waHrb8Jhfx1tgl8g3kBD
         cXhEvxTyExUi1GBI8Jicm8LhtddQgJWHlKL2UENt5Cftozf9RwC6MZOMKbSafPTrbSvl
         naVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4u6HzsFNpjTzqBucYIHm+RhAqXl+q4R/unfW2BOX6N0=;
        b=Y31vF0D4DwpbqwfutQpA01eWbU5ekLKRedhH/Jv8GKOOuh5KpQK1JiH6CO7yUuFzZU
         jbGUq1XMJXeEugVniyo6Y+zxtcS5M0WVxFIkNEjEHF0NaZ0B00IeDKdkrXcHIXtAdxPZ
         ocoPdXk27XAq34DutdYav0blg1SGplHH8T47r9aIEPyYZM9ESQqAG6vsImYR8400oiuz
         97jKzml31y9YP74A6axv86+ZSnNv99HJHSBfdFhvt469b6mkQsGC2pfOUO7LDIisRiVj
         2fiIzDDGunsk44JCcSAMjS5G3+vqgYLAAH97zohm3h+5JvfiOfMSl6z9OJfn7R4gaCt4
         Psjw==
X-Gm-Message-State: AOAM533CSDNfAI6yJDxOnW7Itxai9O+NTyyxTuqrJNjyNGzjQXsfsCXE
        jfOdEfqQ5OMpvUqxAq33NoXfi7BHmJTdG0H8FxwhE+Pp9W0vgf7h
X-Google-Smtp-Source: ABdhPJxdnMV7aKcnahiPgRFUKhqqZYOyyWAHjAPHenhr9TTZvfJ6KXlwvbz0uMRTV/caJTHVy43r4C5nGycZuGCz8tg=
X-Received: by 2002:aca:b644:: with SMTP id g65mr8147306oif.164.1604270947490;
 Sun, 01 Nov 2020 14:49:07 -0800 (PST)
MIME-Version: 1.0
References: <CAPgEAj5eeN7Q9Hs7ZcrvaNCQJ7uW8kyNs3CPiVfQ=AEX9WeYoQ@mail.gmail.com>
 <CAPgEAj72jBPDGWnxOM73JLB=0Soo7uYh0FukNhpZQvDvqPewjg@mail.gmail.com>
 <CAPgEAj4DceAkPySUekDZPAKwNToxNjz6Yr66_3mqkE-0iiKAYA@mail.gmail.com>
 <92dd7044-8f0d-154b-eb04-8cec1b572dd2@pengutronix.de> <fa70fffa-7702-7cd0-dcfb-15bd18c3bb15@posteo.de>
 <2a1ddec7-ca28-ae44-dc06-f80f0017bf1f@pengutronix.de> <CAPgEAj6z_DaycgVOqvqqTv2KVRcascT8_nd+FNnZJtg0ObGPaw@mail.gmail.com>
 <CAPgEAj6nu475YeeWXc3wWO8sAmn8stz2Qr3nQ=HABd8CKR-c+w@mail.gmail.com>
 <41b606d5-5991-4d4f-bd6f-aaaf31cbc9b5@pengutronix.de> <6a7061a4-771d-6703-1e30-273050abfb9d@posteo.de>
 <2593d8e0-2d42-0461-e2e1-86a71b415476@pengutronix.de> <CAPgEAj5JheUirqr2kLrjJpwCaK3+HZyo8r8uKk25zMREVXWT3Q@mail.gmail.com>
 <CAPgEAj4W61tCSkdrCP2J4dL7WwQ1NKzFCUGjY9o4_qj+NG5KEA@mail.gmail.com>
 <3d19330b-860b-7d76-bc6d-768a7b00ed4b@pengutronix.de> <CAPgEAj6qZxfsyuarVgvnXkHd3ZUAP-3fgD-nONCcn-C5xY44+Q@mail.gmail.com>
 <e955f39f-2417-4dca-ee3c-70b328c1014d@posteo.de> <3a5f81d6-13ba-71b8-67a7-fe6e8a13f84a@posteo.de>
 <CAPgEAj7B5O5nwqr-nMBXNqgx9tD5=9XPG0W0=C21FMD6S+bR-A@mail.gmail.com>
In-Reply-To: <CAPgEAj7B5O5nwqr-nMBXNqgx9tD5=9XPG0W0=C21FMD6S+bR-A@mail.gmail.com>
From:   Drew Fustini <drew@beagleboard.org>
Date:   Sun, 1 Nov 2020 23:49:16 +0100
Message-ID: <CAPgEAj7LT48tVa47p-5+5=sb+J=Ff61pdhcOa=70ppPvCMeDzw@mail.gmail.com>
Subject: Re: mcp251xfd on RPi 5.4 downstream
To:     Patrick Menschel <menschel.p@posteo.de>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, Josh S <josh@macchina.cc>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sat, Oct 31, 2020 at 10:57 PM Drew Fustini <drew@beagleboard.org> wrote:
>
> On Sat, Oct 31, 2020 at 4:35 PM Patrick Menschel <menschel.p@posteo.de> wrote:
> >
> > > I believe Waveshare did choose other interrupt pins.
> > > Marc used 24 25 which I also chose for a pHat I'm currently making
> > > schematics for.
> > >
> > > Try these lines in /boot/config.txt
> > >
> > > dtoverlay=mcp251xfd-spi0-0,interrupt=25
> > > dtoverlay=mcp251xfd-spi1-0,interrupt=16
> > >
> > > The waveshare overlay is strange in one point. It uses Pin 26 (instead
> > > of 18) for Chip selection but that is no chip select pin. This can work
> > > if the pin is output and luckily pulls the CE line in the right direction.
> > >
> > > https://gist.github.com/pdp7/784d0ba8b9648d20ab055747ec945225#file-2xmcp2517fd-overlay-dts-L40
> > >
> > > https://pinout.xyz/pinout/pin37_gpio26#
> > >
> > > Maybe this has something to do with Nvidia Jetson Platform.
> > >
> > > --
> > > Patrick
> > >
> >
> > Apparently Pin 26 is CE1 for SPI5, only available on Pi 4.
> >
> > https://github.com/raspberrypi/firmware/blob/master/boot/overlays/README#L2674
> >
> > --
> > Patrick
>
> Thank you!  That appears to have solved the problem:
>
> #dtoverlay=2xMCP2517FD
> pi@raspberrypi:~$ dmesg | grep -Ei can\|spi
> [    5.916785] DEBUG spi.c spi_setup(): ENTER
> [    5.917056] DEBUG spi.c spi_setup(): ENTER
> [    5.960326] DEBUG spi.c spi_setup(): ENTER
> [    6.897919] CAN device driver interface
> [    6.904530] mcp251xfd spi0.0: DEBUG mcp251xfd mcp251xfd_probe():
> devm_clk_get()
> [    6.904574] mcp251xfd spi0.0: DEBUG mcp251xfd mcp251xfd_probe(): feq=40000000
> [    6.904641] DEBUG spi.c spi_setup(): ENTER
> [    6.904658] spi_master spi0: will run message pump with realtime priority
> [    6.912009] mcp251xfd spi0.0 can0: MCP2517FD rev0.0 (-RX_INT
> +MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz
> r:17.00MHz e:0.00MHz) successfully initialized.
> [    6.912613] mcp251xfd spi1.0: DEBUG mcp251xfd mcp251xfd_probe():
> devm_clk_get()
> [    6.912646] mcp251xfd spi1.0: DEBUG mcp251xfd mcp251xfd_probe(): feq=40000000
> [    6.912701] DEBUG spi.c spi_setup(): ENTER
> [    6.912719] spi_master spi1: will run message pump with realtime priority
> [    6.920067] mcp251xfd spi1.0 can1: MCP2517FD rev0.0 (-RX_INT
> +MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz
> r:17.00MHz e:0.00MHz) successfully initialized.

The Waveshare CANFD hat has interrupt pin of CAN1, the second
MCP2517FD, wired up to pin 36 on the Pi connector.

I changed this in mcp251xfd-spi1-0-overlay.dts:
-                               interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
+                               interrupts = <16 IRQ_TYPE_LEVEL_LOW>;

And can1 is now working too:

pi@raspberrypi:~$ dmesg | grep -Ei can\|spi
[   14.663345] CAN device driver interface
[   14.669552] spi_master spi0: will run message pump with realtime priority
[   14.677102] mcp251xfd spi0.0 can0: MCP2517FD rev0.0 (-RX_INT
+MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz
r:17.00MHz e:0.00MHz) successfully initialized.
[   14.677833] spi_master spi1: will run message pump with realtime priority
[   14.682667] mcp251xfd spi1.0 can1: MCP2517FD rev0.0 (-RX_INT
+MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz
r:17.00MHz e:0.00MHz) successfully initialized.
[   75.254659] IPv6: ADDRCONF(NETDEV_CHANGE): can0: link becomes ready
[   77.942514] IPv6: ADDRCONF(NETDEV_CHANGE): can1: link becomes ready

thanks,
drew
