Return-Path: <linux-can+bounces-8021-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id av3jMJucTGolnAEAu9opvQ
	(envelope-from <linux-can+bounces-8021-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 08:28:43 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D06F717F2D
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 08:28:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8021-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-8021-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C81E1301B802
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 06:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47198388E43;
	Tue,  7 Jul 2026 06:28:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D3138887D
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 06:28:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783405721; cv=none; b=Sy2pl4YXH7/YD8rdxLXOaPtP3LV36bYhyxOD5qcgB0hW3ePKUYUVVAKVglwATEI5KLARmGncCMS1fwhu4cg8+Ek/TnfVTQzPiIMqgRU6dIFgHFE8sl3zCpQ/ip11Rw+w/UymZPyVCZ5pHFf+xqOT3ANiWPNP56wqLXbkS+w1FoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783405721; c=relaxed/simple;
	bh=DXRtuLxEwzcJalR0RpFFYEXLIjD376aIycbzF2YrDRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjnQCXdkWzeWNsWPeU40sPtpzJxTQptW4AVv1ysGM5heEv0yt0Okucsu59gf90QXpEYN3NCmeLX/S5eZBql7KbWdA6hzLbLxOJGw+aY1XGGy9l1fAVI1DpZg4sh0Gakkqoyf/xY59eor4EEX88FFELKHoIUVWyL0YYodS5edCMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Received: from loongson.cn (unknown [223.64.68.155])
	by gateway (Coremail) with SMTP id _____8Axz+uUnExq1M0AAA--.3573S3;
	Tue, 07 Jul 2026 14:28:36 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.155])
	by front1 (Coremail) with SMTP id qMiowJCxvMaPnExqbpoDAA--.21344S4;
	Tue, 07 Jul 2026 14:28:35 +0800 (CST)
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
Subject: [PATCH v4 2/2] can: loongson_canfd: Add RXDMA support
Date: Tue,  7 Jul 2026 14:28:25 +0800
Message-ID: <f46c0a1607cac2d8bad84f62707ef4e07fe0b2fa.1783391759.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1783391759.git.zhoubinbin@loongson.cn>
References: <cover.1783391759.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxvMaPnExqbpoDAA--.21344S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEBCGpMhCwBJQAAsg
X-Coremail-Antispam: 1Uk129KBj9fXoW3CF4rXF13Gr4UCFWkCw4xXwc_yoW8JF43Xo
	WfWanxKr4rGw18Jr1UKF1fXr17Za4DZrs0yrZakr1kCa90y3WUArZ8WF4fJr18Ka4Fqa15
	uayrWF4xGw4Sqr43l-sFpf9Il3svdjkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYA7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUAVWUZwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8EoGPUUUUU==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8021-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhoubb.aaron@gmail.com,m:chenhuacai@loongson.cn,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:libingxiong@loongson.cn,m:chenhuacai@kernel.org,m:kernel@xen0n.name,m:loongarch@lists.linux.dev,m:linux-can@vger.kernel.org,m:jeffbai@aosc.io,m:zhoubinbin@loongson.cn,m:zhoubbaaron@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,loongson.cn,pengutronix.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[loongson.cn];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zhoubinbin@loongson.cn,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoubinbin@loongson.cn,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D06F717F2D

Extend the driver with an optional DMA engine support for the receive
path. When a DMA channel named `rx` is available (e.g., from the
loongson2-apb-cmc-dma driver), the RX buffer is mapped to a cyclic DMA
transfer that continuously fills a pre-allocated ring buffer. The driver
then readds incoming CAN frames directly from the DMA buffer, reducing
the number of MMIO accesses and improving performance under high
traffic.

The DMA mode is completely transparent to the under networking stack;
the driver automatically selects the appropriate RX data reading method
based on the availability of the DMA channel.

Co-developed-by: Bingxiong Li <libingxiong@loongson.cn>
Signed-off-by: Bingxiong Li <libingxiong@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/net/can/Kconfig          |   2 +-
 drivers/net/can/loongson_canfd.c | 197 ++++++++++++++++++++++++++++---
 2 files changed, 182 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 55c40b0654fb..f367517ede0d 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -191,7 +191,7 @@ config CAN_KVASER_PCIEFD
 
 config CAN_LOONGSON_CANFD
 	tristate "Loongson CAN-FD controller"
-	depends on HAS_IOMEM
+	depends on HAS_IOMEM && (LOONGSON2_APB_CMC_DMA || COMPILE_TEST)
 	select REGMAP_MMIO
 	help
 	  This is a canfd driver switch for the Loongson platform,
