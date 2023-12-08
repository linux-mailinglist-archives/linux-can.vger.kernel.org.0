Return-Path: <linux-can+bounces-85-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1875580ACE9
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 20:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD26281191
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 19:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E8A4B5BA;
	Fri,  8 Dec 2023 19:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQhKPK3Q"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DC94AF61;
	Fri,  8 Dec 2023 19:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68266C433C8;
	Fri,  8 Dec 2023 19:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702063545;
	bh=z3otdfwGLX1f2a+SvSkMwMZKGTLN4cY6uigJoIFO8gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dQhKPK3QFPl9Y4y8sbGGByFaxlfrHHBrDeR2t0nRF+ZSY8oHD2YtQlpfSwS0bUcMC
	 5cQbG0I+RUkaUbSqsYWyajZrzXiTtDF3inTnntumVRtejuFCXVALMmWg+0cwc1iUpk
	 Z+r8QBYBA7qb9jB6svwH93w66rJkBtDOofMbrFrQyPZFuQ6SjeogAahQSRKSzpKReZ
	 XW8f3hgrcG3j8RrKzzKnZfymmieb9DV7tyw5upJM6+HL9wL6FFIb4JqzfjNbPHJ3Du
	 EaEioV1pHZ4HoRPRU6nZSC8ZpzJibUXbQQDMxwLTvjV/6LSmWW9broVCN4UAwM8MaI
	 8ZeKPanJ7KM/A==
Date: Fri, 8 Dec 2023 19:25:39 +0000
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, linux-can@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, Eric Dumazet <edumazet@google.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RESEND v1 2/7] dt-bindings: can: mpfs: add missing
 required clock
Message-ID: <20231208-contusion-professed-3b2235f7d3df@spud>
References: <20231208-reenter-ajar-b6223e5134b3@spud>
 <20231208-palpitate-passable-c79bacf2036c@spud>
 <170206026051.2485962.13304186324857333888.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LcNsrkCtTh9NwKDb"
Content-Disposition: inline
In-Reply-To: <170206026051.2485962.13304186324857333888.robh@kernel.org>


--LcNsrkCtTh9NwKDb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 12:31:00PM -0600, Rob Herring wrote:
>=20
> On Fri, 08 Dec 2023 17:12:24 +0000, Conor Dooley wrote:
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
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/can/microchip,mpfs-can.yaml: properties:clocks: {'maxItems': 2, 'items':=
 [{'description': 'AHB peripheral clock'}, {'description': 'CAN bus clock'}=
]} should not be valid under {'required': ['maxItems']}
> 	hint: "maxItems" is not needed with an "items" list
> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#


Oh dear, me of all people.

--LcNsrkCtTh9NwKDb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXNtsgAKCRB4tDGHoIJi
0oSOAQCwrHN/7yWhuuIG7o8zyiDD3sQh9O0ObhobDPMiwzstNAEAwZYfqSjCNUqo
PRSO8gA7E/ILMPQQJKcY+VOri+ewwAg=
=IQnv
-----END PGP SIGNATURE-----

--LcNsrkCtTh9NwKDb--

