Return-Path: <linux-can+bounces-5862-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF1ECB9816
	for <lists+linux-can@lfdr.de>; Fri, 12 Dec 2025 19:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 862D1303F4D4
	for <lists+linux-can@lfdr.de>; Fri, 12 Dec 2025 18:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04102D3732;
	Fri, 12 Dec 2025 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+evEzBh"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A28293B75;
	Fri, 12 Dec 2025 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765562429; cv=none; b=nCLsMlt5UcfEoojtBazosseJ3atgFXZ4vhZnFPTZQHXUnZYztkGOBTtLFIM4Vz/iNSbrxhQ2bexgvsUvR6Nf3j9q3OdECyxEKID0bHuKVv6Kr1cjio+9us24Z6azOtPyDIWthf40hs6iqUaBbXlkXxACFWZ0bXbqwRc34MTkI4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765562429; c=relaxed/simple;
	bh=bJ2KJCFxwgxmMsSuX7IhdV9rCVpxtdIdE13CWYdQEx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lI5VsU6+1PDqZVVk4C6BESTkAGXflqH1y5/E7nJpsTR0B2G9eBiN/PO+g1TY9ZFiBJqR8bgKUibGUsU8fMxyRD7sq5i2Ug/T6vrdIxh/D4cz2MZSOv5/09VbOgEB+X5KJA9DWzCY1IDMLN0YK/9aGv/K4TI/tLMqxdqueBW0Ivo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+evEzBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E51AC4CEF1;
	Fri, 12 Dec 2025 18:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765562429;
	bh=bJ2KJCFxwgxmMsSuX7IhdV9rCVpxtdIdE13CWYdQEx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c+evEzBhkPlDbI3BlJdEvZ8AEjftKU/VXIdPPQJWvsCkWhGn0dqBuVSLZ16mXLcK+
	 OQYy/rRiaQmYlbi8QYxP/qhukPanqLxFBIRQOgUCDqyNpOQhI8JxXsFTEp0EbPxClx
	 UkxH7VzoYkIwaFc9ouQK5nOVWoqpUzdszERP5MM8ercsEPDYSvBkJfWfDbsjbe0Tyc
	 uV/YvsLvAAlE+F6xW8hjBaVU4sa1nIcTGpdaz5udHVRAbVeXbkffrWornvbLJlxJuO
	 myLTdNnURrg6rm4H/SWNmBWTVxv0n6rUtk1280Ij8u5Gnov3A2O5hjDK1iGxgOcKTr
	 +0hfL/nEmnITw==
Date: Fri, 12 Dec 2025 18:00:23 +0000
From: Conor Dooley <conor@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Prabhakar <prabhakar.csengg@gmail.com>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Frank Li <Frank.li@nxp.com>, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2] dt-bindings: phy: ti,tcan104x-can: Document TI
 TCAN1046
Message-ID: <20251212-thaw-octopus-57e8400506ea@spud>
References: <20251209162119.2038313-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251210-mauve-cow-of-hurricane-0f969d-mkl@pengutronix.de>
 <20251210-persuaded-rewire-8ac93b0cc039@spud>
 <20251211-wonderful-singing-eel-4e2293-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ec+kgCN350Y3b0uL"
Content-Disposition: inline
In-Reply-To: <20251211-wonderful-singing-eel-4e2293-mkl@pengutronix.de>


--ec+kgCN350Y3b0uL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 12:21:03PM +0100, Marc Kleine-Budde wrote:
> On 10.12.2025 18:21:34, Conor Dooley wrote:
> > On Wed, Dec 10, 2025 at 08:52:58AM +0100, Marc Kleine-Budde wrote:
> > > On 09.12.2025 16:21:19, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Document the TI TCAN1046 automotive CAN transceiver. The TCAN1046 i=
s a
> > > > dual high-speed CAN transceiver with sleep-mode support and no EN p=
in,
> > > > mirroring the behaviour of the NXP TJA1048, which also provides dual
> > > > channels and STB1/2 sleep-control lines.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.c=
om>
> > > > ---
> > > > TCAN 1046, https://www.ti.com/lit/ds/symlink/tcan1046v-q1.pdf?ts=3D=
1765297159307&ref_url=3Dhttps%253A%252F%252Fwww.ti.com%252Fproduct%252FTCAN=
1046V-Q1
> > > > NXP TJA1048, https://www.nxp.com/docs/en/data-sheet/TJA1048.pdf
> > >
> > > The polarity of the standby line of the chips is different.
> > >
> > > You must set the correct active high/low property for the GPIO, as the
> > > driver uses logical levels.
> > >
> > > Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
> >
> > What you're saying seems to contradict the tag you've given, is a
> > fallback really suitable if the standby polarity is not the same?
>=20
> The driver uses _logical_ levels to switch the GPIOs. For example to
> power on the PHY, it disables the standby GPIO by setting the value to
> "0".
>=20
> | static int can_transceiver_phy_power_on(struct phy *phy)
> | {
> [...]
> |         gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
> [...]
> | }
>=20
> You have to use GPIO_ACTIVE_HIGH/GPIO_ACTIVE_LOW in the DT to configure
> the actual level of the GPIO.

Ah okay, I prob should have looked a bit further into the binding.
Acked-by: Conor Dooley <conor.dooley@microchip.com>


>=20
> If you connect the PHY's standby input directly to the SoC's GPIO....
>=20
> | TJA1048: HIGH =3D Normal mode, LOW =3D Standby mode
> | TCAN1046: High =3D Standby mode, Low =3D Normal Mode
>=20
> ...for the TJA1048 you would use GPIO_ACTIVE_LOW, while for the
> TCAN1046 you would use GPIO_ACTIVE_HIGH.
>=20
> regards,
> Marc
>=20
> --=20
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=FCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |



--ec+kgCN350Y3b0uL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaTxYNwAKCRB4tDGHoIJi
0u4GAQCKQ0zLIMjJX0Bdhe/NUX9j3cgUy7HrpJmvIB9NveY+mQEA21rq6AEs7yyQ
5BxDz7hP5JNIAVC+Im1gKpg60Oy2JAs=
=8+rD
-----END PGP SIGNATURE-----

--ec+kgCN350Y3b0uL--

