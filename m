Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2191873A47A
	for <lists+linux-can@lfdr.de>; Thu, 22 Jun 2023 17:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjFVPMp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jun 2023 11:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjFVPMg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Jun 2023 11:12:36 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0F5213E
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 08:12:22 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f871c93a5fso6658521e87.2
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 08:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1687446740; x=1690038740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGWNZk1ysBukZwRgytgsfQzxJ0b9jhYqF4lvlZD8K40=;
        b=S5VL/ec1nK0jzzz8Tk+7jpvuTcP6bLgIZFLbbO9Vgy926fx/fcPoOasMfd6/uFKVZ6
         pxI6FYMZq07jd+MHeM31LZxtPikyyLsZBYC2KRLMaAIijJ6DFnEp/X680G771RomT4Kb
         pzvSb67lRqaYoR8ICyI2YHU5qjVvjlVdTkKxVGDE8xisjsNxfVaHTZ2UmxT4J+kQk+hg
         ksACddBQatvHDVm7ffe5eWBX+OFRxZolwPDArP4RnZiUnFxgOMtziXi6ntm1JRvdP9dA
         s3ynXJKjB33uvMTbxonRZusyrT4VFwwEwxieOU4bKMoxWWJfju0TD/UdaasPAzHdad1T
         4ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687446740; x=1690038740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGWNZk1ysBukZwRgytgsfQzxJ0b9jhYqF4lvlZD8K40=;
        b=gjAhNB6S+5ZGA/mRSimzFvPjLBSxU0Prx0SQ3Tm5IpE4ZFlXwzjoxmWYfvW07Bc5OH
         ksFWMBriIYZ8pUfC1lLkd00T1kbd2civMLrty0YFgEOUMklqrAk6fBctSq3T/kT7ZqTs
         9/MIXhbKa5rtOYPklNAQmEwzbP7GbNkLlOuDKM+JX6VyblRlVAHn8LcqP2kC89/RVYN4
         KQA+3ItItvJFcBqaJcv+zjaLO8QOyffNRfGs25OEQY6ibAWfkq6Wq+ksbHhp/We5Jero
         4rk8VhWO7QU54urJmnyV73+ZHwpP0pzZCch6cTNde3NMM3DAII1pc98ReHWzWtcv/I8u
         xkyg==
X-Gm-Message-State: AC+VfDzBqDUwkPpAgJJg56v7rtrD3eA7Ydzbf25l3XuQs05BFeFgvuOU
        WHdZ/5wYrS/qc7yjY4on/nzuqP6VgZnp2SUuyH8=
X-Google-Smtp-Source: ACHHUZ7N37Z3y2/MaZnDIL53zlVyljpRiBaUg3X+bXLK0POoVrvyK/WxH6Kjf/8TexfDBqTgLK33fA==
X-Received: by 2002:a19:8c14:0:b0:4f8:5cde:a44f with SMTP id o20-20020a198c14000000b004f85cdea44fmr10136485lfd.10.1687446740318;
        Thu, 22 Jun 2023 08:12:20 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id p2-20020a19f002000000b004f85885cff1sm1117787lfc.134.2023.06.22.08.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 08:12:19 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Martin Jocic <majoc@kvaser.com>
Subject: [PATCH v2 1/2] can: kvaser_pciefd: Move hardware specific constants and functions into a driver_data struct
Date:   Thu, 22 Jun 2023 17:11:52 +0200
Message-Id: <20230622151153.294844-2-extja@kvaser.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230622151153.294844-1-extja@kvaser.com>
References: <20230622151153.294844-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Move hardware specific address offsets, interrupt masks and DMA mapping
function, into struct kvaser_pciefd_driver_data, as a step towards adding
new devices based on different hardware.

Co-developed-by: Martin Jocic <majoc@kvaser.com>
Signed-off-by: Martin Jocic <majoc@kvaser.com>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
 - Rebased on
   can: kvaser_pciefd: Fixes and improvements [1]
 - Moved some parts of
   can: kvaser_pciefd: Wrap register read and writes with macros [2]
   into this patch
 - Renamed macro KVASER_PCIEFD_64BIT_DMA_BIT to KVASER_PCIEFD_ALTERA_DMA_64BIT
 - Replaced constant with GENMASK

