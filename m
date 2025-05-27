Return-Path: <linux-can+bounces-3693-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C20AC4DBB
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 13:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87BD78A07E8
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 11:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA7A25D91C;
	Tue, 27 May 2025 11:37:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D842586FE
	for <linux-can@vger.kernel.org>; Tue, 27 May 2025 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748345852; cv=none; b=lyAoodWtcGWhtJECj8VBc2eGsve9VKyB0QQFXF7jh8cs1zS9GglZqd4Vcr4kBb8VffvbQRsf9zzoaDL2+8w+j7PrkISj6G4qdEjtrWCLj+9GDVCfvdbbsSPLXOVdkm8Ph+BaIo9c1YUuiRzkO2qWt0l+m2hnULg1yCqaMaHdPkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748345852; c=relaxed/simple;
	bh=lFkT+5/G0QzkQCrHD/MZR2cgD5qBXMfmgDOLXrIwqpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0jyDyEqjRbIQzhBROCl/9vagEzU0p/Hny1wTUaZ3jLUzooimSnAndSEcj4qCUMHCJvthdB6N3lOFmDUsDCeA1Li/izN3YAY8fU2zx4vDPJZKVdU5Szyc+Q75kcdSnsxh7bRfL+XUgDr2jWmBEj/NLl1mypCgakp/d/9dKneoZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uJscK-0006US-6f; Tue, 27 May 2025 13:37:12 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uJscI-000PZg-1p;
	Tue, 27 May 2025 13:37:10 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3364C41A77F;
	Tue, 27 May 2025 11:37:10 +0000 (UTC)
Date: Tue, 27 May 2025 13:37:09 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: kernel@pengutronix.de, mailhol.vincent@wanadoo.fr, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, cl@rock-chips.com, 
	kever.yang@rock-chips.com, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 3/4] net: can: rockchip: add can for RK3576 Soc
Message-ID: <20250527-sage-python-of-variation-1c7759-mkl@pengutronix.de>
References: <20250526062559.2061311-1-zhangqing@rock-chips.com>
 <20250526062559.2061311-4-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wm5rma25slqeowsj"
Content-Disposition: inline
In-Reply-To: <20250526062559.2061311-4-zhangqing@rock-chips.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--wm5rma25slqeowsj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 3/4] net: can: rockchip: add can for RK3576 Soc
MIME-Version: 1.0

Hey,

here's a partial review.

