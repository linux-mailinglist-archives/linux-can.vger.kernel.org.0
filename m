Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD4B2A1AE4
	for <lists+linux-can@lfdr.de>; Sat, 31 Oct 2020 22:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgJaV5P (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 31 Oct 2020 17:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgJaV5P (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 31 Oct 2020 17:57:15 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E8EC0617A6
        for <linux-can@vger.kernel.org>; Sat, 31 Oct 2020 14:57:14 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id p73so2451620oop.7
        for <linux-can@vger.kernel.org>; Sat, 31 Oct 2020 14:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j2S+VzW8HpML0+dzbnPp4Z7MYvuzXLzw6SsWRN2dbyE=;
        b=JmjW/bXTeLWpCCTQv0i789XUC9xSmokYrH7yuBBkO+Ojd7CLbmRRwO7WzlS0H9De5r
         jHyloLHqfb9//1p58YkcYszm5Y/UJjE1wV/KLvDeB1HvNmf3JKcfHoRgGJHYp9f3ekuq
         1QuIN+oMxIwDEt0DV+xgT1VhKkK/CdPfZqrivgMgBW4jTk/6P2qpkHWznzGjZuRO00Cj
         ih1BAjknBPIK3VHMlSVOChPzwHyJv0YMMJIgwih7pSAI+hgU/P9fXU92bB5FbxuAUadZ
         6Tzt5mrsM2PbFmbi29KNClCupDztAhhsS+guLY30yvY8MCnyZfG6EiMRRS7xF2QOeYRu
         kUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j2S+VzW8HpML0+dzbnPp4Z7MYvuzXLzw6SsWRN2dbyE=;
        b=DVGF6fmpKASOEfvDKHB1Ved47ZnDIsKR3hpzysfRU4Mq2hl+Q/jANTAHxY13VUTHMX
         7NTJe+TruEiVBuDXxR3tkY0N/hzWlbQWkjItaSjxeNCGTpIP1O+i0MKFc/xP7FMmlnl0
         2MRQd2lgMgBbeqrxUBJBf+CM5baMi9lXsAoiD/o7hZWM7ZnrVKGwt190s5AmiEUYoWKC
         nKneOXFfLm36eT6pF+DnXZELvpv57K8quD4MNganZ/AGSf5jsGpIDS1boRLzxnsQ+FPJ
         3rAgkf9cVEWUtUgQHJG3dO0DApLo1YEGb3ZacUriqlqZGWAxFhnKt9gsWZsbcs4hwRL8
         PgYw==
X-Gm-Message-State: AOAM530dTOo3Hs5UpdCVs/K93yCMF8vop3aC5nayefVFTtjwrGeFL74U
        SSj2AhhQMrYDDt0myAc2qzupWyYmwm4kYNAwPG8rAwgtorJxZtZE
X-Google-Smtp-Source: ABdhPJzfwuIwaM8nV3xKhJTJv4X4YU97A9fRWPK+kR8emV0pg6lCGdx+kMZywSyAnFkModCKGt4MU3sGBaalaUwe4Rk=
X-Received: by 2002:a4a:bc92:: with SMTP id m18mr6797975oop.39.1604181433994;
 Sat, 31 Oct 2020 14:57:13 -0700 (PDT)
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
In-Reply-To: <3a5f81d6-13ba-71b8-67a7-fe6e8a13f84a@posteo.de>
From:   Drew Fustini <drew@beagleboard.org>
Date:   Sat, 31 Oct 2020 22:57:23 +0100
Message-ID: <CAPgEAj7B5O5nwqr-nMBXNqgx9tD5=9XPG0W0=C21FMD6S+bR-A@mail.gmail.com>
Subject: Re: mcp251xfd on RPi 5.4 downstream
To:     Patrick Menschel <menschel.p@posteo.de>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, Josh S <josh@macchina.cc>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sat, Oct 31, 2020 at 4:35 PM Patrick Menschel <menschel.p@posteo.de> wrote:
>
> > I believe Waveshare did choose other interrupt pins.
> > Marc used 24 25 which I also chose for a pHat I'm currently making
> > schematics for.
> >
> > Try these lines in /boot/config.txt
> >
> > dtoverlay=mcp251xfd-spi0-0,interrupt=25
> > dtoverlay=mcp251xfd-spi1-0,interrupt=16
> >
> > The waveshare overlay is strange in one point. It uses Pin 26 (instead
> > of 18) for Chip selection but that is no chip select pin. This can work
> > if the pin is output and luckily pulls the CE line in the right direction.
> >
> > https://gist.github.com/pdp7/784d0ba8b9648d20ab055747ec945225#file-2xmcp2517fd-overlay-dts-L40
> >
> > https://pinout.xyz/pinout/pin37_gpio26#
> >
> > Maybe this has something to do with Nvidia Jetson Platform.
> >
> > --
> > Patrick
> >
>
> Apparently Pin 26 is CE1 for SPI5, only available on Pi 4.
>
> https://github.com/raspberrypi/firmware/blob/master/boot/overlays/README#L2674
>
> --
> Patrick

Thank you!  That appears to have solved the problem:

#dtoverlay=2xMCP2517FD
pi@raspberrypi:~$ dmesg | grep -Ei can\|spi
[    5.916785] DEBUG spi.c spi_setup(): ENTER
[    5.917056] DEBUG spi.c spi_setup(): ENTER
[    5.960326] DEBUG spi.c spi_setup(): ENTER
[    6.897919] CAN device driver interface
[    6.904530] mcp251xfd spi0.0: DEBUG mcp251xfd mcp251xfd_probe():
devm_clk_get()
[    6.904574] mcp251xfd spi0.0: DEBUG mcp251xfd mcp251xfd_probe(): feq=40000000
[    6.904641] DEBUG spi.c spi_setup(): ENTER
[    6.904658] spi_master spi0: will run message pump with realtime priority
[    6.912009] mcp251xfd spi0.0 can0: MCP2517FD rev0.0 (-RX_INT
+MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz
r:17.00MHz e:0.00MHz) successfully initialized.
[    6.912613] mcp251xfd spi1.0: DEBUG mcp251xfd mcp251xfd_probe():
devm_clk_get()
[    6.912646] mcp251xfd spi1.0: DEBUG mcp251xfd mcp251xfd_probe(): feq=40000000
[    6.912701] DEBUG spi.c spi_setup(): ENTER
[    6.912719] spi_master spi1: will run message pump with realtime priority
[    6.920067] mcp251xfd spi1.0 can1: MCP2517FD rev0.0 (-RX_INT
+MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz
r:17.00MHz e:0.00MHz) successfully initialized.


Thanks,
Drew
