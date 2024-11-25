Return-Path: <linux-can+bounces-2210-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EDC9D84E7
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2024 12:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 371FDB348F1
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2024 11:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F143F1922D3;
	Mon, 25 Nov 2024 11:01:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26D91632F6
	for <linux-can@vger.kernel.org>; Mon, 25 Nov 2024 11:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732532488; cv=none; b=juEdEyrOsZaYrh/NEizHvoOoryQjK86fb/X6RMFApzOzZbxg5HcF09nyg7LvDdkDDtY6MHFUXzEEs/YqSqxG7hFhVVw3vTZPwjXVCGy1OT0LzD9mhbBwJTulqm1YjErwhoBM2YGN/Rrr+K0Kj1ohdLenwbJf93ZRCUYZgvVQkT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732532488; c=relaxed/simple;
	bh=fQFb0FzkSHnYew6nNRWgK8C7euJhbHRbWDKbrWdFutA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4v3Q1qZWPzrrXtjWVVWmw9KgRvEk/qDMF7aHXJdGUxgYuHwYmLfx2BNOYHNLsJsQS8MSp7cD6LMpwj0b8Wok9z8e50LzgoDHZboENenGexYm87V7SI7Gbjm0F4xVgtTRupyGMTSFh7hqAxgZ5CbFNDhKn9jbdtqUxQMuTWt4+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFWqI-0006Eq-R0; Mon, 25 Nov 2024 12:01:22 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFWqH-00048m-2K;
	Mon, 25 Nov 2024 12:01:22 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3C01637CBA0;
	Mon, 25 Nov 2024 11:01:22 +0000 (UTC)
Date: Mon, 25 Nov 2024 12:01:21 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
	mailhol.vincent@wanadoo.fr, manivannan.sadhasivam@linaro.org, schuchmann@schleissheimer.de, 
	thomas.kopp@microchip.com
Subject: Re: AW: [PATCH RFC can v2] can: mcp251xfd: mcp251xfd_get_tef_len():
 fix length calculation
Message-ID: <20241124-fervent-unyielding-macaw-1c66fb-mkl@pengutronix.de>
References: <20241104-ludicrous-quartz-kakapo-07219e-mkl@pengutronix.de>
 <20241105082801.32475-1-renjaya.zenta@formulatrix.com>
 <20241105-crazy-petrel-of-tempering-cb8f6f-mkl@pengutronix.de>
 <CAJ7t6HhXEMhpmLVh3E14iWZJ0wMaG2ECxYoe_xTYB9mXAdBd9w@mail.gmail.com>
 <20241105-masked-laughing-vulture-2e403e-mkl@pengutronix.de>
 <CAJ7t6HgaeQ3a_OtfszezU=zB-FqiZXqrnATJ3UujNoQJJf7GgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="avr5mq53athnnzul"
Content-Disposition: inline
In-Reply-To: <CAJ7t6HgaeQ3a_OtfszezU=zB-FqiZXqrnATJ3UujNoQJJf7GgA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--avr5mq53athnnzul
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: AW: [PATCH RFC can v2] can: mcp251xfd: mcp251xfd_get_tef_len():
 fix length calculation
MIME-Version: 1.0

On 05.11.2024 18:53:49, Renjaya Raga Zenta wrote:
> > Please add this patch, compile, reproduce the issue, send me the
> > devcoredump and the log output.
>=20
> > >
> > --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
> > +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
> > @@ -149,6 +149,10 @@ mcp251xfd_get_tef_len(struct mcp251xfd_priv *priv,=
 u8 *len_p)
> >          len =3D (chip_tx_tail << shift) - (tail << shift);
> >          *len_p =3D len >> shift;
> >
> > +        if (*len_p =3D=3D 0)
> > +                netdev_err(priv->ndev, "%s: fifo_sta=3D0x%08x head=3D0=
x%08x tail=3D0x%08x\n", __func__,
> > +                           fifo_sta, tx_ring->head, tx_ring->tail);
> > +
> >          return 0;
> >  }
>=20
> I applied this patch manually because it couldn't be applied after your
> "mcp251xfd_get_tef_len(): fix length calculation" patch.
>=20
> The log (dmesg | grep spi)
> [  125.501493] mcp251xfd spi0.0 can1: mcp251xfd_get_tef_len: fifo_sta=3D0=
x00000103 head=3D0x00004a95 tail=3D0x00004a91
> [  125.511420] mcp251xfd spi0.0 can1: IRQ handler mcp251xfd_handle_tefif(=
) returned -22.
> [  125.519250] mcp251xfd spi0.0 can1: IRQ handler returned -22 (intf=3D0x=
bf1a0010).
>=20
> The devcoredump file is attached.

