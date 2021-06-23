Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65A93B11FB
	for <lists+linux-can@lfdr.de>; Wed, 23 Jun 2021 04:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhFWDBi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Jun 2021 23:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFWDBh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Jun 2021 23:01:37 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE4CC061574
        for <linux-can@vger.kernel.org>; Tue, 22 Jun 2021 19:59:21 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id g19-20020a9d12930000b0290457fde18ad0so543655otg.1
        for <linux-can@vger.kernel.org>; Tue, 22 Jun 2021 19:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RV5jZZezH0E/ndRk77moiBo0jiD4miS++rhfLKwkzmw=;
        b=bjpLRjt5ZF7Q0w20FxfLZarcgiMXzBGwBa+piqkzFhZVMfhdSeuy7AgDqI661IqExq
         ojLiTqstTyvHPcZL0JN37ZJjJ+fQw6d03sUmf8BhGUqI750l6VBpNz+kLL4bmZwSJSlD
         sm4UPKz05mZlQn7AlDS7fGk+R1qmnIjMJn71Gj75yu6FIZqw08Ox2vl1bWmQJmGmgIZp
         j12sMhiwWmmGRpNGejfMweQ2jyCFj1gkSJI4hz+gl/Ip4/TFyX+qCGwkzfzXj8uKJYeb
         yBx2+fMTvk33nd/cQSDhDyn1OnDZTt0Iu7WMH1le90xHe1Ied/RvBcWLEQfLUwm0NSbJ
         M0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RV5jZZezH0E/ndRk77moiBo0jiD4miS++rhfLKwkzmw=;
        b=k2QS/+1NUcRIUOg4vCgVs4PqN0VlWwNmtCpl14/O37S1EWKPJL2pTnYz78ZwuJv7VN
         9ofdKDNiPhMN4DqxD3YQomQZK+vXO1ppKEJR+5TOsy4D91xE2CnJPwGA5i16lP9+Eplt
         ziDo83rKACxiQ+KMy7zRN76uTW7N55C/gsJ8BMF4gLqpzz2PscuD1XeHpEibKp8ngB7c
         MBvyoqFX7i1l2Hrm9VCtQJoG0LyXyjzt0eYzwmOih1ZTE0nPAikqWkI4CAbEUdLB545P
         cxoDQ9JmxZFOlHljehJPy5+PZEd9IFOsTZ3wBJTXPluBR+pfMMKM47YCbWkPQ07HwYFU
         plyw==
X-Gm-Message-State: AOAM532AjB7d8+jzP/blY2D9SiC6t9ahwCfpygs2Y8vnwfcCq060TqH4
        6SrUmQoIsx5pocI5/u9Z94ikrNHazV4nBlrrNxI=
X-Google-Smtp-Source: ABdhPJxHXcIU61NbVJhhml25zlBONDeZM/WCvI028JpY4SU6lqh43798YGhyiAQ6fq2upkCF7Ff3c1LV/EaAjaW1BSM=
X-Received: by 2002:a05:6830:821:: with SMTP id t1mr5894057ots.227.1624417160361;
 Tue, 22 Jun 2021 19:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <016701d7678c$2b3d50c0$81b7f240$@gmail.com> <20210622212818.enfx5fzgghfxfznb@pengutronix.de>
In-Reply-To: <20210622212818.enfx5fzgghfxfznb@pengutronix.de>
From:   Joshua Quesenberry <engnfrc@gmail.com>
Date:   Tue, 22 Jun 2021 22:59:09 -0400
Message-ID: <CAMGHUonufNF7CgAzcPkhgykxdYBtA+r5nY2i5xRGXN7Nxd5yMQ@mail.gmail.com>
Subject: Re: MCP2518FD Drivers Rarely Working with Custom Kernel 5.10.Y
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     kernel@pengutronix.de, linux-can@vger.kernel.org,
        Joshua Quesenberry <EngnFrc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thank you Marc, I had tried finding a Linux CAN forum, but
unfortunately searching for "CAN" in Google is about the most
unhelpful search term one could use... so thanks for replying and
getting me to a more appropriate audience.

Reverting my system back to where CAN was working will probably be
challenging. Our main goal was to get Boot from USB on the RPi
enabled, but this unfortunately meant upgrading every piece of
software and firmware available... previously we were still on Buster,
but the OS snapshot was from Spring 2020 (if not Fall/Winter 2019), if
not earlier, the firmware was much older, and the kernel was 4.19.73,
wherein the MCP251XFD driver didn't exist yet. So getting back there
will mean throwing a saved SD Card image on from Spring 2020 and then
trying to figure out how to force downgrade the firmware. A colleague
started this upgrade process for another project and was seeing these
same results on two separate RPi, he did the OS and firmware upgrades,
but I did the building of the 5.10.17 kernel. So including those two
RPi and mine, that's three total systems with mostly non-working CAN
where it had been working fine, my system has slightly newer RPi
firmware now and the 5.10.44 kernel, the hope was maybe I'd pick up a
patch somewhere, but no such luck. If you still think it would be
beneficial to go through the effort of downgrading everything to
verify the hardware I can do that, but just want to make sure before I
start that since it'll take a while.

I updated spi.c to include printing the error number as you requested
and that's all baking now. When I get into work in the morning (US
EST) I'll get the changes deployed and try it out. Since this issue is
a very high failure rate, getting a log shouldn't be an issue.

