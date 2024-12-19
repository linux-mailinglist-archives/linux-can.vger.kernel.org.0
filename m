Return-Path: <linux-can+bounces-2456-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AABF99F7365
	for <lists+linux-can@lfdr.de>; Thu, 19 Dec 2024 04:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2079164737
	for <lists+linux-can@lfdr.de>; Thu, 19 Dec 2024 03:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFD786336;
	Thu, 19 Dec 2024 03:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="jRKun3Jl"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m25477.xmail.ntesmail.com (mail-m25477.xmail.ntesmail.com [103.129.254.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B7F4A04;
	Thu, 19 Dec 2024 03:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.129.254.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734579278; cv=none; b=t/fnPde7B9w4HyUkY8wywZqIqwBuNRvIwhiBQessG7YOpDUw5Fn/BhsykXXXTU3XoT0/LZRkX97OJc+uM7x6xm7oJYDgd4donhE9Uroqn8b19PQTBQ7LHD8FSW0R6B5eGTpfGGBhIlFdiYmCM5UFe5YPSqU/O/pSDtjsDxoB4Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734579278; c=relaxed/simple;
	bh=FMZS0YZhiBeOX3tcp5S8qXFHKDoNwRf4rn7X+9DoQQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ebt0srhbKmvNR+UUeDGv7J8wXiH6pDN15J5Wqpk6cUtsVAp/aun+jSpbi1TzkUxz5a79yO9wycuQy4vqbLsXg5ducvoMVcLHAQgAIYZK/ki+rQ2zB6ly6P+MeaFer1yoV5vMaPx4Q/yyLPw0boiIDRP8TNkdNz1+qk1KojZ0ayU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=jRKun3Jl; arc=none smtp.client-ip=103.129.254.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 626be1a1;
	Thu, 19 Dec 2024 09:12:01 +0800 (GMT+08:00)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: zhangqing@rock-chips.com,
	mkl@pengutronix.de,
	kernel@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	heiko@sntech.de,
	cl@rock-chips.com,
	kever.yang@rock-chips.com
Cc: linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] net: can: rockchip: add can for RK3576 Soc
Date: Thu, 19 Dec 2024 09:11:58 +0800
Message-Id: <20241219011159.3357530-2-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219011159.3357530-1-zhangqing@rock-chips.com>
References: <20241219011159.3357530-1-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU0YS1YeSx8ZHR1CShpOTk9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a93dc78c11703a3kunm626be1a1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PD46Vjo5FTIITRcOSR8hME5W
	MU8aCzRVSlVKTEhPTkxLTElJQkJIVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU9ITE5ONwY+
DKIM-Signature:a=rsa-sha256;
	b=jRKun3JlBRjlIAUidXAmRdVNY7YDF7OVZzdPpYzDR7n0K82PCzAEI2EGQhWIoNGpTf+ZJbE9+47N5qsHhtMi3lbVPd1iB/xp230g8iq1J05yCVGldT8yDYBRRCVYphyFxydXd++JdQ4/V/3zJGogFFooPswNVfdMuelsnZ8qNUk=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=euCwErU2++zF7/Jm3r4NkeqCD14EJ7tXh5lh66IoOqY=;
	h=date:mime-version:subject:message-id:from;

Is new controller:
Support CAN and CANFD protocol.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 .../net/can/rockchip/rockchip_canfd-core.c    | 453 +++++++++++++++---
 drivers/net/can/rockchip/rockchip_canfd-rx.c  | 111 ++++-
 drivers/net/can/rockchip/rockchip_canfd-tx.c  |  29 ++
 drivers/net/can/rockchip/rockchip_canfd.h     | 285 +++++++++++
 4 files changed, 820 insertions(+), 58 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index df18c85fc078..ceae691412d4 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -50,6 +50,11 @@ static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v3 = {
 		RKCANFD_QUIRK_CANFD_BROKEN,
 };
 
+/* The rk3576 CAN-FD */
+static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3576 = {
+	.model = RKCANFD_MODEL_RK3576,
+};
+
 static const char *__rkcanfd_get_model_str(enum rkcanfd_model model)
 {
 	switch (model) {
@@ -57,6 +62,8 @@ static const char *__rkcanfd_get_model_str(enum rkcanfd_model model)
 		return "rk3568v2";
 	case RKCANFD_MODEL_RK3568V3:
 		return "rk3568v3";
+	case RKCANFD_MODEL_RK3576:
+		return "rk3576";
 	}
 
 	return "<unknown>";
@@ -163,10 +170,21 @@ static void rkcanfd_get_berr_counter_corrected(struct rkcanfd_priv *priv,
 					       struct can_berr_counter *bec)
 {
 	struct can_berr_counter bec_raw;
-	u32 reg_state;
+	u32 reg_state, rxerr, txerr, busoff_state, error_war_state;
 
-	bec->rxerr = rkcanfd_read(priv, RKCANFD_REG_RXERRORCNT);
-	bec->txerr = rkcanfd_read(priv, RKCANFD_REG_TXERRORCNT);
+	if (priv->devtype_data.model == RKCANFD_MODEL_RK3576) {
+		rxerr = RK3576CANFD_REG_RXERRORCNT;
+		txerr = RK3576CANFD_REG_TXERRORCNT;
+		busoff_state = RK3576CANFD_REG_STATE_BUS_OFF_STATE;
+		error_war_state = RK3576CANFD_REG_STATE_ERROR_WARNING_STATE;
+	} else {
+		rxerr = RKCANFD_REG_RXERRORCNT;
+		txerr = RKCANFD_REG_TXERRORCNT;
+		busoff_state = RKCANFD_REG_STATE_BUS_OFF_STATE;
+		error_war_state = RKCANFD_REG_STATE_ERROR_WARNING_STATE;
+	}
+	bec->rxerr = rkcanfd_read(priv, rxerr);
+	bec->txerr = rkcanfd_read(priv, txerr);
 	bec_raw = *bec;
 
 	/* Tests show that sometimes both CAN bus error counters read
@@ -198,8 +216,8 @@ static void rkcanfd_get_berr_counter_corrected(struct rkcanfd_priv *priv,
 		    "%s: Raw/Cor: txerr=%3u/%3u rxerr=%3u/%3u Bus Off=%u Warning=%u\n",
 		    __func__,
 		    bec_raw.txerr, bec->txerr, bec_raw.rxerr, bec->rxerr,
-		    !!(reg_state & RKCANFD_REG_STATE_BUS_OFF_STATE),
-		    !!(reg_state & RKCANFD_REG_STATE_ERROR_WARNING_STATE));
+		    !!(reg_state & busoff_state),
+		    !!(reg_state & error_war_state));
 }
 
 static int rkcanfd_get_berr_counter(const struct net_device *ndev,
@@ -229,28 +247,106 @@ static void rkcanfd_chip_interrupts_enable(const struct rkcanfd_priv *priv)
 
 static void rkcanfd_chip_interrupts_disable(const struct rkcanfd_priv *priv)
 {
-	rkcanfd_write(priv, RKCANFD_REG_INT_MASK, RKCANFD_REG_INT_ALL);
+	if (priv->devtype_data.model == RKCANFD_MODEL_RK3576)
+		rkcanfd_write(priv, RK3576CANFD_REG_INT_MASK, RK3576CANFD_REG_INT_ALL);
+	else
+		rkcanfd_write(priv, RKCANFD_REG_INT_MASK, RKCANFD_REG_INT_ALL);
 }
 
 static void rkcanfd_chip_fifo_setup(struct rkcanfd_priv *priv)
 {
-	u32 reg;
-
-	/* TXE FIFO */
-	reg = rkcanfd_read(priv, RKCANFD_REG_RX_FIFO_CTRL);
-	reg |= RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_ENABLE;
-	rkcanfd_write(priv, RKCANFD_REG_RX_FIFO_CTRL, reg);
-
-	/* RX FIFO */
-	reg = rkcanfd_read(priv, RKCANFD_REG_RX_FIFO_CTRL);
-	reg |= RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_ENABLE;
-	rkcanfd_write(priv, RKCANFD_REG_RX_FIFO_CTRL, reg);
+	u32 reg, ism = 0, water = 0;
+
+	if (priv->devtype_data.model == RKCANFD_MODEL_RK3576) {
+		if (priv->rx_max_data > 4) {
+			ism = RK3576CANFD_DATA_CANFD_FIXED;
+			water = RK3576CANFD_ISM_WATERMASK_CANFD;
+		} else {
+			ism = RK3576CANFD_DATA_CAN_FIXED;
+			water = RK3576CANFD_ISM_WATERMASK_CAN;
+		}
 
+		/* internal sram mode */
+		rkcanfd_write(priv, RK3576CANFD_REG_STR_CTL,
+			      (ism << RK3576CANFD_ISM_SEL_SHIFT) |
+			      RK3576CANFD_STORAGE_TIMEOUT_MODE);
+		rkcanfd_write(priv, RK3576CANFD_REG_STR_WTM, water);
+	} else {
+		/* TXE FIFO */
+		reg = rkcanfd_read(priv, RKCANFD_REG_RX_FIFO_CTRL);
+		reg |= RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_ENABLE;
+		rkcanfd_write(priv, RKCANFD_REG_RX_FIFO_CTRL, reg);
+
+		/* RX FIFO */
+		reg = rkcanfd_read(priv, RKCANFD_REG_RX_FIFO_CTRL);
+		reg |= RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_ENABLE;
+		rkcanfd_write(priv, RKCANFD_REG_RX_FIFO_CTRL, reg);
+	}
 	WRITE_ONCE(priv->tx_head, 0);
 	WRITE_ONCE(priv->tx_tail, 0);
 	netdev_reset_queue(priv->ndev);
 }
 
+static int rk3576canfd_atf_config(struct rkcanfd_priv *priv, int mode)
+{
+	u32 id[10] = {0};
+	u32 dlc = 0, dlc_over = 0;
+
+	switch (mode) {
+	case RK3576CANFD_ATF_MASK_MODE:
+		rkcanfd_write(priv, RK3576CANFD_REG_ATF0, id[0]);
+		rkcanfd_write(priv, RK3576CANFD_REG_ATF1, id[1]);
+		rkcanfd_write(priv, RK3576CANFD_REG_ATF2, id[2]);
+		rkcanfd_write(priv, RK3576CANFD_REG_ATF3, id[3]);
+		rkcanfd_write(priv, RK3576CANFD_REG_ATF4, id[4]);
+		rkcanfd_write(priv, RK3576CANFD_REG_ATFM0, 0x7fff);
+		rkcanfd_write(priv, RK3576CANFD_REG_ATFM1, 0x7fff);
+		rkcanfd_write(priv, RK3576CANFD_REG_ATFM2, 0x7fff);
+		rkcanfd_write(priv, RK3576CANFD_REG_ATFM3, 0x7fff);
+		rkcanfd_write(priv, RK3576CANFD_REG_ATFM4, 0x7fff);
+		break;
+	case RK3576CANFD_ATF_LIST_MODE:
+		rkcanfd_write(priv, RK3576CANFD_REG_ATF0, id[0]);
+		rkcanfd_write(priv, RK3576CANFD_REG_ATF1, id[1]);
+		rkcanfd_write(priv, RK3576CANFD_REG_ATF2, id[2]);
+		rkcanfd_write(priv, RK3576CANFD_REG_ATF3, id[3]);
+		rkcanfd_write(priv, RK3576CANFD_REG_ATF4, id[4]);
+		rkcanfd_write(priv, RK3576CANFD_REG_ATFM0, id[5] | (1 << 31));
+		rkcanfd_write(priv, RK3576CANFD_REG_ATFM1, id[6] | (1 << 31));
+		rkcanfd_write(priv, RK3576CANFD_REG_ATFM2, id[7] | (1 << 31));
+		rkcanfd_write(priv, RK3576CANFD_REG_ATFM3, id[8] | (1 << 31));
+		rkcanfd_write(priv, RK3576CANFD_REG_ATFM4, id[9] | (1 << 31));
+		break;
+	default:
+		rkcanfd_write(priv, RK3576CANFD_REG_ATF_CTL, 0xffff);
+		return -EINVAL;
+	}
+
+	if (dlc) {
+		if (dlc_over)
+			rkcanfd_write(priv, RK3576CANFD_REG_ATF_DLC, dlc | (1 << 4));
+		else
+			rkcanfd_write(priv, RK3576CANFD_REG_ATF_DLC, dlc | (1 << 4) | (1 << 5));
+	}
+	rkcanfd_write(priv, RK3576CANFD_REG_ATF_CTL, 0);
+
+	return 0;
+}
+
+static void rk3576canfd_init(struct rkcanfd_priv *priv)
+{
+	rkcanfd_write(priv, RK3576CANFD_REG_AUTO_RETX_CFG,
+		      RK3576CANFD_AUTO_RETX_EN | RK3576CANFD_RETX_LIMIT_EN |
+		      (RK3576CANFD_RETX_TIME_LIMIT_CNT << RK3576CANFD_RETX_TIME_LIMIT_SHIFT));
+
+	rkcanfd_write(priv, RK3576CANFD_REG_BRS_CFG, 0x7);
+
+	rkcanfd_write(priv, RK3576CANFD_REG_BUSOFFRCY_CFG,
+		      RK3576CANFD_BUSOFF_RCY_MODE_EN |
+		      RK3576CANFD_BUSOFF_RCY_CNT_FAST);
+	rkcanfd_write(priv, RK3576CANFD_REG_BUSOFF_RCY_THR, RK3576CANFD_BUSOFF_RCY_TIME_FAST);
+}
+
 static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
 {
 	u32 reg;
@@ -258,8 +354,12 @@ static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
 	rkcanfd_chip_set_reset_mode(priv);
 
 	/* Receiving Filter: accept all */
-	rkcanfd_write(priv, RKCANFD_REG_IDCODE, 0x0);
-	rkcanfd_write(priv, RKCANFD_REG_IDMASK, RKCANFD_REG_IDCODE_EXTENDED_FRAME_ID);
+	if (priv->devtype_data.model == RKCANFD_MODEL_RK3576) {
+		rk3576canfd_atf_config(priv, RK3576CANFD_ATF_MASK_MODE);
+	} else {
+		rkcanfd_write(priv, RKCANFD_REG_IDCODE, 0x0);
+		rkcanfd_write(priv, RKCANFD_REG_IDMASK, RKCANFD_REG_IDCODE_EXTENDED_FRAME_ID);
+	}
 
 	/* enable:
 	 * - CAN_FD: enable CAN-FD
@@ -269,17 +369,26 @@ static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
 	 * - WORK_MODE: transition from reset to working mode
 	 */
 	reg = rkcanfd_read(priv, RKCANFD_REG_MODE);
-	priv->reg_mode_default = reg |
-		RKCANFD_REG_MODE_CAN_FD_MODE_ENABLE |
-		RKCANFD_REG_MODE_AUTO_RETX_MODE |
-		RKCANFD_REG_MODE_COVER_MODE |
-		RKCANFD_REG_MODE_RXSTX_MODE |
-		RKCANFD_REG_MODE_WORK_MODE;
-
-	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
-		priv->reg_mode_default |= RKCANFD_REG_MODE_LBACK_MODE |
-			RKCANFD_REG_MODE_SILENT_MODE |
-			RKCANFD_REG_MODE_SELF_TEST;
+	if (priv->devtype_data.model == RKCANFD_MODEL_RK3576)
+		priv->reg_mode_default = reg | RKCANFD_REG_MODE_WORK_MODE;
+	else
+		priv->reg_mode_default = reg |
+			RKCANFD_REG_MODE_CAN_FD_MODE_ENABLE |
+			RKCANFD_REG_MODE_AUTO_RETX_MODE |
+			RKCANFD_REG_MODE_COVER_MODE |
+			RKCANFD_REG_MODE_RXSTX_MODE |
+			RKCANFD_REG_MODE_WORK_MODE;
+
+	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
+		if (priv->devtype_data.model == RKCANFD_MODEL_RK3576) {
+			priv->reg_mode_default |= RKCANFD_REG_MODE_LBACK_MODE;
+			rkcanfd_write(priv, RK3576CANFD_REG_ERROR_MASK, RK3576CANFD_ACK_ERROR_MASK);
+		} else {
+			priv->reg_mode_default |= RKCANFD_REG_MODE_LBACK_MODE |
+				RKCANFD_REG_MODE_SILENT_MODE |
+				RKCANFD_REG_MODE_SELF_TEST;
+		}
+	}
 
 	/* mask, i.e. ignore:
 	 * - TIMESTAMP_COUNTER_OVERFLOW_INT - timestamp counter overflow interrupt
@@ -287,11 +396,14 @@ static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
 	 * - OVERLOAD_INT - CAN bus overload interrupt
 	 * - TX_FINISH_INT - Transmit finish interrupt
 	 */
-	priv->reg_int_mask_default =
-		RKCANFD_REG_INT_TIMESTAMP_COUNTER_OVERFLOW_INT |
-		RKCANFD_REG_INT_TX_ARBIT_FAIL_INT |
-		RKCANFD_REG_INT_OVERLOAD_INT |
-		RKCANFD_REG_INT_TX_FINISH_INT;
+	if (priv->devtype_data.model == RKCANFD_MODEL_RK3576)
+		priv->reg_int_mask_default = RK3576CANFD_REG_INT_RX_FINISH_INT;
+	else
+		priv->reg_int_mask_default =
+			RKCANFD_REG_INT_TIMESTAMP_COUNTER_OVERFLOW_INT |
+			RKCANFD_REG_INT_TX_ARBIT_FAIL_INT |
+			RKCANFD_REG_INT_OVERLOAD_INT |
+			RKCANFD_REG_INT_TX_FINISH_INT;
 
 	/* Do not mask the bus error interrupt if the bus error
 	 * reporting is requested.
@@ -302,8 +414,13 @@ static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
 	memset(&priv->bec, 0x0, sizeof(priv->bec));
 
 	rkcanfd_chip_fifo_setup(priv);
-	rkcanfd_timestamp_init(priv);
-	rkcanfd_timestamp_start(priv);
+	if (priv->devtype_data.model != RKCANFD_MODEL_RK3576) {
+		rkcanfd_timestamp_init(priv);
+		rkcanfd_timestamp_start(priv);
+	}
+
+	if (priv->devtype_data.model == RKCANFD_MODEL_RK3576)
+		rk3576canfd_init(priv);
 
 	rkcanfd_set_bittiming(priv);
 
@@ -328,7 +445,8 @@ static void rkcanfd_chip_stop(struct rkcanfd_priv *priv, const enum can_state st
 {
 	priv->can.state = state;
 
-	rkcanfd_timestamp_stop(priv);
+	if (priv->devtype_data.model != RKCANFD_MODEL_RK3576)
+		rkcanfd_timestamp_stop(priv);
 	__rkcanfd_chip_stop(priv, state);
 }
 
@@ -336,7 +454,8 @@ static void rkcanfd_chip_stop_sync(struct rkcanfd_priv *priv, const enum can_sta
 {
 	priv->can.state = state;
 
-	rkcanfd_timestamp_stop_sync(priv);
+	if (priv->devtype_data.model != RKCANFD_MODEL_RK3576)
+		rkcanfd_timestamp_stop_sync(priv);
 	__rkcanfd_chip_stop(priv, state);
 }
 
@@ -395,6 +514,9 @@ static const char *rkcanfd_get_error_type_str(unsigned int type)
 #define RKCAN_ERROR_CODE(reg_ec, code) \
 	((reg_ec) & RKCANFD_REG_ERROR_CODE_##code ? __stringify(code) " " : "")
 
+#define RK3576CAN_ERROR_CODE(reg_ec, code) \
+	((reg_ec) & RK3576CANFD_REG_ERROR_CODE_##code ? __stringify(code) " " : "")
+
 static void
 rkcanfd_handle_error_int_reg_ec(struct rkcanfd_priv *priv, struct can_frame *cf,
 				const u32 reg_ec)
@@ -524,6 +646,128 @@ rkcanfd_handle_error_int_reg_ec(struct rkcanfd_priv *priv, struct can_frame *cf,
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
@@ -532,13 +776,19 @@ static int rkcanfd_handle_error_int(struct rkcanfd_priv *priv)
 	struct sk_buff *skb;
 	int err;
 
-	reg_ec = rkcanfd_read(priv, RKCANFD_REG_ERROR_CODE);
+	if (priv->devtype_data.model == RKCANFD_MODEL_RK3576)
+		reg_ec = rkcanfd_read(priv, RK3576CANFD_REG_ERROR_CODE);
+	else
+		reg_ec = rkcanfd_read(priv, RKCANFD_REG_ERROR_CODE);
 
 	if (!reg_ec)
 		return 0;
 
 	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) {
-		skb = rkcanfd_alloc_can_err_skb(priv, &cf, &timestamp);
+		if (priv->devtype_data.model == RKCANFD_MODEL_RK3576)
+			skb = alloc_can_err_skb(priv->ndev, &cf);
+		else
+			skb = rkcanfd_alloc_can_err_skb(priv, &cf, &timestamp);
 		if (cf) {
 			struct can_berr_counter bec;
 
@@ -549,12 +799,18 @@ static int rkcanfd_handle_error_int(struct rkcanfd_priv *priv)
 		}
 	}
 
-	rkcanfd_handle_error_int_reg_ec(priv, cf, reg_ec);
+	if (priv->devtype_data.model == RKCANFD_MODEL_RK3576)
+		rk3576canfd_handle_error_int_reg_ec(priv, cf, reg_ec);
+	else
+		rkcanfd_handle_error_int_reg_ec(priv, cf, reg_ec);
 
 	if (!cf)
 		return 0;
 
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	if (priv->devtype_data.model == RKCANFD_MODEL_RK3576)
+		err = can_rx_offload_queue_tail(&priv->offload, skb);
+	else
+		err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
 	if (err)
 		stats->rx_fifo_errors++;
 
@@ -582,7 +838,10 @@ static int rkcanfd_handle_state_error_int(struct rkcanfd_priv *priv)
 	/* The skb allocation might fail, but can_change_state()
 	 * handles cf == NULL.
 	 */
-	skb = rkcanfd_alloc_can_err_skb(priv, &cf, &timestamp);
+	if (priv->devtype_data.model == RKCANFD_MODEL_RK3576)
+		skb = alloc_can_err_skb(priv->ndev, &cf);
+	else
+		skb = rkcanfd_alloc_can_err_skb(priv, &cf, &timestamp);
 	can_change_state(ndev, cf, tx_state, rx_state);
 
 	if (new_state == CAN_STATE_BUS_OFF) {
@@ -599,7 +858,10 @@ static int rkcanfd_handle_state_error_int(struct rkcanfd_priv *priv)
 		cf->data[7] = bec.rxerr;
 	}
 
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	if (priv->devtype_data.model == RKCANFD_MODEL_RK3576)
+		err = can_rx_offload_queue_tail(&priv->offload, skb);
+	else
+		err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
 	if (err)
 		stats->rx_fifo_errors++;
 
@@ -621,7 +883,10 @@ rkcanfd_handle_rx_fifo_overflow_int(struct rkcanfd_priv *priv)
 
 	netdev_dbg(priv->ndev, "RX-FIFO overflow\n");
 
-	skb = rkcanfd_alloc_can_err_skb(priv, &cf, &timestamp);
+	if (priv->devtype_data.model == RKCANFD_MODEL_RK3576)
+		skb = alloc_can_err_skb(priv->ndev, &cf);
+	else
+		skb = rkcanfd_alloc_can_err_skb(priv, &cf, &timestamp);
 	if (skb)
 		return 0;
 
@@ -632,7 +897,10 @@ rkcanfd_handle_rx_fifo_overflow_int(struct rkcanfd_priv *priv)
 	cf->data[6] = bec.txerr;
 	cf->data[7] = bec.rxerr;
 
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	if (priv->devtype_data.model == RKCANFD_MODEL_RK3576)
+		err = can_rx_offload_queue_tail(&priv->offload, skb);
+	else
+		err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
 	if (err)
 		stats->rx_fifo_errors++;
 
@@ -652,11 +920,58 @@ rkcanfd_handle_rx_fifo_overflow_int(struct rkcanfd_priv *priv)
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
+		       RK3576CANFD_REG_INT_RX_FIFO_FULL_INT))
+		rkcanfd_handle(priv, rx_int);
+
+	if (reg_int & RK3576CANFD_REG_INT_TX_FINISH_INT)
+		rkcanfd_handle(priv, tx_int);
+
+	if (reg_int & RK3576CANFD_REG_INT_ERROR_INT)
+		rkcanfd_handle(priv, error_int);
+
+	if (reg_int & (RK3576CANFD_REG_INT_BUS_OFF_INT |
+		       RK3576CANFD_REG_INT_PASSIVE_ERROR_INT |
+		       RK3576CANFD_REG_INT_ERROR_WARNING_INT) ||
+	    priv->can.state > CAN_STATE_ERROR_ACTIVE)
+		rkcanfd_handle(priv, state_error_int);
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
 	u32 reg_int_unmasked, reg_int;
 
