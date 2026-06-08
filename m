Return-Path: <linux-can+bounces-7764-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UdlUKeuFJmowYAIAu9opvQ
	(envelope-from <linux-can+bounces-7764-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 08 Jun 2026 11:05:47 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAC76545EA
	for <lists+linux-can@lfdr.de>; Mon, 08 Jun 2026 11:05:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7764-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7764-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 252B4306C996
	for <lists+linux-can@lfdr.de>; Mon,  8 Jun 2026 08:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88343AD51C;
	Mon,  8 Jun 2026 08:50:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9427D3B19BF
	for <linux-can@vger.kernel.org>; Mon,  8 Jun 2026 08:50:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908606; cv=none; b=JRWJaNMFuYMXp82E2knAwt4aAMPRAk2rsDq11++OYICWcCOht2IjY4uRl4Jcc6+wqGV+QQbhyAcgFkqFaLzWHEXmr+pElV3iwPV8I0zXY4licN0G+hj91RtUqejqvyIo7e9Q3yG2lvReJogUBU9PUtoJXkDb0n3gOSFhbpNpW10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908606; c=relaxed/simple;
	bh=YgKv+ERTCPA3PaVpDSUJnNCYc6lLRs3Y8KLlR0FDdaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVw+v7BOCGj19/tfsmZXef7RYaJJpS6DPwul4ZfzbWnw5VZHNfV4T6ItvYnvhDQDduxYmYPQ3pHcJ3fJ83nxUBvUYJ7T8meLI/4JIwBFSY+HU0z9kkB+XRwjcYxe+8W1lRQ4UwIyH9Y3tHJsr1Lc8gLuHK9BEhJ5ZU/LNSerKmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Received: from loongson.cn (unknown [223.64.68.59])
	by gateway (Coremail) with SMTP id _____8BxDuo5giZqBL4RAA--.46637S3;
	Mon, 08 Jun 2026 16:50:01 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.59])
	by front1 (Coremail) with SMTP id qMiowJDxTMIxgiZq1I+fAA--.37894S4;
	Mon, 08 Jun 2026 16:50:00 +0800 (CST)
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
Subject: [PATCH v2 2/2] can: loongson_canfd: Add RXDMA support
Date: Mon,  8 Jun 2026 16:49:47 +0800
Message-ID: <9af2c912e0afd439ea9562ea8aa72ee0af3f2ed3.1780908445.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1780908445.git.zhoubinbin@loongson.cn>
References: <cover.1780908445.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxTMIxgiZq1I+fAA--.37894S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEMCGomWeAFggAAs2
X-Coremail-Antispam: 1Uk129KBj9fXoWfGF1kKFWrJFy8Xr48ur1xWFX_yoW8Gr1UWo
	WfWFs3Kr4rCw18JryUtF1fXF17Z3WDZrsxZrZakr4kGa90y3WUJrZxWr4fJF1rJa4Fqa13
	ua95WF4fGayIqrZxl-sFpf9Il3svdjkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYC7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUAVWUZwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7764-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhoubb.aaron@gmail.com,m:chenhuacai@loongson.cn,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:libingxiong@loongson.cn,m:chenhuacai@kernel.org,m:kernel@xen0n.name,m:loongarch@lists.linux.dev,m:linux-can@vger.kernel.org,m:jeffbai@aosc.io,m:zhoubinbin@loongson.cn,m:zhoubbaaron@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,loongson.cn,pengutronix.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[loongson.cn];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zhoubinbin@loongson.cn,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,loongson.cn:mid,loongson.cn:from_mime,loongson.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1AAC76545EA

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
 drivers/net/can/Kconfig          |   2 +-
 drivers/net/can/loongson_canfd.c | 209 ++++++++++++++++++++++++++++---
 2 files changed, 190 insertions(+), 21 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 28014e264f30..16e07be6438c 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -191,7 +191,7 @@ config CAN_KVASER_PCIEFD
 
 config CAN_LOONGSON_CANFD
 	tristate "Loongson CAN-FD controller"
-	depends on HAS_IOMEM || COMPILE_TEST
+	depends on HAS_IOMEM && (LOONGSON2_APB_CMC_DMA || COMPILE_TEST)
 	select REGMAP_MMIO
 	help
 	  This is a canfd driver switch for the Loongson platform,
diff --git a/drivers/net/can/loongson_canfd.c b/drivers/net/can/loongson_canfd.c
index 3794700e04c8..131d6d008a5d 100644
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
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -376,8 +380,10 @@
 #define DEV_NAME			"loongson_canfd"
 #define LOONGSON_CANFD_ID		0xBABE
 #define LOONGSON_CANFD_DW_BYTE		4
+#define LOONGSON_CANFD_RXBUF_SZ		SZ_1K
 #define LOONGSON_CANFD_TXBUF_NUM	8
 #define LOONGSON_CANFD_MAX_RTXTH	0xf
