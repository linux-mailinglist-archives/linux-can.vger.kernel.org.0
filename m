Return-Path: <linux-can+bounces-7403-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK6eGokO72kq4wAAu9opvQ
	(envelope-from <linux-can+bounces-7403-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 09:21:45 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C017246E46B
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 09:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06570300212F
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 07:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCBC36C9E5;
	Mon, 27 Apr 2026 07:19:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8D0362130
	for <linux-can@vger.kernel.org>; Mon, 27 Apr 2026 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777274396; cv=none; b=hk/7quIqsw01wQ2K5Drf5i6c5niXhtmQElWie/yTEr36rb3Vjjz38XTjZqbi/Rc70Q5ukHRdRtVujEyOpW3x5ISgFG/MgOnkWsuj+qeoF6QxaoyrFe7/SNulC8p5IxHUtSM99zj2W1gnzOZPpNarmAI42EUBurrKzSM2RneqKsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777274396; c=relaxed/simple;
	bh=hTYN9NArd8jE13N8QT/jTPWekkr2QXK1W46Xzosr0aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwxO23iNM0eJJllrE5sZQfeQqTZmWBJSXmeogWvKyS61MSuZVxTuvDgWl6Pnmq/hTp2OD2xlsC6O8CnwcUhELrS/FUiNQOOjz2+fb9qh2vIQ+/WQqLgwK3QeVp1oxfwCZrMtKQz4S7emNYKTjLz00q/6z8AjuCkbuEfs4frI9QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.8])
	by gateway (Coremail) with SMTP id _____8CxnOm1De9pdUMEAA--.12728S3;
	Mon, 27 Apr 2026 15:18:13 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.8])
	by front1 (Coremail) with SMTP id qMiowJCxWeCvDe9p0pJ1AA--.27085S4;
	Mon, 27 Apr 2026 15:18:11 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Bingxiong Li <libingxiong@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	linux-can@vger.kernel.org,
	jeffbai@aosc.io,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 2/2] can: loongson_canfd: Add RXDMA support
Date: Mon, 27 Apr 2026 15:18:00 +0800
Message-ID: <ee7e4e0d968428761b0fc50e56560165b4020161.1777273055.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1777273055.git.zhoubinbin@loongson.cn>
References: <cover.1777273055.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxWeCvDe9p0pJ1AA--.27085S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEKCGnu+qgB+QAAss
X-Coremail-Antispam: 1Uk129KBj9fXoW3KFWkuFWrXw4kZw1fuFyDJwc_yoW8Jr43Go
	WxWFsxKa1rWw18Jryjg3WfXr17Za4DZrnxArZakr1kWa90y3WUArZ8Wa1fJF1rta4FqF43
	urZ5WF4fGayxtrW3l-sFpf9Il3svdjkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYC7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUAVWUZwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jzc_-UUUUU=
