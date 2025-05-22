Return-Path: <linux-can+bounces-3620-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AEFAC04B5
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 08:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19524E3BF6
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 06:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCE92222CE;
	Thu, 22 May 2025 06:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="SldgWqCV"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m3270.qiye.163.com (mail-m3270.qiye.163.com [220.197.32.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036F7221F10;
	Thu, 22 May 2025 06:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747895879; cv=none; b=CSDz+SIQcZfv5q3Fx2lGEmqiELcqPes6E4/m1Jwowli4XJM185UIcz12ek7C+GEMHGyLSQjPdsWU/M6Jeerz4fkwu4gfJNeCr1t9wP3tHbldhbwn2TBF8UOHphBwPUnbP8lu2S8uvraXPPJsvTPHoI4LBbxrMbM0Wjj85RwBlu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747895879; c=relaxed/simple;
	bh=GWNEhsQy5OkbVOGvNI9dPJvXo7x0rbTJBzCTumUPU/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pWoi9qrTN5ygPRq/xza6+RXWdl8LDpqfBmh5rvN6dFzBsNEFknWnm7eGgpzN35Gy6kVaMOoA3EpB3JulWjzryDD2x3fR8RN+dhUP1NnBC4gUa7TNLyZV25CqINBYbUucDtfWVmSm/0n1iNCmyFy4IsRpeiEXA65JY3k1Ktoi2wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=SldgWqCV; arc=none smtp.client-ip=220.197.32.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1602d1570;
	Thu, 22 May 2025 14:32:37 +0800 (GMT+08:00)
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
Subject: [PATCH v3 2/3] net: can: rockchip: add can for RK3576 Soc
Date: Thu, 22 May 2025 14:32:31 +0800
Message-Id: <20250522063232.2197432-3-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250522063232.2197432-1-zhangqing@rock-chips.com>
References: <20250522063232.2197432-1-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkseQ1ZJGUwdSh9KTEMdSRlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96f6b19b8603a3kunme211611210aaae7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRQ6Mww4MzE3KhIeHEIzEA4I
	HxwwCgpVSlVKTE9MQ0JOTk5DTEJJVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU5PQkpONwY+
DKIM-Signature:a=rsa-sha256;
	b=SldgWqCV4EUEfkQZxUjyQ8P92vbdR6/OUHsdYI3X2s5nY2Vc/EynHSUzYQH3WfZjzrhioNAhU+MRos9wPvz1FhDXQLtRQjwfNh/VP4eDntLOwqAWEDTVBFPbqnk0YCX81jfVxvc3rM8KKfZgWapoKsYze+SdAEnwxIuZ08pTViY=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=UlPw4yx2WOnDBlgISXQM8sEatcPbanqC10OJmTNN23c=;
	h=date:mime-version:subject:message-id:from;

Is new controller:
Support CAN and CANFD protocol.
Support Dma.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 .../net/can/rockchip/rockchip_canfd-core.c    | 637 ++++++++++++++++--
 drivers/net/can/rockchip/rockchip_canfd-rx.c  | 193 ++++++
 drivers/net/can/rockchip/rockchip_canfd-tx.c  |  29 +
 drivers/net/can/rockchip/rockchip_canfd.h     | 312 +++++++++
 4 files changed, 1126 insertions(+), 45 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index df18c85fc078..7d821f39ac82 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -24,32 +24,6 @@
 
 #include "rockchip_canfd.h"
 
-static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v2 = {
-	.model = RKCANFD_MODEL_RK3568V2,
-	.quirks = RKCANFD_QUIRK_RK3568_ERRATUM_1 | RKCANFD_QUIRK_RK3568_ERRATUM_2 |
-		RKCANFD_QUIRK_RK3568_ERRATUM_3 | RKCANFD_QUIRK_RK3568_ERRATUM_4 |
-		RKCANFD_QUIRK_RK3568_ERRATUM_5 | RKCANFD_QUIRK_RK3568_ERRATUM_6 |
-		RKCANFD_QUIRK_RK3568_ERRATUM_7 | RKCANFD_QUIRK_RK3568_ERRATUM_8 |
-		RKCANFD_QUIRK_RK3568_ERRATUM_9 | RKCANFD_QUIRK_RK3568_ERRATUM_10 |
-		RKCANFD_QUIRK_RK3568_ERRATUM_11 | RKCANFD_QUIRK_RK3568_ERRATUM_12 |
-		RKCANFD_QUIRK_CANFD_BROKEN,
-};
-
-/* The rk3568 CAN-FD errata sheet as of Tue 07 Nov 2023 11:25:31 +08:00
- * states that only the rk3568v2 is affected by erratum 5, but tests
- * with the rk3568v2 and rk3568v3 show that the RX_FIFO_CNT is
- * sometimes too high. In contrast to the errata sheet mark rk3568v3
- * as effected by erratum 5, too.
- */
-static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v3 = {
-	.model = RKCANFD_MODEL_RK3568V3,
-	.quirks = RKCANFD_QUIRK_RK3568_ERRATUM_1 | RKCANFD_QUIRK_RK3568_ERRATUM_2 |
-		RKCANFD_QUIRK_RK3568_ERRATUM_5 | RKCANFD_QUIRK_RK3568_ERRATUM_7 |
-		RKCANFD_QUIRK_RK3568_ERRATUM_8 | RKCANFD_QUIRK_RK3568_ERRATUM_10 |
-		RKCANFD_QUIRK_RK3568_ERRATUM_11 | RKCANFD_QUIRK_RK3568_ERRATUM_12 |
-		RKCANFD_QUIRK_CANFD_BROKEN,
-};
-
 static const char *__rkcanfd_get_model_str(enum rkcanfd_model model)
 {
 	switch (model) {
@@ -57,6 +31,8 @@ static const char *__rkcanfd_get_model_str(enum rkcanfd_model model)
 		return "rk3568v2";
 	case RKCANFD_MODEL_RK3568V3:
 		return "rk3568v3";
+	case RKCANFD_MODEL_RK3576:
+		return "rk3576";
 	}
 
 	return "<unknown>";
@@ -202,6 +178,30 @@ static void rkcanfd_get_berr_counter_corrected(struct rkcanfd_priv *priv,
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
+	if (!bec->rxerr && !bec->txerr)
+		*bec = priv->bec;
+	else
+		priv->bec = *bec;
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
@@ -212,7 +212,7 @@ static int rkcanfd_get_berr_counter(const struct net_device *ndev,
 	if (err)
 		return err;
 
-	rkcanfd_get_berr_counter_corrected(priv, bec);
+	priv->devtype_data.get_berr_counter(priv, bec);
 
 	pm_runtime_put(ndev->dev.parent);
 
@@ -232,6 +232,11 @@ static void rkcanfd_chip_interrupts_disable(const struct rkcanfd_priv *priv)
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
@@ -245,12 +250,100 @@ static void rkcanfd_chip_fifo_setup(struct rkcanfd_priv *priv)
 	reg = rkcanfd_read(priv, RKCANFD_REG_RX_FIFO_CTRL);
 	reg |= RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_ENABLE;
 	rkcanfd_write(priv, RKCANFD_REG_RX_FIFO_CTRL, reg);
+	WRITE_ONCE(priv->tx_head, 0);
+	WRITE_ONCE(priv->tx_tail, 0);
+	netdev_reset_queue(priv->ndev);
+}
 
+static void rk3576canfd_chip_fifo_setup(struct rkcanfd_priv *priv)
+{
+	u32 ism = 0, water = 0;
+
+	if (priv->rx_max_data > 4) {
+		ism = RK3576CANFD_DATA_CANFD_FIXED;
+		water = RK3576CANFD_ISM_WATERMASK_CANFD;
+	} else {
+		ism = RK3576CANFD_DATA_CAN_FIXED;
+		water = RK3576CANFD_ISM_WATERMASK_CAN;
+	}
+
+	/* internal sram mode */
+	rkcanfd_write(priv, RK3576CANFD_REG_STR_CTL,
+		      (ism << RK3576CANFD_ISM_SEL_SHIFT) |
+		      RK3576CANFD_STORAGE_TIMEOUT_MODE);
+	rkcanfd_write(priv, RK3576CANFD_REG_STR_WTM, water);
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
+	if (priv->auto_retx_cnt)
+		rkcanfd_write(priv, RK3576CANFD_REG_AUTO_RETX_CFG,
+			      RK3576CANFD_AUTO_RETX_EN | RK3576CANFD_RETX_LIMIT_EN |
+			      (priv->auto_retx_cnt << RK3576CANFD_RETX_TIME_LIMIT_SHIFT));
+	else
+		rkcanfd_write(priv, RK3576CANFD_REG_AUTO_RETX_CFG, RK3576CANFD_AUTO_RETX_EN);
+
+	rkcanfd_write(priv, RK3576CANFD_REG_BRS_CFG, 0x7);
+
+	if (priv->use_dma)
+		rkcanfd_write(priv, RK3576CANFD_REG_DMA_CTRL,
+			      RK3576CANFD_REG_DMA_CTRL_DMA_RX_EN | priv->dma_thr);
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
@@ -301,13 +394,69 @@ static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
 
 	memset(&priv->bec, 0x0, sizeof(priv->bec));
 
-	rkcanfd_chip_fifo_setup(priv);
+	priv->devtype_data.fifo_setup(priv);
 	rkcanfd_timestamp_init(priv);
 	rkcanfd_timestamp_start(priv);
 
 	rkcanfd_set_bittiming(priv);
 
-	rkcanfd_chip_interrupts_disable(priv);
+	priv->devtype_data.interrupts_disable(priv);
+	rkcanfd_chip_set_work_mode(priv);
+
+	priv->can.state = CAN_STATE_ERROR_ACTIVE;
+
+	netdev_dbg(priv->ndev, "%s: reg_mode=0x%08x\n", __func__,
+		   rkcanfd_read(priv, RKCANFD_REG_MODE));
+}
+
+static void rk3576canfd_chip_start(struct rkcanfd_priv *priv)
+
+{
+	u32 reg;
+
+	rkcanfd_chip_set_reset_mode(priv);
+
+	/* Receiving Filter: accept all */
+	rk3576canfd_atf_config(priv, RK3576CANFD_ATF_MASK_MODE);
+
+	/* enable:
+	 * - CAN_FD: enable CAN-FD
+	 * - AUTO_RETX_MODE: auto retransmission on TX error
+	 * - COVER_MODE: RX-FIFO overwrite mode, do not send OVERLOAD frames
+	 * - RXSTX_MODE: Receive Self Transmit data mode
+	 * - WORK_MODE: transition from reset to working mode
+	 */
+	reg = rkcanfd_read(priv, RKCANFD_REG_MODE);
+	priv->reg_mode_default = reg | RKCANFD_REG_MODE_WORK_MODE;
+
+	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
+		priv->reg_mode_default |= RKCANFD_REG_MODE_LBACK_MODE;
+		rkcanfd_write(priv, RK3576CANFD_REG_ERROR_MASK, RK3576CANFD_ACK_ERROR_MASK);
+	}
+
+	/* mask, i.e. ignore:
+	 * - TIMESTAMP_COUNTER_OVERFLOW_INT - timestamp counter overflow interrupt
+	 * - TX_ARBIT_FAIL_INT - TX arbitration fail interrupt
+	 * - OVERLOAD_INT - CAN bus overload interrupt
+	 * - TX_FINISH_INT - Transmit finish interrupt
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
+	rk3576canfd_init(priv);
+
+	rkcanfd_set_bittiming(priv);
+
+	priv->devtype_data.interrupts_disable(priv);
 	rkcanfd_chip_set_work_mode(priv);
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
@@ -321,7 +470,7 @@ static void __rkcanfd_chip_stop(struct rkcanfd_priv *priv, const enum can_state
 	priv->can.state = state;
 
 	rkcanfd_chip_set_reset_mode(priv);
-	rkcanfd_chip_interrupts_disable(priv);
+	priv->devtype_data.interrupts_disable(priv);
 }
 
 static void rkcanfd_chip_stop(struct rkcanfd_priv *priv, const enum can_state state)
@@ -332,6 +481,13 @@ static void rkcanfd_chip_stop(struct rkcanfd_priv *priv, const enum can_state st
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
@@ -340,6 +496,13 @@ static void rkcanfd_chip_stop_sync(struct rkcanfd_priv *priv, const enum can_sta
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
@@ -347,8 +510,8 @@ static int rkcanfd_set_mode(struct net_device *ndev,
 
 	switch (mode) {
 	case CAN_MODE_START:
-		rkcanfd_chip_start(priv);
-		rkcanfd_chip_interrupts_enable(priv);
+		priv->devtype_data.chip_start(priv);
+		priv->devtype_data.interrupts_enable(priv);
 		netif_wake_queue(ndev);
 		break;
 
@@ -395,6 +558,9 @@ static const char *rkcanfd_get_error_type_str(unsigned int type)
 #define RKCAN_ERROR_CODE(reg_ec, code) \
 	((reg_ec) & RKCANFD_REG_ERROR_CODE_##code ? __stringify(code) " " : "")
 
+#define RK3576CAN_ERROR_CODE(reg_ec, code) \
+	((reg_ec) & RK3576CANFD_REG_ERROR_CODE_##code ? __stringify(code) " " : "")
+
 static void
 rkcanfd_handle_error_int_reg_ec(struct rkcanfd_priv *priv, struct can_frame *cf,
 				const u32 reg_ec)
@@ -524,6 +690,128 @@ rkcanfd_handle_error_int_reg_ec(struct rkcanfd_priv *priv, struct can_frame *cf,
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
@@ -542,7 +830,7 @@ static int rkcanfd_handle_error_int(struct rkcanfd_priv *priv)
 		if (cf) {
 			struct can_berr_counter bec;
 
-			rkcanfd_get_berr_counter_corrected(priv, &bec);
+			priv->devtype_data.get_berr_counter(priv, &bec);
 			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR | CAN_ERR_CNT;
 			cf->data[6] = bec.txerr;
 			cf->data[7] = bec.rxerr;
@@ -561,6 +849,41 @@ static int rkcanfd_handle_error_int(struct rkcanfd_priv *priv)
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
@@ -572,7 +895,7 @@ static int rkcanfd_handle_state_error_int(struct rkcanfd_priv *priv)
 	u32 timestamp;
 	int err;
 
-	rkcanfd_get_berr_counter_corrected(priv, &bec);
+	priv->devtype_data.get_berr_counter(priv, &bec);
 	can_state_get_by_berr_counter(ndev, &bec, &tx_state, &rx_state);
 
 	new_state = max(tx_state, rx_state);
@@ -586,7 +909,7 @@ static int rkcanfd_handle_state_error_int(struct rkcanfd_priv *priv)
 	can_change_state(ndev, cf, tx_state, rx_state);
 
 	if (new_state == CAN_STATE_BUS_OFF) {
-		rkcanfd_chip_stop(priv, CAN_STATE_BUS_OFF);
+		priv->devtype_data.chip_stop(priv, CAN_STATE_BUS_OFF);
 		can_bus_off(ndev);
 	}
 
@@ -606,6 +929,50 @@ static int rkcanfd_handle_state_error_int(struct rkcanfd_priv *priv)
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
@@ -625,7 +992,7 @@ rkcanfd_handle_rx_fifo_overflow_int(struct rkcanfd_priv *priv)
 	if (skb)
 		return 0;
 
-	rkcanfd_get_berr_counter_corrected(priv, &bec);
+	priv->devtype_data.get_berr_counter(priv, &bec);
 
 	cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
 	cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
@@ -652,6 +1019,55 @@ rkcanfd_handle_rx_fifo_overflow_int(struct rkcanfd_priv *priv)
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
@@ -724,21 +1140,21 @@ static int rkcanfd_open(struct net_device *ndev)
 	if (err)
 		goto out_close_candev;
 
-	rkcanfd_chip_start(priv);
+	priv->devtype_data.chip_start(priv);
 	can_rx_offload_enable(&priv->offload);
 
-	err = request_irq(ndev->irq, rkcanfd_irq, IRQF_SHARED, ndev->name, priv);
+	err = request_irq(ndev->irq, priv->devtype_data.irq, IRQF_SHARED, ndev->name, priv);
 	if (err)
 		goto out_rkcanfd_chip_stop;
 
-	rkcanfd_chip_interrupts_enable(priv);
+	priv->devtype_data.interrupts_enable(priv);
 
 	netif_start_queue(ndev);
 
 	return 0;
 
 out_rkcanfd_chip_stop:
-	rkcanfd_chip_stop_sync(priv, CAN_STATE_STOPPED);
+	priv->devtype_data.chip_stop_sync(priv, CAN_STATE_STOPPED);
 	pm_runtime_put(ndev->dev.parent);
 out_close_candev:
 	close_candev(ndev);
@@ -751,10 +1167,10 @@ static int rkcanfd_stop(struct net_device *ndev)
 
 	netif_stop_queue(ndev);
 
-	rkcanfd_chip_interrupts_disable(priv);
+	priv->devtype_data.interrupts_disable(priv);
 	free_irq(ndev->irq, priv);
 	can_rx_offload_disable(&priv->offload);
-	rkcanfd_chip_stop_sync(priv, CAN_STATE_STOPPED);
+	priv->devtype_data.chip_stop_sync(priv, CAN_STATE_STOPPED);
 	close_candev(ndev);
 
 	pm_runtime_put(ndev->dev.parent);
@@ -806,6 +1222,16 @@ static void rkcanfd_register_done(const struct rkcanfd_priv *priv)
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
@@ -823,7 +1249,7 @@ static int rkcanfd_register(struct rkcanfd_priv *priv)
 	if (err)
 		goto out_pm_runtime_put_sync;
 
-	rkcanfd_register_done(priv);
+	priv->devtype_data.register_done(priv);
 
 	pm_runtime_put(ndev->dev.parent);
 
@@ -845,6 +1271,64 @@ static inline void rkcanfd_unregister(struct rkcanfd_priv *priv)
 	pm_runtime_disable(ndev->dev.parent);
 }
 
+static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v2 = {
+	.model = RKCANFD_MODEL_RK3568V2,
+	.quirks = RKCANFD_QUIRK_RK3568_ERRATUM_1 | RKCANFD_QUIRK_RK3568_ERRATUM_2 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_3 | RKCANFD_QUIRK_RK3568_ERRATUM_4 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_5 | RKCANFD_QUIRK_RK3568_ERRATUM_6 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_7 | RKCANFD_QUIRK_RK3568_ERRATUM_8 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_9 | RKCANFD_QUIRK_RK3568_ERRATUM_10 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_11 | RKCANFD_QUIRK_RK3568_ERRATUM_12 |
+		RKCANFD_QUIRK_CANFD_BROKEN,
+	.get_berr_counter = rkcanfd_get_berr_counter_corrected,
+	.interrupts_enable = rkcanfd_chip_interrupts_enable,
+	.interrupts_disable = rkcanfd_chip_interrupts_disable,
+	.fifo_setup = rkcanfd_chip_fifo_setup,
+	.chip_start = rkcanfd_chip_start,
+	.chip_stop = rkcanfd_chip_stop,
+	.chip_stop_sync = rkcanfd_chip_stop_sync,
+	.irq = rkcanfd_irq,
+	.register_done = rkcanfd_register_done,
+};
+
+/* The rk3568 CAN-FD errata sheet as of Tue 07 Nov 2023 11:25:31 +08:00
+ * states that only the rk3568v2 is affected by erratum 5, but tests
+ * with the rk3568v2 and rk3568v3 show that the RX_FIFO_CNT is
+ * sometimes too high. In contrast to the errata sheet mark rk3568v3
+ * as effected by erratum 5, too.
+ */
+static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v3 = {
+	.model = RKCANFD_MODEL_RK3568V3,
+	.quirks = RKCANFD_QUIRK_RK3568_ERRATUM_1 | RKCANFD_QUIRK_RK3568_ERRATUM_2 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_5 | RKCANFD_QUIRK_RK3568_ERRATUM_7 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_8 | RKCANFD_QUIRK_RK3568_ERRATUM_10 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_11 | RKCANFD_QUIRK_RK3568_ERRATUM_12 |
+		RKCANFD_QUIRK_CANFD_BROKEN,
+	.get_berr_counter = rkcanfd_get_berr_counter_corrected,
+	.interrupts_enable = rkcanfd_chip_interrupts_enable,
+	.interrupts_disable = rkcanfd_chip_interrupts_disable,
+	.fifo_setup = rkcanfd_chip_fifo_setup,
+	.chip_start = rkcanfd_chip_start,
+	.chip_stop = rkcanfd_chip_stop,
+	.chip_stop_sync = rkcanfd_chip_stop_sync,
+	.irq = rkcanfd_irq,
+	.register_done = rkcanfd_register_done,
+};
+
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
@@ -852,18 +1336,47 @@ static const struct of_device_id rkcanfd_of_match[] = {
 	}, {
 		.compatible = "rockchip,rk3568v3-canfd",
 		.data = &rkcanfd_devtype_data_rk3568v3,
+	},  {
+		.compatible = "rockchip,rk3576-canfd",
+		.data = &rkcanfd_devtype_data_rk3576,
 	}, {
 		/* sentinel */
 	},
 };
 MODULE_DEVICE_TABLE(of, rkcanfd_of_match);
 
+static void rk3576_canfd_dma_init(struct rkcanfd_priv *priv)
+{
+	struct dma_slave_config rxconf = {
+		.direction = DMA_DEV_TO_MEM,
+		.src_addr = priv->rx_dma_src_addr,
+		.src_addr_width = 4,
+		.dst_addr_width = 4,
+		.src_maxburst = 16,
+	};
+
+	if (priv->rx_max_data == 18)
+		rxconf.src_maxburst = 9;
+	else
+		rxconf.src_maxburst = 4;
+
+	priv->dma_thr = rxconf.src_maxburst - 1;
+	priv->rxbuf = dma_alloc_coherent(priv->dev, priv->dma_size * priv->rx_fifo_depth,
+					 &priv->rx_dma_dst_addr, GFP_KERNEL);
+	if (!priv->rxbuf) {
+		priv->use_dma = 0;
+		return;
+	}
+	dmaengine_slave_config(priv->rxchan, &rxconf);
+}
+
 static int rkcanfd_probe(struct platform_device *pdev)
 {
 	struct rkcanfd_priv *priv;
 	struct net_device *ndev;
+	struct resource *res;
 	const void *match;
-	int err;
+	int err, val;
 
 	ndev = alloc_candev(sizeof(struct rkcanfd_priv), RKCANFD_TXFIFO_DEPTH);
 	if (!ndev)
@@ -883,6 +1396,7 @@ static int rkcanfd_probe(struct platform_device *pdev)
 		goto out_free_candev;
 	}
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->regs)) {
 		err = PTR_ERR(priv->regs);
@@ -912,13 +1426,46 @@ static int rkcanfd_probe(struct platform_device *pdev)
 	priv->can.do_set_mode = rkcanfd_set_mode;
 	priv->can.do_get_berr_counter = rkcanfd_get_berr_counter;
 	priv->ndev = ndev;
+	priv->dev = &pdev->dev;
 
 	match = device_get_match_data(&pdev->dev);
 	if (match)
 		priv->devtype_data = *(struct rkcanfd_devtype_data *)match;
 
+	if (device_property_read_u32(&pdev->dev, "rockchip,auto-retx-cnt", &val))
+		priv->auto_retx_cnt = 0;
+	else
+		priv->auto_retx_cnt = val;
+	if (priv->auto_retx_cnt > RK3576CANFD_RETX_TIME_LIMIT_CNT_MAX)
+		priv->auto_retx_cnt = RK3576CANFD_RETX_TIME_LIMIT_CNT_MAX;
+
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
+	priv->rxchan = dma_request_chan(&pdev->dev, "rx");
+	if (IS_ERR(priv->rxchan)) {
+		dev_warn(&pdev->dev, "Failed to request rxchan\n");
+		priv->rxchan = NULL;
+		priv->use_dma = 0;
+	} else {
+		priv->rx_dma_src_addr = res->start + RK3576CANFD_REG_RXFRD;
+		priv->dma_size = priv->rx_max_data * 4;
+		priv->use_dma = 1;
+	}
+	if (priv->use_dma)
+		rk3576_canfd_dma_init(priv);
+
 	err = can_rx_offload_add_manual(ndev, &priv->offload,
-					RKCANFD_NAPI_WEIGHT);
+					MAX(RKCANFD_NAPI_WEIGHT, priv->rx_fifo_depth));
 	if (err)
 		goto out_free_candev;
 
diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index 475c0409e215..30f497334592 100644
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
@@ -198,6 +239,94 @@ rkcanfd_fifo_header_empty(const struct rkcanfd_fifo_header *header)
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
+	/* Manual handling of CAN Bus Error counters. See
+	 * rkcanfd_get_corrected_berr_counter() for detailed
+	 * explanation.
+	 */
+	if (priv->bec.rxerr)
+		priv->bec.rxerr = min(CAN_ERROR_PASSIVE_THRESHOLD,
+				      priv->bec.rxerr) - 1;
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
+static int rk3576canfd_handle_rx_dma(struct rkcanfd_priv *priv, u32 addr)
+{
+	struct net_device_stats *stats = &priv->ndev->stats;
+	struct canfd_frame cfd[1] = { }, *skb_cfd;
+	struct rk3576canfd_fifo_header header[1] = { };
+	struct sk_buff *skb;
+	unsigned int len;
+	int i;
+
+	header->frameinfo = readl(priv->rxbuf + addr * priv->rx_max_data);
+	header->id = readl(priv->rxbuf + 1 + addr * priv->rx_max_data);
+	for (i = 0; i < (priv->rx_max_data - 2); i++)
+		cfd->data[i] = readl(priv->rxbuf + 2 + i + addr * priv->rx_max_data);
+
+	len = rk3576canfd_fifo_header_to_cfd_header(priv, header, cfd);
+
+	/* Manual handling of CAN Bus Error counters. See
+	 * rkcanfd_get_corrected_berr_counter() for detailed
+	 * explanation.
+	 */
+	if (priv->bec.rxerr)
+		priv->bec.rxerr = min(CAN_ERROR_PASSIVE_THRESHOLD,
+				      priv->bec.rxerr) - 1;
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
+	stats->rx_packets++;
+	stats->rx_bytes += cfd->len;
+	netif_rx(skb);
+	return 0;
+}
+
 static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
 {
 	struct net_device_stats *stats = &priv->ndev->stats;
@@ -284,6 +413,52 @@ rkcanfd_rx_fifo_get_len(const struct rkcanfd_priv *priv)
 	return FIELD_GET(RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT, reg);
 }
 
+static inline unsigned int
+rk3576canfd_rx_fifo_get_len(const struct rkcanfd_priv *priv)
+{
+	const u32 reg = rkcanfd_read(priv, RK3576CANFD_REG_STR_STATE);
+
+	return DIV_ROUND_UP(FIELD_GET(RK3576CANFD_REG_INTM_LEFT_CNT, reg), priv->rx_max_data);
+}
+
+static void rk3576_canfd_rx_dma_callback(void *data)
+{
+	struct rkcanfd_priv *priv = data;
+	int i;
+
+	for (i = 0; i < priv->quota; i++)
+		rk3576canfd_handle_rx_dma(priv, i);
+
+	rkcanfd_write(priv, RK3576CANFD_REG_INT_MASK, priv->reg_int_mask_default);
+}
+
+static int rk3576_canfd_rx_dma(struct rkcanfd_priv *priv)
+{
+	struct dma_async_tx_descriptor *rxdesc = NULL;
+	int quota = 0;
+
+	quota = (rkcanfd_read(priv, RK3576CANFD_REG_STR_STATE) & RK3576CANFD_REG_INTM_LEFT_CNT) >>
+		RK3576CANFD_REG_INTM_LEFT_CNT_SHIFT;
+	quota = DIV_ROUND_UP(quota, priv->rx_max_data);
+	priv->quota = quota;
+	if (priv->quota == 0) {
+		rkcanfd_write(priv, RK3576CANFD_REG_INT_MASK, priv->reg_int_mask_default);
+		return 0;
+	}
+
+	rxdesc = dmaengine_prep_slave_single(priv->rxchan, priv->rx_dma_dst_addr,
+					     priv->dma_size * priv->quota, DMA_DEV_TO_MEM, 0);
+	if (!rxdesc)
+		return -ENOMSG;
+
+	rxdesc->callback = rk3576_canfd_rx_dma_callback;
+	rxdesc->callback_param = priv;
+
+	dmaengine_submit(rxdesc);
+	dma_async_issue_pending(priv->rxchan);
+	return 0;
+}
+
 int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv)
 {
 	unsigned int len;
@@ -294,6 +469,24 @@ int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv)
 		if (err)
 			return err;
 	}
