Return-Path: <linux-can+bounces-1185-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CF094D2C0
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2024 16:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616FA1F213E4
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2024 14:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BA71957FC;
	Fri,  9 Aug 2024 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaRDrZOI"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCBB1922CD;
	Fri,  9 Aug 2024 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723215447; cv=none; b=DxVS1NbsEWhlSyjokkjXPrHDv3mMSsrb3r3jlPE3UGYVAn4JZ4LZpY6HXebo5Y4EDHP/BLymWBF1Ar/YfPT+V7owKcYr9OdzrBYpuBYnn4kkqdUzc/k4Br9dD/Ink0wsngY77N9OLrXzLVUdsgpLE4mK7C08vUALoTsBS+Gqk4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723215447; c=relaxed/simple;
	bh=4R4KKGn2NxfICr7QhCZSDNk9DiWF5xBj9zur1+8jo88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbESxou9QxSQ7B0Au7xbQOdDPS2wpQDiUZDcwOjrBqveTTftXgTwbUPQXFOkK+7QfiL86P3aS8qVhkQIZ8qC5iqoDRCArbarETT0TGNSPjEX89RXFm7C5b9IlHsyxrUm+4c5tZ++xpv36qVV9uGVaEIHWvWtj12zRt0IElsXvp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaRDrZOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0453DC32782;
	Fri,  9 Aug 2024 14:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723215447;
	bh=4R4KKGn2NxfICr7QhCZSDNk9DiWF5xBj9zur1+8jo88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JaRDrZOIPLi0YGLznowFlch5ly9OEAzEwIqVenI88eKSPOMRFgDnYJO4twVfCN96s
	 Uo07xbv8E3L7VIskARFQo62HM6diZXNQXm1g1IQjEMXCzJPyo4O8ojWU02CBO12nPO
	 /MmjdgAc7ldcVl6TuxkMgVgwPuCB6elIlIvhf8pudxG0GCi9RrWIYouCW4Bhd9poG/
	 2T0fvUOljQ2biWHPsyBE0qXpsKlxDzgOr+vRYh1G/Bjahq4AWV2xFH1N8ZeUQXsYWX
	 W8R+x+xAtkCUYgbNMZawkc3PGwBB85oOmlDNkGHa1Uf5jCeQh+bpbCWYu/i/eQ3eXu
	 P7IyVTaF3AQ6w==
Date: Fri, 9 Aug 2024 15:57:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Ilya Orazov <ilordash02@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/1] dt-bindings: phy: ti,tcan104x-can: Document
 Microchip ATA6561
Message-ID: <20240809-guru-tassel-84a14486a596@spud>
References: <56a52c81-68de-438d-94ae-9decc799d824@kernel.org>
 <20240808191735.1483572-1-ilordash02@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z9RnOkapWi2cVpnp"
Content-Disposition: inline
In-Reply-To: <20240808191735.1483572-1-ilordash02@gmail.com>


--Z9RnOkapWi2cVpnp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2024 at 10:17:35PM +0300, Ilya Orazov wrote:
> Microchip ATA6561 is High-Speed CAN Transceiver with Standby Mode.
> It is pin-compatible with TI TCAN1042 and has a compatible programming
> model, therefore use ti,tcan1042 as fallback compatible.
>=20
> Signed-off-by: Ilya Orazov <ilordash02@gmail.com>
> ---

Acked-by: Conor Dooley <conor.dooley@microchip.com>

btw, please don't send new versions as a reply to existing ones, it's a
shortcut to getting lost in deep mailboxes that sort by thread (or as I
almost did here, deletion of the mail without reading it).

--Z9RnOkapWi2cVpnp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrYuUgAKCRB4tDGHoIJi
0oVmAQD8Uap0l7TMY5aZAVoZiOEmVvtoe4eohtWFtQiBT7YazQD+MAqeHGP2ntUa
S2D7wGaioo1h4pc9Qw7vK53R5JN2jwk=
=+82K
-----END PGP SIGNATURE-----

--Z9RnOkapWi2cVpnp--