[1] https://lore.kernel.org/all/20230529134248.752036-1-extja@kvaser.com
[2] https://lore.kernel.org/linux-can/20230523094354.83792-17-extja@kvaser.com

 drivers/net/can/kvaser_pciefd.c | 230 +++++++++++++++++++++-----------
 1 file changed, 154 insertions(+), 76 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index db6256f2b1b3..539f97390761 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -33,37 +33,17 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_DMA_SIZE (4U * 1024U)
 
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
-/* DMA address translation map register base */
-#define KVASER_PCIEFD_DMA_MAP_BASE 0x1000
-/* Loopback control register */
-#define KVASER_PCIEFD_LOOP_REG 0x1f000
-/* System identification and information registers */
-#define KVASER_PCIEFD_SYSID_BASE 0x1f020
-#define KVASER_PCIEFD_SYSID_VERSION_REG (KVASER_PCIEFD_SYSID_BASE + 0x8)
-#define KVASER_PCIEFD_SYSID_CANFREQ_REG (KVASER_PCIEFD_SYSID_BASE + 0xc)
-#define KVASER_PCIEFD_SYSID_BUSFREQ_REG (KVASER_PCIEFD_SYSID_BASE + 0x10)
-#define KVASER_PCIEFD_SYSID_BUILD_REG (KVASER_PCIEFD_SYSID_BASE + 0x14)
-/* Shared receive buffer registers */
-#define KVASER_PCIEFD_SRB_BASE 0x1f200
-#define KVASER_PCIEFD_SRB_FIFO_LAST_REG (KVASER_PCIEFD_SRB_BASE + 0x1f4)
-#define KVASER_PCIEFD_SRB_CMD_REG (KVASER_PCIEFD_SRB_BASE + 0x200)
-#define KVASER_PCIEFD_SRB_IEN_REG (KVASER_PCIEFD_SRB_BASE + 0x204)
-#define KVASER_PCIEFD_SRB_IRQ_REG (KVASER_PCIEFD_SRB_BASE + 0x20c)
-#define KVASER_PCIEFD_SRB_STAT_REG (KVASER_PCIEFD_SRB_BASE + 0x210)
-#define KVASER_PCIEFD_SRB_RX_NR_PACKETS_REG (KVASER_PCIEFD_SRB_BASE + 0x214)
-#define KVASER_PCIEFD_SRB_CTRL_REG (KVASER_PCIEFD_SRB_BASE + 0x218)
+/* Altera SerDes Enable 64-bit DMA address translation */
+#define KVASER_PCIEFD_ALTERA_DMA_64BIT BIT(0)
+
 /* Kvaser KCAN CAN controller registers */
-#define KVASER_PCIEFD_KCAN0_BASE 0x10000
-#define KVASER_PCIEFD_KCAN_BASE_OFFSET 0x1000
 #define KVASER_PCIEFD_KCAN_FIFO_REG 0x100
 #define KVASER_PCIEFD_KCAN_FIFO_LAST_REG 0x180
 #define KVASER_PCIEFD_KCAN_CTRL_REG 0x2c0
@@ -77,13 +57,20 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_KCAN_BUS_LOAD_REG 0x424
 #define KVASER_PCIEFD_KCAN_BTRD_REG 0x428
 #define KVASER_PCIEFD_KCAN_PWM_REG 0x430
-
-/* PCI interrupt fields */
-#define KVASER_PCIEFD_IRQ_SRB BIT(4)
-#define KVASER_PCIEFD_IRQ_ALL_MASK GENMASK(4, 0)
-
-/* Enable 64-bit DMA address translation */
-#define KVASER_PCIEFD_64BIT_DMA_BIT BIT(0)
+/* System identification and information registers */
+#define KVASER_PCIEFD_SYSID_VERSION_REG 0x8
+#define KVASER_PCIEFD_SYSID_CANFREQ_REG 0xc
+#define KVASER_PCIEFD_SYSID_BUSFREQ_REG 0x10
+#define KVASER_PCIEFD_SYSID_BUILD_REG 0x14
+/* Shared receive buffer FIFO registers */
+#define KVASER_PCIEFD_SRB_FIFO_LAST_REG 0x1f4
+/* Shared receive buffer registers */
+#define KVASER_PCIEFD_SRB_CMD_REG 0x0
+#define KVASER_PCIEFD_SRB_IEN_REG 0x04
+#define KVASER_PCIEFD_SRB_IRQ_REG 0x0c
+#define KVASER_PCIEFD_SRB_STAT_REG 0x10
+#define KVASER_PCIEFD_SRB_RX_NR_PACKETS_REG 0x14
+#define KVASER_PCIEFD_SRB_CTRL_REG 0x18
 
 /* System build information fields */
 #define KVASER_PCIEFD_SYSID_VERSION_NR_CHAN_MASK GENMASK(31, 24)
