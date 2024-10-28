Return-Path: <linux-can+bounces-1805-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D739B34E1
	for <lists+linux-can@lfdr.de>; Mon, 28 Oct 2024 16:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73C01C21F3D
	for <lists+linux-can@lfdr.de>; Mon, 28 Oct 2024 15:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208B41DE4F3;
	Mon, 28 Oct 2024 15:29:10 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317E11DE3D2
	for <linux-can@vger.kernel.org>; Mon, 28 Oct 2024 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129350; cv=none; b=sqQTmbpEBMPJC6oHzybcppoMvwGh/MId2RwIYFX0cZRK3/JAPQs96zyJU3LuS+ESp98uv7ox7ZfGlbG068yBqqwLohzMGHTUWNIjaa+Ork60KFIW2XFmuME3kbUrc2M/YEN59SW8QiDrocIzAgU32jUfa9lc6ZXAv2664eSD9BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129350; c=relaxed/simple;
	bh=SKtyNgIFZEZ0qXXkIJhRGSixVdUEa0UAdc/hwiPYEOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeJ6LgOMEQVPHDmmPmHzRYKW/P+BtEKmvRbIHJOY9ATKyTD1+lXMxpqgIHSJRk6cVVT+lM4cq/1x/OwNbeW50O3mCNg+qbSfKHsAXYl/bpkgTRpj4HoLXaDmPPYRLpVPtlszCtRni02phTenf+SxUpNBk3cP1wwKav8PAl7mn/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t5Rfj-0001p6-UH; Mon, 28 Oct 2024 16:28:47 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t5Rfg-000sdb-1p;
	Mon, 28 Oct 2024 16:28:44 +0100
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2C35A360A41;
	Mon, 28 Oct 2024 15:28:44 +0000 (UTC)
Date: Mon, 28 Oct 2024 16:28:43 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	William Qiu <william.qiu@starfivetech.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RE: [PATCH v2 3/4] can: Add driver for CAST CAN Bus Controller
Message-ID: <20241028-delectable-fantastic-swine-3ab4dd-mkl@pengutronix.de>
References: <20240922-inquisitive-stingray-of-philosophy-b725d3-mkl@pengutronix.de>
 <ZQ2PR01MB1307D96BB8AC0B6BB78C97C9E64F2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bayufuaqihhp4puc"
Content-Disposition: inline
In-Reply-To: <ZQ2PR01MB1307D96BB8AC0B6BB78C97C9E64F2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--bayufuaqihhp4puc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: RE: [PATCH v2 3/4] can: Add driver for CAST CAN Bus Controller
MIME-Version: 1.0

On 25.10.2024 01:45:30, Hal Feng wrote:
> On 9/23/2024 5:14 AM, Marc Kleine-Budde wrote:=20
> > On 22.09.2024 22:51:49, Hal Feng wrote:
> > > From: William Qiu <william.qiu@starfivetech.com>
> > >
> > > Add driver for CAST CAN Bus Controller used on StarFive JH7110 SoC.
> >=20
> > Have you read me review of the v1 of this series?
> >=20
> > https://lore.kernel.org/all/20240129-zone-defame-c5580e596f72-
> > mkl@pengutronix.de/
>=20
> Yes, I modify accordingly except using FIELD_GET() / FIELD_PREP(), using
> rx_offload helper and the shared interrupt flag. I found FIELD_GET() / FI=
ELD_PREP()
> can only be used when the mask is a constant,

Do you have a non constant mask?

> and the CAN module won't
> work normally if I change the interrupt flag to 0.

What do you mean by "won't work normally"?
It makes no sense to claim that you support shared interrupts, but
print an error message, if your IP core had no active interrupt.

> I will try to using rx_offload helper
> in the next version.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--bayufuaqihhp4puc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcfragACgkQKDiiPnot
vG85Ygf9GrLJf5wV7bdgz9vs/sx2rKcJlxRbC5pFv5ebTX6WbvM9DlF2hVFYLukY
OVR12GIkefiKCKDW1cEYxZhba1VifqSaayUs8heOrhUjm8W4gq7/258tWSMuwDVS
OcRyTkEP/1UrCB78AHAFtUML+doEqstQArznjSIuzPbytCVQfbNAkrIwagtqLeiR
Xsj4tXKjJQcoIDNBwtMRGJAgNMLSWwt2y7JRj98ygicPFhcPSZVB+CwvXPA2XxqM
ipRmtWdT+pBJtZ3jdD4uhSKP46ROV9ggtZksy8v00ElJG/lu48rQHvKU4pKGkEK1
FwAZIHUmjawWlux4wTT8gRgosM4fcA==
=vCRm
-----END PGP SIGNATURE-----

--bayufuaqihhp4puc--

