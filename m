Return-Path: <linux-can+bounces-4335-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC29B320DF
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 18:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3393B66C1
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 16:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C7E30BF6D;
	Fri, 22 Aug 2025 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTtKvyPn"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4D025A35D;
	Fri, 22 Aug 2025 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755881542; cv=none; b=j58d9Z4yQNFnBKuJ5835/yY+1YnmmUX5esbWn+kPJ85B1MpDPGYg8+mbO6zHEHMJbO07me45h1bsJymVOwsfXqquMbvafUl+3UR3HK+DcQj/eKAT7u9RcWcV88HG7Q6GMt3tNjO58VmzwWLORIMiXgx91YxH7Q+c/ghuM44pbJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755881542; c=relaxed/simple;
	bh=yaK/J9Mq7TMSJEOF0Q/1YTVBPo06y0I9D1S4aI0nInk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haqIuKDhWvCnr7RISAabh7A/4aJWlyR/2W2nmCTTpEcw9yo+I84RYbfx5tCiptJ4aajmkiYWa7C6tXMpheoC+yNG1qoC2FyqmBXZK2C85aUJhUzx0FBtHATQo1utYFXMBbkMBpuiL7ZSuFfhbXhrDmXEyKZzepng3vFuZcZk2zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTtKvyPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27602C4CEED;
	Fri, 22 Aug 2025 16:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755881541;
	bh=yaK/J9Mq7TMSJEOF0Q/1YTVBPo06y0I9D1S4aI0nInk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MTtKvyPnUlzqGaBwQRa4ApDd1eD78Vx/uDltIbOsZNeZ9FXqn6LgBoNYdVvzP+TLZ
	 G6Hwwgw3IH6QrbydGfUJK4dMRu/KjXCWM/Wta1Xu/Qh5m6pzO9Xodry7FgmAgQ6IE5
	 jfXRK1i9nIV6INAtYBguAK1DdUCfICmhNJ9q0eLH0D8hTMS34d1pXz1WZW1MwChISY
	 k+xpxj061avk6wAg6MlLci7qBS03EzI6oo8vxoAFQo/1sxpv8Otf/cLiZKSDuNfZNm
	 eoiKYpA4/RnHKr6ZVV2VELIfrwrqL/VJpgE5O5Zkarg6FdiWPBdoJUpiKj1vfs0SNb
	 vuOwjd6H1Sf5A==
Date: Fri, 22 Aug 2025 17:52:16 +0100
From: Conor Dooley <conor@kernel.org>
To: maudspierings@gocontroll.com
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: ti,tcan104x-can: Document TI
 TCAN1051
Message-ID: <20250822-gout-denture-688eeb65b6e0@spud>
References: <20250822-can_phy3-v1-0-73b3ba1690ee@gocontroll.com>
 <20250822-can_phy3-v1-1-73b3ba1690ee@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="417/6ibRk/SLnFGF"
Content-Disposition: inline
In-Reply-To: <20250822-can_phy3-v1-1-73b3ba1690ee@gocontroll.com>


--417/6ibRk/SLnFGF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--417/6ibRk/SLnFGF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKigPwAKCRB4tDGHoIJi
0pC3AQCDOtsgl3v4+3MpC8nave18XEmONgIFklHfXnBS5G3TwwEA0mnpdzGtsgfJ
aa1SEma1o0J1HMb0GPVTGrRvFhFXVgI=
=SrOb
-----END PGP SIGNATURE-----

--417/6ibRk/SLnFGF--

