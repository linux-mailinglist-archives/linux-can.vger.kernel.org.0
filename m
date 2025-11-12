Return-Path: <linux-can+bounces-5351-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66915C51362
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 09:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A564E189CB65
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 08:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139B42FD661;
	Wed, 12 Nov 2025 08:53:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCEC2FD1D5
	for <linux-can@vger.kernel.org>; Wed, 12 Nov 2025 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937604; cv=none; b=PXI7puWXytrDxejkobYWueQV+KeXPssLs8LsyrbR8eFJkIA79x4JKEC/RH++tRcwpO04bEPYHJ0wyqWIB8rHqHwiJITAOg6mDHhPvfmXfjxzzSCL87Paf0LKNABhCZ9otnHuCdV3oZymc58d/Nu4JCHg5LTc7EMgj85GLahZm7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937604; c=relaxed/simple;
	bh=MhaFweMhCshHOQ3Abf/QyZEE0utz6JnGC5ikWxSKunw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rn6E/VxboVLzC9m+37KOSeRbKdYmyIPMj7vJIjTpF9zRpdGYB3dmDM270UK/19IB3KcgjcoeNRv6azmr1rjwDlJO4bHX0mznswIR5Owr0MPfXmby/TWeH8C258HhDOifzvRgkd7wxEA+94ShDvy6bNh1C3D3GsPsAQqxOnXCVes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ6bF-0003Cr-LJ; Wed, 12 Nov 2025 09:53:09 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJ6bF-0003JA-1K;
	Wed, 12 Nov 2025 09:53:09 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2AB8649D94F;
	Wed, 12 Nov 2025 08:53:09 +0000 (UTC)
Date: Wed, 12 Nov 2025 09:53:09 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: kernel@pengutronix.de, mailhol.vincent@wanadoo.fr, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, cl@rock-chips.com, 
	linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RESEND PATCH v8 1/4] dt-bindings: can: rockchip_canfd: add
 rk3576 CAN controller
Message-ID: <20251112-faithful-olive-orangutan-0dd207-mkl@pengutronix.de>
References: <20251112015940.3695638-1-zhangqing@rock-chips.com>
 <20251112015940.3695638-2-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6j5z6jy5bzcqxtvr"
Content-Disposition: inline
In-Reply-To: <20251112015940.3695638-2-zhangqing@rock-chips.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--6j5z6jy5bzcqxtvr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RESEND PATCH v8 1/4] dt-bindings: can: rockchip_canfd: add
 rk3576 CAN controller
MIME-Version: 1.0

On 12.11.2025 09:59:37, Elaine Zhang wrote:
> Add documentation for the rockchip rk3576 CAN controller.
>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../bindings/net/can/rockchip,rk3568v2-canfd.yaml  | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-=
canfd.yaml b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-ca=
nfd.yaml
> index a077c0330013..22e10494e7d1 100644
> --- a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.y=
aml
> +++ b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.y=
aml
> @@ -10,13 +10,12 @@ title:
>  maintainers:
>    - Marc Kleine-Budde <mkl@pengutronix.de>
>
> -allOf:
> -  - $ref: can-controller.yaml#
> -

What happened to the allOf?

>  properties:
>    compatible:
>      oneOf:
> -      - const: rockchip,rk3568v2-canfd
> +      - enum:
> +          - rockchip,rk3568v2-canfd
> +          - rockchip,rk3576-can
>        - items:
>            - const: rockchip,rk3568v3-canfd
>            - const: rockchip,rk3568v2-canfd
> @@ -43,6 +42,13 @@ properties:
>        - const: core
>        - const: apb
>
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    items:
> +      - const: rx
> +
>  required:
>    - compatible
>    - reg

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6j5z6jy5bzcqxtvr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkUSvEACgkQDHRl3/mQ
kZxpxQf9HZ67/DDxNczIiTdL1rc5POLN6x4dvvla46CMBBsqZIYGLcy/POss2VvD
OPScDEziboS5XmeA7yGdbl3XwrGL9tnn4DyQX8Xk6WbqxNrsVcVbFfyon2xDcOYT
ulS67nJ5ZWjWqZIcU4BD5sZBMgko0x/nIdGH0n3omcb7h+Pi8s9dhI5RE2chc59z
jsCgNBHqO//Wf7hjm50LJBOQ6mUn/djAEJS4132v2EFpsCFNm/2j3TZKTT2N6P1S
Z0GMk0rpaSkltF5goiQy9v5WZYnD2Maoqqc3aCH2/d/bTtin07vdTZlw8iijm8r1
70MAitU6N1mjEufhlI5md6FOaui2FA==
=EB7b
-----END PGP SIGNATURE-----

--6j5z6jy5bzcqxtvr--

