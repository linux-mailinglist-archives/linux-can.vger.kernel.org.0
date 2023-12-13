Return-Path: <linux-can+bounces-90-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5770781125E
	for <lists+linux-can@lfdr.de>; Wed, 13 Dec 2023 14:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDEEDB20C6B
	for <lists+linux-can@lfdr.de>; Wed, 13 Dec 2023 13:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB452C1BD;
	Wed, 13 Dec 2023 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOAZ793f"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3244E2C842;
	Wed, 13 Dec 2023 13:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73FFC433C8;
	Wed, 13 Dec 2023 13:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702472575;
	bh=SYhlR91tO42bA8AfGZXjJpENUJXvfJwI9ZrVd2yDl7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOAZ793fHzKh/HYPbFWxrP57xdIvDGz7zJAPafMIdiXo/gdClWfHHvXyABgyiaI3d
	 IzjD7flCvOmUtRPQK/nwxFG4P+/wjewBRhds66wynKr/e/B9HcmsYwbGWOiDfrcGgF
	 Mad+vti/3CHqhV9Mc8DmDCiHi5Llrhj8bBvRK8yG2/BfMYB5kldfx6AoNVi3LS5Yed
	 voYZzMviyN03AtFIwzndO9A1hh6wyeIOadgNlhvE3YVLQFoRmcz/zTpvLmVk2qGecJ
	 c2p65kbrZ/i6niLm0i+F8ERk9GXSfIiwFL6+xEZru50pieVHqYJCoculVkT2y+ID+D
	 uMM7/fLCxbELQ==
Date: Wed, 13 Dec 2023 13:02:49 +0000
From: Conor Dooley <conor@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH RESEND v1 2/7] dt-bindings: can: mpfs: add missing
 required clock
Message-ID: <20231213-waffle-grueling-3a5c3879395b@spud>
References: <20231208-reenter-ajar-b6223e5134b3@spud>
 <20231208-palpitate-passable-c79bacf2036c@spud>
 <20231212-unreeling-depose-8b6b2e032555-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AuzXFLC6CIKr68l9"
Content-Disposition: inline
In-Reply-To: <20231212-unreeling-depose-8b6b2e032555-mkl@pengutronix.de>


--AuzXFLC6CIKr68l9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 09:49:41PM +0100, Marc Kleine-Budde wrote:
> On 08.12.2023 17:12:24, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > The CAN controller on PolarFire SoC has an AHB peripheral clock _and_ a
> > CAN bus clock. The bus clock was omitted when the binding was written,
> > but is required for operation. Make up for lost time and add it.
> >=20
> > Cautionary tale in adding bindings without having implemented a real
> > user for them perhaps.
> >=20
> > Fixes: c878d518d7b6 ("dt-bindings: can: mpfs: document the mpfs CAN con=
troller")
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  .../devicetree/bindings/net/can/microchip,mpfs-can.yaml    | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/can/microchip,mpfs-c=
an.yaml b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
> > index 45aa3de7cf01..05f680f15b17 100644
> > --- a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
> > +++ b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
> > @@ -24,7 +24,10 @@ properties:
> >      maxItems: 1
> > =20
> >    clocks:
> > -    maxItems: 1
> > +    maxItems: 2
> > +    items:
> > +      - description: AHB peripheral clock
> > +      - description: CAN bus clock
>=20
> Do we we want to have a "clock-names" property, as we need the clock
> rate of the CAN bus clock.

We should not need the clock-names property to be able to get both of
the clocks. clk_bulk_get_all() for example should be usable here.

Cheers,
Conor.

--AuzXFLC6CIKr68l9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXmreQAKCRB4tDGHoIJi
0pybAQCaXK2xUCp5W6797bY/KOydLDfzz6/zpgo3/ym1K/7tCgEAs+ZQmqrTvSuQ
t2sr42Cf8RWYaRCGrwl6zg97g0jV0As=
=jW/W
-----END PGP SIGNATURE-----

--AuzXFLC6CIKr68l9--

