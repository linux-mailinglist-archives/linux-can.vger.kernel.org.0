Return-Path: <linux-can+bounces-92-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B868813122
	for <lists+linux-can@lfdr.de>; Thu, 14 Dec 2023 14:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3AD9283259
	for <lists+linux-can@lfdr.de>; Thu, 14 Dec 2023 13:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FC454FBF;
	Thu, 14 Dec 2023 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cs7sirs9"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9CE4F1E1;
	Thu, 14 Dec 2023 13:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EFFC433C8;
	Thu, 14 Dec 2023 13:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702559821;
	bh=JHyomd0Q9NPn9A6jdZewEr+8uII5CmAyP0V6PrfA4bA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cs7sirs9h0XVwnqWYZLR/SKUFu2N9cpp0Yiz0d+uM6Gx48N7jql/U1q1F0Baw8AK0
	 KAsMhLeqa+jA25Lv7z282d9rx/9Bx3RtE/7rtOpsLo2hAMJVn/cb8uNlOCUh9G1tRa
	 Q4BlAFF9y8gqm4V1uwSrFjju+NkuQAPifpstroy8LPfPit/KVjSN39cF+u1fdTDuFr
	 wxH9zOBWW1Jj+JAaA2/6ttNAWNB3DcevrU39jZyxIV3queyCIejv1lioZzsj2CMqI5
	 YpAEj54TSUVWnVHEfGb4FtOIqjOnmePv+hf2aM31ld4yumAISfJy8yxIVIZjHqK8C8
	 P5OilGkQLL67g==
Date: Thu, 14 Dec 2023 13:16:55 +0000
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
Message-ID: <20231214-tinderbox-paver-d1ff0fc5c428@spud>
References: <20231208-reenter-ajar-b6223e5134b3@spud>
 <20231208-palpitate-passable-c79bacf2036c@spud>
 <20231212-unreeling-depose-8b6b2e032555-mkl@pengutronix.de>
 <20231213-waffle-grueling-3a5c3879395b@spud>
 <20231214-tinderbox-glitzy-60d1936ab85f-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8sbtDukOq8t99rKn"
Content-Disposition: inline
In-Reply-To: <20231214-tinderbox-glitzy-60d1936ab85f-mkl@pengutronix.de>


--8sbtDukOq8t99rKn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 12:31:04PM +0100, Marc Kleine-Budde wrote:
> On 13.12.2023 13:02:49, Conor Dooley wrote:
> > On Tue, Dec 12, 2023 at 09:49:41PM +0100, Marc Kleine-Budde wrote:
> > > On 08.12.2023 17:12:24, Conor Dooley wrote:
> > > > From: Conor Dooley <conor.dooley@microchip.com>
> > > >=20
> > > > The CAN controller on PolarFire SoC has an AHB peripheral clock _an=
d_ a
> > > > CAN bus clock. The bus clock was omitted when the binding was writt=
en,
> > > > but is required for operation. Make up for lost time and add it.
> > > >=20
> > > > Cautionary tale in adding bindings without having implemented a real
> > > > user for them perhaps.
> > > >=20
> > > > Fixes: c878d518d7b6 ("dt-bindings: can: mpfs: document the mpfs CAN=
 controller")
> > > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > > ---
> > > >  .../devicetree/bindings/net/can/microchip,mpfs-can.yaml    | 7 +++=
++--
> > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/net/can/microchip,mp=
fs-can.yaml b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.=
yaml
> > > > index 45aa3de7cf01..05f680f15b17 100644
> > > > --- a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.=
yaml
> > > > +++ b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.=
yaml
> > > > @@ -24,7 +24,10 @@ properties:
> > > >      maxItems: 1
> > > > =20
> > > >    clocks:
> > > > -    maxItems: 1
> > > > +    maxItems: 2
> > > > +    items:
> > > > +      - description: AHB peripheral clock
> > > > +      - description: CAN bus clock
> > >=20
> > > Do we we want to have a "clock-names" property, as we need the clock
> > > rate of the CAN bus clock.
> >=20
> > We should not need the clock-names property to be able to get both of
> > the clocks. clk_bulk_get_all() for example should be usable here.
>=20
> ACK, but we need the clock rate of CAN clock. Does this binding check
> that the CAN clock rate is the 2nd one?

The items list requires that the can clock be the second one, so drivers
etc can rely on that ordering.

--8sbtDukOq8t99rKn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXsARwAKCRB4tDGHoIJi
0h9wAP903owgON0b07MdLtwGROU5QzSNFLxoBOqorLvQyAIqpAD+NUlz2g5CmXeF
4jrpFftFyQNgWbQ8mC2atxX5XKUNvA4=
=LB6e
-----END PGP SIGNATURE-----

--8sbtDukOq8t99rKn--

