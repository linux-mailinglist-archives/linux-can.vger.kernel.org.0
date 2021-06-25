Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930853B3CD9
	for <lists+linux-can@lfdr.de>; Fri, 25 Jun 2021 08:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhFYG6w (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 25 Jun 2021 02:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhFYG6v (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Jun 2021 02:58:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88823C061574
        for <linux-can@vger.kernel.org>; Thu, 24 Jun 2021 23:56:31 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lwflN-0007M8-7Y; Fri, 25 Jun 2021 08:56:29 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6633:1401:6bbf:57ef])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id A182564344F;
        Fri, 25 Jun 2021 06:56:27 +0000 (UTC)
Date:   Fri, 25 Jun 2021 08:56:26 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Joshua Quesenberry <engnfrc@gmail.com>
Cc:     'Patrick Menschel' <menschel.p@posteo.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org
Subject: Re: MCP2518FD Drivers Rarely Working with Custom Kernel 5.10.Y
Message-ID: <20210625065626.b7afwhptoyoxoblx@pengutronix.de>
References: <016701d7678c$2b3d50c0$81b7f240$@gmail.com>
 <20210622212818.enfx5fzgghfxfznb@pengutronix.de>
 <CAMGHUonufNF7CgAzcPkhgykxdYBtA+r5nY2i5xRGXN7Nxd5yMQ@mail.gmail.com>
 <2a99d742-b2dc-4411-acbb-2e23ce7cd132@posteo.de>
 <029101d76855$fa5ac300$ef104900$@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m7uyiu6owgw2avzh"
Content-Disposition: inline
In-Reply-To: <029101d76855$fa5ac300$ef104900$@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--m7uyiu6owgw2avzh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23.06.2021 13:34:10, Joshua Quesenberry wrote:
> I added printing the error number as Marc suggested and the number
> appears to be -110 every time.

#define	ETIMEDOUT	110	/* Connection timed out */
https://elixir.bootlin.com/linux/latest/source/include/uapi/asm-generic/err=
no.h#L93

That means something has timed out, we see this in the previous log
message, too:

> [   25.660006] CAN device driver interface
> [   25.668720] spi_master spi0: will run message pump with realtime prior=
ity
> [   25.676697] mcp251xfd spi0.1 can0: MCP2518FD rev0.0 (-RX_INT -MAB_NO_W=
ARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz r:17.00MHz e:16=
=2E66MHz) successfully initialized.
> [   25.684900] mcp251xfd spi0.0 can1: MCP2518FD rev0.0 (-RX_INT -MAB_NO_W=
ARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz r:17.00MHz e:16=
=2E66MHz) successfully initialized.
> [   28.098033] mcp251xfd spi0.1 rename4: renamed from can0
> [   28.175644] mcp251xfd spi0.0 can0: renamed from can1
> [   28.225891] mcp251xfd spi0.1 can1: renamed from rename4
                                   VVVVVVVVVVVVVVVVVVVVVV
> [  146.964971] mcp251xfd spi0.0: SPI transfer timed out
> [  146.965023] spi_master spi0: failed to transfer one message from queue=
 (ret=3D-110)

> [  146.965216] mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c (l=
ength=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> [  146.965247] mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c (l=
ength=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> [  146.965277] mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c (l=
ength=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> [  146.965286] mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c (l=
ength=3D4, data=3D00 00 00 00, CRC=3D0x0000).
> [  146.965331] mcp251xfd spi0.0 can0: CRC read error at address 0x0000 (l=
ength=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> [  146.965360] mcp251xfd spi0.0 can0: CRC read error at address 0x0000 (l=
ength=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> [  146.965389] mcp251xfd spi0.0 can0: CRC read error at address 0x0000 (l=
ength=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> [  146.965397] mcp251xfd spi0.0 can0: CRC read error at address 0x0000 (l=
ength=3D4, data=3D00 00 00 00, CRC=3D0x0000).
> [  146.965413] A link change request failed with some changes committed a=
lready. Interface can0 may have been left with an inconsistent configuratio=
n, please check.
>=20
> Regarding the discussion about Kconfig flags, I went ahead and rebuilt
> kernel 5.10.44 using a config that was essentially
> arch/arm/configs/bcm2711_defconfig with these additions needed to get
> our I2S working. This should have undone the switch to ONDEMAND
> governor and enabling 1000 Hz clock.

Please switch back the clock to the standard HZ setting.

BTW: why have you changed the clock setting in the first place? All
timer (not timeout) code in Linux makes use of hrtimer, which run
independent of the clock HZ setting.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--m7uyiu6owgw2avzh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDVfhcACgkQqclaivrt
76niJwf7BUZjS9l9Fg7a3DTsrftDZvd/w1w5UXVq7UpgPKXXIishLRVyAbDPvcOC
8WKJoiP24IjxgKcCz2JetkXFAxZFH66OS7QWpZ01XBZHWRZPHCcmsRH8juLSEjcd
zV+vys7Zx7T6oIqf+D7L/GhFqoK+Tavv026dsQWdu+wq2xWxyn5jhkvasCf/Db43
mDqrDH5U/V6jNyzksJffI8ydTRyciHFaSbQeOYG0eIVaiYBLomN0d8hA3w9PqoWz
yXi/enY3R4Ielk309j2YIk/LyoOAhuVxSkNeAR8A2k02YJrOLYQXMdTKNR1ZsYKn
taHQYx5Pcg7ag3HRlxA9ajAkoIoQVg==
=SfXt
-----END PGP SIGNATURE-----

--m7uyiu6owgw2avzh--
