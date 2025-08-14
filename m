Return-Path: <linux-can+bounces-4246-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1BDB265A8
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 14:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2901CC3757
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 12:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD1E2FD7C2;
	Thu, 14 Aug 2025 12:43:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6706F2FA0C9
	for <linux-can@vger.kernel.org>; Thu, 14 Aug 2025 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175434; cv=none; b=c04kAuQi3+EiaWZW3SELqwYSIunSJ1DK3Y9NNqwCcd4nA9buM39grpssLfhlwh7+0Jifu8Hpsrurs426rFYIkXFTCBcj7Kd7S1kLXLvQuAXNWwJGU9Pu3Ut3JfPyRdI/5mFLSmM2EuvnshmBOs12FExvpSWMWKIQZ1h5kUiHEv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175434; c=relaxed/simple;
	bh=HOzw7Wbj+rr+AsMHxe6F/0o5kwHmfRLuwlWb7cKl3hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIP+8dIvmas7FBMyBu5XAza48Y4qobHALdAe/8GGTPEmvhw4UZab2CtxM6akgvu7X3GeNUQlh4nKokJBXI8NR+9clwiVSgt5n5DVnrKLiYlkiP27qxJyzSa01B4yVCjMDh0qoDXZP+OY7N7pQfKXfDyt0tDbWRk+OqlZDWMEcds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1umXJ2-0004Cf-8u; Thu, 14 Aug 2025 14:43:44 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1umXJ1-000FyM-2m;
	Thu, 14 Aug 2025 14:43:43 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 828C8457753;
	Thu, 14 Aug 2025 12:43:43 +0000 (UTC)
Date: Thu, 14 Aug 2025 14:43:42 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 3/9] can: rcar_can: Convert to Runtime PM
Message-ID: <20250814-true-demonic-flamingo-a3155e-mkl@pengutronix.de>
References: <cover.1755172404.git.geert+renesas@glider.be>
 <ae8fdd96d926ddd2c699ec2795a4c9937c3f3bc3.1755172404.git.geert+renesas@glider.be>
 <20250814-incredible-cordial-coot-5f9fc9-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pcmh4tcyjjcbax7a"
Content-Disposition: inline
In-Reply-To: <20250814-incredible-cordial-coot-5f9fc9-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--pcmh4tcyjjcbax7a
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/9] can: rcar_can: Convert to Runtime PM
MIME-Version: 1.0

On 14.08.2025 14:06:33, Marc Kleine-Budde wrote:
> > -	err =3D clk_prepare_enable(priv->clk);
> > +	err =3D pm_runtime_resume_and_get(ndev->dev.parent);
> >  	if (err) {
> >  		netdev_err(ndev,
> > -			   "failed to enable peripheral clock, error %d\n",
> > +			   "pm_runtime_resume_and_get() failed, error %d\n",
>=20
> Can you convert the errors to %pE?

Doh, I mean "%pe"

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--pcmh4tcyjjcbax7a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmid2fsACgkQDHRl3/mQ
kZxqegf9GvD6ctgiYMPuuX3Ql0yaCIyYvbupz2d9qfurpdxLVgHxnwMY6de/5aSV
WP+kYxHpBGyU9t11PGdSRKl+DYEJcPBiJ59VODo1Eajo5zXITyN+5n8AycIBQAyr
6YyGsJjBo5y4IFSww41saTTvokFZf8HsSGI3zas00xw2HzJD/muUeQLNh6S9BVt/
31DJNaeBQhT65zM31kiZGHeP3WVBga9Bbj2Vd/7aZ2Hwo2TwN3sUTMCEjKzyzSRv
UPaEq3Lpr+dzOo0Qu1h62yml9YqLhFrWaEG/dttdLyr7vi4r4WlBVMaMTMsyBrrG
I1M4xu4nnqxUkLCscehQXLhQyHHmJA==
=WVAB
-----END PGP SIGNATURE-----

--pcmh4tcyjjcbax7a--

