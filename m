Return-Path: <linux-can+bounces-6183-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C51EAD33BC3
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 18:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE54F301DE92
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 17:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8D422F74A;
	Fri, 16 Jan 2026 17:07:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D604B26A08F
	for <linux-can@vger.kernel.org>; Fri, 16 Jan 2026 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583270; cv=none; b=iRFygpm56NZo1jM3mqL56TpeR2Co8hJ167UDtQKr8SzQwgQHO6UupqyWYx2fBKyGFThHKDZJXu3eOnD/yB9PuBt6XITAsfKi50kI9qrfmyrXL/iCiLxh/66A95ubFvz3pvoC9qN9t3T9fwvt2pZKgJIzhLWoQ9Xqq6ncoxbh6cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583270; c=relaxed/simple;
	bh=egpe3C20mkcHstH1aVWsInC7cOEe2pPj/PF2i6WCIqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9pWVWSd+wNnCpxMVssp+g12dOKtOgjsBV2EFK2ocmPoOAelJrYERBQj0VAZIvWnh/Atx8XpA/Ooxw2GcNd6cD5xWQgJmTbXmhOoUehPhiRjUpDFZE0uAoVuGhkn6wcq1SsFkseeeYoqD/Mc3q27MOi0B/m0UnM3673aPVKMSA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgnIY-000735-4J; Fri, 16 Jan 2026 18:07:46 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgnIY-000xQD-1X;
	Fri, 16 Jan 2026 18:07:45 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 822A04CED67;
	Fri, 16 Jan 2026 17:07:45 +0000 (UTC)
Date: Fri, 16 Jan 2026 18:07:45 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, 
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH] can: dev: alloc_candev_mqs(): add missing default CAN
 capabilitied
Message-ID: <20260116-new-masterful-kangaroo-2e3229-mkl@pengutronix.de>
References: <20260116-can_add_missing_set_caps-v1-1-7525126d8b20@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uhvguasuckj7bd2d"
Content-Disposition: inline
In-Reply-To: <20260116-can_add_missing_set_caps-v1-1-7525126d8b20@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--uhvguasuckj7bd2d
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: dev: alloc_candev_mqs(): add missing default CAN
 capabilitied
MIME-Version: 1.0

On 16.01.2026 13:44:22, Marc Kleine-Budde wrote:
> The idea behind series 6c1f5146b214 ("Merge patch series "can: raw: better
> approach to instantly reject unsupported CAN frames"") is to set the
> capabilities of a CAN device (CAN-CC, CAN-FD, CAN-XL, and listen only) [1]
> and, based on these capabilities, reject unsupported CAN frames in the
> CAN-RAW protocol [2].
>
> This works perfectly for CAN devices configured in CAN-FD or CAN-XL mode.
> CAN devices with static CAN control modes define their capabilities via
> can_set_static_ctrlmode() -> can_set_cap_info(). CAN devices configured by
> the user space for CAN-FD or CAN-XL set their capabilities via
> can_changelink() -> can_ctrlmode_changelink() -> can_set_cap_info().
>
> However, in commit 166e87329ce6 ("can: propagate CAN device capabilities
> via ml_priv"), the capabilities of CAN devices are not initialized.
> This results in CAN-RAW rejecting all CAN frames on devices directly
> after ifup if the user space has not changed the CAN control mode.
>
> Fix this problem by setting the default capabilities to CAN-CC in
> alloc_candev_mqs() as soon as the CAN specific ml_priv is allocated.
>
> [1] commit 166e87329ce6 ("can: propagate CAN device capabilities via ml_p=
riv")
> [2] commit faba5860fcf9 ("can: raw: instantly reject disabled CAN frames")
>
> Fixes: 166e87329ce6 ("can: propagate CAN device capabilities via ml_priv")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Applied with fixed subject to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--uhvguasuckj7bd2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlqcF4ACgkQDHRl3/mQ
kZzWSQgAtx1EiNigrD8CFBQSK7nkLyk0pfivv2w1f83TY1TFvoeLudJPN5fknSb8
CQHyU354yr9l4MWlY7gYfn/80pF95NJOjavfTeyaZBwHNJPUzdtJC9yuYp3A0iv8
zD0NxN5Mk8dU4u69tn3l5GKiSnwURfA2dU8I5uDTCc3uKRGk1vJNqDpHHoQIzBKK
TE1cS6CUTl9RKCesmUfOdk5Dzll2lM7EeqSuAe+kAFsvniUMDlCtrpFMGZVXq003
pd5B8ifOFbUwtwvGqP/z+LnIXz2HnXcSKdFKtKGk1nd/2ueGRJt4wwxbapWK7kXf
f0CMAiZ5hWGyeSFjqlFJj//YSc5B4Q==
=GghU
-----END PGP SIGNATURE-----

--uhvguasuckj7bd2d--

