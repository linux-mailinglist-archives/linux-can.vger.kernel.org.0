Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2F73B3597
	for <lists+linux-can@lfdr.de>; Thu, 24 Jun 2021 20:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhFXS0w (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Jun 2021 14:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXS0w (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Jun 2021 14:26:52 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0566C061574
        for <linux-can@vger.kernel.org>; Thu, 24 Jun 2021 11:24:31 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id f20so4740332qtk.10
        for <linux-can@vger.kernel.org>; Thu, 24 Jun 2021 11:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=PmB4nHpYi5Dpm5//2WYYci5i1cfLC6tr4Lz6dUvAnGM=;
        b=guDre0GFbo+UqFiOIa1XnqA7q54vp5QVHKIm04bTU2PQRHBj4rLoCcDRRujziYWTAU
         pICWgOSHlXsx8HnZoGj3MaFJ5nQN8V05TqEZZn6dYeSdafguUAAyladjTvZ/a8nk5FO/
         MWzZZuHZAK86HixNm8y3xY1PPmPDEQRPyby9Sz9xRJXUVQM0Mw3pB5TMmaRQL6Rv79ok
         0fIvW3RBVJTrT6och67hIk+cpWtR7KxIQs1iIjydvgHooD4H16JnJTxRMmtnpCBvkeAt
         RqT5q7t/ZSGvDA32rMbOsfS7Lo1GNo040+4dPRZA2uO1eR+7PeqDsJFgodXvaRHloNYR
         fSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=PmB4nHpYi5Dpm5//2WYYci5i1cfLC6tr4Lz6dUvAnGM=;
        b=R6KMn4QWqeFnWogaM1x3KrLA71Puu0/Y2rEVQmD5vRcyrrpVcAMaL1U/3PDDqc1Mag
         HEk1rvkmh+4uLQ6GbZKPi/Pzs52Oh879H8oRtWpHtBw0mt1WyaFt3IbKqimUpvXmsRZq
         IouIDlFiUreRp1Q7b7JT7qTfLEyKgzcSMiogRZoa7gQfc435C4n9rrAMaMXN1lg/nQG+
         MXgNSbp9jLRLF+nwJrTeUdgOikvKRZJZcWaSRA+2wErmuTvuO87pPT2orGYUdxa2G2wU
         Olc93S3szqhDavFgB3zm+l6bSm93SITXz5+BVormKY39rpoOuJirnXQCngRfp749Ehwf
         Jthw==
X-Gm-Message-State: AOAM53325NWByeFkPsEMYY2skcXmv1wf/8mgXhwycO0i1nU3k2iwjqnd
        qoqJjitR8mXeFL7qfpFLm2c=
X-Google-Smtp-Source: ABdhPJwpCIjqLonbFVE1yYfeEFKNwr7sD3goSPUToirSfocR80jG5WskTIVmxPPkLiZw+DJMNU/5Xw==
X-Received: by 2002:ac8:4655:: with SMTP id f21mr2211488qto.110.1624559071027;
        Thu, 24 Jun 2021 11:24:31 -0700 (PDT)
Received: from DTJQUESENBERRY ([2001:468:c80:a202:6d2c:72ca:2369:f63a])
        by smtp.gmail.com with ESMTPSA id d23sm2456028qto.74.2021.06.24.11.24.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jun 2021 11:24:30 -0700 (PDT)
From:   "Joshua Quesenberry" <engnfrc@gmail.com>
To:     "'Patrick Menschel'" <menschel.p@posteo.de>,
        "'Marc Kleine-Budde'" <mkl@pengutronix.de>
Cc:     <kernel@pengutronix.de>, <linux-can@vger.kernel.org>,
        <engnfrc@gmail.com>
References: <016701d7678c$2b3d50c0$81b7f240$@gmail.com> <20210622212818.enfx5fzgghfxfznb@pengutronix.de> <CAMGHUonufNF7CgAzcPkhgykxdYBtA+r5nY2i5xRGXN7Nxd5yMQ@mail.gmail.com> <2a99d742-b2dc-4411-acbb-2e23ce7cd132@posteo.de> <029101d76855$fa5ac300$ef104900$@gmail.com> <fe0a5628-e87f-6261-58c7-dbfccbb143a2@posteo.de>
In-Reply-To: <fe0a5628-e87f-6261-58c7-dbfccbb143a2@posteo.de>
Subject: RE: MCP2518FD Drivers Rarely Working with Custom Kernel 5.10.Y
Date:   Thu, 24 Jun 2021 14:24:29 -0400
Message-ID: <010b01d76926$2c3c6bf0$84b543d0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQKkU7o+qbTtuE7WZsCEE+zhLGrysQHOwZAXAgLTME4A15gpjQI9UoC3Ath8qVypO6qo8A==
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thanks for the tips Patrick on config.txt cleanup, I'll take a closer =
look into that.

Not sure I'm following what you're asking for with regards to i2c. i2c1 =
is currently is use to communicate with accel, gyro, mag, and a power =
supervisor MCU that helps us accomplish wake/sleep based on accel or =
vehicle ignition and some other low-level hardware tasks.

I removed the UDEV rules I had that rename can0 and can1, just in case =
that was causing a race condition or something else odd, but the system =
is behaving the same.

Not sure what else to try at this point, any ideas? What does the error =
number of -110 mean to you all?

-----Original Message-----
From: Patrick Menschel <menschel.p@posteo.de>=20
Sent: Wednesday, June 23, 2021 4:07 PM
To: Joshua Quesenberry <engnfrc@gmail.com>; 'Marc Kleine-Budde' =
<mkl@pengutronix.de>
Cc: kernel@pengutronix.de; linux-can@vger.kernel.org
Subject: Re: MCP2518FD Drivers Rarely Working with Custom Kernel 5.10.Y

Am 23.06.21 um 19:34 schrieb Joshua Quesenberry:
> Hey!
>=20
> I have attached config.txt so you all can see what I'm doing.
>=20
> I added printing the error number as Marc suggested and the number =
appears to be -110 every time.
>=20
> [   25.660006] CAN device driver interface
> [   25.668720] spi_master spi0: will run message pump with realtime =
priority
> [   25.676697] mcp251xfd spi0.1 can0: MCP2518FD rev0.0 (-RX_INT =
-MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz =
r:17.00MHz e:16.66MHz) successfully initialized.
> [   25.684900] mcp251xfd spi0.0 can1: MCP2518FD rev0.0 (-RX_INT =
-MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz =
r:17.00MHz e:16.66MHz) successfully initialized.
> [   28.098033] mcp251xfd spi0.1 rename4: renamed from can0
> [   28.175644] mcp251xfd spi0.0 can0: renamed from can1
> [   28.225891] mcp251xfd spi0.1 can1: renamed from rename4
> [  146.964971] mcp251xfd spi0.0: SPI transfer timed out [  146.965023] =

> spi_master spi0: failed to transfer one message from queue =
(ret=3D-110)=20
> [  146.965216] mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c =
(length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> [  146.965247] mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c =
(length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> [  146.965277] mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c =
(length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> [  146.965286] mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c =
(length=3D4, data=3D00 00 00 00, CRC=3D0x0000).
> [  146.965331] mcp251xfd spi0.0 can0: CRC read error at address 0x0000 =
(length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> [  146.965360] mcp251xfd spi0.0 can0: CRC read error at address 0x0000 =
(length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> [  146.965389] mcp251xfd spi0.0 can0: CRC read error at address 0x0000 =
(length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> [  146.965397] mcp251xfd spi0.0 can0: CRC read error at address 0x0000 =
(length=3D4, data=3D00 00 00 00, CRC=3D0x0000).
> [  146.965413] A link change request failed with some changes =
committed already. Interface can0 may have been left with an =
inconsistent configuration, please check.
>=20
> Regarding the discussion about Kconfig flags, I went ahead and rebuilt =
kernel 5.10.44 using a config that was essentially =
arch/arm/configs/bcm2711_defconfig with these additions needed to get =
our I2S working. This should have undone the switch to ONDEMAND governor =
and enabling 1000 Hz clock.
>=20
> 1030a1031
>> CONFIG_SND_RPI_I2S_AUDIO_WM8782=3Dm
> 1040a1042
>> CONFIG_SND_SOC_WM8782=3Dm
>=20
> My RPi and HAT have worked very reliably with the older buster image =
and customized (same tweaks as mentioned in last email) kernel 4.19.73, =
in that kernel I'm using MCP25XXFD driver from msperl which under 5.10.Y =
kernel is having issues too. I only upgraded everything on my system at =
the end of last week, so hardware has been OK very recently.
>=20
> Keep in mind I'm not seeing a total failure, I do occasionally see =
everything work correctly and I can run the ip link setup command =
without issue, it's just not common and it seems fully removing power =
from the system and reapplying seems to help, but not every time, so =
maybe it's a coincidence. It could be an issue of subsequent =
configurations of the controller after the initial setup on power =
application, but I'd expect it work after every power yank I think.
>=20
> I wouldn't feel comfortable reverting my /boot/config.txt to a stock =
one and a default setup of the 40-pin header, at least not with my HAT =
attached which includes the CAN controllers AND circuitry to supply =
power to RPi from a 12V rail.

OK,

one general advice.

Check if you can merge your HAT into a complete overlay with ovmerge =
tool like I did in
https://github.com/raspberrypi/linux/issues/4032
https://github.com/raspberrypi/linux/pull/4034

This should clean up your config.txt quite a bit.

I compare against the seeed can fd hat v2 which also has i2c1 and both =
can on spi0.

I'm not sure about the PI4 but these 3 items usually all go on i2c1 =
which may be problematic.

# typical combination out of raspi-config dtparam=3Di2c_arm=3Don =
dtparam=3Di2s=3Don

# some manual entry, check if it can be removed
dtoverlay=3Di2c1


The CAN related stuff looks ok, but you can omit the
oscillator=3D40000000,speed=3D20000000
Those are the standard values afaik.

# CAN 0/1
dtoverlay=3Dspi0-cs
dtparam=3Dcs0_pin=3D8
dtparam=3Dcs1_pin=3D7

# CAN 0
dtoverlay=3Dmcp251xfd,spi0-0,interrupt=3D24

# CAN 1
dtoverlay=3Dmcp251xfd,spi0-1,interrupt=3D25


Concerning the naming, I also used generic names can0, can1 at first but =
was advised to use best practice and to rename to mcp0, mcp1 instead. I =
believe Marc mentioned that this causes some kind of problem.

This is my udev rule content.
SUBSYSTEM=3D=3D"net", ACTION=3D=3D"add",
DEVPATH=3D=3D"/devices/platform/soc/*/*/*/spi0.0/net/can?", =
NAME=3D"mcp0"
SUBSYSTEM=3D=3D"net", ACTION=3D=3D"add",
DEVPATH=3D=3D"/devices/platform/soc/*/*/*/spi0.1/net/can?", =
NAME=3D"mcp1"


Regards,
Patrick