On 26.05.2025 14:25:58, Elaine Zhang wrote:
> Is new controller, new register layout and Bit position definition:
> Support CAN and CANFD protocol, ISO 11898-1
> Support transmit or receive error count
> Support acceptance filter, more functional
> Support interrupt and all interrupt can be masked
> Support error code check
> Support self test\silent\loop-back mode
> Support auto retransmission mode
> Support auto bus on after bus-off state
> Support 2 transmit buffers
> Support Internal Storage Mode
> Support DMA
>=20
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../net/can/rockchip/rockchip_canfd-core.c    | 453 ++++++++++++++++++
>  drivers/net/can/rockchip/rockchip_canfd-rx.c  | 111 +++++
>  drivers/net/can/rockchip/rockchip_canfd-tx.c  |  27 ++
>  drivers/net/can/rockchip/rockchip_canfd.h     | 267 +++++++++++
>  4 files changed, 858 insertions(+)
>=20
> diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net=
/can/rockchip/rockchip_canfd-core.c
> index c21ca4c1fb9a..92e260cb2527 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-core.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
> @@ -31,6 +31,8 @@ static const char *__rkcanfd_get_model_str(enum rkcanfd=
_model model)
>  		return "rk3568v2";
>  	case RKCANFD_MODEL_RK3568V3:
>  		return "rk3568v3";
> +	case RKCANFD_MODEL_RK3576:
> +		return "rk3576";
>  	}
> =20
>  	return "<unknown>";
> @@ -176,6 +178,30 @@ static void rkcanfd_get_berr_counter_corrected(struc=
t rkcanfd_priv *priv,
>  		    !!(reg_state & RKCANFD_REG_STATE_ERROR_WARNING_STATE));
>  }
> =20
> +static void rk3576canfd_get_berr_counter_corrected(struct rkcanfd_priv *=
priv,
> +						   struct can_berr_counter *bec)
> +{

Is the rk3576 affected by this problem?

> +	struct can_berr_counter bec_raw;
> +	u32 reg_state;
> +
> +	bec->rxerr =3D rkcanfd_read(priv, RK3576CANFD_REG_RXERRORCNT);
> +	bec->txerr =3D rkcanfd_read(priv, RK3576CANFD_REG_TXERRORCNT);
> +	bec_raw =3D *bec;
> +
> +	if (!bec->rxerr && !bec->txerr)
> +		*bec =3D priv->bec;
> +	else
> +		priv->bec =3D *bec;
> +
> +	reg_state =3D rkcanfd_read(priv, RKCANFD_REG_STATE);
> +	netdev_vdbg(priv->ndev,
> +		    "%s: Raw/Cor: txerr=3D%3u/%3u rxerr=3D%3u/%3u Bus Off=3D%u Warning=
=3D%u\n",
> +		    __func__,
> +		    bec_raw.txerr, bec->txerr, bec_raw.rxerr, bec->rxerr,
> +		    !!(reg_state & RK3576CANFD_REG_STATE_BUS_OFF_STATE),
> +		    !!(reg_state & RK3576CANFD_REG_STATE_ERROR_WARNING_STATE));
> +}
> +
>  static int rkcanfd_get_berr_counter(const struct net_device *ndev,
>  				    struct can_berr_counter *bec)
>  {
> @@ -206,6 +232,11 @@ static void rkcanfd_chip_interrupts_disable(const st=
ruct rkcanfd_priv *priv)
>  	rkcanfd_write(priv, RKCANFD_REG_INT_MASK, RKCANFD_REG_INT_ALL);
>  }
> =20
> +static void rk3576canfd_chip_interrupts_disable(const struct rkcanfd_pri=
v *priv)
> +{
> +	rkcanfd_write(priv, RK3576CANFD_REG_INT_MASK, RK3576CANFD_REG_INT_ALL);
> +}
> +
>  static void rkcanfd_chip_fifo_setup(struct rkcanfd_priv *priv)
>  {
>  	u32 reg;
> @@ -220,6 +251,72 @@ static void rkcanfd_chip_fifo_setup(struct rkcanfd_p=
riv *priv)
>  	netdev_reset_queue(priv->ndev);
>  }
> =20
> +static void rk3576canfd_chip_fifo_setup(struct rkcanfd_priv *priv)
> +{
> +	u32 ism =3D 0, water =3D 0;

no need to init as 0

> +
> +	ism =3D RK3576CANFD_REG_STR_CTL_ISM_SEL_CANFD_FIXED;
> +	water =3D RK3576CANFD_ISM_WATERMASK_CANFD;
> +
> +	/* internal sram mode */

personally I would prefer:

reg_ism =3D FIELD_PREP(RK3576CANFD_REG_STR_CTL_ISM_SEL,
                    RK3576CANFD_REG_STR_CTL_ISM_SEL_CANFD_FIXED) |
          RK3576CANFD_REG_STR_CTL_STORAGE_TIMEOUT_MODE;

> +	rkcanfd_write(priv, RK3576CANFD_REG_STR_CTL,
> +		      (FIELD_PREP(RK3576CANFD_REG_STR_CTL_ISM_SEL, ism) |
> +		      RK3576CANFD_REG_STR_CTL_STORAGE_TIMEOUT_MODE));

reg_water =3D RK3576CANFD_ISM_WATERMASK_CANFD;

> +	rkcanfd_write(priv, RK3576CANFD_REG_STR_WTM, water);
> +	WRITE_ONCE(priv->tx_head, 0);
> +	WRITE_ONCE(priv->tx_tail, 0);
> +	netdev_reset_queue(priv->ndev);
> +}
> +
> +static int rk3576canfd_atf_config(struct rkcanfd_priv *priv, int mode)

With the proposed cleanup, this will become a void function.

