Return-Path: <linux-can+bounces-4451-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A39EEB426DD
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 18:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D94C6831B2
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 16:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B031C2D239F;
	Wed,  3 Sep 2025 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLud6noU"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815212C11D5;
	Wed,  3 Sep 2025 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916761; cv=none; b=gktnbVxDgzC/8LYEgRBkNVmQfTBFuly9L/kXX8U9gA6HLv+4CPrEtQwq0KyFps9OTJ4THdaR086p2VdsHRgfIH450pbhZnn1dZ7/fdeqmsbJ57fC4vJ2uRC5Yq54rwEnt0r+dWT1+jKzwglNl9FrkPCu2l4vm+m0UUG+yonilaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916761; c=relaxed/simple;
	bh=BDjIUd2kVTCwm9T6bUGQ8NdZz69FUdPuVZPsHBAlutY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBVThTl5nooLGjue3MuX2/HF5Ibcnlq3zFoZbTtiQKV5XV1khHpmvb+ZHtsIiRTu7aTp2cKFYHnYJghRwbuQ+ffxZUiwhiqrh0bWR+TNB+XTZ2I1dZiTu7b26AX/FJtlUhfujDSG6EDF3/y973WTx8KSmMel7zp78Di5qQ+QJpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLud6noU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C3CC4CEF4;
	Wed,  3 Sep 2025 16:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756916761;
	bh=BDjIUd2kVTCwm9T6bUGQ8NdZz69FUdPuVZPsHBAlutY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oLud6noUZebhHPdVOSQahlEVZJFRIn034FaEZXbQAAYwcplOxVvFyrickxAmWN6R5
	 rnIJM4qvtlIh/GWu4Iz2cB11IkV/cHpCZcdDW71Rch+bF7K4cJQWnkJRuSRXaWn/j+
	 va/2fRf4OMKmJv0ZqZEFrrc7z8YDTDNPxXGN2+ZfZ/QfnZSchP19vNi4JcYUmGZE/a
	 v2D7+Ay4myy1WbHd1jlihyF05zlDOGhqnCp9kaji+Py2AyZb5byWe144MJxAHHae2s
	 ptZB7ly3pks1C9gKCF8y6hAwdv6T8FZqkpWN9y6pZGv+mXgnVEsmNktcap6fttUClv
	 tygPeAeBS+ecg==
Date: Wed, 3 Sep 2025 17:25:54 +0100
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
	Bough Chen <haibo.chen@nxp.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 1/6] dt-bindings: phy: ti,tcan104x-can: Document NXP
 TJA105X/1048
Message-ID: <20250903-subwoofer-anyone-bc7aa007927a@spud>
References: <20250901-can-v4-0-e42b5fe2cf9e@nxp.com>
 <20250901-can-v4-1-e42b5fe2cf9e@nxp.com>
 <20250901-diligent-dreaded-59b9ad5c3976@spud>
 <20250901-uproar-shrill-07d51ea21a29@spud>
 <PAXPR04MB845991442136C0BEF0540D6A8806A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250902-dastardly-truth-fb2be9f68e4a@spud>
 <PAXPR04MB8459F58B1FCF532F0DE802438801A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <PAXPR04MB845903CF3D03A436925150238801A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kpMiHlovSVn8VNfU"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB845903CF3D03A436925150238801A@PAXPR04MB8459.eurprd04.prod.outlook.com>


--kpMiHlovSVn8VNfU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 03, 2025 at 06:49:47AM +0000, Peng Fan wrote:
> > Subject: RE: [PATCH v4 1/6] dt-bindings: phy: ti,tcan104x-can:
> > Document NXP TJA105X/1048
> >=20
> ...
> >=20
> > Thanks again for the detailed reading into datasheet.
> >=20
> > Yes. But I would like to only keep one compatible "nxp,tja1051" from a
> > board design level, EN could be always tied to high for TJA1051T/E. So
> > to dt-binding, EN it is optional for all TJA1051 variants.
> >=20
> > I am thinking to use below compatible in V4 for the devices added in
> > this patch. Does this look good to you?
> >=20
> >       - items:
> >           - const: nxp,tja1057
> >           - const: nxp,tja1051
> >       - enum:
> >           ....
> >           - nxp,tja1048
> >           - nxp,tja1051
>=20
> Considering TJA1057 does not have EN, I may need to use:
>       - enum:                                                            =
                          =20
>           ....
>           - nxp,tja1048                                                  =
                          =20
>           - nxp,tja1051                                                  =
                          =20
>           - nxp,tja1057                                                  =
                          =20
>          ....

Seems reasonable to me, go for it.

--kpMiHlovSVn8VNfU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaLhsEgAKCRB4tDGHoIJi
0nj8AP9rGJfvEe4zLkBt1ZJjQLFKT1/3vKVWjJX3TBZo83gmxwD/RtmQzj11THLq
lOmFaI/VUQJB0FLk3mi7pCWUeLs+sw8=
=4zb4
-----END PGP SIGNATURE-----

--kpMiHlovSVn8VNfU--

