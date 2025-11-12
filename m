Return-Path: <linux-can+bounces-5339-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAE0C50473
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 03:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B908A4EB296
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 02:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0C22BD5A2;
	Wed, 12 Nov 2025 02:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="MlPdQcBS"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m15571.qiye.163.com (mail-m15571.qiye.163.com [101.71.155.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E074029D26B;
	Wed, 12 Nov 2025 01:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912800; cv=none; b=BoLWr75yO5hVKPReB1fNBY1ADY8Iws+4q5WsxxiXpYKGFTWJRpsJAj98xDgwGqLUhAdfXuxbYpZYxbHd38EELhgBXChlr4nB+59en+ErujURh2aorL3tBN0RTfsFxTn4BHIYAVnmR8m5JanG4LR4gudpTz7hQgJrn4rWvsMcLK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912800; c=relaxed/simple;
	bh=O7tubFIzjSEMZEDcIHATLIKrfwL4LYztCBVPVGIDEqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sA3HvrVt6MHLsO2ygvP3O08UlIakrE2Bqt2uWuMH4g80em+/06vhsdGb9LffeRnYUCU0LhYjV1AftutKAYEA1fNt780ku0fkihJI/r15mRhhQ56agy4K1Q1MYhENeMeGFPpBh9iYpNfEVgLVy/XRRmOm4QUG9rpJYfl7Z+Ie9X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=MlPdQcBS; arc=none smtp.client-ip=101.71.155.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2941ca625;
	Wed, 12 Nov 2025 09:59:47 +0800 (GMT+08:00)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: zhangqing@rock-chips.com,
	mkl@pengutronix.de,
	kernel@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	cl@rock-chips.com
Cc: linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [RESEND PATCH v8 4/4] net: can: rockchip: support dma for rk3576 rx
Date: Wed, 12 Nov 2025 09:59:40 +0800
Message-Id: <20251112015940.3695638-5-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112015940.3695638-1-zhangqing@rock-chips.com>
References: <20251112015940.3695638-1-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a75ca5c7703a3kunm5e00f3261f077d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUhMTlZLQxpLTR5CSE0aTkJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
	b=MlPdQcBS++LtSRKkCsd6Mtelf7U/jEpRYJoER8sEQ/OUZEsdZtPImU7Jjw9TmWTLbWogMt3iPIRS+B3zuKZkZjbYOI+PGcYwJn3H7HMet9lxGJ4D7nSyOJh315kAiS+waagedwIuELgynsjHaJWYZI2kcwllICwUI0CFr9JkeQE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=Gx1ZNKdQ6vm4QkQx+CizmRfGvSq5qGs0J5j5xTq7oJI=;
	h=date:mime-version:subject:message-id:from;

The new can controller of rk3576 supports rx dma.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 .../net/can/rockchip/rockchip_canfd-core.c    |  62 +++++++++-
 drivers/net/can/rockchip/rockchip_canfd-rx.c  | 109 ++++++++++++++++++
 drivers/net/can/rockchip/rockchip_canfd.h     |   9 ++
 3 files changed, 178 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 58fffcf97b20..8284bf05efba 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -399,6 +399,9 @@ static void rk3576can_chip_start(struct rkcanfd_priv *priv)
 		      RK3576CAN_REG_BRS_CFG_BRS_NEGSYNC_EN |
 		      RK3576CAN_REG_BRS_CFG_BRS_POSSYNC_EN);
 
+	if (priv->dma_thr)
+		rkcanfd_write(priv, RK3576CAN_REG_DMA_CTRL,
+			      RK3576CAN_REG_DMA_CTRL_DMA_RX_EN | priv->dma_thr);
 	rkcanfd_set_bittiming(priv);
 
 	priv->devtype_data.interrupts_disable(priv);
@@ -1288,10 +1291,34 @@ static const struct of_device_id rkcanfd_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rkcanfd_of_match);
 
+static int rk3576_canfd_dma_init(struct rkcanfd_priv *priv, struct resource *res)
+{
+	struct dma_slave_config rxconf = {
+		.direction = DMA_DEV_TO_MEM,
+		.src_addr = res->start + RK3576CAN_REG_RXFRD,
+		.src_addr_width = 4,
+		.dst_addr_width = 4,
+		.src_maxburst = 9,
+	};
+
+	priv->dma_thr = rxconf.src_maxburst - 1;
+	priv->dma_size = RK3576CAN_REG_STR_STATE_INTM_LEFT_CNT_UNIT * 4;
+	priv->rxbuf = dma_alloc_coherent(priv->ndev->dev.parent,
+					 priv->dma_size * RK3576CAN_SRAM_MAX_FIFO_CNT,
+					 &priv->rx_dma_dst_addr, GFP_KERNEL);
+	if (!priv->rxbuf) {
+		priv->rxbuf = NULL;
+		return -ENOMEM;
+	}
+	dmaengine_slave_config(priv->rxchan, &rxconf);
+	return 0;
+}
+
 static int rkcanfd_probe(struct platform_device *pdev)
 {
 	struct rkcanfd_priv *priv;
 	struct net_device *ndev;
+	struct resource *res;
 	const void *match;
 	int err;
 
@@ -1313,7 +1340,7 @@ static int rkcanfd_probe(struct platform_device *pdev)
 		goto out_free_candev;
 	}
 