> +{
> +	u32 id[10] =3D {0};

What's the use of this array?

> +	u32 dlc =3D 0, dlc_over =3D 0;
> +
> +	switch (mode) {

It's called with RK3576CANFD_REG_ATFM_MASK_SEL_MASK_MODE only...

> +	case RK3576CANFD_REG_ATFM_MASK_SEL_MASK_MODE:
> +		rkcanfd_write(priv, RK3576CANFD_REG_ATF0, id[0]);

why not call it with 0x0?

> +		rkcanfd_write(priv, RK3576CANFD_REG_ATF1, id[1]);

create:

#define RK3576CANFD_REG_ATF(n) (0x700 + (n) << 2)

and use a for loop

> +		rkcanfd_write(priv, RK3576CANFD_REG_ATF2, id[2]);
> +		rkcanfd_write(priv, RK3576CANFD_REG_ATF3, id[3]);
> +		rkcanfd_write(priv, RK3576CANFD_REG_ATF4, id[4]);
> +		rkcanfd_write(priv, RK3576CANFD_REG_ATFM0, RK3576CANFD_REG_ATFM_ID);
> +		rkcanfd_write(priv, RK3576CANFD_REG_ATFM1, RK3576CANFD_REG_ATFM_ID);
> +		rkcanfd_write(priv, RK3576CANFD_REG_ATFM2, RK3576CANFD_REG_ATFM_ID);
> +		rkcanfd_write(priv, RK3576CANFD_REG_ATFM3, RK3576CANFD_REG_ATFM_ID);
> +		rkcanfd_write(priv, RK3576CANFD_REG_ATFM4, RK3576CANFD_REG_ATFM_ID);
> +		break;
> +	case RK3576CANFD_REG_ATFM_MASK_SEL_LIST_MODE:
> +		rkcanfd_write(priv, RK3576CANFD_REG_ATF0, id[0]);
> +		rkcanfd_write(priv, RK3576CANFD_REG_ATF1, id[1]);
> +		rkcanfd_write(priv, RK3576CANFD_REG_ATF2, id[2]);
> +		rkcanfd_write(priv, RK3576CANFD_REG_ATF3, id[3]);
> +		rkcanfd_write(priv, RK3576CANFD_REG_ATF4, id[4]);
> +		rkcanfd_write(priv, RK3576CANFD_REG_ATFM0, id[5] | RK3576CANFD_REG_ATF=
M_MASK_SEL);
> +		rkcanfd_write(priv, RK3576CANFD_REG_ATFM1, id[6] | RK3576CANFD_REG_ATF=
M_MASK_SEL);
> +		rkcanfd_write(priv, RK3576CANFD_REG_ATFM2, id[7] | RK3576CANFD_REG_ATF=
M_MASK_SEL);
> +		rkcanfd_write(priv, RK3576CANFD_REG_ATFM3, id[8] | RK3576CANFD_REG_ATF=
M_MASK_SEL);
> +		rkcanfd_write(priv, RK3576CANFD_REG_ATFM4, id[9] | RK3576CANFD_REG_ATF=
M_MASK_SEL);
> +		break;
> +	default:
> +		rkcanfd_write(priv, RK3576CANFD_REG_ATF_CTL, RK3576CANFD_REG_ATF_CTL_A=
TF_DIS_ALL);
> +		return -EINVAL;
> +	}
> +
> +	if (dlc) {
> +		if (dlc_over)

both are 0, please remove the dead code

> +			rkcanfd_write(priv, RK3576CANFD_REG_ATF_DLC,
> +				      dlc | RK3576CANFD_REG_ATF_DLC_ATF_DLC_EN);
> +		else
> +			rkcanfd_write(priv, RK3576CANFD_REG_ATF_DLC,
> +				      dlc | RK3576CANFD_REG_ATF_DLC_ATF_DLC_EN |
> +				      RK3576CANFD_REG_ATF_DLC_ATF_DLC_MODE);
> +	}
> +	rkcanfd_write(priv, RK3576CANFD_REG_ATF_CTL, 0);
> +
> +	return 0;
> +}
> +
>  static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
>  {
>  	u32 reg;
> @@ -285,6 +382,68 @@ static void rkcanfd_chip_start(struct rkcanfd_priv *=
priv)
>  		   rkcanfd_read(priv, RKCANFD_REG_MODE));
>  }
> =20
> +static void rk3576canfd_chip_start(struct rkcanfd_priv *priv)
> +
> +{
> +	u32 reg;
> +
> +	rkcanfd_chip_set_reset_mode(priv);
> +
> +	/* Receiving Filter: accept all */
> +	rk3576canfd_atf_config(priv, RK3576CANFD_REG_ATFM_MASK_SEL_MASK_MODE);
> +
> +	/* enable:
> +	 * - CAN_FD: enable CAN-FD
> +	 * - AUTO_RETX_MODE: auto retransmission on TX error
> +	 * - COVER_MODE: RX-FIFO overwrite mode, do not send OVERLOAD frames
> +	 * - RXSTX_MODE: Receive Self Transmit data mode
> +	 * - WORK_MODE: transition from reset to working mode
> +	 */

please adjust the comments

> +	reg =3D rkcanfd_read(priv, RKCANFD_REG_MODE);
> +	priv->reg_mode_default =3D reg | RKCANFD_REG_MODE_WORK_MODE;
> +
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
> +		priv->reg_mode_default |=3D RKCANFD_REG_MODE_LBACK_MODE;
> +		rkcanfd_write(priv, RK3576CANFD_REG_ERROR_MASK,
> +			      RK3576CANFD_REG_ERROR_MASK_ACK_ERROR);
> +	}
> +
> +	/* mask, i.e. ignore:
> +	 * - TIMESTAMP_COUNTER_OVERFLOW_INT - timestamp counter overflow interr=
upt
> +	 * - TX_ARBIT_FAIL_INT - TX arbitration fail interrupt
> +	 * - OVERLOAD_INT - CAN bus overload interrupt
> +	 * - TX_FINISH_INT - Transmit finish interrupt
> +	 */
> +	priv->reg_int_mask_default =3D RK3576CANFD_REG_INT_RX_FINISH_INT;

