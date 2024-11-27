Return-Path: <linux-can+bounces-2245-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6041C9DAE38
	for <lists+linux-can@lfdr.de>; Wed, 27 Nov 2024 21:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2626E282AD8
	for <lists+linux-can@lfdr.de>; Wed, 27 Nov 2024 20:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D476146017;
	Wed, 27 Nov 2024 20:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onG5im7E"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2C712E1E0;
	Wed, 27 Nov 2024 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732737657; cv=none; b=AOwxl0cA7j67oMUI89OUKrsne+R1PhAzcwevM6arm/BQS2EEQmsBZ28lShuzfDVLAatjIZsaOT017eSyVLpQkLPhHLulPVyfwPZtwpC6TQG+ujlughLmwsmasZVsZ9w5cLANEdddN9VBYNr0XTDCXF1chluuh//cfv0lGUpJTjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732737657; c=relaxed/simple;
	bh=GSQuKY+CoM9g7BABvmcCq23+zynQ3pDRGpC2+PRywAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JX2o2+VUNfaUp7QVc1BeQttKDInijDoj0QwKpE2tb9AUTA1mpb9fcJaDkQ6do0/yxspaxgRww0f8AaiOAORyw2N8Pp88m0jTSCv/j6UEcyj98xULoDYgJdyNUWqbuo9kVA7RM8xqopNHp15JoWSZh1MVEdb9narfGung3ZVL3hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onG5im7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192A2C4CECC;
	Wed, 27 Nov 2024 20:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732737656;
	bh=GSQuKY+CoM9g7BABvmcCq23+zynQ3pDRGpC2+PRywAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=onG5im7ElUsb4nUSUbhcNhCPwnW4quLxP2/Xh2ZvFWOa4vSRDOvQNUx0z1ga00zad
	 6ngJCYp9VryK0M5uuNjsj9c2VEcEpl1Ve14x4l9t4pClhn7AUp4/NJEOv7B7f8VDL8
	 7SYbsLJeEBaQUgqGzRqeYcYQ3tOHZh0uFLwhlHaQKDcUPyJpYCBNzOfM5La4OLMBNR
	 WQ91fB+18EFOCUiSYUIMOkDbEH2GMLnUwBFyjGHs7VzNOv2ETx1o401BIKqf0RUDYx
	 OlW3fwrvxd/eVU1BtLkg1Y6Q3Ehd4Z0mf9+OWry8EqwDzKH7FJUuJy0K1d+0SqubAA
	 xGVs2OXIVxJGg==
Date: Wed, 27 Nov 2024 20:00:51 +0000
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
Message-ID: <20241127-quaintly-splinter-fd8761a404ad@spud>
References: <20241127-tcancclk-v1-1-5493d3f03db1@geanix.com>
 <20241127-siberian-singular-c2b99a7fd370@spud>
 <pl22u3ybv3ibnpzmgiskppz56vlvqhlz25h7s5ewunkks6ywtn@v6lgln7s536w>
 <lmyugclgwb7txf3jxc3fsasp5fgu7fji5dxb2wjw4jji32omnt@rs27camphw7q>
 <20241127-myth-lily-122b9839cc0b@spud>
 <yndgosvrbdawcln2adxh6blypf4joejjd5vygogxq7ii5o3ifs@v25ai7joiutx>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="paADetfVWSXra5Dy"
Content-Disposition: inline
In-Reply-To: <yndgosvrbdawcln2adxh6blypf4joejjd5vygogxq7ii5o3ifs@v25ai7joiutx>


--paADetfVWSXra5Dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 07:13:27PM +0100, Sean Nyekjaer wrote:
> On Wed, Nov 27, 2024 at 04:18:59PM +0100, Conor Dooley wrote:
> > On Wed, Nov 27, 2024 at 05:10:31PM +0100, Sean Nyekjaer wrote:
> > > On Wed, Nov 27, 2024 at 04:56:13PM +0100, Sean Nyekjaer wrote:
> > > > Hi Conor,
> > > >=20
> > > > On Wed, Nov 27, 2024 at 03:50:30PM +0100, Conor Dooley wrote:
> > > > > On Wed, Nov 27, 2024 at 02:40:47PM +0100, Sean Nyekjaer wrote:
> > > > > > tcan4x5x requires an external clock called cclk, add it here.
> > > > >=20
> > > > > That's not what this patch is doing, the clock input is already t=
here,
> > > > > so I don't know what this patch actually accomplishes? clock-name=
s isn't
> > > > > a required property, so you can't even use it in a driver.
> > > > >=20
> > > >=20
> > > > Thanks for asking the right questions :)
> > > >=20
> > > > I know the clock input is there, but it looks (to me) like the driv=
er looks for the
> > > > specific clock called cclk:
> > > > https://elixir.bootlin.com/linux/v6.12/source/drivers/net/can/m_can=
/m_can.c#L2299
> > > > https://elixir.bootlin.com/linux/v6.12/source/drivers/net/can/m_can=
/tcan4x5x-core.c#L396
> > >=20
> > > Oh I really need to get my head around the dt jargon :)
> > > Yes I'll add the clock-names to the required list for v2!
> >=20
> > btw, where even is ti,tcan4x5x.yaml? I was gonna paste the fixes tag you
> > should be using but I couldn't find the file in linux-next.
>=20
> It's here:
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/co=
mmit/?h=3Dtesting&id=3D77400284f54b9a1f6b6127c08cb935fc05e5c3d2
>=20
> Do you think the fixes tag is needed?
>=20
> Fixes: 77400284f54b ("dt-bindings: can: convert tcan4x5x.txt to DT schema=
")

Ideally it'd get squashed if it isn't even in next, but ye if you made
the clock required on this platform in the conversion then you should've
made clock-names required too since the driver uses it.

--paADetfVWSXra5Dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0d6cwAKCRB4tDGHoIJi
0gfKAP9MP+E5bIjCWFRdaGdZ0vA7MzGAPB+XmZuolZ+D9tkV4QEA17+RHvT0w4Jn
QuYi5+MrBP9Zb5pSB4k7EhLDTEY+JAg=
=2DXS
-----END PGP SIGNATURE-----

--paADetfVWSXra5Dy--