-	priv->regs = devm_platform_ioremap_resource(pdev, 0);
+	priv->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->regs)) {
 		err = PTR_ERR(priv->regs);
 		goto out_free_candev;
@@ -1348,10 +1375,22 @@ static int rkcanfd_probe(struct platform_device *pdev)
 			priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
 	}
 
+	priv->rxchan = dma_request_chan(&pdev->dev, "rx");
+	if (IS_ERR(priv->rxchan)) {
+		netdev_warn(priv->ndev,
+			    "Failed to request RX-DMA channel: %pe, continuing without DMA",
+			    priv->rxchan);
+		priv->rxchan = NULL;
+	} else {
+		err = rk3576_canfd_dma_init(priv, res);
+		if (err)
+			goto out_can_dma_rx_chan_del;
+	}
+
 	err = can_rx_offload_add_manual(ndev, &priv->offload,
 					RKCANFD_NAPI_WEIGHT);
 	if (err)
-		goto out_free_candev;
+		goto out_can_dma_rx_chan_del;
 
 	err = rkcanfd_register(priv);
 	if (err)
@@ -1361,6 +1400,15 @@ static int rkcanfd_probe(struct platform_device *pdev)
 
 out_can_rx_offload_del:
 	can_rx_offload_del(&priv->offload);
+out_can_dma_rx_chan_del:
+	if (priv->rxbuf) {
+		dma_free_coherent(priv->ndev->dev.parent,
+				  priv->dma_size * RK3576CAN_SRAM_MAX_FIFO_CNT,
+				  priv->rxbuf, priv->rx_dma_dst_addr);
+		priv->rxbuf = NULL;
+	}
+	if (priv->rxchan)
+		dma_release_channel(priv->rxchan);
 out_free_candev:
 	free_candev(ndev);
 
@@ -1372,6 +1420,16 @@ static void rkcanfd_remove(struct platform_device *pdev)
 	struct rkcanfd_priv *priv = platform_get_drvdata(pdev);
 	struct net_device *ndev = priv->ndev;
 
+	if (priv->rxbuf) {
+		dma_free_coherent(priv->ndev->dev.parent,
+				  priv->dma_size * RK3576CAN_SRAM_MAX_FIFO_CNT,
+				  priv->rxbuf, priv->rx_dma_dst_addr);
+		priv->rxbuf = NULL;
+	}
+
+	if (priv->rxchan)
+		dma_release_channel(priv->rxchan);
+
 	rkcanfd_unregister(priv);
 	can_rx_offload_del(&priv->offload);
 	free_candev(ndev);
diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index 6bc4b0185502..e478b2b482c1 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
@@ -277,6 +277,71 @@ static int rk3576can_handle_rx_int_one(struct rkcanfd_priv *priv)
 	return 0;
 }
 