+	if (priv->devtype_data.model == RKCANFD_MODEL_RK3576)
+		return rk3576canfd_irq(irq, dev_id);
+
 	reg_int_unmasked = rkcanfd_read(priv, RKCANFD_REG_INT);
 	reg_int = reg_int_unmasked & ~priv->reg_int_mask_default;
 
@@ -789,14 +1104,21 @@ static void rkcanfd_register_done(const struct rkcanfd_priv *priv)
 {
 	u32 dev_id;
 
-	dev_id = rkcanfd_read(priv, RKCANFD_REG_RTL_VERSION);
+	if (priv->devtype_data.model == RKCANFD_MODEL_RK3576) {
+		dev_id = rkcanfd_read(priv, RK3576CANFD_REG_RTL_VERSION);
+		netdev_info(priv->ndev,
+			    "Rockchip-CANFD %s rev%u.\n",
+			    rkcanfd_get_model_str(priv), dev_id);
+	} else {
+		dev_id = rkcanfd_read(priv, RKCANFD_REG_RTL_VERSION);
 
-	netdev_info(priv->ndev,
-		    "Rockchip-CANFD %s rev%lu.%lu (errata 0x%04x) found\n",
-		    rkcanfd_get_model_str(priv),
-		    FIELD_GET(RKCANFD_REG_RTL_VERSION_MAJOR, dev_id),
-		    FIELD_GET(RKCANFD_REG_RTL_VERSION_MINOR, dev_id),
-		    priv->devtype_data.quirks);
+		netdev_info(priv->ndev,
+			    "Rockchip-CANFD %s rev%lu.%lu (errata 0x%04x) found\n",
+			    rkcanfd_get_model_str(priv),
+			    FIELD_GET(RKCANFD_REG_RTL_VERSION_MAJOR, dev_id),
+			    FIELD_GET(RKCANFD_REG_RTL_VERSION_MINOR, dev_id),
+			    priv->devtype_data.quirks);
+	}
 
 	if (priv->devtype_data.quirks & RKCANFD_QUIRK_RK3568_ERRATUM_5 &&
 	    priv->can.clock.freq < RKCANFD_ERRATUM_5_SYSCLOCK_HZ_MIN)
@@ -852,6 +1174,9 @@ static const struct of_device_id rkcanfd_of_match[] = {
 	}, {
 		.compatible = "rockchip,rk3568v3-canfd",
 		.data = &rkcanfd_devtype_data_rk3568v3,
+	},  {
+		.compatible = "rockchip,rk3576-canfd",
+		.data = &rkcanfd_devtype_data_rk3576,
 	}, {
 		/* sentinel */
 	},
@@ -863,7 +1188,7 @@ static int rkcanfd_probe(struct platform_device *pdev)
 	struct rkcanfd_priv *priv;
 	struct net_device *ndev;
 	const void *match;
-	int err;
+	int err, val;
 
 	ndev = alloc_candev(sizeof(struct rkcanfd_priv), RKCANFD_TXFIFO_DEPTH);
 	if (!ndev)
@@ -917,8 +1242,24 @@ static int rkcanfd_probe(struct platform_device *pdev)
 	if (match)
 		priv->devtype_data = *(struct rkcanfd_devtype_data *)match;
 
+	/* rx-max-data only 4 Words or 18 words are supported */
+	if (device_property_read_u32_array(&pdev->dev, "rockchip,rx-max-data", &val, 1))
+		priv->rx_max_data = 18;
+	else
+		priv->rx_max_data = val;
+
+	if (priv->rx_max_data != 4 && priv->rx_max_data != 18) {
+		priv->rx_max_data = 18;
+		dev_warn(&pdev->dev, "rx_max_data is invalid, set to 18 words!\n");
+	}
+	priv->rx_fifo_depth = RK3576CANFD_SRAM_MAX_DEPTH / priv->rx_max_data;
+
+	if (priv->devtype_data.model == RKCANFD_MODEL_RK3576)
+		val = priv->rx_fifo_depth + 1;
+	else
+		val = RKCANFD_NAPI_WEIGHT;
 	err = can_rx_offload_add_manual(ndev, &priv->offload,
-					RKCANFD_NAPI_WEIGHT);
+					val);
 	if (err)
 		goto out_free_candev;
 
diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index 475c0409e215..7dad674dc545 100644
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
@@ -198,6 +239,62 @@ rkcanfd_fifo_header_empty(const struct rkcanfd_fifo_header *header)
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
+			 cfd->data, (priv->rx_max_data - 2) * 4);
+
+	len = rk3576canfd_fifo_header_to_cfd_header(priv, header, cfd);
+
+	/* Drop any received CAN-FD frames if CAN-FD mode is not
+	 * requested.
+	 */
+	if (header->frameinfo & RKCANFD_REG_FD_FRAMEINFO_FDF &&
+	    !(priv->can.ctrlmode & CAN_CTRLMODE_FD)) {
+		stats->rx_dropped++;
+
+		return 0;
+	}
+
+	/* Manual handling of CAN Bus Error counters. See
+	 * rkcanfd_get_corrected_berr_counter() for detailed
+	 * explanation.
+	 */
+	if (priv->bec.rxerr)
+		priv->bec.rxerr = min(CAN_ERROR_PASSIVE_THRESHOLD,
+				      priv->bec.rxerr) - 1;
+
+	if (header->frameinfo & RKCANFD_REG_FD_FRAMEINFO_FDF)
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
@@ -207,6 +304,9 @@ static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
 	unsigned int len;
 	int err;
 
+	if (priv->devtype_data.model == RKCANFD_MODEL_RK3576)
+		return rk3576canfd_handle_rx_int_one(priv);
+
 	/* read header into separate struct and convert it later */
 	rkcanfd_read_rep(priv, RKCANFD_REG_RX_FIFO_RDATA,
 			 header, sizeof(*header));
