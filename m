Return-Path: <linux-can+bounces-4755-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 297B9B8AC1E
	for <lists+linux-can@lfdr.de>; Fri, 19 Sep 2025 19:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6641893E0C
	for <lists+linux-can@lfdr.de>; Fri, 19 Sep 2025 17:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E72B258ED6;
	Fri, 19 Sep 2025 17:26:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FDD155A30
	for <linux-can@vger.kernel.org>; Fri, 19 Sep 2025 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758302804; cv=none; b=L5bQxNbmoOlcFDI2RuBs6MMGJaSFDJiiC5qREhdGpy+bzqr1Ici6Qv0Uawzo5Y29d/RFFuCvY25C3p5ZVXOxmsCsY7Qky/X9xQd0eHJEan2/Nz2onmjt2v6EeGWCpTw+IxSPOk1VHuQ3tajgy4rz1cFoX9mdwPLSUCo1bJq0Bpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758302804; c=relaxed/simple;
	bh=B+urOrqmBB+3QdP9Plmm538jf6VIjLUppsmdToePA7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ak0yW1IYRObC2C2PnflK8aoYUzGHc0GDAmSmhePyPwPUdz0n26r0km7xJHejVhbDba13/OLGTYtcEPXlwDuwpWYalMOsGcPxLe70sSM8TrIpdsmkeJyyAevFG4nDbWqs9+niJUGrgiOFjiB6bWxMhFI7iyT68Z+/JZibo+A+Mdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzesb-0004GO-0W; Fri, 19 Sep 2025 19:26:41 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzesa-0028qA-1k;
	Fri, 19 Sep 2025 19:26:40 +0200
Received: from pengutronix.de (ip-185-104-138-125.ptr.icomera.net [185.104.138.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 720784750E5;
	Fri, 19 Sep 2025 17:26:39 +0000 (UTC)
Date: Fri, 19 Sep 2025 19:26:35 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 00/11] can: rcar_can: Miscellaneous cleanups and
 improvements
Message-ID: <20250919-aquatic-invisible-bird-19f49c-mkl@pengutronix.de>
References: <cover.1755857536.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u46zhikjaei36jib"
Content-Disposition: inline
In-Reply-To: <cover.1755857536.git.geert+renesas@glider.be>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--u46zhikjaei36jib
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 00/11] can: rcar_can: Miscellaneous cleanups and
 improvements
MIME-Version: 1.0

On 22.08.2025 12:17:01, Geert Uytterhoeven wrote:
> 	Hi all,
>=20
> This patch series contains miscellaneous cleanups and improvements for
> the R-Car CAN driver.  I deliberately sent this as a separate series
> from "[PATCH] can: rcar_can: Fix s2ram with PSCI"[1], to avoid blocking
> the latter.  However, this series (in particular [PATCH 3/9]) does
> depend on it.
>=20
> Changes compared to v1[2]:
>   - Convert new Runtime PM error messages to %pe,
>   - New patches 10 and 11.
>=20
> Thanks for your comments!

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--u46zhikjaei36jib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjNkkcACgkQDHRl3/mQ
kZx0xgf/ZUxi15DJOWGyX9v3T/lgJDmyCeRNQoujDGxcCiTuod2gm1gVJeZ8Apq9
HwdfsA7de7BE1tby51J4X2lhQ0k/GihJ809ERYOObh4R94DAtgxtLkkbwAdkpvL9
PePCMxx+xOIN2Ubgq9xklfE23QdzauVlmJWRrbdoGXmo10i+MH3f07wCc4zcmvKF
/j67XfSaWRwKHihMHKyzuVrr9QIRCrkPhzkiFcN21u8/hFO5p3OEm0JgI3lGcgpo
jwO75gPZ1EWxh1sriQ1LhkyembanuwiLfs6znRo0l/tawulM0zETjr3yi0UFnbFS
LQVIgUP4g7oQ3JFKH0d0rBHX8D3CSA==
=v2jw
-----END PGP SIGNATURE-----

--u46zhikjaei36jib--

