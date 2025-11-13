Return-Path: <linux-can+bounces-5389-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6429FC59CE9
	for <lists+linux-can@lfdr.de>; Thu, 13 Nov 2025 20:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9E57D34E75D
	for <lists+linux-can@lfdr.de>; Thu, 13 Nov 2025 19:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8298D31BC90;
	Thu, 13 Nov 2025 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTr8te+M"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8EC286417;
	Thu, 13 Nov 2025 19:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763062810; cv=none; b=oCfCZPH0eyl3lMTPs+rspXd/lVTswZw5BwN9DgEbwprMX6USuVqKIFdx9B213/d9Ss9e/y1c7KLAgfk6BT4oKtvo/qRobQaAIuyhGH+KG+cDJEXy7jzwQ38w+/NJIcp8djSQSc8y5iXMBONxTrdIGckkc2D4wLb43BcT7JRUv0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763062810; c=relaxed/simple;
	bh=Wx342tcBgfqE+WH1ARcF9gyNKVzvRv5eqMrGaiw/ROs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqzmiCSHUd7aNu4K/Y0Un75ZYK8OP9FNEaWZE79xLDuw7WQVTt4/ZR6VH7RpKkfUkbdVQC7rdeTjNSLsy3ySEGHhyGCdc1VhgyG7OGftX8uySmCIQElb6PDSg1CXAAJVxsjO7PCD10VlfUFnfTADvRBmCM78MvG4WjBH5PhjlsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTr8te+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913BFC4CEF7;
	Thu, 13 Nov 2025 19:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763062809;
	bh=Wx342tcBgfqE+WH1ARcF9gyNKVzvRv5eqMrGaiw/ROs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kTr8te+MVreiJnoFzSWj3UpJCBxpwzTLfo6ifCcdmYQ9cR5x78YbiS3SWKoSoQXMF
	 p7yfF0Rt0WuvBYOZRHhvMOaC3QQmBm2iYpYc6U6Lq9v4uXNEi66/T4ZK2RVC3eM8pS
	 b3QJZnRzFqL5Q5U2zSkeiwaZJx1RB4j9gJQAB0360Jsv+iOctGCJHmoU1wYmGypk4b
	 ncnesRwZp9O+atmoIZZD6rrCV9is0LhQfJ6eRLlFWqnNRb9NtlqfNIEpj6vctbTr4l
	 7O/oiJ9AelGVmYz+inme4ufh8TESqhccG5m2sroUMNcfxWoX8cE5yAAVAR5aKa2jKY
	 /Tn1Bdrk9psng==
Date: Thu, 13 Nov 2025 19:40:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: mkl@pengutronix.de, kernel@pengutronix.de, mailhol.vincent@wanadoo.fr,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heiko@sntech.de, cl@rock-chips.com, linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v9 1/3] dt-bindings: can: rockchip_canfd: add rk3576 CAN
 controller
Message-ID: <20251113-bullfrog-destiny-977deea729e1@spud>
References: <20251113075419.482940-1-zhangqing@rock-chips.com>
 <20251113075419.482940-2-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WjU9NJgo+2A7qyol"
Content-Disposition: inline
In-Reply-To: <20251113075419.482940-2-zhangqing@rock-chips.com>


--WjU9NJgo+2A7qyol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 03:54:17PM +0800, Elaine Zhang wrote:
> Add documentation for the rockchip rk3576 CAN controller.
>=20
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--WjU9NJgo+2A7qyol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRY0FAAKCRB4tDGHoIJi
0sGfAP4wgwh6tZ6Pso8QvqsrTodV7+0O41gzAmmQLMmy7bTcFwD+JqWVf+a/DlRc
6qanJhzv1AANWatqUmDD8yh7hQX58gM=
=y8U3
-----END PGP SIGNATURE-----

--WjU9NJgo+2A7qyol--

