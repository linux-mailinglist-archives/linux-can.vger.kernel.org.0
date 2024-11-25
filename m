Return-Path: <linux-can+bounces-2212-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA98F9D859B
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2024 13:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE71162B62
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2024 12:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118E421106;
	Mon, 25 Nov 2024 12:48:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F0F18893C
	for <linux-can@vger.kernel.org>; Mon, 25 Nov 2024 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732538905; cv=none; b=bE0HItkrRH3nJvkmzFci4JFVQyzn7pLjpbjxIHQxGqOngEsT4fXeMO68Ra7daZl+09dBnWc/UT9HDzqDT2iG3hJx/NG88QqaerWdWmuR1ElknqvDBcjxS033hnZHNt9LbE+xKeBUnUuvl9udZiqnsOKLkzbmKL3Q+/yTr2AHLz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732538905; c=relaxed/simple;
	bh=s8qjWcyzpA0Dr/N4FoYPICErI/nN3MEkaZNL7HTn5pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7wt5wA8AaM03B4mzLZaP8wHENTcrNVyjJE9pHqQF5pra16RWrE9P+mAxcRUHyuuEM7O1z5rb022BSMA7qL2yi4I1FGcKciSN9rqhuEigX0Tad97ebhSVMu7TziquG9Pwg1YCJnzDqJe/y5vkuI9MZk8Cz3a7ACEOLBZanY9uQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFYVk-0006NZ-TN; Mon, 25 Nov 2024 13:48:16 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFYVj-00057p-1y;
	Mon, 25 Nov 2024 13:48:16 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id ED4B537CCA0;
	Mon, 25 Nov 2024 12:48:15 +0000 (UTC)
Date: Mon, 25 Nov 2024 13:48:15 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
	mailhol.vincent@wanadoo.fr, manivannan.sadhasivam@linaro.org, schuchmann@schleissheimer.de, 
	thomas.kopp@microchip.com
Subject: Re: AW: [PATCH RFC can v2] can: mcp251xfd: mcp251xfd_get_tef_len():
 fix length calculation
Message-ID: <20241125-hulking-liberal-stingray-ea500c-mkl@pengutronix.de>
References: <20241124-fervent-unyielding-macaw-1c66fb-mkl@pengutronix.de>
 <20241125124613.29162-1-renjaya.zenta@formulatrix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rtvp63nzig4zuf3z"
Content-Disposition: inline
In-Reply-To: <20241125124613.29162-1-renjaya.zenta@formulatrix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--rtvp63nzig4zuf3z
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: AW: [PATCH RFC can v2] can: mcp251xfd: mcp251xfd_get_tef_len():
 fix length calculation
MIME-Version: 1.0

On 25.11.2024 19:46:13, Renjaya Raga Zenta wrote:
> On 11/25/24 6:01 PM, Marc Kleine-Budde wrote:
>=20
> > I've just send a patch [1] to work around this issue. However not
> > tested, as I cannot reproduce the problem here.
> >
> > [1] https://patch.msgid.link/20241125-mcp251xfd-fix-length-calculation-=
v1-1-974445b5f893@pengutronix.de
>=20
> I've tested this patch and it no longer crashes with the previous reprodu=
cer.
>=20
> Thanks for the fix and detailed explanation.

Can I add your Tested-by?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--rtvp63nzig4zuf3z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdEcgwACgkQKDiiPnot
vG+e9Af/TSqAkHYwbmrqy77U2NLq19Ye/nWfC6I9mKCcza/NEzuI76jifgJnlJiD
kN0BRF8kf/uQMGsDCU5kDIX8doIt6YLVCfMZIsqMAYZCNy4mf/2knsj2ef4nXcIR
gt11SkTFZoMP9Vv4KkT3G2v2NNppkWpmxShXhnc6h0Ux4fsuE7CZ1KKTCdoKQ4O8
NVP0w3ust77ebm2tDIL9FjDnjzSRwTb6wIUw8wH0vvlXtgVqHHIBxDTRSniWmpRY
ZSBdseESTt0Op+VbNUHBeqrtWT96tFy6BLOI8dqjijO9C7H4AmLNkxcjuv5z3b6U
MRA3bf1HFPbb5suk3ZU+XpUKSX8Wpw==
=DkIC
-----END PGP SIGNATURE-----

--rtvp63nzig4zuf3z--

