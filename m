Return-Path: <linux-can+bounces-4779-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C398B8F8DE
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 10:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC7918920F8
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 08:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C8427A47C;
	Mon, 22 Sep 2025 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="A11sAmnA"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m19731107.qiye.163.com (mail-m19731107.qiye.163.com [220.197.31.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD61279DB5;
	Mon, 22 Sep 2025 08:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529898; cv=none; b=rHBifuqmk4oRjzR9qWZDdIuADTksqdij3dMO4shHAK0FRDAKw7oJTRbTnm7ei7XMY8RbjUq1NBsLfu6xEacHZQbTlzRKvgNvwFNXwHY0/bcydruYkczr3isyCLY1WR9pAzs3xwQGZ15j3a1gxahvc6JYR2x6H0EmM4WytWoUmVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529898; c=relaxed/simple;
	bh=JGNcnlpVMEcfv0PGjNAMGkvzaRzphKcQe+zZ8DqfGeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m2rifkF2aneM0GwV5/Exa+Tk+SEXCF+HwFy+SNmuSkEZ8zPt1weym+qjQ72H5RiEKhlaqd3MC55SKU872F1Wx/Doa+/Gk4qVmZtaS+d1MbDfJFLPKLnIJnOJGIaz+1wrzV8CRILWSEPV4/McV5SAcau5LV+tsA1TnwU8CnKkD5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=A11sAmnA; arc=none smtp.client-ip=220.197.31.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 239b62ab7;
	Mon, 22 Sep 2025 15:15:50 +0800 (GMT+08:00)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: zhangqing@rock-chips.com,
	mkl@pengutronix.de,
	kernel@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	cl@rock-chips.com,
	kever.yang@rock-chips.com
Cc: linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v7 3/4] net: can: rockchip: add can for RK3576 Soc
Date: Mon, 22 Sep 2025 15:15:42 +0800
Message-Id: <20250922071543.73923-4-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250922071543.73923-1-zhangqing@rock-chips.com>
References: <20250922071543.73923-1-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a997047616e03a3kunm864fae2f231632
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0NCTVZLH0JKGk9PTRoYHUlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=A11sAmnAevV7Sk+nN7hvTHvPFvgcG+5JDf1k9gRfChOLd+UJpAJIBirD9n3awyjMKD1Ct+oZNaKFbw5OJKm1ovYFyBjpBd0vHgibUKJYW65XXfxzwOs3qHQkP5xwg2gglkZv56wSZy3u6h182AcGaVQFmImxJiBab0gbuoWgSV8=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=v1twWALCq/zj+iMDHa6WDmBLlnPVr3gA6gQmbLJrgTU=;
	h=date:mime-version:subject:message-id:from;

Is new controller, new register layout and Bit position definition:
Support CAN and CANFD protocol, ISO 11898-1
Support transmit or receive error count
Support acceptance filter, more functional
Support interrupt and all interrupt can be masked
Support error code check
Support self test\silent\loop-back mode
Support auto retransmission mode
Support auto bus on after bus-off state
Support 2 transmit buffers
Support Internal Storage Mode
Support DMA

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 .../net/can/rockchip/rockchip_canfd-core.c    | 420 ++++++++++++++++++
 drivers/net/can/rockchip/rockchip_canfd-rx.c  | 103 +++++
 drivers/net/can/rockchip/rockchip_canfd-tx.c  |  20 +
 drivers/net/can/rockchip/rockchip_canfd.h     | 258 +++++++++++
 4 files changed, 801 insertions(+)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index c21ca4c1fb9a..e36cf4cb6743 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -31,6 +31,8 @@ static const char *__rkcanfd_get_model_str(enum rkcanfd_model model)
 		return "rk3568v2";
 	case RKCANFD_MODEL_RK3568V3:
 		return "rk3568v3";
+	case RKCANFD_MODEL_RK3576:
+		return "rk3576";
 	}
 
 	return "<unknown>";
@@ -176,6 +178,27 @@ static void rkcanfd_get_berr_counter_corrected(struct rkcanfd_priv *priv,
 		    !!(reg_state & RKCANFD_REG_STATE_ERROR_WARNING_STATE));
 }
 
+static void rk3576canfd_get_berr_counter_corrected(struct rkcanfd_priv *priv,
+						   struct can_berr_counter *bec)
+{
+	struct can_berr_counter bec_raw;
+	u32 reg_state;
+
+	bec->rxerr = rkcanfd_read(priv, RK3576CANFD_REG_RXERRORCNT);
+	bec->txerr = rkcanfd_read(priv, RK3576CANFD_REG_TXERRORCNT);
+	bec_raw = *bec;
+
+	priv->bec = *bec;
+
+	reg_state = rkcanfd_read(priv, RKCANFD_REG_STATE);
+	netdev_vdbg(priv->ndev,
+		    "%s: Raw/Cor: txerr=%3u/%3u rxerr=%3u/%3u Bus Off=%u Warning=%u\n",
+		    __func__,
+		    bec_raw.txerr, bec->txerr, bec_raw.rxerr, bec->rxerr,
+		    !!(reg_state & RK3576CANFD_REG_STATE_BUS_OFF_STATE),
+		    !!(reg_state & RK3576CANFD_REG_STATE_ERROR_WARNING_STATE));
+}
+
 static int rkcanfd_get_berr_counter(const struct net_device *ndev,
 				    struct can_berr_counter *bec)
 {
@@ -206,6 +229,11 @@ static void rkcanfd_chip_interrupts_disable(const struct rkcanfd_priv *priv)
 	rkcanfd_write(priv, RKCANFD_REG_INT_MASK, RKCANFD_REG_INT_ALL);
 }
 
+static void rk3576canfd_chip_interrupts_disable(const struct rkcanfd_priv *priv)
+{
+	rkcanfd_write(priv, RK3576CANFD_REG_INT_MASK, RK3576CANFD_REG_INT_ALL);
+}
+
 static void rkcanfd_chip_fifo_setup(struct rkcanfd_priv *priv)
 {
 	u32 reg;
@@ -220,6 +248,49 @@ static void rkcanfd_chip_fifo_setup(struct rkcanfd_priv *priv)
 	netdev_reset_queue(priv->ndev);
 }
 
