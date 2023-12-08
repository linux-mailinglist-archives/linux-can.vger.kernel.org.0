Return-Path: <linux-can+bounces-86-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9961B80ACEF
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 20:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5539C28179F
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 19:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEA24CB27;
	Fri,  8 Dec 2023 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0jHp+lr"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2000B125B8;
	Fri,  8 Dec 2023 19:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761F0C433C8;
	Fri,  8 Dec 2023 19:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702063576;
	bh=HmU9LMehAw9DeUV8uCa+TBiQ2MWNpmsc6U26C4PITlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q0jHp+lrFGrxQQ5fEQ0yYQ4fe+W9y4ZBbiIbF5Fm6XNgANu/LLyFCi7GKBQlImOK1
	 zQ5FX411R3rVVBA++4kibVU+Ry2zU52I2LBtZFygSsz/2u+K0JWWcT+JXE2mM3eQa5
	 aMaNS4Jl0owLVOpVhyAh5+5NDmpWsy7qBKYlhrzdxgnBQPmrOGOcSpTvp+Y7TY454O
	 WxcxrL2t/YvNsOiGxmkthRidpOyy3nyHyi8BYNeIuulbHZ7ApFNEULZz6fP97KusN/
	 TGdMkp+mrZygRRBt5EpnO283TOKGmC2DO1viuGwbfey/SpXfK9+mVbEe3SEJjdhIMr
	 WKX33bNQlujUg==
Date: Fri, 8 Dec 2023 19:26:10 +0000
From: Conor Dooley <conor@kernel.org>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
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
Subject: Re: [PATCH RESEND v1 1/7] dt-bindings: clock: mpfs: add more MSSPLL
 output definitions
Message-ID: <20231208-cauterize-hacker-f63dddf39af0@spud>
References: <20231208-reenter-ajar-b6223e5134b3@spud>
 <20231208-unripe-maximum-fc77f4967561@spud>
 <CAJM55Z_ozf=MwOJCSM154L__TE1Gv7Ec=gM8LFJ31-_eX66OKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="keUDLXTW9SCPY39T"
Content-Disposition: inline
In-Reply-To: <CAJM55Z_ozf=MwOJCSM154L__TE1Gv7Ec=gM8LFJ31-_eX66OKA@mail.gmail.com>


--keUDLXTW9SCPY39T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 09:40:00AM -0800, Emil Renner Berthing wrote:
> Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >
> > There are 3 undocumented outputs of the MSSPLL that are used for the CAN
> > bus, "user crypto" module and eMMC. Add their clock IDs so that they can
> > be hooked up in DT.
> >
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  include/dt-bindings/clock/microchip,mpfs-clock.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/dt-bindings/clock/microchip,mpfs-clock.h b/include=
/dt-bindings/clock/microchip,mpfs-clock.h
> > index 79775a5134ca..b52f19a2b480 100644
> > --- a/include/dt-bindings/clock/microchip,mpfs-clock.h
> > +++ b/include/dt-bindings/clock/microchip,mpfs-clock.h
> > @@ -44,6 +44,11 @@
> >
> >  #define CLK_RTCREF	33
> >  #define CLK_MSSPLL	34
> > +#define CLK_MSSPLL0	34
>=20
> You add this new CLK_MSSPLL0 macro with the same value as CLK_MSSPLL, but
> never seem to use it in this series. Did you mean to rename the CLK_MSSPLL
> instances CLK_MSSPLL0?

Yes, that was my intention.

--keUDLXTW9SCPY39T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXNt0gAKCRB4tDGHoIJi
0mr/AQDAPWA0oJFGAgd3kwzO+18/rBTPVxEGkrO5J9+fukpyOAEAyrgQk4472IpW
41zAPoXiQ9UbdlNLIljJi2H7VMzCYAw=
=YxhE
-----END PGP SIGNATURE-----

--keUDLXTW9SCPY39T--