@@ -253,7 +240,92 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 /* KCAN Error detected packet, second word */
 #define KVASER_PCIEFD_EPACK_DIR_TX BIT(0)
 
+/* Macros for calculating addresses of registers */
+#define KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, block) \
+	((pcie)->reg_base + (pcie)->driver_data->address_offset->block)
+#define KVASER_PCIEFD_PCI_IEN_ADDR(pcie) \
+	(KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), pci_ien))
+#define KVASER_PCIEFD_PCI_IRQ_ADDR(pcie) \
+	(KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), pci_irq))
+#define KVASER_PCIEFD_SERDES_ADDR(pcie) \
+	(KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), serdes))
+#define KVASER_PCIEFD_SYSID_ADDR(pcie) \
+	(KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), sysid))
+#define KVASER_PCIEFD_LOOPBACK_ADDR(pcie) \
+	(KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), loopback))
+#define KVASER_PCIEFD_SRB_FIFO_ADDR(pcie) \
+	(KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), kcan_srb_fifo))
+#define KVASER_PCIEFD_SRB_ADDR(pcie) \
+	(KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), kcan_srb))
+#define KVASER_PCIEFD_KCAN_CH0_ADDR(pcie) \
+	(KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), kcan_ch0))
+#define KVASER_PCIEFD_KCAN_CH1_ADDR(pcie) \
+	(KVASER_PCIEFD_GET_BLOCK_ADDR((pcie), kcan_ch1))
+#define KVASER_PCIEFD_KCAN_CHANNEL_SPAN(pcie) \
+	(KVASER_PCIEFD_KCAN_CH1_ADDR((pcie)) - KVASER_PCIEFD_KCAN_CH0_ADDR((pcie)))
+#define KVASER_PCIEFD_KCAN_CHX_ADDR(pcie, i) \
+	(KVASER_PCIEFD_KCAN_CH0_ADDR((pcie)) + (i) * KVASER_PCIEFD_KCAN_CHANNEL_SPAN((pcie)))
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
+	.all = GENMASK(4, 0),
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
@@ -273,6 +345,7 @@ struct kvaser_pciefd {
 	struct pci_dev *pci;
 	void __iomem *reg_base;
 	struct kvaser_pciefd_can *can[KVASER_PCIEFD_MAX_CAN_CHANNELS];
+	const struct kvaser_pciefd_driver_data *driver_data;
 	void *dma_data[KVASER_PCIEFD_DMA_COUNT];
 	u8 nr_channels;
 	u32 bus_freq;
@@ -305,18 +378,23 @@ static const struct can_bittiming_const kvaser_pciefd_bittiming_const = {
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
@@ -783,8 +861,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		can = netdev_priv(netdev);
 		netdev->netdev_ops = &kvaser_pciefd_netdev_ops;
 		netdev->ethtool_ops = &kvaser_pciefd_ethtool_ops;
-		can->reg_base = pcie->reg_base + KVASER_PCIEFD_KCAN0_BASE +
-				i * KVASER_PCIEFD_KCAN_BASE_OFFSET;
+		can->reg_base = KVASER_PCIEFD_KCAN_CHX_ADDR(pcie, i);
 		can->kv_pcie = pcie;
 		can->cmd_seq = 0;
 		can->err_rep_cnt = 0;
@@ -865,20 +942,22 @@ static int kvaser_pciefd_reg_candev(struct kvaser_pciefd *pcie)
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
-	word1 = addr | KVASER_PCIEFD_64BIT_DMA_BIT;
+	word1 = addr | KVASER_PCIEFD_ALTERA_DMA_64BIT;
 	word2 = addr >> 32;
 #else
 	word1 = addr;
 	word2 = 0;
 #endif
-	iowrite32(word1, pcie->reg_base + offset);
-	iowrite32(word2, pcie->reg_base + offset + 4);
+	serdes_base = KVASER_PCIEFD_SERDES_ADDR(pcie) + 0x8 * index;
+	iowrite32(word1, serdes_base);
+	iowrite32(word2, serdes_base + 0x4);
 }
 
 static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
@@ -889,10 +968,8 @@ static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
 	dma_addr_t dma_addr[KVASER_PCIEFD_DMA_COUNT];
 
 	/* Disable the DMA */
-	iowrite32(0, pcie->reg_base + KVASER_PCIEFD_SRB_CTRL_REG);
+	iowrite32(0, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CTRL_REG);
 	for (i = 0; i < KVASER_PCIEFD_DMA_COUNT; i++) {
-		unsigned int offset = KVASER_PCIEFD_DMA_MAP_BASE + 8 * i;
-
 		pcie->dma_data[i] = dmam_alloc_coherent(&pcie->pci->dev,
 							KVASER_PCIEFD_DMA_SIZE,
 							&dma_addr[i],
@@ -903,24 +980,25 @@ static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
 				KVASER_PCIEFD_DMA_SIZE);
 			return -ENOMEM;
 		}
-		kvaser_pciefd_write_dma_map(pcie, dma_addr[i], offset);
+		pcie->driver_data->ops->kvaser_pciefd_write_dma_map(pcie, dma_addr[i], i);
 	}
 
 	/* Reset Rx FIFO, and both DMA buffers */
 	iowrite32(KVASER_PCIEFD_SRB_CMD_FOR | KVASER_PCIEFD_SRB_CMD_RDB0 |
 		  KVASER_PCIEFD_SRB_CMD_RDB1,
-		  pcie->reg_base + KVASER_PCIEFD_SRB_CMD_REG);
+		  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
 	/* Empty Rx FIFO */
 	srb_packet_count =
 		FIELD_GET(KVASER_PCIEFD_SRB_RX_NR_PACKETS_MASK,
-			  ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_RX_NR_PACKETS_REG));
+			  ioread32(KVASER_PCIEFD_SRB_ADDR(pcie) +
+				   KVASER_PCIEFD_SRB_RX_NR_PACKETS_REG));
 	while (srb_packet_count) {
 		/* Drop current packet in FIFO */
-		ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_FIFO_LAST_REG);
+		ioread32(KVASER_PCIEFD_SRB_FIFO_ADDR(pcie) + KVASER_PCIEFD_SRB_FIFO_LAST_REG);
 		srb_packet_count--;
 	}
 
