Return-Path: <linux-can+bounces-4815-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A31AB915CF
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 15:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E812B7A3A8B
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 13:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2373D544;
	Mon, 22 Sep 2025 13:19:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2CE1E9919
	for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758547147; cv=none; b=TaV8lbAnbCUItTaTHdYbAlsAOUm/os0bxpyoU6XCcu2ms9gSX87tRvmY+mfcLtH6VdQqQtpDZd2VtWDRqK8EUf/XPMTN+pFyNzYzprrtU5NyzW6afdeIZysUAFLGXKjc4ihUkXB4Z8ynPmP22dFIZdKbaOi4e+F2fPeorZWaSRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758547147; c=relaxed/simple;
	bh=UGoUEHjpJvt5Yr3oOisWorSw38gBup+CpnaeQcIdBBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agvaZFDWi9BZvvhYCkeNoN2BpAE/zzUGuSeZJmjZWsmB2N11YpfzajDDv7Ro9GnXN/kyKSX+szS1tl5N/BfUvxuZpoMq38fxUnrsotocvUTQQQ1rv4vcm1xaeW8YgQsCKJU3i4VZcVBOlodxcC5imGG5mF2mDD7fWi2REjJNDs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0gRQ-0005EN-QE; Mon, 22 Sep 2025 15:18:52 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0gRQ-002bNX-1U;
	Mon, 22 Sep 2025 15:18:52 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 12606477046;
	Mon, 22 Sep 2025 13:18:52 +0000 (UTC)
Date: Mon, 22 Sep 2025 15:18:51 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: kernel@pengutronix.de, mailhol.vincent@wanadoo.fr, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, cl@rock-chips.com, 
	kever.yang@rock-chips.com, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 2/4] net: can: rockchip: Refactor the
 rkcanfd_devtype_data structure
Message-ID: <20250922-hopeful-mysterious-mole-bccfa3-mkl@pengutronix.de>
References: <20250922071543.73923-1-zhangqing@rock-chips.com>
 <20250922071543.73923-3-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pxk6t45566eu5aco"
Content-Disposition: inline
In-Reply-To: <20250922071543.73923-3-zhangqing@rock-chips.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--pxk6t45566eu5aco
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 2/4] net: can: rockchip: Refactor the
 rkcanfd_devtype_data structure
MIME-Version: 1.0

On 22.09.2025 15:15:41, Elaine Zhang wrote:
> Add new function pointer:
> Encapsulate some hardware operation functions into
> rkcanfd_devtype_data to provide differentiated implementations for
> different models (such as RK3568v2/v3).
>=20
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

[...]

> diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/=
rockchip/rockchip_canfd.h
> index 93131c7d7f54..bcd26d23062b 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd.h
> +++ b/drivers/net/can/rockchip/rockchip_canfd.h
> @@ -436,9 +436,20 @@ enum rkcanfd_model {
>  	RKCANFD_MODEL_RK3568V3 =3D 0x35683,
>  };
> =20
> +struct rkcanfd_priv;
> +
>  struct rkcanfd_devtype_data {
>  	enum rkcanfd_model model;
>  	u32 quirks;
> +	void (*get_berr_counter)(struct rkcanfd_priv *priv, struct can_berr_cou=
nter *bec);
> +	void (*interrupts_enable)(const struct rkcanfd_priv *priv);
> +	void (*interrupts_disable)(const struct rkcanfd_priv *priv);
> +	void (*fifo_setup)(struct rkcanfd_priv *priv);

Why do you make fifo setup a function pointer if it's only called from
chip_start, which you make a function pointer, too?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--pxk6t45566eu5aco
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjRTLgACgkQDHRl3/mQ
kZzvyQgApVlHcsn6vij4HUY70eO04wqsBAOXG0klOf3yy/PakkXYgqsz7mKlryRg
HX+dlpOa6RESuRjCLA/REQo4whMrVTysanahmydgd8CqEvV+id+/0qKB6PvWKEhm
3JejSO5O16PGRXKDA/GBpFaDzDdav77p/3TgVtNKUioOL5/18ca4dNgM9o+/NUZH
+Ak/UKtR6VnV2DvyR3hWR+eznMl0my/zXmf0X1hrm8bUnikJtQqEGaGrWfJqHXiw
tr9sijYa+akL4b2+x4R61dcfmKFo9hNzizx+Vhf8L8Ip8FiF2y7wj9kdgQlBMhFd
6Gh9dnZ0gTk8Rbb2PJb5oCZQ7jLyOA==
=sxoi
-----END PGP SIGNATURE-----

--pxk6t45566eu5aco--

