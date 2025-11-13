Return-Path: <linux-can+bounces-5388-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDE3C57EEF
	for <lists+linux-can@lfdr.de>; Thu, 13 Nov 2025 15:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3F7421B1C
	for <lists+linux-can@lfdr.de>; Thu, 13 Nov 2025 14:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC1A2857F0;
	Thu, 13 Nov 2025 14:15:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536AA27A904
	for <linux-can@vger.kernel.org>; Thu, 13 Nov 2025 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763043322; cv=none; b=UUHv+Tyb9rGfcAVH25u6dz2YA3+PIcOWE7JxZ+khOHxoYLsMn7/4mglnslR/Ri+c6iGlmSTmdOmTV9bA82PGWAEJ89rueFaZbALmWfUACoGmnn/YeUOyJwmxgJySRqazUnmo1Am7umICwHfeQ4KKuqrhxLz754jWwVN1W2hrxi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763043322; c=relaxed/simple;
	bh=JB9XYuo4SRf4Y/rFsT0WYAWTYg3VD/jpmrkkvKVbVoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsKdjcKO+BAui2qvSGB2Vvx2virRa7lm86F0PrUlEROVLw/u7Ii2sgcsZFqS0B4a3z7s4kDayh8+AQkTaCrj5o07T8zHXxnVsYI0PPgk/N5BsrgEsbQ0+buy66bfmJoSvYj6ynWjs8fsuYZgxL+b1QL9VkL66aYBjLxRco0zXhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJY6G-0000bK-2i; Thu, 13 Nov 2025 15:15:00 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJY6E-000GpE-0d;
	Thu, 13 Nov 2025 15:14:58 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D0BB849EB2B;
	Thu, 13 Nov 2025 14:14:57 +0000 (UTC)
Date: Thu, 13 Nov 2025 15:14:56 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: kernel@pengutronix.de, mailhol.vincent@wanadoo.fr, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, cl@rock-chips.com, 
	linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v9 3/3] net: can: rockchip: add can for RK3576 Soc
Message-ID: <20251113-slim-foamy-gecko-2dc389-mkl@pengutronix.de>
References: <20251113075419.482940-1-zhangqing@rock-chips.com>
 <20251113075419.482940-4-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fdgezdn3owk5oz7x"
Content-Disposition: inline
In-Reply-To: <20251113075419.482940-4-zhangqing@rock-chips.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--fdgezdn3owk5oz7x
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 3/3] net: can: rockchip: add can for RK3576 Soc
MIME-Version: 1.0

On 13.11.2025 15:54:19, Elaine Zhang wrote:
> Is new controller, new register layout and Bit position definition:

Let's improve the patch description a bit. What about:

The CAN FD cores in the rk3576 SoC are a newer revision than those in
the rk3568. The main differences are:

- changed register layout
- different bit position
- ...

I remember:
- time stamp register removed

Please go through this list and remove everything that was unchanged and
add it to the list I started above.

