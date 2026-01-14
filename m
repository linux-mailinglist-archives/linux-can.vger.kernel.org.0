Return-Path: <linux-can+bounces-6145-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4225ED1F10B
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 14:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 49FAD300B8AB
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 13:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E0238E120;
	Wed, 14 Jan 2026 13:27:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885811A08AF
	for <linux-can@vger.kernel.org>; Wed, 14 Jan 2026 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768397258; cv=none; b=b6eBEQQbx4Ra7ArEE8uHqF5kPQ7E+EcIyH9BwJmvbuE9avfnwrCxK+9CP09+WTEzkZ0l+kR3N319A8kYt1fwbj6r7/G+2Sa7TzRynX1X11HHaAj3fEpEGsDqFgfcwdiYywmyf+RgLfcz1TKI236LteGvKBVgXOf7KFeAzJYg6CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768397258; c=relaxed/simple;
	bh=A/e9nV3yJKSm2qZeCSc7FJJQQD3BtHGCLoNf9KegyWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2FKp6FgCT2JSmSA7ySoH7mPZ2XwmOC0nxjo46pat2W8KeKeyCImcNHFhu2fXz46RDL1rFAg4VK+zHl0wBV5d9pMPULlkO4FUec5BuIQXWNIIkyggR3GYUXnJvhtZLAd5Usk/xT4lDpn+rrLASnBxJlczyVrektZvzE4CgmmGyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vg0uL-0004Rg-PC; Wed, 14 Jan 2026 14:27:33 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vg0uM-000azz-0b;
	Wed, 14 Jan 2026 14:27:33 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 396634CCD2F;
	Wed, 14 Jan 2026 13:27:33 +0000 (UTC)
Date: Wed, 14 Jan 2026 14:27:32 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH net 0/4] pull-request: can 2026-01-14
Message-ID: <20260114-dashing-foamy-eagle-254a4a-mkl@pengutronix.de>
References: <20260114105212.1034554-1-mkl@pengutronix.de>
 <91cc5ad6-e877-453c-bfd0-8d5ccaad12c7@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mwbu6favn3eh5e5w"
Content-Disposition: inline
In-Reply-To: <91cc5ad6-e877-453c-bfd0-8d5ccaad12c7@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--mwbu6favn3eh5e5w
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 0/4] pull-request: can 2026-01-14
MIME-Version: 1.0

On 14.01.2026 14:09:41, Oliver Hartkopp wrote:
> Not visible in the linux-can repo!
>
> Missing push??

"tags/linux-can-fixes-for-6.19-20260114" was already in linux-can. Now
I've also pushed the testing branch.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mwbu6favn3eh5e5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlnmcEACgkQDHRl3/mQ
kZz4ZQgAqhp7tBYGaML5fBZGilVOUEm3ceiL4xDgbpHUI+eKFErEMLzzIO8U6aVP
an64RMGmlecmFSVgcj6Rx/Cwrwq6mUd+fOXQMtLzMNIBy1SxWoh2qMQKHLr1F+H/
r/ZaDENTGXDrLwmW0nNoDFl6YpHvgGGoXCJUHLTfJZzkimpkP8iA/ugd3FA5+5MQ
iUrbuFaULZ/vfizv5cmdD0a3LZFmpbOUsEMl6lpcaaieXHLDJrsImRWp1tAASSp0
ls4xQ8f89HcqHv/MfN08Z7K4ZXkOXqzNr57AaGhjyhBgpZOxuFLpJicy4c3Nb9Jh
Npjc9Iq2CqPRewBOCbL8IUk9j97xSA==
=yUak
-----END PGP SIGNATURE-----

--mwbu6favn3eh5e5w--

