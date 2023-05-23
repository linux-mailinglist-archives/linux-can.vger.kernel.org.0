Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD7070D967
	for <lists+linux-can@lfdr.de>; Tue, 23 May 2023 11:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbjEWJpa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 May 2023 05:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbjEWJpY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 May 2023 05:45:24 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEE1120
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:16 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2af177f12d1so68116551fa.0
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684835055; x=1687427055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHP1c0pU1lWw0EBTIQc14oTIvAKTbaACqFWRpP7Jkc0=;
        b=Jl4cqZYRf29gheekfG2acHZad/FNsVbsDwRKDGm3Bghdnq7l0m+m/tdb0hMSwgSl3b
         fRtzYKUAA1FxnqI+brGA3plj8DuQBbJIKv/0ETAXJ4ArM8E8pLT0Wg3T0d2FBiaim/vH
         a3dsUWBe2PPXayBAt2zH/IzfY+ap5yr85YMrhcrcXXoOzB6YuFlvzDaogyj4y+K5t3Gu
         XVfGzcUcM3kIErcZLnLQc8PFXDWEP3o2X+WmCY6pFR3ciMxBK/OL+SYyxlxUPrBxszdz
         a9yJAxkX4RcHwUMKGq6BylbDpP2ZNpDbZHW2RulIA/EvydoBzFHeBDLKXF37tCw3JUdj
         KG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835055; x=1687427055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHP1c0pU1lWw0EBTIQc14oTIvAKTbaACqFWRpP7Jkc0=;
        b=DXax0Qn9CCW30n3k1iZzE2XHj2Hu1Mt91p7tZDLonF7rj7gwRGvEs9M0gsHIXL/M64
         002xgPoOhXopD75uIVMZf93p9HME3UScjnEC1UIHtTLFmoKaKU9hrXdePXVeXuHNbCc0
         T4oIK+NeC0/73fNQ/+l6LchUFqfRWntek1KfG35+n1Qmai2EaCb+F1E06O1+2yCRThog
         KgajSEO+PCn2PGpngF5Bj0m0pyvY2s6XZ0IWtst5DjMSYDMn0q6Zv4cq+C6nx/CaLkaZ
         nmvGgB72Z31UIzdxF3MDAppHyvQOuPMSHncoQnM+IOLOYaE4TJ44GCW5fF5OKiUAJBFg
         NUDA==
X-Gm-Message-State: AC+VfDxR7oWvTlnKXd2Tvps5EEKLGRcq2OZnBiU7LYQUr32H6CH0fndh
        CbbopOazjMyLnRFDBI+iw0bp3KMCCNcY4SKsgUw=
X-Google-Smtp-Source: ACHHUZ5Z0515TSQ8FaqicE9/qt70WxRNbPXkYv4ZRGyNliLH5vsGWnLoPg4Ebd03Y5L4bdnnS8A1tw==
X-Received: by 2002:a2e:b209:0:b0:2a7:7d70:6bb with SMTP id l9-20020a2eb209000000b002a77d7006bbmr4606728ljm.2.1684835054987;
        Tue, 23 May 2023 02:44:14 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id c16-20020a2e9490000000b002ac87c15fd4sm1535551ljh.95.2023.05.23.02.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:44:14 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 1/3] can: kvaser_pciefd: Move hardware specific constants and functions into a driver_data struct
Date:   Tue, 23 May 2023 11:43:52 +0200
Message-Id: <20230523094354.83792-15-extja@kvaser.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230523094354.83792-1-extja@kvaser.com>
References: <20230523094354.83792-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Move hardware specific address offsets, interrupt masks and DMA mapping
function, into struct kvaser_pciefd_driver_data, as a step towards adding
new devices based on different hardware.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 205 ++++++++++++++++++++++----------
 1 file changed, 140 insertions(+), 65 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 5f67414e2875..992af04c627c 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -33,20 +33,14 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_64BIT_DMA_BIT BIT(0)
 
 #define KVASER_PCIEFD_VENDOR 0x1a07