diff --git a/drivers/net/can/loongson_canfd.c b/drivers/net/can/loongson_canfd.c
index 83aa620c9d58..17af6505bf0c 100644
--- a/drivers/net/can/loongson_canfd.c
+++ b/drivers/net/can/loongson_canfd.c
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
 #include <linux/ethtool.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
@@ -339,8 +343,10 @@
 #define DEV_NAME			"loongson_canfd"
 #define LOONGSON_CANFD_ID		0xBABE
 #define LOONGSON_CANFD_DW_BYTE		4
+#define LOONGSON_CANFD_RXBUF_SZ		SZ_1K
 #define LOONGSON_CANFD_TXBUF_NUM	8
 #define LOONGSON_CANFD_MAX_RTXTH	0xf
+#define LOONGSON_CANFD_RXDMA_NUM	(LOONGSON_CANFD_RXBUF_SZ / DMA_SLAVE_BUSWIDTH_4_BYTES)
 
 /**
  * struct loongson_canfd_priv - This definition define CAN driver instance
@@ -348,14 +354,26 @@
  * @napi: NAPI structure
  * @regmap: regmap of the CAN device
  * @res: Pointer to the CAN device respurce
+ * @rx_ch: CAN DMA rx channel
+ * @rx_dma_buf: CAN DMA rx buffer bus address
+ * @rx_buf: CAN DMA rx buffer cpu address
+ * @last_res: Last rx data in DMA route
  * @tx_lock: Lock for synchronizing TX interrupt handling
+ * @get_rx_data:  Callback of reading CAN rx data
+ * @get_rxbuf_empty: Callback of gets the RX buffer is empty in dma mode
  */
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
+	bool (*get_rxbuf_empty)(struct loongson_canfd_priv *priv);
 };
 
 /**
@@ -546,13 +564,138 @@ static void loongson_canfd_set_txbuf_cmd(struct net_device *ndev,
 }
 
 /**
- * loongson_canfd_rxbuf_empty() - Gets the RX buffer is empty
+ * loongson_canfd_get_rxdata_in_dma() - Reading RX data in DMA mode
+ * @priv: Pointer to private data
+ *
+ * Return: The CANFD RX data.
+ */
+static u32 loongson_canfd_get_rxdata_in_dma(struct loongson_canfd_priv *priv)
+{
+	u32 data = 0;
+
+	data = priv->rx_buf[LOONGSON_CANFD_RXDMA_NUM - priv->last_res--];
+	if (!priv->last_res)
+		priv->last_res = LOONGSON_CANFD_RXDMA_NUM;
+
+	return data;
+}
+
+/**
+ * loongson_canfd_get_rxbuf_empty_in_dma() - Gets the RX buffer is empty in dma mode
+ * @priv: Pointer to private data
+ *
+ * Return: True - RX buffer is empty.
+ *	   False - RX buffer is processing
+ */
+static bool loongson_canfd_get_rxbuf_empty_in_dma(struct loongson_canfd_priv *priv)
+{
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	status = dmaengine_tx_status(priv->rx_ch, priv->rx_ch->cookie, &state);
+
+	return priv->last_res == (state.residue / DMA_SLAVE_BUSWIDTH_4_BYTES) &&
+	       (status == DMA_IN_PROGRESS);
+}
+
+static void loongson_canfd_rxdma_free(struct loongson_canfd_priv *priv, struct device *dev)
+{
+	dma_free_coherent(dev, LOONGSON_CANFD_RXBUF_SZ, priv->rx_buf, priv->rx_dma_buf);
+}
+
+static void loongson_canfd_rxdma_remove(struct loongson_canfd_priv *priv, struct device *dev)
+{
+	if (!priv->rx_ch)
+		return;
+
+	dmaengine_terminate_sync(priv->rx_ch);
+	loongson_canfd_rxdma_free(priv, dev);
+	dma_release_channel(priv->rx_ch);
+}
+
+/**
+ * loongson_canfd_rxdma_init() - Loongson canfd RXDMA initialization
+ * @ndev: Pointer to net_device structure
+ *
+ * Return: The number of messages in the receive buffer
+ */
+static int loongson_canfd_rxdma_init(struct net_device *ndev)
+{
+	struct loongson_canfd_priv *priv = netdev_priv(ndev);
+	struct dma_async_tx_descriptor *desc = NULL;
+	struct device *dev = ndev->dev.parent;
+	struct dma_slave_config config;
+	int ret;
+
+	if (!priv->rx_ch)
+		return -EINVAL;
+
+	priv->rx_buf = dma_alloc_coherent(dev, LOONGSON_CANFD_RXBUF_SZ,
+					  &priv->rx_dma_buf, GFP_KERNEL);
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
+		netdev_err(ndev, "Loongson canfd rxdma channel config failed\n");
+		goto err_config;
+	}
+
+	/* Prepare a DMA cyclic transaction */
+	desc = dmaengine_prep_dma_cyclic(priv->rx_ch, priv->rx_dma_buf,
+					 LOONGSON_CANFD_RXBUF_SZ, LOONGSON_CANFD_RXBUF_SZ,
+					 DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
+	if (!desc) {
+		netdev_err(ndev, "Loongson canfd rxdma cyclic transaction failed\n");
+		ret = -EBUSY;
+		goto err_config;
+	}
+
+	/* Push current dma transaction in the pending queue */
+	ret = dma_submit_error(dmaengine_submit(desc));
+	if (ret) {
+		dmaengine_terminate_sync(priv->rx_ch);
+		goto err_config;
+	}
+
+	/* Issue pending DMA requests */
+	dma_async_issue_pending(priv->rx_ch);
+
+	return 0;
+
+err_config:
+	loongson_canfd_rxdma_free(priv, dev);
+	return ret;
+}
+
+/**
+ * loongson_canfd_get_rxdata_in_poll() - Reading RX data in poll mode
+ * @priv: Pointer to private data
+ *
+ * Return: The CANFD RX data.
+ */
+static u32 loongson_canfd_get_rxdata_in_poll(struct loongson_canfd_priv *priv)
+{
+	u32 data;
+
+	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
+
+	return data;
+}
+
+/**
+ * loongson_canfd_get_rxbuf_empty_in_poll() - Gets the RX buffer is empty in poll mode
  * @priv: Pointer to private data
  *
  * Return: True - RX buffer is empty.
  *	   False - RX buffer is processing
  */