X-Rspamd-Queue-Id: C017246E46B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7403-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	FREEMAIL_TO(0.00)[gmail.com,loongson.cn,pengutronix.de,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[zhoubinbin@loongson.cn,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loongson.cn:mid,loongson.cn:email]

Add optional DMA support for RX path using the Loongson APB CMC DMA
engine. When a DMA channel is successfully requested, the driver:

- Uses DMA cyclic transfers to write incoming CAN frames directly to
  a coherent DMA buffer
- Replaces RXBNEI (RX buffer not empty interrupt) with DMADI (DMA
  done interrupt)
- Dynamically switches between DMA and PIO modes based on channel
  availability

This significantly reduces CPU intervention under high RX load,
especially beneficial for CAN FD at higher data rates.

Co-developed-by: Bingxiong Li <libingxiong@loongson.cn>
Signed-off-by: Bingxiong Li <libingxiong@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/net/can/loongson_canfd/Kconfig        |   2 +-
 .../net/can/loongson_canfd/loongson_canfd.c   | 179 ++++++++++++++++--
 2 files changed, 160 insertions(+), 21 deletions(-)

diff --git a/drivers/net/can/loongson_canfd/Kconfig b/drivers/net/can/loongson_canfd/Kconfig
index 5a2540bb5410..8fe44b804991 100644
--- a/drivers/net/can/loongson_canfd/Kconfig
+++ b/drivers/net/can/loongson_canfd/Kconfig
@@ -5,7 +5,7 @@
 #
 config CAN_LOONGSON_CANFD
 	tristate "Loongson CAN-FD driver"
-	depends on HAS_IOMEM
+	depends on HAS_IOMEM && LOONGSON2_APB_CMC_DMA
 	select REGMAP_MMIO
 	help
 	  This is a canfd driver switch for the Loongson platform,
diff --git a/drivers/net/can/loongson_canfd/loongson_canfd.c b/drivers/net/can/loongson_canfd/loongson_canfd.c
index 20ac95dc528d..ba9570c34c94 100644
--- a/drivers/net/can/loongson_canfd/loongson_canfd.c
+++ b/drivers/net/can/loongson_canfd/loongson_canfd.c
@@ -6,10 +6,14 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/acpi_dma.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -26,13 +30,21 @@
 #define DEV_NAME			"loongson_canfd"
 #define LOONGSON_CANFD_TXBUF_NUM	8
 #define LOONGSON_CANFD_ID		0xBABE
+#define RX_BUF_SIZE			SZ_1K
+#define LOONGSON_CANFD_DMA_RXDATA_NUM	(RX_BUF_SIZE / DMA_SLAVE_BUSWIDTH_4_BYTES)
 
 struct loongson_canfd_priv {
 	struct can_priv		can;		/* must be first member! */
 	struct napi_struct	napi;
 	struct regmap		*regmap;
 	struct resource		*res;
+	struct dma_chan		*rx_ch;
+	dma_addr_t		rx_dma_buf;	/* dma rx buffer bus address */
+	unsigned int		*rx_buf;	/* dma rx buffer cpu address */
+	u16			last_res;
 	spinlock_t		tx_lock;	/* protect the sending queue */
+	u32 (*get_rx_data)(struct loongson_canfd_priv *priv);
+	bool (*get_rx_pending)(struct loongson_canfd_priv *priv);
 };
 
 enum loongson_canfd_tx_bs {
@@ -137,6 +149,54 @@ static int loongson_canfd_reset(struct net_device *ndev)
 	return 0;
 }
 
+static u32 loongson_canfd_get_rxdma_data(struct loongson_canfd_priv *priv)
+{
+	u32 c = 0;
+
+	c = priv->rx_buf[LOONGSON_CANFD_DMA_RXDATA_NUM - priv->last_res--];
+	if (priv->last_res == 0)
+		priv->last_res = LOONGSON_CANFD_DMA_RXDATA_NUM;
+
+	return c;
+}
+
+static bool loongson_canfd_rxdma_pending(struct loongson_canfd_priv *priv)
+{
+	enum dma_status status;
+	struct dma_tx_state state;
+
+	status = dmaengine_tx_status(priv->rx_ch, priv->rx_ch->cookie, &state);
+
+	if (priv->last_res != (state.residue / DMA_SLAVE_BUSWIDTH_4_BYTES) &&
+	    status == DMA_IN_PROGRESS)
+		return true;
+
+	return false;
+}
+
+static u32 loongson_canfd_get_poll_data(struct loongson_canfd_priv *priv)
+{
+	u32 data;
+
+	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
+
+	return data;
+}
+
+static bool loongson_canfd_rxpoll_pending(struct loongson_canfd_priv *priv)
+{
+	u32 rx_sts;
+
+	regmap_read(priv->regmap, LOONGSON_CANFD_RX_STAT, &rx_sts);
+
+	return FIELD_GET(REG_RX_STAT_RXFRC, rx_sts) ? true : false;
+}
+
+static void loongson_canfd_rxdma_remove(struct loongson_canfd_priv *priv, struct device *dev)
+{
+	dma_free_coherent(dev, RX_BUF_SIZE, priv->rx_buf, priv->rx_dma_buf);
+}
+
 static int loongson_canfd_set_btr(struct net_device *ndev, struct can_bittiming *bt, bool nominal)
 {
 	struct loongson_canfd_priv *priv = netdev_priv(ndev);
@@ -308,7 +368,9 @@ static int loongson_canfd_chip_start(struct net_device *ndev)
 	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
 		int_ena |= REG_INT_STAT_ALI | REG_INT_STAT_BEI;
 
-	int_ena = REG_INT_STAT_TXBHCI | REG_INT_STAT_EWLI | REG_INT_STAT_FCSI | REG_INT_STAT_RBNEI;
+	int_ena = REG_INT_STAT_TXBHCI | REG_INT_STAT_EWLI | REG_INT_STAT_FCSI;
+	int_ena |= priv->rx_ch ? REG_INT_STAT_DMADI : REG_INT_STAT_RBNEI;
+
 	int_msk = ~int_ena; /* Mask all disabled interrupts */
 
 	/* It's after reset, so there is no need to clear anything */
@@ -514,12 +576,12 @@ static void loongson_canfd_read_rx_frame(struct loongson_canfd_priv *priv, struc
 
 	/* Data */
 	for (i = 0; i < len; i += 4) {
-		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
+		data = priv->get_rx_data(priv);
 		*(__le32 *)(cf->data + i) = cpu_to_le32(data);
 	}
 
 	while (unlikely(i < wc * 4)) {
-		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
+		data = priv->get_rx_data(priv);
 		i += 4;
 	}
 }
@@ -532,8 +594,8 @@ static int loongson_canfd_rx(struct net_device *ndev)
 	struct sk_buff *skb;
 	u32 meta0, meta1;
 
-	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &meta0);
-	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &meta1);
+	meta0 = priv->get_rx_data(priv);
+	meta1 = priv->get_rx_data(priv);
 
 	/* Number of characters received */
 	if (!FIELD_GET(REG_FRAME_FORMAT_W_RWCNT, meta1))