+/* Altera based devices */
 #define KVASER_PCIEFD_4HS_DEVICE_ID 0x000d
 #define KVASER_PCIEFD_2HS_V2_DEVICE_ID 0x000e
 #define KVASER_PCIEFD_HS_V2_DEVICE_ID 0x000f
 #define KVASER_PCIEFD_MINIPCIE_HS_V2_DEVICE_ID 0x0010
 #define KVASER_PCIEFD_MINIPCIE_2HS_V2_DEVICE_ID 0x0011
 
-/* PCIe IRQ registers */
-#define KVASER_PCIEFD_IRQ_REG 0x40
-#define KVASER_PCIEFD_IEN_REG 0x50
-/* DMA map */
-#define KVASER_PCIEFD_DMA_MAP_BASE 0x1000
 /* Kvaser KCAN CAN controller registers */
-#define KVASER_PCIEFD_KCAN0_BASE 0x10000
-#define KVASER_PCIEFD_KCAN_BASE_OFFSET 0x1000
 #define KVASER_PCIEFD_KCAN_FIFO_REG 0x100
 #define KVASER_PCIEFD_KCAN_FIFO_LAST_REG 0x180
 #define KVASER_PCIEFD_KCAN_CTRL_REG 0x2c0
@@ -60,26 +54,20 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_KCAN_BUS_LOAD_REG 0x424
 #define KVASER_PCIEFD_KCAN_BTRD_REG 0x428
 #define KVASER_PCIEFD_KCAN_PWM_REG 0x430
-/* Loopback control register */
-#define KVASER_PCIEFD_LOOP_REG 0x1f000
 /* System identification and information registers */
-#define KVASER_PCIEFD_SYSID_BASE 0x1f020
-#define KVASER_PCIEFD_SYSID_VERSION_REG (KVASER_PCIEFD_SYSID_BASE + 0x8)
-#define KVASER_PCIEFD_SYSID_CANFREQ_REG (KVASER_PCIEFD_SYSID_BASE + 0xc)
-#define KVASER_PCIEFD_SYSID_BUSFREQ_REG (KVASER_PCIEFD_SYSID_BASE + 0x10)
-#define KVASER_PCIEFD_SYSID_BUILD_REG (KVASER_PCIEFD_SYSID_BASE + 0x14)
+#define KVASER_PCIEFD_SYSID_VERSION_REG 0x8
+#define KVASER_PCIEFD_SYSID_CANFREQ_REG 0xc
+#define KVASER_PCIEFD_SYSID_BUSFREQ_REG 0x10
+#define KVASER_PCIEFD_SYSID_BUILD_REG 0x14
+/* Shared receive buffer FIFO registers */
+#define KVASER_PCIEFD_SRB_FIFO_LAST_REG 0x1f4
 /* Shared receive buffer registers */
-#define KVASER_PCIEFD_SRB_BASE 0x1f200
-#define KVASER_PCIEFD_SRB_FIFO_LAST_REG (KVASER_PCIEFD_SRB_BASE + 0x1f4)
-#define KVASER_PCIEFD_SRB_CMD_REG (KVASER_PCIEFD_SRB_BASE + 0x200)
-#define KVASER_PCIEFD_SRB_IEN_REG (KVASER_PCIEFD_SRB_BASE + 0x204)
-#define KVASER_PCIEFD_SRB_IRQ_REG (KVASER_PCIEFD_SRB_BASE + 0x20c)
-#define KVASER_PCIEFD_SRB_STAT_REG (KVASER_PCIEFD_SRB_BASE + 0x210)
-#define KVASER_PCIEFD_SRB_RX_NR_PACKETS_REG (KVASER_PCIEFD_SRB_BASE + 0x214)
-#define KVASER_PCIEFD_SRB_CTRL_REG (KVASER_PCIEFD_SRB_BASE + 0x218)
-
-#define KVASER_PCIEFD_IRQ_ALL_MSK 0x1f
-#define KVASER_PCIEFD_IRQ_SRB BIT(4)
+#define KVASER_PCIEFD_SRB_CMD_REG 0x0
+#define KVASER_PCIEFD_SRB_IEN_REG 0x04
+#define KVASER_PCIEFD_SRB_IRQ_REG 0x0c
+#define KVASER_PCIEFD_SRB_STAT_REG 0x10
+#define KVASER_PCIEFD_SRB_RX_NR_PACKETS_REG 0x14
+#define KVASER_PCIEFD_SRB_CTRL_REG 0x18
 
 #define KVASER_PCIEFD_SYSID_VERSION_NR_CHAN_SHIFT 24
 #define KVASER_PCIEFD_SYSID_VERSION_MAJOR_SHIFT 16
