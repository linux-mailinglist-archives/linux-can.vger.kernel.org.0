Return-Path: <linux-can+bounces-5745-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C04C8B671
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 19:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41DE3B5D4A
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 18:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4BB30EF66;
	Wed, 26 Nov 2025 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVNmYADK"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E807279DAB;
	Wed, 26 Nov 2025 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764180894; cv=none; b=HQH5hhd9fphPkc+BWHKgq58MUMRpAVRpSMMQJGTepN+jlLSvEP4j95RpPaZxxilZSqfCkAzIYudpAEEo7npyeJJ/4nLft5GCn/oGGrVF5EBzBNFIaQDcb9RD52zJ8DLwSNPBcguwRv0YiHeQT3A8lvETrq0kX23fMmIiAKBpzN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764180894; c=relaxed/simple;
	bh=fOuR367yqt+TUGOq10HVUIFhRj+cHm45vZHykln0M38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBRcDmAs21gjgFtSq8RdVk+0DlfSaLNmIb1Nc0bz5RBMX3CmD5nUXCVGsT6SMFNcyVKxELavBzxkm4Zp/kMHCeUh5HRH1gFctdfOvVtiPMZVURF8mHgCF0xfktegdqvA7YQniwZ1xb27ceUZYdnZX3hA/Veu+BKKzMtGg+ZyOb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVNmYADK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E904C4CEF7;
	Wed, 26 Nov 2025 18:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764180894;
	bh=fOuR367yqt+TUGOq10HVUIFhRj+cHm45vZHykln0M38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QVNmYADKGSlooLI9Xzma/XL3vTkALXSFnIQr2g2/o31potjF8j5oWU+YlPEoN8jdY
	 dZTSZz6BBIPd25CpcczcwoPQTJTHxjfLss/gV2mPzw/VUKPuca9Zf3gbtcSCLKTrkO
	 x4BY2toROUBmwkbt16h2AKHDYnEzChc/wxHTawgvVk4qROTnzWEqAuX5W6IQULtKxw
	 5HBwHMj9OuQcRktNZltpLlhAts6roJhIFrKfIvCPkCtWGKuSfpEvxL21QEKe/xPdrl
	 t/cxZq0SJJ170MkPRBTP+hRTz6+FB1MVh8zaZd3jdPSzS8dzqCzHZu64K/DaL3C4sI
	 DAgTIz3Gv88pg==
Date: Wed, 26 Nov 2025 18:14:49 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-can@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [net-next v2] dt-bindings: can: mpfs: document resets
Message-ID: <20251126-unworn-mayflower-c135cf7710a7@spud>
References: <20251121-sample-footsore-743d81772efc@spud>
 <20251126-famous-hummingbird-of-fruition-13a9ac-mkl@pengutronix.de>
 <b1511382-1fce-4a1b-a1c3-962a05fc07b5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KGgTrLDeJGsfYJic"
Content-Disposition: inline
In-Reply-To: <b1511382-1fce-4a1b-a1c3-962a05fc07b5@kernel.org>


--KGgTrLDeJGsfYJic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 11:26:17AM +0100, Krzysztof Kozlowski wrote:
> On 26/11/2025 11:24, Marc Kleine-Budde wrote:
> > Hello,
> >=20
> > can I get a review from the DT people?
>=20
> We don't always review each other patches, so you kind of have DT review
> already. I can review, but I just did not plan to review this... less
> work needed...

I think it was a pretty reasonable ask here, because the v1 had a
problem.

--KGgTrLDeJGsfYJic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaSdDmQAKCRB4tDGHoIJi
0shhAQCLWTb6LuCfCy2om4FfMVJhtv/g3PU/1PeKwL6qG4mdFQD9HhbKn4TeFWbB
VddagDUcmlffjW4Ig6xfQbA8EpfZ+AI=
=c1IA
-----END PGP SIGNATURE-----

--KGgTrLDeJGsfYJic--

