Return-Path: <linux-can+bounces-2592-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA6FA0997E
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 19:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1D197A04A2
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 18:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFD81487CD;
	Fri, 10 Jan 2025 18:32:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA47920764A
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736533953; cv=none; b=mPJIeJNlwHDXC/z3iPNRDVfgMKZu3LIHSOwziqESG6aRqu5IkxmzGezVWxRbCPX4g4+OvoeIbZSm/AzdgwG2g+EKgD9Gr71ETbUN7+9bx4smp1uUqTx8ONyjrGR0cOBiuq604qEucVFa8LhnlucV2RQMUJlugOeQ14/QAc+UILY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736533953; c=relaxed/simple;
	bh=xBfLwjtywfjj5sxPDX7j5u8NktPOoMLmAOBKJKIHr78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kv4PNPoiJtWfSwa9pgp1p8SamYbuNZV4EOuPqomcmbqGDaJW3SkDi7YQe4BWn352hrWJrFU1Xqg3/BlLMVV1GnnR1xJO4CsO5N4yC4Nn2FLBUEc66v4okGv7hWOZKadKEocTfT/jJnBby0ZCDj0UVHoLYMGj2N3twrnVIre2/Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWJno-000779-Hw; Fri, 10 Jan 2025 19:32:12 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWJnm-000D0f-36;
	Fri, 10 Jan 2025 19:32:10 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 44D723A4F66;
	Fri, 10 Jan 2025 18:32:02 +0000 (UTC)
Date: Fri, 10 Jan 2025 19:31:58 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Lavoisier Ruffalo <ruffalolavoisier@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: remove duplicate word
Message-ID: <20250110-antique-stallion-of-research-222a49-mkl@pengutronix.de>
References: <20241120044014.92375-1-RuffaloLavoisier@gmail.com>
 <20241120-antique-earwig-of-modernism-1fc66e-mkl@pengutronix.de>
 <20250110-screeching-quixotic-tanuki-1e6fa0-mkl@pengutronix.de>
 <CAAaoUie+4jtUhjt4-wAGr56rt51fa++q9kG8Ympk3a8i_oBzxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zwek5z4fzp5fougc"
Content-Disposition: inline
In-Reply-To: <CAAaoUie+4jtUhjt4-wAGr56rt51fa++q9kG8Ympk3a8i_oBzxg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--zwek5z4fzp5fougc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] docs: remove duplicate word
MIME-Version: 1.0

On 11.01.2025 02:23:14, Lavoisier Ruffalo wrote:
> Hi there
>=20
> I'm sorry for the delay in my reply. Yes, please.

Thanks, I think your mail didn't make it to the mailing list, as HTML
mails are not allowed. I'll add the patch with your S-o-b to
linux-can-next.

regards,
Marc

>=20
> Thanks
>=20
> On Fri, Jan 10, 2025, 7:41=E2=80=AFPM Marc Kleine-Budde <mkl@pengutronix.=
de> wrote:
>=20
> > On 20.11.2024 09:27:22, Marc Kleine-Budde wrote:
> > > On 20.11.2024 13:40:13, Ruffalo Lavoisier wrote:
> > > > - Remove duplicate word, 'to'.
> > >
> > > Can I add your Signed-off-by to the patch?
> > >
> > >
> > https://elixir.bootlin.com/linux/v6.12/source/Documentation/process/sub=
mitting-patches.rst#L396
> >
> > Is it OK to add your Signed-off-by to the patch?
> >
> > regards,
> > Marc
> >
> > --
> > Pengutronix e.K.                 | Marc Kleine-Budde          |
> > Embedded Linux                   | https://www.pengutronix.de |
> > Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> > Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |
> >

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zwek5z4fzp5fougc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmeBZ5sACgkQKDiiPnot
vG8lnAf+MW81F5qZPIOf7hkg0vJ5GwN5GfM5T3hW3RNScfwmER8+nhSSrir3BD43
9oulQhzFhjBPepxZiRL5tsq1XOcm2OQRyBNjIiVSu7o80PXYN3bQ5lxegKojiFk/
vPLVe7XWAGmwvG6vejle1pdk7Tz+2mYGxlwq9+iOEqcMHCs9fSY7WiEDDewEsINZ
dJ8MKzuaDWpQncQDFSPTgngJyOOO82gkNMC2XXsIsGrxxdIptBo7cvFHu0g+503c
06J7W9YjxeOUvSd8o6xTO0y+iG+AuL3wNi8hqE77EStBQP3einh0o4BpOJTxM3MR
AUabcqh3Ap3QrUkcoL1DoS+rRBnDDg==
=+fM4
-----END PGP SIGNATURE-----

--zwek5z4fzp5fougc--

