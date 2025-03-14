Return-Path: <linux-can+bounces-3067-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 127C5A6114A
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 13:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E5F17414E
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 12:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7341E50B;
	Fri, 14 Mar 2025 12:31:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B21A304A
	for <linux-can@vger.kernel.org>; Fri, 14 Mar 2025 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955509; cv=none; b=fojSHAO88Lmhg5Um6rXJv+MHnU9hZeFw8/ql7p5isr9joSYZj6iQgERu3xbwtovxrB5Pmv/VjhJxSZF+/WmZMxVhO/nLb3SYul2papD7heRHaGIeARRsdLPHaRZlGc4HY8ZzCF+0FW8o14PRtlK8dZfCSQohirz3b4HeA19mSOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955509; c=relaxed/simple;
	bh=MBkpOHtAwOAKmwnEEX7VO5IjM2AeT0WIOqYMihxPa7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIbRWb0zbA9IwZBG4+NzE8rXU2aId28lsOmbiJ5LI3F0yqOk3GIUoc7Py7eQ/5p/pZlcuXGZu0WCAGcS1RURHuMAxvzwGegvCnf5kZjaV6EajdmakAAVgtS1WZDQRB9a0evrcp25hxnLMIKNzBBvsIiw5TE3saiCcikI+rfy+GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt4CX-0001H9-CH; Fri, 14 Mar 2025 13:31:45 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt4CX-005hQi-08;
	Fri, 14 Mar 2025 13:31:45 +0100
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AA94D3DBAEE;
	Fri, 14 Mar 2025 12:31:44 +0000 (UTC)
Date: Fri, 14 Mar 2025 13:31:44 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: add protocol counter for AF_CAN sockets
Message-ID: <20250314-messy-fierce-squid-0ce7c3-mkl@pengutronix.de>
References: <9db5d0e6c11b232ad895885616f1258882a32f61.1741952160.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fuevs3s6gvalzadg"
Content-Disposition: inline
In-Reply-To: <9db5d0e6c11b232ad895885616f1258882a32f61.1741952160.git.dcaratti@redhat.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--fuevs3s6gvalzadg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: add protocol counter for AF_CAN sockets
MIME-Version: 1.0

On 14.03.2025 12:39:49, Davide Caratti wrote:
> The third column in the output of the following command:
>=20
>  # grep CAN /proc/net/protocols
>=20
> is systematically '0': use sock_prot_inuse_add() to account for the number
> of sockets for each protocol on top of AF_CAN family.
>=20
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--fuevs3s6gvalzadg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmfUIa0ACgkQDHRl3/mQ
kZy7qQf/cUkvEQIIJjIv8LEhwcc5QYUW+XDXIMeusVGBtORCIe27+gLwF90Mgyta
Vx+uYBsfg1ELjn37NtS2gtbDGMoeO4dm2hyVvB+bLjAexh/igfx0cPbRnUuqRDPD
/z0wmqrRNhUgeFSdU0KzbFMK/xUeTfx5HjYdhfMjYJxgImDrYqWxg+Dna0fHD+SH
jM05dAa+9KjvEe04VYMopWovkvEYuWs5TE1FFh4thS6xfhsNGWnh6rNfRK4cpBj7
FeQdVHPdc8C55fyfzioEIDMKT3RdWOKirK6Zox4WcPOFZHC0NOtBvSWs6z8qJCpn
ZntAs35njCCIaX8G5jL9CQuGcocyfQ==
=gEqO
-----END PGP SIGNATURE-----

--fuevs3s6gvalzadg--

