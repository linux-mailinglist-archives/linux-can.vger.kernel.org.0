Return-Path: <linux-can+bounces-5394-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 454E7C5C9F0
	for <lists+linux-can@lfdr.de>; Fri, 14 Nov 2025 11:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38F8A4FA961
	for <lists+linux-can@lfdr.de>; Fri, 14 Nov 2025 10:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2C2311972;
	Fri, 14 Nov 2025 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="E9BigyW4"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m1973180.qiye.163.com (mail-m1973180.qiye.163.com [220.197.31.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E947311958;
	Fri, 14 Nov 2025 10:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763116294; cv=none; b=gS2c/9TPixSuVCzCeki4QO+emdDfFBl6GpIKS0/MENoNu0SvO7AvTdmGhKSncB+qmCEkYvG3dxGivxe4ivhAymHZcvCyo7mcJyKuhSKsyDBtYbgqTNmKTa8K4UDQ5P52c9jcHcYPlzhCnB5eAmmDzZ0uHS+C47ccAXGotlHKku8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763116294; c=relaxed/simple;
	bh=x7OKsgPTN8aY0D12CuEV0o11Cf3CoDwiAZ4Zocf5wbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CR533GmjOfuMvT9wGqOgmzvzbSWX8ekA3JFnfetvOQvk1iBEpNPXpulwhPpQcUrb7VIhGVnJ7n7h9DSGxvccturRDu1GIdEDvHhXToRT0cjEHTjEooEpRZqpdcAneuGhEhXMBDPZstfR2FwQCHhzTa9eZJ6xdopqLZFwDZXCTuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=E9BigyW4; arc=none smtp.client-ip=220.197.31.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.211] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 299aa9770;
	Fri, 14 Nov 2025 17:55:53 +0800 (GMT+08:00)
Message-ID: <176d96b4-397c-49d4-8e8e-2f77a5d59c12@rock-chips.com>
Date: Fri, 14 Nov 2025 17:55:53 +0800
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/3] net: can: rockchip: add can for RK3576 Soc
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, mailhol.vincent@wanadoo.fr, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, cl@rock-chips.com,
 linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20251113075419.482940-1-zhangqing@rock-chips.com>
 <20251113075419.482940-4-zhangqing@rock-chips.com>
 <20251113-slim-foamy-gecko-2dc389-mkl@pengutronix.de>
From: zhangqing <zhangqing@rock-chips.com>
In-Reply-To: <20251113-slim-foamy-gecko-2dc389-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a81caf75303a3kunm754e4e01ab942
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkodSVZKT01LGUJLH0hJTkhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=E9BigyW4qeTMXU3Ax0P2tOALVbpscmM8wzj++v5UrWphsXNBXd9xCu7wdaO1NsdnDFWKz4FPForSl7D+20QyZtGwRYNqLUn/HjXpei07blytsm5eQwH8uSkiW7sX3BzKlDLV2FwHS2J2YaSKHJIFSK4Z4lqkbId5w+AB9t+bmzk=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=PLrdQnPVm5ERSZuSEAAf2Q2VNrVo8P24q/oLJ4esLsI=;
	h=date:mime-version:subject:message-id:from;


