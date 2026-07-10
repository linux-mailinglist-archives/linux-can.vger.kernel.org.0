Return-Path: <linux-can+bounces-8267-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K8l6KWSsUGrn3AIAu9opvQ
	(envelope-from <linux-can+bounces-8267-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 10:25:08 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5B3738688
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 10:25:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8267-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8267-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0CD33060D04
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 08:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88AD366079;
	Fri, 10 Jul 2026 08:22:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827993EF670
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 08:22:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671755; cv=none; b=jY37mhdSJgZ+evoFoGJ55CZFvCVw0OokQQ0y7XlFCCIHyCaysfPqWk21rLaSIMdolC1D1y2JFDLRTBGT18+chyji7KkWv7WWw2lUKe7fr9aiaP3dWMOZFse+vc17Qj7Oy82FHPVIAbfWgBitbKjfgEt0tARZGtcfCriPiM4vjC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671755; c=relaxed/simple;
	bh=CRHwwYOHcrzKZbpf9tL0NA3Riqa+2EIT9FJJI0Pxhr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWUki64KF4LtQPhEKTaJYfzgJePf7/QY/YxkCJXjyl/gNtAhg8zlDXxmAIzkPOZnR7xeHUlE+2Ju3jjHon9Q79zpom/5q98ydV5lLuaYCyRp4dXtSbd4Tr8mYsdDbN++BcyAwkGR4BpwjDNjm4g+BTGgoaogzUTGAq5kgdSCl9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Received: from loongson.cn (unknown [223.64.68.155])
	by gateway (Coremail) with SMTP id _____8BxGfDHq1Bq5DMCAA--.9335S3;
	Fri, 10 Jul 2026 16:22:31 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.155])
	by front1 (Coremail) with SMTP id qMiowJAxTOW8q1Bqex0IAA--.25035S4;
	Fri, 10 Jul 2026 16:22:29 +0800 (CST)
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
Subject: [PATCH v5 2/2] can: loongson_canfd: Add RXDMA support
Date: Fri, 10 Jul 2026 16:22:14 +0800
Message-ID: <2f8810bf1a8c1114f837f27bac6b1d6bb9c1a99b.1783670733.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1783670733.git.zhoubinbin@loongson.cn>
References: <cover.1783670733.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxTOW8q1Bqex0IAA--.25035S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEECGpQeKwEZQAAsA
X-Coremail-Antispam: 1Uk129KBj9fXoW3CF4rXF13Gr4UCFWkCw4xXwc_yoW8JFW8Ko
	WfWanxKF4Fkw18Jr1UKF13Xr17Za4DZrsrArZakr4kCa90y3WDArZ8Wa1fJr1rta4Fqa15
	uayrWF4xGw4ftr43l-sFpf9Il3svdjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYy7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
	xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07jz2NtUUUUU=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8267-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhoubb.aaron@gmail.com,m:chenhuacai@loongson.cn,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:libingxiong@loongson.cn,m:chenhuacai@kernel.org,m:kernel@xen0n.name,m:loongarch@lists.linux.dev,m:linux-can@vger.kernel.org,m:jeffbai@aosc.io,m:zhoubinbin@loongson.cn,m:zhoubbaaron@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,loongson.cn,pengutronix.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[loongson.cn];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zhoubinbin@loongson.cn,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:from_mime,loongson.cn:email,loongson.cn:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C5B3738688

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
 drivers/net/can/loongson_canfd.c | 217 ++++++++++++++++++++++++++++---
 2 files changed, 200 insertions(+), 19 deletions(-)

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
index 0e85005a9bb1..bed64c15d22a 100644
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
@@ -348,14 +354,28 @@
  * @napi: NAPI structure
  * @regmap: regmap of the CAN device
  * @res: Pointer to the CAN device respurce
+ * @rx_ch: CAN DMA rx channel
+ * @rx_cookie: CAN DMA rx cookie
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
+	dma_cookie_t		rx_cookie;
+	dma_addr_t		rx_dma_buf;	/* dma rx buffer bus address */
+	unsigned int		*rx_buf;	/* dma rx buffer cpu address */
+	u16			last_res;
 	spinlock_t		tx_lock;	/* protect the sending queue */
+	u32 (*get_rx_data)(struct loongson_canfd_priv *priv);
+	bool (*get_rxbuf_empty)(struct loongson_canfd_priv *priv);
 };
 
 /**
@@ -546,13 +566,141 @@ static void loongson_canfd_set_txbuf_cmd(struct net_device *ndev,
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
+	status = dmaengine_tx_status(priv->rx_ch, priv->rx_cookie, &state);
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
+	priv->rx_ch = NULL;
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
+	priv->rx_cookie = dmaengine_submit(desc);
+	ret = dma_submit_error(priv->rx_cookie);
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
+	priv->rx_ch = NULL;
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
@@ -777,8 +925,11 @@ static int loongson_canfd_chip_start(struct net_device *ndev)
 	loongson_canfd_set_conf_mode(priv);
 
 	/* Configure interrupts */
