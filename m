Return-Path: <linux-can+bounces-980-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4149320EF
	for <lists+linux-can@lfdr.de>; Tue, 16 Jul 2024 09:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8A81F22D80
	for <lists+linux-can@lfdr.de>; Tue, 16 Jul 2024 07:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B5B2C19E;
	Tue, 16 Jul 2024 07:06:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4520225A8
	for <linux-can@vger.kernel.org>; Tue, 16 Jul 2024 07:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721113606; cv=none; b=m5/PsSwl80gkaHIa3hA8TbVXiqi6wzKGsM5DWQBXMiNC6/EmjQBtjl0mvBaV8BbbLUwQq4TT4dJG0qxaL0lDtW1MCU52R9TtehB1KlPr8rV3qPB8ndaj8gCoNfd2Lzkv/tiJYNrL0J+GJARCBYjPCqoJor5aoSQ1pdiF6/lIqLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721113606; c=relaxed/simple;
	bh=vXOwryw8xFilYtSz3kn5Q6Fzz0ZLgIL7zHdOIhDwPk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+zhkhOJwI0hMO2H+DOJljSd+bGfO7GojpEjkL31YhVPfAwJvtSmWSRXWQSTUqIdgIuy8aX7CxYGAqlSCEe9Lb/IpUYYVNBGILRZnveiTfjW24FsrDFNWNi3iz0SBZgqoQH2fLPNos+8UYswo3WIVmVM1akz4EbtUTedfh9Pl+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sTcGO-0005NF-D9; Tue, 16 Jul 2024 09:06:16 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sTcGN-0004bT-IL; Tue, 16 Jul 2024 09:06:15 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 21FA9304E11;
	Tue, 16 Jul 2024 07:06:15 +0000 (UTC)
Date: Tue, 16 Jul 2024 09:06:14 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	haibo.chen@nxp.com, imx@lists.linux.dev, han.xu@nxp.com
Subject: Re: [PATCH v2 4/4] can: flexcan: add wakeup support for imx95
Message-ID: <20240716-curious-scorpion-of-glory-8265aa-mkl@pengutronix.de>
References: <20240715-flexcan-v2-0-2873014c595a@nxp.com>
 <20240715-flexcan-v2-4-2873014c595a@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wmxdadf3ku3zl7ae"
Content-Disposition: inline
In-Reply-To: <20240715-flexcan-v2-4-2873014c595a@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--wmxdadf3ku3zl7ae
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.07.2024 17:27:23, Frank Li wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>=20
> iMX95 defines a bit in GPR that sets/unsets the IPG_STOP signal to the
> FlexCAN module, controlling its entry into STOP mode. Wakeup should work
> even if FlexCAN is in STOP mode.
>=20
> Due to iMX95 architecture design, the A-Core cannot access GPR; only the
> system manager (SM) can configure GPR. To support the wakeup feature,
> follow these steps:
>=20
> - For suspend:
>   1) During Linux suspend, when CAN suspends, do nothing for GPR and keep
>      CAN-related clocks on.
>   2) In ATF, check whether CAN needs to support wakeup; if yes, send a
>      request to SM through the SCMI protocol.
>   3) In SM, configure the GPR and unset IPG_STOP.
>   4) A-Core suspends.
>=20
> - For wakeup and resume:
>   1) A-Core wakeup event arrives.
>   2) In SM, deassert IPG_STOP.
>   3) Linux resumes.
>=20
> Add a new fsl_imx95_devtype_data and FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI to
> reflect this.
>=20
> Reviewed-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/net/can/flexcan/flexcan-core.c | 49 ++++++++++++++++++++++++++++=
++----
>  drivers/net/can/flexcan/flexcan.h      |  2 ++
>  2 files changed, 46 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index f6e609c388d55..fe972d5b8fbe0 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -354,6 +354,14 @@ static struct flexcan_devtype_data fsl_imx93_devtype=
_data =3D {
>  		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
>  };
> =20
> +static const struct flexcan_devtype_data fsl_imx95_devtype_data =3D {
> +	.quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS=
 |
> +		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
> +		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI |
> +		FLEXCAN_QUIRK_SUPPORT_FD | FLEXCAN_QUIRK_SUPPORT_ECC |
> +		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
> +		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,

Please keep the flags sorted by their value.

> +};

Please add a newline here.