> Support CAN protocol, ISO 11898-1
> Support transmit or receive error count
> Support acceptance filter, more functional
> Support interrupt and all interrupt can be masked
> Support error code check
> Support self test\silent\loop-back mode
> Support auto retransmission mode
> Support auto bus on after bus-off state
> Support 2 transmit buffers
> Support Internal Storage Mode
>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../net/can/rockchip/rockchip_canfd-core.c    | 419 ++++++++++++++++++
>  drivers/net/can/rockchip/rockchip_canfd-rx.c  | 103 +++++
>  drivers/net/can/rockchip/rockchip_canfd-tx.c  |  20 +
>  drivers/net/can/rockchip/rockchip_canfd.h     | 258 +++++++++++
>  4 files changed, 800 insertions(+)
>
> diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net=
/can/rockchip/rockchip_canfd-core.c
> index 761cb36148ff..58fffcf97b20 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-core.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
> @@ -31,6 +31,8 @@ static const char *__rkcanfd_get_model_str(enum rkcanfd=
_model model)
>  		return "rk3568v2";
>  	case RKCANFD_MODEL_RK3568V3:
>  		return "rk3568v3";
> +	case RKCAN_MODEL_RK3576:
> +		return "rk3576";
>  	}
>
>  	return "<unknown>";
> @@ -176,6 +178,27 @@ static void rkcanfd_get_berr_counter_corrected(struc=
t rkcanfd_priv *priv,
>  		    !!(reg_state & RKCANFD_REG_STATE_ERROR_WARNING_STATE));
>  }
>
> +static void rk3576can_get_berr_counter_corrected(struct rkcanfd_priv *pr=
iv,
> +						 struct can_berr_counter *bec)
> +{
> +	struct can_berr_counter bec_raw;

You've removed the workaround handling for the berr_counter. This means
your SoC is not affected by it. So the bec_raw and taking care of
priv->bec is not needed.

> +	u32 reg_state;
> +
> +	bec->rxerr =3D rkcanfd_read(priv, RK3576CAN_REG_RXERRORCNT);
> +	bec->txerr =3D rkcanfd_read(priv, RK3576CAN_REG_TXERRORCNT);

> +	bec_raw =3D *bec;
remove, see above

> +
> +	priv->bec =3D *bec;

remove, see above

> +
> +	reg_state =3D rkcanfd_read(priv, RKCANFD_REG_STATE);
> +	netdev_vdbg(priv->ndev,
> +		    "%s: Raw/Cor: txerr=3D%3u/%3u rxerr=3D%3u/%3u Bus Off=3D%u Warning=
=3D%u\n",
> +		    __func__,
> +		    bec_raw.txerr, bec->txerr, bec_raw.rxerr, bec->rxerr,
> +		    !!(reg_state & RK3576CAN_REG_STATE_BUS_OFF_STATE),
> +		    !!(reg_state & RK3576CAN_REG_STATE_ERROR_WARNING_STATE));

I think the vdbg can be removed, if the IP core is not affected by the
problem.

> +}
> +
>  static int rkcanfd_get_berr_counter(const struct net_device *ndev,
>  				    struct can_berr_counter *bec)
>  {
> @@ -206,6 +229,11 @@ static void rkcanfd_chip_interrupts_disable(const st=
ruct rkcanfd_priv *priv)
>  	rkcanfd_write(priv, RKCANFD_REG_INT_MASK, RKCANFD_REG_INT_ALL);
>  }
>
> +static void rk3576can_chip_interrupts_disable(const struct rkcanfd_priv =
*priv)
> +{
> +	rkcanfd_write(priv, RK3576CAN_REG_INT_MASK, RK3576CAN_REG_INT_ALL);
> +}
> +
>  static void rkcanfd_chip_fifo_setup(struct rkcanfd_priv *priv)
>  {
>  	u32 reg;
> @@ -220,6 +248,48 @@ static void rkcanfd_chip_fifo_setup(struct rkcanfd_p=
riv *priv)
>  	netdev_reset_queue(priv->ndev);
>  }
>
> +static void rk3576can_chip_fifo_setup(struct rkcanfd_priv *priv)
> +{
> +	u32 reg_ism, reg_water;
> +
> +	reg_ism =3D FIELD_PREP(RK3576CAN_REG_STR_CTL_ISM_SEL,
> +			     RK3576CAN_REG_STR_CTL_ISM_SEL_CANFD_FIXED) |
> +		  RK3576CAN_REG_STR_CTL_STORAGE_TIMEOUT_MODE;
> +	reg_water =3D RK3576CAN_ISM_WATERMASK_CANFD;
> +
> +	/* internal sram mode */
> +	rkcanfd_write(priv, RK3576CAN_REG_STR_CTL, reg_ism);
> +	rkcanfd_write(priv, RK3576CAN_REG_STR_WTM, reg_water);
> +	WRITE_ONCE(priv->tx_head, 0);
> +	WRITE_ONCE(priv->tx_tail, 0);
> +	netdev_reset_queue(priv->ndev);
> +}
> +
> +static void rk3576can_atf_config(struct rkcanfd_priv *priv, int mode)
> +{
> +	int i;
> +
> +	switch (mode) {
> +	case RK3576CAN_REG_ATFM_MASK_SEL_MASK_MODE:
> +		for (i =3D 0; i < 5; i++) {
> +			rkcanfd_write(priv, RK3576CAN_REG_ATF(i), 0);
> +			rkcanfd_write(priv, RK3576CAN_REG_ATFM(i), RK3576CAN_REG_ATFM_ID);
> +		}
> +		break;
> +	case RK3576CAN_REG_ATFM_MASK_SEL_LIST_MODE:
> +		for (i =3D 0; i < 5; i++) {
> +			rkcanfd_write(priv, RK3576CAN_REG_ATF(i), 0);
> +			rkcanfd_write(priv, RK3576CAN_REG_ATFM(i), RK3576CAN_REG_ATFM_MASK_SE=
L);
> +		}
> +		break;
> +	default:
> +		rkcanfd_write(priv, RK3576CAN_REG_ATF_CTL, RK3576CAN_REG_ATF_CTL_ATF_D=
IS_ALL);
> +		return;
> +	}
> +
> +	rkcanfd_write(priv, RK3576CAN_REG_ATF_CTL, 0);
> +}
> +
>  static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
>  {
>  	u32 reg;
> @@ -285,6 +355,61 @@ static void rkcanfd_chip_start(struct rkcanfd_priv *=
priv)
>  		   rkcanfd_read(priv, RKCANFD_REG_MODE));
>  }
>
> +static void rk3576can_chip_start(struct rkcanfd_priv *priv)
> +
> +{
> +	u32 reg;
> +
> +	rkcanfd_chip_set_reset_mode(priv);
> +
> +	/* Receiving Filter: accept all */
> +	rk3576can_atf_config(priv, RK3576CAN_REG_ATFM_MASK_SEL_MASK_MODE);
> +
> +	/* enable:
> +	 * - WORK_MODE: transition from reset to working mode
> +	 */
> +	reg =3D rkcanfd_read(priv, RKCANFD_REG_MODE);
> +	priv->reg_mode_default =3D reg | RKCANFD_REG_MODE_WORK_MODE;
> +
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
> +		priv->reg_mode_default |=3D RKCANFD_REG_MODE_LBACK_MODE;
> +		rkcanfd_write(priv, RK3576CAN_REG_ERROR_MASK,
> +			      RK3576CAN_REG_ERROR_MASK_ACK_ERROR);
> +	}
> +
> +	/* mask, i.e. ignore:
> +	 * - RX_FINISH_INT - Rx finish interrupt
> +	 */
> +	priv->reg_int_mask_default =3D RK3576CAN_REG_INT_RX_FINISH_INT;
> +
> +	/* Do not mask the bus error interrupt if the bus error
> +	 * reporting is requested.
> +	 */
> +	if (!(priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
> +		priv->reg_int_mask_default |=3D RKCANFD_REG_INT_ERROR_INT;
> +
> +	memset(&priv->bec, 0x0, sizeof(priv->bec));
> +
> +	rk3576can_chip_fifo_setup(priv);
> +
> +	rkcanfd_write(priv, RK3576CAN_REG_AUTO_RETX_CFG,
> +		      RK3576CAN_REG_AUTO_RETX_CFG_AUTO_RETX_EN);
> +
> +	rkcanfd_write(priv, RK3576CAN_REG_BRS_CFG,
> +		      RK3576CAN_REG_BRS_CFG_BRS_NEGSYNC_EN |
> +		      RK3576CAN_REG_BRS_CFG_BRS_POSSYNC_EN);
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
>  static void __rkcanfd_chip_stop(struct rkcanfd_priv *priv, const enum ca=
n_state state)
>  {
>  	priv->can.state =3D state;
> @@ -301,6 +426,13 @@ static void rkcanfd_chip_stop(struct rkcanfd_priv *p=
riv, const enum can_state st
>  	__rkcanfd_chip_stop(priv, state);
>  }
>
> +static void rk3576can_chip_stop(struct rkcanfd_priv *priv, const enum ca=
n_state state)
> +{
> +	priv->can.state =3D state;
> +
> +	__rkcanfd_chip_stop(priv, state);
> +}
> +
>  static void rkcanfd_chip_stop_sync(struct rkcanfd_priv *priv, const enum=
 can_state state)
>  {
>  	priv->can.state =3D state;
> @@ -309,6 +441,13 @@ static void rkcanfd_chip_stop_sync(struct rkcanfd_pr=
iv *priv, const enum can_sta
>  	__rkcanfd_chip_stop(priv, state);
>  }
>
> +static void rk3576can_chip_stop_sync(struct rkcanfd_priv *priv, const en=
um can_state state)
> +{
> +	priv->can.state =3D state;
> +
> +	__rkcanfd_chip_stop(priv, state);
> +}
> +
>  static int rkcanfd_set_mode(struct net_device *ndev,
>  			    enum can_mode mode)
>  {
> @@ -364,6 +503,9 @@ static const char *rkcanfd_get_error_type_str(unsigne=
d int type)
>  #define RKCAN_ERROR_CODE(reg_ec, code) \
>  	((reg_ec) & RKCANFD_REG_ERROR_CODE_##code ? __stringify(code) " " : "")
>
> +#define RK3576CAN_ERROR_CODE(reg_ec, code) \
> +	((reg_ec) & RK3576CAN_REG_ERROR_CODE_##code ? __stringify(code) " " : "=
")
> +
>  static void
>  rkcanfd_handle_error_int_reg_ec(struct rkcanfd_priv *priv, struct can_fr=
ame *cf,
>  				const u32 reg_ec)
> @@ -493,6 +635,128 @@ rkcanfd_handle_error_int_reg_ec(struct rkcanfd_priv=
 *priv, struct can_frame *cf,
>  	}
>  }
>
> +static void
> +rk3576can_handle_error_int_reg_ec(struct rkcanfd_priv *priv, struct can_=
frame *cf,
> +				  const u32 reg_ec)
> +{
> +	struct net_device_stats *stats =3D &priv->ndev->stats;
> +	unsigned int type;
> +	u32 reg_state, reg_cmd;
> +
> +	type =3D FIELD_GET(RK3576CAN_REG_ERROR_CODE_TYPE, reg_ec);
> +	reg_cmd =3D rkcanfd_read(priv, RK3576CAN_REG_CMD);
> +	reg_state =3D rkcanfd_read(priv, RK3576CAN_REG_STATE);
> +
> +	netdev_dbg(priv->ndev, "%s Error in %s %s Phase: %s%s%s%s%s%s%s%s%s%s%s=
%s%s%s%s%s%s%s%s%s%s%s%s%s%s(0x%08x) CMD=3D%u RX=3D%u TX=3D%u Error-Warning=
=3D%u Bus-Off=3D%u\n",
> +		   rkcanfd_get_error_type_str(type),
> +		   reg_ec & RK3576CAN_REG_ERROR_CODE_DIRECTION_RX ? "RX" : "TX",
> +		   reg_ec & RK3576CAN_REG_ERROR_CODE_PHASE ? "Data" : "Arbitration",
> +		   RK3576CAN_ERROR_CODE(reg_ec, TX_ACK_EOF),
> +		   RK3576CAN_ERROR_CODE(reg_ec, TX_CRC),
> +		   RK3576CAN_ERROR_CODE(reg_ec, TX_STUFF_COUNT),
> +		   RK3576CAN_ERROR_CODE(reg_ec, TX_DATA),
> +		   RK3576CAN_ERROR_CODE(reg_ec, TX_SOF_DLC),
> +		   RK3576CAN_ERROR_CODE(reg_ec, TX_IDLE),
> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_ERROR),
> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_OVERLOAD),
> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_SPACE),
> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_EOF),
> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_ACK_LIM),
> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_ACK),
> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_CRC_LIM),
> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_CRC),
> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_STUFF_COUNT),
> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_DATA),
> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_DLC),
> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_BRS_ESI),
> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_RES),
> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_FDF),
> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_ID2_RTR),
> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_SOF_IDE),
> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_BUS_IDLE),
> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_BUS_INT),
> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_STOP),
> +		   reg_ec, reg_cmd,
> +		   !!(reg_state & RK3576CAN_REG_STATE_RX_PERIOD),
> +		   !!(reg_state & RK3576CAN_REG_STATE_TX_PERIOD),
> +		   !!(reg_state & RK3576CAN_REG_STATE_ERROR_WARNING_STATE),
> +		   !!(reg_state & RK3576CAN_REG_STATE_BUS_OFF_STATE));
> +
> +	priv->can.can_stats.bus_error++;
> +
> +	if (reg_ec & RK3576CAN_REG_ERROR_CODE_DIRECTION_RX)
> +		stats->rx_errors++;
> +	else
> +		stats->tx_errors++;
> +
> +	if (!cf)
> +		return;
> +
> +	if (reg_ec & RK3576CAN_REG_ERROR_CODE_DIRECTION_RX) {
> +		if (reg_ec & RK3576CAN_REG_ERROR_CODE_RX_SOF_IDE)
> +			cf->data[3] =3D CAN_ERR_PROT_LOC_SOF;
> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_RX_ID2_RTR)
> +			cf->data[3] =3D CAN_ERR_PROT_LOC_RTR;
> +		/* RKCANFD_REG_ERROR_CODE_RX_FDF */
> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_RX_RES)
> +			cf->data[3] =3D CAN_ERR_PROT_LOC_RES0;
> +		/* RKCANFD_REG_ERROR_CODE_RX_BRS_ESI */
> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_RX_DLC)
> +			cf->data[3] =3D CAN_ERR_PROT_LOC_DLC;
> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_RX_DATA)
> +			cf->data[3] =3D CAN_ERR_PROT_LOC_DATA;
> +		/* RKCANFD_REG_ERROR_CODE_RX_STUFF_COUNT */
> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_RX_CRC)
> +			cf->data[3] =3D CAN_ERR_PROT_LOC_CRC_SEQ;
> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_RX_CRC_LIM)
> +			cf->data[3] =3D CAN_ERR_PROT_LOC_ACK_DEL;
> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_RX_ACK)
> +			cf->data[3] =3D CAN_ERR_PROT_LOC_ACK;
> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_RX_ACK_LIM)
> +			cf->data[3] =3D CAN_ERR_PROT_LOC_ACK_DEL;
> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_RX_EOF)
> +			cf->data[3] =3D CAN_ERR_PROT_LOC_EOF;
> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_RX_SPACE)
> +			cf->data[3] =3D CAN_ERR_PROT_LOC_EOF;
> +	} else {
> +		cf->data[2] |=3D CAN_ERR_PROT_TX;
> +
> +		if (reg_ec & RK3576CAN_REG_ERROR_CODE_TX_SOF_DLC)
> +			cf->data[3] =3D CAN_ERR_PROT_LOC_SOF;
> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_TX_DATA)
> +			cf->data[3] =3D CAN_ERR_PROT_LOC_DATA;
> +		/* RKCANFD_REG_ERROR_CODE_TX_STUFF_COUNT */
> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_TX_CRC)
> +			cf->data[3] =3D CAN_ERR_PROT_LOC_CRC_SEQ;
> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_TX_ACK_EOF)
> +			cf->data[3] =3D CAN_ERR_PROT_LOC_ACK_DEL;
> +	}
> +
> +	switch (reg_ec & RK3576CAN_REG_ERROR_CODE_TYPE) {
> +	case FIELD_PREP_CONST(RK3576CAN_REG_ERROR_CODE_TYPE,
> +			      RK3576CAN_REG_ERROR_CODE_TYPE_BIT):
> +
> +		cf->data[2] |=3D CAN_ERR_PROT_BIT;
> +		break;
> +	case FIELD_PREP_CONST(RK3576CAN_REG_ERROR_CODE_TYPE,
> +			      RK3576CAN_REG_ERROR_CODE_TYPE_STUFF):
> +		cf->data[2] |=3D CAN_ERR_PROT_STUFF;
> +		break;
> +	case FIELD_PREP_CONST(RK3576CAN_REG_ERROR_CODE_TYPE,
> +			      RK3576CAN_REG_ERROR_CODE_TYPE_FORM):
> +		cf->data[2] |=3D CAN_ERR_PROT_FORM;
> +		break;
> +	case FIELD_PREP_CONST(RK3576CAN_REG_ERROR_CODE_TYPE,
> +			      RK3576CAN_REG_ERROR_CODE_TYPE_ACK):
> +		cf->can_id |=3D CAN_ERR_ACK;
> +		break;
> +	case FIELD_PREP_CONST(RK3576CAN_REG_ERROR_CODE_TYPE,
> +			      RK3576CAN_REG_ERROR_CODE_TYPE_CRC):
> +		cf->data[3] =3D CAN_ERR_PROT_LOC_CRC_SEQ;
> +		break;
> +	}
> +}
> +
>  static int rkcanfd_handle_error_int(struct rkcanfd_priv *priv)
>  {
>  	struct net_device_stats *stats =3D &priv->ndev->stats;
> @@ -530,6 +794,41 @@ static int rkcanfd_handle_error_int(struct rkcanfd_p=
riv *priv)
>  	return 0;
>  }
>
> +static int rkcanfd_handle_rk3576_error_int(struct rkcanfd_priv *priv)
> +{
> +	struct net_device_stats *stats =3D &priv->ndev->stats;
> +	struct can_frame *cf =3D NULL;
> +	u32 reg_ec;
> +	struct sk_buff *skb;
> +	int err;
> +
> +	reg_ec =3D rkcanfd_read(priv, RK3576CAN_REG_ERROR_CODE);
> +	if (!reg_ec)
> +		return 0;
> +
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) {
> +		skb =3D alloc_can_err_skb(priv->ndev, &cf);
> +		if (cf) {
> +			struct can_berr_counter bec;
> +
> +			priv->devtype_data.get_berr_counter(priv, &bec);
> +			cf->can_id |=3D CAN_ERR_PROT | CAN_ERR_BUSERROR | CAN_ERR_CNT;
> +			cf->data[6] =3D bec.txerr;
> +			cf->data[7] =3D bec.rxerr;
> +		}
> +	}
> +
> +	rk3576can_handle_error_int_reg_ec(priv, cf, reg_ec);
> +	if (!cf)
> +		return 0;
> +
> +	err =3D can_rx_offload_queue_tail(&priv->offload, skb);
> +	if (err)
> +		stats->rx_fifo_errors++;
> +
> +	return 0;
> +}
> +
>  static int rkcanfd_handle_state_error_int(struct rkcanfd_priv *priv)
>  {
>  	struct net_device_stats *stats =3D &priv->ndev->stats;
> @@ -575,6 +874,50 @@ static int rkcanfd_handle_state_error_int(struct rkc=
anfd_priv *priv)
>  	return 0;
>  }
>
> +static int rkcanfd_handle_rk3576_state_error_int(struct rkcanfd_priv *pr=
iv)
> +{
> +	struct net_device_stats *stats =3D &priv->ndev->stats;
> +	enum can_state new_state, rx_state, tx_state;
> +	struct net_device *ndev =3D priv->ndev;
> +	struct can_berr_counter bec;
> +	struct can_frame *cf =3D NULL;
> +	struct sk_buff *skb;
> +	int err;
> +
> +	priv->devtype_data.get_berr_counter(priv, &bec);

You're already in the rk3576 specific code.

> +	can_state_get_by_berr_counter(ndev, &bec, &tx_state, &rx_state);
> +
> +	new_state =3D max(tx_state, rx_state);
> +	if (new_state =3D=3D priv->can.state)
> +		return 0;
> +
> +	/* The skb allocation might fail, but can_change_state()
> +	 * handles cf =3D=3D NULL.
> +	 */
> +	skb =3D alloc_can_err_skb(priv->ndev, &cf);
> +	can_change_state(ndev, cf, tx_state, rx_state);
> +
> +	if (new_state =3D=3D CAN_STATE_BUS_OFF) {
> +		priv->devtype_data.chip_stop(priv, CAN_STATE_BUS_OFF);
> +		can_bus_off(ndev);
> +	}
> +
> +	if (!skb)
> +		return 0;
> +
> +	if (new_state !=3D CAN_STATE_BUS_OFF) {
> +		cf->can_id |=3D CAN_ERR_CNT;
> +		cf->data[6] =3D bec.txerr;
> +		cf->data[7] =3D bec.rxerr;
> +	}
> +
> +	err =3D can_rx_offload_queue_tail(&priv->offload, skb);
> +	if (err)
> +		stats->rx_fifo_errors++;
> +
> +	return 0;
> +}
> +
>  static int
>  rkcanfd_handle_rx_fifo_overflow_int(struct rkcanfd_priv *priv)
>  {
> @@ -621,6 +964,55 @@ rkcanfd_handle_rx_fifo_overflow_int(struct rkcanfd_p=
riv *priv)
>  	err; \
>  })
>
> +static irqreturn_t rk3576can_irq(int irq, void *dev_id)
> +{
> +	struct rkcanfd_priv *priv =3D dev_id;
> +	u32 reg_int_unmasked, reg_int;
> +
> +	reg_int_unmasked =3D rkcanfd_read(priv, RK3576CAN_REG_INT);
> +	reg_int =3D reg_int_unmasked & ~priv->reg_int_mask_default;
> +
> +	if (!reg_int)
> +		return IRQ_NONE;
> +
> +	rkcanfd_write(priv, RK3576CAN_REG_INT, reg_int);
> +
> +	if (reg_int & (RK3576CAN_REG_INT_RXSTR_TIMEOUT_INT |
> +		       RK3576CAN_REG_INT_ISM_WTM_INT |
> +		       RK3576CAN_REG_INT_RX_FIFO_FULL_INT)) {
> +		rkcanfd_write(priv, RK3576CAN_REG_INT_MASK,
> +			      priv->reg_int_mask_default | RK3576CAN_REG_INT_ISM_WTM_INT |
> +			      RK3576CAN_REG_INT_RXSTR_TIMEOUT_INT |
> +			      RK3576CAN_REG_INT_RX_FINISH_INT);
> +		rkcanfd_handle(priv, rk3576_rx_int);
> +	}
> +
> +	if (reg_int & RK3576CAN_REG_INT_TX_FINISH_INT)
> +		rkcanfd_handle(priv, rk3576_tx_int);
> +
> +	if (reg_int & RK3576CAN_REG_INT_ERROR_INT)
> +		rkcanfd_handle(priv, rk3576_error_int);
> +
> +	if (reg_int & (RK3576CAN_REG_INT_BUS_OFF_INT |
> +		       RK3576CAN_REG_INT_PASSIVE_ERROR_INT |
> +		       RK3576CAN_REG_INT_ERROR_WARNING_INT) ||
> +	    priv->can.state > CAN_STATE_ERROR_ACTIVE)
> +		rkcanfd_handle(priv, rk3576_state_error_int);
> +
> +	if (reg_int & RK3576CAN_REG_INT_WAKEUP_INT)
> +		netdev_info(priv->ndev, "%s: WAKEUP_INT\n", __func__);
> +
> +	if (reg_int & RK3576CAN_REG_INT_BUS_OFF_RECOVERY_INT)
> +		netdev_info(priv->ndev, "%s: BUS_OFF_RECOVERY_INT\n", __func__);
> +
> +	if (reg_int & RK3576CAN_REG_INT_OVERLOAD_INT)
> +		netdev_info(priv->ndev, "%s: OVERLOAD_INT\n", __func__);
> +
> +	can_rx_offload_irq_finish(&priv->offload);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static irqreturn_t rkcanfd_irq(int irq, void *dev_id)
>  {
>  	struct rkcanfd_priv *priv =3D dev_id;
> @@ -775,6 +1167,16 @@ static void rkcanfd_register_done(const struct rkca=
nfd_priv *priv)
>  			    RKCANFD_ERRATUM_5_SYSCLOCK_HZ_MIN / MEGA);
>  }
>
> +static void rk3576can_register_done(const struct rkcanfd_priv *priv)
> +{
> +	u32 dev_id;
> +
> +	dev_id =3D rkcanfd_read(priv, RK3576CAN_REG_RTL_VERSION);
> +	netdev_info(priv->ndev,
> +		    "Rockchip-CANFD %s rev%u.\n",
> +		    rkcanfd_get_model_str(priv), dev_id);

Please also print the activated errata.

> +}
> +
>  static int rkcanfd_register(struct rkcanfd_priv *priv)
>  {
>  	struct net_device *ndev =3D priv->ndev;
> @@ -856,6 +1258,20 @@ static const struct rkcanfd_devtype_data rkcanfd_de=
vtype_data_rk3568v3 =3D {
>  	.register_done =3D rkcanfd_register_done,
>  };
>
> +/* The rk3576 CAN-FD */
> +static const struct rkcanfd_devtype_data rkcan_devtype_data_rk3576 =3D {
> +	.model =3D RKCAN_MODEL_RK3576,
> +	.quirks =3D RKCANFD_QUIRK_CANFD_BROKEN,

Is CAN-FD mode broken on the rk3576?

Please test CAN-FD and please do the tests documented near the
definition of RKCANFD_QUIRK_CANFD_BROKEN:

| Tests on the rk3568v2 and rk3568v3 show that receiving certain
| CAN-FD frames trigger an Error Interrupt.
|
| - Form Error in RX Arbitration Phase: TX_IDLE RX_STUFF_COUNT (0x0a010100)=
 CMD=3D0 RX=3D0 TX=3D0
|   Error-Warning=3D1 Bus-Off=3D0
|   To reproduce:
|   host:
|     cansend can0 002##01f
|   DUT:
|     candump any,0:0,#FFFFFFFF -cexdHtA
|
| - Form Error in RX Arbitration Phase: TX_IDLE RX_CRC (0x0a010200) CMD=3D0=
 RX=3D0 TX=3D0
|   Error-Warning=3D1 Bus-Off=3D0
|   To reproduce:
|   host:
|     cansend can0 002##07217010000000000
|   DUT:
|     candump any,0:0,#FFFFFFFF -cexdHtA

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--fdgezdn3owk5oz7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkV590ACgkQDHRl3/mQ
kZwXxgf/QFI0uqBWxPBqTIwX85rKIzjXtfoVbNQSzhZe/cFsspkhKUdWEYoogUu1
8cCyYjdrdH1HKfyn8LFTd+sMd4cXUUlPQ7edt/3oeS5hE5Qwi5hUOVMq8wp60qvJ
AFoUx+eN0+OC9fdxseqdJwtJosj6Yj0hW26GyXCaXmXAlzwrWLmi4FWtJkrpMZqK
7k6EWncOxYOL/XzLdUdNt+tLiSKIKpk7PwkPi3CV3afqWsgmF/UON8oQ1qlXq7OO
B+j1dRzvUTZC7TMA3aIPasAP7EKS8EnDtO5eFvgtrcpfVpWQK4vBfbNZD+q1jusv
cXBj05rBGuMGElTfe12UVuw7GvqmtQ==
=Qh/y
-----END PGP SIGNATURE-----

--fdgezdn3owk5oz7x--