+	return 0;
+}
+
+int rkcanfd_handle_rk3576_rx_int(struct rkcanfd_priv *priv)
+{
+	unsigned int len;
+	int err;
 
+	if (priv->use_dma) {
+		rk3576_canfd_rx_dma(priv);
+		return 0;
+	}
+	while ((len = rk3576canfd_rx_fifo_get_len(priv))) {
+		err = rk3576canfd_handle_rx_int_one(priv);
+		if (err)
+			return err;
+	}
+	rkcanfd_write(priv, RK3576CANFD_REG_INT_MASK, priv->reg_int_mask_default);
 	return 0;
 }
+
diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
index 865a15e033a9..c19b97cb2296 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -165,3 +165,32 @@ void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 ts,
 							    frame_len_p);
 	stats->tx_packets++;
 }
+
+int rkcanfd_handle_rk3576_tx_int(struct rkcanfd_priv *priv)
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
index 93131c7d7f54..17ee90850be4 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -19,6 +19,8 @@
 #include <linux/types.h>
 #include <linux/u64_stats_sync.h>
 #include <linux/units.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 
 #define RKCANFD_REG_MODE 0x000
 #define RKCANFD_REG_MODE_CAN_FD_MODE_ENABLE BIT(15)
@@ -287,6 +289,285 @@
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
+#define RK3576CANFD_REG_INTM_LEFT_CNT GENMASK(16, 8)
+#define RK3576CANFD_REG_INTM_LEFT_CNT_SHIFT 8
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
+#define RK3576CANFD_RETX_TIME_LIMIT_CNT_MAX 0xffff
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
@@ -434,11 +715,23 @@
 enum rkcanfd_model {
 	RKCANFD_MODEL_RK3568V2 = 0x35682,
 	RKCANFD_MODEL_RK3568V3 = 0x35683,
+	RKCANFD_MODEL_RK3576 = 0x3576,
 };
 
