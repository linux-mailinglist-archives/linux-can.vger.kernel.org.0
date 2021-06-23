Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7D33B1F94
	for <lists+linux-can@lfdr.de>; Wed, 23 Jun 2021 19:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhFWRgc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Jun 2021 13:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWRgb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Jun 2021 13:36:31 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D68C061574
        for <linux-can@vger.kernel.org>; Wed, 23 Jun 2021 10:34:12 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id f70so7122237qke.13
        for <linux-can@vger.kernel.org>; Wed, 23 Jun 2021 10:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:thread-index:content-language;
        bh=ggTKOtjHOT4V2G0Ktp5TXlUSdxvHNrTm/G2Qc9anGAU=;
        b=aFOFZKzqisdUrkjQxa1GANMr0J7cm4prT/G8Hqivh1W7sjAOLvFOf0Ovyteie6vl32
         N8txzXcAEwqhUGgedHRQB0RSOgTqKLnP0yBf/e0G08B2zAipZKuTzNuD3jz8qzVjGAsd
         S4tGAlLEODfYH+/DLx1TFaGl85sjvRdNLoa1f0EgpUkLnYcEneI6WO+jCPzbTqATcysM
         1V0xNGLsL1oDCh3TyPwTbhms8QVhUyOZd7zu/5DYK7yS7+U0Cf+onfJvWyanr094tefC
         AOjGeKD/KA88Rap8YVOcRdkWAzWeamTv46MIOUvXA/zvJt6QW1ClhNQCj7ifvaz4adi6
         FcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:thread-index:content-language;
        bh=ggTKOtjHOT4V2G0Ktp5TXlUSdxvHNrTm/G2Qc9anGAU=;
        b=XbF34TSTtI9EJOSgCpAoOJB+yywVknmdq4c3SKzNBkiPWRndCWJfVrdC/Vd95bqaP3
         oSBXsXWrLQJ0Ir8U6gwL1V3XokWF1Z4i/jbaIc4mfzkQXNcsUVLZaSgnVrhyhJD4H41l
         EJHp1ruTHkDReCWTz/uimT04Q/X0dZa4TfH+M3hqyzqKak36nJW26P70R4dV3tZfzWNE
         1WNj1JAXCfHUA9OCGe9SL4c0e+8h1n+eX0NbjNJyQMkNrn0iEboBzJ1YC1EAxytUgtHG
         D3uzKCygYjHF7qZQ6aLrEpR3oBsjHHvfrcA058nMQiVovNOoPGLZS5Z6suvD2owIsIq5
         mv8g==
X-Gm-Message-State: AOAM5329AKXzHspmS18cWfFnLV36YiXc14N7Cvew2dc39439b64VP5sd
        h4dk5lPzSNE2pmoplsdxzw0=
X-Google-Smtp-Source: ABdhPJzgecxrUh0GH81r834dfHEcYIQmxk1sBDWYrWADTg5op2AAiMEnxlLaOzaz0YAevviVkvRcQg==
X-Received: by 2002:a05:620a:1326:: with SMTP id p6mr1148865qkj.132.1624469651985;
        Wed, 23 Jun 2021 10:34:11 -0700 (PDT)
Received: from DTJQUESENBERRY ([2001:468:c80:a202:24ee:683:408c:fc8])
        by smtp.gmail.com with ESMTPSA id i24sm336671qkk.87.2021.06.23.10.34.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jun 2021 10:34:11 -0700 (PDT)
From:   "Joshua Quesenberry" <engnfrc@gmail.com>
To:     "'Patrick Menschel'" <menschel.p@posteo.de>,
        "'Marc Kleine-Budde'" <mkl@pengutronix.de>
Cc:     <kernel@pengutronix.de>, <linux-can@vger.kernel.org>,
        <engnfrc@gmail.com>
