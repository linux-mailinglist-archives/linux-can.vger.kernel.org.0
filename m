Return-Path: <linux-can+bounces-6034-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7220D024D5
	for <lists+linux-can@lfdr.de>; Thu, 08 Jan 2026 12:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C2FA313CB53
	for <lists+linux-can@lfdr.de>; Thu,  8 Jan 2026 10:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41671364023;
	Thu,  8 Jan 2026 09:41:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32DC357A55
	for <linux-can@vger.kernel.org>; Thu,  8 Jan 2026 09:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865304; cv=none; b=syP2cunVPGBjg5ykXgEbY7q78TBXzcqzSIgUdiI2QQG+g7tiGPfVnsrE6XiZ863AfgLyzCtSIYq3HoUQEDfcYIlThCvHHaWkKb00laVYJUHuH1bCABTyBVgySyiTbrHxfcfhvabaMgXCUvQdH5wgqPfyMZ9UzSm22zZ0yyP+9UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865304; c=relaxed/simple;
	bh=1PhqGUhfEnT8X0ylisS0etWGcKD9wt4b7scMOeaVceY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIRT8iUIhLLBa3ND35KxH1/7XEO3TU+Ljw7QZhWTIHpM9NtmCDe2Y6Vw3Z7+IpwfubQEU95VxNkE1pZ5X6p+BdLr+k4Wg2hsv48zjeKqzm4iNwp/LZd2V3qLiAQiOxrE1rJa1IWQga4QX19PtH7FA8n6duNCbrY3e4ksrK2tPC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vdmWL-00031X-N6; Thu, 08 Jan 2026 10:41:33 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vdmWL-009ehR-1e;
	Thu, 08 Jan 2026 10:41:33 +0100
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:bd31:e383:3245:3d0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2E2CD4C8701;
	Thu, 08 Jan 2026 09:41:33 +0000 (UTC)
Date: Thu, 8 Jan 2026 10:41:31 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Kery Qi <qikeyu2017@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: mcp251xfd: fix UAF from workqueue double-destroy
Message-ID: <20260108-quoll-of-exotic-vitality-a7ceaa-mkl@pengutronix.de>
References: <20260108082042.1627-1-qikeyu2017@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4cfsa7ikvg572mkj"
Content-Disposition: inline
In-Reply-To: <20260108082042.1627-1-qikeyu2017@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--4cfsa7ikvg572mkj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: mcp251xfd: fix UAF from workqueue double-destroy
MIME-Version: 1.0

On 08.01.2026 16:20:42, Kery Qi wrote:
> mcp251xfd_open() allocates priv->wq after the controller is started.
> If request_threaded_irq() or mcp251xfd_chip_interrupts_enable() fails,
> the error path destroys the workqueue but leaves priv->wq unchanged.
>
> This leaves a dangling non-NULL pointer that can later be destroyed
> again, for example:
> - a retry to open the device fails before priv->wq is reallocated and a
>   later close/remove cleanup destroys the stale pointer; or

Can you point me to the exact code path.

> - reset/recovery paths end up calling mcp251xfd_stop() after the failed
>   open and destroy priv->wq again.

mcp251xfd_stop() is only called from net_device_ops:

| static const struct net_device_ops mcp251xfd_netdev_ops =3D {
| 	.ndo_stop =3D mcp251xfd_stop,
| }

Is this ndo_stop is called if ndo_open failed?

> Clear priv->wq after destroy_workqueue() to make teardown idempotent and
> avoid double-destroy/use-after-free crashes.
>
> This is the same bug class as CVE-2024-26802 (stmmac workqueue teardown).

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--4cfsa7ikvg572mkj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlfe8gACgkQDHRl3/mQ
kZy5Uwf8D0tAXLcHJfwvFbWkqG8Qc+dA2/JvkAMGKSB2Hp+nFRxNr8xRuCSD4iWf
njxENeRYtdZiS4kYqwpLIVLq+OXZ4kugZppUtL8qgm+nIEom/+pGHDzRfud8RCIA
hTnPWc5HMFAdeFWYVFT/FBQYvKA1b10i6e16Ef+xj6PgglA0rnAKsmFVkZsDEYLG
4iUgVOqhHsRFR3vvaaWfRuqGRZ0eMEFsZlQrE5hC9Rmf4PEbWjtSJroKxmlbzRHG
N+3eUXw/X1smQdbsUf00FUERqQpRCsc9LtpSD9nNlBxRxQWElRkse4IdXJ+t7KTk
XFWf+tM+U3E7J7mH+AILcNB9T8Qj1Q==
=/7jS
-----END PGP SIGNATURE-----

--4cfsa7ikvg572mkj--

