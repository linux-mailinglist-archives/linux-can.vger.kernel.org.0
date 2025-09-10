Return-Path: <linux-can+bounces-4641-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F919B51675
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 14:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06FDD1C846DE
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 12:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F9E28851C;
	Wed, 10 Sep 2025 12:01:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FDB241CB6
	for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757505716; cv=none; b=GabCwDtBXZtjrc3g/LzY7IpgvfEJiTythn/eLaa5OCYoOtipY83oZjwwj0KNzyqgkQ0kvfSmkbXyO4o+UmZ2ChrKCwcpkNkzSPUVKoua6FRDK0yif5sUHVyfYVI3Ze1JpMg7RSuPFnVLg90yvGaGoEhgAAw4ZaTagWn1ZCpNU84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757505716; c=relaxed/simple;
	bh=xNT4G6qs9l7QPTAvqBF1dRgaEssgIWs25a7L/Xt6Q2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/R4uvrC3z59OKG3tPu8PpBrbt8C3OKceL+begIlTtkr3K+efRFRZv5q0Cfdh7S2FG5sYyzKABTd4RQlGvgu6YaJ+RO6y7SVrsaFfWyYe8DZJ5dfJ9/dFjMJEFeifsiPSJqsgB2w7JKFPqiLzyx30JSNZu/Y0Mo6tqFlm0113Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uwJWG-00077G-1O; Wed, 10 Sep 2025 14:01:48 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uwJWF-000aHA-29;
	Wed, 10 Sep 2025 14:01:47 +0200
Received: from pengutronix.de (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 45E3A46AE6F;
	Wed, 10 Sep 2025 12:01:47 +0000 (UTC)
Date: Wed, 10 Sep 2025 14:01:46 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju <biju.das.au@gmail.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 0/4] R-Car CANFD Improvements
Message-ID: <20250910-brave-vehement-peacock-9db1db-mkl@pengutronix.de>
References: <20250908120940.147196-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xpufka5iexvklpko"
Content-Disposition: inline
In-Reply-To: <20250908120940.147196-1-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--xpufka5iexvklpko
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/4] R-Car CANFD Improvements
MIME-Version: 1.0

On 08.09.2025 13:09:29, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> The calculation formula for nominal bit rate of classical CAN is same as
> that of nominal bit rate of CANFD on the RZ/G3E SoC and R-Car Gen4
> compared to other SoCs. Update the nominal bit rate constants.
>=20
> Apart from this, for replacing function-like macros, introduced
> rcar_canfd_compute_{nominal,data}_bit_rate_cfg().

Applied with the added "the" in 1/4.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xpufka5iexvklpko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjBaKcACgkQDHRl3/mQ
kZyHuQf/T2gw8Ri56EZFw46roCFn4iFrUghyS1PkXXNnrWpiZupUN3V8wBobMjZo
CkKY14YHOm97AbSBD3Ps5DcyZ3Iiu2kikIsFWh2BHJKZMBYKlP4qfvu5A4V7oClW
o9oK5bbPVHcKFFgMxtAfKE8c0mgdAjcH0VnfQwpfUegbnd3XKA+/ig+laWpU3hht
Ru5D//Tu2COcOjpnb/nnYbaCIExbv4oJY3rvKHc/llQjQfohYTnJt7V97Khp7BfI
19ke/hSheFiCofnBrf8qVIedTnFvWeAGi2r9hfdMd7SxbdLclrL3X6CH/VX8oCes
Rf0IV0X8bhLxtg+GMiCobvB/jhmpLQ==
=T415
-----END PGP SIGNATURE-----

--xpufka5iexvklpko--

