Return-Path: <linux-can+bounces-583-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA678BD25C
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 18:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76583B24128
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 16:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A78215623D;
	Mon,  6 May 2024 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdjHTtbT"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01966762D2;
	Mon,  6 May 2024 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012189; cv=none; b=bBADECh45m6ZJkEhEnJ2E5p1qphnPKCejFhrvGJKHtvoixc22tE22O/cKc/QgB6oCkFm5SEXCqPeKItW1AEiaIKbOXC0vOh4Q1Q5nEF4p+tLCi363LJg8ZYiCnm3juIKx2kAEvRVznXyZz0LQb26MzF6xGVzcexsBN8UloqNY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012189; c=relaxed/simple;
	bh=Ri+Ds/sxr7JPSlqfXZs9ek55V/5xijmm8kLTGaAtM+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wcy8VnRakn94Suky0GqLPd0QAQxBnaHvVDbZkZY65gC5jd5gHfrSm4CSc8XXscLmCbVGvZiGe/4oL2UlARk/65WXvNnZLPWmj0zFfwAa8KeDxJYEVKc56U2RDLUuxJ3lkbl11HDXISbq1zqlAH4zEt52nsmapuoeH7zyoxZT/DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdjHTtbT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4133C116B1;
	Mon,  6 May 2024 16:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715012188;
	bh=Ri+Ds/sxr7JPSlqfXZs9ek55V/5xijmm8kLTGaAtM+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XdjHTtbTI+PnJbt3+foEezrLOaFgc/U60jkZ/Jj5gbqgM8E39usquZY7RtapwnEOT
	 VPz5GIQIFsFfd9AOr7VvKIdqL7l0dwfy5TIa4m2D1c01GtOESwC/I/xCXOpB1cee1J
	 EsKeGp+ddI/auKBDXQZjHy0iiMg5MXVeJ015n3toLJsU3Y6u66hLSR0l+zmd/Njisz
	 4KCaQfVYj0HwP3ajDKdQiUPaUyJzUABEChS5qZIHXOJNkgbhuZ8fEGJOEQ0mH4XF19
	 SPWQZ0ufjnSJF6TsMM0xTsjYN+5zGrvAaYN97WinwFWyQp1E72XqMASCQ4mjgdh82t
	 1kbe2Uj/925sw==
Date: Mon, 6 May 2024 17:16:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Christoph Fritz <christoph.fritz@hexdev.de>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andreas Lauser <andreas.lauser@mercedes-benz.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 06/11] dt-bindings: net/can: Add serial (serdev) LIN
 adapter
Message-ID: <20240506-jaws-cheesy-bf94885651c1@spud>
References: <20240502182804.145926-1-christoph.fritz@hexdev.de>
 <20240502182804.145926-7-christoph.fritz@hexdev.de>
 <20240503-fading-extruding-2105bbd8b479@spud>
 <a5b894f8dc2ab0cf087a5b4972d7f752e6c17c16.camel@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IZWKdHDwzN9uOGw5"
Content-Disposition: inline
In-Reply-To: <a5b894f8dc2ab0cf087a5b4972d7f752e6c17c16.camel@hexdev.de>


--IZWKdHDwzN9uOGw5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 08:29:15PM +0200, Christoph Fritz wrote:
> Hello Conor,
>=20
>  thanks for having an eye on this, please see my answer below.
>=20
> On Fri, 2024-05-03 at 18:12 +0100, Conor Dooley wrote:
> > On Thu, May 02, 2024 at 08:27:59PM +0200, Christoph Fritz wrote:
> > > Add dt-bindings for serial LIN bus adapters. These adapters are
> > > basically just LIN transceivers that are hard-wired to serial devices.
> > >=20
> > > Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> > > ---
> > >  .../bindings/net/can/hexdev,lin-serdev.yaml   | 32 +++++++++++++++++=
++
> > >  1 file changed, 32 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/net/can/hexdev,=
lin-serdev.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/net/can/hexdev,lin-ser=
dev.yaml b/Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml
> > > new file mode 100644
> > > index 0000000000000..c178eb9be1391
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml
> > > @@ -0,0 +1,32 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/net/can/hexdev,lin-serdev.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Serial LIN Adapter
> > > +
> > > +description:
> > > +  LIN transceiver, mostly hard-wired to a serial device, used for co=
mmunication
> > > +  on a LIN bus.
> > > +  For more details on an adapter, visit <https://hexdev.de/hexlin#tt=
y>.
> > > +
> > > +maintainers:
> > > +  - Christoph Fritz <christoph.fritz@hexdev.de>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: hexdev,lin-serdev
> >=20
> > Maybe I've just missed something on earlier versions that I didn't
> > read, but the name of the device on the website you link is "hexLIN",
> > so why is "lin-serdev" used here instead?
>=20
> The USB one is called hexLIN and has it's own HID driver.
>=20
> This serial LIN adapter doesn't really have a product name. Currently
> on our website it's generically called 'UART LIN Adapter'.
>=20
> This LIN adapter is basically just a LIN transceiver and very generic,
> so that one could solder it to any single-board computer with an uart.
>=20
> I think 'lin-serdev' for LIN and serial device fits great, also serdev
> is the name of the used kernel infrastructure (besides the LIN glue
> driver).
>=20
> If you still don't like it, I'm open to other names. What about
> "hexlin-uart" or "linser"?

I dunno, I don't really care about it being called "hexlin,lin-serdev",
all that much, I just found it confusing that the link in the description
sent me to the ""Hello World" in LIN" section of your site. If it had
dropped me off at the "UART LIN adapter" section things woud've been less
confusing.

That said, calling the compatible after a linux-ism is a bit odd to me
when the device seems to be called a "UART LIN adapter" on the page, not
a "serdev".

Cheers,
Conor.

--IZWKdHDwzN9uOGw5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjkCVQAKCRB4tDGHoIJi
0hFNAP9IZ2xs8L+8HDUj7EwsmhlcnekaNMvoaAPmci+3S7sVGwEAhYXvEL9+hMC2
gv7FekqGBwL+ccs/QA/5F4W2A+cBpgA=
=wRuw
-----END PGP SIGNATURE-----

--IZWKdHDwzN9uOGw5--

