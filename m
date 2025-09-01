Return-Path: <linux-can+bounces-4416-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FEEB3EE36
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 21:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BEEB1A87DB6
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 19:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E1F259CA0;
	Mon,  1 Sep 2025 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5UYpFbK"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827AD175A5;
	Mon,  1 Sep 2025 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756753231; cv=none; b=ZBOhyPDY//K2W20TM3bJ477/0DFi4LV565EEtgqON91/jWuTfqUMH0YdoCJpmmuQXXRWync2jV5Uyu8Uqz6mdhiqGgz3OdoZPTzj3njlWsNECNf2YNpGx3MEf1xMAc8PdBNePZzrCXLXFZ3LkM531liJNgQUn9Fd0PZt46pEZjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756753231; c=relaxed/simple;
	bh=LctdjUhGxf71qHtiYonh2qpbLAV3p/deNyRN07fjZos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arWdbsNK/syukpR3/o/VS6VKnQDhbxQfS/lCrK0ZJJasfEm+K9okeJW5BC8FzaG/AlZHhBCTw6kDQLdRrrEW2+yfvJ74VyLmJRfiwzNpspTfrxZf31qOjj5brHs5WDLgMhgkfK5jEc/ZdfLG4RLHqyJJta6qOjZ9ZItRrWNQ+MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5UYpFbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F547C4CEF1;
	Mon,  1 Sep 2025 19:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756753231;
	bh=LctdjUhGxf71qHtiYonh2qpbLAV3p/deNyRN07fjZos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A5UYpFbKND00c/aB/57avZ/pTSSw0GM987HdW/KZ2QHrq/x1ScaszBRAv8e2eecuj
	 92YwLjPpWuTC2KTeKExOJdKfpqs3xKc4hgudiRj+2VkGIA3H5azimMH/QkP7c6SH9N
	 ET9LA7wRZpS2GdgvuTmMwq0/anCo/hC47WO9jDoCTVnm+9GQ+SSqYKIqKyVkkmROSh
	 HSloiWdyvTS7Z3COVahZZsBCJd8tIGT758/GF32UWyVh+iKqsnUM7dRptcen7+zLuC
	 lBWwtunR1SUg3aazWx4bRgzUtP4DV514EtIFf94KZyzGjjpkOpBldRsPoTEYu7L8Hn
	 MUeHcsiA6MWjA==
Date: Mon, 1 Sep 2025 20:00:25 +0100
From: Conor Dooley <conor@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/6] dt-bindings: phy: ti,tcan104x-can: Document NXP
 TJA105X/1048
Message-ID: <20250901-uproar-shrill-07d51ea21a29@spud>
References: <20250901-can-v4-0-e42b5fe2cf9e@nxp.com>
 <20250901-can-v4-1-e42b5fe2cf9e@nxp.com>
 <20250901-diligent-dreaded-59b9ad5c3976@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Fac7BrZqSni97b6k"
Content-Disposition: inline
In-Reply-To: <20250901-diligent-dreaded-59b9ad5c3976@spud>


--Fac7BrZqSni97b6k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 01, 2025 at 07:54:01PM +0100, Conor Dooley wrote:
> On Mon, Sep 01, 2025 at 11:18:11AM +0800, Peng Fan wrote:
> > The TJA105[1,7] is a high-speed CAN transceiver which is a pin-compatib=
le
> > alternative for TI TCAN1043 with sleep mode supported, and has a compat=
ible
> > programming model, therefore use ti,tcan1043 as fallback compatible.
> >=20
> > The TJA1048 is a dual high-speed CAN transceiver with sleep mode suppor=
ted.
> >=20
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/phy/ti,tcan104x-can.yaml   | 30 ++++++++++++++=
++++++--
> >  1 file changed, 28 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml=
 b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > index 4a8c3829d85d3c4a4963750d03567c1c345beb91..f8e0c24856a2ba83b5c988b=
246464f47e11a032f 100644
> > --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > @@ -19,18 +19,25 @@ properties:
> >            - enum:
> >                - microchip,ata6561
> >            - const: ti,tcan1042
> > +      - items:
> > +          - enum:
> > +              - nxp,tja1051
> > +              - nxp,tja1057
> > +          - const: ti,tcan1043
> >        - enum:
> >            - ti,tcan1042
> >            - ti,tcan1043
> > +          - nxp,tja1048
> >            - nxp,tjr1443
> > =20
> >    '#phy-cells':
> > -    const: 0
> > +    enum: [0, 1]
> > =20
> >    standby-gpios:
> >      description:
> >        gpio node to toggle standby signal on transceiver
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
>=20
> You're adding a second standby gpio, which one is which?
> I assume you mean that item 1 is stbn1 and item 2 is stbn 2 for tja1048.
> Might be kinda obvious, but I think it should be mentioned.
>=20
> tja105{1,7} don't have a standby gpio, but they do have a silent mode.
> silent mode seems fundamentally different to standby, since the receiver
> still works. Seems like that should be handled differently, no?

The docs for standby mode for the tcan1043 don't match with the tja1051,
"Standby mode is a low power mode where the driver and receiver are
disabled," so does the fallback compatible even make sense? Seems like a
combination of enable and standby gpios are used to put the tcan device
into silent mode but the tja1051 has a pin for that alone and seemingly
does not support standby at all?

>=20
> > =20
> >    enable-gpios:
> >      description:
> > @@ -53,6 +60,25 @@ required:
> >    - compatible
> >    - '#phy-cells'
> > =20
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: nxp,tja1048
> > +    then:
> > +      properties:
> > +        '#phy-cells':
> > +          const: 1
> > +        standby-gpios:
> > +          minItems: 2
> > +    else:
> > +      properties:
> > +        '#phy-cells':
> > +          const: 0
> > +        standby-gpios:
> > +          maxItems: 1
> > +
> >  additionalProperties: false
> > =20
> >  examples:
> >=20
> > --=20
> > 2.37.1
> >=20



--Fac7BrZqSni97b6k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaLXtSQAKCRB4tDGHoIJi
0vFGAQCYNzumk6MUDIsHrTq+zb2rPK0wlmaEJB3AP3SpQVUxnAEAqIUZeoqA5+in
UbteyD3yR0gqvOwaghcsU1k+0rcDpgs=
=Zpms
-----END PGP SIGNATURE-----

--Fac7BrZqSni97b6k--

