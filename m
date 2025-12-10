Return-Path: <linux-can+bounces-5834-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6DECB254A
	for <lists+linux-can@lfdr.de>; Wed, 10 Dec 2025 08:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F6BE3074747
	for <lists+linux-can@lfdr.de>; Wed, 10 Dec 2025 07:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD232D73B8;
	Wed, 10 Dec 2025 07:53:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0267A27F4F5
	for <linux-can@vger.kernel.org>; Wed, 10 Dec 2025 07:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765353208; cv=none; b=eYrgwALZ0qtGzF7QRcNOPK0GSMkbmYh54PtAn9amGPHusdjcLiEAOpBdEfZPpsCiYPTo+FOQi+xXFyqwzEfo/bls3Ze72OoHnc+QboNdv6qfflFg+NHDp4QkM2zlAQwFHn51K4J930a5dn6KWTG10RFUhazlXmoHq3hZei5wf70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765353208; c=relaxed/simple;
	bh=3kuGZOTUwPOsrIgNaRKdJ33+hh3Yox1Ms/LqZ7sTvK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V53haY/RMWtMnyCFfTOnoPBPy6S19YI2E7tDR/4tj9AlOoZR1PN+iCJlR0JZIz+zlxpO+/KPgCDvH3yoWdUy8OmCldPzVRFzJSOhbx9v3EJ4+DksfO8pCITEUgq5eVA+4DupNhvn9nFKHLHAqUIYdWryOtQqad716icJoj9q9X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vTF0Q-0003HH-GJ; Wed, 10 Dec 2025 08:53:02 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vTF0O-004uxp-1R;
	Wed, 10 Dec 2025 08:53:00 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 150BD4B3A9F;
	Wed, 10 Dec 2025 07:53:00 +0000 (UTC)
Date: Wed, 10 Dec 2025 08:52:58 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Aswath Govindraju <a-govindraju@ti.com>, Frank Li <Frank.li@nxp.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2] dt-bindings: phy: ti,tcan104x-can: Document TI
 TCAN1046
Message-ID: <20251210-mauve-cow-of-hurricane-0f969d-mkl@pengutronix.de>
References: <20251209162119.2038313-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e6urrv5hrowjmz7i"
Content-Disposition: inline
In-Reply-To: <20251209162119.2038313-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--e6urrv5hrowjmz7i
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] dt-bindings: phy: ti,tcan104x-can: Document TI
 TCAN1046
MIME-Version: 1.0

On 09.12.2025 16:21:19, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Document the TI TCAN1046 automotive CAN transceiver. The TCAN1046 is a
> dual high-speed CAN transceiver with sleep-mode support and no EN pin,
> mirroring the behaviour of the NXP TJA1048, which also provides dual
> channels and STB1/2 sleep-control lines.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> TCAN 1046, https://www.ti.com/lit/ds/symlink/tcan1046v-q1.pdf?ts=3D176529=
7159307&ref_url=3Dhttps%253A%252F%252Fwww.ti.com%252Fproduct%252FTCAN1046V-=
Q1
> NXP TJA1048, https://www.nxp.com/docs/en/data-sheet/TJA1048.pdf

The polarity of the standby line of the chips is different.

You must set the correct active high/low property for the GPIO, as the
driver uses logical levels.

Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--e6urrv5hrowjmz7i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmk5JtcACgkQDHRl3/mQ
kZwxIgf/eUDLIjC6LBRgFTzonAO1ySjcSPxz5b68r3lN+Fvh85PzhF0hjQKy4rJK
y7IitOQcsYbNWhT/Fb2hQ16upPZ+OMz/TLTN5T7KL/aNCELTfXZ4byV7yklI/80j
til6mvAf5f5XLEKDUhGZyhU5tCBYjzm1VINTonZjS184Aonvgm7yOX6KoeDBPfkj
Uq6r7R/d2Sf5lQnyrElepWAb6no84OrBbO2uo7cHcp/xSOhjFsXo6usk2Xf0QJWL
XywgDNwNbmmqSg1T8Svsq9hSiG+Zpd73xpCxUmxC1sbtvxNo3ktlgOvBW73mTdwr
VllmqGd0XH9U5dYp6Con58PNS3VWGg==
=IgJz
-----END PGP SIGNATURE-----

--e6urrv5hrowjmz7i--

