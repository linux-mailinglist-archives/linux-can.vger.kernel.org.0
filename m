Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93903B42FF
	for <lists+linux-can@lfdr.de>; Fri, 25 Jun 2021 14:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhFYMTP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 25 Jun 2021 08:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhFYMTO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Jun 2021 08:19:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4955C061574
        for <linux-can@vger.kernel.org>; Fri, 25 Jun 2021 05:16:53 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lwklP-0000xu-9r; Fri, 25 Jun 2021 14:16:51 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6633:1401:6bbf:57ef])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E10E7643869;
        Fri, 25 Jun 2021 12:16:49 +0000 (UTC)
Date:   Fri, 25 Jun 2021 14:16:48 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Joshua Quesenberry <engnfrc@gmail.com>
Cc:     'Patrick Menschel' <menschel.p@posteo.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org
Subject: Re: MCP2518FD Drivers Rarely Working with Custom Kernel 5.10.Y
Message-ID: <20210625121648.hg4hihfmddss7ptu@pengutronix.de>
References: <016701d7678c$2b3d50c0$81b7f240$@gmail.com>
 <20210622212818.enfx5fzgghfxfznb@pengutronix.de>
 <CAMGHUonufNF7CgAzcPkhgykxdYBtA+r5nY2i5xRGXN7Nxd5yMQ@mail.gmail.com>
 <2a99d742-b2dc-4411-acbb-2e23ce7cd132@posteo.de>
 <029101d76855$fa5ac300$ef104900$@gmail.com>
 <20210625065626.b7afwhptoyoxoblx@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kcpkgioq3tb4boeo"
