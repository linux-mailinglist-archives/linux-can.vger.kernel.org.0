Return-Path: <linux-can+bounces-4656-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A221DB51DDE
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 18:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD73E1C26F04
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 16:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83401EF091;
	Wed, 10 Sep 2025 16:36:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B45726E712
	for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522190; cv=none; b=WvpumzmqZCrqknQFfMwcSNxVZZoeEO9H2RP4MaWf5MVwRJsa8R5GJhzKIhoOi6h568gHaS8b3eNzZ/d2I0gUHz86T2aHAykdOFxUJRymeVx7UfOt8iIvWdyGMc/s0Mws3W9N7P/OAj6Q/HDCCnamnYKFN/+UAVk8uGCmafIpiyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522190; c=relaxed/simple;
	bh=uW3PRkGgI6Mjymkzjxub2qQAK4EHaSCyG4Wx/ly98lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ss/TZYZ7vKbQUqYi6iKal4u+IOz5Ub0WjLOmM3nfCwq2wRXQD5FmjWjrDeM2od8N4R82bXWgQxRGdA2If2fxevwh7he+QyCblfWiiUwlPTMffqzCeW8pIUK9dYD5IspW79Ml0hpB5Lf7cxfK1jPMa57SGAyajCQykuIorbsKrRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uwNo0-00069Z-Nm; Wed, 10 Sep 2025 18:36:24 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uwNo0-000cd0-0i;
	Wed, 10 Sep 2025 18:36:24 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E3A0E46B25E;
	Wed, 10 Sep 2025 16:36:23 +0000 (UTC)
Date: Wed, 10 Sep 2025 18:36:22 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	Felix Maurer <fmaurer@redhat.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-can@vger.kernel.org, Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PATCH v4] selftests: can: enable CONFIG_CAN_VCAN as a module
Message-ID: <20250910-pearl-caiman-of-competition-6e7c2d-mkl@pengutronix.de>
References: <fa4c0ea262ec529f25e5f5aa9269d84764c67321.1757516009.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="inlh3s4jsqfxb73r"
Content-Disposition: inline
In-Reply-To: <fa4c0ea262ec529f25e5f5aa9269d84764c67321.1757516009.git.dcaratti@redhat.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--inlh3s4jsqfxb73r
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] selftests: can: enable CONFIG_CAN_VCAN as a module
MIME-Version: 1.0

On 10.09.2025 16:56:06, Davide Caratti wrote:
> A proper kernel configuration for running kselftest can be obtained with:
>=20
>  $ yes | make kselftest-merge
>=20
> Build of 'vcan' driver is currently missing, while the other required kno=
bs
> are already there because of net/link_netns.py [1]. Add a config file in
> selftests/net/can to store the minimum set of kconfig needed for CAN
> selftests.
>=20
> [1] https://patch.msgid.link/20250219125039.18024-14-shaw.leon@gmail.com
>=20
> Fixes: 77442ffa83e8 ("selftests: can: Import tst-filter from can-tests")
> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>

Applied and included in the new PR [1].

[1] https://lore.kernel.org/all/20250910162907.948454-1-mkl@pengutronix.de/

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--inlh3s4jsqfxb73r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjBqQMACgkQDHRl3/mQ
kZwcVQf/eWRq10Q7I6zQ7BNKxen2UVnD7ji3Gbigt6K5hnMkcWkca/eK0+UoS55L
KQ3USl9xnttdPPwVyFsK4En1BB9/aqN3KSPB7fDXexwa5xqysGxi9GCvmeGivtnO
jAInlmG8wphL5ktjS9TcSpTxnwX3KDIhL41l/L2LF62V04axSwpz+EeLYXH1lhH0
ZPVAOI63O+COq3WNWTQp9RWVv80lJmZcE6/UqCv2Qsoc8zrqSRteqQLvq1OB9EZc
MV7AuwYYepSTlOe+x+32bvF3iRMOmjKYLgLGrYBK3g/po9rXEsN3xt7ILrbUyQqB
GNNE0i5gpLk7083+s/aR27WTG56sVg==
=DLXL
-----END PGP SIGNATURE-----

--inlh3s4jsqfxb73r--