-static bool loongson_canfd_rxbuf_empty(struct loongson_canfd_priv *priv)
+static bool loongson_canfd_get_rxbuf_empty_in_poll(struct loongson_canfd_priv *priv)
 {
 	return !!regmap_test_bits(priv->regmap, LOONGSON_CANFD_RX_STAT, REG_RX_STAT_RXE);
 }
@@ -777,8 +920,8 @@ static int loongson_canfd_chip_start(struct net_device *ndev)
 	loongson_canfd_set_conf_mode(priv);
 
 	/* Configure interrupts */
-	int_ena = REG_INT_STAT_RBNEI | REG_INT_STAT_TXBHCI |
-		  REG_INT_STAT_EWLI | REG_INT_STAT_FCSI;
+	int_ena = REG_INT_STAT_TXBHCI | REG_INT_STAT_EWLI | REG_INT_STAT_FCSI;
+	int_ena |= priv->rx_ch ? REG_INT_STAT_DMADI : REG_INT_STAT_RBNEI;
 
 	/* Bus error reporting */
 	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
@@ -980,8 +1123,8 @@ static int loongson_canfd_rx(struct net_device *ndev)
 	struct sk_buff *skb;
 	bool is_can_fd;
 
-	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &meta0);
-	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &meta1);
+	meta0 = priv->get_rx_data(priv);
+	meta1 = priv->get_rx_data(priv);
 
 	/* Number of characters received */
 	if (!FIELD_GET(REG_FRAME_META1_RWCNT, meta1))
@@ -1028,7 +1171,7 @@ static int loongson_canfd_rx(struct net_device *ndev)
 
 	/* Data */
 	for (unsigned int i = 0; i < cfd->len; i += LOONGSON_CANFD_DW_BYTE)
-		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, (u32 *)(cfd->data + i));
+		*(u32 *)(cf->data + i) = priv->get_rx_data(priv);
 
 	if (!(cfd->can_id & CAN_RTR_FLAG))
 		stats->rx_bytes += cfd->len;
