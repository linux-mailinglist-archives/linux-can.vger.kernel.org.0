Return-Path: <linux-can+bounces-2284-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BD69DE8A4
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 15:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63B71B22950
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 14:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E4E42AAB;
	Fri, 29 Nov 2024 14:37:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13164EB45
	for <linux-can@vger.kernel.org>; Fri, 29 Nov 2024 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732891061; cv=none; b=QKWc9DB7IRWXlt/rPfsCpupcxvI4+dN8YDJFFTIlY21tS66pIWcypr9sxo8Q6hnfPImEtPAEwPdSJEWs7IMqBeJiQzum7rSIMIHLIv100Vi2BLnlWINtAX17PSowNGTOd+zAKUx2BV3oyVsUHlafbLDVOjginSTfoRe/YaWztwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732891061; c=relaxed/simple;
	bh=XtJxsP6Q5iK8IFbFbWf41hPjnWxcYV2ue5hmBYZx4PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXVLVVJ/34eil16vkGie2bEyar3yuJlL6qQXNBLDsF8YbITtwWjyHWtO1ujm3MtCwh3HsQKPQO+fYmOOvx6juE5YMt/SGO3zcgkNZP4FjcBGAv7+wnAVSznrrX8Zi57CAVawPqJky0yllmRVOiMVToqRNqfPsI71rFZnUzL/IGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tH27W-00081B-S1; Fri, 29 Nov 2024 15:37:22 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tH27V-000nvK-0o;
	Fri, 29 Nov 2024 15:37:22 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A9E7E38135D;
	Fri, 29 Nov 2024 14:37:21 +0000 (UTC)
Date: Fri, 29 Nov 2024 15:37:21 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, NXP S32 Linux <s32@nxp.com>, imx@lists.linux.dev, 
	Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>, 
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3
 SoC support
Message-ID: <20241129-ancient-sloth-of-bloom-077ab2-mkl@pengutronix.de>
References: <20241129142535.1171249-1-ciprianmarian.costea@oss.nxp.com>
 <20241129142535.1171249-2-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wuotrmvbblrkdbk6"
Content-Disposition: inline
In-Reply-To: <20241129142535.1171249-2-ciprianmarian.costea@oss.nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--wuotrmvbblrkdbk6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3
 SoC support
MIME-Version: 1.0

On 29.11.2024 16:25:33, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>=20
> Add S32G2/S32G3 SoCs compatible strings.
>=20
> A particularity for these SoCs is the presence of separate interrupts for
> state change, bus errors, MBs 0-7 and MBs 8-127 respectively.
>=20
> Increase maxItems of 'interrupts' to 4 for S32G based SoCs and keep the
> same restriction for other SoCs.
>=20
> Also, as part of this commit, move the 'allOf' after the required
> properties to make the documentation easier to read.
>=20
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> ---
>  .../bindings/net/can/fsl,flexcan.yaml         | 46 +++++++++++++++++--
>  1 file changed, 42 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b=
/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> index 97dd1a7c5ed2..10b658e85ef2 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> +++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> @@ -10,9 +10,6 @@ title:
>  maintainers:
>    - Marc Kleine-Budde <mkl@pengutronix.de>
> =20
> -allOf:
> -  - $ref: can-controller.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -28,6 +25,7 @@ properties:
>            - fsl,vf610-flexcan
>            - fsl,ls1021ar2-flexcan
>            - fsl,lx2160ar1-flexcan
> +          - nxp,s32g2-flexcan
>        - items:
>            - enum:
>                - fsl,imx53-flexcan
> @@ -43,12 +41,21 @@ properties:
>            - enum:
>                - fsl,ls1028ar1-flexcan
>            - const: fsl,lx2160ar1-flexcan
> +      - items:
> +          - enum:
> +              - nxp,s32g3-flexcan
> +          - const: nxp,s32g2-flexcan
> =20
>    reg:
>      maxItems: 1
> =20
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 4
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 4
> =20
>    clocks:
>      maxItems: 2
> @@ -136,6 +143,37 @@ required:
>    - reg
>    - interrupts
> =20
> +allOf:
> +  - $ref: can-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nxp,s32g2-flexcan
> +    then:
> +      properties:
> +        interrupts:
> +          items:
> +            - description: Message Buffer interrupt for mailboxes 0-7 an=
d Enhanced RX FIFO
> +            - description: Device state change
> +            - description: Error detection
> +            - description: Message Buffer interrupt for mailboxes 8-127
> +        interrupt-names:
> +          items:
> +            - const: mb-0
> +            - const: state
> +            - const: berr

Nitpick:

- description: Error detection
and
- const: err

or

- description: Bus Error detection
and
- const: berr

regards,
Marc

> +            - const: mb-1
> +      required:
> +        - compatible
> +        - reg
> +        - interrupts
> +        - interrupt-names
> +    else:
> +      properties:
> +        interrupts:
> +          maxItems: 1
> +
>  additionalProperties: false
> =20
>  examples:
> --=20
> 2.45.2
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wuotrmvbblrkdbk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdJ0Z4ACgkQKDiiPnot
vG99zgf/e0bR3pFlC1iXoVoAbLuPS/XgUVnlr8Ip8XqDQ3ETCN/gHY0jBMqrAkpG
HpyX2GXpYGmS2HjWwjasJqtyW2KTw+oFI7iCxkmHDp6SIp7MZmBfFBOADOKtZh0C
HFicEIKxiPZt2zzM+aJSSnXqL+I/dx0EdY5ONAFhaKkRfu1zzvKeBRxoJQ8pIAf/
QSbaowMGmHDryoJW3N02/T59Wk1yacAVq7E0AQ1W2EAr3p3bd9fzOsHxDpU0x/L8
0X20hFp38G9F6RWzECP74gFps6d26fIAv3DHPFW0t/OE9Y4u+nhv9yf0FeDeFLBC
QKRM5/eo8fMoTJ0c7Pga4CJ8ixZpiw==
=gPO1
-----END PGP SIGNATURE-----

--wuotrmvbblrkdbk6--

