Return-Path: <linux-can+bounces-793-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1972191012D
	for <lists+linux-can@lfdr.de>; Thu, 20 Jun 2024 12:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A343A283DAA
	for <lists+linux-can@lfdr.de>; Thu, 20 Jun 2024 10:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A559C1A4F2B;
	Thu, 20 Jun 2024 10:09:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A671A8C01
	for <linux-can@vger.kernel.org>; Thu, 20 Jun 2024 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878175; cv=none; b=AkP8P2YIaAK2O5aw/u6RUf++Opx45HZoKpB4kUAdu4ZRwDZAsbErF9OUAcis6oC59uCBz3M93EEMnaj8MbxnYSZo7dAfycyagN97cf8ymtVAhP9+bru5M1274+oOO1kyScQEiSh16kOven0ZDOLZk/SFXoqXnqcO4G96XNrbLYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878175; c=relaxed/simple;
	bh=R4DTmVJY/o7xYgtnlHZblY5TyuJsXmDUy5NZ3VOpf+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjxLkxfJjyo1dGABGmBMyYQmYUlEF66c9b+imwL3r2cM+6QWSSav5VvkwS7asoRcs8lzBVJDxCr+ZFs8wqFOLr/Ie7jkkeZvlPbcKTGwlElxGmb5ABTkY3OiSphnfv8ZFXcJhpk4FPh5OmRfk042Mv9mJKAWaz6TN1sd+vKplGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKEjR-0003nP-2y; Thu, 20 Jun 2024 12:09:29 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKEjQ-003g5A-Ke; Thu, 20 Jun 2024 12:09:28 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 569F32ED87D;
	Thu, 20 Jun 2024 10:09:28 +0000 (UTC)
Date: Thu, 20 Jun 2024 12:09:28 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Martin Jocic <martin.jocic@kvaser.com>
Cc: linux-can@vger.kernel.org, mailhol.vincent@wanadoo.fr, 
	extja@kvaser.com
Subject: Re: [PATCH 2/2] can: kvaser_pciefd: Add MSI interrupts
Message-ID: <20240620-roaring-numbat-of-advance-9ba160-mkl@pengutronix.de>
References: <20240614152008.2730746-1-martin.jocic@kvaser.com>
 <20240614152008.2730746-3-martin.jocic@kvaser.com>
 <20240620-stylish-harrier-of-development-29f6c9-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xrn6ia6lbi53cs5c"
Content-Disposition: inline
In-Reply-To: <20240620-stylish-harrier-of-development-29f6c9-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--xrn6ia6lbi53cs5c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.06.2024 12:05:33, Marc Kleine-Budde wrote:
> On 14.06.2024 17:20:08, Martin Jocic wrote:
> > Use MSI interrupts with fallback to legacy interrupts.
>=20
> Thanks for your patches, but this fails to build on current net-next.
>=20
> | drivers/net/can/kvaser_pciefd.c: In function =E2=80=98kvaser_pciefd_pro=
be=E2=80=99:
> | drivers/net/can/kvaser_pciefd.c:1777:54: error: =E2=80=98PCI_IRQ_LEGACY=
=E2=80=99 undeclared (first use in this function); did you mean =E2=80=98NR=
_IRQS_LEGACY=E2=80=99?
> |  1777 |         ret =3D pci_alloc_irq_vectors(pcie->pci, 1, 1, PCI_IRQ_=
LEGACY | PCI_IRQ_MSI);
> |       |                                                      ^~~~~~~~~~=
~~~~
> |       |                                                      NR_IRQS_LE=
GACY
> | drivers/net/can/kvaser_pciefd.c:1777:54: note: each undeclared identifi=
er is reported only once for each function it appears in

See 0e1fdd222f0a ("PCI: Remove PCI_IRQ_LEGACY"). I'll fix it up here.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xrn6ia6lbi53cs5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZz/9QACgkQKDiiPnot
vG+oAwf/X+hQhE/kf7r8gj9ZSDOkpfLtAjne9/hlNQCGZK83CZXnzz7xLQ7/4E1D
RM5wR/JDCQN34FcX0SQeGDf7suw5H2g0hog0GXD5QbOlHyJRh3Lk+Cl7/qbmfFG5
GB2vDPju9CvTyKi4sH7bgnrIMTpFOhhUqOV6RYGk97ATZ2xzVHKPrONqCqt2VqKg
WsiVVmN78yrSUrKRSJLR1s+p2LBLG3Mn/MygtsLW6B80R62is1IqzxMxSX5XObP/
fONdOLv95jSQrEpjs3KPqENTpyYUMjF+sTmssisDJNh8ApauESN9OvSN5nVcAQJq
wZHp/RNgKN7igD4uHIGwD3q23HUg8w==
=2fiz
-----END PGP SIGNATURE-----

--xrn6ia6lbi53cs5c--