References: <016701d7678c$2b3d50c0$81b7f240$@gmail.com> <20210622212818.enfx5fzgghfxfznb@pengutronix.de> <CAMGHUonufNF7CgAzcPkhgykxdYBtA+r5nY2i5xRGXN7Nxd5yMQ@mail.gmail.com> <2a99d742-b2dc-4411-acbb-2e23ce7cd132@posteo.de>
In-Reply-To: <2a99d742-b2dc-4411-acbb-2e23ce7cd132@posteo.de>
Subject: RE: MCP2518FD Drivers Rarely Working with Custom Kernel 5.10.Y
Date:   Wed, 23 Jun 2021 13:34:10 -0400
Message-ID: <029101d76855$fa5ac300$ef104900$@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_NextPart_000_0292_01D76834.7349E650"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKkU7o+qbTtuE7WZsCEE+zhLGrysQHOwZAXAgLTME4A15gpjalitNUA
Content-Language: en-us
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is a multipart message in MIME format.

------=_NextPart_000_0292_01D76834.7349E650
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey!

I have attached config.txt so you all can see what I'm doing.

I added printing the error number as Marc suggested and the number =
appears to be -110 every time.

[   25.660006] CAN device driver interface
[   25.668720] spi_master spi0: will run message pump with realtime =
priority
[   25.676697] mcp251xfd spi0.1 can0: MCP2518FD rev0.0 (-RX_INT =
-MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz =
r:17.00MHz e:16.66MHz) successfully initialized.
[   25.684900] mcp251xfd spi0.0 can1: MCP2518FD rev0.0 (-RX_INT =
-MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz =
r:17.00MHz e:16.66MHz) successfully initialized.
[   28.098033] mcp251xfd spi0.1 rename4: renamed from can0
[   28.175644] mcp251xfd spi0.0 can0: renamed from can1
[   28.225891] mcp251xfd spi0.1 can1: renamed from rename4
[  146.964971] mcp251xfd spi0.0: SPI transfer timed out
[  146.965023] spi_master spi0: failed to transfer one message from =
queue (ret=3D-110)
[  146.965216] mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c =
(length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
[  146.965247] mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c =
(length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
[  146.965277] mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c =
(length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
[  146.965286] mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c =
(length=3D4, data=3D00 00 00 00, CRC=3D0x0000).
[  146.965331] mcp251xfd spi0.0 can0: CRC read error at address 0x0000 =
(length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
[  146.965360] mcp251xfd spi0.0 can0: CRC read error at address 0x0000 =
(length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
[  146.965389] mcp251xfd spi0.0 can0: CRC read error at address 0x0000 =
(length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
[  146.965397] mcp251xfd spi0.0 can0: CRC read error at address 0x0000 =
(length=3D4, data=3D00 00 00 00, CRC=3D0x0000).
[  146.965413] A link change request failed with some changes committed =
already. Interface can0 may have been left with an inconsistent =
configuration, please check.

Regarding the discussion about Kconfig flags, I went ahead and rebuilt =
kernel 5.10.44 using a config that was essentially =
arch/arm/configs/bcm2711_defconfig with these additions needed to get =
our I2S working. This should have undone the switch to ONDEMAND governor =
and enabling 1000 Hz clock.

1030a1031
> CONFIG_SND_RPI_I2S_AUDIO_WM8782=3Dm
1040a1042
> CONFIG_SND_SOC_WM8782=3Dm

My RPi and HAT have worked very reliably with the older buster image and =
customized (same tweaks as mentioned in last email) kernel 4.19.73, in =
that kernel I'm using MCP25XXFD driver from msperl which under 5.10.Y =
kernel is having issues too. I only upgraded everything on my system at =
the end of last week, so hardware has been OK very recently.

Keep in mind I'm not seeing a total failure, I do occasionally see =
everything work correctly and I can run the ip link setup command =
without issue, it's just not common and it seems fully removing power =
from the system and reapplying seems to help, but not every time, so =
maybe it's a coincidence. It could be an issue of subsequent =
configurations of the controller after the initial setup on power =
application, but I'd expect it work after every power yank I think.

I wouldn't feel comfortable reverting my /boot/config.txt to a stock one =
and a default setup of the 40-pin header, at least not with my HAT =
attached which includes the CAN controllers AND circuitry to supply =
power to RPi from a 12V rail.

Thanks,

Josh Q

-----Original Message-----
From: Patrick Menschel <menschel.p@posteo.de>=20
Sent: Wednesday, June 23, 2021 1:24 AM
To: Joshua Quesenberry <engnfrc@gmail.com>; Marc Kleine-Budde =
<mkl@pengutronix.de>
Cc: kernel@pengutronix.de; linux-can@vger.kernel.org
Subject: Re: MCP2518FD Drivers Rarely Working with Custom Kernel 5.10.Y

Am 23.06.21 um 04:59 schrieb Joshua Quesenberry:
> Thank you Marc, I had tried finding a Linux CAN forum, but=20
> unfortunately searching for "CAN" in Google is about the most=20
> unhelpful search term one could use... so thanks for replying and=20
> getting me to a more appropriate audience.
>=20
> Reverting my system back to where CAN was working will probably be=20
> challenging. Our main goal was to get Boot from USB on the RPi=20
> enabled, but this unfortunately meant upgrading every piece of=20
> software and firmware available... previously we were still on Buster, =

> but the OS snapshot was from Spring 2020 (if not Fall/Winter 2019), if =

> not earlier, the firmware was much older, and the kernel was 4.19.73,=20
> wherein the MCP251XFD driver didn't exist yet. So getting back there=20
> will mean throwing a saved SD Card image on from Spring 2020 and then=20
> trying to figure out how to force downgrade the firmware. A colleague=20
> started this upgrade process for another project and was seeing these=20
> same results on two separate RPi, he did the OS and firmware upgrades, =

> but I did the building of the 5.10.17 kernel. So including those two=20
> RPi and mine, that's three total systems with mostly non-working CAN=20
> where it had been working fine, my system has slightly newer RPi=20
> firmware now and the 5.10.44 kernel, the hope was maybe I'd pick up a=20
> patch somewhere, but no such luck. If you still think it would be=20
> beneficial to go through the effort of downgrading everything to=20
> verify the hardware I can do that, but just want to make sure before I =

> start that since it'll take a while.
>=20
> I updated spi.c to include printing the error number as you requested=20
> and that's all baking now. When I get into work in the morning (US
> EST) I'll get the changes deployed and try it out. Since this issue is =

> a very high failure rate, getting a log shouldn't be an issue.
>=20
> Some background on the custom kernel... when I switched to the 5.10.Y=20
> branch, I used arch/arm/configs/bcm2711_defconfig as my base config=20
> and then switched on preempt, switched to 1000Hz kernel timer,=20
> switched the default governor from powersave to ondemand, switched on=20
> debug flag (CONFIG_DEBUG_USER=3Dy), enabled a few different CAN =
drivers=20
> we may encounter, and enabled some stuff for the WM8782 I2S chip. I=20
> probably should have recreated my config after 5.10.44, but I hadn't=20
> considered till this writing, looking at this diff there a few bits=20
> that are new I probably could benefit from including, but I don't see=20
> anything that I'd be concerned about.
>=20
> `diff bcm2711_defconfig hel_bcm2711_lowlatency_defconfig`
> 15d14
> < CONFIG_ATA=3Dm
> 43d41
> < CONFIG_BH1750=3Dm
> 53c51
> < CONFIG_BLK_DEV_NVME=3Dy
> ---
>> CONFIG_BLK_DEV_NVME=3Dm
> 120c118
> < CONFIG_CAN_J1939=3Dm
> ---
>> CONFIG_CAN_KVASER_USB=3Dm
> 123a122,123
>> CONFIG_CAN_MCP25XXFD=3Dm
>> CONFIG_CAN_PEAK_USB=3Dm
> 127d126
> < CONFIG_CCS811=3Dm
> 155c154
> < CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=3Dy
> ---
>> CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=3Dy
> 158,159c157
> < CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
> < CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
> ---
>> CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
> 184a183
>> CONFIG_DEBUG_USER=3Dy
> 209d207
> < CONFIG_DRM_PANEL_JDI_LT070ME05000=3Dm
> 319a318
>> CONFIG_GENERIC_PHY=3Dy
> 325d323
> < CONFIG_GPIO_PCA953X_IRQ=3Dy
> 395a394
>> CONFIG_HZ_1000=3Dy
> 561d559
> < CONFIG_IR_TOY=3Dm
> 826d823
> < CONFIG_NF_LOG_ARP=3Dm
> 828d824
> < CONFIG_NF_LOG_NETDEV=3Dm
> 950c946
> < CONFIG_PREEMPT_VOLUNTARY=3Dy
> ---
>> CONFIG_PREEMPT=3Dy
> 957d952
> < CONFIG_QCA7000_UART=3Dm
> 994d988
> < CONFIG_RPI_POE_POWER=3Dm
> 1040a1035
>> # CONFIG_RTC_HCTOSYS is not set
> 1044,1045d1038
> < CONFIG_SATA_AHCI=3Dm
> < CONFIG_SATA_MV=3Dm
> 1054d1046
> < CONFIG_SENSIRION_SGP30=3Dm
> 1134a1127
>> CONFIG_SND_RPI_I2S_AUDIO_WM8782=3Dm
> 1149a1143
>> CONFIG_SND_SOC_WM8782=3Dm
>=20
> The /boot/config.txt I included in the forum posts mentioned is=20
> tweaking the 40-pin header quite a bit from the default setup, we're=20
> using many of the pins for our HAT and planned for possibly adding=20
> more in the future.

Hi,

it would help to find a reference to that config.txt .

Regarding the changed Kconfig flags, I would suspect everything that =
owns a =3Dy to be the culprit, especially everything that has =
connections to a clock.
Ever since the first rpi3, clocks are unreliable in general due to the =
frequency governor. The rpi guys did there best to get rid of most of =
the initial problems but the root cause remains.

The interesting question is, does a stock raspbian buster work with your =
hardware and that config.txt?

I'm running a stock raspbian buster on a rpi3b+ with seeed can fd hat v2
24/7 for a couple of month now and did not expierence any problems.

Regards,
Patrick

------=_NextPart_000_0292_01D76834.7349E650
Content-Type: text/plain;
	name="config.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="config.txt"

# For more options and information see=0A=
# http://rpf.io/configtxt=0A=
# Some settings may impact device functionality. See link above for =
details=0A=
=0A=
dtdebug=3D1=0A=
=0A=
disable_splash=3D1=0A=
boot_delay=3D0=0A=
=0A=
# uncomment if you get no picture on HDMI for a default "safe" mode=0A=
#hdmi_safe=3D1=0A=
=0A=
# uncomment this if your display has a black border of unused pixels =
visible=0A=
# and your display can output without overscan=0A=
#disable_overscan=3D1=0A=
=0A=
# uncomment the following to adjust overscan. Use positive numbers if =
console=0A=
# goes off screen, and negative if there is too much border=0A=
#overscan_left=3D16=0A=
#overscan_right=3D16=0A=
#overscan_top=3D16=0A=
#overscan_bottom=3D16=0A=
=0A=
# uncomment to force a console size. By default it will be display's =
size minus=0A=
# overscan.=0A=
#framebuffer_width=3D1280=0A=
#framebuffer_height=3D720=0A=
=0A=
# uncomment if hdmi display is not detected and composite is being output=0A=
#hdmi_force_hotplug=3D1=0A=
=0A=
hdmi_force_mode=3D1=0A=
=0A=
# uncomment to force a specific HDMI mode (this will force VGA)=0A=
#hdmi_group=3D1=0A=
#hdmi_mode=3D1=0A=
hdmi_group=3D1=0A=
hdmi_mode=3D3 # 480p 60Hz H=0A=
#hdmi_mode=3D9 # 240p 60Hz H=0A=
=0A=
# uncomment to force a HDMI mode rather than DVI. This can make audio =
work in=0A=
# DMT (computer monitor) modes=0A=
#hdmi_drive=3D2=0A=
=0A=
# uncomment to increase signal to HDMI, if you have interference, =
blanking, or=0A=
# no display=0A=
#config_hdmi_boost=3D4=0A=
=0A=
# uncomment for composite PAL=0A=
#sdtv_mode=3D2=0A=
=0A=
#uncomment to overclock the arm. 700 MHz is the default.=0A=
#arm_freq=3D800=0A=
=0A=
#arm_freq=3D1500=0A=
#gpu_freq=3D600=0A=
#core_freq=3D600=0A=
#h264_freq=3D600=0A=
#isp_freq=3D600=0A=
#v3d_freq=3D600=0A=
=0A=
# Uncomment some or all of these to enable the optional hardware =
interfaces=0A=
dtparam=3Di2c_arm=3Don=0A=
dtparam=3Di2s=3Don=0A=
dtparam=3Dspi=3Doff=0A=
enable_uart=3D0=0A=
=0A=
# Uncomment this to enable the lirc-rpi module=0A=
#dtoverlay=3Dlirc-rpi=0A=
=0A=
# Additional overlays and parameters are documented /boot/overlays/README=0A=
=0A=
# Enable audio (loads snd_bcm2835)=0A=
dtparam=3Daudio=3Don=0A=
=0A=
[pi4]=0A=
# Enable DRM VC4 V3D driver on top of the dispmanx display stack=0A=
dtoverlay=3Dvc4-fkms-v3d=0A=
max_framebuffers=3D2=0A=
=0A=
[all]=0A=
#dtoverlay=3Dvc4-fkms-v3d=0A=
start_x=3D1=0A=
gpu_mem=3D512=0A=
=0A=
# GPS=0A=
dtoverlay=3Duart3=0A=
=0A=
# Reserved for HAT IDs=0A=
dtoverlay=3Di2c0=0A=
dtparam=3Dpins_0_1=3Don=0A=
dtparam=3Dcombine=3Doff=0A=
=0A=
# Power Supervisor, IMU, RPi I2C Bus=0A=
dtoverlay=3Di2c1=0A=
=0A=
# CAN 0/1=0A=
dtoverlay=3Dspi0-cs=0A=
dtparam=3Dcs0_pin=3D8=0A=
dtparam=3Dcs1_pin=3D7=0A=
=0A=
# Reserved=0A=
dtoverlay=3Dspi5-2cs=0A=
dtparam=3Dcs0_pin=3D12=0A=
dtparam=3Dcs0_spidev=3Ddisabled=0A=
dtparam=3Dcs1_pin=3D26=0A=
dtparam=3Dcs1_spidev=3Ddisabled=0A=
=0A=
# # CAN 0=0A=
# dtoverlay=3Dmcp2517fd-spi0_0-can0=0A=
# dtparam=3Doscillator=3D40000000=0A=
# dtparam=3Dspimaxfrequency=3D20000000=0A=
# dtparam=3Dinterrupt=3D24=0A=
# =0A=
# # CAN 1=0A=
# dtoverlay=3Dmcp2517fd-spi0_1-can1=0A=
# dtparam=3Doscillator=3D40000000=0A=
# dtparam=3Dspimaxfrequency=3D20000000=0A=
# dtparam=3Dinterrupt=3D25=0A=
=0A=
# CAN 0=0A=
dtoverlay=3Dmcp251xfd,spi0-0,interrupt=3D24,oscillator=3D40000000,speed=3D=
20000000=0A=
=0A=
# CAN 1=0A=
dtoverlay=3Dmcp251xfd,spi0-1,interrupt=3D25,oscillator=3D40000000,speed=3D=
20000000=0A=
=0A=
dtoverlay=3Dhel-wm8782,alsaname=3Dmic=0A=

------=_NextPart_000_0292_01D76834.7349E650--

