Return-Path: <linux-can+bounces-5850-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70715CB3C02
	for <lists+linux-can@lfdr.de>; Wed, 10 Dec 2025 19:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEE30301DB88
	for <lists+linux-can@lfdr.de>; Wed, 10 Dec 2025 18:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38F3301007;
	Wed, 10 Dec 2025 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvAVRy0j"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4AE1898F8;
	Wed, 10 Dec 2025 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765390900; cv=none; b=XNXlpdplo6viPIVCcCxjQsRGLlef1eijJxv08jMkIF0bLH4/QlpomJia1+5uhnbHZhcMnQ9/JkBkYqJ/9fnqDKst8LY75hVEUw5gsENzXP/Flmr0BdhiFEHwOarTXoB2PnPxPubCDopMpBtqvT/Nr2nXwnKdn94G49YnE/Y3DjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765390900; c=relaxed/simple;
	bh=O+bGZbuvV5kBW7ZrBjTqnBm76ibmQ69yjYsTylWkcb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqMHnjBJIyVX0lnWCUcHnIBTSAW2cXgOQjktbXFDQLWDG11N4Tfp9F5X0oPB8xyo+1FeNJxrYLBwKM1e6108JR7tM7rJ6JJAmO7owdTsKO2iVO+FjcQQEDIk/WnxAsrpGWjx9AjpaFalv2dYB/oQKBYR2l+4NQYbEyEpB2mf5lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvAVRy0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4D6C4CEF1;
	Wed, 10 Dec 2025 18:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765390900;
	bh=O+bGZbuvV5kBW7ZrBjTqnBm76ibmQ69yjYsTylWkcb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BvAVRy0j+eyq40iKGFIWrLwNVP55uSf8AD4b81YFOwB5wOjrt3gLIqkJtmaOmbx6u
	 /H1NnCpqCcJafwoaygyuMgqITpp+A0bC//qQNcSeBLmNbYti9qiozuFSyqNNzl8zdo
	 E9VIeIOQUp5PIm8e2JjCPN0UAkrM61i5UgIjNmfK069X0ZnEPtKskxo1nFFlKoV8Df
	 Gggyb2hHueVniuewm9/BFvUWr7/b4OliGyJW3GAiokao6XQM39anwQ8a6AcKS7Dtgv
	 PxsPCqT4Q6nJt2i9ekG58XqeWnOQ2dCkfF1KcEEypfh4T2sD2xk6gA08K7/widSsu7
	 9/N0llidyrzfQ==
Date: Wed, 10 Dec 2025 18:21:34 +0000
From: Conor Dooley <conor@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Prabhakar <prabhakar.csengg@gmail.com>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Frank Li <Frank.li@nxp.com>, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2] dt-bindings: phy: ti,tcan104x-can: Document TI
 TCAN1046
Message-ID: <20251210-persuaded-rewire-8ac93b0cc039@spud>
References: <20251209162119.2038313-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251210-mauve-cow-of-hurricane-0f969d-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IIsQrjuMkvqB7/Hb"
Content-Disposition: inline
In-Reply-To: <20251210-mauve-cow-of-hurricane-0f969d-mkl@pengutronix.de>


--IIsQrjuMkvqB7/Hb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 08:52:58AM +0100, Marc Kleine-Budde wrote:
> On 09.12.2025 16:21:19, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Document the TI TCAN1046 automotive CAN transceiver. The TCAN1046 is a
> > dual high-speed CAN transceiver with sleep-mode support and no EN pin,
> > mirroring the behaviour of the NXP TJA1048, which also provides dual
> > channels and STB1/2 sleep-control lines.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > TCAN 1046, https://www.ti.com/lit/ds/symlink/tcan1046v-q1.pdf?ts=3D1765=
297159307&ref_url=3Dhttps%253A%252F%252Fwww.ti.com%252Fproduct%252FTCAN1046=
V-Q1
> > NXP TJA1048, https://www.nxp.com/docs/en/data-sheet/TJA1048.pdf
>=20
> The polarity of the standby line of the chips is different.
>=20
> You must set the correct active high/low property for the GPIO, as the
> driver uses logical levels.
>=20
> Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>

What you're saying seems to contradict the tag you've given, is a
fallback really suitable if the standby polarity is not the same?

--IIsQrjuMkvqB7/Hb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaTm6LgAKCRB4tDGHoIJi
0rd8AQCVqGYenKiVlmsteQjlS3YKRFO6NfcKVKty99nB08UYYAD9EvjL6s2ARUpL
Tk/sBch2w9KMamz7vNWItgV48BNsgA8=
=XC1y
-----END PGP SIGNATURE-----

--IIsQrjuMkvqB7/Hb--

