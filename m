Return-Path: <linux-can+bounces-1579-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70B698A9F6
	for <lists+linux-can@lfdr.de>; Mon, 30 Sep 2024 18:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FC33B25246
	for <lists+linux-can@lfdr.de>; Mon, 30 Sep 2024 16:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD421194138;
	Mon, 30 Sep 2024 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cX2j4Fnh"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C26D18F2D4;
	Mon, 30 Sep 2024 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714248; cv=none; b=FXPWi7Gu3zHxuIJxAdfWGkzMY7Ic1ndw6ek4rvZ6B5cM13C351fb9Ft3S+AOxQ2veUwOr9nCEzN/L52MtJmWjspTujwepXTmIyIlqDEt2ma7DNTGmbSZsHZglgktDXxXD69lmQc2175n6MrWojF1ESrrwdrrd0XWs5JJ/wU8dqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714248; c=relaxed/simple;
	bh=OEea+N+ZjPGjpK21jvjrr1s1DyH+2HAyStoPS1VmXZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ge6t09jn7CgrmE+8y1GRYY96lO9hAcvIzZsTX3LRBSBwMAKKb2I3sR/7Sv9lgIpHY9U0bEN5resZCDMMEP4J8z8vAQiF5w7vo7/IFYpYwF01B+pn0k+5+m668wglBvk+mHv3GN9iQfDO4JDZ8ED//EUuy56ddJtx7/CQO6YnICE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cX2j4Fnh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD860C4CEC7;
	Mon, 30 Sep 2024 16:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727714248;
	bh=OEea+N+ZjPGjpK21jvjrr1s1DyH+2HAyStoPS1VmXZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cX2j4Fnhb8B+ap9VHBSQ/yD/9hmgAtNO2eAEEXmYLiaV7UWod/13UWBuxsg6+wZXm
	 nTFSeiBwPU80M9dwYoSTe7EIcetotGWA0vOJ3zCGjJyjSeuPmvCL4fpqmHS4+6hNKs
	 oc5SUhAK+4vXCrJxqxAuDg7fNlPFDMXiMPPXVzp3GmlN/cR6K6eqKEUisReJeN69pe
	 jTRjyzLP3RpWmQWRoWNmkpikRagW0cunxD9JIVXOQCPEIDPYh9u1ZQjDNCRxM+ISYE
	 FJQUv59JGcd0VPMEX4WaRM3uTKihKPi+yKAZX/N4MjBwGOO530YKyCoDc6SIfXM40w
	 0P0/QgvyrlZrw==
Date: Mon, 30 Sep 2024 17:37:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: pierre-henry.moussay@microchip.com, Linux4Microchip@microchip.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
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
Message-ID: <20240930-skeletal-bolster-544f3a2b290a@spud>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
 <20240930095449.1813195-2-pierre-henry.moussay@microchip.com>
 <20240930-voracious-hypersonic-sambar-72a1c5-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L5xF4s+PIzPhE/RQ"
Content-Disposition: inline
In-Reply-To: <20240930-voracious-hypersonic-sambar-72a1c5-mkl@pengutronix.de>


--L5xF4s+PIzPhE/RQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 06:32:29PM +0200, Marc Kleine-Budde wrote:
> On 30.09.2024 10:54:30, pierre-henry.moussay@microchip.com wrote:
> > From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
> >=20
> > PIC64GX CAN is compatible with the MPFS CAN, only add a fallback
> >=20
> > Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> Who is going to take this patch/series?

Ideally you take this patch, and other subsystem maintainers take the
ones relevant to their subsystem. And I guess, I take what is left over
along with the dts patches.

--L5xF4s+PIzPhE/RQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvrTwgAKCRB4tDGHoIJi
0khKAQCsE8hEXz8LI1xqSwIVZ4y5wc4iBPh7MmU6gV6cbW9Q2gEAw+Ers8hDKQpi
/5YIJ3xCLcFLMHF061k0iQv/9uHTFQ8=
=ukT/
-----END PGP SIGNATURE-----

--L5xF4s+PIzPhE/RQ--