>  static const struct flexcan_devtype_data fsl_vf610_devtype_data =3D {
>  	.quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS=
 |
>  		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
> @@ -548,6 +556,13 @@ static inline int flexcan_enter_stop_mode(struct fle=
xcan_priv *priv)
>  	} else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_GP=
R) {
>  		regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
>  				   1 << priv->stm.req_bit, 1 << priv->stm.req_bit);
> +	} else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SC=
MI) {
> +		/* For the SCMI mode, driver do nothing, ATF will send request to
> +		 * SM(system manager, M33 core) through SCMI protocol after linux
> +		 * suspend. Once SM get this request, it will send IPG_STOP signal
> +		 * to Flex_CAN, let CAN in STOP mode.
> +		 */
> +		return 0;
>  	}
> =20
>  	return flexcan_low_power_enter_ack(priv);
> @@ -559,7 +574,11 @@ static inline int flexcan_exit_stop_mode(struct flex=
can_priv *priv)
>  	u32 reg_mcr;
>  	int ret;
> =20
> -	/* remove stop request */
> +	/* Remove stop request, for FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI,
> +	 * do nothing here, because ATF already send request to SM before
> +	 * linux resume. Once SM get this request, it will deassert the
> +	 * IPG_STOP signal to Flex_CAN.
> +	 */
>  	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCFW) {
>  		ret =3D flexcan_stop_mode_enable_scfw(priv, false);
>  		if (ret < 0)
> @@ -1987,6 +2006,9 @@ static int flexcan_setup_stop_mode(struct platform_=
device *pdev)
>  		ret =3D flexcan_setup_stop_mode_scfw(pdev);
>  	else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR)
>  		ret =3D flexcan_setup_stop_mode_gpr(pdev);
> +	else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI)
> +		/* ATF will handle all STOP_IPG related work */
> +		ret =3D 0;
>  	else
>  		/* return 0 directly if doesn't support stop mode feature */
>  		return 0;
> @@ -2013,6 +2035,7 @@ static const struct of_device_id flexcan_of_match[]=
 =3D {
>  	{ .compatible =3D "fsl,imx8qm-flexcan", .data =3D &fsl_imx8qm_devtype_d=
ata, },
>  	{ .compatible =3D "fsl,imx8mp-flexcan", .data =3D &fsl_imx8mp_devtype_d=
ata, },
>  	{ .compatible =3D "fsl,imx93-flexcan", .data =3D &fsl_imx93_devtype_dat=
a, },
> +	{ .compatible =3D "fsl,imx95-flexcan", .data =3D &fsl_imx95_devtype_dat=
a, },
>  	{ .compatible =3D "fsl,imx6q-flexcan", .data =3D &fsl_imx6q_devtype_dat=
a, },
>  	{ .compatible =3D "fsl,imx28-flexcan", .data =3D &fsl_imx28_devtype_dat=
a, },
>  	{ .compatible =3D "fsl,imx53-flexcan", .data =3D &fsl_imx25_devtype_dat=
a, },
> @@ -2311,9 +2334,22 @@ static int __maybe_unused flexcan_noirq_suspend(st=
ruct device *device)
>  	if (netif_running(dev)) {
>  		int err;
> =20
> -		if (device_may_wakeup(device))
> +		if (device_may_wakeup(device)) {
>  			flexcan_enable_wakeup_irq(priv, true);
> =20
> +			/* For FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI, it need
                                                                      needs
> +			 * ATF to send request to SM through SCMI protocol,
> +			 * SM will assert the IPG_STOP signal. But all this
> +			 * works need the CAN clocks keep on.
> +			 * After the CAN module get the IPG_STOP mode, and
                                                gets
> +			 * switch to STOP mode, whether still keep the CAN
                           switches
> +			 * clocks on or gate them off depend on the Hardware
> +			 * design.
> +			 */
> +			if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI)
> +				return 0;
> +		}
> +
>  		err =3D pm_runtime_force_suspend(device);
>  		if (err)
>  			return err;
> @@ -2330,9 +2366,12 @@ static int __maybe_unused flexcan_noirq_resume(str=
uct device *device)
>  	if (netif_running(dev)) {
>  		int err;
> =20
> -		err =3D pm_runtime_force_resume(device);
> -		if (err)
> -			return err;
> +		if (!(device_may_wakeup(device) &&
                      ^^^^^^^^^^^^^^^^^^^^^^^^

Where does this come from?

> +		      priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI))=
 {
> +			err =3D pm_runtime_force_resume(device);
> +			if (err)
> +				return err;
> +		}
> =20
>  		if (device_may_wakeup(device))
>  			flexcan_enable_wakeup_irq(priv, false);
> diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/=
flexcan.h
> index 025c3417031f4..4933d8c7439e6 100644
> --- a/drivers/net/can/flexcan/flexcan.h
> +++ b/drivers/net/can/flexcan/flexcan.h
> @@ -68,6 +68,8 @@
>  #define FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR BIT(15)
>  /* Device supports RX via FIFO */
>  #define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
> +/* Setup stop mode with ATF SCMI protocol to support wakeup */
> +#define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI BIT(17)
> =20
>  struct flexcan_devtype_data {
>  	u32 quirks;		/* quirks needed for different IP cores */
>=20
> --=20
> 2.34.1
>=20
>=20

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wmxdadf3ku3zl7ae
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmaWG+QACgkQKDiiPnot
vG/hgAgAnxXnqQEsWJcE8q1cfm4Zhwb71ljBgIGlUXzUDlWT21EwarfgDf+/IBf8
xwgpDBaU/CuA9qwuuHXDkKJMIcTdsOhxkQs+jcQ2EKDAF9tLCJbjx9ceJdfHUF2c
MYECj51MHZ9qyMrxMuxlhN266gDMsD9sIeEGcZmCSy2RTDayan7NLSnXIIJGcTK1
QQn++HXrKBzTOi53qnyf20K0lCIS/yLQfbsgxigSuHTeS8SlpTYeOl/NBbqnfyLL
bhMcmSuFWKYGMpTIy9rnZo7aKZEyAK40Jjg6gKx8qFoJS44Ye9lhPDPBoIQRfkQo
JmhoFgMXnDsQptl0ppxMIbI1WsBIGQ==
=p1co
-----END PGP SIGNATURE-----

--wmxdadf3ku3zl7ae--