please adjust the comments

> +
> +	/* Do not mask the bus error interrupt if the bus error
> +	 * reporting is requested.
> +	 */
> +	if (!(priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
> +		priv->reg_int_mask_default |=3D RKCANFD_REG_INT_ERROR_INT;
> +
> +	memset(&priv->bec, 0x0, sizeof(priv->bec));
> +
> +	priv->devtype_data.fifo_setup(priv);

Why do you need a callback here? You're already know you're a
rk3576canfd, here.

> +
> +	rkcanfd_write(priv, RK3576CANFD_REG_AUTO_RETX_CFG,
> +		      RK3576CANFD_REG_AUTO_RETX_CFG_AUTO_RETX_EN);
> +
> +	rkcanfd_write(priv, RK3576CANFD_REG_BRS_CFG,
> +		      RK3576CANFD_REG_BRS_CFG_BRS_NEGSYNC_EN |
> +		      RK3576CANFD_REG_BRS_CFG_BRS_POSSYNC_EN);
> +
> +	rkcanfd_set_bittiming(priv);
> +
> +	priv->devtype_data.interrupts_disable(priv);
> +	rkcanfd_chip_set_work_mode(priv);
> +
> +	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +
> +	netdev_dbg(priv->ndev, "%s: reg_mode=3D0x%08x\n", __func__,
> +		   rkcanfd_read(priv, RKCANFD_REG_MODE));
> +}
> +

more later...

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wm5rma25slqeowsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmg1o+IACgkQDHRl3/mQ
kZwlcAgAp0JdNemXDYJQP2NtGDnnNFQoPnjeNpkF+YvkXizqgIxjzLfewpIZf3Be
MA2WfFN/ewOwBAX7TrBfWAoCiRqc4mdHlupNO5VrKflNq4cQXRkbSoB9Q2xl3SQX
VFTUeyJDd5i/N1kGYa8iXDVQ5I3T9eNjlCmKqP9PwrXkQHAyKlfu17u1nW7Uf4GS
h8ebrFhb5FlTtanZY5+GL7Qlngg0lEaYdqcvOx0JyepgNugewSmTcWf1QSUnwx7h
bQF4IoVm12zELwQRPalBgC2qX/nwXeZKOi1i4GTzVMZvqqPSba7JOMYgnCNZagK3
AHtBIhG91hPtC0ykR3IYV3LbR3SWcg==
=wAW9
-----END PGP SIGNATURE-----

--wm5rma25slqeowsj--