@@ -238,7 +226,69 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 /* Kvaser KCAN_EPACK second word */
 #define KVASER_PCIEFD_EPACK_DIR_TX BIT(0)
 
+#define KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, block) \
+	((pcie)->reg_base + (pcie)->driver_data->address_offset->block)
+
 struct kvaser_pciefd;
+static void kvaser_pciefd_write_dma_map_altera(struct kvaser_pciefd *pcie,
+					       dma_addr_t addr, int index);
+
+struct kvaser_pciefd_address_offset {
+	u32 serdes;
+	u32 pci_ien;
+	u32 pci_irq;
+	u32 sysid;
+	u32 loopback;
+	u32 kcan_srb_fifo;
+	u32 kcan_srb;
+	u32 kcan_ch0;
+	u32 kcan_ch1;
+};
+
+struct kvaser_pciefd_dev_ops {
+	void (*kvaser_pciefd_write_dma_map)(struct kvaser_pciefd *pcie,
+					    dma_addr_t addr, int index);
+};
+
+struct kvaser_pciefd_irq_mask {
+	u32 kcan_rx0;
+	u32 kcan_tx[KVASER_PCIEFD_MAX_CAN_CHANNELS];
+	u32 all;
+};
+
+struct kvaser_pciefd_driver_data {
+	const struct kvaser_pciefd_address_offset *address_offset;
+	const struct kvaser_pciefd_irq_mask *irq_mask;
+	const struct kvaser_pciefd_dev_ops *ops;
+};
+
+const struct kvaser_pciefd_address_offset kvaser_pciefd_altera_address_offset = {
+	.serdes = 0x1000,
+	.pci_ien = 0x50,
+	.pci_irq = 0x40,
+	.sysid = 0x1f020,
+	.loopback = 0x1f000,
+	.kcan_srb_fifo = 0x1f200,
+	.kcan_srb = 0x1f400,
+	.kcan_ch0 = 0x10000,
+	.kcan_ch1 = 0x11000,
+};
+
+const struct kvaser_pciefd_irq_mask kvaser_pciefd_altera_irq_mask = {
+	.kcan_rx0 = BIT(4),
+	.kcan_tx = { BIT(0), BIT(1), BIT(2), BIT(3) },
+	.all = 0x0000001f,
+};
+
+const struct kvaser_pciefd_dev_ops kvaser_pciefd_altera_dev_ops = {
+	.kvaser_pciefd_write_dma_map = kvaser_pciefd_write_dma_map_altera,
+};
+
+const struct kvaser_pciefd_driver_data kvaser_pciefd_altera_driver_data = {
+	.address_offset = &kvaser_pciefd_altera_address_offset,
+	.irq_mask = &kvaser_pciefd_altera_irq_mask,
+	.ops = &kvaser_pciefd_altera_dev_ops,
+};
 
 struct kvaser_pciefd_can {
 	struct can_priv can;
@@ -258,6 +308,7 @@ struct kvaser_pciefd {
 	struct pci_dev *pci;
 	void __iomem *reg_base;
 	struct kvaser_pciefd_can *can[KVASER_PCIEFD_MAX_CAN_CHANNELS];
+	const struct kvaser_pciefd_driver_data *driver_data;
 	void *dma_data[KVASER_PCIEFD_DMA_COUNT];
 	u8 nr_channels;
 	u32 bus_freq;
@@ -290,18 +341,23 @@ static const struct can_bittiming_const kvaser_pciefd_bittiming_const = {
 static struct pci_device_id kvaser_pciefd_id_table[] = {
 	{
 		PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_4HS_DEVICE_ID),
+		.driver_data = (kernel_ulong_t)&kvaser_pciefd_altera_driver_data,
 	},
 	{
 		PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_2HS_V2_DEVICE_ID),
+		.driver_data = (kernel_ulong_t)&kvaser_pciefd_altera_driver_data,
 	},
 	{
 		PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_HS_V2_DEVICE_ID),
+		.driver_data = (kernel_ulong_t)&kvaser_pciefd_altera_driver_data,
 	},
 	{
 		PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_MINIPCIE_HS_V2_DEVICE_ID),
+		.driver_data = (kernel_ulong_t)&kvaser_pciefd_altera_driver_data,
 	},
 	{
 		PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_MINIPCIE_2HS_V2_DEVICE_ID),
