Return-Path: <linux-can+bounces-3401-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B401EA89A4A
	for <lists+linux-can@lfdr.de>; Tue, 15 Apr 2025 12:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697011891BD0
	for <lists+linux-can@lfdr.de>; Tue, 15 Apr 2025 10:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E1D28B4E3;
	Tue, 15 Apr 2025 10:30:39 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAAE28B51D
	for <linux-can@vger.kernel.org>; Tue, 15 Apr 2025 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744713039; cv=none; b=LlryQwwY808pjHD/XTEHy9Oagnfqcl0GQNNCrJAdRUXj/+CgbLRejQI1vcpb51rclGrBkLlKubKP4kb0kCgZApDV+e0NYLx5fUA0G6zlYDRHLOqBetUJLiLYVGjYO7Q7/J+gza5S4AqshtD7nx89QACo5dSAzWQxjKwxkzXqih8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744713039; c=relaxed/simple;
	bh=vxcW2jhj4T2pootYZ+pVEjva9ixTC5O+HAdClybGYcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2NKEgpmHqkKO2+DCfzrsC8aDZMzWejd8Bz2c3FBERUjG50vbrkopMrGlbzAunh2ceWAr2jEPXdWwwYVloYOsTRR/lU7yko29ntehoEvcI2pFbn5AOaz1FQ1taQXX2sVhw1fd+1mmPIgAbkVz2zWNM6eDFWecIgD7IhBFK31XuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1u4dYm-0005nU-Um; Tue, 15 Apr 2025 12:30:32 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1u4dYm-000P3o-1g;
	Tue, 15 Apr 2025 12:30:32 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3145B3F9BC7;
	Tue, 15 Apr 2025 10:30:32 +0000 (UTC)
Date: Tue, 15 Apr 2025 12:30:31 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH] can: fix missing decrement of j1939_proto.inuse_idx
Message-ID: <20250415-upbeat-deft-spaniel-1bf984-mkl@pengutronix.de>
References: <09ce71f281b9e27d1e3d1104430bf3fceb8c7321.1742292636.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y3fwbpzwfazg3tbf"
Content-Disposition: inline
In-Reply-To: <09ce71f281b9e27d1e3d1104430bf3fceb8c7321.1742292636.git.dcaratti@redhat.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--y3fwbpzwfazg3tbf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: fix missing decrement of j1939_proto.inuse_idx
MIME-Version: 1.0

On 18.03.2025 11:21:41, Davide Caratti wrote:
> Like other protocols on top of AF_CAN family, also j1939_proto.inuse_idx
> needs to be decremented on socket dismantle.
>=20
> Fixes: 6bffe88452db ("can: add protocol counter for AF_CAN sockets")
> Reported-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Closes: https://lore.kernel.org/linux-can/7e35b13f-bbc4-491e-9081-fb939e1=
b8df0@hartkopp.net/
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--y3fwbpzwfazg3tbf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmf+NUUACgkQDHRl3/mQ
kZwTmQgAtwRF1Np04TyVK4Iwkfk+Ssf95APlfQ/QFDAko807Ka8J+iPUng4TNUQh
cHfRmzvR/hKUVNp+zsQly//hPGbBmP84AVtNO3JJzCyL8cFxlvIjcVrYrMOul84l
5wz0qBAln/wfRZq1TOnLIT4s7RUeSTWaie9tpHZpAogJUi3KIDan6LNSLKgPYTKs
iXY3i5FtplX5e/+fPJLAndjX/a2PTpwOJX+Y88i+7mU1uzAfdA64G59ty9pau8NR
Q/et9JJd9qi2qsOM8Xkvyhx1r8qZcHXnlaWE5N5k8P8owMMHTv+gHKR5Zhtvqm7t
lQNsi8Nykec4v0Tv+GmeTlhk9QzUlg==
=K3zK
-----END PGP SIGNATURE-----

--y3fwbpzwfazg3tbf--

