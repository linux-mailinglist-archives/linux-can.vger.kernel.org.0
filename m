Return-Path: <linux-can+bounces-5869-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB4ACC6F10
	for <lists+linux-can@lfdr.de>; Wed, 17 Dec 2025 11:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67BB43046D77
	for <lists+linux-can@lfdr.de>; Wed, 17 Dec 2025 09:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C06344045;
	Wed, 17 Dec 2025 09:49:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B43A3446D5
	for <linux-can@vger.kernel.org>; Wed, 17 Dec 2025 09:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765964942; cv=none; b=TaPVsGGZNIHtY98F6GIeu2peypWCjpqoO+wW0OBYywTLGQHKqiypj8p/TC9I0NeF1T3CKYCUi9KR9UPJiQl0uO2DgWpbJRlyg8c89Y5tt2CxpZt8gAzTK0i8VoRpO6XzZ9jM4MESemTlVzeWx7ywEedEe8QsENm/AD0X+3AEcgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765964942; c=relaxed/simple;
	bh=0Cx8H3lRCBr3OdhAY3NTbw7dA06kKvk9QR8BAA46K2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRZpKIsjfzOGJkYkJikosEDlwEgYpVwZ55Wre1378QXQPsKZMTvcxNhD/jXBXUGI8+JwixyE0laeXWcdDv83G02G+ByDiWSlZvENc/EvB3ZOd0eohTE0CCRW31l8knDgLBGKmrxc1uPfUXLDB0WXfgROXF1cDsBujTJ6tlEHwEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vVo9Q-0000Vl-8V; Wed, 17 Dec 2025 10:48:56 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vVo9Q-0065iJ-02;
	Wed, 17 Dec 2025 10:48:56 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AF8A34B771F;
	Wed, 17 Dec 2025 09:48:55 +0000 (UTC)
Date: Wed, 17 Dec 2025 10:48:55 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH v2] can: j1939: make j1939_sk_bind() fail if device is no
 longer registered
Message-ID: <20251217-aspiring-dragonfly-of-chivalry-571ccf-mkl@pengutronix.de>
References: <9a3f9a95-1f58-4d67-9ab4-1ca360f86f79@I-love.SAKURA.ne.jp>
 <5732921e-247e-4957-a364-da74bd7031d7@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="liabczl5po3b6i2b"
Content-Disposition: inline
In-Reply-To: <5732921e-247e-4957-a364-da74bd7031d7@I-love.SAKURA.ne.jp>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--liabczl5po3b6i2b
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: j1939: make j1939_sk_bind() fail if device is no
 longer registered
MIME-Version: 1.0

On 25.11.2025 22:43:12, Tetsuo Handa wrote:
> There is a theoretical race window in j1939_sk_netdev_event_unregister()
> where two j1939_sk_bind() calls jump in between read_unlock_bh() and
> lock_sock().
>
> The assumption jsk->priv =3D=3D priv can fail if the first j1939_sk_bind()
> call once made jsk->priv =3D=3D NULL due to failed j1939_local_ecu_get() =
call
> and the second j1939_sk_bind() call again made jsk->priv !=3D NULL due to
> successful j1939_local_ecu_get() call.
>
> Since the socket lock is held by both j1939_sk_netdev_event_unregister()
> and j1939_sk_bind(), checking ndev->reg_state with the socket lock held c=
an
> reliably make the second j1939_sk_bind() call fail (and close this race
> window).
>
> Fixes: 7fcbe5b2c6a4 ("can: j1939: implement NETDEV_UNREGISTER notificatio=
n handler")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Applied to linux-can.

Thanks,
Marc

P.S.: Don't send a -vN+1 patch as a reply to a -vN. Please start a new thre=
ad.

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--liabczl5po3b6i2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlCfIQACgkQDHRl3/mQ
kZz4GggAjsfRBVAEWCV327hQ9lSngrFDWaDHKFgYtkp8B82SdLyv7+1alAQ7Iyve
fgdyBdT7ulO6BazLpqDJLd0QhInper8noijIWX04vS0zc7zdCMTMYGjIRm/jurMn
Iy04ja+v7Hti7ZevwrdV5Nfev3IdJ/CcKKmB3ES9oNkTqZAzp35C0Gp8uXeeyaYP
naPyrkEgSZJgz+pRzcWjgd6ePuYJqWwMw81hCxt2849/Mh31LvRd66yLf/141Nzx
Ogqew3f9YicJtfGAVP27cLculJaU4Sd1/Po78Ap/qnDDa1sJ8uneBTbb1t5/lLcS
uwWcACRdpg0omoEghJYRZmRG0Gst1g==
=sRzp
-----END PGP SIGNATURE-----

--liabczl5po3b6i2b--

