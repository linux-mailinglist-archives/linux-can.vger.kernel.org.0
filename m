Return-Path: <linux-can+bounces-3470-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10B4A9AE8F
	for <lists+linux-can@lfdr.de>; Thu, 24 Apr 2025 15:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E5416B5FD
	for <lists+linux-can@lfdr.de>; Thu, 24 Apr 2025 13:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D7827CCD7;
	Thu, 24 Apr 2025 13:11:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CA7E545
	for <linux-can@vger.kernel.org>; Thu, 24 Apr 2025 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745500319; cv=none; b=MaBb3mFiwBKPikootD2BEswLn90p5Flq9wYKXw+bR92RIEgI6zF9U+P8Itio/FB8osNEsCqZArz2KFqRiLReWgZwSkgB/NVwjmdflJeq3YNvfraABjEZGgSypzxkUHGj1ZnO1xAlpreVXdqkKoJLaVlGlGpAOgN6v9DUcTOJmuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745500319; c=relaxed/simple;
	bh=C/Q8y1WOoI79mrUc5AXR5uiVEkK5ZuZpj0XY0ZtO+X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yvt4M9X6w2r4Rvi00muD/EbNCbA9k9pre+Ix3gsYceyF54N6zwlnwrAqg7FykR//5fh+kcVxK1BzerAxh2yEOk9ojnNnGp0wO2Bod+ComTmJp1gKXhFRm3ZE9alLUUW0uIwqV7y2uaONX6F+2p/GOjEA6Pz6/Uvm8ggfxtXQIHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1u7wMs-0006vL-DW; Thu, 24 Apr 2025 15:11:54 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1u7wMr-001tDV-0t;
	Thu, 24 Apr 2025 15:11:53 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D1028400B40;
	Thu, 24 Apr 2025 13:11:52 +0000 (UTC)
Date: Thu, 24 Apr 2025 15:11:52 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Antonios Salios <antonios@mwa.re>
Cc: rcsekar@samsung.com, mailhol.vincent@wanadoo.fr, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, lukas@mwa.re, jan@mwa.re, 
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH] can: m_can: initialize spin lock on device probe
Message-ID: <20250424-industrious-rottweiler-of-attack-e7ef77-mkl@pengutronix.de>
References: <20250424125219.47345-2-antonios@mwa.re>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4xawpvijbzqi6nhz"
Content-Disposition: inline
In-Reply-To: <20250424125219.47345-2-antonios@mwa.re>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--4xawpvijbzqi6nhz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: m_can: initialize spin lock on device probe
MIME-Version: 1.0

Hello Antonios,

On 24.04.2025 14:52:20, Antonios Salios wrote:
> The spin lock tx_handling_spinlock in struct m_can_classdev is not being
> initialized. This leads to bug complaints from the kernel, eg. when
> trying to send CAN frames with cansend from can-utils.

Thanks for your contribution, that's a good catch!

> This patch fixes that by initializing the spin lock in the corresponding
> device probe functions.

The spin_lock is only used in m_can.c, so it's better to be initialized
there.

Please add a fixes tag:

Fixes: 1fa80e23c150 ("can: m_can: Introduce a tx_fifo_in_flight counter")

I've also added Markus on Cc, who introduced the spin_lock.

regards,
Marc


--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--4xawpvijbzqi6nhz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmgKOJUACgkQDHRl3/mQ
kZy6Owf/b2L6Bn5o2hjsAMj82tkKqpAYWWrEBq7jN79SC1v9FmyAMG276AsPR4Cw
ssE+fmTQ9htgAzDFprC90KruobaEKUdDBtRGQO+bktZOkxBJ7WF49mXB7WQdi7gJ
HwM5R1dgVgjCPSy01AkD7BQI+4suCcwWepuX7KTRLi33pLHnkHXsca//K98EWYBX
zSlraNg5Oq1alB+XpLFulTvIwg5/JHVIIiJDqsH+D3sFhWJBJkOzFUhh5k0lw5lF
6AsbHAc8F967kBuOCHZej1ihSPBnPsIElpC7ZyMiemG1PLaB9jwTHHf1N1C6MPmE
jp3SCFAJFcmVSgzsyzpQRg6k4NEtMA==
=5GTM
-----END PGP SIGNATURE-----

--4xawpvijbzqi6nhz--