+static void rk3576canfd_chip_fifo_setup(struct rkcanfd_priv *priv)
+{
+	u32 reg_ism, reg_water;
+
+	reg_ism = FIELD_PREP(RK3576CANFD_REG_STR_CTL_ISM_SEL,
+			     RK3576CANFD_REG_STR_CTL_ISM_SEL_CANFD_FIXED) |
+		  RK3576CANFD_REG_STR_CTL_STORAGE_TIMEOUT_MODE;
+	reg_water = RK3576CANFD_ISM_WATERMASK_CANFD;
+
+	/* internal sram mode */
+	rkcanfd_write(priv, RK3576CANFD_REG_STR_CTL, reg_ism);
+	rkcanfd_write(priv, RK3576CANFD_REG_STR_WTM, reg_water);
+	WRITE_ONCE(priv->tx_head, 0);
+	WRITE_ONCE(priv->tx_tail, 0);
+	netdev_reset_queue(priv->ndev);
+}
+
+static void rk3576canfd_atf_config(struct rkcanfd_priv *priv, int mode)
+{
+	int i;
+
+	switch (mode) {
+	case RK3576CANFD_REG_ATFM_MASK_SEL_MASK_MODE:
+		for (i = 0; i < 5; i++) {
+			rkcanfd_write(priv, RK3576CANFD_REG_ATF(i), 0);
+			rkcanfd_write(priv, RK3576CANFD_REG_ATFM(i), RK3576CANFD_REG_ATFM_ID);
+		}
+		break;
+	case RK3576CANFD_REG_ATFM_MASK_SEL_LIST_MODE:
+		for (i = 0; i < 5; i++) {
+			rkcanfd_write(priv, RK3576CANFD_REG_ATF(i), 0);
+			rkcanfd_write(priv, RK3576CANFD_REG_ATFM(i), RK3576CANFD_REG_ATFM_MASK_SEL);
+		}
+		break;
+	default:
+		rkcanfd_write(priv, RK3576CANFD_REG_ATF_CTL, RK3576CANFD_REG_ATF_CTL_ATF_DIS_ALL);
+		return;
+	}
+
+	rkcanfd_write(priv, RK3576CANFD_REG_ATF_CTL, 0);
+	return;
+}
+
 static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
 {
 	u32 reg;
@@ -285,6 +356,61 @@ static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
 		   rkcanfd_read(priv, RKCANFD_REG_MODE));
 }
 
