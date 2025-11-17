Return-Path: <linux-can+bounces-5471-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB929C65B7D
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 19:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id DEA1C28C32
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 18:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5BE312803;
	Mon, 17 Nov 2025 18:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPHcpXOF"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5F930CD87;
	Mon, 17 Nov 2025 18:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763404201; cv=none; b=qS7QQSg57/skfMY1VDvKjPJPZmI9+jyPKN/oxnf+v8P8p86aiZh6IQpHIQYhbLvanpA1uQkDoiDomJpUr+10MQ5Ox5Imuelhwmikw9T9lapyT65s8iYHflQcFYjcOYMxVBPeiGN4JlIYi51ecOXfKpG+q8BvZWMx43lMKoEz7sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763404201; c=relaxed/simple;
	bh=vS2qoZFaDwTz47Zow58QbyqMl1Lvm3hLFL8m9IyE1T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/Z0DVQErIVbH/fHLQq5XhpJa5YInGLcQ4kD936IPEtmHJ9lY6mNulMWULoWmC4ytaI7qMFvdJZC4jtVKqwwyFkgI6AFiQgvORPsadenGS0au8E0J+QppanyRNtzJ49IXpPR3yTyD0ll+doH/OwmusYXwogmb41B2j5Ss8PPG/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPHcpXOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DF0C19423;
	Mon, 17 Nov 2025 18:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763404200;
	bh=vS2qoZFaDwTz47Zow58QbyqMl1Lvm3hLFL8m9IyE1T4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BPHcpXOFPsnvK8Yo6l71yPqBmGdNVKVmLiLsIEYZcfn+ZsQwwPECJlVhFJt9pQ0n4
	 lZPwoLyGRHLkNf9LgRAlFcx93RSTSggdTO+JPj/TMYBKuVAfIxHePQyoiy6VM24PsX
	 YR5AxU+DO2tAABSoPc61mhN6xkbICE2iaKxo+OjsO/NfrqUg8fpnjUWXUQwqJ1w9bM
	 lwF2lCrqpAH3AWlWcUMhjkZaC1L5qfKlkjctTfA1rpEfmI0yrCTX57qRcjABkWj9PA
	 WpaiTjuAtdymQZYNrrCWf07vQ63IJIbHIMvu7cJRqGQgL9SXz7fIGdycD19PDSyNlT
	 b+5lJnUoXreXQ==
Date: Mon, 17 Nov 2025 18:29:55 +0000
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, devicetree@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>
Subject: Re: [net-next v1] dt-bindings: can: mpfs: document resets
Message-ID: <20251117-example-spoiled-6b098fb9fdcc@spud>
References: <20251117-twitter-sternness-f2b3a1506a6f@spud>
 <176340406423.422791.14985477842686606616.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3oRJEmGRROVbDJnx"
Content-Disposition: inline
In-Reply-To: <176340406423.422791.14985477842686606616.robh@kernel.org>


--3oRJEmGRROVbDJnx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 12:27:44PM -0600, Rob Herring (Arm) wrote:
>=20
> On Mon, 17 Nov 2025 16:38:18 +0000, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > The CAN cores on Polarfire SoC both have a reset. The platform firmware
> > brings both cores out of reset, but the linux driver must use them
> > during normal operation. The resets should have been made required, but
> > this is one of the things that can happen when the binding is written
> > without driver support.
> >=20
> > Fixes: c878d518d7b6 ("dt-bindings: can: mpfs: document the mpfs CAN con=
troller")
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > This is the second mistake in this binding, both spotted because of the
> > driver being written (although this one sat downstream for a while for
> > w/e reason). I wish I could say that I'd send the driver soon, but I am
> > busy upstreaming things I wrote and therefore understand at the moment,
> > so a driver that I'd have to go understand and review before sending is
> > low priority, sorry!
> >=20
> > CC: Conor Dooley <conor.dooley@microchip.com>
> > CC: Daire McNamara <daire.mcnamara@microchip.com>
> > CC: Marc Kleine-Budde <mkl@pengutronix.de>
> > CC: Vincent Mailhol <mailhol@kernel.org>
> > CC: Rob Herring <robh@kernel.org>
> > CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > CC: linux-riscv@lists.infradead.org
> > CC: linux-can@vger.kernel.org
> > CC: devicetree@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> > ---
> >  .../devicetree/bindings/net/can/microchip,mpfs-can.yaml       | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/can/microchip,mpfs-can.example.dtb: can@2010c000 (microchip,mpfs-can): '=
resets' is a required property
> 	from schema $id: http://devicetree.org/schemas/net/can/microchip,mpfs-ca=
n.yaml

Two issues in the same branch now, there's something weird going on with
my test script. /sigh guess that's my evening gone.

--3oRJEmGRROVbDJnx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRtpoAAKCRB4tDGHoIJi
0kh6AQDMah2x5pv9Jzm5qa7f0RyDe8XjE7XPyOd57IzKk9dJkwD+IxCrlcQTptpQ
nFJQ8qoKO1RnWBRPhwCx/w6xxgbCiQE=
=Xgh5
-----END PGP SIGNATURE-----

--3oRJEmGRROVbDJnx--