+		.driver_data = (kernel_ulong_t)&kvaser_pciefd_altera_driver_data,
 	},
 	{
 		0,
@@ -755,7 +811,11 @@ static const struct ethtool_ops kvaser_pciefd_ethtool_ops = {
 static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 {
 	int i;
+	void __iomem *kcan_ch0_base;
+	u64 kcan_controller_span;
 
+	kcan_ch0_base = KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, kcan_ch0);
+	kcan_controller_span = KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, kcan_ch1) - kcan_ch0_base;
 	for (i = 0; i < pcie->nr_channels; i++) {
 		struct net_device *netdev;
 		struct kvaser_pciefd_can *can;
@@ -769,8 +829,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		can = netdev_priv(netdev);
 		netdev->netdev_ops = &kvaser_pciefd_netdev_ops;
 		netdev->ethtool_ops = &kvaser_pciefd_ethtool_ops;
-		can->reg_base = pcie->reg_base + KVASER_PCIEFD_KCAN0_BASE +
-				i * KVASER_PCIEFD_KCAN_BASE_OFFSET;
+		can->reg_base = kcan_ch0_base + i * kcan_controller_span;
 		can->kv_pcie = pcie;
 		can->cmd_seq = 0;
 		can->err_rep_cnt = 0;
@@ -851,9 +910,10 @@ static int kvaser_pciefd_reg_candev(struct kvaser_pciefd *pcie)
 	return 0;
 }
 
-static void kvaser_pciefd_write_dma_map(struct kvaser_pciefd *pcie,
-					dma_addr_t addr, int offset)
+static void kvaser_pciefd_write_dma_map_altera(struct kvaser_pciefd *pcie,
+					       dma_addr_t addr, int index)
 {
+	void __iomem *serdes_base;
 	u32 word1, word2;
 
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
@@ -863,22 +923,24 @@ static void kvaser_pciefd_write_dma_map(struct kvaser_pciefd *pcie,
 	word1 = addr;
 	word2 = 0;
 #endif
-	iowrite32(word1, pcie->reg_base + offset);
-	iowrite32(word2, pcie->reg_base + offset + 4);
+	serdes_base = KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, serdes) + 0x8 * index;
+	iowrite32(word1, serdes_base);
+	iowrite32(word2, serdes_base + 0x4);
 }
 
 static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
 {
+	void __iomem *kcan_srb_base;
+	const struct kvaser_pciefd_dev_ops *dev_ops = pcie->driver_data->ops;
 	int i;
 	u32 srb_status;
 	u32 srb_packet_count;
 	dma_addr_t dma_addr[KVASER_PCIEFD_DMA_COUNT];
 
+	kcan_srb_base = KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, kcan_srb);
 	/* Disable the DMA */
-	iowrite32(0, pcie->reg_base + KVASER_PCIEFD_SRB_CTRL_REG);
+	iowrite32(0, kcan_srb_base + KVASER_PCIEFD_SRB_CTRL_REG);
 	for (i = 0; i < KVASER_PCIEFD_DMA_COUNT; i++) {
-		unsigned int offset = KVASER_PCIEFD_DMA_MAP_BASE + 8 * i;
-
 		pcie->dma_data[i] = dmam_alloc_coherent(&pcie->pci->dev,
 							KVASER_PCIEFD_DMA_SIZE,
 							&dma_addr[i],
@@ -889,23 +951,24 @@ static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
 				KVASER_PCIEFD_DMA_SIZE);
 			return -ENOMEM;
 		}
-		kvaser_pciefd_write_dma_map(pcie, dma_addr[i], offset);
+		dev_ops->kvaser_pciefd_write_dma_map(pcie, dma_addr[i], i);
 	}
 
 	/* Reset Rx FIFO, and both DMA buffers */
 	iowrite32(KVASER_PCIEFD_SRB_CMD_FOR | KVASER_PCIEFD_SRB_CMD_RDB0 |
 		  KVASER_PCIEFD_SRB_CMD_RDB1,
-		  pcie->reg_base + KVASER_PCIEFD_SRB_CMD_REG);
+		  kcan_srb_base + KVASER_PCIEFD_SRB_CMD_REG);
 	/* Empty Rx FIFO */