@@ -718,16 +780,16 @@ static int loongson_canfd_rx_napi(struct napi_struct *napi, int quota)
 	struct net_device *ndev = napi->dev;
 	struct loongson_canfd_priv *priv = netdev_priv(ndev);
 	int work_done = 0, res = 1;
-	u32 sts, rx_frc, rx_sts;
+	int int_ena = priv->rx_ch ? REG_INT_STAT_DMADI : REG_INT_STAT_RBNEI;
+	u32 sts;
+	bool rx_frc;
 
-	regmap_read(priv->regmap, LOONGSON_CANFD_RX_STAT, &rx_sts);
-	rx_frc = FIELD_GET(REG_RX_STAT_RXFRC, rx_sts);
+	rx_frc = priv->get_rx_pending(priv);
 
 	while (rx_frc && work_done < quota && res > 0) {
 		res = loongson_canfd_rx(ndev);
 		work_done++;
-		regmap_read(priv->regmap, LOONGSON_CANFD_RX_STAT, &rx_sts);
-		rx_frc = FIELD_GET(REG_RX_STAT_RXFRC, rx_sts);
+		rx_frc = priv->get_rx_pending(priv);
 	}
 
 	/* Check for RX FIFO Overflow */
@@ -757,13 +819,11 @@ static int loongson_canfd_rx_napi(struct napi_struct *napi, int quota)
 	if (!rx_frc && res != 0) {
 		if (napi_complete_done(napi, work_done)) {
 			/*
-			 * Clear and enable RBNEI. It is level-triggered, so
+			 * Clear and enable RBNEI/DMADI. It is level-triggered, so
 			 * there is no race condition.
 			 */
-			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT,
-				     REG_INT_STAT_RBNEI);
-			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK,
-				     (REG_INT_STAT_RBNEI << 16));
+			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, int_ena);
+			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, (int_ena << 16));
 		}
 	}
 
@@ -855,7 +915,7 @@ static irqreturn_t loongson_canfd_interrupt(int irq, void *dev_id)
 	struct net_device *ndev = (struct net_device *)dev_id;
 	struct loongson_canfd_priv *priv = netdev_priv(ndev);
 	int irq_loops;
-	u32 isr;
+	u32 isr, mask;
 	u16 icr;
 
 	for (irq_loops = 0; irq_loops < 10000; irq_loops++) {
@@ -864,14 +924,16 @@ static irqreturn_t loongson_canfd_interrupt(int irq, void *dev_id)
 		if (!isr)
 			return irq_loops ? IRQ_HANDLED : IRQ_NONE;
 
+		mask = priv->rx_ch ? REG_INT_STAT_DMADI : REG_INT_STAT_RBNEI;
+
 		/* Receive Buffer Not Empty Interrupt */
-		if (FIELD_GET(REG_INT_STAT_RBNEI, isr)) {
+		if (isr & mask) {
 			/*
 			 * Mask RXBNEI the first, then clear interrupt and schedule NAPI.
 			 * Even if another IRQ fires, RBNEI will always be 0 (masked).
 			 */
-			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, REG_INT_STAT_RBNEI);
-			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, REG_INT_STAT_RBNEI);
+			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, mask);
+			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, mask);
 			napi_schedule(&priv->napi);
 		}
 
@@ -1054,11 +1116,56 @@ static const struct regmap_config loongson_cangfd_regmap = {
 	.cache_type	= REGCACHE_MAPLE,
 };
 
