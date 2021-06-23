Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD1A3B1332
	for <lists+linux-can@lfdr.de>; Wed, 23 Jun 2021 07:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhFWF0l (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Jun 2021 01:26:41 -0400
Received: from mout02.posteo.de ([185.67.36.66]:33277 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhFWF0l (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 23 Jun 2021 01:26:41 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 206592400E5
        for <linux-can@vger.kernel.org>; Wed, 23 Jun 2021 07:24:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1624425863; bh=gAWAxgPp0R3SAgL9+PwM9Pr1hlGsCAdIAhRpV7seitU=;
        h=To:Cc:From:Autocrypt:Subject:Date:From;
        b=PEnTswutK0mDzlnLRwIOCp8w82eYFUZ0sGoC9DJmnjD97iY1rCkFy6ZSV7rsHgs6s
         H5iJddrdW7JPNCmwbO4yo2rL1+Gxv1u1r1zrEMLGdHT6iy34AL0TgWm3OKZdgc9jxx
         XWupwG437GPF9fWUP7ezjbMBFdZei5Srr4/TuYnpPPcrByzxkNL8mo6qldidO7I0Qv
         0VR49tyJBHiVGjmp22WyH+uZqgRKu4cu9bDpcj7hrduPksTSUJIG2Rj9+Qf19jhxKb
         I9N8Wa4C0NobUlNLWTkH6zBmcRTn81ODxL+XoMucjmTpwgYd3Ap/dKn18D8/Mgv1CA
         8kqdBCJXwb6KA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4G8sBt2MjRz6tmG;
        Wed, 23 Jun 2021 07:24:22 +0200 (CEST)
To:     Joshua Quesenberry <engnfrc@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     kernel@pengutronix.de, linux-can@vger.kernel.org
References: <016701d7678c$2b3d50c0$81b7f240$@gmail.com>
 <20210622212818.enfx5fzgghfxfznb@pengutronix.de>
 <CAMGHUonufNF7CgAzcPkhgykxdYBtA+r5nY2i5xRGXN7Nxd5yMQ@mail.gmail.com>
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
Message-ID: <2a99d742-b2dc-4411-acbb-2e23ce7cd132@posteo.de>
Date:   Wed, 23 Jun 2021 05:24:21 +0000
MIME-Version: 1.0
In-Reply-To: <CAMGHUonufNF7CgAzcPkhgykxdYBtA+r5nY2i5xRGXN7Nxd5yMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Am 23.06.21 um 04:59 schrieb Joshua Quesenberry:
> Thank you Marc, I had tried finding a Linux CAN forum, but
> unfortunately searching for "CAN" in Google is about the most
> unhelpful search term one could use... so thanks for replying and
> getting me to a more appropriate audience.
> 
> Reverting my system back to where CAN was working will probably be
> challenging. Our main goal was to get Boot from USB on the RPi
> enabled, but this unfortunately meant upgrading every piece of
> software and firmware available... previously we were still on Buster,
> but the OS snapshot was from Spring 2020 (if not Fall/Winter 2019), if
> not earlier, the firmware was much older, and the kernel was 4.19.73,
> wherein the MCP251XFD driver didn't exist yet. So getting back there
> will mean throwing a saved SD Card image on from Spring 2020 and then
> trying to figure out how to force downgrade the firmware. A colleague
> started this upgrade process for another project and was seeing these
> same results on two separate RPi, he did the OS and firmware upgrades,
> but I did the building of the 5.10.17 kernel. So including those two
> RPi and mine, that's three total systems with mostly non-working CAN
> where it had been working fine, my system has slightly newer RPi
> firmware now and the 5.10.44 kernel, the hope was maybe I'd pick up a
> patch somewhere, but no such luck. If you still think it would be
> beneficial to go through the effort of downgrading everything to
> verify the hardware I can do that, but just want to make sure before I
> start that since it'll take a while.
> 
> I updated spi.c to include printing the error number as you requested
> and that's all baking now. When I get into work in the morning (US
> EST) I'll get the changes deployed and try it out. Since this issue is
> a very high failure rate, getting a log shouldn't be an issue.
> 
> Some background on the custom kernel... when I switched to the 5.10.Y
> branch, I used arch/arm/configs/bcm2711_defconfig as my base config
> and then switched on preempt, switched to 1000Hz kernel timer,
> switched the default governor from powersave to ondemand, switched on
> debug flag (CONFIG_DEBUG_USER=y), enabled a few different CAN drivers
> we may encounter, and enabled some stuff for the WM8782 I2S chip. I
> probably should have recreated my config after 5.10.44, but I hadn't
> considered till this writing, looking at this diff there a few bits
> that are new I probably could benefit from including, but I don't see
> anything that I'd be concerned about.
> 
> `diff bcm2711_defconfig hel_bcm2711_lowlatency_defconfig`
> 15d14
> < CONFIG_ATA=m
> 43d41
> < CONFIG_BH1750=m
> 53c51
> < CONFIG_BLK_DEV_NVME=y
> ---
>> CONFIG_BLK_DEV_NVME=m
> 120c118
> < CONFIG_CAN_J1939=m
> ---
>> CONFIG_CAN_KVASER_USB=m
> 123a122,123
>> CONFIG_CAN_MCP25XXFD=m
>> CONFIG_CAN_PEAK_USB=m
> 127d126
> < CONFIG_CCS811=m
> 155c154
> < CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=y
> ---
>> CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
> 158,159c157
> < CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> < CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> ---
>> CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> 184a183
>> CONFIG_DEBUG_USER=y
> 209d207
> < CONFIG_DRM_PANEL_JDI_LT070ME05000=m
> 319a318
>> CONFIG_GENERIC_PHY=y
> 325d323
> < CONFIG_GPIO_PCA953X_IRQ=y
> 395a394
>> CONFIG_HZ_1000=y
> 561d559
> < CONFIG_IR_TOY=m
> 826d823
> < CONFIG_NF_LOG_ARP=m
> 828d824
> < CONFIG_NF_LOG_NETDEV=m
> 950c946
> < CONFIG_PREEMPT_VOLUNTARY=y
> ---
>> CONFIG_PREEMPT=y
> 957d952
> < CONFIG_QCA7000_UART=m
> 994d988
> < CONFIG_RPI_POE_POWER=m
> 1040a1035
>> # CONFIG_RTC_HCTOSYS is not set
> 1044,1045d1038
> < CONFIG_SATA_AHCI=m
> < CONFIG_SATA_MV=m
> 1054d1046
> < CONFIG_SENSIRION_SGP30=m
> 1134a1127
>> CONFIG_SND_RPI_I2S_AUDIO_WM8782=m
> 1149a1143
>> CONFIG_SND_SOC_WM8782=m
> 
> The /boot/config.txt I included in the forum posts mentioned is
> tweaking the 40-pin header quite a bit from the default setup, we're
> using many of the pins for our HAT and planned for possibly adding
> more in the future.

Hi,

it would help to find a reference to that config.txt .

Regarding the changed Kconfig flags, I would suspect everything that
owns a =y to be the culprit, especially everything that has connections
to a clock.
Ever since the first rpi3, clocks are unreliable in general due to the
frequency governor. The rpi guys did there best to get rid of most of
the initial problems but the root cause remains.

The interesting question is, does a stock raspbian buster work with your
hardware and that config.txt?

I'm running a stock raspbian buster on a rpi3b+ with seeed can fd hat v2
24/7 for a couple of month now and did not expierence any problems.

Regards,
Patrick
