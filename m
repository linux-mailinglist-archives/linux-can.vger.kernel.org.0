Return-Path: <linux-can+bounces-4515-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A013DB48C44
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 13:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F191B25170
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 11:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A8522FDE8;
	Mon,  8 Sep 2025 11:33:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D3822A4F4
	for <linux-can@vger.kernel.org>; Mon,  8 Sep 2025 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757331223; cv=none; b=braJmOAcGVWCwuYyH2C6qsQbTiTmnB4EarVWFhzIE61b3nH4xwDycsFTxskD1e3kWz0nqgQCiNsjQ+oiSokaMtci4DH6wbrjkorGOI7Uckh7anVuMiZ9y3fU6yLYBXkToojZ/xU5IpXXW9dMJX5IhpYeM0+qwJxBPtSwSRxwN5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757331223; c=relaxed/simple;
	bh=o4uMpmacUmTqj8LQOpsuWStPCxahpVbiMopQUGKhJzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWrxX5sT4Z3ENiiXwbrohHqApHI+W7cK4DL7d05j8xMETdZSb0N3hy1wG6n8eUvgWwyEQOUIwFFxOADiQV7h+mlRI5G7G7lc9MoxnDkcFKG/ouy4FOPHdCfmLtiqqcAVg4CXx8v82mKlxbxR3HQMo68HnBXJIrmbb7ANeuNIZVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uva7v-0005QP-MO; Mon, 08 Sep 2025 13:33:39 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uva7v-000EwQ-1I;
	Mon, 08 Sep 2025 13:33:39 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 169C84690F1;
	Mon, 08 Sep 2025 11:33:39 +0000 (UTC)
Date: Mon, 8 Sep 2025 13:33:38 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org
Subject: Re: [PATCH can-utils] cangen: allow to use -m on classical CAN
 interfaces
Message-ID: <20250908-attentive-walrus-of-snow-0433f5-mkl@pengutronix.de>
References: <20250907060330.441165-1-mailhol@kernel.org>
 <20250908-hilarious-myna-of-relaxation-f26357-mkl@pengutronix.de>
 <4242f299-64c2-47f1-90d5-6381752bc1f3@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j77z7znnli5gmx2t"
Content-Disposition: inline
In-Reply-To: <4242f299-64c2-47f1-90d5-6381752bc1f3@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--j77z7znnli5gmx2t
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-utils] cangen: allow to use -m on classical CAN
 interfaces
MIME-Version: 1.0

On 08.09.2025 13:27:46, Oliver Hartkopp wrote:
> Me too :-D
>=20
> https://github.com/linux-can/can-utils/pull/600

One PR should be enough.

> The former concept mixed the actual frame format (canfd canxl) with the
> switch whether FD/XL is enabled and operable.
>=20
> So I reworked the idea from Vincent.

You should be able to force push your code to my branch ("Maintainers
are allowed to edit this pull request.").

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--j77z7znnli5gmx2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmi+vw8ACgkQDHRl3/mQ
kZz89gf+MmELbjc1OjJ7NWvv151soPeCPssUZDq3jxYTjTAN5z4olE4bJPEZaVck
vF0AxgveI2gzn3PFx0tSCXkK+V/7NxdtVL3+Tm5p30aSE+Enq8M9VE5DkU79+Os6
sh/XXOlfkBdUHKgc1eF/wqaco1VzZIBzEzxwGIktU3ERGyVU4wz3rblL/6pYzeM2
ckB8fL794EzULyX93QgQeW3SZw7YHSCs4jYY2k8HuSCjDscEvjU1pwKaZcPM2yjH
KA3dm5p1mJNDDJZ+Xxm0Bm1OB0gt+MHIyedcoxyjolcnLeg1gmFcmaAEGOqXDswZ
EEFgWtyTEHcZdl+8V3Sa/oWOywvPOQ==
=+p8s
-----END PGP SIGNATURE-----

--j77z7znnli5gmx2t--