-	srb_status = ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_STAT_REG);
+	srb_status = ioread32(KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_STAT_REG);
 	if (!(srb_status & KVASER_PCIEFD_SRB_STAT_DI)) {
 		dev_err(&pcie->pci->dev, "DMA not idle before enabling\n");
 		return -EIO;
@@ -928,7 +1006,7 @@ static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
 
 	/* Enable the DMA */
 	iowrite32(KVASER_PCIEFD_SRB_CTRL_DMA_ENABLE,
-		  pcie->reg_base + KVASER_PCIEFD_SRB_CTRL_REG);
+		  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CTRL_REG);
 
 	return 0;
 }
@@ -937,30 +1015,29 @@ static int kvaser_pciefd_setup_board(struct kvaser_pciefd *pcie)
 {
 	u32 version, srb_status, build;
 
-	version = ioread32(pcie->reg_base + KVASER_PCIEFD_SYSID_VERSION_REG);
+	version = ioread32(KVASER_PCIEFD_SYSID_ADDR(pcie) + KVASER_PCIEFD_SYSID_VERSION_REG);
 	pcie->nr_channels = min(KVASER_PCIEFD_MAX_CAN_CHANNELS,
 				FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_NR_CHAN_MASK, version));
 
-	build = ioread32(pcie->reg_base + KVASER_PCIEFD_SYSID_BUILD_REG);
+	build = ioread32(KVASER_PCIEFD_SYSID_ADDR(pcie) + KVASER_PCIEFD_SYSID_BUILD_REG);
 	dev_dbg(&pcie->pci->dev, "Version %lu.%lu.%lu\n",
 		FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MAJOR_MASK, version),
 		FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MINOR_MASK, version),
 		FIELD_GET(KVASER_PCIEFD_SYSID_BUILD_SEQ_MASK, build));
 