+static int rk3576can_handle_rx_dma(struct rkcanfd_priv *priv, u32 addr)
+{
+	struct net_device_stats *stats = &priv->ndev->stats;
+	struct canfd_frame *skb_cfd;
+	struct sk_buff *skb;
+	u32 frameinfo, id, data[16] = {0};
+	u8 dlc;
+	int i;
+
+	frameinfo = *(u32 *)(priv->rxbuf + addr * RK3576CAN_REG_STR_STATE_INTM_LEFT_CNT_UNIT);
+	id = *(u32 *)(priv->rxbuf + 1 + addr * RK3576CAN_REG_STR_STATE_INTM_LEFT_CNT_UNIT);
+	for (i = 0; i < (RK3576CAN_REG_STR_STATE_INTM_LEFT_CNT_UNIT - 2); i++)
+		data[i] = *(u32 *)(priv->rxbuf + 2 + i +
+				   addr * RK3576CAN_REG_STR_STATE_INTM_LEFT_CNT_UNIT);
+
+	if (frameinfo & RK3576CAN_REG_RXFRD_FRAMEINFO_FDF)
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
+	if (frameinfo & RK3576CAN_REG_RXFRD_FRAMEINFO_FRAME_FORMAT)
+		skb_cfd->can_id = FIELD_GET(RKCANFD_REG_FD_ID_EFF, id) |
+			CAN_EFF_FLAG;
+	else
+		skb_cfd->can_id = FIELD_GET(RKCANFD_REG_FD_ID_SFF, id);
+
+	dlc = FIELD_GET(RK3576CAN_REG_RXFRD_FRAMEINFO_DATA_LENGTH,
+			frameinfo);
+
+	/* CAN-FD */
+	if (frameinfo & RK3576CAN_REG_RXFRD_FRAMEINFO_FDF) {
+		skb_cfd->len = can_fd_dlc2len(dlc);
+
+		/* The cfd is not allocated by alloc_canfd_skb(), so
+		 * set CANFD_FDF here.
+		 */
+		skb_cfd->flags |= CANFD_FDF;
+
+		if (frameinfo & RK3576CAN_REG_RXFRD_FRAMEINFO_BRS)
+			skb_cfd->flags |= CANFD_BRS;
+	} else {
+		skb_cfd->len = can_cc_dlc2len(dlc);
+
+		if (frameinfo & RK3576CAN_REG_RXFRD_FRAMEINFO_RTR)
+			skb_cfd->can_id |= CAN_RTR_FLAG;
+	}
+	if (!(skb_cfd->can_id & CAN_RTR_FLAG)) {
+		/* Change CANFD data format to SocketCAN data format */
+		for (i = 0; i < skb_cfd->len; i += 4)
+			*(u32 *)(skb_cfd->data + i) = data[i / 4];
+	}
+
+	stats->rx_packets++;
+	stats->rx_bytes += skb_cfd->len;
+	netif_rx(skb);
+
+	return 0;
+}
+
 static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
 {
 	struct net_device_stats *stats = &priv->ndev->stats;
@@ -372,6 +437,43 @@ rk3576can_rx_fifo_get_len(const struct rkcanfd_priv *priv)
 	return DIV_ROUND_UP(val, RK3576CAN_REG_STR_STATE_INTM_LEFT_CNT_UNIT);
 }
 
+static void rk3576_can_rx_dma_callback(void *data)
+{
+	struct rkcanfd_priv *priv = data;
+	int i;
+
+	for (i = 0; i < priv->quota; i++)
+		rk3576can_handle_rx_dma(priv, i);
+
+	rkcanfd_write(priv, RK3576CAN_REG_INT_MASK, priv->reg_int_mask_default);
+}
+
+static int rk3576_can_rx_dma(struct rkcanfd_priv *priv)
+{
+	struct dma_async_tx_descriptor *rxdesc = NULL;
+	const u32 reg = rkcanfd_read(priv, RK3576CAN_REG_STR_STATE);
+	int quota = FIELD_GET(RK3576CAN_REG_STR_STATE_INTM_LEFT_CNT, reg);
+
+	quota = DIV_ROUND_UP(quota, RK3576CAN_REG_STR_STATE_INTM_LEFT_CNT_UNIT);
+	priv->quota = quota;
+	if (priv->quota == 0) {
+		rkcanfd_write(priv, RK3576CAN_REG_INT_MASK, priv->reg_int_mask_default);
+		return 0;
+	}
+
+	rxdesc = dmaengine_prep_slave_single(priv->rxchan, priv->rx_dma_dst_addr,
+					     priv->dma_size * priv->quota, DMA_DEV_TO_MEM, 0);
+	if (!rxdesc)
+		return -ENOMSG;
+
+	rxdesc->callback = rk3576_can_rx_dma_callback;
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
@@ -391,6 +493,13 @@ int rkcanfd_handle_rk3576_rx_int(struct rkcanfd_priv *priv)
 	unsigned int len;
 	int err;
 
+	if (priv->rxchan) {
+		err = rk3576_can_rx_dma(priv);
+		if (err)
+			return err;
+		else
+			return 0;
+	}
 	while ((len = rk3576can_rx_fifo_get_len(priv))) {
 		err = rk3576can_handle_rx_int_one(priv);
 		if (err)
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 77c673cfea3b..bdd01150d920 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -11,6 +11,8 @@
 #include <linux/can/dev.h>
 #include <linux/can/rx-offload.h>
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/netdevice.h>
 #include <linux/reset.h>
@@ -532,6 +534,7 @@
 #define RK3576CAN_ISM_WATERMASK_CANFD 0x6c /* word */
 
 #define RK3576CAN_SRAM_MAX_DEPTH 256 /* word */
+#define RK3576CAN_SRAM_MAX_FIFO_CNT (RK3576CAN_SRAM_MAX_DEPTH / 18)
 
 #define RK3576CAN_CANFD_FILTER GENMASK(28, 0)
 
@@ -748,6 +751,12 @@ struct rkcanfd_priv {
 	struct reset_control *reset;
 	struct clk_bulk_data *clks;
 	int clks_num;
+	u32 dma_size;
+	u32 dma_thr;
+	int quota;
+	struct dma_chan *rxchan;
+	u32 *rxbuf;
+	dma_addr_t rx_dma_dst_addr;
 };
 
 static inline u32
-- 
2.34.1


