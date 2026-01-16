Return-Path: <linux-can+bounces-6176-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 309FED31493
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 13:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F44630155A9
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 12:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9A2203710;
	Fri, 16 Jan 2026 12:46:15 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E380517BCA
	for <linux-can@vger.kernel.org>; Fri, 16 Jan 2026 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768567575; cv=none; b=lu4n7ZmLEXqH09Thcwzk6jdW64tMuyv+NNRN9YqyA5ilWsG6fgGXK6ubPw6EhOS4PRfH4332CHyFciukkBR09owwE70A+axFRghiM6BJ/ZC28nyF3108jtWilx+rw/QzyYGYBelrqYBejxdIv9Skb/3GLO4Mt7miItcCN8SljQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768567575; c=relaxed/simple;
	bh=oP/eh4VU8j0MEGpM3Sroj0wSpjMGzcrb8ii6sy0Bhck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9GJUHfvwCuCRWfAgzt2Z/0tkZHj8G7Xhc9LfZN6yUmepQNkj9grliAa+be/ppf34FMDKdLfzX7DSFyMWrLqhjfc+gYvr2X5zvVChTBH122f/D3kFR8S1Qt4C8mpGZ598luGNoBoFBlkJq8d87hiXIdg56r52rR/FqkDxq2oHbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgjDN-0006vu-RU; Fri, 16 Jan 2026 13:46:09 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgjDO-000v4j-0s;
	Fri, 16 Jan 2026 13:46:09 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5349E4CEA5C;
	Fri, 16 Jan 2026 12:46:09 +0000 (UTC)
Date: Fri, 16 Jan 2026 13:46:09 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, 
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH] can: dev: alloc_candev_mqs(): add missing default CAN
 capabilitied
Message-ID: <20260116-spiritual-sambar-of-satiation-2f446d-mkl@pengutronix.de>
References: <20260116-can_add_missing_set_caps-v1-1-7525126d8b20@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="slyzcyo4tcq5sges"
Content-Disposition: inline
In-Reply-To: <20260116-can_add_missing_set_caps-v1-1-7525126d8b20@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--slyzcyo4tcq5sges
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: dev: alloc_candev_mqs(): add missing default CAN
 capabilitied
MIME-Version: 1.0

Fixed typo in subject (capabilitied -> capabilities) for v2.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--slyzcyo4tcq5sges
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlqMw4ACgkQDHRl3/mQ
kZz7NQf/dn0Enh0KLaXR7RxQkDSTsCaCuIt9oqDEAKidw4MwKH/Fr4d2dVe/p2WF
RsKsh3pztLgs1BYzHFNX/TjIe0dnKMErBboPxXhtMyyuRZ8C8dg9I4oJp4RxTdJf
d7fSTvUmv2V3gtU/lQR7Nj9+yT/T1qD2jCt3tyj2aIvggbS/cr7x+8AyYPSICHCP
eiMG29P8cZmSwX0qhWcAY+sksEWf6ZPXyKALgLODy1dovLZRe2CTQsHOxtTN7s1Q
EX7Do2lnw7k2RXRyE6dq1UqP6ND/Z4bHw3tioPSqBjqrKL7o8peFfJPHvC7tVeHU
Fm4i3q6IFhEI7bDmiOdPBaPwk149EA==
=vL4z
-----END PGP SIGNATURE-----

--slyzcyo4tcq5sges--

