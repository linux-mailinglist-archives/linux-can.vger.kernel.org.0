Return-Path: <linux-can+bounces-3059-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D7DA60CDF
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 10:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 432637A4F5C
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 09:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5846C1DFDAE;
	Fri, 14 Mar 2025 09:13:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBCD1DE3AD
	for <linux-can@vger.kernel.org>; Fri, 14 Mar 2025 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943599; cv=none; b=XR7lyFPz45qGE6QUqP0eaxLKMcdHD1Tgo+4lXe49hiwOe1MtOzrqyjUvL/AjZJQCwAPiOUE3tO9LDMpsgAC6DHx22BVlXRJY3d12ZI738ixGG6Uuor7lNZK8rNJgqB8rxTcoY8REyp+Nd8UEfYuRf5qBfDKh9Tu8MEgwfPwa/eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943599; c=relaxed/simple;
	bh=gA269ZA7re/1zq17sICYw8fQwFZdnE3HKJAQuA1wjrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agd1kSWFaGGVg9gXl8mGmfXDMpAwZP8g94badWlC1p3FqVq7VUQDyMcd/Osho92SUxXUch3nebdp33AMip3Tm61FMciy1io6TUQAW83a06hc5NGaz3zNI9viRJM09E5AhYvtv4xsbIsV261gfMDp8DWm6dasFo89QM9yD0eCfwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt16N-00032P-JB; Fri, 14 Mar 2025 10:13:11 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt16M-005g5a-2p;
	Fri, 14 Mar 2025 10:13:10 +0100
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8547B3DB889;
	Fri, 14 Mar 2025 09:13:10 +0000 (UTC)
Date: Fri, 14 Mar 2025 10:13:08 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: haibo.chen@nxp.com
Cc: mailhol.vincent@wanadoo.fr, ciprianmarian.costea@oss.nxp.com, 
	han.xu@nxp.com, u.kleine-koenig@baylibre.com, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 1/2] can: flexcan: only set CAN_STATE_ERROR_ACTIVE when
 resume has no issue
Message-ID: <20250314-invaluable-economic-caterpillar-80541a-mkl@pengutronix.de>
References: <20250306065921.2329517-1-haibo.chen@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7dixbjw5nb2p3hgi"
Content-Disposition: inline
In-Reply-To: <20250306065921.2329517-1-haibo.chen@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--7dixbjw5nb2p3hgi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] can: flexcan: only set CAN_STATE_ERROR_ACTIVE when
 resume has no issue
MIME-Version: 1.0

On 06.03.2025 14:59:20, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>=20
> Only set CAN state to CAN_STATE_ERROR_ACTIVE when resume process has
> no issue, otherwise keep in CAN_STATE_SLEEPING as suspend did.

When looking at the code, it makes no sense to set the can.state to
CAN_STATE_ERROR_ACTIVE, if the device isn't up.

The suspend function doesn't look correct, either. I'll send a v3.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7dixbjw5nb2p3hgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmfT8yEACgkQDHRl3/mQ
kZxexQf+JmEKpW48n7JZaT4itKhpbShwu5VNhVjXTZjgyErhN7cqpKyFglMMPIru
JpKW8al/V5egAvSxVkC3LbKGE8/CtKXG8cY9cPAcgY2tdHU5bwxCbMWAcdbunSru
+OQn4fdsUrC0kt15a8G+0u3rXrChh4GA4lMBB4oGuGWlO2UgqWClEaJsJj098sAn
7E6ysBMUw70/ungoZfQb7xDOZt2/qTQVdgrZWRkypaqoxbTDQRylWHMCzFwJdxSj
Ykq8PB9q6fRIozXgNc9vVfLTVFTxdVWf1Rc6Ujp+4JBHkI2AGXb7Np67kyntk8Bl
l6WLqe3SQNzUGLY6pQ10ImsmW1w8kA==
=JpVT
-----END PGP SIGNATURE-----

--7dixbjw5nb2p3hgi--

