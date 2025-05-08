Return-Path: <linux-can+bounces-3561-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB807AAFDFD
	for <lists+linux-can@lfdr.de>; Thu,  8 May 2025 16:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE69C1896F49
	for <lists+linux-can@lfdr.de>; Thu,  8 May 2025 14:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AD1278E44;
	Thu,  8 May 2025 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gic8elSE"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B35C20E6E4;
	Thu,  8 May 2025 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716191; cv=none; b=rvQSaN6+UeFo9KJufU88Po6XGbBdr9b85PTS3OkvIbKYmVAzjV5O6TancnNbxCcidCwdyMYVsp13kxhA563m61DyqmGNL8jNntOC0Rk1nBfY/D8X639EQ0kRejxnUKxvmckE7zcYd48aLoqJqHTp/apbte8wrV0ep8XC0ue1jis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716191; c=relaxed/simple;
	bh=Z4dvnwDPKKrOO7FUvW4AKUEsf8IE286Bt0EslCrm8Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=up0BuxsjIHUQp+iWTSXObJkGwDvz6r5HfNZLwE/BeOX0kLcXYzTEywskcRkwyA9eKo2/xjeudFqyOyKM34cA3n2A9CaIIf56PAe2uWFqzKBndPWh6pYca0UbkCPuBhwANmeq4B9Kbjy3aKxgKaWibdH2MtYTRedXrAGRGJoOqpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gic8elSE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBEFC4CEE7;
	Thu,  8 May 2025 14:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746716190;
	bh=Z4dvnwDPKKrOO7FUvW4AKUEsf8IE286Bt0EslCrm8Pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gic8elSEBoSXWOgzZ/JP3Y447rorLLxgCm4lmsxdhRrsKkwlBp7tpjjfcqO8YJFek
	 h4ThQQx/NcOh+3o7SgaV6dU1ToBlHqJTZ39Y+1YdAUuOcXMmGNtvTNZOv9UAZLgweP
	 Yq8yXkIZ2nKa/xRQdYoFnM6UUckLblPNyaKVb6Curng2KCXZlMwkkjUp8MiViUvLYN
	 qHmhMUJ3FDhV4t27V5wHL9JDYbsS/Y0wbS883m1Fi9KmxGmDc7tTot3VIdn8mPnB26
	 w18SCe9fzbQERcxIPL/YNjAnc2LFgaTlEYQRXHZloH9CiyAkd3cRl7+Gtsi0V91VMz
	 1mM5Un13tQWag==
Date: Thu, 8 May 2025 15:56:26 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-can@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: can: microchip,mcp2510: Fix $id path
Message-ID: <20250508-bankable-ethically-100b553b1819@spud>
References: <20250507154201.1589542-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ky+DZqPykRgOfhgT"
Content-Disposition: inline
In-Reply-To: <20250507154201.1589542-1-robh@kernel.org>


--ky+DZqPykRgOfhgT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2025 at 10:42:00AM -0500, Rob Herring (Arm) wrote:
> The "$id" value must match the relative path under bindings/ and is
> missing the "net" sub-directory.
>=20
> Fixes: 09328600c2f9 ("dt-bindings: can: convert microchip,mcp251x.txt to =
yaml")
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--ky+DZqPykRgOfhgT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaBzGGgAKCRB4tDGHoIJi
0qwtAQDAN8XEkM5Y1FfAwRsghKcOYekZNfGUuNuNVO2Hj8FlCgD/fa3Ptxfwk6rZ
UoCTbjnYF5mM1vJgevrnq3hkiG1BzgA=
=PUb/
-----END PGP SIGNATURE-----

--ky+DZqPykRgOfhgT--

