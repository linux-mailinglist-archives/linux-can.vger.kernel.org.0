Return-Path: <linux-can+bounces-948-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E12F9273A7
	for <lists+linux-can@lfdr.de>; Thu,  4 Jul 2024 12:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86C71C23325
	for <lists+linux-can@lfdr.de>; Thu,  4 Jul 2024 10:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDF51AB8FF;
	Thu,  4 Jul 2024 10:07:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5671AAE06
	for <linux-can@vger.kernel.org>; Thu,  4 Jul 2024 10:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720087654; cv=none; b=nMPGmugPpPXl6JIjcyGTVwB0TAKbhQX6HlLSZkaTRLjjAOxlso6EgA/Deflgl3tWe4/10/AJWs16fG3pIZju/VVJiPj8NdZHHibI8A9vaSLkwBfG5ra6YParwsVlPm0hGmnkdwVDT4g1juW0lpbWXoWAZmfNROqem1vwyfuz/Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720087654; c=relaxed/simple;
	bh=L1au4gRMKcI5BIEcsS+8zjDDar+BRU9MILS6EafA7W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V68F/wk21czPXfgUYwepx4WWT1pltfdJ1yoaZOFsjBkcis5nTCDNPC7R3pG4SXy2Klz6GP+3MmHttvpLexte85smw7ZPJ43DwpRUpKqt033CsZYaPHFK98nwU39Nys6iRokof/V0K2nr+Uq3G3NlIWYsNWRmUlhoRSC7SRM9NBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sPJMm-0004rB-JU; Thu, 04 Jul 2024 12:07:04 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sPJMl-007460-14; Thu, 04 Jul 2024 12:07:03 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 97EF92FABC2;
	Thu, 04 Jul 2024 10:07:02 +0000 (UTC)
Date: Thu, 4 Jul 2024 12:07:02 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: can: fsl,flexcan: add common
 'can-transceiver' for fsl,flexcan
Message-ID: <20240704-outstanding-outrageous-herring-003368-mkl@pengutronix.de>
References: <20240629021754.3583641-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dr2n3t7ohmn737hp"
Content-Disposition: inline
In-Reply-To: <20240629021754.3583641-1-Frank.Li@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--dr2n3t7ohmn737hp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.06.2024 22:17:54, Frank Li wrote:
> Add common 'can-transceiver' children node for fsl,flexcan.
>=20
> Fix below warning:
> arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: can@2180000: 'can-tran=
sceiver' does not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/net/can/fsl,flexca=
n.yaml#
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--dr2n3t7ohmn737hp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmaGdEMACgkQKDiiPnot
vG+ndwgAmTD3vI+lh+SpHXPC8faiwWnvlpIAuwu1ia2S5LNiIxhehoz6+WgxW3h/
0KkIbn2zQva+MUsldVljBQd1tGssLrV54uni1v1OF1Hwnjd/E89cYqEZasllZEX/
sBlUbgBOxj9DW8liWUhk7hsPxPmrSKHJIgnMDq6lW8998oT+EG2DSfTGyU19aJJr
/mbyaZ/IXIGplQKbS/4tVGABrip20ab95BrbDf6WphlTIgtleyt9ZICdT7CQ6YCH
WtWHrmy9L6hSNOSTR7qUSG7af7fcXVgg6P1Scmw1DyEirWKyqxXYldb9Tyl1H8gj
RezwMSF47aHNA9/vXmPeX7WjWsH2Cw==
=36qY
-----END PGP SIGNATURE-----

--dr2n3t7ohmn737hp--