To me it seems the TX-FIFO STA register is not consistent at this point,
this is likely another manifestation of the mcp2518fd erratum
DS80000789E 6.

The TX-FIFO and the Transmit Event FIFO (TEF) are implemented as ring
buffers in hardware. They work on a buffer in the chip's memory, with a
head and tail index.

=46rom the driver's point of view the TX-queue is full, the TX-FIFO with
depth 4 is completely filled, the head and tail indexes have a
difference of 4 (head=3D0x00004a95 tail=3D0x00004a91). The driver is waiting
for TX complete events.

Here, the chip has successfully send at least 1 CAN frame, puts that
information in the Transmit Event FIFO (TEF) and rises a TX Event FIFO
not empty interrupt.

The driver handles this interrupt in the mcp251xfd_handle_tefif()
function. It reads the TX-FIFO STA register (sic! TX-FIFO) and tries to
figure out the fill level of the TEF. (Note: The RX-FIFO has head
index in the STA register, the TEF, doesn't.)

The trick to figure out the fill level of the TEF, is to look at the
tail index of the TX FIFO. The tail index is the next CAN frame that
the chip will send. The driver assumes that all CAN frames before that
have been send. This means the TX-tail index should equal the TEF-head
index. The difference between the TEF-head and TEF-tail would be the
fill level of the TEF.

According to the debug message, the TX-FIFO STA register shows a TX tail
index of 1 and the other bits show that the TX FIFO is _not_ empty.

Looking at the driver's version of the TX indexes:

| head=3D0x00004a95
| tail=3D0x00004a91

With the here configured FIFO depth of 4, both indexes would be "1" in
hardware. This means the TX-FIFO could either be full or empty. "TX-FIFO
full" makes no sense, as the driver is right now handling the "TEF not
empty" interrupt. (In order to have an event in the TEF, a CAN frame
must have been send, so the TX-FIFO cannot be full.)

But the bits in the TX-FIFO STA also tell us the TX-FIFO is not empty
either (TFERFFIF is not set).

=46rom the debug message:

|          fifosta      =3D0x00000103=20
|           FIFOCI =3D   1		FIFO Message Index
|         TFERFFIF    		Transmit/Receive FIFO Empty/Full Interrupt Flag
|         TFHRFHIF   x		Transmit/Receive FIFO Half Empty/Half Full Interrup=
t Flag
|         TFNRFNIF   x		Transmit/Receive FIFO Not Full/Not Empty Interrupt =
Flag

This is inconsistent and the driver bails out. Then it creates a dump of
the registers:

| FIFOSTA: fifosta(0x078)=3D0x00000107
|           FIFOCI =3D   1		FIFO Message Index
|         TFERFFIF   x		Transmit/Receive FIFO Empty/Full Interrupt Flag
|         TFHRFHIF   x		Transmit/Receive FIFO Half Empty/Half Full Interrup=
t Flag
|         TFNRFNIF   x		Transmit/Receive FIFO Not Full/Not Empty Interrupt =
Flag

We see that the TFERFFIF _is_ set. Note: It takes some time between the
initial read of the TX-FIFO STA and the reading of the TX-FIFO STA
register for the dump.

I've just send a patch [1] to work around this issue. However not
tested, as I cannot reproduce the problem here.

[1] https://patch.msgid.link/20241125-mcp251xfd-fix-length-calculation-v1-1=
-974445b5f893@pengutronix.de

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--avr5mq53athnnzul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdEWP0ACgkQKDiiPnot
vG9MKwf/RTbXU0QdUK5TOwZbwwEsBkmrzEqZUog6o8QP2BM8k5ENnMvY1c5TcJBa
Q2iYpSE6S1/OqGqrtYrv13lMZ6+mhmYdz9h8tP7CTTN6MlzCePakezBrykWoV01a
JxZRL2q9YrdCLmOlvG2HVDMp5/0aZ23c0nVO6UANLFydza6GR5WMxW8Cv9JTdj+I
mVVTCzkZ+UsUbcChNGoJqItlooFuUNS9EAMPKbNnTgAd0WZU8ZCfuW1ugAYB4rqG
9SsZYZzNoPQ0x+JYEgffyLZvA3J1JgJ4awJJQsdDET+kT7hkKd9NYvJm9FWg7Z4l
/Woht87fxe6koc58fuiTdfFsztTtjA==
=awBx
-----END PGP SIGNATURE-----

--avr5mq53athnnzul--

