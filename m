Return-Path: <linux-can+bounces-3958-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C20B3B018B1
	for <lists+linux-can@lfdr.de>; Fri, 11 Jul 2025 11:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA710B46B3D
	for <lists+linux-can@lfdr.de>; Fri, 11 Jul 2025 09:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D3E27C875;
	Fri, 11 Jul 2025 09:48:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E414120F07C
	for <linux-can@vger.kernel.org>; Fri, 11 Jul 2025 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227331; cv=none; b=pSUu7sWspSYFa16Vll1aYymIlVU8NGhdN/DkdfgRTkxZEWt/EkuF1tIKpOPBBzzgaifnktNzLg1CoM68WS7/02AnuLtl6cQUx+HLzJwbIPag2pv0ZMG9sEFeZHb63xKFkaMxr9bSFj4fq7RxPOyHFdGHkzt3Qqq1qf+XYFNDHWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227331; c=relaxed/simple;
	bh=XE04xjW8Ih8MjJqQrwcHCMZEgNqRZvl5cOT9qaT/7HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRpDB0L1bfptW1CZGAYPpOCp63qy9mQ4q+qojimouw4b5/7whUCh8R0fIcBsSEMkMyfncoPyKsPGpKdilF+YYY95lloSmB1QzMAPE5mxUeP2dR0PKrZC23YqK9860/IA5IshwXZk6pGfO7cgtdryBhgpQEDGxpHBQRQiVsNqK8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uaAMx-0007Hr-RZ; Fri, 11 Jul 2025 11:48:39 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uaAMw-007tqA-0z;
	Fri, 11 Jul 2025 11:48:38 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EFAD343C77D;
	Fri, 11 Jul 2025 09:48:37 +0000 (UTC)
Date: Fri, 11 Jul 2025 11:48:37 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, linux-can@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH v2] can: rcar_canfd: Drop unused macros
Message-ID: <20250711-expert-vengeful-urchin-9419f5-mkl@pengutronix.de>
References: <20250702120539.98490-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ayyagcjcd6zy664r"
Content-Disposition: inline
In-Reply-To: <20250702120539.98490-1-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ayyagcjcd6zy664r
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: rcar_canfd: Drop unused macros
MIME-Version: 1.0

On 02.07.2025 13:05:29, Biju Das wrote:
> Drop unused macros from the rcar_canfd.c.
>=20
> Reported-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Closes: https://lore.kernel.org/all/7ff93ff9-f578-4be2-bdc6-5b09eab64fe6@=
wanadoo.fr/
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ayyagcjcd6zy664r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmhw3fIACgkQDHRl3/mQ
kZwxuggAk3XM8kUBt5sCB8IgNc+xXLujHbRWgpABtj7VuNTfDF/Nglp+xHh/xGHt
62gSc85PhiDj3Bik+hYR5LnWKl0P92x3hltGuWsePGvPv4ha7rp8LDICYy2mSckY
L+PJUNNESpiSNRIdwpdrk2U/a5PFANw1GwUdMkGSoJ5bUw0XhCyDfSSocSaKUe/J
yf+VZ8Tq13xWZBKWcEDJ9+q71CVZsdfayVRYwFEezzDTOJ/chxI321KExUTW/xij
5BD32NmEvEjxXCmQCgrqw3vqzCzggw8uavD7m7GoAByTCXfh4bR1OCqsMuYPmJP4
6Lkknu6ij97AIBH8gPr9zjoNQ9eS6Q==
=qgPY
-----END PGP SIGNATURE-----

--ayyagcjcd6zy664r--

