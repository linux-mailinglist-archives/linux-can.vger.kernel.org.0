Return-Path: <linux-can+bounces-991-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB458937991
	for <lists+linux-can@lfdr.de>; Fri, 19 Jul 2024 17:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86EFC283AC4
	for <lists+linux-can@lfdr.de>; Fri, 19 Jul 2024 15:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D993114659C;
	Fri, 19 Jul 2024 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yq1WWAyq"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE46014535B;
	Fri, 19 Jul 2024 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401625; cv=none; b=hJ+M0jxtUElmqgnNCnzO6PZuVMVSEBLyts52n35bufNdXuCgTWMk7iJlPIalJ29ITwEBRjITZRJz7QUfK4i6cpl8C3vIBl8pDOHl+Wy2ms8aqcMLlHDNH3zSGFrlHzCG88WuAkePhbiLgrTCoSz+Na9j8ASj/jnRJaOKV5eoRss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401625; c=relaxed/simple;
	bh=0kZ1M+m/Vu8kSpyCAxR0eczQ1iZK8eRhY3vk9xdexi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQxSVlSbilVio5yAgqfUYBVa+dqyRudsP9DX1a+4GkQF0abREwQ9wGpua2K6hOH+qcerxQnDZtzihIF1YeoAUqjZaND5JQtHwiYIn3fmr5jhT0Ef2Hfgat6IjvuVzQEmmeIYDGT8UK+VAajbJkBoCenHjsscA3Aznp0WwJDm3OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yq1WWAyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C21C4AF0A;
	Fri, 19 Jul 2024 15:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721401625;
	bh=0kZ1M+m/Vu8kSpyCAxR0eczQ1iZK8eRhY3vk9xdexi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yq1WWAyqtpfEiNfWpa2zFl6NlIDZu9EoJzNOKd8zCw7lp/yHNLi5Ean7UWplNt0Y9
	 04L1RRoydh/BpjSfTKk7t41XgkZunfZh8sFXZPL+Y1xjNvIGi4Fomps8a3AlyrnqCs
	 sfjisGLWU5JR2ugwoBoIYbCVeOopMY9cq8i4owCp+oE0xS+3EO4yMWFrAW4Ar3X/KK
	 kDcQS/BW+YiAIShNpI0ftDFdvcuC5UsZvCWfRyjXxqin47jbPQLarKaW+Z9QQaXNUh
	 RCV9pC0HpU/yyiF9ecFN5A5DVn6qie4XIu+4qhAUp7ESMO6gwKF+wSbzsAsApcHjKE
	 M+8j298OiespA==
Date: Fri, 19 Jul 2024 16:07:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Ilya Orazov <ilordash02@gmail.com>
Cc: mkl@pengutronix.de, mailhol.vincent@wanadoo.fr, vkoul@kernel.org,
	kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	a-govindraju@ti.com, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: ti,tcan104x-can: Document
 Microchip ATA6561
Message-ID: <20240719-ahead-kiwi-995e52bf3e74@spud>
References: <20240718210322.37492-1-ilordash02@gmail.com>
 <20240718210322.37492-2-ilordash02@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OacaTNnqMJzRi7N4"
Content-Disposition: inline
In-Reply-To: <20240718210322.37492-2-ilordash02@gmail.com>


--OacaTNnqMJzRi7N4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 12:03:21AM +0300, Ilya Orazov wrote:
> Microchip ATA6561 is High-Speed CAN Transceiver with Standby Mode.
> It is pin-compatible with TI TCAN1042.
>=20
> Signed-off-by: Ilya Orazov <ilordash02@gmail.com>
> ---
>  Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b=
/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> index 79dad3e89aa6..03de361849d2 100644
> --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> @@ -18,6 +18,7 @@ properties:
>        - nxp,tjr1443
>        - ti,tcan1042
>        - ti,tcan1043
> +      - microchip,ata6561

Given that your driver patch has
| diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-tran=
sceiver.c
| index ee4ce4249698..dbcd99213ba1 100644
| --- a/drivers/phy/phy-can-transceiver.c
| +++ b/drivers/phy/phy-can-transceiver.c
| @@ -89,6 +89,10 @@ static const struct of_device_id can_transceiver_phy_i=
ds[] =3D {
|                 .compatible =3D "nxp,tjr1443",
|                 .data =3D &tcan1043_drvdata
|         },
| +       {
| +               .compatible =3D "microchip,ata6561",
| +               .data =3D &tcan1042_drvdata
| +       },
|         { }
|  };

the driver patch is actually not needed at all, and you just need to
allow ti,tcan1042 as fallback compatible in the binding, so something
like:

  compatible:
    oneOf:
      - enum:
          - nxp,tjr1443
          - ti,tcan1042
          - ti,tcan1043
      - items:
          - const: microchip,ata6561
          - const: ti,tcan1042
=20
   '#phy-cells':
     const: 0

Cheers,
Conor.

> =20
>    '#phy-cells':
>      const: 0
> --=20
> 2.34.1
>=20
>=20

--OacaTNnqMJzRi7N4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpqBFAAKCRB4tDGHoIJi
0u25APwJ3s2fz/iSUlVs8nhu7y4M/qp5donngZ/W2xoG6RZFFAEAilk2WvgKvymW
xAUkue9tqFIm/xv1Avcb+vTE1mqUcQQ=
=yHPo
-----END PGP SIGNATURE-----

--OacaTNnqMJzRi7N4--

