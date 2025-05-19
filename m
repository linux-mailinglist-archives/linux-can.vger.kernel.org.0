Return-Path: <linux-can+bounces-3579-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6B8ABC1B7
	for <lists+linux-can@lfdr.de>; Mon, 19 May 2025 17:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4D61B62A57
	for <lists+linux-can@lfdr.de>; Mon, 19 May 2025 15:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA99A28540F;
	Mon, 19 May 2025 15:08:55 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27AB284B33
	for <linux-can@vger.kernel.org>; Mon, 19 May 2025 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747667335; cv=none; b=iz0BB+vKKCoEN7KUnFll42VxGDfufCb8T3EF3ZGx4BW2yeDomh5XI8Oq+o/5Mi+zz7a9LmCsrIXGLu0Q7INP98TIPiuZe/YJBSS+KNfeVYf3A5vTNMOwX6A5OnVoR0RzB/srtMNxvdjrvj/AMTbHAWkpSqvHC7ZWysykJX2JUzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747667335; c=relaxed/simple;
	bh=9xgvH8iJYz/nbOjL/49eCcRlnWgMMUZOdKlMqXx5SYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVuvgbvDjTJ4pN4WidO8UpAVcVU5LGFb4dYcYJfiojJnQvzGwMH6BrfqIbmZKt/R7kb9PchhoCXg8c6nMFo7Pqq7NirRXWuzMHvmfZGKHwGog1xlfVSbdZQnL6q/7iIdSRsSijiBVYu6krkD/EkQL+zGaSoEnNlYzUoGxPmH2XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uH26k-0004yv-JT; Mon, 19 May 2025 17:08:50 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uH26k-000Gge-1G;
	Mon, 19 May 2025 17:08:50 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009:2000::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id ED286415308;
	Mon, 19 May 2025 15:08:49 +0000 (UTC)
Date: Mon, 19 May 2025 17:08:49 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, 
	Anderson Nascimento <anderson@allelesecurity.com>
Subject: Re: [PATCH 2/2] can: bcm: add missing rcu read protection for procfs
 content
Message-ID: <20250519-cherubic-precious-guppy-3b1619-mkl@pengutronix.de>
References: <20250519125027.11900-1-socketcan@hartkopp.net>
 <20250519125027.11900-2-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rjhumjn2r4f5xonx"
Content-Disposition: inline
In-Reply-To: <20250519125027.11900-2-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--rjhumjn2r4f5xonx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] can: bcm: add missing rcu read protection for procfs
 content
MIME-Version: 1.0

On 19.05.2025 14:50:27, Oliver Hartkopp wrote:
> When the procfs content is generated for a bcm_op which is in the process
> to be removed the procfs output might show unreliable data (UAF).
>=20
> As the removal of bcm_op's is already implemented with rcu handling this
> patch adds the missing rcu_read_lock() and makes sure the list entries
> are properly removed under rcu protection.
>=20
> Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly synchron=
ize_rcu()") # >=3D 5.4
> Reported-by: Anderson Nascimento <anderson@allelesecurity.com>
> Suggested-by: Anderson Nascimento <anderson@allelesecurity.com>
> Tested-by: Anderson Nascimento <anderson@allelesecurity.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Applied and added stable on Cc and moved the # >=3D 5.4 there.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--rjhumjn2r4f5xonx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmgrSX4ACgkQDHRl3/mQ
kZwsfAgAscz6Gnaz9GHfYiWahSYvVpgkxphreu5wwaXNcdwOalWVZsUjK50pq0C9
/1FcKh5TAUYUOqcRiMgiFrxD16m/U53iwxW6JQHkPjreir5g243Pf2isY9f0rgbL
/ZEcuGFD1fzXVVCzL3e6CN5btKzwuBOGQSZ/5WBw4leFFAr2ZO4X00yHyQHufLrl
dYYuf5+x/H+dE7YyTadWHbe7NhhBN5G+/wuutrHAEPJsRoAUazHT4jQGKl1VyfR6
PU4h/VOGHQe346pZjZVNuMCz/8aJ56Jzq1lZgZ+pv3a4ZcL68xaVZhvmUbReTIl/
mQWmkYlLGCq3FhuRq1BATg5zkhGSOg==
=i8U0
-----END PGP SIGNATURE-----

--rjhumjn2r4f5xonx--

