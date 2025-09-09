Return-Path: <linux-can+bounces-4562-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 507D7B4AD3A
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 14:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB7D17A16E2
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 12:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DBA334384;
	Tue,  9 Sep 2025 12:01:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0813A334368
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419294; cv=none; b=PEp6jB3Z9Ku7klEP/A2oqE+QjlH0F3ygPLevAT5n56Sdh4G2cMMO/QqSWnNqlHJutijTOdxZOj619sac00UrgWQUGvzq6jGW047MbTk7SdVdP5HQevFScJt1VeFrWcfDgePUCDjEJ4N0/AqKvd6Bpzrgal3jPKH6gXGC19c6d2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419294; c=relaxed/simple;
	bh=g9nh6GpHzAI4I294+ruQ+2mXUTTzAyrQ6pQK61hnsnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFqb+QzvFFQ5uywITxQetJzPo88SUDYNu7lb3mNzS4qrMHNE5ZCCPkwKpBsHIuzg1Nd6rb1RYRGRN+slvtKHL5UPNbsfDakWfrfVQ5jmt2DocUR4BzXZoc0+umCCuk4ovUhHCzuemZUMceU+2H+A+0pb495rlxJJN5XT87lCQF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvx2L-0006YA-Fr; Tue, 09 Sep 2025 14:01:25 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvx2L-000Pep-0w;
	Tue, 09 Sep 2025 14:01:25 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 08A95469EAC;
	Tue, 09 Sep 2025 12:01:25 +0000 (UTC)
Date: Tue, 9 Sep 2025 14:01:24 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	Felix Maurer <fmaurer@redhat.com>, Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org
Subject: Re: [PATCH v3] selftests: can: enable CONFIG_CAN_VCAN as a module
Message-ID: <20250909-big-astute-potoo-e50070-mkl@pengutronix.de>
References: <f1b942b5c85dda5de8ff243af158d8ba6432b59f.1756813350.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dbzheyhfkmtrm7ph"
Content-Disposition: inline
In-Reply-To: <f1b942b5c85dda5de8ff243af158d8ba6432b59f.1756813350.git.dcaratti@redhat.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--dbzheyhfkmtrm7ph
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] selftests: can: enable CONFIG_CAN_VCAN as a module
MIME-Version: 1.0

On 02.09.2025 13:45:34, Davide Caratti wrote:
> A proper kernel configuration for running kselftest can be obtained with:
>=20
>  $ yes | make kselftest-merge
>=20
> Build of 'vcan' driver is currently missing, while the other required kno=
bs
> are already there because of net/link_netns.py [1]. Add a config file in
> selftests/net/can to store the minimum set of kconfig needed for CAN
> selftests. While at it, move existing CAN-related knobs from selftests/net
> to selftests/net/can.
>=20
> [1] https://patch.msgid.link/20250219125039.18024-14-shaw.leon@gmail.com
>=20
> Fixes: 77442ffa83e8 ("selftests: can: Import tst-filter from can-tests")
> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>

Applied to linux-can.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--dbzheyhfkmtrm7ph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjAFxEACgkQDHRl3/mQ
kZySDwf8Dn/928XIZDzwWmEgCbIKx3NvvuNaOtm2lxOxEAWBJs5wp7ApC4b9riX5
cxMDFP9iCJogYfaO4+RiOxg9hawOR2Im/2NFi1/qFzP92QUqR/1oGkLH21IqKvRd
vRrPZSnwtY55dk+NVnHz91b0V32FPduyueyqz4d9aTwvcdnbTZjYiCpHoGqALZOS
AFYaOMY6hr+FWmDCh7neWOB8wA/grwpEhqBdW0j1ElB7fLM4x8FfoCZMb7ZACWpg
0R01vm+QzgAaLP6RTwl4vkeSCW1GGddmRXI2tjVN3fOE/QFgpqvA5JdMKeZRZe/J
MIfwtLftPR2qQWY10SkSOlJGz3P3bg==
=CVF0
-----END PGP SIGNATURE-----

--dbzheyhfkmtrm7ph--

