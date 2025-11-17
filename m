Return-Path: <linux-can+bounces-5472-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 300AAC65C01
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 19:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C447C353E2E
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 18:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999E7314D03;
	Mon, 17 Nov 2025 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijsTdrG2"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664522FFF99;
	Mon, 17 Nov 2025 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763404922; cv=none; b=Ha183aI5gbHD6RXIN3hDRHnGcFQmKxNKJs8kwevkBWr2ba5PZgemTZeK59FIq+ixY+w/oo+OYjilT/AfpFT6wjSl/X54dn73WA/fkYWXh6Bp7B50muKw5pPiMlw/pXoyfF97BZMTigAF4NMpEC5ITGNnPygJJIK2mmkpmoP8fJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763404922; c=relaxed/simple;
	bh=JZPvJG4H9TtURVS4KR4gxr5gf352lFKsvwgszLWc4oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fylow0yPiEgWnogrhl8RBdd4eo31XTtBzsIzXyVf8/25syl+MMKVhFHDsPH2rAXlp2l4h1xu96dNmgBWWqsTNylawiKa0weFW9jtwCrhOpvSI9ut9rUs5MeAdhrjCRVC7iy/YEDhfkrLXlePVe0HyGW4XQjd20D7ZqGLMWQdu+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijsTdrG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E5EC4CEF5;
	Mon, 17 Nov 2025 18:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763404921;
	bh=JZPvJG4H9TtURVS4KR4gxr5gf352lFKsvwgszLWc4oU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ijsTdrG2Ikg8KgFdoRtI7ulj6jVyS1KWCGCJgvBa1yf7t6CRz6FojOhQF0A6JuAPZ
	 /mUhZNBrN4zla8f5jiM/SlJW2zNVZ4rJI4a866fH3kMqRDoX3622ehfhSyMop4LlzN
	 q0fgLl/jeWED9IGi55wLJBFUfRRGssqloNdKiPL8TPoCwrfamcK2TdfBqfIOzM9K4m
	 ZjFEGxVrp0cs+bIjOizIGnE8Cy1dxumxqPoi2KWO0yi9UBa5QS7qeYJJuJGRyBIKgJ
	 j+uGT+fWugqhNwQIkOuPboYKpTSuu0IrS/h70FB1tRg+OKZVAwya6Bg/0niW6groHK
	 K5Dx1yubgO1hg==
Date: Mon, 17 Nov 2025 18:41:56 +0000
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, devicetree@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>
Subject: Re: [net-next v1] dt-bindings: can: mpfs: document resets
Message-ID: <20251117-edgy-extenuate-6850a9440802@spud>
References: <20251117-twitter-sternness-f2b3a1506a6f@spud>
 <176340406423.422791.14985477842686606616.robh@kernel.org>
 <20251117-example-spoiled-6b098fb9fdcc@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9jacpcMD8tGHOEF2"
Content-Disposition: inline
In-Reply-To: <20251117-example-spoiled-6b098fb9fdcc@spud>


--9jacpcMD8tGHOEF2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 06:29:55PM +0000, Conor Dooley wrote:
> On Mon, Nov 17, 2025 at 12:27:44PM -0600, Rob Herring (Arm) wrote:
> >=20
> > On Mon, 17 Nov 2025 16:38:18 +0000, Conor Dooley wrote:
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > >=20
> > > The CAN cores on Polarfire SoC both have a reset. The platform firmwa=
re
> > > brings both cores out of reset, but the linux driver must use them
> > > during normal operation. The resets should have been made required, b=
ut
> > > this is one of the things that can happen when the binding is written
> > > without driver support.
> > >=20
> > > Fixes: c878d518d7b6 ("dt-bindings: can: mpfs: document the mpfs CAN c=
ontroller")
> > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> > > This is the second mistake in this binding, both spotted because of t=
he
> > > driver being written (although this one sat downstream for a while for
> > > w/e reason). I wish I could say that I'd send the driver soon, but I =
am
> > > busy upstreaming things I wrote and therefore understand at the momen=
t,
> > > so a driver that I'd have to go understand and review before sending =
is
> > > low priority, sorry!
> > >=20
> > > CC: Conor Dooley <conor.dooley@microchip.com>
> > > CC: Daire McNamara <daire.mcnamara@microchip.com>
> > > CC: Marc Kleine-Budde <mkl@pengutronix.de>
> > > CC: Vincent Mailhol <mailhol@kernel.org>
> > > CC: Rob Herring <robh@kernel.org>
> > > CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > > CC: linux-riscv@lists.infradead.org
> > > CC: linux-can@vger.kernel.org
> > > CC: devicetree@vger.kernel.org
> > > CC: linux-kernel@vger.kernel.org
> > > ---
> > >  .../devicetree/bindings/net/can/microchip,mpfs-can.yaml       | 4 ++=
++
> > >  1 file changed, 4 insertions(+)
> > >=20
> >=20
> > My bot found errors running 'make dt_binding_check' on your patch:
> >=20
> > yamllint warnings/errors:
> >=20
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/net/can/microchip,mpfs-can.example.dtb: can@2010c000 (microchip,mpfs-can):=
 'resets' is a required property
> > 	from schema $id: http://devicetree.org/schemas/net/can/microchip,mpfs-=
can.yaml
>=20
> Two issues in the same branch now, there's something weird going on with
> my test script. /sigh guess that's my evening gone.

I can spend my evening playing poe after all, I am pretty sure this was
caused by running my test script and then immediately switching windows
back and doing a rebase... I'll send a v2 tomorrow or w/e.
pw-bot: changes-requested

--9jacpcMD8tGHOEF2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRtsdAAKCRB4tDGHoIJi
0l5hAQCJe0ZHxyl8cOcnZUgbfN4pt45YDPzZtSMoGnQ2vaE2hAD6AuUA/GHPm7hf
J04T840JoYUU8iCQaeqglW7vXrmShAs=
=e8ps
-----END PGP SIGNATURE-----

--9jacpcMD8tGHOEF2--