-	srb_packet_count = ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_RX_NR_PACKETS_REG) &
+	srb_packet_count = ioread32(kcan_srb_base + KVASER_PCIEFD_SRB_RX_NR_PACKETS_REG) &
 			   KVASER_PCIEFD_SRB_RX_NR_PACKETS_MASK;
 	while (srb_packet_count) {
 		/* Drop current packet in FIFO */
-		ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_FIFO_LAST_REG);
+		ioread32(KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, kcan_srb_fifo) +
+			 KVASER_PCIEFD_SRB_FIFO_LAST_REG);
 		srb_packet_count--;
 	}
 
-	srb_status = ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_STAT_REG);
+	srb_status = ioread32(kcan_srb_base + KVASER_PCIEFD_SRB_STAT_REG);
 	if (!(srb_status & KVASER_PCIEFD_SRB_STAT_DI)) {
 		dev_err(&pcie->pci->dev, "DMA not idle before enabling\n");
 		return -EIO;
@@ -913,39 +976,43 @@ static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
 
 	/* Enable the DMA */
 	iowrite32(KVASER_PCIEFD_SRB_CTRL_DMA_ENABLE,
-		  pcie->reg_base + KVASER_PCIEFD_SRB_CTRL_REG);
+		  kcan_srb_base + KVASER_PCIEFD_SRB_CTRL_REG);
 
 	return 0;
 }
 
 static int kvaser_pciefd_setup_board(struct kvaser_pciefd *pcie)
 {
+	void __iomem *kcan_srb_base;
+	void __iomem *sysid_base;
 	u32 version, srb_status, build;
 
-	version = ioread32(pcie->reg_base + KVASER_PCIEFD_SYSID_VERSION_REG);
+	sysid_base = KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, sysid);
+	version = ioread32(sysid_base + KVASER_PCIEFD_SYSID_VERSION_REG);
 	pcie->nr_channels = min(KVASER_PCIEFD_MAX_CAN_CHANNELS,
 				((version >> KVASER_PCIEFD_SYSID_VERSION_NR_CHAN_SHIFT) & 0xff));
 
-	build = ioread32(pcie->reg_base + KVASER_PCIEFD_SYSID_BUILD_REG);
+	build = ioread32(sysid_base + KVASER_PCIEFD_SYSID_BUILD_REG);
 	dev_dbg(&pcie->pci->dev, "Version %u.%u.%u\n",
 		(version >> KVASER_PCIEFD_SYSID_VERSION_MAJOR_SHIFT) & 0xff,
 		version & 0xff,
 		(build >> KVASER_PCIEFD_SYSID_BUILD_VERSION_SHIFT) & 0x7fff);
 
-	srb_status = ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_STAT_REG);
+	kcan_srb_base = KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, kcan_srb);
+	srb_status = ioread32(kcan_srb_base + KVASER_PCIEFD_SRB_STAT_REG);
 	if (!(srb_status & KVASER_PCIEFD_SRB_STAT_DMA)) {
 		dev_err(&pcie->pci->dev, "Hardware without DMA is not supported\n");
 		return -ENODEV;
 	}
 
