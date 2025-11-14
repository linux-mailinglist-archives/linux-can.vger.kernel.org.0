Return-Path: <linux-can+bounces-5400-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEFCC5D64D
	for <lists+linux-can@lfdr.de>; Fri, 14 Nov 2025 14:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77343B7F4B
	for <lists+linux-can@lfdr.de>; Fri, 14 Nov 2025 13:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D2531B82E;
	Fri, 14 Nov 2025 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="CBPpRDWo"
X-Original-To: linux-can@vger.kernel.org
Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06D3315D52;
	Fri, 14 Nov 2025 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763127631; cv=none; b=FnGfkpbeJuvMmQQCI9Z+LURscUrplccl3PruYdtBycFDCp+9rVGbo0RRAJraWkvfyzjneaZmJ8TlxdSnI6llNyKePV1378ovVYGBw+tKbz/BP26yh5qxrVxwpbkxhrvPoTvXNGHXYS4u5tAKRphX3ZMc/aDyEkvWWzK52PDWRLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763127631; c=relaxed/simple;
	bh=4cOJY4dO3sEZMCBdI2nn9UZcEUub7LgNXjQuUo4QFlc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=A1vJhSMdieASFuIFEubK61BadXxQ+Rc+kzJqkPZBbhEpgOOvzh+xdu+s4Bl/HTYmBFxI9KqANTG9W+XIv1+MPaRcbnMqT3qMgZu+UqhGp27ZTJ/cA4uiN85CMJ7z5snkMA/R8Js0p2D/aNWXuETSKreAHkpfjnjAkCI3HcuTWmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=CBPpRDWo; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id A90D6DF8E28;
	Fri, 14 Nov 2025 14:34:24 +0100 (CET)
Received: from zimbra65-e11.priv.proxad.net (unknown [172.20.243.215])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 2DD27780389;
	Fri, 14 Nov 2025 14:34:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1763127257;
	bh=4cOJY4dO3sEZMCBdI2nn9UZcEUub7LgNXjQuUo4QFlc=;
	h=Date:From:To:Cc:In-Reply-To:Subject:From;
	b=CBPpRDWo2MW1LX9q3xUlDc4LBOTCNcMLakW9p5bRIK7DuEjrNwzpoCOnb/0unbh86
	 mzl1Rv2TIoDeEETFS1m2aogcgL3iqbsNlQn37B3X51r/J7JPVFICog9+op1ZfaGGLK
	 eVOWpX6adt1YZpI6HiknAp4QgCOyjZbIRkltwUEcud3/QCVw5i5gJ04yzeZBkAiqrp
	 cIieeoMXnESAL5MNkf3SOrOtkfQu+MiUc0B9SB1jPXNm6IcmJJJd5iUrMChpm7WWfJ
	 ivnc1+uNE0pg8MLvsVg1D2pqXEIJAY94feMK0ZW7Wps8uGKMIWxw28G6DD/1j8kchs
	 ODKPrGs/BOhzg==
Date: Fri, 14 Nov 2025 14:34:17 +0100 (CET)
From: =?utf-8?Q?St=C3=A9phane?= Grosjean <stephane.grosjean@free.fr>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: =?utf-8?Q?St=C3=A9phane?= Grosjean <stephane.grosjean@hms-networks.com>, 
	Robert Nawrath <mbro1689@gmail.com>, 
	Minh Le <minh.le.aj@renesas.com>, 
	Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>, 
	Marc Kleine-Budde <mkl@pengutronix.de>
Message-ID: <664236749.640139017.1763127257039.JavaMail.root@zimbra65-e11.priv.proxad.net>
In-Reply-To: <e58c90a8-c9e3-4f9b-99cb-09b87c18d657@hartkopp.net>
Subject: Re: [PATCH 3/9] can: netlink: add initial CAN XL support
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - GC142 (Linux)/7.2.0-GA2598)
X-Authenticated-User: stephane.grosjean@free.fr

Hi all,

I completely agree with Oliver: an error or warning message should only app=
ear when the feature is requested but not supported.

In the opposite case, displaying a warning about an unsupported feature whe=
n it has not been requested=E2=80=94but still configuring the interface=E2=
=80=94leaves the user (me ;-) ) in doubt (speaking from experience ;-)).

Best regards,

-- St=C3=A9phane

----- Mail original -----=20