+static int loongson_canfd_rxdma_init(struct loongson_canfd_priv *priv, struct device *dev)
+{
+	struct dma_slave_config config;
+	struct dma_async_tx_descriptor *desc = NULL;
+	int ret;
+
+	priv->rx_buf = dma_alloc_coherent(dev, RX_BUF_SIZE, &priv->rx_dma_buf, GFP_KERNEL);
+	if (!priv->rx_buf)
+		return -ENOMEM;
+
+	/* Configure DMA channel */
+	memset(&config, 0, sizeof(config));
+	config.src_addr = priv->res->start + LOONGSON_CANFD_RX_DATA;
+	config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+
+	ret = dmaengine_slave_config(priv->rx_ch, &config);
+	if (ret < 0) {
+		dev_err(dev, "rx dma channel config failed\n");
+		goto err_config;
+	}
+
+	/* Prepare a DMA cyclic transaction */
+	desc = dmaengine_prep_dma_cyclic(priv->rx_ch, priv->rx_dma_buf,
+					 RX_BUF_SIZE, RX_BUF_SIZE,
+					 DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
+	if (!desc) {
+		dev_err(dev, "rx dma prep cyclic failed\n");
+		ret = -EBUSY;
+		goto err_config;
+	}
+
+	/* Push current DMA transaction in the pending queue */
+	dmaengine_submit(desc);
+
+	/* Issue pending DMA requests */
+	dma_async_issue_pending(priv->rx_ch);
+
+	return 0;
+
+err_config:
+	loongson_canfd_rxdma_remove(priv, dev);
+	return ret;
+}
+
 static int loongson_canfd_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct loongson_canfd_priv *priv;
 	struct net_device *ndev;
+	struct dma_chan *rx_ch;
 	struct regmap *regmap;
 	struct resource *res;
 	void __iomem *base;
@@ -1079,14 +1186,24 @@ static int loongson_canfd_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	rx_ch = dma_request_chan(dev, "rx");
+	if (PTR_ERR(rx_ch) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	if (IS_ERR(rx_ch)) {
+		dev_warn(dev, "Fall back in poll mode for any non-deferral error.\n");
+		rx_ch = NULL;
+	}
+
 	/* Create a CAN device instance */
 	ndev = alloc_candev(sizeof(*priv), LOONGSON_CANFD_TXBUF_NUM);
 	if (!ndev)
-		return -ENOMEM;
+		goto err_dma_rx;
 
 	priv = netdev_priv(ndev);
 	spin_lock_init(&priv->tx_lock);
 	priv->regmap = regmap;
+	priv->rx_ch = rx_ch;
 	priv->res = res;
 
 	priv->can.clock.freq = clk_rate;
@@ -1111,6 +1228,19 @@ static int loongson_canfd_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_candev_free;
 
+	if (priv->rx_ch) {
+		priv->get_rx_data = loongson_canfd_get_rxdma_data;
+		priv->get_rx_pending = loongson_canfd_rxdma_pending;
+		priv->last_res = LOONGSON_CANFD_DMA_RXDATA_NUM;
+		ret = loongson_canfd_rxdma_init(priv, dev);
+		if (ret) {
+			dev_err(dev, "interrupt mode used for rx (no dma)\n");
+			goto err_candev_free;
+		}
+	} else {
+		priv->get_rx_data = loongson_canfd_get_poll_data;
+		priv->get_rx_pending = loongson_canfd_rxpoll_pending;
+	}
 	netif_napi_add(ndev, &priv->napi, loongson_canfd_rx_napi);
 
 	ret = register_candev(ndev);
@@ -1123,6 +1253,9 @@ static int loongson_canfd_probe(struct platform_device *pdev)
 
 err_candev_free:
 	free_candev(ndev);
+err_dma_rx:
+	if (rx_ch)
+		dma_release_channel(rx_ch);
 	return ret;
 }
 
@@ -1133,6 +1266,11 @@ static void loongson_canfd_remove(struct platform_device *pdev)
 
 	netdev_dbg(ndev, "loongson_canfd_remove");
 
+	if (priv->rx_ch) {
+		loongson_canfd_rxdma_remove(priv, &pdev->dev);
+		dma_release_channel(priv->rx_ch);
+	}
+
 	unregister_candev(ndev);
 	netif_napi_del(&priv->napi);
 	free_candev(ndev);
@@ -1154,6 +1292,7 @@ static struct platform_driver loongson_canfd_driver = {
 };
 module_platform_driver(loongson_canfd_driver);
 
+MODULE_SOFTDEP("pre: loongson2-apb-cmc-dma");
 MODULE_AUTHOR("Loongson Technology Corporation Limited");
 MODULE_DESCRIPTION("Loongson CAN-FD Controller driver");
 MODULE_LICENSE("GPL");
-- 
2.52.0