-	srb_status = ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_STAT_REG);
+	srb_status = ioread32(KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_STAT_REG);
 	if (!(srb_status & KVASER_PCIEFD_SRB_STAT_DMA)) {
 		dev_err(&pcie->pci->dev, "Hardware without DMA is not supported\n");
 		return -ENODEV;
 	}
 
-	pcie->bus_freq = ioread32(pcie->reg_base +
-				  KVASER_PCIEFD_SYSID_BUSFREQ_REG);
-	pcie->freq = ioread32(pcie->reg_base + KVASER_PCIEFD_SYSID_CANFREQ_REG);
+	pcie->bus_freq = ioread32(KVASER_PCIEFD_SYSID_ADDR(pcie) + KVASER_PCIEFD_SYSID_BUSFREQ_REG);
+	pcie->freq = ioread32(KVASER_PCIEFD_SYSID_ADDR(pcie) + KVASER_PCIEFD_SYSID_CANFREQ_REG);
 	pcie->freq_to_ticks_div = pcie->freq / 1000000;
 	if (pcie->freq_to_ticks_div == 0)
 		pcie->freq_to_ticks_div = 1;
 	/* Turn off all loopback functionality */
-	iowrite32(0, pcie->reg_base + KVASER_PCIEFD_LOOP_REG);
+	iowrite32(0, KVASER_PCIEFD_LOOPBACK_ADDR(pcie));
 
 	return 0;
 }
@@ -1430,21 +1507,20 @@ static int kvaser_pciefd_read_buffer(struct kvaser_pciefd *pcie, int dma_buf)
 
 static void kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
 {
-	u32 irq;
+	u32 irq = ioread32(KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IRQ_REG);
 
-	irq = ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_IRQ_REG);
 	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD0) {
 		kvaser_pciefd_read_buffer(pcie, 0);
 		/* Reset DMA buffer 0 */
 		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB0,
-			  pcie->reg_base + KVASER_PCIEFD_SRB_CMD_REG);
+			  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
 	}
 
 	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD1) {
 		kvaser_pciefd_read_buffer(pcie, 1);
 		/* Reset DMA buffer 1 */
 		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB1,
-			  pcie->reg_base + KVASER_PCIEFD_SRB_CMD_REG);
+			  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
 	}
 
 	if (irq & KVASER_PCIEFD_SRB_IRQ_DOF0 ||
@@ -1453,7 +1529,7 @@ static void kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
 	    irq & KVASER_PCIEFD_SRB_IRQ_DUF1)
 		dev_err(&pcie->pci->dev, "DMA IRQ error 0x%08X\n", irq);
 
-	iowrite32(irq, pcie->reg_base + KVASER_PCIEFD_SRB_IRQ_REG);
+	iowrite32(irq, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IRQ_REG);
 }
 
 static void kvaser_pciefd_transmit_irq(struct kvaser_pciefd_can *can)
@@ -1479,15 +1555,14 @@ static void kvaser_pciefd_transmit_irq(struct kvaser_pciefd_can *can)
 static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
 {
 	struct kvaser_pciefd *pcie = (struct kvaser_pciefd *)dev;
-	u32 board_irq;
+	const struct kvaser_pciefd_irq_mask *irq_mask = pcie->driver_data->irq_mask;
+	u32 board_irq = ioread32(KVASER_PCIEFD_PCI_IRQ_ADDR(pcie));
 	int i;
 
-	board_irq = ioread32(pcie->reg_base + KVASER_PCIEFD_IRQ_REG);
-
-	if (!(board_irq & KVASER_PCIEFD_IRQ_ALL_MASK))
+	if (!(board_irq & irq_mask->all))
 		return IRQ_NONE;
 
-	if (board_irq & KVASER_PCIEFD_IRQ_SRB)
+	if (board_irq & irq_mask->kcan_rx0)
 		kvaser_pciefd_receive_irq(pcie);
 
 	for (i = 0; i < pcie->nr_channels; i++) {
@@ -1498,7 +1573,7 @@ static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
 		}
 
 		/* Check that mask matches channel (i) IRQ mask */
-		if (board_irq & (1 << i))
+		if (board_irq & irq_mask->kcan_tx[i])
 			kvaser_pciefd_transmit_irq(pcie->can[i]);
 	}
 
