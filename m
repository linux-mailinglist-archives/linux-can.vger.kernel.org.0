Return-Path: <linux-can+bounces-5443-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7579DC617A5
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 16:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D178B3AB581
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 15:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3353226E704;
	Sun, 16 Nov 2025 15:44:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD792264C7
	for <linux-can@vger.kernel.org>; Sun, 16 Nov 2025 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763307848; cv=none; b=cCG8nUx6+NUkCOe+Zq2EZ0QQvxNl9beFNBg1JfAV9OIHsSnpckFJW6Sy1eGVpKA25jSjm7Y8ZkPkr4vLGSir1lkYe9iiNXAEyJj8vt0+fIK/3rFPSUVyeKpI7dn+UoHq429IOhPN8ja3re99zKoCa7ajKzO/bgilgmxAB1VoxBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763307848; c=relaxed/simple;
	bh=asYYzvY1bJw5JgiilVLPLq3agtnHbMENu33w9p5RQjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHhnitPOTkv5cYXsi+JKqNTe/bOMIVhAIlp/RHO1DmKfFLKZHqg+kofY1QX2kpTbWURfM9kod8ch+w41fyvUvbKxGFU16LJALp6Qqpr7BLvDYXI/rVbqzIi16ABl0fYX0ioTwBzEJyR7f26O5mBboaVkqhP+jZ47RMfDAufMDeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vKeux-0005IY-FQ; Sun, 16 Nov 2025 16:43:55 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vKeuw-000lf5-2n;
	Sun, 16 Nov 2025 16:43:54 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6741B4A02FB;
	Sun, 16 Nov 2025 15:25:33 +0000 (UTC)
Date: Sun, 16 Nov 2025 16:25:33 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Thomas =?utf-8?Q?M=C3=BChlbacher?= <tmuehlbacher@posteo.net>
Cc: linux-can@vger.kernel.org, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH] can: sja1000: fix max irq loop handling
Message-ID: <20251116-inescapable-festive-kiwi-40724d-mkl@pengutronix.de>
References: <20251115153437.11419-1-tmuehlbacher@posteo.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jzn7jzr2ldeqjioe"
Content-Disposition: inline
In-Reply-To: <20251115153437.11419-1-tmuehlbacher@posteo.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--jzn7jzr2ldeqjioe
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: sja1000: fix max irq loop handling
MIME-Version: 1.0

On 15.11.2025 15:34:56, Thomas M=C3=BChlbacher wrote:
> Reading the interrupt register `SJA1000_IR` causes all of its bits to be
> reset. If we ever reach the condition of handling more than
> `SJA1000_MAX_IRQ` IRQs, we will have read the register and reset all its
> bits but without actually handling the interrupt inside of the loop
> body.
>
> This may, among other issues, cause us to never `netif_wake_queue()`
> again after a transmission interrupt.

Applied to linux-can and added stable to Cc. Out of curiosity, what
hardware are you using that has an SJA1000 IP core built in?

regards,
Marc
--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jzn7jzr2ldeqjioe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkZ7OoACgkQDHRl3/mQ
kZwcYAf+P9DELWZGEZdtbQIQGhZ/x9rfxyMlZLpNs7IJhIetv60iJ/ADGkboGyAF
T1e+6xWDm6nmW9eGOs+DfZylgYRHq7FbE5Rch6q1b2+S2db7/gQdmtP8/VaI5amL
y++v5+T5WY4Zmlr46PLuKRDIbzl40U4P+cX3C5vg9EZG01GiEozwvvWVDilsCCvc
aVj0mynMe6d9evcwmgsTHaiUOFpUeNanEGi1ufPLH3lb7uUDyI9HQd16TjIMed41
cO5zDkK08+eS6/R6mEg1dYNt4i43qxN1HUN8iWdl0MVj6uQS1dIx2j+xXqaclL7u
absidVAYapEHLzThWnXJFinqtToQRA==
=tztx
-----END PGP SIGNATURE-----

--jzn7jzr2ldeqjioe--

