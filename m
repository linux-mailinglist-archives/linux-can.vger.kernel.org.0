Return-Path: <linux-can+bounces-1196-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA3D953713
	for <lists+linux-can@lfdr.de>; Thu, 15 Aug 2024 17:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77581F21D85
	for <lists+linux-can@lfdr.de>; Thu, 15 Aug 2024 15:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EDF1AD3F7;
	Thu, 15 Aug 2024 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAcRel+b"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BCA4C69;
	Thu, 15 Aug 2024 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735422; cv=none; b=Nqguf/kCRY8MxGE9B+LZZVMFb+LKfJkLcq2J/+vq1zhjHAwyDGwLqZbicM/348Tzk1ocaVz6pQEWG5i7aQMhbkc53DZHZ70oTenYf+0BBsHHqKS1lxBzeTMfCwHvjBiok7Z5Cc5SR/ky768UrDs6ZCVGd9K0dgtRN10n7YIvdUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735422; c=relaxed/simple;
	bh=0ZfzbeuFb6gKPVJ9pBATBFdadY6BD3r0J17tU13W4KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYEndq1DyBvDEayLAsNpBMbgCn0MF0KVj6P+NMLD2CvnLi+X2HmKUWwUnR2yEiwgishC5+qalyFs7nnETe2DUNrX3KtMEzqF0UjeDaxo0O+LeOqMdk9/iPKLOeayhD1TqWYk3f9poxenf63vThgWRzow3p9Hz+OHtVDQe6wAjbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAcRel+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C57C32786;
	Thu, 15 Aug 2024 15:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723735421;
	bh=0ZfzbeuFb6gKPVJ9pBATBFdadY6BD3r0J17tU13W4KM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VAcRel+bzpk/hCp81ehFEU/GFY6T296u70vKu6f1LD/h3f0ffge8uKXz2ndXkgAZB
	 9vZkq/7xvu8WOX2gJafOixVbAWjxa1pziZ3ryxjF3CDsVYHe1LN94Cp3CfGo9qp83Y
	 aH9TZ1LUG5Ck25bBC15Y+5Uero0hfjBWP7Qu3QWeFWw8Qe5T3h7zzxtEdPlR3QEefV
	 1uuPlS0heomw7yNW8gMCK4onsZoploUlqYsEF6WeZXjVuUhaBm6xOvTysa/mb7kx8L
	 X98pjRRH7SxRwLrwQxaXkYof9G9YmJdzhcPK2jj3e8GC37SJqVwm93n5DVURPhVjlN
	 dawF/D5nOhYug==
Date: Thu, 15 Aug 2024 16:23:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: can: convert microchip,mcp251x.txt
 to yaml
Message-ID: <20240815-lustfully-vividly-09e14a228808@spud>
References: <20240814164407.4022211-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ye30We0ew5va6oAo"
Content-Disposition: inline
In-Reply-To: <20240814164407.4022211-1-Frank.Li@nxp.com>


--ye30We0ew5va6oAo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 12:44:06PM -0400, Frank Li wrote:
> Convert binding doc microchip,mcp251x.txt to yaml.
> Additional change:
> - add ref to spi-peripheral-props.yaml
>=20
> Fix below warning:
> arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dtb: /bus@5a000000/s=
pi@5a020000/can@0:
> 	failed to match any schema with compatible: ['microchip,mcp2515']
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--ye30We0ew5va6oAo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZr4deAAKCRB4tDGHoIJi
0rjJAP0fMOz6Cn4pfWN4TEbN2PK8LfPBRTxS8Ye7EP35El3bGQEA2t/2dB5YvzTK
iUyzz2EGGOfyAu5QSUEbgpQx6xqBPQg=
=ywfp
-----END PGP SIGNATURE-----

--ye30We0ew5va6oAo--

