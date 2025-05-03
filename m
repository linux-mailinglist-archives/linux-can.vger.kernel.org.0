Return-Path: <linux-can+bounces-3525-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB8CAA80BD
	for <lists+linux-can@lfdr.de>; Sat,  3 May 2025 14:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3445A1B62149
	for <lists+linux-can@lfdr.de>; Sat,  3 May 2025 12:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6292AD2C;
	Sat,  3 May 2025 12:46:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C9A849C
	for <linux-can@vger.kernel.org>; Sat,  3 May 2025 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746276362; cv=none; b=EjzNxI/hus/dXEpk1FeDloB0oYbtVH6OUc3dEHnVY0WdiIzncIcauBGXttR13UayGxWQMkrg1XfURSkfj/xdNbQHpYNxQtHfAGlCSLuT5xf5blmRjznhU/cBdNZE5QvsuNT+69jANEl4vcVk7yZDM3TqjwpxnVFy+syKBGJEkIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746276362; c=relaxed/simple;
	bh=PeSuCiH0EAKkjBGZSZUgMAjqfj7s/KuKnybxmYa8vGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdnHLErdo3eBkm/KzZfa+S+y8Eds5oSf/v+4jNDsZEd46uYebV6TKHT7zE+wOJc06LZZfqvLmcoGX8sjveuU212imjxll3ZfTTK9/nIfagdf716Vvw92Qu3iaxKpM811UgdAp8NUvfs922U+qYI9kd/C01cIFitRHB31wO4uxPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uBCFX-0003WM-2A; Sat, 03 May 2025 14:45:47 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uBCFW-000uWZ-1z;
	Sat, 03 May 2025 14:45:46 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4A5A140748D;
	Sat, 03 May 2025 12:45:46 +0000 (UTC)
Date: Sat, 3 May 2025 14:45:45 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, 
	tglx@linutronix.de
Subject: Re: [PATCH v2] can: gw: fix RCU/BH usage in cgw_create_job()
Message-ID: <20250503-spirited-inchworm-of-promotion-4c8ca6-mkl@pengutronix.de>
References: <20250429070555.cs-7b_eZ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nwj5h6rsvcwp4x27"
Content-Disposition: inline
In-Reply-To: <20250429070555.cs-7b_eZ@linutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--nwj5h6rsvcwp4x27
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: gw: fix RCU/BH usage in cgw_create_job()
MIME-Version: 1.0

On 29.04.2025 09:05:55, Sebastian Andrzej Siewior wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
>=20
> As reported by Sebastian Andrzej Siewior the use of local_bh_disable()
> is only feasible in uni processor systems to update the modification rule=
s.
> The usual use-case to update the modification rules is to update the data
> of the modifications but not the modification types (AND/OR/XOR/SET) or
> the checksum functions itself.
>=20
> To omit additional memory allocations to maintain fast modification
> switching times, the modification description space is doubled at gw-job
> creation time so that only the reference to the active modification
> desciption is changed under rcu protection.
     ^^r
>=20
> Rename cgw_job::mod to cf_mod and make it a RCU pointer. Allocate in
> cgw_create_job() and free it together with cgw_job in
> cgw_job_free_rcu(). Update all users to dereference cgw_job::cf_mod with
> a RCU accessor and if possible once.
>=20
> [bigeasy: Replace mod1/mod2 from the Oliver's original patch with dynamic
> allocation, use RCU annotation and accessor]
>=20
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Closes: https://lore.kernel.org/linux-can/20231031112349.y0aLoBrz@linutro=
nix.de/
> Fixes: dd895d7f21b2 ("can: cangw: introduce optional uid to reference cre=
ated routing jobs")
> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Applied to linux-can + fixed typo.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nwj5h6rsvcwp4x27
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmgWD/YACgkQDHRl3/mQ
kZzZdwgAr7OamR0+jYjMrm5FterB5H5BZ0ys3NG6IiheXy9/1FTNufrHwuKYS1yt
g5Ugy4M5ZnKvsm5RSY0x2Xfim6jNYt1V5cKfJcWgaYyzpmAbdRKZ4qqo+g03EmE5
IF/n2UrZvz32hcbrIqJU3nK+wCUbY+67L6vE/gm9zgqVlkQlFbshGgaNMOJlGt93
fo4fzho1SlhOfgrMBlCLHFk8CJx1FhpaurlhtdVmevCZW1ItVHLSCirQmyQgDwzm
9bYxPv8figA6B8pJog39YXb9dp5wpMtFnF+ueApSsNbqp2dd2J1K0Nj8kQmUI35B
QXDbvBwlVKqKXA0hUzHZMuUq+16cxg==
=RN4b
-----END PGP SIGNATURE-----

--nwj5h6rsvcwp4x27--