Some background on the custom kernel... when I switched to the 5.10.Y
branch, I used arch/arm/configs/bcm2711_defconfig as my base config
and then switched on preempt, switched to 1000Hz kernel timer,
switched the default governor from powersave to ondemand, switched on
debug flag (CONFIG_DEBUG_USER=y), enabled a few different CAN drivers
we may encounter, and enabled some stuff for the WM8782 I2S chip. I
probably should have recreated my config after 5.10.44, but I hadn't
considered till this writing, looking at this diff there a few bits
that are new I probably could benefit from including, but I don't see
anything that I'd be concerned about.

`diff bcm2711_defconfig hel_bcm2711_lowlatency_defconfig`
15d14
< CONFIG_ATA=m
43d41
< CONFIG_BH1750=m
53c51
< CONFIG_BLK_DEV_NVME=y
---
> CONFIG_BLK_DEV_NVME=m
120c118
< CONFIG_CAN_J1939=m
---
> CONFIG_CAN_KVASER_USB=m
123a122,123
> CONFIG_CAN_MCP25XXFD=m
> CONFIG_CAN_PEAK_USB=m
127d126
< CONFIG_CCS811=m
155c154
< CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=y
---
> CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
158,159c157
< CONFIG_CPU_FREQ_GOV_ONDEMAND=y
< CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
---
> CONFIG_CPU_FREQ_GOV_POWERSAVE=y
184a183
> CONFIG_DEBUG_USER=y
209d207
< CONFIG_DRM_PANEL_JDI_LT070ME05000=m
319a318
> CONFIG_GENERIC_PHY=y
325d323
< CONFIG_GPIO_PCA953X_IRQ=y
395a394
> CONFIG_HZ_1000=y
561d559
< CONFIG_IR_TOY=m
826d823
< CONFIG_NF_LOG_ARP=m
828d824
< CONFIG_NF_LOG_NETDEV=m
950c946
< CONFIG_PREEMPT_VOLUNTARY=y
---
> CONFIG_PREEMPT=y
957d952
< CONFIG_QCA7000_UART=m
994d988
< CONFIG_RPI_POE_POWER=m
1040a1035
> # CONFIG_RTC_HCTOSYS is not set
1044,1045d1038
< CONFIG_SATA_AHCI=m
< CONFIG_SATA_MV=m
1054d1046
< CONFIG_SENSIRION_SGP30=m
1134a1127
> CONFIG_SND_RPI_I2S_AUDIO_WM8782=m
1149a1143
> CONFIG_SND_SOC_WM8782=m

The /boot/config.txt I included in the forum posts mentioned is
tweaking the 40-pin header quite a bit from the default setup, we're
using many of the pins for our HAT and planned for possibly adding
more in the future.

Lastly, I've implemented UDEV rules so that SPI0.0 = can0 and SPI0.1 =
can1, I've done this in the past without it causing any issues and
don't think it's causing issues here, in fact I think I've tested with
the UDEV rule removed and things still didn't work, but felt it worth
mentioning just in case.

Thanks!

Josh Q

On Tue, Jun 22, 2021 at 5:28 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> Hey Joshua,
>
> On 22.06.2021 13:29:34, Joshua Quesenberry wrote:
> > I see you are a maintainer of the MCP251XFD driver? I am running into
> > issues where the driver doesn't work on an RPI4 with custom kernel
> > 5.10.17 or 5.10.44 and am wondering if you could take a look at one of
> > my ticket (cross posted in RPi and Linux forums) to see if anything
> > I'm running into is familiar and you may have some idea of a direction
> > to point me in?
>
> Feel free to use the linux-can mailing list (linux-can@vger.kernel.org -
> no HTML mail though) or open an issue on my github
> (https://github.com/marckleinebudde/linux/issues). Using the mailing
> list is preferred.
>
> You've written that your system was working with the old software. Can
> you restore the old kernel and check if it's still working. Just to be
> sure that the hardware is OK?
>
> | mcp251xfd spi0.1 can0: MCP2518FD rev0.0 (-RX_INT -MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz r:17.00MHz e:16.66MHz) successfully initialized.
> | mcp251xfd spi0.0 can1: MCP2518FD rev0.0 (-RX_INT -MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz r:17.00MHz e:16.66MHz) successfully initialized.
>
> These messages shows that the mcp2518fd was properly detected and that
> SPI communication with the is working.
>
> But then some SPI transfers fails:
> | spi_master spi0: failed to transfer one message from queue
>
> But the SPI framework doesn't print the error number, nor the raspi SPI
> driver does. Can you add the error number to the error message:
>
> https://elixir.bootlin.com/linux/v5.10.45/source/drivers/spi/spi.c#L1534
>
> e.g.:
>
> |               dev_err(&ctlr->dev,
> |                       "failed to transfer one message from queue (ret=%d)\n", ret);
>
> These error messages mean that the mcp251xfd driver read nothing (data
> is always 00) from the chip. This might be caused by the failed SPI
> transfer.
>
> | mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c (length=4, data=00 00 00 00, CRC=0x0000) retrying.
> | mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c (length=4, data=00 00 00 00, CRC=0x0000) retrying.
> | mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c (length=4, data=00 00 00 00, CRC=0x0000) retrying.
> | mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c (length=4, data=00 00 00 00, CRC=0x0000).
>
> I think the easiest way is to add the error number as mentioned above
> and reproduce the error. Answer to this mail and add the mailing list on
> Cc, don't forget to send a non HTML mail. :D
>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
