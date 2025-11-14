Return-Path: <linux-can+bounces-5399-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6EFC5D584
	for <lists+linux-can@lfdr.de>; Fri, 14 Nov 2025 14:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2203B7E11
	for <lists+linux-can@lfdr.de>; Fri, 14 Nov 2025 13:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A49041C72;
	Fri, 14 Nov 2025 13:28:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA19221F0A
	for <linux-can@vger.kernel.org>; Fri, 14 Nov 2025 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763126914; cv=none; b=ptXZGsLC+oCGcAdRirPbtv08ZXKP/hH4RFJi5jrl75FOX6gy4T3KZe7JUzeSJRcKA/Y4vSb1OeN7V9P1bJvoYauTHlnyVuVTGeFIww6UNHpCL78qX4dX/ig/zGkYPf/todaERkpqeF0kSeSSWAJCW4hxemnt6vp32QVe009fJ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763126914; c=relaxed/simple;
	bh=yEijyplpZGr7/4zEBY7gIZG1qqV8bFfnbaLNM3vZf5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaGN88OZx15UAdT8tBg4I0mRyLEk0Hx11yw5mlO5ygZ8cTJbdSaYS8xc9jVbM4a/BcOBW17WlInOwokRGDDd2j4dks8WzqzwQcS8zNGMWoJ7bgpmqxSPQICoi47hr3OMBoYSzQv3uElWoUpTTMj8DSVLOspLegtrt6CGFnA4tGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJtqd-0003vN-Jy; Fri, 14 Nov 2025 14:28:19 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJtqd-000Qjk-0l;
	Fri, 14 Nov 2025 14:28:19 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E047049F5B4;
	Fri, 14 Nov 2025 13:28:18 +0000 (UTC)
Date: Fri, 14 Nov 2025 14:28:18 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: zhangqing <zhangqing@rock-chips.com>
Cc: robh@kernel.org, conor+dt@kernel.org, heiko@sntech.de, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, cl@rock-chips.com, kernel@pengutronix.de, 
	mailhol.vincent@wanadoo.fr, krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 3/3] net: can: rockchip: add can for RK3576 Soc
Message-ID: <20251114-amorphous-guillemot-of-awe-871e2c-mkl@pengutronix.de>
References: <20251113075419.482940-1-zhangqing@rock-chips.com>
 <20251113075419.482940-4-zhangqing@rock-chips.com>
 <20251113-slim-foamy-gecko-2dc389-mkl@pengutronix.de>
 <176d96b4-397c-49d4-8e8e-2f77a5d59c12@rock-chips.com>
 <20251114-utopian-cheerful-otter-33c1d5-mkl@pengutronix.de>
 <3233894e-9409-4b74-a954-0b30064c3c8c@rock-chips.com>
 <20251114-illegal-flounder-of-maturity-edc269-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="entuv2nh3gx4wcbx"
Content-Disposition: inline
In-Reply-To: <20251114-illegal-flounder-of-maturity-edc269-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--entuv2nh3gx4wcbx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 3/3] net: can: rockchip: add can for RK3576 Soc
MIME-Version: 1.0

On 14.11.2025 14:22:42, Marc Kleine-Budde wrote:
> > For RK3576 SoC, the IC hardware design supports CANFD.
> > However, a license application is required before it can be used; other=
wise,
> > there will be legal risks.
>
> INANL. If an SoC is supplied without a license for the IP cores that you
> want to use in a product you sell, you must purchase a license from
> Bosch:

AFAIK the same applies to the "CTU CAN-FD IP core", which is already mainli=
ne.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--entuv2nh3gx4wcbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkXLm8ACgkQDHRl3/mQ
kZxkWAf/XmdTZDXXJ6DlNXHOIMGMpYO/3VE+v2MkC2G7jqHuFn+mIt3qM1iYwyEr
yWcVqSPUFwZi7GhSX+qTgA8bB4kxF34UL30WS/QDE8HK7gXQ+fBXtJUqeUiAPnIl
8hMiNNEr/78RFISeu21cbB/Xgif+AoPY+V4S6iltsSi21DTaFiZTRtJeIUXWB8Qd
QYdGQaRUFMUX0Q3xpdYFV6de0ZPHj0dFZqULjuPZehvzeVHrcFY5QPxikzw+oD1P
wLfHsFF3aAFqLbgGE965ia9EnwBJl4gM/V78/7Y5adh3JmwXMO4iDEJ6QKgukl8F
gqbegfsz4kkUkunpWLEwhBrGYs057A==
=3CsA
-----END PGP SIGNATURE-----

--entuv2nh3gx4wcbx--

