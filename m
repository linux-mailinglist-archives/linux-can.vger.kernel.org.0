Return-Path: <linux-can+bounces-1237-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD0B965FA7
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 12:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE8131C2116B
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 10:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D842D17BB03;
	Fri, 30 Aug 2024 10:53:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A8915C138
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015238; cv=none; b=YL1y+S6hqbOHJerv4iUhCit6smWAcEnu+rnaRgbVy/A4O64Lx7Rnuaq9M+MKKlQmeHaZryOXBiJUVtrHNo96QUk9FSfZWInXmqrA+4Xw56k7FHr09IfdRfD7j9udJA8h4bxGv9BkRwMQMM+YNUEOpaU0B7QIxwn38b+62CUtYzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015238; c=relaxed/simple;
	bh=l5JnedAhH5OoiWJvUtTkdSJL9+NuSoIpA7SU4wZtszU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqR8JaWnizt2kWtcJ5Oxuzkvvk5quMNxYuKKX+iGM/Tx2RrGkjeZGThB9W6YNa5wCaGzqOM0mYxUotmm10qzdb4quAAaGnK+OkoY2nYZVhYPurOxUmwGh9IDEp8O8+xARENQGBpA2J+b8nLTH1dPPfto2fGM1l7JhegfYAPA6dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjzGM-0003Jx-Fi; Fri, 30 Aug 2024 12:53:54 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjzGL-00489r-Ne; Fri, 30 Aug 2024 12:53:53 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6B80232DCF6;
	Fri, 30 Aug 2024 10:53:53 +0000 (UTC)
Date: Fri, 30 Aug 2024 12:53:53 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Martin =?utf-8?B?Sm9jacSH?= <martin.jocic@kvaser.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	Jimmy Assarsson <extja@kvaser.com>, "mailhol.vincent@wanadoo.fr" <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH] can: kvaser_pciefd: Use a single write when releasing RX
 buffers
Message-ID: <20240830-evasive-binturong-of-serenity-76c782-mkl@pengutronix.de>
References: <20240711135451.2736466-1-martin.jocic@kvaser.com>
 <20240805-mindful-unbiased-lobster-384ed9-mkl@pengutronix.de>
 <d092e2cf51c4b99355d729dd1612146a046a3373.camel@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g7v3vtatbla5wnft"
Content-Disposition: inline
In-Reply-To: <d092e2cf51c4b99355d729dd1612146a046a3373.camel@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--g7v3vtatbla5wnft
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.08.2024 14:18:31, Martin Joci=C4=87 wrote:
> On Mon, 2024-08-05 at 17:37 +0200, Marc Kleine-Budde wrote:
> > On 11.07.2024 15:54:51, Martin Jocic wrote:
> > > We should return from the ISR as fast as possible in order
> > > not to mask a new interrupt.
> >=20
> > Do you mean really mean "mask" new interrupts or "ACK" new interrupts?
> >=20
> > I'm not familiar with the hardware, but in several other IP cores the
> > driver first ACKs then IRQs then does the work. Is this an option here,
> > too?
> >=20
> > regards,
> > Marc
> >=20
> Sorry for the late answer, but I have been on vacation.
>=20
> Maybe I was unclear, what I meant by masking was that as I understand it,=
 the
> kernel won't issue a new call to an ISR for a specific interrupt until th=
e ISR
> has returned, thus effectively "masking" new identical interrupts.
>=20
> Kvaser's PCIe hardware uses the KCAN FPGA IP block which has dual 4K ping=
-pong
> buffers for incoming messages shared by all (currently up to eight) chann=
els.
> I.e. while the driver processes the messages in one buffer, new incoming
> messages are stored in the other and so on.
>=20
> The design of KCAN is such that a buffer must be fully read and then rele=
ased.
> Releasing a buffer will make the FPGA switch buffers. If the other buffer
> contains at least one new incoming message the FPGA will also instantly i=
ssue a
> new interrupt, if not the interrupt will be issued after receiving the fi=
rst new
> message.
>=20
> With IRQx interrupts, it takes a little time for the interrupt to happen,=
 enough
> for the ISR to do it's business and return, but MSI interrupts are way fa=
ster so
> this time is reduced to almost nothing. So with MSI, releasing the buffer=
 HAS to
> be the very last action of the ISR before returning, otherwise the new in=
terrupt
> may be "masked" by the kernel as described above. And the interrupts are =
edge-
> triggered so we cannot loose one, or the ping-pong reading process will s=
top.

Edge triggered IRQs are a pain. :(

> This is why the patch modifies the driver to use a single write to the SR=
B_CMD
> register to release the buffer(s) instead of possibly two writes as befor=
e.

Thanks for the explanation. Can you add some of this to the commit
message, so that it doesn't get lost?

> The interrupts can be (and are) reset by writing logical one bits to the =
IRQ
> registers if that is what you mean by ACKing. Regarding your reference to=
 other
> IP cores, I'm not quite sure what you mean. Are you suggesting some kind =
of top-
> half/bottom-half solution?

I was not aware that the IRQs are edge triggered. Other IP cores with
level triggered IRQs, the driver reads the IRQ register, ACKs the IRQs,
then handles them and exits the IRQ handler. If another IRQ comes after
ACK the IRQ handler is started again, due to the level nature of the IRQ
trigger.

> If so, I've tried various such variants in the hope of avoiding the "mask=
ing"
> problem to no avail (IIRC, it was before my vacation).
>=20
> However, as a side note, further tests with very high incoming message lo=
ads has
> shown that this patch, although improving the situation won't be enough.
> Therefore I'm preparing another patch which does the processing in a thre=
aded
> interrupt using a (limited) poll loop. But more on that later.

I'm looking forward for that patch.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--g7v3vtatbla5wnft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbRpL4ACgkQKDiiPnot
vG8Pygf/aOAzy7F1Tt63oFl4GrDYfV8O9wOvFNkY9FMTWkWRrlnXMjyCMtGws6fG
WO6m/KFawNbDGzKSeduZk95SULLQeK8IFlX73lkIh5g17JJ/7r0ZadFQIzZTU8V1
AwMSXZyO5Uab1dNpnBBKFqqU2MG9WEC76D9ttLR3FXHB7RiLh9wU6jj8SzhSbq9X
xX3CXAi7S0pk6HRGsMblVHZTKIscoGed48sq7mkJvK715hIKVjwZahJgRiH3+wOO
UMlgYo6Mek6VOshesfp84A4QD9xgpXFAl9hppY2bS4e6uI3TP+P5wQHUrUsfz9DA
yEefYIllbno0VgO7aBRYIM77NnakKQ==
=mRbH
-----END PGP SIGNATURE-----

--g7v3vtatbla5wnft--

