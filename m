Return-Path: <linux-can+bounces-6058-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9D6D07FD0
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 09:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31E0E30060E7
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 08:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959E3352F8C;
	Fri,  9 Jan 2026 08:53:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF4A352F9A
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 08:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767948791; cv=none; b=LYeMl0Ly3xAPUhR33OICDBuYxmCkTmm5CXc9E+gvoM9vI2OP5/tVMkmT5WBC6sWehRFz0wnDgxamQ5nqTeIv42zkfvwUAkObAl1L8eXTpkS5DXm6UaIA1NSrScq833dfR4UOM672kdN/OdGkcZAXButgem9jGoSk2upQ7yOF/YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767948791; c=relaxed/simple;
	bh=NcAAHBKuL1paDyvekQySUgExGDiJDCMW4nBD4aU5ftA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6t45Igj9XTKEwEHHO9Tji74pKBVt5yaXE0Nj8lyRJaGu3uMMq7oAe/KGJrvcfrJRJjVbGgzzW2tfuKa+q0VqB5xnv+zGjBxFG8zeB4L01Hw5yO3POjg2ZJ/noFJmr+2BR+QDwt3P/IRHXK2Wc9d4ndySkz1ziG+/4uYmJSdx70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ve8Ec-0000dg-1f; Fri, 09 Jan 2026 09:52:42 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ve8Eb-009ogy-0l;
	Fri, 09 Jan 2026 09:52:41 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 482464C9645;
	Fri, 09 Jan 2026 08:52:40 +0000 (UTC)
Date: Fri, 9 Jan 2026 09:52:39 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: mani@kernel.org, thomas.kopp@microchip.com, mailhol@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, mukesh.savaliya@oss.qualcomm.com, 
	anup.kulkarni@oss.qualcomm.com
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: qcs6490-rb3gen2: Enable CAN bus
 controller
Message-ID: <20260109-agile-bear-of-fascination-cc4680-mkl@pengutronix.de>
References: <20260108125200.2803112-1-viken.dadhaniya@oss.qualcomm.com>
 <20260108125200.2803112-3-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b6a6cfnpmaill5yd"
Content-Disposition: inline
In-Reply-To: <20260108125200.2803112-3-viken.dadhaniya@oss.qualcomm.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--b6a6cfnpmaill5yd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: qcs6490-rb3gen2: Enable CAN bus
 controller
MIME-Version: 1.0

On 08.01.2026 18:22:00, Viken Dadhaniya wrote:
> Enable the MCP2518FD CAN controller on the QCS6490 RB3 Gen2 platform.
> The controller is connected via SPI3 and uses a 40=E2=80=AFMHz oscillator.
> A GPIO hog for GPIO0 is included to configure the CAN transceiver in
> Normal mode during boot.
>
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 30 ++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/bo=
ot/dts/qcom/qcs6490-rb3gen2.dts
> index e3d2f01881ae..f2f2925e645a 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -44,6 +44,14 @@ chosen {
>  		stdout-path =3D "serial0:115200n8";
>  	};
>
> +	clocks {
> +		mcp2518fd_osc: can-clk {
> +			compatible =3D "fixed-clock";
> +			clock-frequency =3D <40000000>;
> +			#clock-cells =3D <0>;

Is the #clock-cells property needed?

> +		};
> +	};
> +
>  	dp-connector {
>  		compatible =3D "dp-connector";
>  		label =3D "DP";
> @@ -1151,6 +1159,28 @@ platform {
>  	};
>  };
>
> +&spi3 {
> +	status =3D "okay";
> +
> +	can@0 {
> +		compatible =3D "microchip,mcp2518fd";
> +		reg =3D <0>;
> +		interrupts-extended =3D <&tlmm 7 IRQ_TYPE_LEVEL_LOW>;
> +		clocks =3D <&mcp2518fd_osc>;
> +		spi-max-frequency =3D <10000000>;
> +		vdd-supply =3D <&vreg_l11c_2p8>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +
> +		gpio0-hog {
> +			gpio-hog;
> +			gpios =3D <0 GPIO_ACTIVE_LOW>;
> +			output-high;
> +			line-name =3D "mcp251xfd-gpio0";

If the CAN transceiver is connected to GPIO0, why not reflect that in
the name of the line?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--b6a6cfnpmaill5yd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlgwdQACgkQDHRl3/mQ
kZzYcgf/RcjpsR1zrNIK/qYyKyE2xYZkGYQ+2JAZqCedlbbvXt8s4UdXhDbslXMB
5xXPrMAb9jwiBNCwQJXSitDhhZf0HqNCpzcVv2jwa5Xh0NK84hHxNoKJKpzB+G2L
p45ocigeSLxzqHfxjM6miQKKApRqQqZf05UDe62o7FeNJXaO+MY8NKPw6m6L0z5z
Ma7EALZDaX1BkQ76G1P7omtuyOWk24vDlQjMaoLVkmxy5sKEO3jOQ/mAyiH+zC99
5R9pHd/ipWcXmTmr7Kyzskp2QTgaoF7cFjGs/PH6PlaqNeVliLnVeeiIP9F+KFiD
KWCuk/ImkKA67JOs/sG/zj2m0oFEiw==
=k+Pi
-----END PGP SIGNATURE-----

--b6a6cfnpmaill5yd--

