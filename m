Return-Path: <linux-can+bounces-601-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6A08C01C6
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2024 18:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C341C21AFE
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2024 16:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA331292C3;
	Wed,  8 May 2024 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mb+hdOq5"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3571DFD8;
	Wed,  8 May 2024 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715184994; cv=none; b=LgEzfyuMbS6nlMV/o0J/yUg3632Gz24Mxj9ISCU7uq9eBMdAb9gnTf0HKIhHpWmR0MPzcyNnGh4LVUO6fHXcBSQGNCKf86gCuQ12h+/KH+UTdQB8/UFcDsO3m2HA5UMhSWOc3L2SmgxIOM78DwgflqbP+M3HKNb943BxrhMOv6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715184994; c=relaxed/simple;
	bh=7uXx6swrCcj63Q1Kq5orROu6Yte2GQluX/afoi/VjlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUUO66ArORYCZGqZyczkJnh88MSPhFXobdc3P2RMHOkpwH7FGXyWi3MPc3pH/SPUlgziLxNbqm9wl4Pl3y8lXJFN3JaUQGt6LfrhV50e4c8M0v4ULNZg2UBHUuhUrSXtY0JZysKDSciuwq93Tpm+sgxa+G/rzDBICSWQeq5tyYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mb+hdOq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B670CC113CC;
	Wed,  8 May 2024 16:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715184993;
	bh=7uXx6swrCcj63Q1Kq5orROu6Yte2GQluX/afoi/VjlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mb+hdOq53qmHC0tsnwHZjWvs0XBJkKZMEiwnPjJ2mn32qKcZZw4pY0Mo55+FJrmcS
	 /XCsoVhGSe7MSvmWWAwogYlSP3eqAlzXIz9RSwbgfLmeNG7CLVhSPmpXxCzieRVYuZ
	 cOufbq3pU4xhAFLiBblQ/ahAAQ693QQWfoRODWX7xcxLCInUUXMjUdvHgoz9yw0RMM
	 RLtGgoM9mPdmuvYQoPD2BTDowiNH94T95q73biOqRbfHENAbkQ//ZjHtcbEpdr+UQd
	 Vu7kDL3ejYOds/rA8GqKWvTaQTr4SnyOOM0fSjQODFHTymGa9w14L3TTHDG08v3EJe
	 yoCD9p5pfLmbg==
Date: Wed, 8 May 2024 17:16:25 +0100
From: Conor Dooley <conor@kernel.org>
To: Christoph Fritz <christoph.fritz@hexdev.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
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
Message-ID: <20240508-headwear-monorail-a425ac6fe8a8@spud>
References: <20240502182804.145926-1-christoph.fritz@hexdev.de>
 <20240502182804.145926-7-christoph.fritz@hexdev.de>
 <20240503-fading-extruding-2105bbd8b479@spud>
 <a5b894f8dc2ab0cf087a5b4972d7f752e6c17c16.camel@hexdev.de>
 <20240506-jaws-cheesy-bf94885651c1@spud>
 <f1173a7c-f18b-47cc-8873-30347489d1be@kernel.org>
 <b716f34ce54dfed2595690d37c121d242a18ff64.camel@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tlupBOI+4XnNwj6+"
Content-Disposition: inline
In-Reply-To: <b716f34ce54dfed2595690d37c121d242a18ff64.camel@hexdev.de>


--tlupBOI+4XnNwj6+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2024 at 01:34:34PM +0200, Christoph Fritz wrote:
> On Mon, 2024-05-06 at 20:50 +0200, Krzysztof Kozlowski wrote:
> > On 06/05/2024 18:16, Conor Dooley wrote:
> > > > > > +maintainers:
> > > > > > +  - Christoph Fritz <christoph.fritz@hexdev.de>
> > > > > > +
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    const: hexdev,lin-serdev
> > > > >=20
> > > > > Maybe I've just missed something on earlier versions that I didn't
> > > > > read, but the name of the device on the website you link is "hexL=
IN",
> > > > > so why is "lin-serdev" used here instead?
> > > >=20
> > > > The USB one is called hexLIN and has it's own HID driver.
> > > >=20
> > > > This serial LIN adapter doesn't really have a product name. Current=
ly
> > > > on our website it's generically called 'UART LIN Adapter'.
> > > >=20
> > > > This LIN adapter is basically just a LIN transceiver and very gener=
ic,
> > > > so that one could solder it to any single-board computer with an ua=
rt.
> > > >=20
> > > > I think 'lin-serdev' for LIN and serial device fits great, also ser=
dev
> > > > is the name of the used kernel infrastructure (besides the LIN glue
> > > > driver).
> > > >=20
> > > > If you still don't like it, I'm open to other names. What about
> > > > "hexlin-uart" or "linser"?
> > >
> > > I dunno, I don't really care about it being called "hexlin,lin-serdev=
",
> > > all that much, I just found it confusing that the link in the descrip=
tion
> > > sent me to the ""Hello World" in LIN" section of your site. If it had
> > > dropped me off at the "UART LIN adapter" section things woud've been =
less
> > > confusing.
>=20
> Hi Conor and Krzysztof,
>=20
> I guess this is a chromium oddity, because browsing to
>=20
>  https://hexdev.de/hexlin#hexLINSER
>=20
> brings the user to another headline ("hexLIN" not "hexLINSER") as long
> as headline "hexLINSER" can be also displayed.
>=20
> When using firefox, the top headline is hexLINSER as expected (at least
> I do).


Yeah, I think its actually chrome that I saw it originally, but that's
probably irrelevant. After your re-org, in Chrome, if the window is small
enough, I still only see the "3 Open Source Tool: hexLIN" stuff, but
that's not an issue with the binding itself, so I won't hold things up
on that basis.

--tlupBOI+4XnNwj6+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjulWQAKCRB4tDGHoIJi
0tMQAP9fMElMFGNJxdwBsOADn6kLSS6YLWaEOU+ouw82kF76MAEAptNwatRO9P4z
xo6AX9qqibZldOB8BhC2XkjXXCc6BAo=
=k3yE
-----END PGP SIGNATURE-----

--tlupBOI+4XnNwj6+--

