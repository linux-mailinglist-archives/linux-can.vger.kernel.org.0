Return-Path: <linux-can+bounces-5868-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F51CC6E86
	for <lists+linux-can@lfdr.de>; Wed, 17 Dec 2025 10:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 178D93018941
	for <lists+linux-can@lfdr.de>; Wed, 17 Dec 2025 09:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D6F33F8AD;
	Wed, 17 Dec 2025 09:47:14 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EAF33EAE6
	for <linux-can@vger.kernel.org>; Wed, 17 Dec 2025 09:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765964834; cv=none; b=nD6FbMgQsYDdVJTSNBIiCrDT12cgRDrtYCwo/E30cub8Amqg6HfVvoEXA4YpqUbDMWH9oklOIiYjRy+xGmXyEmYDO56NsqlTXahYrrT9Hc/lDTaDVWD/Vfmeqgpb5O45aW6KSXPvZ1vBIBK77BG1D5360W12TjrunbC5ufqB40I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765964834; c=relaxed/simple;
	bh=WgtSRbBnw0/M7b2pWLJJj+dAdvtCAkF4Jbxbb+Z0tQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2Eb/hsedNj9qs+T3UxDCxvvHUoPvElJZICwbq1NYQVBXti2lR1HRYPCRXsJVqJQse3cvdJrSERCXK9fLEbIbuLf5vNp7yu1aOFXt4QsdZuozV67kJR3ioXoU4c9Hw/omrwydk9A5xUXlcHODxjg1WtElFjaZasHoZMxv7YSB24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vVo7e-0000KS-5a; Wed, 17 Dec 2025 10:47:06 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vVo7b-0065iA-2I;
	Wed, 17 Dec 2025 10:47:03 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 74AB64B771C;
	Wed, 17 Dec 2025 09:47:03 +0000 (UTC)
Date: Wed, 17 Dec 2025 10:47:01 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH] can: j1939: make j1939_session_activate() fail if device
 is no longer registered
Message-ID: <20251217-mysterious-accomplished-caribou-1e7aae-mkl@pengutronix.de>
References: <b9653191-d479-4c8b-8536-1326d028db5c@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gtjk5pkjaohevwah"
Content-Disposition: inline
In-Reply-To: <b9653191-d479-4c8b-8536-1326d028db5c@I-love.SAKURA.ne.jp>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--gtjk5pkjaohevwah
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: j1939: make j1939_session_activate() fail if device
 is no longer registered
MIME-Version: 1.0

On 25.11.2025 22:39:59, Tetsuo Handa wrote:
> syzbot is still reporting
>
>   unregister_netdevice: waiting for vcan0 to become free. Usage count =3D=
 2
>
> even after commit 93a27b5891b8 ("can: j1939: add missing calls in
> NETDEV_UNREGISTER notification handler") was added. A debug printk() patch
> found that j1939_session_activate() can succeed even after
> j1939_cancel_active_session() from j1939_netdev_notify(NETDEV_UNREGISTER)
> has completed.
>
> Since j1939_cancel_active_session() is processed with the session list lo=
ck
> held, checking ndev->reg_state in j1939_session_activate() with the sessi=
on
> list lock held can reliably close the race window.
>
> Reported-by: syzbot <syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.co=
m>
> Closes: https://syzkaller.appspot.com/bug?extid=3D881d65229ca4f9ae8c84
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gtjk5pkjaohevwah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlCfBIACgkQDHRl3/mQ
kZx1dAgAhi1H6yVKfFcynEtrB0c6eLVDbTZHt28eJGiYHDJcJfUrVUP/1LZNwhhd
Nk/un16f/Db8Wn9fCq94oTA4CP6QKVZUOyBzUp4u5yErHr6fWeEmIe552Laj399+
uVG+se1hFfQCj+U3h8C8gnUWhx56CYEqKV75kHb5dwnHZ6DHl9Qfb0gvjY+uR4f8
3GbAd3FdfATwRCeTHIFX1sPSRJ3WLUOcqXHSr+GuUZW3ZS2xtR2+IcoCKyLzSdKM
mY3Xbh5nyGNFWAu/QARK7P8fse23U9oWmhb9pCFmwGs3U+lG4qWCbPAbkZGWi/er
plAM8/kRQePG5hMPExTqHIaqUy4pRQ==
=vZ5c
-----END PGP SIGNATURE-----

--gtjk5pkjaohevwah--

