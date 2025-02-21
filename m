Return-Path: <linux-can+bounces-2927-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B829DA3FDFA
	for <lists+linux-can@lfdr.de>; Fri, 21 Feb 2025 18:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B524319C2665
	for <lists+linux-can@lfdr.de>; Fri, 21 Feb 2025 17:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409BC1FAC3D;
	Fri, 21 Feb 2025 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBYRmx9P"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FA51DE4E5;
	Fri, 21 Feb 2025 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740160320; cv=none; b=tUq7ROqaR+yFKMuGbYn8I+or4nKMDiJam/w2tqYiCrfA/8cAegAv/vdcreieiOwwVWikbNoVbGCIDpjBCjWFsKGMcJoMD85w+0PJ7UxxMQtvdasS9m5llLbYr0dUThdwgwxfhPUOdZVJ2a8jg0c2IHLCsyiFAKraWOXA4FafplQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740160320; c=relaxed/simple;
	bh=VwTAjAXwC00P6D1+oysocktoqQUV4zh6nOgKJ0tvpA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJb7Gkx4XxcdhbOG72A04OoN3gK46wzb3o2+GhZgjdq5NeL+MQ9CkgBS/2T7PNCRPkKrrcjIx4EpM2HscMSvOuDU5frRn9OcD8DUYtOKOqL70XeHxn7JK2+Hrv+vCaNtkzNiKCji6ojznN1Egrb8NfKkvR52EjrKpN8jXly+RTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBYRmx9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC445C4CEEF;
	Fri, 21 Feb 2025 17:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740160319;
	bh=VwTAjAXwC00P6D1+oysocktoqQUV4zh6nOgKJ0tvpA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBYRmx9PSj6n7ukTMVN6wSb609yCVn2ELVkVA7FiUgn3qnmxbcFwh7g7g5UM5N0nH
	 Z/mgo/52kGqxZtRC39D18Zv8dKFuwp8XZbBx3o2JgoyZNvJ4IJZFMfK2bHCYeqGXli
	 3FdEq5pPpT9CGBohn3dIl4fgqAcRkfJDHP33KnjKC47nH6oyTwoaiUxAQVBJS+KmId
	 wCmgRKtStR///FTkuoJiemwBOQ5gL/RfDpp6q1kWdWWyJOdmxwF679c8gX4D35Y1x4
	 EjPhkjL/rNOR2W5q+ze+qRfaqwf1hMsAXwz+VRhV+cU1u++RstPWQfCeNakNjj65gD
	 OHLJudkiGwNEw==
Date: Fri, 21 Feb 2025 17:51:54 +0000
From: Conor Dooley <conor@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Simon Horman <horms@kernel.org>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: can: renesas,rcar-canfd: Simplify
 the conditional schema
Message-ID: <20250221-enchilada-manhole-033a7140f29f@spud>
References: <20250220130427.217342-1-biju.das.jz@bp.renesas.com>
 <20250220130427.217342-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cvqklKlHeqLlpBQB"
Content-Disposition: inline
In-Reply-To: <20250220130427.217342-2-biju.das.jz@bp.renesas.com>


--cvqklKlHeqLlpBQB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 01:04:17PM +0000, Biju Das wrote:
> RZ/G3E SoC has 20 interrupts, 2 resets and 6 channels that need more
> branching with conditional schema. Simplify the conditional schema with
> if statements rather than the complex if-else statements to prepare for
> supporting RZ/G3E SoC.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--cvqklKlHeqLlpBQB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7i9OgAKCRB4tDGHoIJi
0hJsAQD+dEXcr7xaCJA6BbWZj+Bk582fzaiXaYAUPmBJY9R16AEAucaVR1BI/nBE
1qm6pdvP8kUpo0ZeOeGFzOJiaoWMOQI=
=01R8
-----END PGP SIGNATURE-----

--cvqklKlHeqLlpBQB--

