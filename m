Return-Path: <linux-can+bounces-3849-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAAAADD3C9
	for <lists+linux-can@lfdr.de>; Tue, 17 Jun 2025 18:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59EA1642C7
	for <lists+linux-can@lfdr.de>; Tue, 17 Jun 2025 15:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE582ECEA3;
	Tue, 17 Jun 2025 15:53:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2537C2EE60C
	for <linux-can@vger.kernel.org>; Tue, 17 Jun 2025 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175628; cv=none; b=l8lhewnWKn8eeCDEHaSOx36lLvvWrYGPeMira4Skwx6GRU9IwvGBhqFXlk9zsR2pCoLuOgi+ddw6CwhYungr6AXViOYv5HM9euJeOw35XxguiHLCgKlu4u01kgpqtMS8STo7kSR347cJsspwnq8uN0PWMw9vNNZMs7IzsDMyYEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175628; c=relaxed/simple;
	bh=GvzfkJFVneHZYPW+CHWgs5wGF6uPJgGTGRmiwt7cGMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bD4Ynoi7f+aVkhW+Z3Jdr9lbtNAcX1kcoEYyJemizas46ZLSx5Pn/eWBZ4/60hBm5EEfcnAHHr+8em+o+aPZ4nGmuLpWBWIIB1jM6FMgTy5xfI8oTnq+EwUPYUIEZ9Co+C83aoWumeTu+DCQ5mSO8MXJ9/XjyFUMo3q2eSuPZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRYd7-00052k-FV; Tue, 17 Jun 2025 17:53:45 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRYd7-003znl-0P;
	Tue, 17 Jun 2025 17:53:45 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C69D542AABB;
	Tue, 17 Jun 2025 15:53:44 +0000 (UTC)
Date: Tue, 17 Jun 2025 17:53:44 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Brett Werling <bwerl.dev@gmail.com>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH] can: tcan4x5x: fix power regulator retrieval during probe
Message-ID: <20250617-visionary-bouncy-galago-dbcf1c-mkl@pengutronix.de>
References: <20250612191825.3646364-1-brett.werling@garmin.com>
 <20250613-snobbish-tapir-of-fascination-1dc74c-mkl@pengutronix.de>
 <3302f4d4-a863-4a88-83af-8f09b4191bb3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3fxklf6b323euqrd"
Content-Disposition: inline
In-Reply-To: <3302f4d4-a863-4a88-83af-8f09b4191bb3@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--3fxklf6b323euqrd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: tcan4x5x: fix power regulator retrieval during probe
MIME-Version: 1.0

Hello Brett,

On 17.06.2025 10:17:44, Brett Werling wrote:
> Do you know when the final patch will be available on
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git? I'd li=
ke
> to reference the proper SHA1 when back-porting to my company's kernel
> repository.

I've just send a PR to the netdev team and if I don't get any objections
the patch will go mainline as:

| db2272054520 ("can: tcan4x5x: fix power regulator retrieval during probe")

The commit is now available on
https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3fxklf6b323euqrd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmhRj4MACgkQDHRl3/mQ
kZwJYwf7BwOkEaoYS4FZPwBb0USH4slF/62V4NLporfB7h9JM6J+fGyoxEg1ntJy
30232yOenjppWRnY0PFy/q3EBK+NIioWgyU3aSiXaP61n8fAEOlSxLFI+LyskFqJ
5AqDlIFcUww+gpNpd8IOtjRyA5REKCPQ/C9mGAGwolR0lINrtOcpOrDSVXy0waa4
ZLh+A5YyYFTrvFn/WJuU5cqbd6L7vbERgQ6PY/cWyHn22Lcl8t4pGRNg4fl9x/zK
xV6GZzRjYKwfJg3sgUcMCQW8+2S2Ep4b3MdJQO3jIKNnQaBKk9JL700iObTgxt20
pzycUCKDZCVnkcZW7aPFL6PBE7Brxw==
=Og+N
-----END PGP SIGNATURE-----

--3fxklf6b323euqrd--

