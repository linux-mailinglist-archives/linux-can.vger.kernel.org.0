Return-Path: <linux-can+bounces-1577-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E509F98A596
	for <lists+linux-can@lfdr.de>; Mon, 30 Sep 2024 15:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0331F210D5
	for <lists+linux-can@lfdr.de>; Mon, 30 Sep 2024 13:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1E1190067;
	Mon, 30 Sep 2024 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/PWdgjG"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DE718E779;
	Mon, 30 Sep 2024 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703693; cv=none; b=VvayUy09+NyKICPScj23lg2ZAqADRkmp0gqA3JXn79zzbpFYD2U+FEuHQmmUdVukCK/LRIPQYxh7zrLjOKnQ11wmGc768XOpeZIMYvSM4b3jl3hD0vKZLAVE9WSPhVWSJuy5jgWjJvdspmBoEXmOrTQgqK6XKENkuWbz/IdWjJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703693; c=relaxed/simple;
	bh=XuIxcWV90Pt6xKt7ogNiIxpo5TOpoq4J541bjNJwqag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDxYp8YgwzOHRn16aMF1tQL/dHAfm0B2+eKLynVhqOQUyY6JZidzoAI8SSwrIv6Fo8uSOz7EaAguXAEd1kTenP3tyK/do9ChUwX9C1VNbunhOJECV8a3E1EtbzjRxC0kzW/2JeI8r/J7UhsBsj9QSF/LguCEN8IRmNcmPQBTL3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/PWdgjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34562C4CECE;
	Mon, 30 Sep 2024 13:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727703693;
	bh=XuIxcWV90Pt6xKt7ogNiIxpo5TOpoq4J541bjNJwqag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p/PWdgjGHFmG4a9TeIg92cCR3b53QtlukirDa0WYMdHKixucwR9yo13JHac/Cxbij
	 tntZ/2FwufIcSYwmBoJBBK4do+bRogXXJFVPI7fImhhJa40MJ3wS951qvfbNMHq/G0
	 bpqHHiIDY+j0LLwjkuYefn3ToR3bWuAsq3XJ2jqDJ/2uMQ9fYf2SHvvx1G9ibfdnCd
	 2aJ4M/cAnfW4kAaDgMFhrQ6bap8Rn7qAvvq496T76Z5jDB5pkcYeo7JlVVSSphDX8x
	 0hJV877W2z/I7VFx6nHWwgAGIHRWUq3xacHJelunGpWo/+NnRpilCa2aOtT3xpmUgR
	 POJBFfImmhGBQ==
Date: Mon, 30 Sep 2024 14:41:25 +0100
From: Conor Dooley <conor@kernel.org>
To: pierre-henry.moussay@microchip.com
Cc: Linux4Microchip@microchip.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [linux][PATCH v2 01/20] dt-bindings: can: mpfs: add PIC64GX CAN
 compatibility
Message-ID: <20240930-transpose-isolating-5c20f43745b1@spud>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
 <20240930095449.1813195-2-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ITDHeWGvw1IVSKQ3"
Content-Disposition: inline
In-Reply-To: <20240930095449.1813195-2-pierre-henry.moussay@microchip.com>


--ITDHeWGvw1IVSKQ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:54:30AM +0100, pierre-henry.moussay@microchip.co=
m wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> PIC64GX CAN is compatible with the MPFS CAN, only add a fallback
>=20
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--ITDHeWGvw1IVSKQ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvqqhQAKCRB4tDGHoIJi
0jNVAP0ZEUhs6p76YEPVv+A3Xa03N4ZG3xl3Y1mmGJW8BNWHuAD4wyvWl7QbHbq/
Px7FmbCsj+wyZHmXwRcSgEpzuMnuBA==
=s7yU
-----END PGP SIGNATURE-----

--ITDHeWGvw1IVSKQ3--