-	pcie->bus_freq = ioread32(pcie->reg_base +
+	pcie->bus_freq = ioread32(sysid_base +
 				  KVASER_PCIEFD_SYSID_BUSFREQ_REG);
-	pcie->freq = ioread32(pcie->reg_base + KVASER_PCIEFD_SYSID_CANFREQ_REG);
+	pcie->freq = ioread32(sysid_base + KVASER_PCIEFD_SYSID_CANFREQ_REG);
 	pcie->freq_to_ticks_div = pcie->freq / 1000000;
 	if (pcie->freq_to_ticks_div == 0)
 		pcie->freq_to_ticks_div = 1;
 	/* Turn off all loopback functionality */
-	iowrite32(0, pcie->reg_base + KVASER_PCIEFD_LOOP_REG);
+	iowrite32(0, KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, loopback));
 
 	return 0;
 }
@@ -1415,21 +1482,23 @@ static int kvaser_pciefd_read_buffer(struct kvaser_pciefd *pcie, int dma_buf)
 
 static void kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
 {
+	void __iomem *kcan_srb_base;
 	u32 irq;
 
-	irq = ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_IRQ_REG);
+	kcan_srb_base = KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, kcan_srb);
+	irq = ioread32(kcan_srb_base + KVASER_PCIEFD_SRB_IRQ_REG);
 	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD0) {
 		kvaser_pciefd_read_buffer(pcie, 0);
 		/* Reset DMA buffer 0 */
 		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB0,
-			  pcie->reg_base + KVASER_PCIEFD_SRB_CMD_REG);
+			  kcan_srb_base + KVASER_PCIEFD_SRB_CMD_REG);
 	}
 
 	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD1) {
 		kvaser_pciefd_read_buffer(pcie, 1);
 		/* Reset DMA buffer 1 */
 		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB1,
-			  pcie->reg_base + KVASER_PCIEFD_SRB_CMD_REG);
+			  kcan_srb_base + KVASER_PCIEFD_SRB_CMD_REG);
 	}
 
 	if (irq & KVASER_PCIEFD_SRB_IRQ_DOF0 ||
@@ -1438,7 +1507,7 @@ static void kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
 	    irq & KVASER_PCIEFD_SRB_IRQ_DUF1)
 		dev_err(&pcie->pci->dev, "DMA IRQ error 0x%08X\n", irq);
 
-	iowrite32(irq, pcie->reg_base + KVASER_PCIEFD_SRB_IRQ_REG);
+	iowrite32(irq, kcan_srb_base + KVASER_PCIEFD_SRB_IRQ_REG);
 }
 
 static void kvaser_pciefd_transmit_irq(struct kvaser_pciefd_can *can)
@@ -1464,15 +1533,16 @@ static void kvaser_pciefd_transmit_irq(struct kvaser_pciefd_can *can)
 static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
 {
 	struct kvaser_pciefd *pcie = (struct kvaser_pciefd *)dev;
+	const struct kvaser_pciefd_irq_mask *irq_mask = pcie->driver_data->irq_mask;
 	u32 board_irq;
 	int i;
 
-	board_irq = ioread32(pcie->reg_base + KVASER_PCIEFD_IRQ_REG);
+	board_irq = ioread32(KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, pci_irq));
 
-	if (!(board_irq & KVASER_PCIEFD_IRQ_ALL_MSK))
+	if (!(board_irq & irq_mask->all))
 		return IRQ_NONE;
 
-	if (board_irq & KVASER_PCIEFD_IRQ_SRB)
+	if (board_irq & irq_mask->kcan_rx0)
 		kvaser_pciefd_receive_irq(pcie);
 
 	for (i = 0; i < pcie->nr_channels; i++) {
@@ -1483,7 +1553,7 @@ static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
 		}
 
 		/* Check that mask matches channel (i) IRQ mask */
-		if (board_irq & (1 << i))
+		if (board_irq & irq_mask->kcan_tx[i])
 			kvaser_pciefd_transmit_irq(pcie->can[i]);
 	}
 
@@ -1510,6 +1580,9 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 {
 	int err;
 	struct kvaser_pciefd *pcie;
+	const struct kvaser_pciefd_irq_mask *irq_mask;
+	void __iomem *kcan_srb_base;
+	void __iomem *irq_en_base;
 
 	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
@@ -1517,6 +1590,8 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, pcie);
 	pcie->pci = pdev;
