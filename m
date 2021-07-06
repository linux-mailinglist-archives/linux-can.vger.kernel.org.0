Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30223BDD62
	for <lists+linux-can@lfdr.de>; Tue,  6 Jul 2021 20:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhGFSnR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Jul 2021 14:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbhGFSnR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Jul 2021 14:43:17 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC5DC061574
        for <linux-can@vger.kernel.org>; Tue,  6 Jul 2021 11:40:37 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id b18so9655136qkc.5
        for <linux-can@vger.kernel.org>; Tue, 06 Jul 2021 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=R3kUMwYP8BmJcVRKqRjLHvg/ZeKigOnEq8HJ3zYwaxo=;
        b=LXkTkF8cz9WsHA0lxWN1pXbZ3SKpYvEf4+DvjSN6jxvnXHZA6pUatZRcUxj6Nxv97o
         g/wNQRDDjXLKY0KBJYR6Byfl2Cx1s2OJFPvj5YohL1vJMORt7X2J0LBkyIXOiJGD7VFo
         O8wYHOXkiiAGogoe8VW8Z8LRhAXwoxCmtygrn15rJO+XYxxEuXYQOLKZPhMv6dJBkAkk
         ZGAeZ4xaiVtzp216gjvEyRrAQhurl6PhYATPVK7xpy5PbTsy0Me56NadDUyybnq9iSmJ
         T5k71LiiWFTJl4faRt1sTIoYiuXhjAK+yNaYZ+YUuFxX8ZO4gtto24gTxq/7mG4ycXZ8
         j+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=R3kUMwYP8BmJcVRKqRjLHvg/ZeKigOnEq8HJ3zYwaxo=;
        b=YTrgBZaPppziR9c15yWHpJDHTmAgl79kGnVtBl/2aOyJJgAnWExH5Yfn5V5DPus0qO
         LZe1JBiiYp7SD9uFYQz4dUhp5f05AT8r0BygEkIjVEADklUOs0W4+RUtamgzUhxffaT+
         tjGkeYvlEynD5nBpoRcFO7u453xPsAfvozqfEpbNdyThK0s241Pc62JYr1dbPmalNumv
         lEz52ehznKrduzVmZTVJV3CDddKjpFRAic/Iobr0sjeW0VguF4rhCwmCn6jruvfBHsNa
         Zlq/VjtsJ+pcHHy9o8YtenXj+lmiLdkHsSFe+7vLidXjLR0IgC3r71dmihYhr7yBzypL
         4sHA==
X-Gm-Message-State: AOAM533+jri7Vrz/SAOCTXOUHXtRWZEc56vNZE6DknHVZ9MdHEyhaIwn
        AKHZlWaGmSeq5no4/3DZA0Y=
X-Google-Smtp-Source: ABdhPJy+9GiaFDG0AQ/Oskl4Ps8mOK/pcZivzRRzAPqzrPuN2dR+pLjvsNc9W05DNf5Wo8oJ4adVQQ==
X-Received: by 2002:ae9:e519:: with SMTP id w25mr18575052qkf.391.1625596836776;
        Tue, 06 Jul 2021 11:40:36 -0700 (PDT)
Received: from DTJQUESENBERRY ([2001:468:c80:a202:b578:7d7:5843:274e])
        by smtp.gmail.com with ESMTPSA id p3sm5824034qti.31.2021.07.06.11.40.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jul 2021 11:40:36 -0700 (PDT)
From:   "Joshua Quesenberry" <engnfrc@gmail.com>
To:     "'Marc Kleine-Budde'" <mkl@pengutronix.de>
Cc:     "'Patrick Menschel'" <menschel.p@posteo.de>,
        <kernel@pengutronix.de>, <linux-can@vger.kernel.org>,
        <engnfrc@gmail.com>
References: <016701d7678c$2b3d50c0$81b7f240$@gmail.com> <20210622212818.enfx5fzgghfxfznb@pengutronix.de>        <CAMGHUonufNF7CgAzcPkhgykxdYBtA+r5nY2i5xRGXN7Nxd5yMQ@mail.gmail.com>    <2a99d742-b2dc-4411-acbb-2e23ce7cd132@posteo.de>        <029101d76855$fa5ac300$ef104900$@gmail.com>     <20210625065626.b7afwhptoyoxoblx@pengutronix.de>        <20210625121648.hg4hihfmddss7ptu@pengutronix.de>        <020f01d769da$9fac86b0$df059410$@gmail.com>     <022d01d769e2$e623cbf0$b26b63d0$@gmail.com>     <20210702093110.vzfjk4dgovrrs4mj@pengutronix.de> <CAMGHUo=NK0Q=4y8Wgp3Mo+G8CuUcK8gLhxBH6Z1to8PZMZRr3w@mail.gmail.com>
In-Reply-To: <CAMGHUo=NK0Q=4y8Wgp3Mo+G8CuUcK8gLhxBH6Z1to8PZMZRr3w@mail.gmail.com>
Subject: RE: MCP2518FD Drivers Rarely Working with Custom Kernel 5.10.Y
Date:   Tue, 6 Jul 2021 14:40:35 -0400
Message-ID: <006601d77296$68e41d40$3aac57c0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKkU7o+qbTtuE7WZsCEE+zhLGrysQHOwZAXAgLTME4A15gpjQI9UoC3AfsMaV4CTizomAGzk0WoAZKSgAIBs/x7BAFwQIEbqQ+ksyA=
Content-Language: en-us
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Good Afternoon,

