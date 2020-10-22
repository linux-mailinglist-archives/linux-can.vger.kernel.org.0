Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557B6295832
	for <lists+linux-can@lfdr.de>; Thu, 22 Oct 2020 08:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503159AbgJVGAT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Oct 2020 02:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503108AbgJVGAS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Oct 2020 02:00:18 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C24C0613CE
        for <linux-can@vger.kernel.org>; Wed, 21 Oct 2020 23:00:17 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id n15so487470otl.8
        for <linux-can@vger.kernel.org>; Wed, 21 Oct 2020 23:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lZy23MusJplsjobaSUkwu3mdO5smGrrv9eXjXFVCi/Q=;
        b=eW52E6bEMM3cVNzxlXH8Wsnry80B9dk+ySRJsFGccHCmFr19AO+buUZHuG/t2ndSps
         Iw3hfc6bBGs9FZ4pQvU/v5QSnUI1wLj8ruzHBhtaCopdlFOrytFD+F9pDbl7Y13IJJw1
         XKaatnUw2GA2iukj+DUrVje3BjVVriyoCMF8pw1X/kjTK43NnqD7s1wLA7NOnHG6s2Kb
         0niICIUg0vIigGUU6QEahNQic/W8vT04a36PYrUszEjGv8I2VXx34CzRTDGEIup0PEBs
         qDixi/xShqzRCGCcc74Zhrt4N5bAbQaAA5Py2TCT2Ud9IcJfRc1FEJi5VOKKXYDdUH9+
         29SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lZy23MusJplsjobaSUkwu3mdO5smGrrv9eXjXFVCi/Q=;
        b=I9+sYmFRxfjtHij19+TXsElT9rpUlz4AR9ujcYUoWiL72eaZpzbYS+eQxPdUf1uBql
         9Fmi96RKpkjfx+bzghzcP6XTJg/SYEIXpuVwMuSvVvedDByr1ZfSvgwjQCU7AiLXHmAy
         mAE3GIHiymDgXiTKuRdrYHWwubQLS5zgWmKIJfgt2HIp5HJNjF4PT86sleu76etlOhym
         Qbh+88UiVuOpJlJCs00n/ekKqLD9r0lKRvAU6+bTepdMvJXkZGjZ9IIbwSDL0cJdQIyU
         LgDjdYDoOpY30xMY/py/OdqjfMAj3+k8/y3wzxW4egA0DMhBbi7CKu1O79RvRkS1tEzm
         sJjA==
X-Gm-Message-State: AOAM530IBMrVY1pi9z7w4edtBxfBtTgJjQTnf6Ht+U9x3ParuRyGrRlv
        ovd8eE72XBlB/LNNadoiwu/AZg/lAYgeMF/VYpCo6xSo0faFcw==
X-Google-Smtp-Source: ABdhPJyCQvCkKJTNLlVMgSw/nKVehWrKFQv7HWeje8jOdWcJxGMGC5QT603tdc/Jhh4Uy7D1xbOddzObzN/OLy7GLds=
X-Received: by 2002:a05:6830:22eb:: with SMTP id t11mr800197otc.114.1603346416394;
 Wed, 21 Oct 2020 23:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAPgEAj5eeN7Q9Hs7ZcrvaNCQJ7uW8kyNs3CPiVfQ=AEX9WeYoQ@mail.gmail.com>
In-Reply-To: <CAPgEAj5eeN7Q9Hs7ZcrvaNCQJ7uW8kyNs3CPiVfQ=AEX9WeYoQ@mail.gmail.com>
From:   Drew Fustini <drew@beagleboard.org>
Date:   Thu, 22 Oct 2020 01:00:20 -0500
Message-ID: <CAPgEAj5HwFUTqhbgZ2Y5Db-_PPHNN7Rc8dnp1s+TBBALf5EwSw@mail.gmail.com>
Subject: Re: mcp251xfd on RPi 5.4 downstream
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Josh S <josh@macchina.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Oct 21, 2020 at 10:10 PM Drew Fustini <drew@beagleboard.org> wrote:
>
> Hi Marc, thanks for working on mcp251xfd driver that has been pulled into=
 5.10.