@@ -1525,6 +1600,8 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 {
 	int err;
 	struct kvaser_pciefd *pcie;
+	const struct kvaser_pciefd_irq_mask *irq_mask;
+	void __iomem *irq_en_base;
 
 	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
@@ -1532,6 +1609,8 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, pcie);
 	pcie->pci = pdev;
+	pcie->driver_data = (const struct kvaser_pciefd_driver_data *)id->driver_data;
+	irq_mask = pcie->driver_data->irq_mask;
 
 	err = pci_enable_device(pdev);
 	if (err)
@@ -1567,22 +1646,21 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 		goto err_teardown_can_ctrls;
 
 	iowrite32(KVASER_PCIEFD_SRB_IRQ_DPD0 | KVASER_PCIEFD_SRB_IRQ_DPD1,
-		  pcie->reg_base + KVASER_PCIEFD_SRB_IRQ_REG);
+		  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IRQ_REG);
 
 	iowrite32(KVASER_PCIEFD_SRB_IRQ_DPD0 | KVASER_PCIEFD_SRB_IRQ_DPD1 |
 		  KVASER_PCIEFD_SRB_IRQ_DOF0 | KVASER_PCIEFD_SRB_IRQ_DOF1 |
 		  KVASER_PCIEFD_SRB_IRQ_DUF0 | KVASER_PCIEFD_SRB_IRQ_DUF1,
-		  pcie->reg_base + KVASER_PCIEFD_SRB_IEN_REG);
+		  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IEN_REG);
 
 	/* Enable PCI interrupts */
-	iowrite32(KVASER_PCIEFD_IRQ_ALL_MASK,
-		  pcie->reg_base + KVASER_PCIEFD_IEN_REG);
-
+	irq_en_base = KVASER_PCIEFD_PCI_IEN_ADDR(pcie);
+	iowrite32(irq_mask->all, irq_en_base);
 	/* Ready the DMA buffers */
 	iowrite32(KVASER_PCIEFD_SRB_CMD_RDB0,
-		  pcie->reg_base + KVASER_PCIEFD_SRB_CMD_REG);
+		  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
 	iowrite32(KVASER_PCIEFD_SRB_CMD_RDB1,
-		  pcie->reg_base + KVASER_PCIEFD_SRB_CMD_REG);
+		  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
 
 	err = kvaser_pciefd_reg_candev(pcie);
 	if (err)
@@ -1592,12 +1670,12 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 
 err_free_irq:
 	/* Disable PCI interrupts */
-	iowrite32(0, pcie->reg_base + KVASER_PCIEFD_IEN_REG);
+	iowrite32(0, irq_en_base);
 	free_irq(pcie->pci->irq, pcie);
 
 err_teardown_can_ctrls:
 	kvaser_pciefd_teardown_can_ctrls(pcie);
-	iowrite32(0, pcie->reg_base + KVASER_PCIEFD_SRB_CTRL_REG);
+	iowrite32(0, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CTRL_REG);
 	pci_clear_master(pdev);
 
 err_pci_iounmap:
@@ -1636,8 +1714,8 @@ static void kvaser_pciefd_remove(struct pci_dev *pdev)
 	kvaser_pciefd_remove_all_ctrls(pcie);
 
 	/* Disable interrupts */
-	iowrite32(0, pcie->reg_base + KVASER_PCIEFD_SRB_CTRL_REG);
-	iowrite32(0, pcie->reg_base + KVASER_PCIEFD_IEN_REG);
+	iowrite32(0, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CTRL_REG);
+	iowrite32(0, KVASER_PCIEFD_PCI_IEN_ADDR(pcie));
 
 	free_irq(pcie->pci->irq, pcie);
 
-- 
2.40.0

