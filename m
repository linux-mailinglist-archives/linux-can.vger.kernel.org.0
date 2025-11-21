Return-Path: <linux-can+bounces-5550-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 312A4C7829D
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 10:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id A22E335E81
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5D234165F;
	Fri, 21 Nov 2025 09:19:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0BF3396E9
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716771; cv=none; b=AR++DiwFKaq67+ak3ppJAefx0gLf6QOfzEUkDIgFKmWnBOVT91tiBiI2mAuVuZW1cl4zyKA1XSJqE+JbEwzEcjeXHRFAbr6H+I1y0LSneTKFgDKsu8wl/y6iaHuNR0t1MsfSqkH3NKh/3ptWWt27+iX1Xg0NyLoHs23JtQ6igkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716771; c=relaxed/simple;
	bh=DPN8J3jed+ss/8dL1dWFUq2QyhreEa1fpDlZQvSCcOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsrMBReFgxQ8b6E09/EUpnFIpWExyEjCT/5kheuNR+XC5UYASQ2hYbGnak5UxzKgSdsebk9hpwz6r/6kKZ5p6Z+BILKqXMT37+CjAIFNnsCoCo7MCqlihbxFlIShZOH0QWysbDV2qYWUqlNTNrl+4PDYPwRArTdGJB+69goY5d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vMNId-0003Jv-Vk; Fri, 21 Nov 2025 10:19:27 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vMNId-001YqI-1w;
	Fri, 21 Nov 2025 10:19:27 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 35ADE4A45F9;
	Fri, 21 Nov 2025 09:19:27 +0000 (UTC)
Date: Fri, 21 Nov 2025 10:19:26 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [canxl v4 10/17] can: netlink: add PWM netlink interface
Message-ID: <20251121-cherubic-pearl-bittern-e54ab2-mkl@pengutronix.de>
References: <20251121083414.3642-1-socketcan@hartkopp.net>
 <20251121083414.3642-11-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jeqef6rf4fcyy7s4"
Content-Disposition: inline
In-Reply-To: <20251121083414.3642-11-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--jeqef6rf4fcyy7s4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [canxl v4 10/17] can: netlink: add PWM netlink interface
MIME-Version: 1.0