-	int_ena = REG_INT_STAT_RBNEI | REG_INT_STAT_TXBHCI |
-		  REG_INT_STAT_EWLI | REG_INT_STAT_FCSI;
+	int_ena = REG_INT_STAT_TXBHCI | REG_INT_STAT_EWLI | REG_INT_STAT_FCSI;
+	if (priv->rx_ch)
+		int_ena |= REG_INT_STAT_DMADI;
+	else
+		int_ena |= REG_INT_STAT_RBNEI;
 
 	/* Bus error reporting */
 	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
@@ -980,8 +1131,8 @@ static int loongson_canfd_rx(struct net_device *ndev)
 	struct sk_buff *skb;
 	bool is_can_fd;
 
-	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &meta0);
-	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &meta1);
+	meta0 = priv->get_rx_data(priv);
+	meta1 = priv->get_rx_data(priv);
 
 	/* Number of characters received */
 	rwcnt = FIELD_GET(REG_FRAME_META1_RWCNT, meta1);
@@ -1033,7 +1184,7 @@ static int loongson_canfd_rx(struct net_device *ndev)
 
 	/* Data */
 	for (i = 0; i < dbcnt; i += LOONGSON_CANFD_DW_BYTE)
-		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, (u32 *)(cfd->data + i));
+		*(u32 *)(cfd->data + i) = priv->get_rx_data(priv);
 
 	while (unlikely(i < dbcnt)) {
 		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
@@ -1256,12 +1407,12 @@ static int loongson_canfd_rx_napi(struct napi_struct *napi, int quota)
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
@@ -1288,13 +1439,18 @@ static int loongson_canfd_rx_napi(struct napi_struct *napi, int quota)
 
 	if (rxbuf_is_empty && ret != 0) {
 		if (napi_complete_done(napi, work_done)) {
+			int int_ena;
 			/*
-			 * Clear and enable RBNEI. It is level-triggered,
+			 * Clear and enable RBNEI/DMADI. It is level-triggered, so
 			 * so there is no race condition.
 			 */
-			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, REG_INT_STAT_RBNEI);
-			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK,
-				     (REG_INT_STAT_RBNEI << 16));
+			if (priv->rx_ch)
+				int_ena = REG_INT_STAT_DMADI;
+			else
+				int_ena = REG_INT_STAT_RBNEI;
+
+			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, int_ena);
+			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, (int_ena << 16));
 		}
 	}
 
@@ -1404,13 +1560,14 @@ static irqreturn_t loongson_canfd_interrupt(int irq, void *dev_id)
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
 
@@ -1663,18 +1820,40 @@ static int loongson_canfd_probe(struct platform_device *pdev)
 	ndev->ethtool_ops = &loongson_canfd_ethtool_ops;
 	SET_NETDEV_DEV(ndev, dev);
 
+	priv->get_rx_data = loongson_canfd_get_rxdata_in_poll;
+	priv->get_rxbuf_empty = loongson_canfd_get_rxbuf_empty_in_poll;
+
+	priv->rx_ch = dma_request_chan(dev, "rx");
+	if (PTR_ERR(priv->rx_ch) == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
+		goto err_candev_free;
+	}
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
 	if (ret) {
 		dev_err(dev, "register_candev failed with %d\n", ret);
-		goto err_candev_free;
+		goto err_napi_del;
 	}
 
 	return 0;
 
-err_candev_free:
+err_napi_del:
 	netif_napi_del(&priv->napi);
+	loongson_canfd_rxdma_remove(priv, &pdev->dev);
+err_candev_free:
 	free_candev(ndev);
 	return ret;
 }
@@ -1692,6 +1871,7 @@ static void loongson_canfd_remove(struct platform_device *pdev)
 
 	unregister_candev(ndev);
 	netif_napi_del(&priv->napi);
+	loongson_canfd_rxdma_remove(priv, &pdev->dev);
 	free_candev(ndev);
 }
 
@@ -1711,6 +1891,7 @@ static struct platform_driver loongson_canfd_driver = {
 };
 module_platform_driver(loongson_canfd_driver);
 
+MODULE_SOFTDEP("pre: loongson2-apb-cmc-dma");
 MODULE_AUTHOR("Loongson Technology Corporation Limited");
 MODULE_DESCRIPTION("Loongson CAN-FD Controller driver");
 MODULE_LICENSE("GPL");
-- 
2.52.0


