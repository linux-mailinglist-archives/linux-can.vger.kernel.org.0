Return-Path: <linux-can+bounces-3722-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EFCAC6DEC
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 18:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1AD4A142A
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 16:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F9F28CF6C;
	Wed, 28 May 2025 16:23:15 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BECF17B418
	for <linux-can@vger.kernel.org>; Wed, 28 May 2025 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748449395; cv=none; b=boRPdR0N3XBXvrFrzBwMvB030Xw+Sr8EFESRcKtQn/BoTFJ/wUG31ytO3rqYGVIsMXEx9ylqCCGIieTNQ1Ss3lBHW2OTA890aTMPOmsFuCaeLkm0JHQNFfQsIzjzP31jPp4GjFobqtxeulZxpeb83xqUlyo+V1TSTXhnG7twz9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748449395; c=relaxed/simple;
	bh=mIi8Lb9MQN2YvDa8UPtnF7u2T2piW+oIGb3KSVLc0hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SymX/8/cvyUsW1qoWLG72WtZ3Jq5XUWBk8I2qECfrO6xU1DbEGO5IuwVvyt0WrajqyOo6SMD+/cQr/XIEuk51NsBkiT9fp5hGep+OBb/oey2MmfB16AnTVIsQqMSCug94W7lAh+NBmHyvdk3MHmTeCuBQCzqt0aOM2XrC6BRVZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uKJYc-0005iy-3O; Wed, 28 May 2025 18:23:10 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uKJYb-000cQH-2k;
	Wed, 28 May 2025 18:23:09 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8685341B95A;
	Wed, 28 May 2025 16:23:09 +0000 (UTC)
Date: Wed, 28 May 2025 18:23:09 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH 10/11] can: canxl: add PWM config support
Message-ID: <20250528-encouraging-scallop-of-expression-2d1ebe-mkl@pengutronix.de>
References: <20250527195625.65252-1-socketcan@hartkopp.net>
 <20250527195625.65252-10-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t3y7z52f3fyy3mym"
Content-Disposition: inline
In-Reply-To: <20250527195625.65252-10-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--t3y7z52f3fyy3mym
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 10/11] can: canxl: add PWM config support
MIME-Version: 1.0

On 27.05.2025 21:56:24, Oliver Hartkopp wrote:
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/dev/netlink.c    | 31 ++++++++++++++++++++++++++++++-
>  include/linux/can/bittiming.h    | 25 +++++++++++++++++++++++++
>  include/linux/can/dev.h          |  1 +
>  include/uapi/linux/can/netlink.h | 15 +++++++++++++++
>  4 files changed, 71 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index 1b798a7dcd64..685cceb74048 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -23,10 +23,11 @@ static const struct nla_policy can_policy[IFLA_CAN_MA=
X + 1] =3D {
>  	[IFLA_CAN_TDC] =3D { .type =3D NLA_NESTED },
>  	[IFLA_CAN_CTRLMODE_EXT] =3D { .type =3D NLA_NESTED },
>  	[IFLA_CAN_XL_DATA_BITTIMING] =3D { .len =3D sizeof(struct can_bittiming=
) },
>  	[IFLA_CAN_XL_DATA_BITTIMING_CONST] =3D { .len =3D sizeof(struct can_bit=
timing_const) },
>  	[IFLA_CAN_XL_TDC] =3D { .type =3D NLA_NESTED },
> +	[IFLA_CAN_XL_PWM] =3D { .type =3D NLA_NESTED },
>  };
> =20
>  static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] =3D {
>  	[IFLA_CAN_TDC_TDCV_MIN] =3D { .type =3D NLA_U32 },
>  	[IFLA_CAN_TDC_TDCV_MAX] =3D { .type =3D NLA_U32 },
> @@ -37,10 +38,16 @@ static const struct nla_policy can_tdc_policy[IFLA_CA=
N_TDC_MAX + 1] =3D {
>  	[IFLA_CAN_TDC_TDCV] =3D { .type =3D NLA_U32 },
>  	[IFLA_CAN_TDC_TDCO] =3D { .type =3D NLA_U32 },
>  	[IFLA_CAN_TDC_TDCF] =3D { .type =3D NLA_U32 },
>  };
> =20
> +static const struct nla_policy can_pwm_policy[IFLA_CAN_PWM_MAX + 1] =3D {
> +	[IFLA_CAN_PWM_OFFSET] =3D { .type =3D NLA_U8 },
> +	[IFLA_CAN_PWM_LONG] =3D { .type =3D NLA_U8 },
> +	[IFLA_CAN_PWM_SHORT] =3D { .type =3D NLA_U8 },

IIRC when Oleksij added some Ethernet related stuff, upstream wanted u32
even if the values would have fitted in a u8.

> +};
> +
>  static int can_validate_bittiming(const struct can_bittiming *bt,
>  				  struct netlink_ext_ack *extack)
>  {
>  	/* sample point is in one-tenth of a percent */
>  	if (bt->sample_point >=3D 1000) {
> @@ -464,10 +471,29 @@ static int can_changelink(struct net_device *dev, s=
truct nlattr *tb[],
>  				 can_xl_tdc_is_enabled(priv),
>  				 CAN_CTRLMODE_XL_TDC_MASK, extack);
>  	if (err)
>  		return err;
> =20
> +	/* CAN XL transceiver PWM configuration */
> +	if (data[IFLA_CAN_XL_PWM]) {
> +		struct nlattr *tb_pwm[IFLA_CAN_PWM_MAX + 1];
> +
> +		err =3D nla_parse_nested(tb_pwm, IFLA_CAN_PWM_MAX, data[IFLA_CAN_XL_PW=
M],
> +				       can_pwm_policy, extack);
> +		if (err)
> +			return err;
> +
> +		if (tb_pwm[IFLA_CAN_PWM_OFFSET])
> +			priv->pwm.pwm_offset =3D nla_get_u8(tb_pwm[IFLA_CAN_PWM_OFFSET]) & 0x=
3F;
> +
> +		if (tb_pwm[IFLA_CAN_PWM_LONG])
> +			priv->pwm.pwm_phase_long =3D nla_get_u8(tb_pwm[IFLA_CAN_PWM_LONG]) & =
0x3F;
> +
> +		if (tb_pwm[IFLA_CAN_PWM_SHORT])
> +			priv->pwm.pwm_phase_short =3D nla_get_u8(tb_pwm[IFLA_CAN_PWM_SHORT]) =
& 0x3F;

If the values are to large, reject them. Do not silently take only 6
bits. Fill extack for a descriptive error message.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--t3y7z52f3fyy3mym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmg3OGoACgkQDHRl3/mQ
kZysQgf/b6CRuUac982nsGBjPOhSfNOCePUvZMomCjtsyA/Bwj4hWydae+w4p1T2
6ndWWX5xW7hDLo1w8AWgkuWRww4jIvohmRSoA+VwrNKBeldMXRjkR/15CWzyj0i1
nM1zVj/Ri9ArAPMq0IrGwHzdgp/oYtdZovRkflojJM45WGhk/EowcPhp5OQzjzD5
phXV0yT7SromxmZmk+8a+UTJVgrH60t0LwjkPetokInZ+wzH3F7KqGipXqnerdzO
zrWq4hoTfp1hsot7tFC6S/1D/T+38o2o+dlplSyhCL9CL157Mz6wgvD/o8uWS1+7
PmT9pRZSB3xY4KGv/cvolMGdWt0p2w==
=VZ5U
-----END PGP SIGNATURE-----

--t3y7z52f3fyy3mym--