Today I was planning to attack this problem from two different angles, =
first to detach the HAT and try narrowing down my config.txt to just =
what's needed for CAN (HAT wired up by jumper wires) and second to =
completely rebuild my OS from scratch in case something went awry during =
the upgrades; luckily during narrowing down my config.txt I found the =
issue. It appears that when I try to load the I2S subsystem that it's =
conflicting with SPI0. Since it's a lesser used feature, I'm guessing =
none of you all are testing with it loaded? Any ideas on how to begin =
troubleshooting this? I2S is something we need.

Current config.txt with two I2S lines (double hash) removed that results =
in working CAN on each reboot:

-------------------------------------------------------------------------=
-----------------------------------------------------------

dtdebug=3D1

disable_splash=3D1
boot_delay=3D0

hdmi_force_mode=3D1

hdmi_group=3D1
hdmi_mode=3D3 # 480p 60Hz H

# Uncomment some or all of these to enable the optional hardware =
interfaces
dtparam=3Di2c_arm=3Don
## dtparam=3Di2s=3Don
dtparam=3Dspi=3Doff
enable_uart=3D0

# Enable audio (loads snd_bcm2835)
dtparam=3Daudio=3Don

# I2S WM8782 Driver
## dtoverlay=3Dhel-wm8782,alsaname=3Dmic

[pi4]
# Enable DRM VC4 V3D driver on top of the dispmanx display stack
dtoverlay=3Dvc4-fkms-v3d
max_framebuffers=3D2

[all]
start_x=3D1
gpu_mem=3D512

# GPS
dtoverlay=3Duart3

# Reserved for HAT IDs
dtoverlay=3Di2c0
dtparam=3Dpins_0_1=3Don
dtparam=3Dcombine=3Doff

# Power Supervisor, IMU, RPi I2C Bus
dtoverlay=3Di2c1

# CAN 0/1
dtoverlay=3Dspi0-cs
dtparam=3Dcs0_pin=3D8
dtparam=3Dcs1_pin=3D7

# Reserved
dtoverlay=3Dspi5-2cs
dtparam=3Dcs0_pin=3D12
dtparam=3Dcs0_spidev=3Ddisabled
dtparam=3Dcs1_pin=3D26
dtparam=3Dcs1_spidev=3Ddisabled

# CAN 0
dtoverlay=3Dmcp251xfd,spi0-0,interrupt=3D24,oscillator=3D40000000,speed=3D=
20000000

# CAN 1
dtoverlay=3Dmcp251xfd,spi0-1,interrupt=3D25,oscillator=3D40000000,speed=3D=
20000000

-------------------------------------------------------------------------=
-----------------------------------------------------------

Thanks,

Josh Q

-----Original Message-----
From: Joshua Quesenberry <engnfrc@gmail.com>=20
Sent: Friday, July 2, 2021 10:27 AM
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Patrick Menschel <menschel.p@posteo.de>; kernel@pengutronix.de; =
linux-can@vger.kernel.org; Joshua Quesenberry <EngnFrc@gmail.com>
Subject: Re: MCP2518FD Drivers Rarely Working with Custom Kernel 5.10.Y

The only other format I have is Saleae's trace format, if you're willing =
to install their software, the attached trace should work. I double =
checked that the application will load even without the device attached, =
and it does, so it should work for you. I was using Logic 1, but =
switched to their Logic 2 app and recollected a trace for you.
https://www.saleae.com/downloads/

Thanks,

Josh Q

On Fri, Jul 2, 2021 at 5:31 AM Marc Kleine-Budde <mkl@pengutronix.de> =
wrote:
>
> On 25.06.2021 12:55:26, Joshua Quesenberry wrote:
> > Forgive me, I forgot can0 =3D spi0.1 and can1 =3D spi0.0 right now=20
> > because I killed my UDEV rule so I was tapped onto the wrong CS=20
> > line. Attached is a snapshot of what I'm seeing AND an export of the =

> > data from Saleae which may prove more useful than snapshots.
>
> Pulseview cannot parse the csv file correctly (see [1]). Can you save=20
> it in a different format?
>
> Marc
>
> [1]=20
> https://www.mail-archive.com/sigrok-devel@lists.sourceforge.net/msg037
> 51.html
>
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

