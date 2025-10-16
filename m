Return-Path: <linux-can+bounces-5200-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 978E4BE495C
	for <lists+linux-can@lfdr.de>; Thu, 16 Oct 2025 18:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1962B19C5E42
	for <lists+linux-can@lfdr.de>; Thu, 16 Oct 2025 16:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F392301000;
	Thu, 16 Oct 2025 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OE1k9/sw"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123241C84D0;
	Thu, 16 Oct 2025 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632136; cv=none; b=cXZtE3HkNXalag8UdLza20Uy1UV20Hn31pEs7aHe/YF7yHJyYE3XrAMPZWEBw5fHfgBfsaQf/rxOLny71GnB7nvNDodOuQ5U4loHhtmrM8Wb8nruW5yJ0CndXsGfPsnjXiUSEamyJs2Ctvc1yvay2HXymuB9jBM5vHkb8c+4Z84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632136; c=relaxed/simple;
	bh=e0tpk0pXhNi0q5plF/roKaY96GG8hUyMZeEejuinUmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vh5qJanIUli1jgKlTf6RUHXlF4TiAkQA1a92v8oZci7MMztoy3uqQWMtfW6HFmQ015KeZlL9ffhVGzq5xeYeFFLYqthoKMMulGu6JCdEJHcIZzbyt+FhrZ7QhR8KilYGsjOTLyVhm4XLxGE63eT5lu+T3charAcK8a55VmgbPX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OE1k9/sw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5867BC4CEF1;
	Thu, 16 Oct 2025 16:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760632135;
	bh=e0tpk0pXhNi0q5plF/roKaY96GG8hUyMZeEejuinUmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OE1k9/swW/9cZ+nogd5QzEATbacMt/NE0mx3YanZRwL2ubIiUKiAa41VeQDc/88aI
	 zQ2voAcjsNUg+QPVxJ2c0LElLoGx2YwBPLTtHio7cI7PCtbC58RScGyWLXoRCYTPjJ
	 gtpsVN789tPz5YnK7cK4H5v1FfhHQe5K52wBc4pjyTz0B5mrYrQS83F3inanGzsgOe
	 h0FQ/11fARUWgv40HxK5NPBC0pz5XLI2pvGGNNjGEZuyvW3b8f4sFzgAjhUo+RQNOy
	 W+NHsBxUlr/9hew9TkrK1wy5VTC09k5zDjbdJOwe2aaT5gQNik8xQV5zkb811jUFEb
	 rgqjtQUNQnm6Q==
Date: Thu, 16 Oct 2025 17:28:51 +0100
From: Conor Dooley <conor@kernel.org>
To: dimitri.fedrau@liebherr.com
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: phy: add support for NXPs TJA1145
 CAN transceiver
Message-ID: <20251016-expire-oxymoron-7a527e0af28e@spud>
References: <20251015-tja1145-support-v4-0-4d3ca13c8881@liebherr.com>
 <20251015-tja1145-support-v4-1-4d3ca13c8881@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/ONgJVkuQzMk504I"
Content-Disposition: inline
In-Reply-To: <20251015-tja1145-support-v4-1-4d3ca13c8881@liebherr.com>


--/ONgJVkuQzMk504I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 09:37:08AM +0200, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
>=20
> Adding documentation for NXPs TJA1145 CAN transceiver, which resides like
> the ti,tcan104x-can.yaml in the same directory as other generic PHY
> subsystem bindings. At the moment there is only support for simple PHYs
> by using regulator bindings in combination with can-transceiver.yaml or
> PHYs that implement the generic PHY subsystem like the NXP TJA1145.
>=20
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Thanks for the update.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--/ONgJVkuQzMk504I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPEdQwAKCRB4tDGHoIJi
0k+vAP4qpP/HGQPYQh/9NRAJMNduk5wViRE4u/NDCKwdIGNYJQD+JYobjIqKAQ/j
jX1knxlZh6zaq2DvcJl5iX6rrB/RugA=
=AufA
-----END PGP SIGNATURE-----

--/ONgJVkuQzMk504I--

