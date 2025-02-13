Return-Path: <linux-can+bounces-2817-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B9EA34F04
	for <lists+linux-can@lfdr.de>; Thu, 13 Feb 2025 21:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA52316D998
	for <lists+linux-can@lfdr.de>; Thu, 13 Feb 2025 20:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8741224A063;
	Thu, 13 Feb 2025 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjnfPFOa"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2FF28A2CB;
	Thu, 13 Feb 2025 20:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477247; cv=none; b=A5ownosPyHXSFgJUVQ00UOMcGhNr9wGcnP+O+2hKIbuYIIyAL9+7dpqmVsSE4GbeUOmh05xSr6XbMXWhinRhTpEhbEwHegdCyKhe2ZCYWWnhjW7dw0qYSMct5+dr89298xTryhgCImauu8Z5QzCzeY6NAC/67pk1c9FpbvldSEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477247; c=relaxed/simple;
	bh=3DmcbEkHgnPTKF7R+BfX1ZJqHTWQE6R1Af0rscBhj5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDMocjB0uq5BM3dRCREO7gvwVzWPLKwb6sS1uJ4IARdX/bQp4GnKz05/0UDrERw+YyJOYLszFbrMcTFXwxs4Mm+jmKvA8gCwQ9V7aD4nylIDAwnp2MsGetbimJFUnz0cM/r2A26eN8EUJjsXp5RMDV3L8O0MCYPyGZIKaIJnvyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjnfPFOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADE9C4CED1;
	Thu, 13 Feb 2025 20:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739477246;
	bh=3DmcbEkHgnPTKF7R+BfX1ZJqHTWQE6R1Af0rscBhj5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mjnfPFOaeXN14HgJgFnJvL+lBMgQFzs0G4SJNJhYx3lawMt3SAHUUu/wufXKFhdQv
	 x4bpqkL10lxnllvTNTgM9VujRp6+hgtmRRXVJPooL1usHydwfr9nEby2GE6AqxbESD
	 KlKChRrKXqfVspbh4hRe247dmUW+Q5iIOWnQcDWM9uQPmkUkMlL9bpRZcgfkCh78J3
	 wkWJqO6er0GNMOVdBGV531cgevhvWbcXqFDfQ3rRdlY1AoqwL/csw6EMpMbxTdGg2a
	 R6xFQE2pmIJFX6dPnCVRIgHlXhL0l+4tbS5qBMoez5a5cd5EcIuVdSsVRZ4/VxwH0y
	 MvFDWKjShNWMg==
Date: Thu, 13 Feb 2025 20:07:22 +0000
From: Conor Dooley <conor@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: dimitri.fedrau@liebherr.com, Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: can: fsl,flexcan: add transceiver
 capabilities
Message-ID: <20250213-scariness-enhance-56eda6901f69@spud>
References: <20250211-flexcan-add-transceiver-caps-v1-0-c6abb7817b0f@liebherr.com>
 <20250211-flexcan-add-transceiver-caps-v1-1-c6abb7817b0f@liebherr.com>
 <20250211-epidermis-crib-b50da209d954@spud>
 <20250212195204.GA6577@debian>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tSopz/7vpBki9Xj2"
Content-Disposition: inline
In-Reply-To: <20250212195204.GA6577@debian>


--tSopz/7vpBki9Xj2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 08:52:04PM +0100, Dimitri Fedrau wrote:
> Am Tue, Feb 11, 2025 at 04:38:48PM +0000 schrieb Conor Dooley:
> > On Tue, Feb 11, 2025 at 02:12:33PM +0100, Dimitri Fedrau via B4 Relay w=
rote:
> > > From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > >=20
> > > Currently the flexcan driver does not support adding PHYs. Add the
> > > capability to ensure that the PHY is in operational state when the li=
nk
> > > is set to an "up" state.
> > >=20
> > > Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > > ---
> > >  Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.ya=
ml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> > > index 97dd1a7c5ed26bb7f1b2f78c326d91e2c299938a..397957569588a61111a31=
3cf9107e29dacc9e667 100644
> > > --- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> > > +++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> > > @@ -70,6 +70,9 @@ properties:
> > >    xceiver-supply:
> > >      description: Regulator that powers the CAN transceiver.
> > > =20
> > > +  phys:
> > > +    maxItems: 1
> >=20
> > Can all devices in this binding support external phy? Are all devices
> > limited to a single external phy?
> >=20
> As far as I know, these devices are controllers without integrated PHY.
> So they need a single external PHY. Transceivers can be very simple like
> xceiver-supply in the binding, but I want to use "ti,tcan1043" in=20
> drivers/phy/phy-can-transceiver.

I'm not quite following, do all of these devices need to have an
external phy but the property did not exist until now? How did any of
them work, if that's the case?

--tSopz/7vpBki9Xj2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ65Q+gAKCRB4tDGHoIJi
0kqpAPsGLUPRbO7MpIYG5HFwrss+7TGqLMfS7u0SUFSFBLj9IAD/VRU65YL7Ee+6
HXBEGk8jv/xZxw2DyNhLUnZURTh4Nw0=
=UKHj
-----END PGP SIGNATURE-----

--tSopz/7vpBki9Xj2--

