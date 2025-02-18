Return-Path: <linux-can+bounces-2846-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36769A3A3E5
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 18:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AFC43AAA2B
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 17:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D874F26FA71;
	Tue, 18 Feb 2025 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5hmNgvw"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EB326983F;
	Tue, 18 Feb 2025 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898939; cv=none; b=Wu/lGeRCBRZ3Xv5HGmi4aogH/usROZ1rryEqw6nGWbgl1CzlgAZckhecBhGmh5HuSz4qPcD3TwNQdi4vZ4uPnp+dbkpY9GMa9LH0NsEFW/UFqFG2q2Hbt7TNWqlIffC5fmqKcmoLyemt5k4nPYaNtV8mrhlo3k0wLJxXmx24IF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898939; c=relaxed/simple;
	bh=0qTjpm35cwQdCGD+yRQpHZsJddTi8Wdn9wST9LDUBG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fw3LGoktVVVTmcASF2fhWD7+Z0iFJI6Ak8ajXoOt9JH7q38N0wO85FV5vDtqRWgZEhWp0zslJ7JQLwlubmnQ6I7RDSCIIq19BHeBT0crqZ8GVdxilc0/vkvFzlEC/d923FTxp4DFMx0qymgU6Z5avSNhetC/U82hkWcZfqnm1yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5hmNgvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34ECFC4CEE9;
	Tue, 18 Feb 2025 17:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739898939;
	bh=0qTjpm35cwQdCGD+yRQpHZsJddTi8Wdn9wST9LDUBG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5hmNgvwM5n2BWPrY7GtfLSdtttsKpcT3Q/VytUv0rvPgJf50TBc3r923ZdsT2r1r
	 JwvE1qiJV+V6FSeH8G+TABjjgrd2pyBed0SOl7GEC/R0pqiQUfLp34ms2fd3fz5bBi
	 WnPeuM8ORACVOzhj9MGTLReszxBSbGCDIwaLVv2UDgRT2ddq22JoCXDWKp/jJ3canC
	 5NP55NOVA7BJjMn0/S9547FkSjuXvx+z/MKBhaT73fxU4BO0bq4ENOEidQlzGa6P9l
	 udFumyvJ2HGa7iTW7cSUZE91ifirWn20lzEkFTyPCPv7S6sPkCiUnmPWpj4jQOoPz4
	 vETUR8ILG/QpQ==
Date: Tue, 18 Feb 2025 17:15:35 +0000
From: Conor Dooley <conor@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: dimitri.fedrau@liebherr.com, Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: can: fsl,flexcan: add transceiver
 capabilities
Message-ID: <20250218-encrypt-ambitious-d9aafe5e86cf@spud>
References: <20250211-flexcan-add-transceiver-caps-v1-0-c6abb7817b0f@liebherr.com>
 <20250211-flexcan-add-transceiver-caps-v1-1-c6abb7817b0f@liebherr.com>
 <20250211-epidermis-crib-b50da209d954@spud>
 <20250212195204.GA6577@debian>
 <20250213-scariness-enhance-56eda6901f69@spud>
 <20250214050540.GA3602@debian>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6y3jfApe3QALE3gG"
Content-Disposition: inline
In-Reply-To: <20250214050540.GA3602@debian>


--6y3jfApe3QALE3gG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 06:05:40AM +0100, Dimitri Fedrau wrote:
> Am Thu, Feb 13, 2025 at 08:07:22PM +0000 schrieb Conor Dooley:
> > On Wed, Feb 12, 2025 at 08:52:04PM +0100, Dimitri Fedrau wrote:
> > > Am Tue, Feb 11, 2025 at 04:38:48PM +0000 schrieb Conor Dooley:
> > > > On Tue, Feb 11, 2025 at 02:12:33PM +0100, Dimitri Fedrau via B4 Rel=
ay wrote:
> > > > > From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > > > >=20
> > > > > Currently the flexcan driver does not support adding PHYs. Add the
> > > > > capability to ensure that the PHY is in operational state when th=
e link
> > > > > is set to an "up" state.
> > > > >=20
> > > > > Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 3 +=
++
> > > > >  1 file changed, 3 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexca=
n.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> > > > > index 97dd1a7c5ed26bb7f1b2f78c326d91e2c299938a..397957569588a6111=
1a313cf9107e29dacc9e667 100644
> > > > > --- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> > > > > +++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> > > > > @@ -70,6 +70,9 @@ properties:
> > > > >    xceiver-supply:
> > > > >      description: Regulator that powers the CAN transceiver.
> > > > > =20
> > > > > +  phys:
> > > > > +    maxItems: 1
> > > >=20
> > > > Can all devices in this binding support external phy? Are all devic=
es
> > > > limited to a single external phy?
> > > >=20
> > > As far as I know, these devices are controllers without integrated PH=
Y.
> > > So they need a single external PHY. Transceivers can be very simple l=
ike
> > > xceiver-supply in the binding, but I want to use "ti,tcan1043" in=20
> > > drivers/phy/phy-can-transceiver.
> >=20
> > I'm not quite following, do all of these devices need to have an
> > external phy but the property did not exist until now? How did any of
> > them work, if that's the case?
>=20
> The property xceiver-supply is used to describe connected transceiver
> which do only rely on corresponding regulator configuration.
> For example here:
> https://elixir.bootlin.com/linux/v6.14-rc2/source/arch/arm/boot/dts/nxp/i=
mx/imx6qdl-sabreauto.dtsi#L105
>=20
> But I want to enable support for these:
> https://elixir.bootlin.com/linux/v6.14-rc2/source/Documentation/devicetre=
e/bindings/phy/ti,tcan104x-can.yaml

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for the explanation,
Conor.

--6y3jfApe3QALE3gG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7TANgAKCRB4tDGHoIJi
0oTsAP9d/zsK4fAJNoXBrxxAr8OhuNutHT9Ggk86r0oSXItKaQEAsOoe62UImPeR
zqLyAsg/YXXTNfB+SJXNUJygfkgc5AY=
=jn6b
-----END PGP SIGNATURE-----

--6y3jfApe3QALE3gG--

