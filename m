Return-Path: <linux-can+bounces-32-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400ED7F0672
	for <lists+linux-can@lfdr.de>; Sun, 19 Nov 2023 14:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73CC280D1D
	for <lists+linux-can@lfdr.de>; Sun, 19 Nov 2023 13:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2B5101C9;
	Sun, 19 Nov 2023 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dojdJKck"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862CEF4F5;
	Sun, 19 Nov 2023 13:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C3CC433C7;
	Sun, 19 Nov 2023 13:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700401055;
	bh=2fexIX8Wllal1qs9XQNtQXc+WrSDQ3whn+AUI85d1mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dojdJKck+Y9O7k5rdfKnG08U6mBKW0yzAyatUWilOu1QJjyvkXsuWEupI2hp8nn1d
	 ILSIVbXXXSDURd9yDkvbJ0jpPPfPjIOdO1Z/b4D4TtOxXlmNJMyqpp1CBECnyE9DNk
	 bP2vP8DWGH1UBmdR/uwJ+sIXZ5w/2r5Z4SkHKpot8tiGD4ENOiKvcPU97OXJJEt7MC
	 F9yNEqTW239br5FnQaCc9w5P3fLB9MD8UGRG/QzDoZL2vJv/5hztp0EToBADUcUEF3
	 PUrkZOBbVHyniVmoYuNqJorvnpFZWKS83ynooRCViqs62zkJ/21SAjzik9nHy7BtEc
	 2s7NkQPGEHiNA==
Date: Sun, 19 Nov 2023 13:37:28 +0000
From: Conor Dooley <conor@kernel.org>
To: Srinivas Goud <srinivas.goud@amd.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de, git@amd.com,
	michal.simek@xilinx.com, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	appana.durga.rao@xilinx.com, naga.sureshkumar.relli@xilinx.com
Subject: Re: [PATCH v5 1/3] dt-bindings: can: xilinx_can: Add 'xlnx,has-ecc'
 optional property
Message-ID: <20231119-dotted-feast-eb01cbebde42@spud>
References: <1700213336-652-1-git-send-email-srinivas.goud@amd.com>
 <1700213336-652-2-git-send-email-srinivas.goud@amd.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8WwOMIKNYsPT2CWN"
Content-Disposition: inline
In-Reply-To: <1700213336-652-2-git-send-email-srinivas.goud@amd.com>


--8WwOMIKNYsPT2CWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 02:58:54PM +0530, Srinivas Goud wrote:
> ECC feature added to CAN TX_OL, TX_TL and RX FIFOs of
> Xilinx AXI CAN Controller.
> Part of this feature configuration and counter registers added in

"ECC is an IP configuration option where counter registers are added..."
The sentence is hard to parse for the important bit of information - the
justification for this being a property rather than based on compatible
or autodetectable based on some IP version etc.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> IP for 1bit/2bit ECC errors.
>=20
> 'xlnx,has-ecc' is optional property and added to Xilinx AXI CAN Controller
> node if ECC block enabled in the HW
>=20
> Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
> ---
> Changes in v5:
> Update property description
>=20
> Changes in v4:
> Fix binding check warning
> Update property description
>=20
> Changes in v3:
> Update commit description
> =20
> Changes in v2:
> None
>=20
>  Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml b/=
Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> index 64d57c3..8d4e5af 100644
> --- a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> @@ -49,6 +49,10 @@ properties:
>    resets:
>      maxItems: 1
> =20
> +  xlnx,has-ecc:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: CAN TX_OL, TX_TL and RX FIFOs have ECC support(AXI CAN)
> +
>  required:
>    - compatible
>    - reg
> @@ -137,6 +141,7 @@ examples:
>          interrupts =3D <GIC_SPI 59 IRQ_TYPE_EDGE_RISING>;
>          tx-fifo-depth =3D <0x40>;
>          rx-fifo-depth =3D <0x40>;
> +        xlnx,has-ecc;
>      };
> =20
>    - |
> --=20
> 2.1.1
>=20

--8WwOMIKNYsPT2CWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVoPmAAKCRB4tDGHoIJi
0gIVAQCmItBnILexQiAoXNdAAsHy5rgfRr4rjnM34BOJAlWaNQEA92zmPiiA1wxS
KxWwYSuiX1hAlANo8CLa5w7qWaHayQY=
=jE3W
-----END PGP SIGNATURE-----

--8WwOMIKNYsPT2CWN--

