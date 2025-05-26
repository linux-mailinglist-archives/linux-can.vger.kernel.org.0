Return-Path: <linux-can+bounces-3687-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38ECAC3A50
	for <lists+linux-can@lfdr.de>; Mon, 26 May 2025 09:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F773B1470
	for <lists+linux-can@lfdr.de>; Mon, 26 May 2025 07:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102AA1DD88F;
	Mon, 26 May 2025 07:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ITBADzCk"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m15595.qiye.163.com (mail-m15595.qiye.163.com [101.71.155.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4191DF990;
	Mon, 26 May 2025 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748242906; cv=none; b=nvosLRjTP/ItzI70Lo1msBjJIUqP2NET4d7YcZ7oGSO496cGfKHnRFMHpxF2k82gQ3rAgqOH//w56W4khrsEkMIwculSITijXwoHI8coZ33Nf3AYYKOhKsgk3tjAt/ynOsRtSIyLVCgDur2+43jxnlvC5fgHSb70yib/+XrzI0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748242906; c=relaxed/simple;
	bh=uizY7Vfo2i4aL8JJ94BduzLNKrYOHMuhSiaqwltGkw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XdUbh+xYLFqNX0NA+HVH73RkYM+cnmHBChN1HJYIW8VhcChbuE7k3XkastF2QXZahLBAhXw3klW4HIOSyz0cV6bygJGKWa5mrAS+BnaT/SwCo9mtdcaN0HVz5uPPb9Fz1kP3mWCAqaVNLZImVwhyNUtjAb5Tl4k4dXdIsMOs6WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ITBADzCk; arc=none smtp.client-ip=101.71.155.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1660c017b;
	Mon, 26 May 2025 14:26:07 +0800 (GMT+08:00)
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
Subject: [PATCH v6 4/4] net: can: rockchip: support dma for rk3576 rx
Date: Mon, 26 May 2025 14:25:59 +0800
Message-Id: <20250526062559.2061311-5-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250526062559.2061311-1-zhangqing@rock-chips.com>
References: <20250526062559.2061311-1-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh0YQ1ZDTR8aGkNNHh9PTU1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	1VSktLVUpCWQY+
X-HM-Tid: 0a970b45195a03a3kunm902b49ed4a33da
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBw6PDo4MzE1Pg4YVhgeTjEh
	PUwwC0hVSlVKTE9DSU9LTE1DQkhKVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUNOQ043Bg++
DKIM-Signature:a=rsa-sha256;
	b=ITBADzCkKdMRaStkLgK06xzfxrmvQighhyh7HQBYg7OOiTtB78XYQDqlk7rU9sdbyPnM+0+iPA9XLyQJeuq/x0aE8phzZefFL+MhFg/hGjuRhK20EHt5KRhxuwzjU7SQpffUQEXtautrWE3WSJ2c5j+gtCjB+0eUdZmqZC++L7A=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=xqG/Wy3+meYZ9Nw6yZE9fdRixbffGpHZok75x3uNNP4=;
	h=date:mime-version:subject:message-id:from;

The new can controller of rk3576 supports rx dma.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 .../net/can/rockchip/rockchip_canfd-core.c    | 39 +++++++++
 drivers/net/can/rockchip/rockchip_canfd-rx.c  | 87 +++++++++++++++++++
 drivers/net/can/rockchip/rockchip_canfd.h     | 11 +++
 3 files changed, 137 insertions(+)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 92e260cb2527..9ef4a9ae19d8 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -433,6 +433,9 @@ static void rk3576canfd_chip_start(struct rkcanfd_priv *priv)
 		      RK3576CANFD_REG_BRS_CFG_BRS_NEGSYNC_EN |
 		      RK3576CANFD_REG_BRS_CFG_BRS_POSSYNC_EN);
 
+	if (priv->use_dma)
+		rkcanfd_write(priv, RK3576CANFD_REG_DMA_CTRL,
+			      RK3576CANFD_REG_DMA_CTRL_DMA_RX_EN | priv->dma_thr);
 	rkcanfd_set_bittiming(priv);
 
 	priv->devtype_data.interrupts_disable(priv);
@@ -1324,10 +1327,31 @@ static const struct of_device_id rkcanfd_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rkcanfd_of_match);
 