On 21.11.2025 09:34:07, Oliver Hartkopp wrote:
> From: Vincent Mailhol <mailhol@kernel.org>
>
> When the TMS is switched on, the node uses PWM (Pulse Width
> Modulation) during the data phase instead of the classic NRZ (Non
> Return to Zero) encoding.
>
> PWM is configured by three parameters:
>
>   - PWMS: Pulse Width Modulation Short phase
>   - PWML: Pulse Width Modulation Long phase
>   - PWMO: Pulse Width Modulation Offset time
>
> For each of these parameters, define three IFLA symbols:
>
>   - IFLA_CAN_PWM_PWM*_MIN: the minimum allowed value.
>   - IFLA_CAN_PWM_PWM*_MAX: the maximum allowed value.
>   - IFLA_CAN_PWM_PWM*: the runtime value.
>
> This results in a total of nine IFLA symbols which are all nested in a
> parent IFLA_CAN_XL_PWM symbol.
>
> IFLA_CAN_PWM_PWM*_MIN and IFLA_CAN_PWM_PWM*_MAX define the range of
> allowed values and will match the value statically configured by the
> device in struct can_pwm_const.
>
> IFLA_CAN_PWM_PWM* match the runtime values stored in struct can_pwm.
> Those parameters may only be configured when the tms mode is on. If
> the PWMS, PWML and PWMO parameters are provided, check that all the
> needed parameters are present using can_validate_pwm(), then check
> their value using can_validate_pwm_bittiming(). PWMO defaults to zero
> if omitted. Otherwise, if CAN_CTRLMODE_XL_TMS is true but none of the
> PWM parameters are provided, calculate them using can_calc_pwm().
>
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/dev/netlink.c    | 192 ++++++++++++++++++++++++++++++-
>  include/uapi/linux/can/netlink.h |  25 ++++
>  2 files changed, 215 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index 5a628c629109..72b9a094ea83 100644
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
>
>  static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] =3D {
>  	[IFLA_CAN_TDC_TDCV_MIN] =3D { .type =3D NLA_U32 },
>  	[IFLA_CAN_TDC_TDCV_MAX] =3D { .type =3D NLA_U32 },
> @@ -37,10 +38,22 @@ static const struct nla_policy can_tdc_policy[IFLA_CA=
N_TDC_MAX + 1] =3D {
>  	[IFLA_CAN_TDC_TDCV] =3D { .type =3D NLA_U32 },
>  	[IFLA_CAN_TDC_TDCO] =3D { .type =3D NLA_U32 },
>  	[IFLA_CAN_TDC_TDCF] =3D { .type =3D NLA_U32 },
>  };
>
> +static const struct nla_policy can_pwm_policy[IFLA_CAN_PWM_MAX + 1] =3D {
> +	[IFLA_CAN_PWM_PWMS_MIN] =3D { .type =3D NLA_U32 },
> +	[IFLA_CAN_PWM_PWMS_MAX] =3D { .type =3D NLA_U32 },
> +	[IFLA_CAN_PWM_PWML_MIN] =3D { .type =3D NLA_U32 },
> +	[IFLA_CAN_PWM_PWML_MAX] =3D { .type =3D NLA_U32 },
> +	[IFLA_CAN_PWM_PWMO_MIN] =3D { .type =3D NLA_U32 },
> +	[IFLA_CAN_PWM_PWMO_MAX] =3D { .type =3D NLA_U32 },
> +	[IFLA_CAN_PWM_PWMS] =3D { .type =3D NLA_U32 },
> +	[IFLA_CAN_PWM_PWML] =3D { .type =3D NLA_U32 },
> +	[IFLA_CAN_PWM_PWMO] =3D { .type =3D NLA_U32 },
> +};
> +
>  static int can_validate_bittiming(struct nlattr *data[],
>  				  struct netlink_ext_ack *extack,
>  				  int ifla_can_bittiming)
>  {
>  	struct can_bittiming *bt;
> @@ -117,10 +130,44 @@ static int can_validate_tdc(struct nlattr *data_tdc,
>  	}
>
>  	return 0;
>  }
>
> +static int can_validate_pwm(struct nlattr *data[],
> +			    struct netlink_ext_ack *extack, u32 flags)
> +{
> +	struct nlattr *tb_pwm[IFLA_CAN_PWM_MAX + 1];
> +	int err;
> +
> +	if (!data[IFLA_CAN_XL_PWM])
> +		return 0;
> +
> +	if (!(flags & CAN_CTRLMODE_XL_TMS)) {
> +		NL_SET_ERR_MSG(extack, "PWM requires TMS");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	err =3D nla_parse_nested(tb_pwm, IFLA_CAN_PWM_MAX, data[IFLA_CAN_XL_PWM=
],
> +			       can_pwm_policy, extack);
> +	if (err)
> +		return err;
> +
> +	if (!tb_pwm[IFLA_CAN_PWM_PWMS] !=3D !tb_pwm[IFLA_CAN_PWM_PWML]) {
> +		NL_SET_ERR_MSG(extack,
> +			       "Provide either both PWMS and PWML, or none for automic calcul=
ation");

    =E2=97=8F checkpatch.pl: WARNING: 'automic' may be misspelled - perhaps=
 'atomic'?
    =E2=97=8F checkpatch.pl: #188: FILE: drivers/net/can/dev/netlink.c:156:
    =E2=97=8F checkpatch.pl: +                         "Provide either both=
 PWMS and PWML, or none for automic calculation");
    =E2=97=8F checkpatch.pl:

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jeqef6rf4fcyy7s4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkgLpsACgkQDHRl3/mQ
kZz5eQf9GO3Xa+NA9yY9A144wWPfeq4fS7IcIlPGoX7Q+0YgAE40TI23wqEWLsdh
fl5z1kUQq2ZSVMzOEtm2MZLJspe8al+FTDR/mXSwRius5hYSCtSoaoaQQD2cjRRg
L2ig9+fRLmvpbKb6wpmyA4e1kaQVlOTV/l6w8xqxPm9BcJ1JMlYNhf96kK1jp6ui
vpMLZDTpbVKbfq4zo4g0XsBitE/yy8goQcLoMOARKlYUUPl1y66QKKrDKNWmttn5
ee7hjgJh5RyEtoYB9yUEPL/HI0bCJMl5E1n0cr0tbsvdp8FSU+qi6ptGgorjpbYE
anRrieT5zvF7LIXx/q6bcC9IF/ayPA==
=a2BV
-----END PGP SIGNATURE-----

--jeqef6rf4fcyy7s4--