+	pcie->driver_data = (const struct kvaser_pciefd_driver_data *)id->driver_data;
+	irq_mask = pcie->driver_data->irq_mask;
 
 	err = pci_enable_device(pdev);
 	if (err)
@@ -1542,6 +1617,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
+	kcan_srb_base = KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, kcan_srb);
 	err = kvaser_pciefd_setup_can_ctrls(pcie);
 	if (err)
 		goto err_teardown_can_ctrls;
@@ -1552,22 +1628,21 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 		goto err_teardown_can_ctrls;
 
 	iowrite32(KVASER_PCIEFD_SRB_IRQ_DPD0 | KVASER_PCIEFD_SRB_IRQ_DPD1,
-		  pcie->reg_base + KVASER_PCIEFD_SRB_IRQ_REG);
+		  kcan_srb_base + KVASER_PCIEFD_SRB_IRQ_REG);
 
 	iowrite32(KVASER_PCIEFD_SRB_IRQ_DPD0 | KVASER_PCIEFD_SRB_IRQ_DPD1 |
 		  KVASER_PCIEFD_SRB_IRQ_DOF0 | KVASER_PCIEFD_SRB_IRQ_DOF1 |
 		  KVASER_PCIEFD_SRB_IRQ_DUF0 | KVASER_PCIEFD_SRB_IRQ_DUF1,
-		  pcie->reg_base + KVASER_PCIEFD_SRB_IEN_REG);
+		  kcan_srb_base + KVASER_PCIEFD_SRB_IEN_REG);
 
 	/* Enable PCI interrupts */
-	iowrite32(KVASER_PCIEFD_IRQ_ALL_MSK,
-		  pcie->reg_base + KVASER_PCIEFD_IEN_REG);
-
+	irq_en_base = KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, pci_ien);
+	iowrite32(irq_mask->all, irq_en_base);
 	/* Ready the DMA buffers */
 	iowrite32(KVASER_PCIEFD_SRB_CMD_RDB0,
-		  pcie->reg_base + KVASER_PCIEFD_SRB_CMD_REG);
+		  kcan_srb_base + KVASER_PCIEFD_SRB_CMD_REG);
 	iowrite32(KVASER_PCIEFD_SRB_CMD_RDB1,
-		  pcie->reg_base + KVASER_PCIEFD_SRB_CMD_REG);
+		  kcan_srb_base + KVASER_PCIEFD_SRB_CMD_REG);
 
 	err = kvaser_pciefd_reg_candev(pcie);
 	if (err)
@@ -1577,12 +1652,12 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 
 err_free_irq:
 	/* Disable PCI interrupts */
-	iowrite32(0, pcie->reg_base + KVASER_PCIEFD_IEN_REG);
+	iowrite32(0, irq_en_base);
 	free_irq(pcie->pci->irq, pcie);
 
 err_teardown_can_ctrls:
 	kvaser_pciefd_teardown_can_ctrls(pcie);
-	iowrite32(0, pcie->reg_base + KVASER_PCIEFD_SRB_CTRL_REG);
+	iowrite32(0, kcan_srb_base + KVASER_PCIEFD_SRB_CTRL_REG);
 	pci_clear_master(pdev);
 
 err_pci_iounmap:
@@ -1621,8 +1696,8 @@ static void kvaser_pciefd_remove(struct pci_dev *pdev)
 	kvaser_pciefd_remove_all_ctrls(pcie);
 
 	/* Disable interrupts */
-	iowrite32(0, pcie->reg_base + KVASER_PCIEFD_SRB_CTRL_REG);
-	iowrite32(0, pcie->reg_base + KVASER_PCIEFD_IEN_REG);
+	iowrite32(0, KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, kcan_srb) + KVASER_PCIEFD_SRB_CTRL_REG);
+	iowrite32(0, KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, pci_ien));
 
 	free_irq(pcie->pci->irq, pcie);
 
-- 
2.40.0