De: "Oliver Hartkopp" <socketcan@hartkopp.net>=20
=C3=80: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pe=
ngutronix.de>=20
Cc: "St=C3=A9phane Grosjean" <stephane.grosjean@hms-networks.com>, "Robert =
Nawrath" <mbro1689@gmail.com>, "Minh Le" <minh.le.aj@renesas.com>, "Duy Ngu=
yen" <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, linux-kernel@v=
ger.kernel.org=20
Envoy=C3=A9: Vendredi 14 Novembre 2025 14:19:04=20
Objet: Re: [PATCH 3/9] can: netlink: add initial CAN XL support=20

Hi Vincent,=20

On 13.10.25 13:01, Vincent Mailhol wrote:=20
> CAN XL uses bittiming parameters different from Classical CAN and CAN=20
> FD. Thus, all the data bittiming parameters, including TDC, need to be=20
> duplicated for CAN XL.=20
>=20
> Add the CAN XL netlink interface for all the features which are common=20
> with CAN FD. Any new CAN XL specific features are added later on.=20
>=20
> Add a check that CAN XL capable nodes correctly provide=20
> CAN_CTRLMODE_RESTRIC_OP as mandated by ISO 11898-1:2024 =C2=A76.6.19.=20
>=20
> The first time CAN XL is activated, the MTU is set by default to=20
> CANXL_MAX_MTU. The user may then configure a custom MTU within the=20
> CANXL_MIN_MTU to CANXL_MIN_MTU range, in which case, the custom MTU=20
> value will be kept as long as CAN XL remains active.=20
>=20
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>=20
> ---=20
> Changelog:=20
>=20
> RFC -> v1:=20
>=20
> - Correctly wipe out the CAN XL data bittiming and TDC parameters=20
> when switching CAN_CTRLMODE_XL off.=20
>=20
> - Add one level on nesting for xl parameters so that:=20
>=20
> - bittiming are under priv->xl.data_bittiming{,_const}=C2=A8=20
> - pwm are under priv->xl.pwm{,_const}=20
>=20
> - Many other code refactors.=20
> ---=20
> drivers/net/can/dev/dev.c | 14 ++++++-=20
> drivers/net/can/dev/netlink.c | 87 ++++++++++++++++++++++++++++++++------=
--=20
> include/linux/can/bittiming.h | 6 ++-=20
> include/linux/can/dev.h | 7 +++-=20
> include/uapi/linux/can/netlink.h | 7 ++++=20
> 5 files changed, 100 insertions(+), 21 deletions(-)=20
>=20
> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c=20
> index 3377afb6f1c4..32f11db88295 100644=20
> --- a/drivers/net/can/dev/dev.c=20
> +++ b/drivers/net/can/dev/dev.c=20
> @@ -117,6 +117,12 @@ const char *can_get_ctrlmode_str(u32 ctrlmode)=20
> return "fd-tdc-manual";=20
> case CAN_CTRLMODE_RESTRICTED:=20
> return "restricted-operation";=20
> + case CAN_CTRLMODE_XL:=20
> + return "xl";=20
> + case CAN_CTRLMODE_XL_TDC_AUTO:=20
> + return "xl-tdc-auto";=20
> + case CAN_CTRLMODE_XL_TDC_MANUAL:=20
> + return "xl-tdc-manual";=20
> default:=20
> return "<unknown>";=20
> }=20
> @@ -350,7 +356,13 @@ void can_set_default_mtu(struct net_device *dev)=20
> {=20
> struct can_priv *priv =3D netdev_priv(dev);=20
>=20
> - if (priv->ctrlmode & CAN_CTRLMODE_FD) {=20
> + if (priv->ctrlmode & CAN_CTRLMODE_XL) {=20
> + if (can_is_canxl_dev_mtu(dev->mtu))=20
> + return;=20
> + dev->mtu =3D CANXL_MTU;=20
> + dev->min_mtu =3D CANXL_MIN_MTU;=20
> + dev->max_mtu =3D CANXL_MAX_MTU;=20
> + } else if (priv->ctrlmode & CAN_CTRLMODE_FD) {=20
> dev->mtu =3D CANFD_MTU;=20
> dev->min_mtu =3D CANFD_MTU;=20
> dev->max_mtu =3D CANFD_MTU;=20
> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.=
c=20
> index f44b5dffa176..2405f1265488 100644=20
> --- a/drivers/net/can/dev/netlink.c=20
> +++ b/drivers/net/can/dev/netlink.c=20
> @@ -2,7 +2,7 @@=20
> /* Copyright (C) 2005 Marc Kleine-Budde, Pengutronix=20
> * Copyright (C) 2006 Andrey Volkov, Varma Electronics=20
> * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>=20
> - * Copyright (C) 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>=20
> + * Copyright (C) 2021-2025 Vincent Mailhol <mailhol@kernel.org>=20
> */=20
>=20
> #include <linux/can/dev.h>=20
> @@ -22,6 +22,9 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX =
+ 1] =3D {=20
> [IFLA_CAN_TERMINATION] =3D { .type =3D NLA_U16 },=20
> [IFLA_CAN_TDC] =3D { .type =3D NLA_NESTED },=20
> [IFLA_CAN_CTRLMODE_EXT] =3D { .type =3D NLA_NESTED },=20
> + [IFLA_CAN_XL_DATA_BITTIMING] =3D { .len =3D sizeof(struct can_bittiming=
) },=20
> + [IFLA_CAN_XL_DATA_BITTIMING_CONST] =3D { .len =3D sizeof(struct can_bit=
timing_const) },=20
> + [IFLA_CAN_XL_TDC] =3D { .type =3D NLA_NESTED },=20
> };=20
>=20
> static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] =3D {=
=20
> @@ -70,7 +73,7 @@ static int can_validate_tdc(struct nlattr *data_tdc,=20
> return -EOPNOTSUPP;=20
> }=20
>=20
> - /* If one of the CAN_CTRLMODE_TDC_* flag is set then TDC=20
> + /* If one of the CAN_CTRLMODE_{,XL}_TDC_* flags is set then TDC=20
> * must be set and vice-versa=20
> */=20
> if ((tdc_auto || tdc_manual) && !data_tdc) {=20
> @@ -82,8 +85,8 @@ static int can_validate_tdc(struct nlattr *data_tdc,=20
> return -EOPNOTSUPP;=20
> }=20
>=20
> - /* If providing TDC parameters, at least TDCO is needed. TDCV=20
> - * is needed if and only if CAN_CTRLMODE_TDC_MANUAL is set=20
> + /* If providing TDC parameters, at least TDCO is needed. TDCV is=20
> + * needed if and only if CAN_CTRLMODE_{,XL}_TDC_MANUAL is set=20
> */=20
> if (data_tdc) {=20
> struct nlattr *tb_tdc[IFLA_CAN_TDC_MAX + 1];=20
> @@ -126,10 +129,10 @@ static int can_validate_databittiming(struct nlattr=
 *data[],=20
> bool is_on;=20
> int err;=20
>=20
> - /* Make sure that valid CAN FD configurations always consist of=20
> + /* Make sure that valid CAN FD/XL configurations always consist of=20
> * - nominal/arbitration bittiming=20
> * - data bittiming=20
> - * - control mode with CAN_CTRLMODE_FD set=20
> + * - control mode with CAN_CTRLMODE_{FD,XL} set=20
> * - TDC parameters are coherent (details in can_validate_tdc())=20
> */=20
>=20
> @@ -139,7 +142,10 @@ static int can_validate_databittiming(struct nlattr =
*data[],=20
> is_on =3D flags & CAN_CTRLMODE_FD;=20
> type =3D "FD";=20
> } else {=20
> - return -EOPNOTSUPP; /* Place holder for CAN XL */=20
> + data_tdc =3D data[IFLA_CAN_XL_TDC];=20
> + tdc_flags =3D flags & CAN_CTRLMODE_XL_TDC_MASK;=20
> + is_on =3D flags & CAN_CTRLMODE_XL;=20
> + type =3D "XL";=20
> }=20
>=20
> if (is_on) {=20
> @@ -206,6 +212,11 @@ static int can_validate(struct nlattr *tb[], struct =
nlattr *data[],=20
> if (err)=20
> return err;=20
>=20
> + err =3D can_validate_databittiming(data, extack,=20
> + IFLA_CAN_XL_DATA_BITTIMING, flags);=20
> + if (err)=20
> + return err;=20
> +=20
> return 0;=20
> }=20
>=20
> @@ -215,7 +226,8 @@ static int can_ctrlmode_changelink(struct net_device =
*dev,=20
> {=20
> struct can_priv *priv =3D netdev_priv(dev);=20
> struct can_ctrlmode *cm;=20
> - u32 ctrlstatic, maskedflags, notsupp, ctrlstatic_missing;=20
> + const u32 xl_mandatory =3D CAN_CTRLMODE_RESTRICTED;=20
> + u32 ctrlstatic, maskedflags, notsupp, ctrlstatic_missing, xl_missing;=
=20
>=20
> if (!data[IFLA_CAN_CTRLMODE])=20
> return 0;=20
> @@ -229,6 +241,7 @@ static int can_ctrlmode_changelink(struct net_device =
*dev,=20
> maskedflags =3D cm->flags & cm->mask;=20
> notsupp =3D maskedflags & ~(priv->ctrlmode_supported | ctrlstatic);=20
> ctrlstatic_missing =3D (maskedflags & ctrlstatic) ^ ctrlstatic;=20
> + xl_missing =3D (priv->ctrlmode_supported & xl_mandatory) ^ xl_mandatory=
;=20
>=20
> if (notsupp) {=20
> NL_SET_ERR_MSG_FMT(extack,=20
> @@ -248,21 +261,36 @@ static int can_ctrlmode_changelink(struct net_devic=
e *dev,=20
> return -EOPNOTSUPP;=20
> }=20
>=20
> + if ((priv->ctrlmode_supported & CAN_CTRLMODE_XL) && xl_missing) {=20
> + NL_SET_ERR_MSG_FMT(extack,=20
> + "bad device: CAN XL capable nodes must support the %s mode",=20
> + can_get_ctrlmode_str(xl_missing));=20
> + return -EOPNOTSUPP;=20
> + }=20
> +=20

I'm not sure if it is our job to check for ISO 11898-1:2024 compliance=20
of CAN controllers when CAN_CTRLMODE_RESTRICTED is not supported.=20

IMO an appropriate error message (only) when the user requests this=20
feature would be better and that is already the standard behaviour.=20

Best regards,=20
Oliver=20

> /* If a top dependency flag is provided, reset all its dependencies */=20
> if (cm->mask & CAN_CTRLMODE_FD)=20
> priv->ctrlmode &=3D ~CAN_CTRLMODE_FD_TDC_MASK;=20
> + if (cm->mask & CAN_CTRLMODE_XL)=20
> + priv->ctrlmode &=3D ~(CAN_CTRLMODE_XL_TDC_MASK);=20
>=20
> /* clear bits to be modified and copy the flag values */=20
> priv->ctrlmode &=3D ~cm->mask;=20
> priv->ctrlmode |=3D maskedflags;=20
>=20
> - /* Wipe potential leftovers from previous CAN FD config */=20
> + /* Wipe potential leftovers from previous CAN FD/XL config */=20
> if (!(priv->ctrlmode & CAN_CTRLMODE_FD)) {=20
> memset(&priv->fd.data_bittiming, 0,=20
> sizeof(priv->fd.data_bittiming));=20
> priv->ctrlmode &=3D ~CAN_CTRLMODE_FD_TDC_MASK;=20
> memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));=20
> }=20
> + if (!(priv->ctrlmode & CAN_CTRLMODE_XL)) {=20
> + memset(&priv->xl.data_bittiming, 0,=20
> + sizeof(priv->fd.data_bittiming));=20
> + priv->ctrlmode &=3D ~CAN_CTRLMODE_XL_TDC_MASK;=20
> + memset(&priv->xl.tdc, 0, sizeof(priv->xl.tdc));=20
> + }=20
>=20
> can_set_default_mtu(dev);=20
>=20
> @@ -337,7 +365,10 @@ static int can_dbt_changelink(struct net_device *dev=
, struct nlattr *data[],=20
> dbt_params =3D &priv->fd;=20
> tdc_mask =3D CAN_CTRLMODE_FD_TDC_MASK;=20
> } else {=20
> - return -EOPNOTSUPP; /* Place holder for CAN XL */=20
> + data_bittiming =3D data[IFLA_CAN_XL_DATA_BITTIMING];=20
> + data_tdc =3D data[IFLA_CAN_XL_TDC];=20
> + dbt_params =3D &priv->xl;=20
> + tdc_mask =3D CAN_CTRLMODE_XL_TDC_MASK;=20
> }=20
>=20
> if (!data_bittiming)=20
> @@ -388,7 +419,7 @@ static int can_dbt_changelink(struct net_device *dev,=
 struct nlattr *data[],=20
> */=20
> can_calc_tdco(&dbt_params->tdc, dbt_params->tdc_const, &dbt,=20
> tdc_mask, &priv->ctrlmode, priv->ctrlmode_supported);=20
> - } /* else: both CAN_CTRLMODE_TDC_{AUTO,MANUAL} are explicitly=20
> + } /* else: both CAN_CTRLMODE_{,XL}_TDC_{AUTO,MANUAL} are explicitly=20
> * turned off. TDC is disabled: do nothing=20
> */=20
>=20
> @@ -491,6 +522,11 @@ static int can_changelink(struct net_device *dev, st=
ruct nlattr *tb[],=20
> if (err)=20
> return err;=20
>=20
> + /* CAN XL */=20
> + err =3D can_dbt_changelink(dev, data, false, extack);=20
> + if (err)=20
> + return err;=20
> +=20
> if (data[IFLA_CAN_TERMINATION]) {=20
> const u16 termval =3D nla_get_u16(data[IFLA_CAN_TERMINATION]);=20
> const unsigned int num_term =3D priv->termination_const_cnt;=20
> @@ -558,14 +594,14 @@ static size_t can_data_bittiming_get_size(struct da=
ta_bittiming_params *dbt_para=20
> {=20
> size_t size =3D 0;=20
>=20
> - if (dbt_params->data_bittiming.bitrate) /* IFLA_CAN_DATA_BITTIMING */=
=20
> + if (dbt_params->data_bittiming.bitrate) /* IFLA_CAN_{,XL}_DATA_BITTIMIN=
G */=20
> size +=3D nla_total_size(sizeof(dbt_params->data_bittiming));=20
> - if (dbt_params->data_bittiming_const) /* IFLA_CAN_DATA_BITTIMING_CONST =
*/=20
> + if (dbt_params->data_bittiming_const) /* IFLA_CAN_{,XL}_DATA_BITTIMING_=
CONST */=20
> size +=3D nla_total_size(sizeof(*dbt_params->data_bittiming_const));=20
> - if (dbt_params->data_bitrate_const) /* IFLA_CAN_DATA_BITRATE_CONST */=
=20
> + if (dbt_params->data_bitrate_const) /* IFLA_CAN_{,XL}_DATA_BITRATE_CONS=
T */=20
> size +=3D nla_total_size(sizeof(*dbt_params->data_bitrate_const) *=20
> dbt_params->data_bitrate_const_cnt);=20
> - size +=3D can_tdc_get_size(dbt_params, tdc_flags);/* IFLA_CAN_TDC */=20
> + size +=3D can_tdc_get_size(dbt_params, tdc_flags);/* IFLA_CAN_{,XL}_TDC=
 */=20
>=20
> return size;=20
> }=20
> @@ -605,6 +641,9 @@ static size_t can_get_size(const struct net_device *d=
ev)=20
> size +=3D can_data_bittiming_get_size(&priv->fd,=20
> priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);=20
>=20
> + size +=3D can_data_bittiming_get_size(&priv->xl,=20
> + priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MASK);=20
> +=20
> return size;=20
> }=20
>=20
> @@ -649,7 +688,9 @@ static int can_tdc_fill_info(struct sk_buff *skb, con=
st struct net_device *dev,=20
> tdc_is_enabled =3D can_fd_tdc_is_enabled(priv);=20
> tdc_manual =3D priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL;=20
> } else {=20
> - return -EOPNOTSUPP; /* Place holder for CAN XL */=20
> + dbt_params =3D &priv->xl;=20
> + tdc_is_enabled =3D can_xl_tdc_is_enabled(priv);=20
> + tdc_manual =3D priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MANUAL;=20
> }=20
> tdc_const =3D dbt_params->tdc_const;=20
> tdc =3D &dbt_params->tdc;=20
> @@ -771,7 +812,19 @@ static int can_fill_info(struct sk_buff *skb, const =
struct net_device *dev)=20
>=20
> can_tdc_fill_info(skb, dev, IFLA_CAN_TDC) ||=20
>=20
> - can_ctrlmode_ext_fill_info(skb, priv)=20
> + can_ctrlmode_ext_fill_info(skb, priv) ||=20
> +=20
> + can_bittiming_fill_info(skb, IFLA_CAN_XL_DATA_BITTIMING,=20
> + &priv->xl.data_bittiming) ||=20
> +=20
> + can_bittiming_const_fill_info(skb, IFLA_CAN_XL_DATA_BITTIMING_CONST,=20
> + priv->xl.data_bittiming_const) ||=20
> +=20
> + can_bitrate_const_fill_info(skb, IFLA_CAN_XL_DATA_BITRATE_CONST,=20
> + priv->xl.data_bitrate_const,=20
> + priv->xl.data_bitrate_const_cnt) ||=20
> +=20
> + can_tdc_fill_info(skb, dev, IFLA_CAN_XL_TDC)=20
> )=20
>=20
> return -EMSGSIZE;=20
> diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.=
h=20
> index d30816dd93c7..68d533bb7856 100644=20
> --- a/include/linux/can/bittiming.h=20
> +++ b/include/linux/can/bittiming.h=20
> @@ -16,10 +16,12 @@=20
>=20
> #define CAN_CTRLMODE_FD_TDC_MASK \=20
> (CAN_CTRLMODE_TDC_AUTO | CAN_CTRLMODE_TDC_MANUAL)=20
> +#define CAN_CTRLMODE_XL_TDC_MASK \=20
> + (CAN_CTRLMODE_XL_TDC_AUTO | CAN_CTRLMODE_XL_TDC_MANUAL)=20
> #define CAN_CTRLMODE_TDC_AUTO_MASK \=20
> - (CAN_CTRLMODE_TDC_AUTO)=20
> + (CAN_CTRLMODE_TDC_AUTO | CAN_CTRLMODE_XL_TDC_AUTO)=20
> #define CAN_CTRLMODE_TDC_MANUAL_MASK \=20
> - (CAN_CTRLMODE_TDC_MANUAL)=20
> + (CAN_CTRLMODE_TDC_MANUAL | CAN_CTRLMODE_XL_TDC_MANUAL)=20
>=20
> /*=20
> * struct can_tdc - CAN FD Transmission Delay Compensation parameters=20
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h=20
> index 9de8fde3ec9d..945c16743702 100644=20
> --- a/include/linux/can/dev.h=20
> +++ b/include/linux/can/dev.h=20
> @@ -47,7 +47,7 @@ struct can_priv {=20
>=20
> const struct can_bittiming_const *bittiming_const;=20
> struct can_bittiming bittiming;=20
> - struct data_bittiming_params fd;=20
> + struct data_bittiming_params fd, xl;=20
> unsigned int bitrate_const_cnt;=20
> const u32 *bitrate_const;=20
> u32 bitrate_max;=20
> @@ -85,6 +85,11 @@ static inline bool can_fd_tdc_is_enabled(const struct =
can_priv *priv)=20
> return !!(priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);=20
> }=20
>=20
> +static inline bool can_xl_tdc_is_enabled(const struct can_priv *priv)=20
> +{=20
> + return !!(priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MASK);=20
> +}=20
> +=20
> static inline u32 can_get_static_ctrlmode(struct can_priv *priv)=20
> {=20
> return priv->ctrlmode & ~priv->ctrlmode_supported;=20
> diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/ne=
tlink.h=20
> index fafd1cce4798..c2c96c5978a8 100644=20
> --- a/include/uapi/linux/can/netlink.h=20
> +++ b/include/uapi/linux/can/netlink.h=20
> @@ -104,6 +104,9 @@ struct can_ctrlmode {=20
> #define CAN_CTRLMODE_TDC_AUTO 0x200 /* FD transceiver automatically calcu=
lates TDCV */=20
> #define CAN_CTRLMODE_TDC_MANUAL 0x400 /* FD TDCV is manually set up by us=
er */=20
> #define CAN_CTRLMODE_RESTRICTED 0x800 /* Restricted operation mode */=20
> +#define CAN_CTRLMODE_XL 0x1000 /* CAN XL mode */=20
> +#define CAN_CTRLMODE_XL_TDC_AUTO 0x2000 /* XL transceiver automatically =
calculates TDCV */=20
> +#define CAN_CTRLMODE_XL_TDC_MANUAL 0x4000 /* XL TDCV is manually set up =
by user */=20
>=20
> /*=20
> * CAN device statistics=20
> @@ -139,6 +142,10 @@ enum {=20
> IFLA_CAN_BITRATE_MAX,=20
> IFLA_CAN_TDC, /* FD */=20
> IFLA_CAN_CTRLMODE_EXT,=20
> + IFLA_CAN_XL_DATA_BITTIMING,=20
> + IFLA_CAN_XL_DATA_BITTIMING_CONST,=20
> + IFLA_CAN_XL_DATA_BITRATE_CONST,=20
> + IFLA_CAN_XL_TDC,=20
>=20
> /* add new constants above here */=20
> __IFLA_CAN_MAX,=20
>