+#define LOONGSON_CANFD_RXDMA_NUM	(LOONGSON_CANFD_RXBUF_SZ / DMA_SLAVE_BUSWIDTH_4_BYTES)
 
 /**
  * struct loongson_canfd_priv - This definition define CAN driver instance
@@ -385,14 +391,26 @@
  * @napi: NAPI structure
  * @regmap: regmap of the CAN device
  * @res: Pointer to the CAN device respurce
+ * @rx_ch: CAN DMA rx channel
+ * @rx_dma_buf: CAN DMA rx buffer bus address
+ * @rx_buf: CAN DMA rx buffer cpu address
+ * @rx_frc: Last rx data in DMA route
  * @tx_lock: Lock for synchronizing TX interrupt handling
+ * @get_rx_data:  Callback of reading CAN rx data
+ * @get_rx_frc: Callback of the number of messages in the receive buffer
  */
 struct loongson_canfd_priv {
 	struct can_priv		can;		/* must be first member! */
 	struct napi_struct	napi;
 	struct regmap		*regmap;
 	struct resource		*res;
+	struct dma_chan		*rx_ch;
+	dma_addr_t		rx_dma_buf;	/* dma rx buffer bus address */
+	unsigned int		*rx_buf;	/* dma rx buffer cpu address */
+	u16			rx_frc;
 	spinlock_t		tx_lock;	/* protect the sending queue */
+	u32 (*get_rx_data)(struct loongson_canfd_priv *priv);
+	bool (*get_rx_frc)(struct loongson_canfd_priv *priv);
 };
 
 /**
@@ -614,6 +632,125 @@ static int loongson_canfd_reset(struct net_device *ndev)
 	return 0;
 }
 
+/**
+ * loongson_canfd_get_rxdata_in_dma() - Reading RX data in DMA mode
+ * @priv: Pointer to private data
+ *
+ * Return: The CANFD RX data.
+ */
+static u32 loongson_canfd_get_rxdata_in_dma(struct loongson_canfd_priv *priv)
+{
+	u32 c = 0;
+
+	c = priv->rx_buf[LOONGSON_CANFD_RXDMA_NUM - priv->rx_frc--];
+	if (priv->rx_frc == 0)
+		priv->rx_frc = LOONGSON_CANFD_RXDMA_NUM;
+
+	return c;
+}
+
+/**
+ * loongson_canfd_rxfrc_in_dma() - Gets he number of messages in the receive buffer in DMA mode
+ * @priv: Pointer to private data
+ *
+ * Return: The number of messages in the receive buffer
+ */
+static bool loongson_canfd_rxfrc_in_dma(struct loongson_canfd_priv *priv)
+{
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	status = dmaengine_tx_status(priv->rx_ch, priv->rx_ch->cookie, &state);
+
+	return priv->rx_frc != (state.residue / DMA_SLAVE_BUSWIDTH_4_BYTES) &&
+	       (status == DMA_IN_PROGRESS);
+}
+
+static void loongson_canfd_rxdma_remove(struct loongson_canfd_priv *priv, struct device *dev)
+{
+	dma_free_coherent(dev, LOONGSON_CANFD_RXBUF_SZ, priv->rx_buf, priv->rx_dma_buf);
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
+	dmaengine_submit(desc);
+	dma_async_issue_pending(priv->rx_ch);
+
+	return 0;
+
+err_config:
+	loongson_canfd_rxdma_remove(priv, dev);
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
+ * loongson_canfd_rxfrc_in_poll() - Gets he number of messages in the receive buffer in poll mode
+ * @priv: Pointer to private data
+ *
+ * Return: The number of messages in the receive buffer
+ */
+static bool loongson_canfd_rxfrc_in_poll(struct loongson_canfd_priv *priv)
+{
+	u32 rx_sts;
+
+	regmap_read(priv->regmap, LOONGSON_CANFD_RX_STAT, &rx_sts);
+
+	return FIELD_GET(REG_RX_STAT_RXFRC, rx_sts) ? true : false;
+}
+
 /**
  * loongson_canfd_set_btr() - Sets CAN bus bit timing in Loongson CANFD
  * @ndev: Pointer to net_device structure
@@ -838,8 +975,8 @@ static int loongson_canfd_chip_start(struct net_device *ndev)
 	loongson_canfd_set_mode(priv, &mode);
 
 	/* Configure interrupts */
-	int_ena = REG_INT_STAT_RBNEI | REG_INT_STAT_TXBHCI |
-		  REG_INT_STAT_EWLI | REG_INT_STAT_FCSI;
+	int_ena = REG_INT_STAT_TXBHCI | REG_INT_STAT_EWLI | REG_INT_STAT_FCSI;
+	int_ena |= priv->rx_ch ? REG_INT_STAT_DMADI : REG_INT_STAT_RBNEI;
 
 	/* Bus error reporting */
 	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
@@ -1074,12 +1211,12 @@ static void loongson_canfd_read_rx_frame(struct loongson_canfd_priv *priv, struc
 
 	/* Data */
 	for (i = 0; i < len; i += LOONGSON_CANFD_DW_BYTE) {
-		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
+		data = priv->get_rx_data(priv);
 		*(__le32 *)(cf->data + i) = cpu_to_le32(data);
 	}
 
 	while (unlikely(i < wc * LOONGSON_CANFD_DW_BYTE)) {
-		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
+		data = priv->get_rx_data(priv);
 		i += LOONGSON_CANFD_DW_BYTE;
 	}
 }
@@ -1101,8 +1238,8 @@ static int loongson_canfd_rx(struct net_device *ndev)
 	struct sk_buff *skb;
 	u32 meta0, meta1;
 
-	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &meta0);
-	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &meta1);
+	meta0 = priv->get_rx_data(priv);
+	meta1 = priv->get_rx_data(priv);
 
 	/* Number of characters received */
 	if (!FIELD_GET(REG_FRAME_META1_RWCNT, meta1))