在 2025/11/13 22:14, Marc Kleine-Budde 写道:
> On 13.11.2025 15:54:19, Elaine Zhang wrote:
>> Is new controller, new register layout and Bit position definition:
> Let's improve the patch description a bit. What about:
>
> The CAN FD cores in the rk3576 SoC are a newer revision than those in
> the rk3568. The main differences are:
>
> - changed register layout
> - different bit position
> - ...
>
> I remember:
> - time stamp register removed
>
> Please go through this list and remove everything that was unchanged and
> add it to the list I started above.
>
>> Support CAN protocol, ISO 11898-1
>> Support transmit or receive error count
>> Support acceptance filter, more functional
>> Support interrupt and all interrupt can be masked
>> Support error code check
>> Support self test\silent\loop-back mode
>> Support auto retransmission mode
>> Support auto bus on after bus-off state
>> Support 2 transmit buffers
>> Support Internal Storage Mode
>>
>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>> ---
>>   .../net/can/rockchip/rockchip_canfd-core.c    | 419 ++++++++++++++++++
>>   drivers/net/can/rockchip/rockchip_canfd-rx.c  | 103 +++++
>>   drivers/net/can/rockchip/rockchip_canfd-tx.c  |  20 +
>>   drivers/net/can/rockchip/rockchip_canfd.h     | 258 +++++++++++
>>   4 files changed, 800 insertions(+)
>>
>> diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
>> index 761cb36148ff..58fffcf97b20 100644
>> --- a/drivers/net/can/rockchip/rockchip_canfd-core.c
>> +++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
>> @@ -31,6 +31,8 @@ static const char *__rkcanfd_get_model_str(enum rkcanfd_model model)
>>   		return "rk3568v2";
>>   	case RKCANFD_MODEL_RK3568V3:
>>   		return "rk3568v3";
>> +	case RKCAN_MODEL_RK3576:
>> +		return "rk3576";
>>   	}
>>
>>   	return "<unknown>";
>> @@ -176,6 +178,27 @@ static void rkcanfd_get_berr_counter_corrected(struct rkcanfd_priv *priv,
>>   		    !!(reg_state & RKCANFD_REG_STATE_ERROR_WARNING_STATE));
>>   }
>>
>> +static void rk3576can_get_berr_counter_corrected(struct rkcanfd_priv *priv,
>> +						 struct can_berr_counter *bec)
>> +{
>> +	struct can_berr_counter bec_raw;
> You've removed the workaround handling for the berr_counter. This means
> your SoC is not affected by it. So the bec_raw and taking care of
> priv->bec is not needed.
>
>> +	u32 reg_state;
>> +
>> +	bec->rxerr = rkcanfd_read(priv, RK3576CAN_REG_RXERRORCNT);
>> +	bec->txerr = rkcanfd_read(priv, RK3576CAN_REG_TXERRORCNT);
>> +	bec_raw = *bec;
> remove, see above
>
>> +
>> +	priv->bec = *bec;
> remove, see above
>
>> +
>> +	reg_state = rkcanfd_read(priv, RKCANFD_REG_STATE);
>> +	netdev_vdbg(priv->ndev,
>> +		    "%s: Raw/Cor: txerr=%3u/%3u rxerr=%3u/%3u Bus Off=%u Warning=%u\n",
>> +		    __func__,
>> +		    bec_raw.txerr, bec->txerr, bec_raw.rxerr, bec->rxerr,
>> +		    !!(reg_state & RK3576CAN_REG_STATE_BUS_OFF_STATE),
>> +		    !!(reg_state & RK3576CAN_REG_STATE_ERROR_WARNING_STATE));
> I think the vdbg can be removed, if the IP core is not affected by the
> problem.
>
>> +}
>> +
>>   static int rkcanfd_get_berr_counter(const struct net_device *ndev,
>>   				    struct can_berr_counter *bec)
>>   {
>> @@ -206,6 +229,11 @@ static void rkcanfd_chip_interrupts_disable(const struct rkcanfd_priv *priv)
>>   	rkcanfd_write(priv, RKCANFD_REG_INT_MASK, RKCANFD_REG_INT_ALL);
>>   }
>>
>> +static void rk3576can_chip_interrupts_disable(const struct rkcanfd_priv *priv)
>> +{
>> +	rkcanfd_write(priv, RK3576CAN_REG_INT_MASK, RK3576CAN_REG_INT_ALL);
>> +}
>> +
>>   static void rkcanfd_chip_fifo_setup(struct rkcanfd_priv *priv)
>>   {
>>   	u32 reg;
>> @@ -220,6 +248,48 @@ static void rkcanfd_chip_fifo_setup(struct rkcanfd_priv *priv)
>>   	netdev_reset_queue(priv->ndev);
>>   }
>>
>> +static void rk3576can_chip_fifo_setup(struct rkcanfd_priv *priv)
>> +{
>> +	u32 reg_ism, reg_water;
>> +
>> +	reg_ism = FIELD_PREP(RK3576CAN_REG_STR_CTL_ISM_SEL,
>> +			     RK3576CAN_REG_STR_CTL_ISM_SEL_CANFD_FIXED) |
>> +		  RK3576CAN_REG_STR_CTL_STORAGE_TIMEOUT_MODE;
>> +	reg_water = RK3576CAN_ISM_WATERMASK_CANFD;
>> +
>> +	/* internal sram mode */
>> +	rkcanfd_write(priv, RK3576CAN_REG_STR_CTL, reg_ism);
>> +	rkcanfd_write(priv, RK3576CAN_REG_STR_WTM, reg_water);
>> +	WRITE_ONCE(priv->tx_head, 0);
>> +	WRITE_ONCE(priv->tx_tail, 0);
>> +	netdev_reset_queue(priv->ndev);
>> +}
>> +
>> +static void rk3576can_atf_config(struct rkcanfd_priv *priv, int mode)
>> +{
>> +	int i;
>> +
>> +	switch (mode) {
>> +	case RK3576CAN_REG_ATFM_MASK_SEL_MASK_MODE:
>> +		for (i = 0; i < 5; i++) {
>> +			rkcanfd_write(priv, RK3576CAN_REG_ATF(i), 0);
>> +			rkcanfd_write(priv, RK3576CAN_REG_ATFM(i), RK3576CAN_REG_ATFM_ID);
>> +		}
>> +		break;
>> +	case RK3576CAN_REG_ATFM_MASK_SEL_LIST_MODE:
>> +		for (i = 0; i < 5; i++) {
>> +			rkcanfd_write(priv, RK3576CAN_REG_ATF(i), 0);
>> +			rkcanfd_write(priv, RK3576CAN_REG_ATFM(i), RK3576CAN_REG_ATFM_MASK_SEL);
>> +		}
>> +		break;
>> +	default:
>> +		rkcanfd_write(priv, RK3576CAN_REG_ATF_CTL, RK3576CAN_REG_ATF_CTL_ATF_DIS_ALL);
>> +		return;
>> +	}
>> +
>> +	rkcanfd_write(priv, RK3576CAN_REG_ATF_CTL, 0);
>> +}
>> +
>>   static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
>>   {
>>   	u32 reg;
>> @@ -285,6 +355,61 @@ static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
>>   		   rkcanfd_read(priv, RKCANFD_REG_MODE));
>>   }
>>
>> +static void rk3576can_chip_start(struct rkcanfd_priv *priv)
>> +
>> +{
>> +	u32 reg;
>> +
>> +	rkcanfd_chip_set_reset_mode(priv);
>> +
>> +	/* Receiving Filter: accept all */
>> +	rk3576can_atf_config(priv, RK3576CAN_REG_ATFM_MASK_SEL_MASK_MODE);
>> +
>> +	/* enable:
>> +	 * - WORK_MODE: transition from reset to working mode
>> +	 */
>> +	reg = rkcanfd_read(priv, RKCANFD_REG_MODE);
>> +	priv->reg_mode_default = reg | RKCANFD_REG_MODE_WORK_MODE;
>> +
>> +	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
>> +		priv->reg_mode_default |= RKCANFD_REG_MODE_LBACK_MODE;
>> +		rkcanfd_write(priv, RK3576CAN_REG_ERROR_MASK,
>> +			      RK3576CAN_REG_ERROR_MASK_ACK_ERROR);
>> +	}
>> +
>> +	/* mask, i.e. ignore:
>> +	 * - RX_FINISH_INT - Rx finish interrupt
>> +	 */
>> +	priv->reg_int_mask_default = RK3576CAN_REG_INT_RX_FINISH_INT;
>> +
>> +	/* Do not mask the bus error interrupt if the bus error
>> +	 * reporting is requested.
>> +	 */
>> +	if (!(priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
>> +		priv->reg_int_mask_default |= RKCANFD_REG_INT_ERROR_INT;
>> +
>> +	memset(&priv->bec, 0x0, sizeof(priv->bec));
>> +
>> +	rk3576can_chip_fifo_setup(priv);
>> +
>> +	rkcanfd_write(priv, RK3576CAN_REG_AUTO_RETX_CFG,
>> +		      RK3576CAN_REG_AUTO_RETX_CFG_AUTO_RETX_EN);
>> +
>> +	rkcanfd_write(priv, RK3576CAN_REG_BRS_CFG,
>> +		      RK3576CAN_REG_BRS_CFG_BRS_NEGSYNC_EN |
>> +		      RK3576CAN_REG_BRS_CFG_BRS_POSSYNC_EN);
>> +
>> +	rkcanfd_set_bittiming(priv);
>> +
>> +	priv->devtype_data.interrupts_disable(priv);
>> +	rkcanfd_chip_set_work_mode(priv);
>> +
>> +	priv->can.state = CAN_STATE_ERROR_ACTIVE;
>> +
>> +	netdev_dbg(priv->ndev, "%s: reg_mode=0x%08x\n", __func__,
>> +		   rkcanfd_read(priv, RKCANFD_REG_MODE));
>> +}
>> +
>>   static void __rkcanfd_chip_stop(struct rkcanfd_priv *priv, const enum can_state state)
>>   {
>>   	priv->can.state = state;
>> @@ -301,6 +426,13 @@ static void rkcanfd_chip_stop(struct rkcanfd_priv *priv, const enum can_state st
>>   	__rkcanfd_chip_stop(priv, state);
>>   }
>>
>> +static void rk3576can_chip_stop(struct rkcanfd_priv *priv, const enum can_state state)
>> +{
>> +	priv->can.state = state;
>> +
>> +	__rkcanfd_chip_stop(priv, state);
>> +}
>> +
>>   static void rkcanfd_chip_stop_sync(struct rkcanfd_priv *priv, const enum can_state state)
>>   {
>>   	priv->can.state = state;
>> @@ -309,6 +441,13 @@ static void rkcanfd_chip_stop_sync(struct rkcanfd_priv *priv, const enum can_sta
>>   	__rkcanfd_chip_stop(priv, state);
>>   }
>>
>> +static void rk3576can_chip_stop_sync(struct rkcanfd_priv *priv, const enum can_state state)
>> +{
>> +	priv->can.state = state;
>> +
>> +	__rkcanfd_chip_stop(priv, state);
>> +}
>> +
>>   static int rkcanfd_set_mode(struct net_device *ndev,
>>   			    enum can_mode mode)
>>   {
>> @@ -364,6 +503,9 @@ static const char *rkcanfd_get_error_type_str(unsigned int type)
>>   #define RKCAN_ERROR_CODE(reg_ec, code) \
>>   	((reg_ec) & RKCANFD_REG_ERROR_CODE_##code ? __stringify(code) " " : "")
>>
>> +#define RK3576CAN_ERROR_CODE(reg_ec, code) \
>> +	((reg_ec) & RK3576CAN_REG_ERROR_CODE_##code ? __stringify(code) " " : "")
>> +
>>   static void
>>   rkcanfd_handle_error_int_reg_ec(struct rkcanfd_priv *priv, struct can_frame *cf,
>>   				const u32 reg_ec)
>> @@ -493,6 +635,128 @@ rkcanfd_handle_error_int_reg_ec(struct rkcanfd_priv *priv, struct can_frame *cf,
>>   	}
>>   }
>>
>> +static void
>> +rk3576can_handle_error_int_reg_ec(struct rkcanfd_priv *priv, struct can_frame *cf,
>> +				  const u32 reg_ec)
>> +{
>> +	struct net_device_stats *stats = &priv->ndev->stats;
>> +	unsigned int type;
>> +	u32 reg_state, reg_cmd;
>> +
>> +	type = FIELD_GET(RK3576CAN_REG_ERROR_CODE_TYPE, reg_ec);
>> +	reg_cmd = rkcanfd_read(priv, RK3576CAN_REG_CMD);
>> +	reg_state = rkcanfd_read(priv, RK3576CAN_REG_STATE);
>> +
>> +	netdev_dbg(priv->ndev, "%s Error in %s %s Phase: %s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s(0x%08x) CMD=%u RX=%u TX=%u Error-Warning=%u Bus-Off=%u\n",
>> +		   rkcanfd_get_error_type_str(type),
>> +		   reg_ec & RK3576CAN_REG_ERROR_CODE_DIRECTION_RX ? "RX" : "TX",
>> +		   reg_ec & RK3576CAN_REG_ERROR_CODE_PHASE ? "Data" : "Arbitration",
>> +		   RK3576CAN_ERROR_CODE(reg_ec, TX_ACK_EOF),
>> +		   RK3576CAN_ERROR_CODE(reg_ec, TX_CRC),
>> +		   RK3576CAN_ERROR_CODE(reg_ec, TX_STUFF_COUNT),
>> +		   RK3576CAN_ERROR_CODE(reg_ec, TX_DATA),
>> +		   RK3576CAN_ERROR_CODE(reg_ec, TX_SOF_DLC),
>> +		   RK3576CAN_ERROR_CODE(reg_ec, TX_IDLE),
>> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_ERROR),
>> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_OVERLOAD),
>> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_SPACE),
>> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_EOF),
>> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_ACK_LIM),
>> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_ACK),
>> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_CRC_LIM),
>> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_CRC),
>> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_STUFF_COUNT),
>> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_DATA),
>> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_DLC),
>> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_BRS_ESI),
>> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_RES),
>> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_FDF),
>> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_ID2_RTR),
>> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_SOF_IDE),
>> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_BUS_IDLE),
>> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_BUS_INT),
>> +		   RK3576CAN_ERROR_CODE(reg_ec, RX_STOP),
>> +		   reg_ec, reg_cmd,
>> +		   !!(reg_state & RK3576CAN_REG_STATE_RX_PERIOD),
>> +		   !!(reg_state & RK3576CAN_REG_STATE_TX_PERIOD),
>> +		   !!(reg_state & RK3576CAN_REG_STATE_ERROR_WARNING_STATE),
>> +		   !!(reg_state & RK3576CAN_REG_STATE_BUS_OFF_STATE));
>> +
>> +	priv->can.can_stats.bus_error++;
>> +
>> +	if (reg_ec & RK3576CAN_REG_ERROR_CODE_DIRECTION_RX)
>> +		stats->rx_errors++;
>> +	else
>> +		stats->tx_errors++;
>> +
>> +	if (!cf)
>> +		return;
>> +
>> +	if (reg_ec & RK3576CAN_REG_ERROR_CODE_DIRECTION_RX) {
>> +		if (reg_ec & RK3576CAN_REG_ERROR_CODE_RX_SOF_IDE)
>> +			cf->data[3] = CAN_ERR_PROT_LOC_SOF;
>> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_RX_ID2_RTR)
>> +			cf->data[3] = CAN_ERR_PROT_LOC_RTR;
>> +		/* RKCANFD_REG_ERROR_CODE_RX_FDF */
>> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_RX_RES)
>> +			cf->data[3] = CAN_ERR_PROT_LOC_RES0;
>> +		/* RKCANFD_REG_ERROR_CODE_RX_BRS_ESI */
>> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_RX_DLC)
>> +			cf->data[3] = CAN_ERR_PROT_LOC_DLC;
>> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_RX_DATA)
>> +			cf->data[3] = CAN_ERR_PROT_LOC_DATA;
>> +		/* RKCANFD_REG_ERROR_CODE_RX_STUFF_COUNT */
>> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_RX_CRC)
>> +			cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
>> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_RX_CRC_LIM)
>> +			cf->data[3] = CAN_ERR_PROT_LOC_ACK_DEL;
>> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_RX_ACK)
>> +			cf->data[3] = CAN_ERR_PROT_LOC_ACK;
>> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_RX_ACK_LIM)
>> +			cf->data[3] = CAN_ERR_PROT_LOC_ACK_DEL;
>> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_RX_EOF)
>> +			cf->data[3] = CAN_ERR_PROT_LOC_EOF;
>> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_RX_SPACE)
>> +			cf->data[3] = CAN_ERR_PROT_LOC_EOF;
>> +	} else {
>> +		cf->data[2] |= CAN_ERR_PROT_TX;
>> +
>> +		if (reg_ec & RK3576CAN_REG_ERROR_CODE_TX_SOF_DLC)
>> +			cf->data[3] = CAN_ERR_PROT_LOC_SOF;
>> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_TX_DATA)
>> +			cf->data[3] = CAN_ERR_PROT_LOC_DATA;
>> +		/* RKCANFD_REG_ERROR_CODE_TX_STUFF_COUNT */
>> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_TX_CRC)
>> +			cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
>> +		else if (reg_ec & RK3576CAN_REG_ERROR_CODE_TX_ACK_EOF)
>> +			cf->data[3] = CAN_ERR_PROT_LOC_ACK_DEL;
>> +	}
>> +
>> +	switch (reg_ec & RK3576CAN_REG_ERROR_CODE_TYPE) {
>> +	case FIELD_PREP_CONST(RK3576CAN_REG_ERROR_CODE_TYPE,
>> +			      RK3576CAN_REG_ERROR_CODE_TYPE_BIT):
>> +
>> +		cf->data[2] |= CAN_ERR_PROT_BIT;
>> +		break;
>> +	case FIELD_PREP_CONST(RK3576CAN_REG_ERROR_CODE_TYPE,
>> +			      RK3576CAN_REG_ERROR_CODE_TYPE_STUFF):
>> +		cf->data[2] |= CAN_ERR_PROT_STUFF;
>> +		break;
>> +	case FIELD_PREP_CONST(RK3576CAN_REG_ERROR_CODE_TYPE,
>> +			      RK3576CAN_REG_ERROR_CODE_TYPE_FORM):
>> +		cf->data[2] |= CAN_ERR_PROT_FORM;
>> +		break;
>> +	case FIELD_PREP_CONST(RK3576CAN_REG_ERROR_CODE_TYPE,
>> +			      RK3576CAN_REG_ERROR_CODE_TYPE_ACK):
>> +		cf->can_id |= CAN_ERR_ACK;
>> +		break;
>> +	case FIELD_PREP_CONST(RK3576CAN_REG_ERROR_CODE_TYPE,
>> +			      RK3576CAN_REG_ERROR_CODE_TYPE_CRC):
>> +		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
>> +		break;
>> +	}
>> +}
>> +
>>   static int rkcanfd_handle_error_int(struct rkcanfd_priv *priv)
>>   {
>>   	struct net_device_stats *stats = &priv->ndev->stats;
>> @@ -530,6 +794,41 @@ static int rkcanfd_handle_error_int(struct rkcanfd_priv *priv)
>>   	return 0;
>>   }
>>
>> +static int rkcanfd_handle_rk3576_error_int(struct rkcanfd_priv *priv)
>> +{
>> +	struct net_device_stats *stats = &priv->ndev->stats;
>> +	struct can_frame *cf = NULL;
>> +	u32 reg_ec;
>> +	struct sk_buff *skb;
>> +	int err;
>> +
>> +	reg_ec = rkcanfd_read(priv, RK3576CAN_REG_ERROR_CODE);
>> +	if (!reg_ec)
>> +		return 0;
>> +
>> +	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) {
>> +		skb = alloc_can_err_skb(priv->ndev, &cf);
>> +		if (cf) {
>> +			struct can_berr_counter bec;
>> +
>> +			priv->devtype_data.get_berr_counter(priv, &bec);
>> +			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR | CAN_ERR_CNT;
>> +			cf->data[6] = bec.txerr;
>> +			cf->data[7] = bec.rxerr;
>> +		}
>> +	}
>> +
>> +	rk3576can_handle_error_int_reg_ec(priv, cf, reg_ec);
>> +	if (!cf)
>> +		return 0;
>> +
>> +	err = can_rx_offload_queue_tail(&priv->offload, skb);
>> +	if (err)
>> +		stats->rx_fifo_errors++;
>> +
>> +	return 0;
>> +}
>> +
>>   static int rkcanfd_handle_state_error_int(struct rkcanfd_priv *priv)
>>   {
>>   	struct net_device_stats *stats = &priv->ndev->stats;
>> @@ -575,6 +874,50 @@ static int rkcanfd_handle_state_error_int(struct rkcanfd_priv *priv)
>>   	return 0;
>>   }
>>
>> +static int rkcanfd_handle_rk3576_state_error_int(struct rkcanfd_priv *priv)
>> +{
>> +	struct net_device_stats *stats = &priv->ndev->stats;
>> +	enum can_state new_state, rx_state, tx_state;
>> +	struct net_device *ndev = priv->ndev;
>> +	struct can_berr_counter bec;
>> +	struct can_frame *cf = NULL;
>> +	struct sk_buff *skb;
>> +	int err;
>> +
>> +	priv->devtype_data.get_berr_counter(priv, &bec);
> You're already in the rk3576 specific code.
>
>> +	can_state_get_by_berr_counter(ndev, &bec, &tx_state, &rx_state);
>> +
>> +	new_state = max(tx_state, rx_state);
>> +	if (new_state == priv->can.state)
>> +		return 0;
>> +
>> +	/* The skb allocation might fail, but can_change_state()
>> +	 * handles cf == NULL.
>> +	 */
>> +	skb = alloc_can_err_skb(priv->ndev, &cf);
>> +	can_change_state(ndev, cf, tx_state, rx_state);
>> +
>> +	if (new_state == CAN_STATE_BUS_OFF) {
>> +		priv->devtype_data.chip_stop(priv, CAN_STATE_BUS_OFF);
>> +		can_bus_off(ndev);
>> +	}
>> +
>> +	if (!skb)
>> +		return 0;
>> +
>> +	if (new_state != CAN_STATE_BUS_OFF) {
>> +		cf->can_id |= CAN_ERR_CNT;
>> +		cf->data[6] = bec.txerr;
>> +		cf->data[7] = bec.rxerr;
>> +	}
>> +
>> +	err = can_rx_offload_queue_tail(&priv->offload, skb);
>> +	if (err)
>> +		stats->rx_fifo_errors++;
>> +
>> +	return 0;
>> +}
>> +
>>   static int
>>   rkcanfd_handle_rx_fifo_overflow_int(struct rkcanfd_priv *priv)
>>   {
>> @@ -621,6 +964,55 @@ rkcanfd_handle_rx_fifo_overflow_int(struct rkcanfd_priv *priv)
>>   	err; \
>>   })
>>
>> +static irqreturn_t rk3576can_irq(int irq, void *dev_id)
>> +{
>> +	struct rkcanfd_priv *priv = dev_id;
>> +	u32 reg_int_unmasked, reg_int;
>> +
>> +	reg_int_unmasked = rkcanfd_read(priv, RK3576CAN_REG_INT);
>> +	reg_int = reg_int_unmasked & ~priv->reg_int_mask_default;
>> +
>> +	if (!reg_int)
>> +		return IRQ_NONE;
>> +
>> +	rkcanfd_write(priv, RK3576CAN_REG_INT, reg_int);
>> +
>> +	if (reg_int & (RK3576CAN_REG_INT_RXSTR_TIMEOUT_INT |
>> +		       RK3576CAN_REG_INT_ISM_WTM_INT |
>> +		       RK3576CAN_REG_INT_RX_FIFO_FULL_INT)) {
>> +		rkcanfd_write(priv, RK3576CAN_REG_INT_MASK,
>> +			      priv->reg_int_mask_default | RK3576CAN_REG_INT_ISM_WTM_INT |
>> +			      RK3576CAN_REG_INT_RXSTR_TIMEOUT_INT |
>> +			      RK3576CAN_REG_INT_RX_FINISH_INT);
>> +		rkcanfd_handle(priv, rk3576_rx_int);
>> +	}
>> +
>> +	if (reg_int & RK3576CAN_REG_INT_TX_FINISH_INT)
>> +		rkcanfd_handle(priv, rk3576_tx_int);
>> +
>> +	if (reg_int & RK3576CAN_REG_INT_ERROR_INT)
>> +		rkcanfd_handle(priv, rk3576_error_int);
>> +
>> +	if (reg_int & (RK3576CAN_REG_INT_BUS_OFF_INT |
>> +		       RK3576CAN_REG_INT_PASSIVE_ERROR_INT |
>> +		       RK3576CAN_REG_INT_ERROR_WARNING_INT) ||
>> +	    priv->can.state > CAN_STATE_ERROR_ACTIVE)
>> +		rkcanfd_handle(priv, rk3576_state_error_int);
>> +
>> +	if (reg_int & RK3576CAN_REG_INT_WAKEUP_INT)
>> +		netdev_info(priv->ndev, "%s: WAKEUP_INT\n", __func__);
>> +
>> +	if (reg_int & RK3576CAN_REG_INT_BUS_OFF_RECOVERY_INT)
>> +		netdev_info(priv->ndev, "%s: BUS_OFF_RECOVERY_INT\n", __func__);
>> +
>> +	if (reg_int & RK3576CAN_REG_INT_OVERLOAD_INT)
>> +		netdev_info(priv->ndev, "%s: OVERLOAD_INT\n", __func__);
>> +
>> +	can_rx_offload_irq_finish(&priv->offload);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>>   static irqreturn_t rkcanfd_irq(int irq, void *dev_id)
>>   {
>>   	struct rkcanfd_priv *priv = dev_id;
>> @@ -775,6 +1167,16 @@ static void rkcanfd_register_done(const struct rkcanfd_priv *priv)
>>   			    RKCANFD_ERRATUM_5_SYSCLOCK_HZ_MIN / MEGA);
>>   }
>>
>> +static void rk3576can_register_done(const struct rkcanfd_priv *priv)
>> +{
>> +	u32 dev_id;
>> +
>> +	dev_id = rkcanfd_read(priv, RK3576CAN_REG_RTL_VERSION);
>> +	netdev_info(priv->ndev,
>> +		    "Rockchip-CANFD %s rev%u.\n",
>> +		    rkcanfd_get_model_str(priv), dev_id);
> Please also print the activated errata.
>
>> +}
>> +
>>   static int rkcanfd_register(struct rkcanfd_priv *priv)
>>   {
>>   	struct net_device *ndev = priv->ndev;
>> @@ -856,6 +1258,20 @@ static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v3 = {
>>   	.register_done = rkcanfd_register_done,
>>   };
>>
>> +/* The rk3576 CAN-FD */
>> +static const struct rkcanfd_devtype_data rkcan_devtype_data_rk3576 = {
>> +	.model = RKCAN_MODEL_RK3576,
>> +	.quirks = RKCANFD_QUIRK_CANFD_BROKEN,
> Is CAN-FD mode broken on the rk3576?
>
> Please test CAN-FD and please do the tests documented near the
> definition of RKCANFD_QUIRK_CANFD_BROKEN:
>
> | Tests on the rk3568v2 and rk3568v3 show that receiving certain
> | CAN-FD frames trigger an Error Interrupt.
> |
> | - Form Error in RX Arbitration Phase: TX_IDLE RX_STUFF_COUNT (0x0a010100) CMD=0 RX=0 TX=0
> |   Error-Warning=1 Bus-Off=0
> |   To reproduce:
> |   host:
> |     cansend can0 002##01f
> |   DUT:
> |     candump any,0:0,#FFFFFFFF -cexdHtA
> |
> | - Form Error in RX Arbitration Phase: TX_IDLE RX_CRC (0x0a010200) CMD=0 RX=0 TX=0
> |   Error-Warning=1 Bus-Off=0
> |   To reproduce:
> |   host:
> |     cansend can0 002##07217010000000000
> |   DUT:
> |     candump any,0:0,#FFFFFFFF -cexdHtA
There is no doubt about the other modifications above. They will be 
corrected in version V10.

CANFD requires authorization and is not supported by default.
After obtaining authorization, it can be used, so this place is not 
considered broken.
What's the best way to handle this situation?
>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

-- 
张晴
瑞芯微电子股份有限公司
Rockchip Electronics Co.,Ltd
地址：福建省福州市铜盘路软件大道89号软件园A区21号楼
Add:No.21 Building, A District, No.89 Software Boulevard Fuzhou, Fujian 350003, P.R.China
Tel:+86-0591-83991906-8601
邮编：350003
E-mail:elaine.zhang@rock-chips.com
****************************************************************************
保密提示：本邮件及其附件含有机密信息，仅发送给本邮件所指特定收件人。若非该特定收件人，请勿复制、使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件或其他方式即刻告知发件人。福州瑞芯微电子有限公司拥有本邮件信息的著作权及解释权，禁止任何未经授权许可的侵权行为。

IMPORTANT NOTICE: This email is from Fuzhou Rockchip Electronics Co., Ltd .The contents of this email and any attachments may contain information that is privileged, confidential and/or exempt from disclosure under applicable law and relevant NDA. If you are not the intended recipient, you are hereby notified that any disclosure, copying, distribution, or use of the information is STRICTLY PROHIBITED. Please immediately contact the sender as soon as possible and destroy the material in its entirety in any format. Thank you.

****************************************************************************


