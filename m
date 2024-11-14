Return-Path: <linux-can+bounces-2032-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4919C8584
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 10:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A4C1F25A68
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 09:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177DA1DFD89;
	Thu, 14 Nov 2024 09:03:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5639429CFB
	for <linux-can@vger.kernel.org>; Thu, 14 Nov 2024 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574996; cv=none; b=rMNZvcGO+xEpPXFwhsYlCmSx41fG8h8Xokp+8tsRCaJ2sCUElB+X5TXWIpns0t8pXYnY8J/9jc7k3Elfd822IdB5uiXa8GqJ6Hxkpwb3I5qoTREzyGERC9XBewdreEpOiI+O+Rn7l/F8Jks8qmrcesnaWGZ2HlGIREntcFbvSq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574996; c=relaxed/simple;
	bh=yMofAg6GnSBQAObf74t5qTT94MgiyHC7E8wT+BEjOl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1ClPNpMNqAh7w+7zhY7TwCWpXfQxZZxsoWRPbSsBR8iVw9HvSIsJhugNR2szCZn+1p4zMG269qEUhyxuB18f68dv68OGu/lylR+pwROXxONydKJRp9SeXewadrtexKyUl/7nH1JpAA/5ihDTQyrq3cm7r7ZMc7bdkK537/MNcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBVkk-0003PQ-CT; Thu, 14 Nov 2024 10:03:02 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBVkk-000iJR-0X;
	Thu, 14 Nov 2024 10:03:02 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D9007372EC9;
	Thu, 14 Nov 2024 09:03:01 +0000 (UTC)
Date: Thu, 14 Nov 2024 10:03:01 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Jakub Kicinski <kuba@kernel.org>, Sean Nyekjaer <sean@geanix.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] can: tcan4x5x: add option for selecting nWKRQ
 voltage
Message-ID: <20241114-natural-ethereal-auk-46db7f-mkl@pengutronix.de>
References: <20241111-tcan-wkrqv-v2-0-9763519b5252@geanix.com>
 <20241111101011.30e04701@kernel.org>
 <fatpdmg5k2vlwzr3nhz47esxv7nokzdebd7ziieic55o5opzt6@axccyqm6rjts>
 <20241112-hulking-smiling-pug-c6fd4d-mkl@pengutronix.de>
 <20241113193709.395c18b0@kernel.org>
 <CAMZ6Rq+Z=UZaxbMeigWp7-=v5xgetguxOcLgsht2G56OR1jFPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dfrlbwylwhzsoyyl"
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+Z=UZaxbMeigWp7-=v5xgetguxOcLgsht2G56OR1jFPw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--dfrlbwylwhzsoyyl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/2] can: tcan4x5x: add option for selecting nWKRQ
 voltage
MIME-Version: 1.0

On 14.11.2024 13:41:12, Vincent Mailhol wrote:
> On Thu. 14 Nov. 2024 at 12:37, Jakub Kicinski <kuba@kernel.org> wrote:
> > My bad actually, I didn't realize we don't have an X: entries
> > on net/can/ under general networking in MAINTAINERS.
                      ^^^^^^^^^^^^^^^^^^
> >
> > Would you mind if I added them?
>=20
> OK for me. I guess you want to add the exclusion for both the
>=20
>   CAN NETWORK DRIVERS
>=20
> and the
>=20
>   CAN NETWORK LAYER
>=20
> entries in MAINTAINERS.

I thinks, it's the other way round.

General networking gets an X: for driver/net/can and driver/can/ and the
include files.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--dfrlbwylwhzsoyyl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc1vMIACgkQKDiiPnot
vG8jmgf9FcKy1/rIq9vQpBZ1lOKeAtlWIbgY9hfsDz/Iml2T5CpJtjkAOV4S11RH
kIE2WpZU5pm6AqCXEgDVehVLFjVUaz/uGQXXJhxITNEPxsp4QAeV/pz4Gml5Lh1F
c9kzILRL9QD43YrONxMGNT2meIp+nDIS73PNG6Jf3/Kr/GSv0R8Gfkkjv6I5vlgB
4lHC2KnLxzj7l7BBCaeXSNkZywEVj+co3IFkKRTWAHJJHtIOefiDI5YiDW8KnyBJ
0SmXZOC/bhSja2TIjGh1dE71dZFFWcdv0xqxfUckVc+TLnWcYw+iQIhHzwRYYdy5
BfJNZIEiE8O8Zlr7B9ui0QTCd14LPQ==
=TMAg
-----END PGP SIGNATURE-----

--dfrlbwylwhzsoyyl--

