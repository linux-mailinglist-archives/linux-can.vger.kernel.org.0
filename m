Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DFB29569E
	for <lists+linux-can@lfdr.de>; Thu, 22 Oct 2020 05:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443674AbgJVDKV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Oct 2020 23:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442155AbgJVDKU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Oct 2020 23:10:20 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECB5C0613CE
        for <linux-can@vger.kernel.org>; Wed, 21 Oct 2020 20:10:18 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id l4so236350ota.7
        for <linux-can@vger.kernel.org>; Wed, 21 Oct 2020 20:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=hQzNRooklhPecgF7HTHOa9/G8bcmymxkgOB7iQ5Shek=;
        b=J1IJumiCx0jsRrAmqO2Hebv41xauwuQOM+xL9Nct82UUiUEjyVioFOg7Mt+OQxXZWj
         xIE67XhYuuLcb9KHTTJ7f43AmJMTOfvPJ9Lm1mOenAVXbUcKg4MzmqdS8cZMa3uUIuB4
         w8djOcZhTh/w7ESO770b70AGOyP9c3WsmKLRUyFLY0zAdU/jRe6QF/Bk+Zfkr8+QbNRP
         9B4ZG3IoBG8nP5ZWVumPC0Mgzu/zxlAEz93uC95JQbIGPZ2F4B+3iLPYHla+Gx+suVTy
         PGpDVrERwKu+QNZQoRp/+sbMZow4jUSvS4vNqXWoNB5RpmbbnNqEYGVv576fLrehghdz
         Gfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=hQzNRooklhPecgF7HTHOa9/G8bcmymxkgOB7iQ5Shek=;
        b=TVs7yPN+EuTrnhfsiH8yUH0C/ywtIjI2h21yvmHdmX8NaJB5ly4bIthHC69hJQ634C
         dqtB7RiNF8m9ef3oDFMiruVjDzZx+DXsBXr7HvexvqhSvELKkDnEQUgPNOgn669HNavd
         Itd54SUex9AyzZLpWUTAMPQIfk72algr/9xBOf4P0HsK8sE3Bgp8nIIn01ILl0o3vFoV
         VY9s6aZLOig4V0LYx2lVJLeo1NXPQk8FnEizabPSDtXCWP8GSmyXTdomaONKhcWNQK+n
         C6NcxiCJ2D/Yit3NWAfT285DdC6uh0ERbJovBmznsKimrrKgol6c4TGUR1TWLXs9nYd8
         cYEA==
X-Gm-Message-State: AOAM531oNxyPoetBddcYPO8RBXvtfA+Qgys2Wi6ynuiuhlv3bL+PvLL3
        /oPC+xh0NKR/4l5MIIW8/+2ZdEsvlgTimsx+V/95rtaiwVtmuw==
X-Google-Smtp-Source: ABdhPJxx9apJQ+twvPdcjE/AQoIo2NwNnISpuWvNmioObD/bQl6/ldDWV2pjSfTvPJPItkrO0kj0F9D4PjtOAKGUcNw=
X-Received: by 2002:a9d:649:: with SMTP id 67mr463550otn.233.1603336217815;
 Wed, 21 Oct 2020 20:10:17 -0700 (PDT)
MIME-Version: 1.0
From:   Drew Fustini <drew@beagleboard.org>
Date:   Wed, 21 Oct 2020 22:10:21 -0500
Message-ID: <CAPgEAj5eeN7Q9Hs7ZcrvaNCQJ7uW8kyNs3CPiVfQ=AEX9WeYoQ@mail.gmail.com>
Subject: mcp251xfd on RPi 5.4 downstream
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Josh S <josh@macchina.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc, thanks for working on mcp251xfd driver that has been pulled into 5=
.10.

I would like to use it with the official rpi-5.4.y branch [1] which
currently ships on their Raspberry Pi OS image.  The target board is a
Raspberry Pi 4 in 32-bit mode which uses bcm2711_defconfig [2]
according to their instructions [3].

I copied mcp251xfd from 5.10 and got this error when compiling:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  AR      drivers/net/can/spi/mcp251xfd/built-in.a
  CC [M]  drivers/net/can/spi/mcp251xfd/mcp251xfd-core.o
drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c: In function
=E2=80=98mcp251xfd_tx_ring_init_tx_obj=E2=80=99:
drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:314:23: error: request
for member =E2=80=98value=E2=80=99 in something not a structure or union
  xfer->cs_change_delay.value =3D 0;
                       ^
drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:315:23: error: request
for member =E2=80=98unit=E2=80=99 in something not a structure or union
  xfer->cs_change_delay.unit =3D SPI_DELAY_UNIT_NSECS;
                       ^
drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c: In function =E2=80=98mcp251=
xfd_probe=E2=80=99:
drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:2862:2: error: implicit
declaration of function =E2=80=98can_rx_offload_add_manual=E2=80=99
[-Werror=3Dimplicit-function-declaration]
  err =3D can_rx_offload_add_manual(ndev, &priv->offload,
  ^
cc1: some warnings being treated as errors
make[5]: *** [scripts/Makefile.build:266:
drivers/net/can/spi/mcp251xfd/mcp251xfd-core.o] Error 1
make[4]: *** [scripts/Makefile.build:500: drivers/net/can/spi/mcp251xfd] Er=
ror 2
make[3]: *** [scripts/Makefile.build:500: drivers/net/can/spi] Error 2
make[2]: *** [scripts/Makefile.build:500: drivers/net/can] Error 2
make[1]: *** [scripts/Makefile.build:500: drivers/net] Error 2
make: *** [Makefile:1732: drivers] Error 2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

I believe this is a result of 329f0dac4cad ("spi: make
`cs_change_delay` the first user of the `spi_delay` logic") where
integer values `cs_change_delay` and `cs_change_delay_unit` are
replaced with `struct spi_delay`.

I thought I would ask if you have any advice before I start making
incremental changes to get it to compile under 5.4.

thank you,
drew

[1] https://github.com/raspberrypi/linux/blob/rpi-5.4.y/
[2] https://github.com/raspberrypi/linux/blob/rpi-5.4.y/arch/arm/configs/bc=
m2711_defconfig
[3] https://www.raspberrypi.org/documentation/linux/kernel/building.md
