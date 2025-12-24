Return-Path: <linux-can+bounces-5929-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E5BCDC2C7
	for <lists+linux-can@lfdr.de>; Wed, 24 Dec 2025 13:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10AA730184D1
	for <lists+linux-can@lfdr.de>; Wed, 24 Dec 2025 12:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8215F314B76;
	Wed, 24 Dec 2025 12:03:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C6E23E356
	for <linux-can@vger.kernel.org>; Wed, 24 Dec 2025 12:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766577786; cv=none; b=o0h22Ppa8vtNCGOSynn6lU6oIg/XgHSlyajGFSG1DIknYllRl+IUk4zQh286Ea5r+y2cOhlxXDYRr1aLDamJxm5j5/tjiH3qTa7qCXFx54o/9PFTE4OZaB2LRr4942DeKyZ8c50M8Noxgog5ylzFv7drwW+jI01QBHf+3WsWgFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766577786; c=relaxed/simple;
	bh=NRpVnURBhU4QBVbtsTM99DWWfTpKw6D+I7VLpgW/2SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8Uihcu3XC9liVwv1qd5H4hCglbyGifvHD5zqnnoFshY71vey0c1vx1RXvY4AmfjKV/hLuWe86JJfDCJVzjJzDgI3eh/i4HTbk7gHXKJBCG0sfVh1NWUwZN7a6nOC5KMcLHo7VBFEMVBNCWTPBjRf+23TduLJdWWg1hBuZJoN78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vYNZt-0005NE-7o; Wed, 24 Dec 2025 13:02:53 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vYNZs-007Fg4-2L;
	Wed, 24 Dec 2025 13:02:52 +0100
Received: from pengutronix.de (2a02-8206-2419-3200-aee2-ccb5-e6fb-2dd9.dynamic.ewe-ip-backbone.de [IPv6:2a02:8206:2419:3200:aee2:ccb5:e6fb:2dd9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 40A194BDB43;
	Wed, 24 Dec 2025 12:02:52 +0000 (UTC)
Date: Wed, 24 Dec 2025 13:02:50 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Szymon Wilczek <swilczek.lx@gmail.com>
Cc: mailhol@kernel.org, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+e8cb6691a7cf68256cb8@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] can: etas_es58x: allow partial RX URB allocation to
 succeed
Message-ID: <20251224-shrewd-dog-of-focus-f974d2-mkl@pengutronix.de>
References: <20251222154208.22117-1-swilczek.lx@gmail.com>
 <20251223011732.39361-1-swilczek.lx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l2vchrqzlq5qqkx7"
Content-Disposition: inline
In-Reply-To: <20251223011732.39361-1-swilczek.lx@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--l2vchrqzlq5qqkx7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: etas_es58x: allow partial RX URB allocation to
 succeed
MIME-Version: 1.0

On 23.12.2025 02:17:32, Szymon Wilczek wrote:
> When es58x_alloc_rx_urbs() fails to allocate the requested number of
> URBs but succeeds in allocating some, it returns an error code.
> This causes es58x_open() to return early, skipping the cleanup label
> 'free_urbs', which leads to the anchored URBs being leaked.
>
> As pointed out by maintainer Vincent Mailhol, the driver is designed
> to handle partial URB allocation gracefully. Therefore, partial
> allocation should not be treated as a fatal error.
>
> Modify es58x_alloc_rx_urbs() to return 0 if at least one URB has been
> allocated, restoring the intended behavior and preventing the leak
> in es58x_open().
>
> Fixes: 8537257874e9 ("can: etas_es58x: add core support for ETAS ES58X CA=
N USB interfaces")
> Reported-by: syzbot+e8cb6691a7cf68256cb8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3De8cb6691a7cf68256cb8
> Signed-off-by: Szymon Wilczek <swilczek.lx@gmail.com>

Applied to linux-can.

Thanks,
Marc

P.S.: There's no need to send a vN+1 patch as reply to vN

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--l2vchrqzlq5qqkx7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlL1mcACgkQDHRl3/mQ
kZzP+gf/aP8pVg76LEpyxP8d37BtSH3A1FJi0O2MTPmaUBA2pOCyVGcyxH4YGkfw
lZfbWqp8hduCXNNktGIhtnqqlIF7SNI9aMXwoEcFsIfNiva5k1wahRjtykAIotuO
xPf5RWHS1YIo3HexbfVugeGPMoE1u43fKSkQw/4sXTeIdJXypAxYaQ/loyxK5DEZ
2ii3uwi3YiF0+rg8TmF08opXjvLzUUwt3Zz2Hxb1B/NQajr9hnTWGt3nNIWu26Ps
4el9yN29CS6dKFNlM5EEZQv3p6P17Qh7EPNXOSwZKIIWOgQ0UKrNlyQaCIt2iS4f
XA/ZN7mkAwLNqyRV6An0GPHC3EfHBg==
=zLh8
-----END PGP SIGNATURE-----

--l2vchrqzlq5qqkx7--

