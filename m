Return-Path: <linux-can+bounces-82-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A259580AA97
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 18:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2BE1F21115
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 17:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055AB3984B;
	Fri,  8 Dec 2023 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asAvpaBX"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC4938F80;
	Fri,  8 Dec 2023 17:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEEAC433C8;
	Fri,  8 Dec 2023 17:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702056088;
	bh=ryi1+JoVfvgu/u0KzMXd0k5DlGLPr5+GS23H098zLjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=asAvpaBXzdOpyoA0TtI3pkRNSJhbYdZyq+M5kiBfp3doZzKntMBxjRpQZL/i/E1pW
	 X9KMj34VwfBlGJe5jJv/TcIY1Rsf1XvdBeVWDQOrTHKuujFDz3MhcAY3sVco58dHET
	 Ac3nVenKZwcCxdoONX+h7Ap4l8xSIbByhRuDSXyBBaHuTdd781U39IpaUa4nQl+hJ2
	 aTVhjLoSzphqmmvoY7inlhIOWstPPskRHGUnUMjF+/KT/55bqKHJo0OxKxu2HnlZ4s
	 jbNXijq5InVNIvpg7bDRGWD/okT2k8pYX5NvvJJEHGbwV2wQmgI9zGECJMnwTni8IR
	 bfsBNvXrybyrQ==
Date: Fri, 8 Dec 2023 17:21:22 +0000
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
Subject: Re: [PATCH RESEND v1 0/7] MPFS clock fixes required for correct CAN
 clock modeling
Message-ID: <20231208-overlay-idiom-620c83d2775c@spud>
References: <20231208-reenter-ajar-b6223e5134b3@spud>
 <20231208-atonable-cable-24ce1ceec083-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qTXgDU+xTXR37z/4"
Content-Disposition: inline
In-Reply-To: <20231208-atonable-cable-24ce1ceec083-mkl@pengutronix.de>


--qTXgDU+xTXR37z/4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 06:17:54PM +0100, Marc Kleine-Budde wrote:
> On 08.12.2023 17:12:22, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > Resending cos I accidentally only sent the cover letter a few minutes
> > prior to this series, due to screwing up a dry run of sending.
> > :clown_face:
> >=20
> > While reviewing a CAN clock driver internally for MPFS [1]
>=20
> > 1 - Hopefully that'll show up on the lists soon, once we are happy with
> >   it ourselves.
>=20
> A CAN clock driver or a complete CAN driver?

Heh, should have proof read it again in the time afforded to me by the
accident release of the dry run.. It's the latter, sorry.

--qTXgDU+xTXR37z/4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXNQkgAKCRB4tDGHoIJi
0iZWAPwNWUowlloTZivBoyo83wk1jjTAlFSA9wYjLGxZhT8cXAD7Bt8TdOacG3dL
eZWhIXHj1CMUfYoRUaqAPO5bzj51xAk=
=/P9s
-----END PGP SIGNATURE-----

--qTXgDU+xTXR37z/4--

