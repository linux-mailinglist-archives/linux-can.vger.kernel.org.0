Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D290490986
	for <lists+linux-can@lfdr.de>; Mon, 17 Jan 2022 14:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbiAQN1X (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Jan 2022 08:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbiAQN1X (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Jan 2022 08:27:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80904C061574
        for <linux-can@vger.kernel.org>; Mon, 17 Jan 2022 05:27:22 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n9S2b-0005bI-1h; Mon, 17 Jan 2022 14:27:21 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 416711A958;
        Mon, 17 Jan 2022 13:27:20 +0000 (UTC)
Date:   Mon, 17 Jan 2022 14:27:16 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Markus Mirevik <markus.mirevik@dpsolutions.se>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: MCP251xFD runs interrupt handler twice per message.
Message-ID: <20220117132716.y5q3vuayjgqhwpro@pengutronix.de>
References: <HE1PR04MB310066D557C9D77FE357D90AE6549@HE1PR04MB3100.eurprd04.prod.outlook.com>
 <87o84e1oj1.fsf@hardanger.blackshift.org>
 <HE1PR04MB3100B7CD240526C06FCA048EE6549@HE1PR04MB3100.eurprd04.prod.outlook.com>
 <20220116110941.6cqzm3skp57pnvth@pengutronix.de>
 <HE1PR04MB3100E5991C6FB420821F1F54E6579@HE1PR04MB3100.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="radlh4hdcrkf5vgf"
Content-Disposition: inline
In-Reply-To: <HE1PR04MB3100E5991C6FB420821F1F54E6579@HE1PR04MB3100.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--radlh4hdcrkf5vgf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.01.2022 11:55:31, Markus Mirevik wrote:
> > > > You mean mcp251xfd_irq() is started twice?
> > >
> > > Yes.
> >=20
> > That's not the way it's supposed to be. Maybe it's a limitation of the =
am335x
> > IRQ controller.
>=20
> What kind of limitation could that be?

Some kind of limitation of the hardware. Don't know, SoC may have all
kinds of bugs :)

[...]

> > > > Can you test again with IRQ_TYPE_LEVEL_LOW and no rx-int-gpios.
> > > > Please instrument the beginning and the returns of the
> > > > mcp251xfd_irq() function to check if it's really started twice.
> > > > Please print the
> > > > priv->regs_status.intf in every loop. Can you record the gpio2_5
> > > > priv->with a
> > > > scope.
> > >
> > > Yes I can but what do you mean with Instrument?
> >=20
> > That's a fancy way of saying: please add printk() :)
> >=20
> > > And no scope until Monday.
> >=20
> > no problem
> >=20
> > > > Make sure that you don't send any CAN frames as reaction of recepti=
on.
> > >
> > > How do I make sure of that? :/
> >=20
> > The Linux kernel doesn't send any CAN frames on its own. You need a user
> > space program to do so. Make sure you don't have any user space program
> > running that's sending CAN frames.
> >=20
>=20
> No user space program running that would send can frames. And no can fram=
es received on the other side. =20
>=20
> With IRQ_TYPE_LEVEL_LOW and the rx-int-gpios disabled I have added a
> call to netdev_info at the top of the function:

For better readability register values are usually printed in hex
(0x%08x).

> ...
>         netdev_info(priv->ndev, "mcp251xfd_irq mcp251xfd_regs_status.intf=
: %d", priv->regs_status.intf );

Note: the "intf" contains old information here, because in this run of
the interrupt handler the intf has not been read so far.

>         if (priv->rx_int) {
> ...
>=20
> and here:
> ...=20
>                if (!(intf_pending)) {
>                         netdev_info(priv->ndev, "!intf_pending mcp251xfd_=
regs_status.intf: %d", priv->regs_status.intf );
>                         return handled;
>                 }
>                 netdev_info(priv->ndev, "intf_pending mcp251xfd_regs_stat=
us.intf: %d", priv->regs_status.intf );
> ...
>=20
> Resulting in this when receiving one can message:=20
>=20
> [  987.486691] mcp251xfd spi1.1 can1: mcp251xfd_irq mcp251xfd_regs_status=
=2Eintf: -1088815100
> [  987.494987] mcp251xfd spi1.1 can1: intf_pending mcp251xfd_regs_status.=
intf:  -1088815098
> [  987.503239] mcp251xfd spi1.1 can1: !intf_pending mcp251xfd_regs_status=
=2Eintf: -1088815100

2nd loop starts here:

> [  987.511423] mcp251xfd spi1.1 can1: mcp251xfd_irq mcp251xfd_regs_status=
=2Eintf: -1088815100
> [  987.519603] mcp251xfd spi1.1 can1: !intf_pending mcp251xfd_regs_status=
=2Eintf: -1088815100
>=20
> mcp251xfd_regs_status.intf translated to binary=20
> 1	1111 1111 1111 1111 1111 1111 1111 1111 1011 1111 0001 1010 0000 0000 0=
000 0100
> 2	1111 1111 1111 1111 1111 1111 1111 1111 1011 1111 0001 1010 0000 0000 0=
000 0110
> 3	1111 1111 1111 1111 1111 1111 1111 1111 1011 1111 0001 1010 0000 0000 0=
000 0100

2nd loop starts here:

> 4	1111 1111 1111 1111 1111 1111 1111 1111 1011 1111 0001 1010 0000 0000 0=
000 0100
> 5	1111 1111 1111 1111 1111 1111 1111 1111 1011 1111 0001 1010 0000 0000 0=
000 0100
>=20
> I have also attached a scope picture, this is without the printouts.

good idea, the printk usually takes much time.

That scope picture looks good! Can you include both runs of the IRQ
handler in one scope picture? I'm interested if there is activity or a
glich on IRQ line.

After you've that picture, you can try to catch glitches on the IRQ
line. If your scope allows this, setup a trigger on the INT channel that
triggers if the channel is low for considerably less then it takes to
clear the IRQ.

Currently it takes about 160=C2=B5s to clear the IRQ, so setup a trigger for
less than 50=C2=B5s.

> And if I'm reading it correctly it confirms that it runs twice.=20

ACK

> 1 read pending IRQs [*]
> -RXIF-
> 2 read RX-FIFO level [*]
> 3 read RX'ed CAN frames [*]
> 4 and 5 mark RX'ed CAN frames as read [*]
> (This is the 5.10.79 version that uses regmap_update_bits which I
>  assume uses one read and one write instruction.)

ACK - in the CRC mode (which is default) the regmap_update_bits has not
been optimized, it does a read/modify/write.

> -loop-
> 6 read pending IRQs [*]
> -Exit-
> 7 read pending IRQs [*]
>=20
> Confirmd with printouts:
> [   26.990324] mcp251xfd spi1.1 can1: mcp251xfd_irq()
> [   26.995173] mcp251xfd spi1.1 can1: * Bulk read MCP251XFD_REG_INT
> [   27.001371] mcp251xfd spi1.1 can1: Interrupts pending, handling.
> [   27.007435] mcp251xfd spi1.1 can1: * Read RX MCP251XFD_REG_FIFOSTA
> [   27.013676] mcp251xfd spi1.1 can1: * Bulk read. Register: 1248 count: 5
> [   27.020226] mcp251xfd spi1.1 can1: * Update bits MCP251XFD_REG_FIFOCON=
_UINC
> [   27.027318] mcp251xfd spi1.1 can1: * Bulk read MCP251XFD_REG_INT
> [   27.033378] mcp251xfd spi1.1 can1: No interrupts pending, returning.
> [   27.039805] mcp251xfd spi1.1 can1: mcp251xfd_irq()
> [   27.044617] mcp251xfd spi1.1 can1: * Bulk read MCP251XFD_REG_INT
> [   27.050693] mcp251xfd spi1.1 can1: No interrupts pending, returning.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--radlh4hdcrkf5vgf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHlbrIACgkQqclaivrt
76mwvAf/V1ZsZO8PpDwmzoGYLDyTE5yVJiwpqBKmZnjjkrJNAwJNWl9Rqaa0mKaw
hMnzabkpV6y9tccUmRK6ObrNrMVwadzVgb+76Q9M8txaMr7VF+5vLW4nOXyZeYUQ
uYAIvkTgscIpJaLEdRmmrTwvUc0t43UYhqngOsNWP3JAYVMkbvjmxgyfnYCmfPZY
ZED929+jz0LiKKTI03vJ1ySNRXm8DIk402SO0HaarNJV5p2PHq8SzBrs2qvA4ORb
iW21fn3YxuFIr8YZRDDb3Tq8bGz6s/CuvCEtyTwVTUwTQt9il+KgnXYWy2A14bXu
VKGsIhesPbjCihEhXv8jO2A2I9+qNA==
=7Fu3
-----END PGP SIGNATURE-----

--radlh4hdcrkf5vgf--