>
> I would like to use it with the official rpi-5.4.y branch [1] which
> currently ships on their Raspberry Pi OS image.  The target board is a
> Raspberry Pi 4 in 32-bit mode which uses bcm2711_defconfig [2]
> according to their instructions [3].
>
> I copied mcp251xfd from 5.10 and got this error when compiling:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>   AR      drivers/net/can/spi/mcp251xfd/built-in.a
>   CC [M]  drivers/net/can/spi/mcp251xfd/mcp251xfd-core.o
> drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c: In function
> =E2=80=98mcp251xfd_tx_ring_init_tx_obj=E2=80=99:
> drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:314:23: error: request
> for member =E2=80=98value=E2=80=99 in something not a structure or union
>   xfer->cs_change_delay.value =3D 0;
>                        ^
> drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:315:23: error: request
> for member =E2=80=98unit=E2=80=99 in something not a structure or union
>   xfer->cs_change_delay.unit =3D SPI_DELAY_UNIT_NSECS;
>                        ^
> drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c: In function =E2=80=98mcp2=
51xfd_probe=E2=80=99:
> drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:2862:2: error: implicit
> declaration of function =E2=80=98can_rx_offload_add_manual=E2=80=99
> [-Werror=3Dimplicit-function-declaration]
>   err =3D can_rx_offload_add_manual(ndev, &priv->offload,
>   ^
> cc1: some warnings being treated as errors
> make[5]: *** [scripts/Makefile.build:266:
> drivers/net/can/spi/mcp251xfd/mcp251xfd-core.o] Error 1
> make[4]: *** [scripts/Makefile.build:500: drivers/net/can/spi/mcp251xfd] =
Error 2
> make[3]: *** [scripts/Makefile.build:500: drivers/net/can/spi] Error 2
> make[2]: *** [scripts/Makefile.build:500: drivers/net/can] Error 2
> make[1]: *** [scripts/Makefile.build:500: drivers/net] Error 2
> make: *** [Makefile:1732: drivers] Error 2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>
> I believe this is a result of 329f0dac4cad ("spi: make
> `cs_change_delay` the first user of the `spi_delay` logic") where
> integer values `cs_change_delay` and `cs_change_delay_unit` are
> replaced with `struct spi_delay`.
>
> I thought I would ask if you have any advice before I start making
> incremental changes to get it to compile under 5.4.
>
> thank you,
> drew
>
> [1] https://github.com/raspberrypi/linux/blob/rpi-5.4.y/
> [2] https://github.com/raspberrypi/linux/blob/rpi-5.4.y/arch/arm/configs/=
bcm2711_defconfig
> [3] https://www.raspberrypi.org/documentation/linux/kernel/building.md

It appears it was simpler to get it to compile than I expected.

cs_change_delay.unit becomes cs_change_delay_unit,  and
cs_change_delay.value becomes cs_change_delay.

The other issue was 728fc9ff73d3 ("can: rx-offload:
can_rx_offload_add_manual(): add new initialization function") which
was simply solved by adding can_rx_offload_add_manual() to:
include/linux/can/rx-offload.h
drivers/net/can/rx-offload.c

The driver builds ok:

filename:
/home/pdp7/dev/rpi/linux/./drivers/net/can/spi/mcp251xfd/mcp251xfd.ko
license:        GPL v2
description:    Microchip MCP251xFD Family CAN controller driver
author:         Marc Kleine-Budde <mkl@pengutronix.de>
srcversion:     336E42AD62992352D5E583E
alias:          spi:mcp251xfd
alias:          spi:mcp2518fd
alias:          spi:mcp2517fd
alias:          of:N*T*Cmicrochip,mcp251xfdC*
alias:          of:N*T*Cmicrochip,mcp251xfd
alias:          of:N*T*Cmicrochip,mcp2518fdC*
alias:          of:N*T*Cmicrochip,mcp2518fd
alias:          of:N*T*Cmicrochip,mcp2517fdC*
alias:          of:N*T*Cmicrochip,mcp2517fd
depends:        can-dev
intree:         Y
name:           mcp251xfd
vermagic:       5.4.72-v7l+ SMP mod_unload modversions ARMv7 p2v8

thanks,
drew