+static void rk3576_canfd_dma_init(struct rkcanfd_priv *priv)
+{
+	struct dma_slave_config rxconf = {
+		.direction = DMA_DEV_TO_MEM,
+		.src_addr = priv->rx_dma_src_addr,
+		.src_addr_width = 4,
+		.dst_addr_width = 4,
+		.src_maxburst = 9,
+	};
+
+	priv->dma_thr = rxconf.src_maxburst - 1;
+	priv->rxbuf = dma_alloc_coherent(priv->dev, priv->dma_size * 14,
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
 	int err;
 
@@ -1349,6 +1373,7 @@ static int rkcanfd_probe(struct platform_device *pdev)
 		goto out_free_candev;
 	}
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->regs)) {
 		err = PTR_ERR(priv->regs);
@@ -1376,6 +1401,7 @@ static int rkcanfd_probe(struct platform_device *pdev)
 	priv->can.do_set_mode = rkcanfd_set_mode;
 	priv->can.do_get_berr_counter = rkcanfd_get_berr_counter;
 	priv->ndev = ndev;
+	priv->dev = &pdev->dev;
 
 	match = device_get_match_data(&pdev->dev);
 	if (match) {
@@ -1384,6 +1410,19 @@ static int rkcanfd_probe(struct platform_device *pdev)
 			priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
 	}
 
+	priv->rxchan = dma_request_chan(&pdev->dev, "rx");
+	if (IS_ERR(priv->rxchan)) {
+		dev_warn(&pdev->dev, "Failed to request rxchan\n");
+		priv->rxchan = NULL;
+		priv->use_dma = 0;
+	} else {
+		priv->rx_dma_src_addr = res->start + RK3576CANFD_REG_RXFRD;
+		priv->dma_size = RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT_UNIT * 4;
+		priv->use_dma = 1;
+	}
+	if (priv->use_dma)
+		rk3576_canfd_dma_init(priv);
+
 	err = can_rx_offload_add_manual(ndev, &priv->offload,
 					RKCANFD_NAPI_WEIGHT);
 	if (err)
diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index 8a383cabd9d2..ac06e876552e 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
@@ -285,6 +285,52 @@ static int rk3576canfd_handle_rx_int_one(struct rkcanfd_priv *priv)
 	return 0;
 }
 
+static int rk3576canfd_handle_rx_dma(struct rkcanfd_priv *priv, u32 addr)
+{
+	struct net_device_stats *stats = &priv->ndev->stats;
+	struct canfd_frame cfd[1] = { }, *skb_cfd;
+	struct rk3576canfd_fifo_header header[1] = { };
+	struct sk_buff *skb;
+	u32 __iomem *rxbuf = (u32 __iomem *)priv->rxbuf;
+	unsigned int len;
+	int i;
+
+	header->frameinfo = readl(rxbuf +
+				  addr * RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT_UNIT);
+	header->id = readl(rxbuf + 1 +
+			   addr * RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT_UNIT);
+	for (i = 0; i < (RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT_UNIT - 2); i++)
+		cfd->data[i] = readl(rxbuf + 2 + i +
+				     addr * RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT_UNIT);
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
@@ -380,6 +426,43 @@ rk3576canfd_rx_fifo_get_len(const struct rkcanfd_priv *priv)
 	return DIV_ROUND_UP(val, RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT_UNIT);
 }
 
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
+	const u32 reg = rkcanfd_read(priv, RK3576CANFD_REG_STR_STATE);
+	int quota = FIELD_GET(RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT, reg);
+
+	quota = DIV_ROUND_UP(quota, RK3576CANFD_REG_STR_STATE_INTM_LEFT_CNT_UNIT);
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
@@ -399,6 +482,10 @@ int rkcanfd_handle_rk3576_rx_int(struct rkcanfd_priv *priv)
 	unsigned int len;
 	int err;
 
+	if (priv->use_dma) {
+		rk3576_canfd_rx_dma(priv);
+		return 0;
+	}
 	while ((len = rk3576canfd_rx_fifo_get_len(priv))) {
 		err = rk3576canfd_handle_rx_int_one(priv);
 		if (err)
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 9b91d757d054..c7d6845c6d95 100644
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
@@ -737,6 +739,7 @@ struct rkcanfd_priv {
 	struct can_priv can;
 	struct can_rx_offload offload;
 	struct net_device *ndev;
+	struct device *dev;
 
 	void __iomem *regs;
 	unsigned int tx_head;
@@ -758,6 +761,14 @@ struct rkcanfd_priv {
 	struct reset_control *reset;
 	struct clk_bulk_data *clks;
 	int clks_num;
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
-- 
2.34.1