@@ -279,9 +379,16 @@ static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
 static inline unsigned int
 rkcanfd_rx_fifo_get_len(const struct rkcanfd_priv *priv)
 {
-	const u32 reg = rkcanfd_read(priv, RKCANFD_REG_RX_FIFO_CTRL);
+	u32 reg, len;
 
-	return FIELD_GET(RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT, reg);
+	if (priv->devtype_data.model == RKCANFD_MODEL_RK3576) {
+		reg = rkcanfd_read(priv, RK3576CANFD_REG_STR_STATE);
+		len = FIELD_GET(RK3576CANFD_REG_INTM_FRAME_CNT, reg);
+	} else {
+		reg = rkcanfd_read(priv, RKCANFD_REG_RX_FIFO_CTRL);
+		len = FIELD_GET(RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT, reg);
+	}
+	return len;
 }
 
 int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv)
diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
index 865a15e033a9..e00f3447928f 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -165,3 +165,32 @@ void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 ts,
 							    frame_len_p);
 	stats->tx_packets++;
 }
+
+int rkcanfd_handle_tx_int(struct rkcanfd_priv *priv)
+{
+	struct net_device_stats *stats = &priv->ndev->stats;
+	unsigned int tx_tail;
+	struct sk_buff *skb;
+	unsigned int frame_len = 0;
+
+	tx_tail = rkcanfd_get_tx_tail(priv);
+	skb = priv->can.echo_skb[tx_tail];
+
+	/* Manual handling of CAN Bus Error counters. See
+	 * rkcanfd_get_corrected_berr_counter() for detailed
+	 * explanation.
+	 */
+	if (priv->bec.txerr)
+		priv->bec.txerr--;
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
index 93131c7d7f54..17f099ee08cf 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -287,6 +287,282 @@
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
+#define RK3576CANFD_REG_STR_STATE 0x604
+#define RK3576CANFD_REG_INTM_FRAME_CNT GENMASK(25, 17)
+
+#define RK3576CANFD_REG_STR_TIMEOUT 0x608
+
+#define RK3576CANFD_BUFFER_MODE_ENABLE BIT(0)
+#define RK3576CANFD_EXT_STORAGE_MODE BIT(1)
+#define RK3576CANFD_ISM_SEL_SHIFT 2
+#define RK3576CANFD_ISM_SEL_MASK (0x3 << RK3576CANFD_ISM_SEL_SHIFT)
+#define RK3576CANFD_RX_STORAGE_RESET BIT(4)
+#define RK3576CANFD_ESM_SEL_SHIFT 6
+#define RK3576CANFD_ESM_SEL_MASK (0x3 << RK3576CANFD_ESM_SEL_SHIFT)
+#define RK3576CANFD_STORAGE_TIMEOUT_MODE BIT(8)
+
+#define RK3576CANFD_INTM_CNT_SHIFT 17
+#define RK3576CANFD_INTM_CNT_MASK (0x1ff << RK3576CANFD_INTM_CNT_SHIFT)
+#define RK3576CANFD_INTM_LEFT_CNT_SHIFT 8
+#define RK3576CANFD_INTM_LEFT_CNT_MASK (0x1ff << RK3576CANFD_INTM_LEFT_CNT_SHIFT)
+#define RK3576CANFD_EXTM_FULL BIT(3)
+#define RK3576CANFD_EXTM_EMPTY BIT(2)
+#define RK3576CANFD_INTM_FULL BIT(1)
+#define RK3576CANFD_INTM_EMPTY BIT(0)
+
+#define RK3576CANFD_REG_STR_WTM 0x60c
+#define RK3576CANFD_REG_ATF0 0x700
+#define RK3576CANFD_REG_ATF1 0x704
+#define RK3576CANFD_REG_ATF2 0x708
+#define RK3576CANFD_REG_ATF3 0x70c
+#define RK3576CANFD_REG_ATF4 0x710
+#define RK3576CANFD_REG_ATFM0 0x714
+#define RK3576CANFD_REG_ATFM1 0x718
+#define RK3576CANFD_REG_ATFM2 0x71c
+#define RK3576CANFD_REG_ATFM3 0x720
+#define RK3576CANFD_REG_ATFM4 0x724
+#define RK3576CANFD_REG_ATF_DLC 0x728
+#define RK3576CANFD_REG_ATF_CTL 0x72c
+#define RK3576CANFD_ATF_MASK BIT(31)
+#define RK3576CANFD_ATF_RTR_EN BIT(30)
+#define RK3576CANFD_ATF_RTR BIT(29)
+#define RK3576CANFD_ATF_DLC_MODE BIT(5)
+#define RK3576CANFD_ATF_DLC_EN BIT(4)
+#define RK3576CANFD_ATF_DLC_SHIFT 0
+#define RK3576CANFD_ATF_DLC_MASK (0xf << RK3576CANFD_ATF_DLC_SHIFT)
+#define RK3576CANFD_ATF_DIS(n) BIT(n)
+
+#define RK3576CANFD_REG_SPACE_CTRL 0x800
+
+#define RK3576CANFD_REG_AUTO_RETX_CFG 0x808
+#define RK3576CANFD_RETX_TIME_LIMIT_CNT 0x12c /* 300 */
+#define RK3576CANFD_RETX_TIME_LIMIT_SHIFT 3
+#define RK3576CANFD_RETX_LIMIT_EN BIT(1)
+#define RK3576CANFD_AUTO_RETX_EN BIT(0)
+
+#define RK3576CANFD_REG_AUTO_RETX_STATE0 0x80c
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
+#define RK3576CANFD_BUSOFF_RCY_MODE_EN BIT(8)
+#define RK3576CANFD_BUSOFF_RCY_TIME_CLR BIT(9)
+#define RK3576CANFD_BUSOFF_RCY_CNT_FAST 4
+#define RK3576CANFD_BUSOFF_RCY_CNT_SLOW 5
+#define RK3576CANFD_BUSOFF_RCY_TIME_FAST 0x3d0900 /* 40ms : cnt * (1 / can_clk) */
+#define RK3576CANFD_BUSOFF_RCY_TIME_SLOW 0x1312d00 /* 200ms : cnt * (1 / can_clk) */
+
+#define RK3576CANFD_REG_ERROR_CODE 0x900
+#define RK3576CANFD_REG_ERROR_MASK 0x904
+#define RK3576CANFD_ACK_ERROR_MASK BIT(4)
+#define RK3576CANFD_FORM_ERROR_MASK BIT(3)
+#define RK3576CANFD_CRC_ERROR_MASK BIT(2)
+#define RK3576CANFD_STUFF_ERROR_MASK BIT(1)
+#define RK3576CANFD_BIT_ERROR_MASK BIT(0)
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
+#define RK3576CANFD_ESM_WATERMASK (0x50 << 8) /* word */
+
+#define RK3576CANFD_SRAM_MAX_DEPTH 256 /* word */
+#define RK3576CANFD_EXT_MEM_SIZE 0x2000 /* 8KByte */
+
+#define RK3576CANFD_CANFD_FILTER_MASK 0x1fffffff
+
+#define RK3576CANFD_CANFD_FIFO_CNT_MASK 0xff
+
+#define RK3576CANFD_CANBUSOFF_RCY_SLOW 200 /* ms */
+#define RK3576CANFD_CANBUSOFF_RCY_FAST 30 /* ms */
+
+enum rk3576canfd_atf_mode {
+	RK3576CANFD_ATF_MASK_MODE = 0,
+	RK3576CANFD_ATF_LIST_MODE,
+};
+
+enum rk3576canfd_storage_mode {
+	RK3576CANFD_DATA_FLEXIBLE = 0,
+	RK3576CANFD_DATA_CAN_FIXED,
+	RK3576CANFD_DATA_CANFD_FIXED,
+};
+
 #define DEVICE_NAME "rockchip_canfd"
 #define RKCANFD_NAPI_WEIGHT 32
 #define RKCANFD_TXFIFO_DEPTH 2
@@ -434,6 +710,7 @@
 enum rkcanfd_model {
 	RKCANFD_MODEL_RK3568V2 = 0x35682,
 	RKCANFD_MODEL_RK3568V3 = 0x35683,
+	RKCANFD_MODEL_RK3576 = 0x3576,
 };
 
 struct rkcanfd_devtype_data {
@@ -447,6 +724,11 @@ struct rkcanfd_fifo_header {
 	u32 ts;
 };
 
+struct rk3576canfd_fifo_header {
+	u32 frameinfo;
+	u32 id;
+};
+
 struct rkcanfd_stats {
 	struct u64_stats_sync syncp;
 
@@ -482,6 +764,8 @@ struct rkcanfd_priv {
 	struct reset_control *reset;
 	struct clk_bulk_data *clks;
 	int clks_num;
+	int rx_fifo_depth;
+	int rx_max_data;
 };
 
 static inline u32
@@ -536,6 +820,7 @@ rkcanfd_get_tx_free(const struct rkcanfd_priv *priv)
 void rkcanfd_ethtool_init(struct rkcanfd_priv *priv);
 
 int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv);
+int rkcanfd_handle_tx_int(struct rkcanfd_priv *priv);
 
 void rkcanfd_skb_set_timestamp(const struct rkcanfd_priv *priv,
 			       struct sk_buff *skb, const u32 timestamp);
-- 
2.34.1


