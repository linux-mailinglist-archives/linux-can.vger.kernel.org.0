Return-Path: <linux-can+bounces-2908-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7846A3E239
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 18:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4383C16F821
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 17:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0433320DD47;
	Thu, 20 Feb 2025 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V48dg0Ro"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5CF1FECD1;
	Thu, 20 Feb 2025 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072039; cv=none; b=rM7BAosNVfd4DDj/gRodPCay6Fn55cS5yJCwnm733h8WfMbCT6tm0xQhZbO2Or/018wvMOyCLX0+PL8Yrz9xe5c3YdfVAFf09kJo78kw71p4yIyzWFWVJTAaa8QM9xP/dqaplCDCPSwf06JNZuAXNBNQ0mv7GQ5k5bX4Nor3714=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072039; c=relaxed/simple;
	bh=Hu1WTAfqe+K8mtqQXODfypOXtNqLo8VKfdA62K3E6Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+gLzeb5WBatOKX8aBS6HQdK2IqWSxTPSprWoqm6RENHN9LO9LiPzmiALOmDontDZ5faD0d5gLf99mMHkES8foapr4jXtl2HFxO8gNQ4FraRlmNfOnZOfnncGZCzlTHxlruTDCoqwrPdav9v3m6vlR5FQXKnxvnK0UW+UWp/E4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V48dg0Ro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62945C4CED1;
	Thu, 20 Feb 2025 17:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740072039;
	bh=Hu1WTAfqe+K8mtqQXODfypOXtNqLo8VKfdA62K3E6Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V48dg0RoRUN6ItMpHAomEWvzy7LCNB16MvbcB3yO8qei7e0TU8wMFwJTPYb/VsmxR
	 YznzFN2hyHtMkOv/KBFyFFvYkpCeyPtbBaN+mkU9vS4jb6PvV+UWM7waQL2VfoUo9J
	 +HDxcPhFqIUbWlHqJThGXpqU51bSKDTgN2mDT+ZSBWx+NtJLUZeFZGxsaQvP67ETG3
	 h9VtqEX9FycYDcR4NWW0LNjSW1ZfHxCuNxSUBYxIwczx1oQCU+alH1IeQjLpE9Ku0J
	 C83KM5q1+Ep5V74SENppQ1ge1clkV3+QIxLFib6Nx4mbks5yK2pmMwOw+X8C4BUUWl
	 4W4UKo20naVEA==
Date: Thu, 20 Feb 2025 17:20:35 +0000
From: Conor Dooley <conor@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: can: fsl,flexcan: add transceiver
 capabilities
Message-ID: <20250220-underfed-taekwondo-22c1d4f4eea9@spud>
References: <20250220-flexcan-add-transceiver-caps-v2-0-a81970f11846@liebherr.com>
 <20250220-flexcan-add-transceiver-caps-v2-1-a81970f11846@liebherr.com>
 <20250220-tasteful-loud-firefly-1e2438-mkl@pengutronix.de>
 <20250220155642.GA43726@debian>
 <20250220-intelligent-serious-badger-978793-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cvX9SZ/wFqhw/Mos"
Content-Disposition: inline
In-Reply-To: <20250220-intelligent-serious-badger-978793-mkl@pengutronix.de>


--cvX9SZ/wFqhw/Mos
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 05:02:56PM +0100, Marc Kleine-Budde wrote:
> On 20.02.2025 16:56:42, Dimitri Fedrau wrote:
> > Am Thu, Feb 20, 2025 at 09:44:50AM +0100 schrieb Marc Kleine-Budde:
> > > On 20.02.2025 09:22:10, Dimitri Fedrau via B4 Relay wrote:
> > > > From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > > >=20
> > > > Currently the flexcan driver does only support adding PHYs by using=
 the
> > > > "old" regulator bindings. Add support for CAN transceivers as a PHY.
> > > >=20
> > > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > > Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > >=20
> > > Is it possible express in the biding that we either want to have
> > > xceiver-supply or phys?
> > >
> > I didn't found anything to express that in the binding.
>=20
> What about something like this:
>=20
> | dependencies:
> |   prop-a: ["!prop-b"]
> |   prop-b: ["!prop-a"]

  # the internal reference buffer always requires high-z mode
  - if:
      required:
        - refin-supply
    then:
      properties:
        adi,no-ref-high-z: false

Do it like so ;)

Cheers,
Conor.

--cvX9SZ/wFqhw/Mos
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7dkYwAKCRB4tDGHoIJi
0sOqAQChswDW5EztBIATr02uhJsvr3xn+8xab4wiA4bMf6Q9aQEAhXf6L4AA8aOv
abXs1cmkgb+Qd63fLNDXupY9Ymvq/QM=
=BfK4
-----END PGP SIGNATURE-----

--cvX9SZ/wFqhw/Mos--

