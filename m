Return-Path: <linux-can+bounces-2120-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B69A9D355C
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 09:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17F2BB24429
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 08:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32221B7F4;
	Wed, 20 Nov 2024 08:27:39 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7209D15443D
	for <linux-can@vger.kernel.org>; Wed, 20 Nov 2024 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091259; cv=none; b=JwHpI+YsNdxEPPOfB7CWJFM2zV6sF+XSt4VYvhwBD6xQTX4oxbPcJ8IHLCRjjS0HsiM2wON8K89XpLzN8w2YZseWQa7SGtCjyQRQY8jjt2s6F4sqPjCAA0sqeMFlmxvyMjAd+buBMY0iBFuzNFMI5Xgyt1NEwbdL+wFJi7l2i88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091259; c=relaxed/simple;
	bh=oRF4Zp8urklCMluJXoTlIYuvlDScKbepSXFEoWRyqoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pb7MxW/z1fJRUEIjUCW4uqpFqgujF9oi0pt81RmDjrlrYTP/F6zE4c1PXRuqx5QY5b0crCvG7xqjVD8sLmn2FlQ3xuhqIAWkGu0k0TchSoKwg3VKncxmBrD0r815/21jUbn615Ez9Ovu28PSaxrcB8hGHLJwtrubWdUlHNWFZPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tDg3Z-0006zr-6M; Wed, 20 Nov 2024 09:27:25 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tDg3X-001i5O-1a;
	Wed, 20 Nov 2024 09:27:23 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1EC32377A27;
	Wed, 20 Nov 2024 08:27:23 +0000 (UTC)
Date: Wed, 20 Nov 2024 09:27:22 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: remove duplicate word
Message-ID: <20241120-antique-earwig-of-modernism-1fc66e-mkl@pengutronix.de>
References: <20241120044014.92375-1-RuffaloLavoisier@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yuwyd5k5mk2aw3ay"
Content-Disposition: inline
In-Reply-To: <20241120044014.92375-1-RuffaloLavoisier@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--yuwyd5k5mk2aw3ay
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] docs: remove duplicate word
MIME-Version: 1.0

On 20.11.2024 13:40:13, Ruffalo Lavoisier wrote:
> - Remove duplicate word, 'to'.

Can I add your Signed-off-by to the patch?

https://elixir.bootlin.com/linux/v6.12/source/Documentation/process/submitt=
ing-patches.rst#L396

Marc

> ---
>  .../devicetree/bindings/net/can/microchip,mcp251xfd.yaml        | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251xf=
d.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
> index 2a98b26630cb..c155c9c6db39 100644
> --- a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
> @@ -40,7 +40,7 @@ properties:
> =20
>    microchip,rx-int-gpios:
>      description:
> -      GPIO phandle of GPIO connected to to INT1 pin of the MCP251XFD, wh=
ich
> +      GPIO phandle of GPIO connected to INT1 pin of the MCP251XFD, which
>        signals a pending RX interrupt.
>      maxItems: 1
> =20
> --=20
> 2.46.1
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--yuwyd5k5mk2aw3ay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc9nWcACgkQKDiiPnot
vG9aAAf/c8tXeQMSvhdWf+YPQQTpApOl0IfwPrF3nhffF59fMFGzaWEKFCV4FyJK
um242NrMo+ewZVcASlj5ycX+TtjdXe58wYF2DyBTwCZKciegmV4Uq/ku0vEsC/Jf
t7GUZCt33I55YbHq64ACpGNO8MozSvxgvbMcf2jMeV6LAIKs7Ptrdex/NtCcCxy1
TvxQmYgGv8OEtwcjKMR+whXIppvlZVq5/2JFncbyKVDc5MHaJr7rEdheXJneIojO
+EF/Kk6RU+pfjyRC+Q1rFak15kV41HpIrBWQD09KO9G+1JTXpSqitQcY7/UXke7K
0474na1s2eEBhtBUCG6H4Dm2t1M8HA==
=nP0u
-----END PGP SIGNATURE-----

--yuwyd5k5mk2aw3ay--

