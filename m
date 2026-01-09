Return-Path: <linux-can+bounces-6090-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9935D0B0EA
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 16:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DAEB30CE2E0
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 15:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D2F27FD44;
	Fri,  9 Jan 2026 15:48:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3D7322B7F
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767973714; cv=none; b=F6xWqForgTgLWj/5Rng1amycIsI2k38rQiSZk5JZ4PnN/SvoHZ05Wp9SjlAwBXUIs59CEvU5sFC6NI6vN/FHxxdZRQj+1eMPNL8iejS+c0TQMiS+PlfSoxDd8HaQnu3bthx0H9OLlvN8SOPaWL4Dz97Tej5NE0g2/rQl+Tn2o94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767973714; c=relaxed/simple;
	bh=/Na9DB2i2mLyLEW95rOoA08kWzlBbzql5p2hbORDBEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDj0hPJKSZiMaTkTQBV9aswxEuzbBuAH8JDY75RmjbeOfKcKELoDRUY/nyoqi8QP3cGU43iHbJWFipuTeSESLQJIgn784txF4VrQmxrG8+RAjYZHagY8L6J3hz9cC6UMHT9MW29j+p4KuzLTh1tJNeD4Tfz8XBsjGXtesHCnFHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1veEj0-00072V-Sg; Fri, 09 Jan 2026 16:48:30 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1veEj0-009rwA-21;
	Fri, 09 Jan 2026 16:48:30 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3FE234C9AD6;
	Fri, 09 Jan 2026 15:48:30 +0000 (UTC)
Date: Fri, 9 Jan 2026 16:48:29 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH 0/3] Revert "can: raw: instantly reject unsupported CAN
 frames"
Message-ID: <20260109-inquisitive-hoatzin-of-contentment-7c6ebd-mkl@pengutronix.de>
References: <20260109144135.8495-1-socketcan@hartkopp.net>
 <20260109-overjoyed-refreshing-eel-f887b6-mkl@pengutronix.de>
 <1e64eeef-5c26-4262-b511-49c754c26158@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="midyjramlgmdwx3g"
Content-Disposition: inline
In-Reply-To: <1e64eeef-5c26-4262-b511-49c754c26158@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--midyjramlgmdwx3g
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/3] Revert "can: raw: instantly reject unsupported CAN
 frames"
MIME-Version: 1.0

On 09.01.2026 16:42:57, Oliver Hartkopp wrote:
> > Applied to linux-can.
>
> Thanks!
>
> Unfortunately we had some snow problems here so I missed your PR.
> =C2=AF\_(=E3=83=84)_/=C2=AF

I've some patches to write, so there will be another one soon.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--midyjramlgmdwx3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlhI0oACgkQDHRl3/mQ
kZzc0wf/QlfCyTbU1Xn9E7yLRQkWpmlfGcjjmmZuNcVZLiYL0zG+r+wKA/c7tS4F
YJknt7f3QDxMcaUIIMgGd5Up0kkuRzqdJwa9KXGkaRKgPXIXjPO3U2Osl+WwCgWE
d27Ov2dnj/bmD+ze9Tk7EFB8N0CDhlRz1Uefbx5jIhQpuWcIKQlJ7olx2dgs2rl2
2RgUwSqsBjCp3cfz0lhLjba6N11CCOWQV1LZZZRFjXzIvyyAmLoL3D9RbFNmFGmZ
MJZoie/SR8Sc44W1ztX84JW7Wj1YjX8vJGdzYCmKvbJ1fAjrIalBkSVzf5EZ6V45
VNPDsg7fJOitvDwfAYunrLoCzV+NSQ==
=X2jM
-----END PGP SIGNATURE-----

--midyjramlgmdwx3g--

