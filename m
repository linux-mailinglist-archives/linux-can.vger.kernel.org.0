Return-Path: <linux-can+bounces-1403-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB8996BDC6
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 15:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF2C286386
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 13:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636C9145FE8;
	Wed,  4 Sep 2024 13:04:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090A41DA2EF
	for <linux-can@vger.kernel.org>; Wed,  4 Sep 2024 13:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455081; cv=none; b=hZSgQIMPwESpxs5iOlXpAipTvaj5PCu9eL05Fy5sVccMYILwBEVp381cwC1SLfvp5PH5n4+dpEOqxSQK7pyWsHQKuryWLiBKu4txVvkdpq2quZnauU2EQyWjwdyjMS4F1XHj7x4G02nTcNZVg3rAkn0fDEhdonwhuuPe53kFgJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455081; c=relaxed/simple;
	bh=iUvkWqxZWOqh9qs9Z4qY7apUDk7RXeOCuIbeU/k45lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYdttHnCWn0Z1rc2+pLQkVAbVBvRuAavSLKZELq/W31B7R+Fql0YuBw62A2K5qPWftfULqYlErdm5xTkInSt4cO2k87XFrvOwTMea9teaN4iWLvX8RqkWZJYsNNz2HTGGh8wDMVKoGj8dVsxBMVAoGisayBPWCzcIhtYFZaMJoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slpga-0000Pm-Lk; Wed, 04 Sep 2024 15:04:36 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slpga-005Scb-6e; Wed, 04 Sep 2024 15:04:36 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EC81C332878;
	Wed, 04 Sep 2024 13:04:35 +0000 (UTC)
Date: Wed, 4 Sep 2024 15:04:35 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 0/20] pull-request: can-next 2024-09-04
Message-ID: <20240904-valiant-camouflaged-dove-171b7d-mkl@pengutronix.de>
References: <20240904094218.1925386-1-mkl@pengutronix.de>
 <20240904-stirring-meteoric-cobra-831697-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="564yis4mvy6qojrj"
Content-Disposition: inline
In-Reply-To: <20240904-stirring-meteoric-cobra-831697-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--564yis4mvy6qojrj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.09.2024 14:56:49, Marc Kleine-Budde wrote:
> Please don't pull.
>=20
> DTS changes should not be included in this PR. I'll send an updated
> one.

The updated PR: https://lore.kernel.org/all/20240904130256.1965582-1-mkl@pe=
ngutronix.de/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--564yis4mvy6qojrj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbYWuAACgkQKDiiPnot
vG9q3Qf/YxMQ2/a8YA53kYe/8TLk1ncL6fZUqNcQLe5H2x5uGvUU/4YqQdQ61nHG
lJbW/PjTnAAVTd6o1JncOwdHXo/y3PR6MdC2QP4hB2excONeTzStibTMtQdifVAN
NVWT4PTZNe92pCj4Rbqn+GBtw7tLt2sY3FtHYGjpfeuxSssGq8gqatNFS4Aesj9z
NCb28WPgeh3LPohi1TlUL9nfuDvetpf+RTQKwgd4MyIkd1wZ1wsqHrundM7HxDqb
SMlQXYSLuc32tZrbZVEaGtPBrTgDy8i8kunBev6/2ULgyiyf6MOLGesqJ3nTbxLT
yIF7ZdBukCZTvhXYVh5tZkjOemxfRQ==
=iau/
-----END PGP SIGNATURE-----

--564yis4mvy6qojrj--

