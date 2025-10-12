Return-Path: <linux-can+bounces-5137-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 571F4BD03FD
	for <lists+linux-can@lfdr.de>; Sun, 12 Oct 2025 16:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 281084E93AB
	for <lists+linux-can@lfdr.de>; Sun, 12 Oct 2025 14:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DB51D63F8;
	Sun, 12 Oct 2025 14:31:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02EE28851E
	for <linux-can@vger.kernel.org>; Sun, 12 Oct 2025 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760279473; cv=none; b=KblpVuTywOcajVTucG6z1k4Ys/rLKfmHn5DqcfYZJLzPxta0ZSMI+CKIqGN4AcY/jzyU9EKnohz7chnP6dsq9/rQC22LPcQK5Zt4v834a09kyZ/ZzlldjzGjNxpF3C2INo5g7GWaCxCPY94rfm8h9U8ngyQRDpfJFk0e+kz0aQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760279473; c=relaxed/simple;
	bh=aGXWk5risK1nzanm4IGd4Dn0QdjY5NZ+YtdY5FtoxrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWXR010Txnbdc6CEDlxEc7yLnAINF+rOHm9bFJIBwwE7OA92vfCNIXsQSFulmJVQZS7+AMv5l1tVcvuYVJEOB9zo0dxl4S1wK1X0IHA8fSa/8ODzcgiVK+kwpcktmkE9QplVtYvfqBN0L+UR4GZ8NuFWc0vU8kJ+JFFaWDK7fmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v7x6K-00051j-RM; Sun, 12 Oct 2025 16:31:08 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v7x6I-003EVc-2N;
	Sun, 12 Oct 2025 16:31:06 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 759E34840BC;
	Sun, 12 Oct 2025 14:31:06 +0000 (UTC)
Date: Sun, 12 Oct 2025 16:31:06 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH] can: j1939: add missing calls in NETDEV_UNREGISTER
 notification handler
Message-ID: <20251012-hallowed-intelligent-slug-be45ec-mkl@pengutronix.de>
References: <3ad3c7f8-5a74-4b07-a193-cb0725823558@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g5v4mchaqyiwgiku"
Content-Disposition: inline
In-Reply-To: <3ad3c7f8-5a74-4b07-a193-cb0725823558@I-love.SAKURA.ne.jp>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--g5v4mchaqyiwgiku
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: j1939: add missing calls in NETDEV_UNREGISTER
 notification handler
MIME-Version: 1.0

On 27.09.2025 21:11:16, Tetsuo Handa wrote:
> Currently NETDEV_UNREGISTER event handler is not calling
> j1939_cancel_active_session() and j1939_sk_queue_drop_all().
> This will result in these calls being skipped when j1939_sk_release() is
> called. And I guess that the reason syzbot is still reporting
>=20
>   unregister_netdevice: waiting for vcan0 to become free. Usage count =3D=
 2
>=20
> is caused by lack of these calls.
>=20
> Calling j1939_cancel_active_session(priv, sk) from j1939_sk_release() can
> be covered by calling j1939_cancel_active_session(priv, NULL) from
> j1939_netdev_notify().
>=20
> Calling j1939_sk_queue_drop_all() from j1939_sk_release() can be covered
> by calling j1939_sk_netdev_event_netdown() from j1939_netdev_notify().
>=20
> Therefore, we can reuse j1939_cancel_active_session(priv, NULL) and
> j1939_sk_netdev_event_netdown(priv) for NETDEV_UNREGISTER event handler.
>=20
> Fixes: 7fcbe5b2c6a4 ("can: j1939: implement NETDEV_UNREGISTER notificatio=
n handler")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Added to linux-can. I've just send out a PR, this will be included in
the next one.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--g5v4mchaqyiwgiku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjru6YACgkQDHRl3/mQ
kZxG0ggAjQa8M47QI+dYw1ppO5ROlW3NFIYdT0VurjJhHsq+KPbkMYmuXGwcbLAX
rjQcR+K9B7gR8E87ltFh/SsV+Cl4AcHw5ORavqSKDEFyfFqqdxwkdy9MUJtRe3bM
rqNqaUHQCaHIqXHJI3E0Den01CSnAM+E0Qwni6FYefSf5iBMLD7R5K5sOlwQ9ySF
OFLFC6UcwnaxQFGy6umRhUkcWsYIRpksvYurAZ95SV+Z2Da+SXbRAbuqB+AWrPgx
05FaZZVFWo+cMGXGLdMTeCBN5qiphVtjO8+A5P8QojzODp3By8QfovVAtET6x6or
259pQs4EKCUHF+cvYYjn4lh+8M+UBA==
=DQuA
-----END PGP SIGNATURE-----

--g5v4mchaqyiwgiku--

