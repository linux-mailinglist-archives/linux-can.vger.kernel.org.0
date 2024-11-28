Return-Path: <linux-can+bounces-2255-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7C29DBBBD
	for <lists+linux-can@lfdr.de>; Thu, 28 Nov 2024 18:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B904028183F
	for <lists+linux-can@lfdr.de>; Thu, 28 Nov 2024 17:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A7A1C07DB;
	Thu, 28 Nov 2024 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KobBLlEy"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392C3211C;
	Thu, 28 Nov 2024 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732814436; cv=none; b=f23P3TwxQ6Uqe+yKDmJOzG9pkulumtPchsIP6UMED+QazvAuytX+NoAYNRwvOA9lSo6lAJNi1zNS1CqMAkHKLUyZH4S2wx1TX3Qmgg1bCnP0DlDSvdpZoP72BMLnuT1C1ZixAZjNsdJnUiDjBBN7+Ex9aQhLRgqS+t2rfIKDw2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732814436; c=relaxed/simple;
	bh=nxQ3tdPX3PVmDwwc/iJ9SATSGZa9q4VWEv6Pdy+kaYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPazggwdPtXkgz1RsXPSzbJ9n6k8jS/KIaiTT9k/7q06yhbN34i1pqq5WL0hmf7m3k26joNC5PXmcLAuyFfWvFo7fhbh4TPbHHqFL6RdKixqJ6DFyuCC/HY1BQjh0K2ram0kYA2qTslwpkO6SHOtOU7LOgLPIteRGQGiDerST60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KobBLlEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5829DC4CECE;
	Thu, 28 Nov 2024 17:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732814435;
	bh=nxQ3tdPX3PVmDwwc/iJ9SATSGZa9q4VWEv6Pdy+kaYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KobBLlEy5BE0KtCyVElCdKK9Ny04y1mr6yAD+ATnV5EAwDTmjFqkzBFcRZk+HHHnL
	 sHTpumMwIeBUioPFKpas2vdtNgxCTlY4XjN+KqAxrnFT1bc8PvtUBXDsk2UqobDb/d
	 QBIOuB7HoVSX+P6YGB+HOUOIaWXmElOqR3+0ouodwZAvdnc62SiqgiKjXZICcU2F9I
	 jkSWLSoVImHhYhzdXEbm7p9TaNL/6f0mwlKZ6+DZ4Cbr5WcyHvDOx0PXJJzBBWnic/
	 Botv+odN661UqZ2gFCBeHpEDhTDTJ9dW8/Mvo6dq+rghm3dl3QuCaP0xD5hfT1tjcO
	 EYdsmrBm7+Ltg==
Date: Thu, 28 Nov 2024 17:20:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH can-next v3] dt-bindings: can: convert tcan4x5x.txt to DT
 schema
Message-ID: <20241128-unrefined-aging-7767b0d7f6fc@spud>
References: <20241128-convert-tcan-v3-1-bf2d8005bab5@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pdqG/F8ZyEhGscji"
Content-Disposition: inline
In-Reply-To: <20241128-convert-tcan-v3-1-bf2d8005bab5@geanix.com>


--pdqG/F8ZyEhGscji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 09:29:21AM +0100, Sean Nyekjaer wrote:
> Convert binding doc tcan4x5x.txt to yaml.
>=20
> Added during conversion, required clock-names cclk.
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes in v3:
> - Added cclk to clock-names list
> - Added clock-names to the required list
> - Link to v2: https://lore.kernel.org/r/20241105-convert-tcan-v2-1-4b320f=
3fcf99@geanix.com

Acked-by: Conor Dooley <conor.dooley@microchip.com>
I suspect Krzysztof may want to re-add his R-b on this.

--pdqG/F8ZyEhGscji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0imXgAKCRB4tDGHoIJi
0khlAP4t+pA23pxdUpOpc1T7Bdm3ViZKstusZPPmmwI1Rhbv5AEA8flF1GdF7o5z
jG2mky+o6eLy18v/gIB2V4Qh3TnWHwo=
=1eJ3
-----END PGP SIGNATURE-----

--pdqG/F8ZyEhGscji--

