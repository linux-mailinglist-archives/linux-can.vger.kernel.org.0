Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCE23B2194
	for <lists+linux-can@lfdr.de>; Wed, 23 Jun 2021 22:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFWUJt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Jun 2021 16:09:49 -0400
Received: from mout02.posteo.de ([185.67.36.66]:60199 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhFWUJt (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 23 Jun 2021 16:09:49 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 553BB2400FE
        for <linux-can@vger.kernel.org>; Wed, 23 Jun 2021 22:07:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1624478849; bh=U/HqbOhkzA7kyR/uQ61lAoVV5YIko65gDqiJD1UUQdM=;
        h=To:Cc:From:Autocrypt:Subject:Date:From;
        b=r7i5EP66mWFbHbe1TeCYLNy4ZXVevIwOd3GcfGPTL60FwnfJhMP1ZM9SCHDY5OTYs
         M+DVuDerKSRKh9WeaIapign+e+dlZvmCuo0avn0ojM5sd0OrM3oXn079pveI5rqIdE
         8AKMXrM9+dmqZ4/Dti3jM9hPqjvm0dINkwlPHTYQQLwx63mcwL0zZ9ZaGEL1k/s/hL
         cfWxyFlw5yykK9gyaJtVkzRQXEvRFvM9gnX/NR04/2nIuePS1gBG72VqvbL9TvZ0VE
         Zj0VQIsxc5UfNftWwgOsg+/8HTi7tEmTqFWBYc3/wr9pOAxgCZCFoSLxav+Njvl82H
         9dr/hpnK5c/Bg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4G9Dnr1VM8z6tmH;
        Wed, 23 Jun 2021 22:07:28 +0200 (CEST)
To:     Joshua Quesenberry <engnfrc@gmail.com>,
        'Marc Kleine-Budde' <mkl@pengutronix.de>
Cc:     kernel@pengutronix.de, linux-can@vger.kernel.org
References: <016701d7678c$2b3d50c0$81b7f240$@gmail.com>
 <20210622212818.enfx5fzgghfxfznb@pengutronix.de>
 <CAMGHUonufNF7CgAzcPkhgykxdYBtA+r5nY2i5xRGXN7Nxd5yMQ@mail.gmail.com>
 <2a99d742-b2dc-4411-acbb-2e23ce7cd132@posteo.de>
 <029101d76855$fa5ac300$ef104900$@gmail.com>
From:   Patrick Menschel <menschel.p@posteo.de>
Autocrypt: addr=menschel.p@posteo.de; prefer-encrypt=mutual; keydata=
 LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptUUlOQkZ3RG1RZ0JFQUMr
 elBRRy9KTHQyWUpiNTRERFBKd0Jtd25EUTh4dUZQcEFjRjNYSVVuZkFOTGs0OUpoClhWczFR
 TnVHZk1VLytmY3RPWGd0SmF6Q3doc3NGdlUvWStPc1Nmd3FTN1ROOXhIWE1DZmtnK1gxRHhI
 ZGtqcmoKL1pUYkxHd1FUQlE2SVpVeW9BTEVSQ2RHZFBETFVqWERSS0poSTdvV3RqYlVFWUVr
 ZE9RYnY2eDhLVWd1bGtHUgpYYWxka1hJZ0R0VWZLaUE0VGhBVXpncVJuZ09DV2ZITis4TnBo
 Q2pGVlFnclRSakxCc3pkZTFnTmJkZ2kvdWxiClcyTngvS1Jqa0F1TTdFUVJvVUJ2QUJWb2FX
 R3ZYenIzUmphUFhrSk5wNHdFbm1IcVoxZlVteWMvSGZRNnVjWnkKRW5QZnlEWExtWTJQUU5P
 N2ZCemZLMTJVRTdWZHh0OTBDNURPSkRBc25kNHYreloxNHJObEpmTHNwaDZkVlNIbApsS2t2
 NE1BTndNaGxRT3Bta1pLMHhVU0Q2R0M1OHRiV0RSbEg4b3UrWUhDYlh2OHJCTXphR0phWDVB
 S25lNTJTCmZEUCtiQVVTdWVQdDhrRG5TaU1ZNk9iUEdObWhqcW1JN1RmNkU1NDdqRXUzcmxr
 aVI3Rno2cktVVzA5VlBlcnAKUnVya3orSTFtTDZ5ZTlZdGFDZ3MwbFR4b3VuYnA5emROVE04
 djZFOGJsMWNoSnRoYWs1bkEvRktnbmRtVHdhUQpNclFTRFEyNmxMcUw0MXRPZzhlVXFhTzJI
 TXVPRGNaaVVIMGVNWHlQZjhsbXhMcy9sbUVZU3hGUXFMWlBjWW9pClA0SGxVcDNSMkxIa0hO
 WDg1WDBKUldwRkkwLzNKMTFiWEpjLzc1MzVKODExdE9aRDkyRHlkK20zS3dBUkFRQUIKdENk
 UVlYUnlhV05ySUUxbGJuTmphR1ZzSUR4dFpXNXpZMmhsYkM1d1FIQnZjM1JsYnk1a1pUNkpB
 bFFFRXdFSwpBRDRXSVFUcFZLQkNXcGNoUW9QQURFY3g1bTR3ejYrNFRnVUNYQU9aQ0FJYkl3
 VUpDV1lCZ0FVTENRZ0hBZ1lWCkNna0lDd0lFRmdJREFRSWVBUUlYZ0FBS0NSQXg1bTR3ejYr
 NFRnQTJELzBTQW92U0xuK1pTcGUzK0d4UUhKMzYKWmJ1TWs0REVSa0RKMnIveStvc254WUd2
 TmNtU3N5Q1pBaVZjTTlFM0kxUXVtdDZvWHpoditJUDJNd09MZTlQMwpvUmhJQ1JyQ2RwWmY1
 YjdDb0lOc3lENUJwNGFsSUs5UFpHUDdXTjRHeGE3OVpNYkRhNVBNWGVQZ2psckFNVGNOCjRv
 c2Q5NVB4eFNkV1dheTB2TUh0VWYwRGJkaDFRNUs1U3lkREpxdG56dFBkNzBzUG9wOHBRSWhE
 NExGUWdpcFgKL3VRdkEvWnZpN2c5T3N4YThCNnRDTG41VG5LT2lNYktCVUFya1FHTDFnbDQ4
 NFJtKzRlR011YVZrVjVBb3VYMApOaGQvTVU3eEMxS2dGcWZwYTMzZ0ZRdUxTSTU2aStuRkt6
 dzNIdiszeHBJOXJjaHFXQjNnSWNVQ2lQZmFxcU1vCnI4RVNKODF0NWlvckQrRlpQb1RyMUEz
 aGZTMTNuMGxWUytsZUd3dlNucjRRZ0gvcjZ5eGw4RERIaUdFMUFXblAKaTNaWFNKWnkxRUJW
 TWJXTXFBNzFwczZDS2ZnbmpmSHVvVmNsTElXd3cxT2gwYXlER1hMZUFic1VPTGtGOXAxMwo1
 MWxRS0lJWUZpcXVwL09qa0pKMlgxaTdITjlqV2xRVnR0SER3QlhZOWNYWDRHUzk3cnNwSVhj
 S2hHRytFSVB0CjFEaFdBdDR1ZDdqcDIrSDRmTXlKZGlVK0wrYTVXNjlTODZpOURTMjBUdXd2
 K3JRemNQWTQ3MkVxZmo0elhWWmsKNUNzZ2kxVDZzQ1lnZDd5TGpHMnFYblZsSTJqQ1JyT0RW
 dGJiY25jSi9peEhPQ1h2TmlvRzZPREhBM3ZtNlZxaQpEelBmYTBFaWZveWMxbDRvSUZvQ2c3
 a0NEUVJjQTVrSUFSQUEwdUlXUGNrRlpzb0ZVZG1Sd29vMW95YzhmSyttCll6TmhTc1l0UTlI
 ZDMvQmlWeUxwUERQK0F6eks4U2JvWXVGcTJOaGRJaTIyeFRTZ2pyRFZMOU10YTdNbDB6cHgK
 QnJSTitySm5LRFl3bThJeUl6eUpCRmhXU1l3YnVPSXVqbnB6U1IvVGVDT1VvelRadFhnQmRU
 YzZrUG5kV1BWTgpDWU9hZVFXdDI1Qnc3ZGNVbllUQ1FWYm9EN0RFVWFEVkVqM1BKM2U0aGli
 TEp1UnEvK1dQY3kxQ3g2UFNucTJ6CkdQN1pVNWh6NjF2ZGovbVJJa2QxS2UzUTZmWUwzSVRN
 T1l1WGF6VUVEZ3l3TlN0bVkwRmZUT05GWEtGTXdSNm8KcUtuSGlTN2tINytxQWFodUpkdVFB
 MW9SU2xUTWRFb3F2WHEySlVJTm1NaGdYL0ZQN3ZpZEFxcTdnVjRXWElxcAptckliVHBiNVpz
 U0N6dUJBd3lkOTYxM1lmYWpZVGlUYkJGRzQ1Mld4TnlJeTFUdVpWMmIxZlhPbGdLRjNvbmUx
 CnhwbURqbTFlZVhSdjRnV0d0Vks5cXlEaUtYWnlmQ0YyL2o5d08xaTNnUHZqYmFvU1dhT2hH
 T2V6dlNFQzB4RjgKWU9TMitGSmxVclVyVm54UXZsZkdyWFYxbUpRTHpvcFJ5N0VndjNlRDI0
 NUx5YjhjUHpOUmppelRqV2RYN0g0MwpuNTlXMkdWTkFLTkNyV1pkOGNjZEdJK1RodmwzUUh1
 YWQ3NEY5cGdDUUNZWXM5dG92YVZldFR1WlI2Y3JMaG10CmxmK1V4ME5SV29PV2ZTR0w5anBt
 dkR3aGlwWCszMUlvb1FiOTZ1a2UzOFBZMUVOMjJ6QlBxZ25jVVVrUkxQQncKbEhYbnpFVit6
 U1p4QXpFQUVRRUFBWWtDUEFRWUFRb0FKaFloQk9sVW9FSmFseUZDZzhBTVJ6SG1iakRQcjdo
 TwpCUUpjQTVrSUFoc01CUWtKWmdHQUFBb0pFREhtYmpEUHI3aE9Db0lQLzNTanBFdTl4Wkpj
 TlZvU0s5MTA0enB6CmtnS2FUVmcrR0tZSEFJa1NZL3U2NU1zVmFTWk14bWVDSzdtTiswNU1w
 RUZCYW9uMG5sVTlRK0ZMRDFkRDBsenYKTVBkOEZOcEx4VEMxVDQwbXBVN0ZCV1hlVjZWRHoz
 STY5VkFBdjRWVDM4ZVZhYXBOS1lmVGdwcFRYVEVNYVdoTApVYUpGaU1HaFNYaGkrR01GV2Ji
 NVNFOGJJRTZ0WUpONWlYZUFNVFE4NjhYVGtHS0VHTjk3bEU2S09odmpWV0kxCkhiUVIzZ0tV
 ck1uVmlhbGp0YnV4bGNvS2YrblRvNG85OUEyTkprRCswaFozclJZTWhacFR1MitkcCt2Rm9p
 aEQKdVNFTCtoblZhNFRMd2pYd2gzNzNweU9XMFhra2E5YWpNTEFoMUFtMmRBa0pLSDhzMVlJ
 UUlpL2Q3bEkyYXQ1awpIcWtIa2p0YzE1ZkgrQUU5Q0VSM3RCSVNoYU9Fb0hXTXc0WEs5NS9n
 MWVnMVB1cmJmN3RwRnltcklxU3ppQjlvCjJBWituSHVDQ001ZC9pQXh5MmJOcndqNDhPM2Z5
 WXd1a0pManUyNlJKbzRMNStjNEJoTU1Ray9nVWROdldHK2YKNUxreVhvbHNMY0p0SktLdStD
 V1pFK1hxc2RGWHd2d2xDRVNSQ012cGZyQmNtY1hrT0g3S1JKVy9pUjFXVjVRZApjR3ZDcDl0
 a08vaEhSb2t0dzBibUl1MlFhZkovajZLTGJqZWV4cTc0TWUyb0U5YmkxY3B2azYvSElDV0JQ
 dHVYCnNqd2o1Q2M3UlZOMjJLekdZT0RKVGtxU0d4RjV1NVlkTHVNVG5CVGNweEphR2h3MzNq
 QjgwY3o3enFwQXBpREIKZFFnR2psVlNQT3ZidU04aXBPZDYKPW1nREMKLS0tLS1FTkQgUEdQ
 IFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=
Subject: Re: MCP2518FD Drivers Rarely Working with Custom Kernel 5.10.Y
Message-ID: <fe0a5628-e87f-6261-58c7-dbfccbb143a2@posteo.de>
Date:   Wed, 23 Jun 2021 20:07:27 +0000
MIME-Version: 1.0
In-Reply-To: <029101d76855$fa5ac300$ef104900$@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Am 23.06.21 um 19:34 schrieb Joshua Quesenberry:
> Hey!
> 
> I have attached config.txt so you all can see what I'm doing.
> 
> I added printing the error number as Marc suggested and the number appears to be -110 every time.
> 
> [   25.660006] CAN device driver interface
> [   25.668720] spi_master spi0: will run message pump with realtime priority
> [   25.676697] mcp251xfd spi0.1 can0: MCP2518FD rev0.0 (-RX_INT -MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz r:17.00MHz e:16.66MHz) successfully initialized.
> [   25.684900] mcp251xfd spi0.0 can1: MCP2518FD rev0.0 (-RX_INT -MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz r:17.00MHz e:16.66MHz) successfully initialized.
> [   28.098033] mcp251xfd spi0.1 rename4: renamed from can0
> [   28.175644] mcp251xfd spi0.0 can0: renamed from can1
> [   28.225891] mcp251xfd spi0.1 can1: renamed from rename4
> [  146.964971] mcp251xfd spi0.0: SPI transfer timed out
> [  146.965023] spi_master spi0: failed to transfer one message from queue (ret=-110)
> [  146.965216] mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c (length=4, data=00 00 00 00, CRC=0x0000) retrying.
> [  146.965247] mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c (length=4, data=00 00 00 00, CRC=0x0000) retrying.
> [  146.965277] mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c (length=4, data=00 00 00 00, CRC=0x0000) retrying.
> [  146.965286] mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c (length=4, data=00 00 00 00, CRC=0x0000).
> [  146.965331] mcp251xfd spi0.0 can0: CRC read error at address 0x0000 (length=4, data=00 00 00 00, CRC=0x0000) retrying.
> [  146.965360] mcp251xfd spi0.0 can0: CRC read error at address 0x0000 (length=4, data=00 00 00 00, CRC=0x0000) retrying.
> [  146.965389] mcp251xfd spi0.0 can0: CRC read error at address 0x0000 (length=4, data=00 00 00 00, CRC=0x0000) retrying.
> [  146.965397] mcp251xfd spi0.0 can0: CRC read error at address 0x0000 (length=4, data=00 00 00 00, CRC=0x0000).
> [  146.965413] A link change request failed with some changes committed already. Interface can0 may have been left with an inconsistent configuration, please check.
> 
> Regarding the discussion about Kconfig flags, I went ahead and rebuilt kernel 5.10.44 using a config that was essentially arch/arm/configs/bcm2711_defconfig with these additions needed to get our I2S working. This should have undone the switch to ONDEMAND governor and enabling 1000 Hz clock.
> 
> 1030a1031
>> CONFIG_SND_RPI_I2S_AUDIO_WM8782=m
> 1040a1042
>> CONFIG_SND_SOC_WM8782=m
> 
> My RPi and HAT have worked very reliably with the older buster image and customized (same tweaks as mentioned in last email) kernel 4.19.73, in that kernel I'm using MCP25XXFD driver from msperl which under 5.10.Y kernel is having issues too. I only upgraded everything on my system at the end of last week, so hardware has been OK very recently.
> 
> Keep in mind I'm not seeing a total failure, I do occasionally see everything work correctly and I can run the ip link setup command without issue, it's just not common and it seems fully removing power from the system and reapplying seems to help, but not every time, so maybe it's a coincidence. It could be an issue of subsequent configurations of the controller after the initial setup on power application, but I'd expect it work after every power yank I think.
> 
> I wouldn't feel comfortable reverting my /boot/config.txt to a stock one and a default setup of the 40-pin header, at least not with my HAT attached which includes the CAN controllers AND circuitry to supply power to RPi from a 12V rail.

OK,

one general advice.

Check if you can merge your HAT into a complete overlay with ovmerge
tool like I did in
https://github.com/raspberrypi/linux/issues/4032
https://github.com/raspberrypi/linux/pull/4034

This should clean up your config.txt quite a bit.

I compare against the seeed can fd hat v2 which also has i2c1 and both
can on spi0.

I'm not sure about the PI4 but these 3 items usually all go on i2c1
which may be problematic.

# typical combination out of raspi-config
dtparam=i2c_arm=on
dtparam=i2s=on

# some manual entry, check if it can be removed
dtoverlay=i2c1


The CAN related stuff looks ok, but you can omit the
oscillator=40000000,speed=20000000
Those are the standard values afaik.

# CAN 0/1
dtoverlay=spi0-cs
dtparam=cs0_pin=8
dtparam=cs1_pin=7

# CAN 0
dtoverlay=mcp251xfd,spi0-0,interrupt=24

# CAN 1
dtoverlay=mcp251xfd,spi0-1,interrupt=25


Concerning the naming, I also used generic names can0, can1 at first but
was advised to use best practice and to rename to mcp0, mcp1 instead. I
believe Marc mentioned that this causes some kind of problem.

This is my udev rule content.
SUBSYSTEM=="net", ACTION=="add",
DEVPATH=="/devices/platform/soc/*/*/*/spi0.0/net/can?", NAME="mcp0"
SUBSYSTEM=="net", ACTION=="add",
DEVPATH=="/devices/platform/soc/*/*/*/spi0.1/net/can?", NAME="mcp1"


Regards,
Patrick