@@ -1328,16 +1465,16 @@ static int loongson_canfd_rx_napi(struct napi_struct *napi, int quota)
 	struct net_device *ndev = napi->dev;
 	struct loongson_canfd_priv *priv = netdev_priv(ndev);
 	int work_done = 0, ret = 1;
-	u32 sts, rx_frc, rx_sts;
+	int int_ena = priv->rx_ch ? REG_INT_STAT_DMADI : REG_INT_STAT_RBNEI;
+	bool rx_frc;
+	u32 sts;
 
-	regmap_read(priv->regmap, LOONGSON_CANFD_RX_STAT, &rx_sts);
-	rx_frc = FIELD_GET(REG_RX_STAT_RXFRC, rx_sts);
+	rx_frc = priv->get_rx_frc(priv);
 
 	while (rx_frc && work_done < quota && ret > 0) {
 		ret = loongson_canfd_rx(ndev);
 		work_done++;
-		regmap_read(priv->regmap, LOONGSON_CANFD_RX_STAT, &rx_sts);
-		rx_frc = FIELD_GET(REG_RX_STAT_RXFRC, rx_sts);
+		rx_frc = priv->get_rx_frc(priv);
 	}
 
 	/* Check for RX FIFO Overflow */
@@ -1367,13 +1504,11 @@ static int loongson_canfd_rx_napi(struct napi_struct *napi, int quota)
 	if (!rx_frc && ret != 0) {
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
 
@@ -1460,13 +1595,14 @@ static irqreturn_t loongson_canfd_interrupt(int irq, void *dev_id)
 			return irq_loops ? IRQ_HANDLED : IRQ_NONE;
 
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
 
@@ -1663,6 +1799,7 @@ static int loongson_canfd_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct loongson_canfd_priv *priv;
 	struct net_device *ndev;
+	struct dma_chan *rx_ch;
 	struct regmap *regmap;
 	struct resource *res;
 	void __iomem *base;
@@ -1683,14 +1820,24 @@ static int loongson_canfd_probe(struct platform_device *pdev)
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
@@ -1720,6 +1867,19 @@ static int loongson_canfd_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_candev_free;
 
+	if (priv->rx_ch) {
+		priv->get_rx_data = loongson_canfd_get_rxdata_in_dma;
+		priv->get_rx_frc = loongson_canfd_rxfrc_in_dma;
+		priv->rx_frc = LOONGSON_CANFD_RXDMA_NUM;
+		ret = loongson_canfd_rxdma_init(ndev);
+		if (ret) {
+			dev_err(dev, "interrupt mode used for rx (no dma)\n");
+			goto err_candev_free;
+		}
+	} else {
+		priv->get_rx_data = loongson_canfd_get_rxdata_in_poll;
+		priv->get_rx_frc = loongson_canfd_rxfrc_in_poll;
+	}
 	netif_napi_add(ndev, &priv->napi, loongson_canfd_rx_napi);
 
 	ret = register_candev(ndev);
@@ -1732,6 +1892,9 @@ static int loongson_canfd_probe(struct platform_device *pdev)
 
 err_candev_free:
 	free_candev(ndev);
+err_dma_rx:
+	if (rx_ch)
+		dma_release_channel(rx_ch);
 	return ret;
 }
 
@@ -1740,6 +1903,11 @@ static void loongson_canfd_remove(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct loongson_canfd_priv *priv = netdev_priv(ndev);
 
+	if (priv->rx_ch) {
+		loongson_canfd_rxdma_remove(priv, &pdev->dev);
+		dma_release_channel(priv->rx_ch);
+	}
+
 	unregister_candev(ndev);
 	netif_napi_del(&priv->napi);
 	free_candev(ndev);
@@ -1761,6 +1929,7 @@ static struct platform_driver loongson_canfd_driver = {
 };
 module_platform_driver(loongson_canfd_driver);
 
+MODULE_SOFTDEP("pre: loongson2-apb-cmc-dma");
 MODULE_AUTHOR("Loongson Technology Corporation Limited");
 MODULE_DESCRIPTION("Loongson CAN-FD Controller driver");
 MODULE_LICENSE("GPL");
-- 
2.52.0


