Return-Path: <linux-can+bounces-6087-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE30D0AD96
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 16:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BFADE300925A
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 15:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A7F2877F4;
	Fri,  9 Jan 2026 15:19:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6E91D5141
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767971996; cv=none; b=EvPVh1nRvJTQhLYxX6cXtFMUgdhZGecgoONrzbb27j+KMjxeAiKyLDvOVaVnt7pIC58IHukZsWX1A6jSWK9YroZN1VO6PEIqeIcoCSFpod3QZqtMpWrwqzUxW9slUPo8pL+z9AFndJdoVcQKegwZrAyYA7Bq9OTGzxUum6hBigs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767971996; c=relaxed/simple;
	bh=MCbRP2PMPHZIAHR11KScnrIyiLVZrAJDFOWI/+YKKlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0HZr4XzSZ3WSyHHYLLtTfMAg0xGCv99IN6tCP57VKpGOHSLT1ECaDPthu0l7VHxaOcR9x1akK4pRjltZhieofiNKS4tjAPrSTXgnvSjm0gtH3jf/aO4t+uuVjJkS5TKONRs6p49x4hZb4yI6ptVEpDzYUFBHAWJQPLNLD8cbIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1veEHG-0003q1-Qz; Fri, 09 Jan 2026 16:19:50 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1veEHG-009rp6-1h;
	Fri, 09 Jan 2026 16:19:50 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2965A4C9AA1;
	Fri, 09 Jan 2026 15:19:50 +0000 (UTC)
Date: Fri, 9 Jan 2026 16:19:48 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH 0/3] Revert "can: raw: instantly reject unsupported CAN
 frames"
Message-ID: <20260109-overjoyed-refreshing-eel-f887b6-mkl@pengutronix.de>
References: <20260109144135.8495-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zxrl2z5c6je6njko"
Content-Disposition: inline
In-Reply-To: <20260109144135.8495-1-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--zxrl2z5c6je6njko
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/3] Revert "can: raw: instantly reject unsupported CAN
 frames"
MIME-Version: 1.0

On 09.01.2026 15:41:32, Oliver Hartkopp wrote:
> This reverts commit 1a620a723853a0f49703c317d52dc6b9602cbaa8
>
> and its follow-up fixes for the introduced dependency issues.
>
> commit 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
> commit cb2dc6d2869a ("can: Kconfig: select CAN driver infrastructure by d=
efault")
> commit 6abd4577bccc ("can: fix build dependency")
> commit 5a5aff6338c0 ("can: fix build dependency")
>
> The reverted patch was accessing CAN device internal data structures
> from the network layer because it needs to know about the CAN protocol
> capabilities of the CAN devices.
>
> This data access caused build problems between the CAN network and the
> CAN driver layer which introduced unwanted Kconfig dependencies and fixes.
>
> The patches 2 & 3 implement a better approach which makes use of the
> CAN specific ml_priv data which is accessible from both sides.
>
> With this change the CAN network layer can check the required features
> and the decoupling of the driver layer and network layer is restored.

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zxrl2z5c6je6njko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlhHJAACgkQDHRl3/mQ
kZw6iwf8CgLDUltBp3WLV6ugSxXR5TKunlS9DrzrJJS1y44UUZ9JpTR6qAPcn2o/
+tSnlvGtWbtphcFDk3cQdjJAPIWbaZTJ9aTTRrOSYyimFdQ8rO/MdOtuqCShGfsV
qdvIAUGIOtKzJ7SLh3+ZsUW4939LoEWzR+OSwi2Xi3y6qcOUrN7/wIFic40Xlnts
PW+NZPlvtXFwluVeW4JDnyZjC/5eMU/PYdkaiDt8i6i3pN5FJ7gJJgZSv7f1siSf
9iFXl3nKUnwwyJFAvFWDowIfViYM0qq17OSJv37UFxG6j87WROidge8OihCahY8Y
kpqS1JsjtK40wGvTt+/bzrjohyyjrA==
=+rTa
-----END PGP SIGNATURE-----

--zxrl2z5c6je6njko--