Content-Disposition: inline
In-Reply-To: <20210625065626.b7afwhptoyoxoblx@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--kcpkgioq3tb4boeo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.06.2021 08:56:26, Marc Kleine-Budde wrote:
> On 23.06.2021 13:34:10, Joshua Quesenberry wrote:
> > I added printing the error number as Marc suggested and the number
> > appears to be -110 every time.
>=20
> #define	ETIMEDOUT	110	/* Connection timed out */
> https://elixir.bootlin.com/linux/latest/source/include/uapi/asm-generic/e=
rrno.h#L93
>=20
> That means something has timed out, we see this in the previous log
> message, too:
>=20
> > [   25.660006] CAN device driver interface
> > [   25.668720] spi_master spi0: will run message pump with realtime pri=
ority
> > [   25.676697] mcp251xfd spi0.1 can0: MCP2518FD rev0.0 (-RX_INT -MAB_NO=
_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz r:17.00MHz e:=
16.66MHz) successfully initialized.
> > [   25.684900] mcp251xfd spi0.0 can1: MCP2518FD rev0.0 (-RX_INT -MAB_NO=
_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz r:17.00MHz e:=
16.66MHz) successfully initialized.
> > [   28.098033] mcp251xfd spi0.1 rename4: renamed from can0
> > [   28.175644] mcp251xfd spi0.0 can0: renamed from can1
> > [   28.225891] mcp251xfd spi0.1 can1: renamed from rename4
>                                    VVVVVVVVVVVVVVVVVVVVVV
> > [  146.964971] mcp251xfd spi0.0: SPI transfer timed out
> > [  146.965023] spi_master spi0: failed to transfer one message from que=
ue (ret=3D-110)
>=20
> > [  146.965216] mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c =
(length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> > [  146.965247] mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c =
(length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> > [  146.965277] mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c =
(length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> > [  146.965286] mcp251xfd spi0.0 can0: CRC read error at address 0x0e0c =
(length=3D4, data=3D00 00 00 00, CRC=3D0x0000).
> > [  146.965331] mcp251xfd spi0.0 can0: CRC read error at address 0x0000 =
(length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> > [  146.965360] mcp251xfd spi0.0 can0: CRC read error at address 0x0000 =
(length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> > [  146.965389] mcp251xfd spi0.0 can0: CRC read error at address 0x0000 =
(length=3D4, data=3D00 00 00 00, CRC=3D0x0000) retrying.
> > [  146.965397] mcp251xfd spi0.0 can0: CRC read error at address 0x0000 =
(length=3D4, data=3D00 00 00 00, CRC=3D0x0000).
> > [  146.965413] A link change request failed with some changes committed=
 already. Interface can0 may have been left with an inconsistent configurat=
ion, please check.
> >=20
> > Regarding the discussion about Kconfig flags, I went ahead and rebuilt
> > kernel 5.10.44 using a config that was essentially
> > arch/arm/configs/bcm2711_defconfig with these additions needed to get
> > our I2S working. This should have undone the switch to ONDEMAND
> > governor and enabling 1000 Hz clock.
>=20
> Please switch back the clock to the standard HZ setting.

I compiled my 64 bit raspi kernel with HZ=3D1000 and my mcp2518fd board
works without problem on my raspi4b.

| static int bcm2835_spi_transfer_one_poll(struct spi_controller *ctlr,
| 					 struct spi_device *spi,
| 					 struct spi_transfer *tfr,
| 					 u32 cs)
| {
[...]
| 	/* set the timeout to at least 2 jiffies */
| 	timeout =3D jiffies + 2 + HZ * polling_limit_us / 1000000;

The timeout is calculated in jiffies. The jiffies variable is
incremented once per timer tick (which depends on the clock HZ
configuration). There are "HZ" jiffies per second. This means the above
"2" equals 8ms (HZ=3D250), but with HZ=3D1000 only 2ms.

To keep the timeout constant, you can change this into:

        timeout =3D jiffies + (HZ * 8) / 1000 + HZ * polling_limit_us / 100=
0000;

However, the polling mode will only be used for transfers that should
finish in 30 =C2=B5s. So even 2ms is far of...

|=20
| 	/* loop until finished the transfer */
| 	while (bs->rx_len) {
| 		/* fill in tx fifo with remaining data */
| 		bcm2835_wr_fifo(bs);
|=20
| 		/* read from fifo as much as possible */
| 		bcm2835_rd_fifo(bs);
|=20
| 		/* if there is still data pending to read
| 		 * then check the timeout
| 		 */
| 		if (bs->rx_len && time_after(jiffies, timeout)) {

If there is a timeout, the driver will fall back to IRQ mode.


Can you add a "#define DEBUG" in spi-bcm2835.c, even before the other
"#include" directives. That should give you this debug message:

| 			dev_dbg_ratelimited(&spi->dev,
| 					    "timeout period reached: jiffies: %lu remaining tx/rx: %d/%d - f=
alling back to interrupt mode\n",
| 					    jiffies - timeout,
| 					    bs->tx_len, bs->rx_len);
| 			/* fall back to interrupt mode */
|=20
| 			/* update usage statistics */
| 			bs->count_transfer_irq_after_polling++;
|=20
| 			return bcm2835_spi_transfer_one_irq(ctlr, spi,
| 							    tfr, cs, false);

here it activates the IRQ. But I'm not sure if the fallback works
correctly....

| 		}
| 	}
|=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--kcpkgioq3tb4boeo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDVyS4ACgkQqclaivrt
76meCwgAhMeef0V7WZ8S3Ikn84FMdsnxpQj4e7qJsWiMU7vdEGeKO+R4OaD5Zlt+
mJhuQCl8Tgn0EsrvbcBxft9LVZPdxR5A/KG2ghssCWEPqA6o+sUiNNAISMmUDZ8A
aZl2bJYhVNiwGy6VmtKrggS6g1YybPYfodECpLxsHQWZVxQ5lQWPJI64VPEiLF3V
Ez7aD/ltJ778XOvY9ztFHB1UFQt9zCAQBPXzpIyBRQ8uK043qqgu1cNiH2ukuhtF
tRQx8u7ZD9wH2wy73abs8rFf5FbC9AFFQfM2zXbuGczcuOsjHt1+5tzV5GB1oGIl
+wmXmS54ylVrBr90jaFRISU/emQkQA==
=4nmm
-----END PGP SIGNATURE-----

--kcpkgioq3tb4boeo--