@@ -1244,16 +1387,17 @@ static int loongson_canfd_rx_napi(struct napi_struct *napi, int quota)
 {
 	struct net_device *ndev = napi->dev;
 	struct loongson_canfd_priv *priv = netdev_priv(ndev);
+	int int_ena = priv->rx_ch ? REG_INT_STAT_DMADI : REG_INT_STAT_RBNEI;
 	int work_done = 0, ret = 1;
 	bool rxbuf_is_empty;
 	u32 sts;
 
-	rxbuf_is_empty = loongson_canfd_rxbuf_empty(priv);
+	rxbuf_is_empty = priv->get_rxbuf_empty(priv);
 
 	while (!rxbuf_is_empty && work_done < quota && ret > 0) {
 		ret = loongson_canfd_rx(ndev);
 		work_done++;
-		rxbuf_is_empty = loongson_canfd_rxbuf_empty(priv);
+		rxbuf_is_empty = priv->get_rxbuf_empty(priv);
 	}
 
 	/* Check for RX FIFO Overflow */
@@ -1281,12 +1425,11 @@ static int loongson_canfd_rx_napi(struct napi_struct *napi, int quota)
 	if (rxbuf_is_empty && ret != 0) {
 		if (napi_complete_done(napi, work_done)) {
 			/*
-			 * Clear and enable RBNEI. It is level-triggered,
+			 * Clear and enable RBNEI/DMADI. It is level-triggered, so
 			 * so there is no race condition.
 			 */
-			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, REG_INT_STAT_RBNEI);
-			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK,
-				     (REG_INT_STAT_RBNEI << 16));
+			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, int_ena);
+			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, (int_ena << 16));
 		}
 	}
 
@@ -1377,13 +1520,14 @@ static irqreturn_t loongson_canfd_interrupt(int irq, void *dev_id)
 		}
 
 		/* Receive Buffer Not Empty Interrupt */
-		if (isr & REG_INT_STAT_RBNEI) {
+		imask = priv->rx_ch ? REG_INT_STAT_DMADI : REG_INT_STAT_RBNEI;
+		if (isr & imask) {
 			/*
 			 * Mask RXBNEI the first, then clear interrupt and schedule NAPI.
 			 * Even if another IRQ fires, RBNEI will always be 0 (masked).
 			 */
-			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, REG_INT_STAT_RBNEI);
-			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, REG_INT_STAT_RBNEI);
+			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, imask);
+			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, imask);
 			napi_schedule(&priv->napi);
 		}
 
@@ -1635,6 +1779,24 @@ static int loongson_canfd_probe(struct platform_device *pdev)
 	ndev->ethtool_ops = &loongson_canfd_ethtool_ops;
 	SET_NETDEV_DEV(ndev, dev);
 
+	priv->get_rx_data = loongson_canfd_get_rxdata_in_poll;
+	priv->get_rxbuf_empty = loongson_canfd_get_rxbuf_empty_in_poll;
+
+	priv->rx_ch = dma_request_chan(dev, "rx");
+	if (PTR_ERR(priv->rx_ch) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	if (IS_ERR(priv->rx_ch)) {
+		dev_warn(dev, "Fall back in poll mode for any non-deferral error.\n");
+		priv->rx_ch = NULL;
+	}
+
+	ret = loongson_canfd_rxdma_init(ndev);
+	if (!ret) {
+		priv->get_rx_data = loongson_canfd_get_rxdata_in_dma;
+		priv->get_rxbuf_empty = loongson_canfd_get_rxbuf_empty_in_dma;
+		priv->last_res = LOONGSON_CANFD_RXDMA_NUM;
+	}
 	netif_napi_add(ndev, &priv->napi, loongson_canfd_rx_napi);
 
 	ret = register_candev(ndev);
@@ -1647,6 +1809,7 @@ static int loongson_canfd_probe(struct platform_device *pdev)
 
 err_candev_free:
 	netif_napi_del(&priv->napi);
+	loongson_canfd_rxdma_remove(priv, &pdev->dev);
 	free_candev(ndev);
 	return ret;
 }
@@ -1664,6 +1827,7 @@ static void loongson_canfd_remove(struct platform_device *pdev)
 
 	unregister_candev(ndev);
 	netif_napi_del(&priv->napi);
+	loongson_canfd_rxdma_remove(priv, &pdev->dev);
 	free_candev(ndev);
 }
 
@@ -1683,6 +1847,7 @@ static struct platform_driver loongson_canfd_driver = {
 };
 module_platform_driver(loongson_canfd_driver);
 
+MODULE_SOFTDEP("pre: loongson2-apb-cmc-dma");
 MODULE_AUTHOR("Loongson Technology Corporation Limited");
 MODULE_DESCRIPTION("Loongson CAN-FD Controller driver");
 MODULE_LICENSE("GPL");
-- 
2.52.0


