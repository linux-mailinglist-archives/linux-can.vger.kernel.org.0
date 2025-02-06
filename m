Return-Path: <linux-can+bounces-2741-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 110C5A2A8C5
	for <lists+linux-can@lfdr.de>; Thu,  6 Feb 2025 13:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153EF18891A8
	for <lists+linux-can@lfdr.de>; Thu,  6 Feb 2025 12:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBFC227B8B;
	Thu,  6 Feb 2025 12:47:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7FE20B208
	for <linux-can@vger.kernel.org>; Thu,  6 Feb 2025 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738846076; cv=none; b=jPOMsz7RlTZLR2Qe7TUA77sOfkR2WrhwgMawHEGDTjFPvWsbf5rUro6iATD3aWTo1FUkwOoEvBPfjmnRoml2EsHNrA2G9HrDzS/IkwJGB2M3hbFimWJpscpnCuZ5DCpus0x3g4dLaoINPL33ppYB08p855hSR8HCTfl1yQzA1fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738846076; c=relaxed/simple;
	bh=XVRhnXvtvTxseMVq6Tt74IEfVFr5ZN9/eDfbJZNGxRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5k2lIFUqxlLj9KroBLwvdg5St2HjpHzBrnzIB/l2Ag3lt0I/1gmQYCImPhNYlP6YgwSlZPB1kTgl8EPrJZSh6BXOumsI60zgjAkyidktYKeTJ0de9jVfDMGyq261Anz2VqLu2L4hg3T0T7Pfn9ysTqDU/0Wg4SQtv7AXbl9iB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tg1I6-0004gN-MG; Thu, 06 Feb 2025 13:47:34 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tg1I6-003oDk-0V;
	Thu, 06 Feb 2025 13:47:34 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BF4CC3BB4C9;
	Thu, 06 Feb 2025 12:47:33 +0000 (UTC)
Date: Thu, 6 Feb 2025 13:47:33 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, NXP S32 Linux <s32@nxp.com>, imx@lists.linux.dev, 
	Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>, 
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3
 SoC support
Message-ID: <20250206-tough-seagull-of-diversity-1b8ba7-mkl@pengutronix.de>
References: <20241204074916.880466-1-ciprianmarian.costea@oss.nxp.com>
 <20241204074916.880466-2-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qz65ro3fcu6xw73r"
Content-Disposition: inline
In-Reply-To: <20241204074916.880466-2-ciprianmarian.costea@oss.nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--qz65ro3fcu6xw73r
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3
 SoC support
MIME-Version: 1.0

Hello Krzysztof,

can you (and you bot) take a look at this patch?

Thanks,
Marc

On 04.12.2024 09:49:13, Ciprian Costea wrote:
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
>  .../bindings/net/can/fsl,flexcan.yaml         | 44 +++++++++++++++++--
>  1 file changed, 40 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b=
/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> index 97dd1a7c5ed2..73252fe56fe6 100644
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
> @@ -136,6 +143,35 @@ required:
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
> +            - description: Bus Error detection
> +            - description: Message Buffer interrupt for mailboxes 8-127
> +        interrupt-names:
> +          items:
> +            - const: mb-0
> +            - const: state
> +            - const: berr
> +            - const: mb-1
> +      required:
> +        - interrupt-names
> +    else:
> +      properties:
> +        interrupts:
> +          maxItems: 1
> +        interrupt-names: false
> +
>  additionalProperties: false
> =20
>  examples:
> --=20
> 2.45.2
>=20
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--qz65ro3fcu6xw73r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmekr2IACgkQDHRl3/mQ
kZxOdwf8C8MMmL+EnFDiiqoAtTokYJHzXNrc4kVC7YtoWzn7tsrnTq4Tkx7r09My
LZrMvfryFAOwlFD9zaj7dwGqnaFvaOJ9f0REHEztFUe4BEV03qeK2enFG9eNunek
A9/FxSArFYMDybn8V0loiX3+Apchf45k/c6k4u4GA2WOTVmPmpLgKOIkpJQmqXT6
S6nV5w/xbJv2X0ujX40D/QV+LNvyEH1UVrGrNgumwggPXr4eaEWYNthIkoD1nZLL
yoWMCYdYRh9+elqgCGpdYgfgLr8Cv1+tYa2jKmouc0oj8mQzsa+PJXkB+leO0mXB
MUduyAUNzZDGDesuKB9QJUeLfW7FkQ==
=pngP
-----END PGP SIGNATURE-----

--qz65ro3fcu6xw73r--