+static struct rkcanfd_priv *priv;
+
 struct rkcanfd_devtype_data {
 	enum rkcanfd_model model;
 	u32 quirks;
+	void (*get_berr_counter)(struct rkcanfd_priv *priv, struct can_berr_counter *bec);
+	void (*interrupts_enable)(const struct rkcanfd_priv *priv);
+	void (*interrupts_disable)(const struct rkcanfd_priv *priv);
+	void (*fifo_setup)(struct rkcanfd_priv *priv);
+	void (*chip_start)(struct rkcanfd_priv *priv);
+	void (*chip_stop)(struct rkcanfd_priv *priv, const enum can_state state);
+	void (*chip_stop_sync)(struct rkcanfd_priv *priv, const enum can_state state);
+	irqreturn_t (*irq)(int irq, void *dev_id);
+	void (*register_done)(const struct rkcanfd_priv *priv);
 };
 
 struct rkcanfd_fifo_header {
@@ -447,6 +740,11 @@ struct rkcanfd_fifo_header {
 	u32 ts;
 };
 
+struct rk3576canfd_fifo_header {
+	u32 frameinfo;
+	u32 id;
+};
+
 struct rkcanfd_stats {
 	struct u64_stats_sync syncp;
 
@@ -461,6 +759,7 @@ struct rkcanfd_priv {
 	struct can_priv can;
 	struct can_rx_offload offload;
 	struct net_device *ndev;
+	struct device *dev;
 
 	void __iomem *regs;
 	unsigned int tx_head;
@@ -482,6 +781,17 @@ struct rkcanfd_priv {
 	struct reset_control *reset;
 	struct clk_bulk_data *clks;
 	int clks_num;
+	int rx_fifo_depth;
+	int rx_max_data;
+	unsigned int auto_retx_cnt;
+	bool use_dma;
+	u32 dma_size;
+	u32 dma_thr;
+	int quota;
+	struct dma_chan *rxchan;
+	u32 *rxbuf;
+	dma_addr_t rx_dma_src_addr;
+	dma_addr_t rx_dma_dst_addr;
 };
 
 static inline u32
@@ -536,6 +846,8 @@ rkcanfd_get_tx_free(const struct rkcanfd_priv *priv)
 void rkcanfd_ethtool_init(struct rkcanfd_priv *priv);
 
 int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv);
+int rkcanfd_handle_rk3576_tx_int(struct rkcanfd_priv *priv);
+int rkcanfd_handle_rk3576_rx_int(struct rkcanfd_priv *priv);
 
 void rkcanfd_skb_set_timestamp(const struct rkcanfd_priv *priv,
 			       struct sk_buff *skb, const u32 timestamp);
-- 
2.34.1