+static void rk3576canfd_chip_start(struct rkcanfd_priv *priv)
+
+{
+	u32 reg;
+
+	rkcanfd_chip_set_reset_mode(priv);
+
+	/* Receiving Filter: accept all */
+	rk3576canfd_atf_config(priv, RK3576CANFD_REG_ATFM_MASK_SEL_MASK_MODE);
+
+	/* enable:
+	 * - WORK_MODE: transition from reset to working mode
+	 */
+	reg = rkcanfd_read(priv, RKCANFD_REG_MODE);
+	priv->reg_mode_default = reg | RKCANFD_REG_MODE_WORK_MODE;
+
+	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
+		priv->reg_mode_default |= RKCANFD_REG_MODE_LBACK_MODE;
+		rkcanfd_write(priv, RK3576CANFD_REG_ERROR_MASK,
+			      RK3576CANFD_REG_ERROR_MASK_ACK_ERROR);
+	}
+
+	/* mask, i.e. ignore:
+	 * - RX_FINISH_INT - Rx finish interrupt
+	 */
+	priv->reg_int_mask_default = RK3576CANFD_REG_INT_RX_FINISH_INT;
+
+	/* Do not mask the bus error interrupt if the bus error
+	 * reporting is requested.
+	 */
+	if (!(priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
+		priv->reg_int_mask_default |= RKCANFD_REG_INT_ERROR_INT;
+
+	memset(&priv->bec, 0x0, sizeof(priv->bec));
+
+	priv->devtype_data.fifo_setup(priv);
+
+	rkcanfd_write(priv, RK3576CANFD_REG_AUTO_RETX_CFG,
+		      RK3576CANFD_REG_AUTO_RETX_CFG_AUTO_RETX_EN);
+
+	rkcanfd_write(priv, RK3576CANFD_REG_BRS_CFG,
+		      RK3576CANFD_REG_BRS_CFG_BRS_NEGSYNC_EN |
+		      RK3576CANFD_REG_BRS_CFG_BRS_POSSYNC_EN);
+
+	rkcanfd_set_bittiming(priv);
+
+	priv->devtype_data.interrupts_disable(priv);
+	rkcanfd_chip_set_work_mode(priv);
+
+	priv->can.state = CAN_STATE_ERROR_ACTIVE;
+
+	netdev_dbg(priv->ndev, "%s: reg_mode=0x%08x\n", __func__,
+		   rkcanfd_read(priv, RKCANFD_REG_MODE));
+}
+
 static void __rkcanfd_chip_stop(struct rkcanfd_priv *priv, const enum can_state state)
 {
 	priv->can.state = state;
@@ -301,6 +427,13 @@ static void rkcanfd_chip_stop(struct rkcanfd_priv *priv, const enum can_state st
 	__rkcanfd_chip_stop(priv, state);
 }
 
+static void rk3576canfd_chip_stop(struct rkcanfd_priv *priv, const enum can_state state)
+{
+	priv->can.state = state;
+
+	__rkcanfd_chip_stop(priv, state);
+}
+
 static void rkcanfd_chip_stop_sync(struct rkcanfd_priv *priv, const enum can_state state)
 {
 	priv->can.state = state;
@@ -309,6 +442,13 @@ static void rkcanfd_chip_stop_sync(struct rkcanfd_priv *priv, const enum can_sta
 	__rkcanfd_chip_stop(priv, state);
 }
 
+static void rk3576canfd_chip_stop_sync(struct rkcanfd_priv *priv, const enum can_state state)
+{
+	priv->can.state = state;
+
+	__rkcanfd_chip_stop(priv, state);
+}
+
 static int rkcanfd_set_mode(struct net_device *ndev,
 			    enum can_mode mode)
 {
@@ -364,6 +504,9 @@ static const char *rkcanfd_get_error_type_str(unsigned int type)
 #define RKCAN_ERROR_CODE(reg_ec, code) \
 	((reg_ec) & RKCANFD_REG_ERROR_CODE_##code ? __stringify(code) " " : "")
 
+#define RK3576CAN_ERROR_CODE(reg_ec, code) \
+	((reg_ec) & RK3576CANFD_REG_ERROR_CODE_##code ? __stringify(code) " " : "")
+
 static void
 rkcanfd_handle_error_int_reg_ec(struct rkcanfd_priv *priv, struct can_frame *cf,
 				const u32 reg_ec)
@@ -493,6 +636,128 @@ rkcanfd_handle_error_int_reg_ec(struct rkcanfd_priv *priv, struct can_frame *cf,
 	}
 }
 
+static void
+rk3576canfd_handle_error_int_reg_ec(struct rkcanfd_priv *priv, struct can_frame *cf,
+				    const u32 reg_ec)
+{
+	struct net_device_stats *stats = &priv->ndev->stats;
+	unsigned int type;
+	u32 reg_state, reg_cmd;
+
+	type = FIELD_GET(RK3576CANFD_REG_ERROR_CODE_TYPE, reg_ec);
+	reg_cmd = rkcanfd_read(priv, RK3576CANFD_REG_CMD);
+	reg_state = rkcanfd_read(priv, RK3576CANFD_REG_STATE);
+
+	netdev_dbg(priv->ndev, "%s Error in %s %s Phase: %s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s(0x%08x) CMD=%u RX=%u TX=%u Error-Warning=%u Bus-Off=%u\n",
+		   rkcanfd_get_error_type_str(type),
+		   reg_ec & RK3576CANFD_REG_ERROR_CODE_DIRECTION_RX ? "RX" : "TX",
+		   reg_ec & RK3576CANFD_REG_ERROR_CODE_PHASE ? "Data" : "Arbitration",
+		   RK3576CAN_ERROR_CODE(reg_ec, TX_ACK_EOF),
+		   RK3576CAN_ERROR_CODE(reg_ec, TX_CRC),
+		   RK3576CAN_ERROR_CODE(reg_ec, TX_STUFF_COUNT),
+		   RK3576CAN_ERROR_CODE(reg_ec, TX_DATA),
+		   RK3576CAN_ERROR_CODE(reg_ec, TX_SOF_DLC),
+		   RK3576CAN_ERROR_CODE(reg_ec, TX_IDLE),
+		   RK3576CAN_ERROR_CODE(reg_ec, RX_ERROR),
+		   RK3576CAN_ERROR_CODE(reg_ec, RX_OVERLOAD),
+		   RK3576CAN_ERROR_CODE(reg_ec, RX_SPACE),
+		   RK3576CAN_ERROR_CODE(reg_ec, RX_EOF),
+		   RK3576CAN_ERROR_CODE(reg_ec, RX_ACK_LIM),
+		   RK3576CAN_ERROR_CODE(reg_ec, RX_ACK),
+		   RK3576CAN_ERROR_CODE(reg_ec, RX_CRC_LIM),
+		   RK3576CAN_ERROR_CODE(reg_ec, RX_CRC),
+		   RK3576CAN_ERROR_CODE(reg_ec, RX_STUFF_COUNT),
+		   RK3576CAN_ERROR_CODE(reg_ec, RX_DATA),
+		   RK3576CAN_ERROR_CODE(reg_ec, RX_DLC),
+		   RK3576CAN_ERROR_CODE(reg_ec, RX_BRS_ESI),
+		   RK3576CAN_ERROR_CODE(reg_ec, RX_RES),
+		   RK3576CAN_ERROR_CODE(reg_ec, RX_FDF),
+		   RK3576CAN_ERROR_CODE(reg_ec, RX_ID2_RTR),
+		   RK3576CAN_ERROR_CODE(reg_ec, RX_SOF_IDE),
+		   RK3576CAN_ERROR_CODE(reg_ec, RX_BUS_IDLE),
+		   RK3576CAN_ERROR_CODE(reg_ec, RX_BUS_INT),
+		   RK3576CAN_ERROR_CODE(reg_ec, RX_STOP),
+		   reg_ec, reg_cmd,
+		   !!(reg_state & RK3576CANFD_REG_STATE_RX_PERIOD),
+		   !!(reg_state & RK3576CANFD_REG_STATE_TX_PERIOD),
+		   !!(reg_state & RK3576CANFD_REG_STATE_ERROR_WARNING_STATE),
+		   !!(reg_state & RK3576CANFD_REG_STATE_BUS_OFF_STATE));
+
+	priv->can.can_stats.bus_error++;
+
+	if (reg_ec & RK3576CANFD_REG_ERROR_CODE_DIRECTION_RX)
+		stats->rx_errors++;
+	else
+		stats->tx_errors++;
+
+	if (!cf)
+		return;
+
+	if (reg_ec & RK3576CANFD_REG_ERROR_CODE_DIRECTION_RX) {
+		if (reg_ec & RK3576CANFD_REG_ERROR_CODE_RX_SOF_IDE)
+			cf->data[3] = CAN_ERR_PROT_LOC_SOF;
+		else if (reg_ec & RK3576CANFD_REG_ERROR_CODE_RX_ID2_RTR)
+			cf->data[3] = CAN_ERR_PROT_LOC_RTR;
+		/* RKCANFD_REG_ERROR_CODE_RX_FDF */
+		else if (reg_ec & RK3576CANFD_REG_ERROR_CODE_RX_RES)
+			cf->data[3] = CAN_ERR_PROT_LOC_RES0;
+		/* RKCANFD_REG_ERROR_CODE_RX_BRS_ESI */
+		else if (reg_ec & RK3576CANFD_REG_ERROR_CODE_RX_DLC)
+			cf->data[3] = CAN_ERR_PROT_LOC_DLC;
+		else if (reg_ec & RK3576CANFD_REG_ERROR_CODE_RX_DATA)
+			cf->data[3] = CAN_ERR_PROT_LOC_DATA;
+		/* RKCANFD_REG_ERROR_CODE_RX_STUFF_COUNT */
+		else if (reg_ec & RK3576CANFD_REG_ERROR_CODE_RX_CRC)
+			cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+		else if (reg_ec & RK3576CANFD_REG_ERROR_CODE_RX_CRC_LIM)
+			cf->data[3] = CAN_ERR_PROT_LOC_ACK_DEL;
+		else if (reg_ec & RK3576CANFD_REG_ERROR_CODE_RX_ACK)
+			cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+		else if (reg_ec & RK3576CANFD_REG_ERROR_CODE_RX_ACK_LIM)
+			cf->data[3] = CAN_ERR_PROT_LOC_ACK_DEL;
+		else if (reg_ec & RK3576CANFD_REG_ERROR_CODE_RX_EOF)
+			cf->data[3] = CAN_ERR_PROT_LOC_EOF;
+		else if (reg_ec & RK3576CANFD_REG_ERROR_CODE_RX_SPACE)
+			cf->data[3] = CAN_ERR_PROT_LOC_EOF;
+	} else {
+		cf->data[2] |= CAN_ERR_PROT_TX;
+
+		if (reg_ec & RK3576CANFD_REG_ERROR_CODE_TX_SOF_DLC)
+			cf->data[3] = CAN_ERR_PROT_LOC_SOF;
+		else if (reg_ec & RK3576CANFD_REG_ERROR_CODE_TX_DATA)
+			cf->data[3] = CAN_ERR_PROT_LOC_DATA;
+		/* RKCANFD_REG_ERROR_CODE_TX_STUFF_COUNT */
+		else if (reg_ec & RK3576CANFD_REG_ERROR_CODE_TX_CRC)
+			cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+		else if (reg_ec & RK3576CANFD_REG_ERROR_CODE_TX_ACK_EOF)
+			cf->data[3] = CAN_ERR_PROT_LOC_ACK_DEL;
+	}
+
+	switch (reg_ec & RK3576CANFD_REG_ERROR_CODE_TYPE) {
+	case FIELD_PREP_CONST(RK3576CANFD_REG_ERROR_CODE_TYPE,
+			      RK3576CANFD_REG_ERROR_CODE_TYPE_BIT):
+
+		cf->data[2] |= CAN_ERR_PROT_BIT;
+		break;
+	case FIELD_PREP_CONST(RK3576CANFD_REG_ERROR_CODE_TYPE,
+			      RK3576CANFD_REG_ERROR_CODE_TYPE_STUFF):
+		cf->data[2] |= CAN_ERR_PROT_STUFF;
+		break;
+	case FIELD_PREP_CONST(RK3576CANFD_REG_ERROR_CODE_TYPE,
+			      RK3576CANFD_REG_ERROR_CODE_TYPE_FORM):
+		cf->data[2] |= CAN_ERR_PROT_FORM;
+		break;
+	case FIELD_PREP_CONST(RK3576CANFD_REG_ERROR_CODE_TYPE,
+			      RK3576CANFD_REG_ERROR_CODE_TYPE_ACK):
+		cf->can_id |= CAN_ERR_ACK;
+		break;
+	case FIELD_PREP_CONST(RK3576CANFD_REG_ERROR_CODE_TYPE,
+			      RK3576CANFD_REG_ERROR_CODE_TYPE_CRC):
+		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+		break;
+	}
+}
+
 static int rkcanfd_handle_error_int(struct rkcanfd_priv *priv)
 {
 	struct net_device_stats *stats = &priv->ndev->stats;
@@ -530,6 +795,41 @@ static int rkcanfd_handle_error_int(struct rkcanfd_priv *priv)
 	return 0;
 }
 
+static int rkcanfd_handle_rk3576_error_int(struct rkcanfd_priv *priv)
+{
+	struct net_device_stats *stats = &priv->ndev->stats;
+	struct can_frame *cf = NULL;
+	u32 reg_ec;
+	struct sk_buff *skb;
+	int err;
+
+	reg_ec = rkcanfd_read(priv, RK3576CANFD_REG_ERROR_CODE);
+	if (!reg_ec)
+		return 0;
+
+	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) {
+		skb = alloc_can_err_skb(priv->ndev, &cf);
+		if (cf) {
+			struct can_berr_counter bec;
+
+			priv->devtype_data.get_berr_counter(priv, &bec);
+			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR | CAN_ERR_CNT;
+			cf->data[6] = bec.txerr;
+			cf->data[7] = bec.rxerr;
+		}
+	}
+
+	rk3576canfd_handle_error_int_reg_ec(priv, cf, reg_ec);
+	if (!cf)
+		return 0;
+
+	err = can_rx_offload_queue_tail(&priv->offload, skb);
+	if (err)
+		stats->rx_fifo_errors++;
+
+	return 0;
+}
+
 static int rkcanfd_handle_state_error_int(struct rkcanfd_priv *priv)
 {
 	struct net_device_stats *stats = &priv->ndev->stats;
@@ -575,6 +875,50 @@ static int rkcanfd_handle_state_error_int(struct rkcanfd_priv *priv)
 	return 0;
 }
 
+static int rkcanfd_handle_rk3576_state_error_int(struct rkcanfd_priv *priv)
+{
+	struct net_device_stats *stats = &priv->ndev->stats;
+	enum can_state new_state, rx_state, tx_state;
+	struct net_device *ndev = priv->ndev;
+	struct can_berr_counter bec;
+	struct can_frame *cf = NULL;
+	struct sk_buff *skb;
+	int err;
+
+	priv->devtype_data.get_berr_counter(priv, &bec);
+	can_state_get_by_berr_counter(ndev, &bec, &tx_state, &rx_state);
+
+	new_state = max(tx_state, rx_state);
+	if (new_state == priv->can.state)
+		return 0;
+
+	/* The skb allocation might fail, but can_change_state()
+	 * handles cf == NULL.
+	 */
+	skb = alloc_can_err_skb(priv->ndev, &cf);
+	can_change_state(ndev, cf, tx_state, rx_state);
+
+	if (new_state == CAN_STATE_BUS_OFF) {
+		priv->devtype_data.chip_stop(priv, CAN_STATE_BUS_OFF);
+		can_bus_off(ndev);
+	}
+
+	if (!skb)
+		return 0;
+
+	if (new_state != CAN_STATE_BUS_OFF) {
+		cf->can_id |= CAN_ERR_CNT;
+		cf->data[6] = bec.txerr;
+		cf->data[7] = bec.rxerr;
+	}
+
+	err = can_rx_offload_queue_tail(&priv->offload, skb);
+	if (err)
+		stats->rx_fifo_errors++;
+
+	return 0;
+}
+
 static int
 rkcanfd_handle_rx_fifo_overflow_int(struct rkcanfd_priv *priv)
 {
@@ -621,6 +965,55 @@ rkcanfd_handle_rx_fifo_overflow_int(struct rkcanfd_priv *priv)
 	err; \
 })
 
+static irqreturn_t rk3576canfd_irq(int irq, void *dev_id)
+{
+	struct rkcanfd_priv *priv = dev_id;
+	u32 reg_int_unmasked, reg_int;
+
+	reg_int_unmasked = rkcanfd_read(priv, RK3576CANFD_REG_INT);
+	reg_int = reg_int_unmasked & ~priv->reg_int_mask_default;
+
+	if (!reg_int)
+		return IRQ_NONE;
+
+	rkcanfd_write(priv, RK3576CANFD_REG_INT, reg_int);
+
+	if (reg_int & (RK3576CANFD_REG_INT_RXSTR_TIMEOUT_INT |
+		       RK3576CANFD_REG_INT_ISM_WTM_INT |
+		       RK3576CANFD_REG_INT_RX_FIFO_FULL_INT)) {
+		rkcanfd_write(priv, RK3576CANFD_REG_INT_MASK,
+			      priv->reg_int_mask_default | RK3576CANFD_REG_INT_ISM_WTM_INT |
+			      RK3576CANFD_REG_INT_RXSTR_TIMEOUT_INT |
+			      RK3576CANFD_REG_INT_RX_FINISH_INT);
+		rkcanfd_handle(priv, rk3576_rx_int);
+	}
+
+	if (reg_int & RK3576CANFD_REG_INT_TX_FINISH_INT)
+		rkcanfd_handle(priv, rk3576_tx_int);
+
+	if (reg_int & RK3576CANFD_REG_INT_ERROR_INT)
+		rkcanfd_handle(priv, rk3576_error_int);
+
+	if (reg_int & (RK3576CANFD_REG_INT_BUS_OFF_INT |
+		       RK3576CANFD_REG_INT_PASSIVE_ERROR_INT |
+		       RK3576CANFD_REG_INT_ERROR_WARNING_INT) ||
+	    priv->can.state > CAN_STATE_ERROR_ACTIVE)
+		rkcanfd_handle(priv, rk3576_state_error_int);
+
+	if (reg_int & RK3576CANFD_REG_INT_WAKEUP_INT)
+		netdev_info(priv->ndev, "%s: WAKEUP_INT\n", __func__);
+
+	if (reg_int & RK3576CANFD_REG_INT_BUS_OFF_RECOVERY_INT)
+		netdev_info(priv->ndev, "%s: BUS_OFF_RECOVERY_INT\n", __func__);
+
+	if (reg_int & RK3576CANFD_REG_INT_OVERLOAD_INT)
+		netdev_info(priv->ndev, "%s: OVERLOAD_INT\n", __func__);
+
+	can_rx_offload_irq_finish(&priv->offload);
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t rkcanfd_irq(int irq, void *dev_id)
 {
 	struct rkcanfd_priv *priv = dev_id;
@@ -775,6 +1168,16 @@ static void rkcanfd_register_done(const struct rkcanfd_priv *priv)
 			    RKCANFD_ERRATUM_5_SYSCLOCK_HZ_MIN / MEGA);
 }
 
+static void rk3576canfd_register_done(const struct rkcanfd_priv *priv)
+{
+	u32 dev_id;
+
+	dev_id = rkcanfd_read(priv, RK3576CANFD_REG_RTL_VERSION);
+	netdev_info(priv->ndev,
+		    "Rockchip-CANFD %s rev%u.\n",
+		    rkcanfd_get_model_str(priv), dev_id);
+}
+
 static int rkcanfd_register(struct rkcanfd_priv *priv)
 {
 	struct net_device *ndev = priv->ndev;
@@ -858,6 +1261,20 @@ static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v3 = {
 	.register_done = rkcanfd_register_done,
 };
 
+/* The rk3576 CAN-FD */
+static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3576 = {
+	.model = RKCANFD_MODEL_RK3576,
+	.get_berr_counter = rk3576canfd_get_berr_counter_corrected,
+	.interrupts_enable = rkcanfd_chip_interrupts_enable,
+	.interrupts_disable = rk3576canfd_chip_interrupts_disable,
+	.fifo_setup = rk3576canfd_chip_fifo_setup,
+	.chip_start = rk3576canfd_chip_start,
+	.chip_stop = rk3576canfd_chip_stop,
+	.chip_stop_sync = rk3576canfd_chip_stop_sync,
+	.irq = rk3576canfd_irq,
+	.register_done = rk3576canfd_register_done,
+};
+
 static const struct of_device_id rkcanfd_of_match[] = {
 	{
 		.compatible = "rockchip,rk3568v2-canfd",
@@ -865,6 +1282,9 @@ static const struct of_device_id rkcanfd_of_match[] = {
 	}, {
 		.compatible = "rockchip,rk3568v3-canfd",
 		.data = &rkcanfd_devtype_data_rk3568v3,
+	},  {
+		.compatible = "rockchip,rk3576-canfd",
+		.data = &rkcanfd_devtype_data_rk3576,
 	}, {
 		/* sentinel */
 	},
diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index 475c0409e215..d6f39393c7ea 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
@@ -91,6 +91,47 @@ rkcanfd_fifo_header_to_cfd_header(const struct rkcanfd_priv *priv,
 	return len + cfd->len;
 }
 
+static unsigned int
+rk3576canfd_fifo_header_to_cfd_header(const struct rkcanfd_priv *priv,
+				      const struct rk3576canfd_fifo_header *header,
+				      struct canfd_frame *cfd)
+{
+	unsigned int len = sizeof(*cfd) - sizeof(cfd->data);
+	u8 dlc;
+
+	if (header->frameinfo & RK3576CANFD_REG_RXFRD_FRAMEINFO_FRAME_FORMAT)
+		cfd->can_id = FIELD_GET(RKCANFD_REG_FD_ID_EFF, header->id) |
+			CAN_EFF_FLAG;
+	else
+		cfd->can_id = FIELD_GET(RKCANFD_REG_FD_ID_SFF, header->id);
+
+	dlc = FIELD_GET(RK3576CANFD_REG_RXFRD_FRAMEINFO_DATA_LENGTH,
+			header->frameinfo);
+
+	/* CAN-FD */
+	if (header->frameinfo & RK3576CANFD_REG_RXFRD_FRAMEINFO_FDF) {
+		cfd->len = can_fd_dlc2len(dlc);
+
+		/* The cfd is not allocated by alloc_canfd_skb(), so
+		 * set CANFD_FDF here.
+		 */
+		cfd->flags |= CANFD_FDF;
+
+		if (header->frameinfo & RK3576CANFD_REG_RXFRD_FRAMEINFO_BRS)
+			cfd->flags |= CANFD_BRS;
+	} else {
+		cfd->len = can_cc_dlc2len(dlc);
+
+		if (header->frameinfo & RK3576CANFD_REG_RXFRD_FRAMEINFO_RTR) {
+			cfd->can_id |= CAN_RTR_FLAG;
+
+			return len;
+		}
+	}
+
+	return len + cfd->len;
+}
+
 static int rkcanfd_rxstx_filter(struct rkcanfd_priv *priv,
 				const struct canfd_frame *cfd_rx, const u32 ts,
 				bool *tx_done)
@@ -198,6 +239,44 @@ rkcanfd_fifo_header_empty(const struct rkcanfd_fifo_header *header)
 		header->frameinfo == header->ts;
 }
 
+static int rk3576canfd_handle_rx_int_one(struct rkcanfd_priv *priv)
+{
+	struct net_device_stats *stats = &priv->ndev->stats;
+	struct canfd_frame cfd[1] = { }, *skb_cfd;
+	struct rk3576canfd_fifo_header header[1] = { };
+	struct sk_buff *skb;
+	unsigned int len;
+	int err;
+
+	/* read header into separate struct and convert it later */
+	rkcanfd_read_rep(priv, RKCANFD_REG_RX_FIFO_RDATA,
+			 header, sizeof(*header));
+	/* read data directly into cfd */
+	rkcanfd_read_rep(priv, RKCANFD_REG_RX_FIFO_RDATA,
+			 cfd->data, sizeof(cfd->data));
+
+	len = rk3576canfd_fifo_header_to_cfd_header(priv, header, cfd);
+
+	if (header->frameinfo & RK3576CANFD_REG_RXFRD_FRAMEINFO_FDF)
+		skb = alloc_canfd_skb(priv->ndev, &skb_cfd);
+	else
+		skb = alloc_can_skb(priv->ndev, (struct can_frame **)&skb_cfd);
+
+	if (!skb) {
+		stats->rx_dropped++;
+
+		return 0;
+	}
+
+	memcpy(skb_cfd, cfd, len);
+
+	err = can_rx_offload_queue_tail(&priv->offload, skb);
+	if (err)
+		stats->rx_fifo_errors++;
+
+	return 0;
+}
+
 static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
 {
 	struct net_device_stats *stats = &priv->ndev->stats;
@@ -284,6 +363,15 @@ rkcanfd_rx_fifo_get_len(const struct rkcanfd_priv *priv)
 	return FIELD_GET(RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT, reg);
 }
 
+static inline unsigned int
+rk3576canfd_rx_fifo_get_len(const struct rkcanfd_priv *priv)
+{
+	const u32 reg = rkcanfd_read(priv, RK3576CANFD_REG_STR_STATE);
+	int val = FIELD_GET(RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT, reg);
+
+	return DIV_ROUND_UP(val, RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT_UNIT);
+}
+
 int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv)
 {
 	unsigned int len;
@@ -297,3 +385,18 @@ int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv)
 
 	return 0;
 }
+
+int rkcanfd_handle_rk3576_rx_int(struct rkcanfd_priv *priv)
+{
+	unsigned int len;
+	int err;
+
+	while ((len = rk3576canfd_rx_fifo_get_len(priv))) {
+		err = rk3576canfd_handle_rx_int_one(priv);
+		if (err)
+			return err;
+	}
+	rkcanfd_write(priv, RK3576CANFD_REG_INT_MASK, priv->reg_int_mask_default);
+	return 0;
+}
+
diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
index 865a15e033a9..6f6389030da9 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -165,3 +165,23 @@ void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 ts,
 							    frame_len_p);
 	stats->tx_packets++;
 }
+
+int rkcanfd_handle_rk3576_tx_int(struct rkcanfd_priv *priv)
+{
+	struct net_device_stats *stats = &priv->ndev->stats;
+	unsigned int tx_tail;
+	unsigned int frame_len = 0;
+
+	tx_tail = rkcanfd_get_tx_tail(priv);
+
+	stats->tx_bytes +=
+		can_rx_offload_get_echo_skb_queue_tail(&priv->offload,
+						       tx_tail, &frame_len);
+	stats->tx_packets++;
+	WRITE_ONCE(priv->tx_tail, priv->tx_tail + 1);
+	netif_subqueue_completed_wake(priv->ndev, 0, 1, frame_len,
+				      rkcanfd_get_effective_tx_free(priv),
+				      RKCANFD_TX_START_THRESHOLD);
+	return 0;
+}
+
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index bcd26d23062b..6b77a19e0d4a 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -287,6 +287,256 @@
 #define RKCANFD_REG_RX_FIFO_RDATA 0x400
 #define RKCANFD_REG_TXE_FIFO_RDATA 0x500
 
+#define RK3576CANFD_REG_MODE 0x000
+#define RK3576CANFD_REG_CMD 0x004
+
+#define RK3576CANFD_REG_STATE 0x008
+#define RK3576CANFD_REG_STATE_SLEEP_STATE BIT(5)
+#define RK3576CANFD_REG_STATE_BUS_OFF_STATE BIT(4)
+#define RK3576CANFD_REG_STATE_ERROR_WARNING_STATE BIT(3)
+#define RK3576CANFD_REG_STATE_TX_PERIOD BIT(2)
+#define RK3576CANFD_REG_STATE_RX_PERIOD BIT(1)
+#define RK3576CANFD_REG_STATE_TX_BUFFER_FULL BIT(0)
+
+#define RK3576CANFD_REG_INT 0x00c
+#define RK3576CANFD_REG_INT_BUSOFF_RCY_INT BIT(19)
+#define RK3576CANFD_REG_INT_ESM_WTM_INT BIT(18)
+#define RK3576CANFD_REG_INT_ISM_WTM_INT BIT(17)
+#define RK3576CANFD_REG_INT_BUSINT_INT BIT(16)
+#define RK3576CANFD_REG_INT_RXSTR_TIMEOUT_INT BIT(15)
+#define RK3576CANFD_REG_INT_MFI_TIMEOUT_INT BIT(14)
+#define RK3576CANFD_REG_INT_MFI_INT BIT(13)
+#define RK3576CANFD_REG_INT_AUTO_RETX_FAIL_INT BIT(12)
+#define RK3576CANFD_REG_INT_WAKEUP_INT BIT(11)
+#define RK3576CANFD_REG_INT_BUS_OFF_RECOVERY_INT BIT(10)
+#define RK3576CANFD_REG_INT_BUS_OFF_INT BIT(9)
+#define RK3576CANFD_REG_INT_RX_FIFO_OVERFLOW_INT BIT(8)
+#define RK3576CANFD_REG_INT_RX_FIFO_FULL_INT BIT(7)
+#define RK3576CANFD_REG_INT_ERROR_INT BIT(6)
+#define RK3576CANFD_REG_INT_TX_ARBIT_FAIL_INT BIT(5)
+#define RK3576CANFD_REG_INT_PASSIVE_ERROR_INT BIT(4)
+#define RK3576CANFD_REG_INT_OVERLOAD_INT BIT(3)
+#define RK3576CANFD_REG_INT_ERROR_WARNING_INT BIT(2)
+#define RK3576CANFD_REG_INT_TX_FINISH_INT BIT(1)
+#define RK3576CANFD_REG_INT_RX_FINISH_INT BIT(0)
+
+#define RK3576CANFD_REG_INT_ALL \
+	(RK3576CANFD_REG_INT_BUSOFF_RCY_INT | \
+	 RK3576CANFD_REG_INT_ESM_WTM_INT | \
+	 RK3576CANFD_REG_INT_ISM_WTM_INT | \
+	 RK3576CANFD_REG_INT_BUSINT_INT | \
+	 RK3576CANFD_REG_INT_RXSTR_TIMEOUT_INT | \
+	 RK3576CANFD_REG_INT_MFI_TIMEOUT_INT | \
+	 RK3576CANFD_REG_INT_MFI_INT | \
+	 RK3576CANFD_REG_INT_AUTO_RETX_FAIL_INT | \
+	 RK3576CANFD_REG_INT_WAKEUP_INT | \
+	 RK3576CANFD_REG_INT_BUS_OFF_RECOVERY_INT | \
+	 RK3576CANFD_REG_INT_BUS_OFF_INT | \
+	 RK3576CANFD_REG_INT_RX_FIFO_OVERFLOW_INT | \
+	 RK3576CANFD_REG_INT_RX_FIFO_FULL_INT | \
+	 RK3576CANFD_REG_INT_ERROR_INT | \
+	 RK3576CANFD_REG_INT_TX_ARBIT_FAIL_INT | \
+	 RK3576CANFD_REG_INT_PASSIVE_ERROR_INT | \
+	 RK3576CANFD_REG_INT_OVERLOAD_INT | \
+	 RK3576CANFD_REG_INT_ERROR_WARNING_INT | \
+	 RK3576CANFD_REG_INT_TX_FINISH_INT | \
+	 RK3576CANFD_REG_INT_RX_FINISH_INT)
+
+#define RK3576CANFD_REG_INT_ALL_ERROR \
+	(RK3576CANFD_REG_INT_BUS_OFF_INT | \
+	 RK3576CANFD_REG_INT_ERROR_INT | \
+	 RK3576CANFD_REG_INT_PASSIVE_ERROR_INT | \
+	 RK3576CANFD_REG_INT_ERROR_WARNING_INT)
+
+#define RK3576CANFD_REG_INT_MASK 0x010
+
+#define RK3576CANFD_REG_FD_NOMINAL_BITTIMING 0x100
+#define RK3576CANFD_REG_FD_NOMINAL_BITTIMING_SAMPLE_MODE BIT(31)
+#define RK3576CANFD_REG_FD_NOMINAL_BITTIMING_SJW GENMASK(30, 24)
+#define RK3576CANFD_REG_FD_NOMINAL_BITTIMING_BRP GENMASK(23, 16)
+#define RK3576CANFD_REG_FD_NOMINAL_BITTIMING_TSEG2 GENMASK(14, 8)
+#define RK3576CANFD_REG_FD_NOMINAL_BITTIMING_TSEG1 GENMASK(7, 0)
+
+#define RK3576CANFD_REG_FD_DATA_BITTIMING 0x104
+#define RK3576CANFD_REG_FD_DATA_BITTIMING_BRS_TSEG1 GENMASK(31, 24)
+#define RK3576CANFD_REG_FD_DATA_BITTIMING_BRS_MODE BIT(23)
+#define RK3576CANFD_REG_FD_DATA_BITTIMING_ACKSLOT_SYNC_DIS BIT(22)
+#define RK3576CANFD_REG_FD_DATA_BITTIMING_SJW GENMASK(20, 17)
+#define RK3576CANFD_REG_FD_DATA_BITTIMING_BRP GENMASK(16, 9)
+#define RK3576CANFD_REG_FD_DATA_BITTIMING_TSEG2 GENMASK(8, 5)
+#define RK3576CANFD_REG_FD_DATA_BITTIMING_TSEG1 GENMASK(4, 0)
+
+#define RK3576CANFD_REG_TRANSMIT_DELAY_COMPENSATION 0x108
+#define RK3576CANFD_REG_TRANSMIT_DELAY_COMPENSATION_TDC_OFFSET GENMASK(6, 1)
+#define RK3576CANFD_REG_TRANSMIT_DELAY_COMPENSATION_TDC_ENABLE BIT(0)
+
+#define RK3576CANFD_REG_BRS_CFG 0x10c
+#define RK3576CANFD_REG_BRS_CFG_TRIPLE_SYNC_MODE BIT(31)
+#define RK3576CANFD_REG_BRS_CFG_SP2_DTSEG1 GENMASK(30, 26)
+#define RK3576CANFD_REG_BRS_CFG_SP2_NTSEG1 GENMASK(25, 18)
+#define RK3576CANFD_REG_BRS_CFG_SP1_DTSEG1 GENMASK(17, 13)
+#define RK3576CANFD_REG_BRS_CFG_SP1_NTSEG1 GENMASK(12, 5)
+#define RK3576CANFD_REG_BRS_CFG_RESYNC_MODE BIT(3)
+#define RK3576CANFD_REG_BRS_CFG_BRS_POSSYNC_EN BIT(1)
+#define RK3576CANFD_REG_BRS_CFG_BRS_NEGSYNC_EN BIT(0)
+
+#define RK3576CANFD_REG_LOOP_CNT 0x110
+
+#define RK3576CANFD_REG_DMA_CTRL 0x11c
+#define RK3576CANFD_REG_DMA_CTRL_DMA_RX_EN BIT(9)
+#define RK3576CANFD_REG_DMA_CTRL_DMA_THR GENMASK(8, 0)
+
+#define RK3576CANFD_REG_FD_TXFRAMEINFO 0x200
+
+#define RK3576CANFD_REG_FD_TXID 0x204
+#define RK3576CANFD_REG_FD_ID_EFF GENMASK(28, 0)
+#define RK3576CANFD_REG_FD_ID_SFF GENMASK(11, 0)
+
+#define RK3576CANFD_REG_FD_TXDATA0 0x208
+#define RK3576CANFD_REG_FD_TXDATA1 0x20c
+#define RK3576CANFD_REG_FD_TXDATA2 0x210
+#define RK3576CANFD_REG_FD_TXDATA3 0x214
+#define RK3576CANFD_REG_FD_TXDATA4 0x218
+#define RK3576CANFD_REG_FD_TXDATA5 0x21c
+#define RK3576CANFD_REG_FD_TXDATA6 0x220
+#define RK3576CANFD_REG_FD_TXDATA7 0x224
+#define RK3576CANFD_REG_FD_TXDATA8 0x228
+#define RK3576CANFD_REG_FD_TXDATA9 0x22c
+#define RK3576CANFD_REG_FD_TXDATA10 0x230
+#define RK3576CANFD_REG_FD_TXDATA11 0x234
+#define RK3576CANFD_REG_FD_TXDATA12 0x238
+#define RK3576CANFD_REG_FD_TXDATA13 0x23c
+#define RK3576CANFD_REG_FD_TXDATA14 0x240
+#define RK3576CANFD_REG_FD_TXDATA15 0x244
+
+#define RK3576CANFD_REG_RXFRD 0x400
+#define RK3576CANFD_REG_RXFRD_FRAMEINFO_FRAME_FORMAT BIT(23)
+#define RK3576CANFD_REG_RXFRD_FRAMEINFO_RTR BIT(22)
+#define RK3576CANFD_REG_RXFRD_FRAMEINFO_FDF BIT(21)
+#define RK3576CANFD_REG_RXFRD_FRAMEINFO_BRS BIT(20)
+#define RK3576CANFD_REG_RXFRD_FRAMEINFO_DATA_LENGTH GENMASK(27, 24)
+
+#define RK3576CANFD_REG_STR_CTL 0x600
+#define RK3576CANFD_REG_STR_CTL_STORAGE_TIMEOUT_MODE BIT(8)
+#define RK3576CANFD_REG_STR_CTL_ESM_SEL_MASK GENMASK(7, 6)
+#define RK3576CANFD_REG_STR_CTL_RX_STORAGE_RESET BIT(4)
+#define RK3576CANFD_REG_STR_CTL_ISM_SEL GENMASK(3, 2)
+#define RK3576CANFD_REG_STR_CTL_ISM_SEL_FLEXIBLE 0x0
+#define RK3576CANFD_REG_STR_CTL_ISM_SEL_CAN_FIXED 0x1
+#define RK3576CANFD_REG_STR_CTL_ISM_SEL_CANFD_FIXED 0x2
+#define RK3576CANFD_REG_STR_CTL_EXT_STORAGE_MODE BIT(1)
+#define RK3576CANFD_REG_STR_CTL_BUFFER_MODE_ENABLE BIT(0)
+
+#define RK3576CANFD_REG_STR_STATE 0x604
+#define RK3576CANFD_REG_STR_STATE_INTM_FRAME_CNT GENMASK(25, 17)
+#define RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT GENMASK(16, 8)
+#define RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT_UNIT 18
+#define RK3576CANFD_REG_STR_STATE_EXTM_FULL BIT(3)
+#define RK3576CANFD_REG_STR_STATE_EXTM_EMPTY BIT(2)
+#define RK3576CANFD_REG_STR_STATE_INTM_FULL BIT(1)
+#define RK3576CANFD_REG_STR_STATE_INTM_EMPTY BIT(0)
+
+#define RK3576CANFD_REG_STR_TIMEOUT 0x608
+
+#define RK3576CANFD_REG_STR_WTM 0x60c
+#define RK3576CANFD_REG_ATF(n) (0x700 + ((n) << 2))
+#define RK3576CANFD_REG_ATFM(n) (0x714 + ((n) << 2))
+#define RK3576CANFD_REG_ATFM_MASK_SEL BIT(31)
+#define RK3576CANFD_REG_ATFM_RTR_EN BIT(30)
+#define RK3576CANFD_REG_ATFM_RTR BIT(29)
+#define RK3576CANFD_REG_ATFM_MASK_SEL_MASK_MODE 0x0
+#define RK3576CANFD_REG_ATFM_MASK_SEL_LIST_MODE 0x1
+#define RK3576CANFD_REG_ATFM_ID GENMASK(28, 0)
+
+#define RK3576CANFD_REG_ATF_DLC 0x728
+#define RK3576CANFD_REG_ATF_DLC_ATF_DLC_MODE BIT(5)
+#define RK3576CANFD_REG_ATF_DLC_ATF_DLC_EN BIT(4)
+#define RK3576CANFD_REG_ATF_DLC_ATF_DLC GENMASK(3, 0)
+
+#define RK3576CANFD_REG_ATF_CTL 0x72c
+#define RK3576CANFD_REG_ATF_CTL_ATF_DIS(n) BIT(n)
+#define RK3576CANFD_REG_ATF_CTL_ATF_DIS_ALL GENMASK(15, 0)
+
+#define RK3576CANFD_REG_SPACE_CTRL 0x800
+
+#define RK3576CANFD_REG_AUTO_RETX_CFG 0x808
+#define RK3576CANFD_REG_AUTO_RETX_CFG_RETX_TIME_LIMIT GENMASK(18, 3)
+#define RK3576CANFD_REG_AUTO_RETX_CFG_RETX_LIMIT_EN BIT(1)
+#define RK3576CANFD_REG_AUTO_RETX_CFG_AUTO_RETX_EN BIT(0)
+
+#define RK3576CANFD_REG_AUTO_RETX_STATE0 0x80c
+#define RK3576CANFD_REG_AUTO_RETX_STATE0_AUTO_RETX_CNT GENMASK(15, 0)
+
+#define RK3576CANFD_REG_AUTO_RETX_STATE1 0x810
+#define RK3576CANFD_REG_OLF_CFG 0x814
+#define RK3576CANFD_REG_RXINT_CTRL 0x818
+#define RK3576CANFD_REG_RXINT_TIMEOUT 0x81c
+#define RK3576CANFD_REG_OTHER_CFG 0x820
+#define RK3576CANFD_REG_WAVE_FILTER_CFG 0x824
+#define RK3576CANFD_REG_RBC_CFG 0x828
+#define RK3576CANFD_REG_TXCRC_CFG 0x82c
+
+#define RK3576CANFD_REG_BUSOFFRCY_CFG 0x830
+#define RK3576CANFD_REG_BUSOFF_RCY_THR 0x834
+
+#define RK3576CANFD_REG_ERROR_CODE 0x900
+#define RK3576CANFD_REG_ERROR_MASK 0x904
+#define RK3576CANFD_REG_ERROR_MASK_ACK_ERROR BIT(4)
+#define RK3576CANFD_REG_ERROR_MASK_FORM_ERROR BIT(3)
+#define RK3576CANFD_REG_ERROR_MASK_CRC_ERROR BIT(2)
+#define RK3576CANFD_REG_ERROR_MASK_STUFF_ERROR BIT(1)
+#define RK3576CANFD_REG_ERROR_MASK_BIT_ERROR BIT(0)
+
+#define RK3576CANFD_REG_RXERRORCNT 0x910
+#define RK3576CANFD_REG_TXERRORCNT 0x914
+#define RK3576CANFD_REG_RX_RXSRAM_RDATA 0xc00
+#define RK3576CANFD_REG_RTL_VERSION 0xf0c
+
+#define RK3576CANFD_REG_ERROR_CODE_PHASE BIT(29)
+#define RK3576CANFD_REG_ERROR_CODE_TYPE GENMASK(28, 26)
+#define RK3576CANFD_REG_ERROR_CODE_TYPE_BIT 0x0
+#define RK3576CANFD_REG_ERROR_CODE_TYPE_STUFF 0x1
+#define RK3576CANFD_REG_ERROR_CODE_TYPE_FORM 0x2
+#define RK3576CANFD_REG_ERROR_CODE_TYPE_ACK 0x3
+#define RK3576CANFD_REG_ERROR_CODE_TYPE_CRC 0x4
+#define RK3576CANFD_REG_ERROR_CODE_DIRECTION_RX BIT(25)
+#define RK3576CANFD_REG_ERROR_CODE_TX GENMASK(24, 19)
+#define RK3576CANFD_REG_ERROR_CODE_TX_ACK_EOF BIT(24)
+#define RK3576CANFD_REG_ERROR_CODE_TX_CRC BIT(23)
+#define RK3576CANFD_REG_ERROR_CODE_TX_STUFF_COUNT BIT(22)
+#define RK3576CANFD_REG_ERROR_CODE_TX_DATA BIT(21)
+#define RK3576CANFD_REG_ERROR_CODE_TX_SOF_DLC BIT(20)
+#define RK3576CANFD_REG_ERROR_CODE_TX_IDLE BIT(19)
+#define RK3576CANFD_REG_ERROR_CODE_RX GENMASK(18, 0)
+#define RK3576CANFD_REG_ERROR_CODE_RX_ERROR BIT(18)
+#define RK3576CANFD_REG_ERROR_CODE_RX_OVERLOAD BIT(17)
+#define RK3576CANFD_REG_ERROR_CODE_RX_SPACE BIT(16)
+#define RK3576CANFD_REG_ERROR_CODE_RX_EOF BIT(15)
+#define RK3576CANFD_REG_ERROR_CODE_RX_ACK_LIM BIT(14)
+#define RK3576CANFD_REG_ERROR_CODE_RX_ACK BIT(13)
+#define RK3576CANFD_REG_ERROR_CODE_RX_CRC_LIM BIT(12)
+#define RK3576CANFD_REG_ERROR_CODE_RX_CRC BIT(11)
+#define RK3576CANFD_REG_ERROR_CODE_RX_STUFF_COUNT BIT(10)
+#define RK3576CANFD_REG_ERROR_CODE_RX_DATA BIT(9)
+#define RK3576CANFD_REG_ERROR_CODE_RX_DLC BIT(8)
+#define RK3576CANFD_REG_ERROR_CODE_RX_BRS_ESI BIT(7)
+#define RK3576CANFD_REG_ERROR_CODE_RX_RES BIT(6)
+#define RK3576CANFD_REG_ERROR_CODE_RX_FDF BIT(5)
+#define RK3576CANFD_REG_ERROR_CODE_RX_ID2_RTR BIT(4)
+#define RK3576CANFD_REG_ERROR_CODE_RX_SOF_IDE BIT(3)
+#define RK3576CANFD_REG_ERROR_CODE_RX_BUS_IDLE BIT(2)
+#define RK3576CANFD_REG_ERROR_CODE_RX_BUS_INT BIT(1)
+#define RK3576CANFD_REG_ERROR_CODE_RX_STOP BIT(0)
+
+#define RK3576CANFD_ISM_WATERMASK_CAN 0x6c /* word */
+#define RK3576CANFD_ISM_WATERMASK_CANFD 0x6c /* word */
+
+#define RK3576CANFD_SRAM_MAX_DEPTH 256 /* word */
+
+#define RK3576CANFD_CANFD_FILTER GENMASK(28, 0)
+
+#define RK3576CANFD_CANFD_FIFO_CNT GENMASK(7, 0)
+
 #define DEVICE_NAME "rockchip_canfd"
 #define RKCANFD_NAPI_WEIGHT 32
 #define RKCANFD_TXFIFO_DEPTH 2
@@ -434,6 +684,7 @@
 enum rkcanfd_model {
 	RKCANFD_MODEL_RK3568V2 = 0x35682,
 	RKCANFD_MODEL_RK3568V3 = 0x35683,
+	RKCANFD_MODEL_RK3576 = 0x3576,
 };
 
 struct rkcanfd_priv;
@@ -458,6 +709,11 @@ struct rkcanfd_fifo_header {
 	u32 ts;
 };
 
+struct rk3576canfd_fifo_header {
+	u32 frameinfo;
+	u32 id;
+};
+
 struct rkcanfd_stats {
 	struct u64_stats_sync syncp;
 
@@ -547,6 +803,8 @@ rkcanfd_get_tx_free(const struct rkcanfd_priv *priv)
 void rkcanfd_ethtool_init(struct rkcanfd_priv *priv);
 
 int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv);
+int rkcanfd_handle_rk3576_tx_int(struct rkcanfd_priv *priv);
+int rkcanfd_handle_rk3576_rx_int(struct rkcanfd_priv *priv);
 
 void rkcanfd_skb_set_timestamp(const struct rkcanfd_priv *priv,
 			       struct sk_buff *skb, const u32 timestamp);
-- 
2.34.1


