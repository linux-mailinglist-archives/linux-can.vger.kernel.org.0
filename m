Return-Path: <linux-can+bounces-2243-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380FA9DABA2
	for <lists+linux-can@lfdr.de>; Wed, 27 Nov 2024 17:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346AA1650C0
	for <lists+linux-can@lfdr.de>; Wed, 27 Nov 2024 16:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8C3200BB6;
	Wed, 27 Nov 2024 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6+bDJWT"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51967200BB1;
	Wed, 27 Nov 2024 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724344; cv=none; b=TGM6kOd/Q5qGUxXDw6PBYAISQ43ij9zhzUdUKXBZ5+wmh8rl+DWA1BSMY157oYL4SUaLemg8k/k1oX5o4gFIbstCnjlXL2kIeC865iyLYkrREiryGNrNslkoj3Oel6Fy2qSfcTrsRK3Bk+XhGcr/BnlAHoWlrMHQa4HdGzYtA+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724344; c=relaxed/simple;
	bh=N/F/nu4EPomDe0PNZxW7kt5NLpIvQhDIAVNnHLwbFMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwNyknLHjV7vGmjQ3jty0hu35tCEcAH+2XbZZfJPRBx+yTO6w5GiaG2JebIni6ZIdQnUHzGzea4SOu7kTHHd7XtD54gOvU6L7U+LkeT8Z6HHF2fODN2ij536y8xvY+2ZO8U0eDwdo5XiN/Patdok4v1m7ZmfEdLNxP/S2OGlt5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6+bDJWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9265C4CEDA;
	Wed, 27 Nov 2024 16:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732724344;
	bh=N/F/nu4EPomDe0PNZxW7kt5NLpIvQhDIAVNnHLwbFMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b6+bDJWTQRiQvMpF8t3PX95Nba4gsqha6jyicokWrt8v8FmxcBez1IqzYlJpdhcuK
	 X9k1nYUwNiHwOtJSwKLPQCT7t0R9WvAkQUIcBrQ+rSQoaaclJQ9EHqzpx79ZjwxF94
	 RxMTbxFMgcu86oMUqXQsQa7leLSljIyfT8rhaXu3gGmhWNMHazm0JmM6WaLKk/2iWG
	 ODeeaVvjvf8s+otSpc6OHNwCYBjjOirOhzrSsLh+/TM4ct7pRwrdS4EwsLkicyxHdH
	 +07nWTMvXHClyVPaumJsv5RUkv8b8zuwBYDRxFqsMKMx8TL4k949CJ7fqSFZsn0XSR
	 nGbSrcxBuo27Q==
Date: Wed, 27 Nov 2024 16:18:59 +0000
From: Conor Dooley <conor@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH can-next] dt-bindings: can: tcan4x5x: add missing
 required clock-names
Message-ID: <20241127-myth-lily-122b9839cc0b@spud>
References: <20241127-tcancclk-v1-1-5493d3f03db1@geanix.com>
 <20241127-siberian-singular-c2b99a7fd370@spud>
 <pl22u3ybv3ibnpzmgiskppz56vlvqhlz25h7s5ewunkks6ywtn@v6lgln7s536w>
 <lmyugclgwb7txf3jxc3fsasp5fgu7fji5dxb2wjw4jji32omnt@rs27camphw7q>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="69C/mtCz1F0Mt/iO"
Content-Disposition: inline
In-Reply-To: <lmyugclgwb7txf3jxc3fsasp5fgu7fji5dxb2wjw4jji32omnt@rs27camphw7q>


--69C/mtCz1F0Mt/iO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 05:10:31PM +0100, Sean Nyekjaer wrote:
> On Wed, Nov 27, 2024 at 04:56:13PM +0100, Sean Nyekjaer wrote:
> > Hi Conor,
> >=20
> > On Wed, Nov 27, 2024 at 03:50:30PM +0100, Conor Dooley wrote:
> > > On Wed, Nov 27, 2024 at 02:40:47PM +0100, Sean Nyekjaer wrote:
> > > > tcan4x5x requires an external clock called cclk, add it here.
> > >=20
> > > That's not what this patch is doing, the clock input is already there,
> > > so I don't know what this patch actually accomplishes? clock-names is=
n't
> > > a required property, so you can't even use it in a driver.
> > >=20
> >=20
> > Thanks for asking the right questions :)
> >=20
> > I know the clock input is there, but it looks (to me) like the driver l=
ooks for the
> > specific clock called cclk:
> > https://elixir.bootlin.com/linux/v6.12/source/drivers/net/can/m_can/m_c=
an.c#L2299
> > https://elixir.bootlin.com/linux/v6.12/source/drivers/net/can/m_can/tca=
n4x5x-core.c#L396
>=20
> Oh I really need to get my head around the dt jargon :)
> Yes I'll add the clock-names to the required list for v2!

btw, where even is ti,tcan4x5x.yaml? I was gonna paste the fixes tag you
should be using but I couldn't find the file in linux-next.

--69C/mtCz1F0Mt/iO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0dGcwAKCRB4tDGHoIJi
0p0BAP4gmHnm82HGWqBjdxIMq26VKuKZCC4ecqJjbv5MGKl3AAD9E0H7SqA9/FYW
UuuUC1qT3nAtBzfGJ83EN89AnfTCwgw=
=vdsg
-----END PGP SIGNATURE-----

--69C/mtCz1F0Mt/iO--

