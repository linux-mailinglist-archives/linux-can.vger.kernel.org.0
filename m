Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3CD73A47B
	for <lists+linux-can@lfdr.de>; Thu, 22 Jun 2023 17:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjFVPM5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jun 2023 11:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjFVPMt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Jun 2023 11:12:49 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D911BF9
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 08:12:30 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f86fbe5e4fso6796765e87.2
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 08:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1687446749; x=1690038749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjSv15dzC6nuXKYZrJU9b8Q9RmPOIFKd49BervCX4t0=;
        b=aLgCCNfATgu9N2pX5VU4IaRUHhyCWHQMEPcXPdfJosBJF7scx+OIAMRbyhefPPJHvN
         ILMvO3qZU2plN3k8GoDtv7fL4urUUJRdSwnwBapAtAnZIAbe2zh9vk0A08rsBK9VtzRB
         dsPiJfpGLTfgQETA8DP1wmU5UK6HP8RaqeIUvPXyPZHY0/KjU4i1ItLuYH9jknmGnYd2
         xkFdKVFqF1selrEpFrz6Qet30aUvIjAPOcxdEY9DPYcBGn8EtpS7NYfoewxfam5L/uT5
         1ztUrzV/gAjc5JAOl685aKAf+IYdGA37i21xvRJ3sNTOcZnMzq5HTCoaAaozSU94v+Rw
         Nc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687446749; x=1690038749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjSv15dzC6nuXKYZrJU9b8Q9RmPOIFKd49BervCX4t0=;
        b=ic6hSQ0qEiIi3xBkZYcTky0iojgkbtDsXqcGU3p5Cy+HAObp9/tAogl723dJrqkfR3
         mVKW19UVIC+zLBWoPtzYRDHBnDq2CqtQFFixnw/rl9AzqL3ef3Upb/vk76Ci6MaurbM7
         0w20ZB0fkkN9z/VFMVhn4hAIFNd2RzjGVS27GI5/KhZIo551MlElv/hqmy5jOIETp7uD
         e7ILAUs/Vg5EXL/7xQjXTgc/W8t12lxSNSY2Vfy396TSbS4yzaeMVV8Cid2hQvpCZv6X
         F+LZZ/vGeDhsaw+1wy10TIqTW5qbrSbM9w7irkqGis1fj6EKtWlfyle0vlCt8cFDesxd
         tDKQ==
X-Gm-Message-State: AC+VfDxN8mJ31yUfOn/Lwxgl8oXzkyhB5uKN7LxO8EdBjjCmR4k/MpwF
        g1zLukxXcnKDa0c4QIWBQ4YXa2Nha08Rp1Spb6c=
X-Google-Smtp-Source: ACHHUZ4XO7aD9IvWCyImHt/hGvv5rNdZ3cPcsOO07dQr3qeHDeG8XiOnbk3p/7Ekev6eHWEwPqgjJw==
X-Received: by 2002:a05:6512:2f4:b0:4f8:582e:f4f2 with SMTP id m20-20020a05651202f400b004f8582ef4f2mr11520308lfq.47.1687446749125;
        Thu, 22 Jun 2023 08:12:29 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id p2-20020a19f002000000b004f85885cff1sm1117787lfc.134.2023.06.22.08.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 08:12:28 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 2/2] can: kvaser_pciefd: Add support for new Kvaser pciefd devices
Date:   Thu, 22 Jun 2023 17:11:53 +0200
Message-Id: <20230622151153.294844-3-extja@kvaser.com>
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

Add support for new Kvaser pciefd devices, based on SmartFusion2 SoC.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
 - Rebased on
   can: kvaser_pciefd: Fixes and improvements [1]
 - Replaced some constants with macros

[1] https://lore.kernel.org/all/20230529134248.752036-1-extja@kvaser.com

 drivers/net/can/Kconfig         |  5 +++
 drivers/net/can/kvaser_pciefd.c | 77 ++++++++++++++++++++++++++++++++-
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index a5c5036dfb94..18e4a6e94ba9 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -160,8 +160,13 @@ config CAN_KVASER_PCIEFD
 	    Kvaser PCIEcan 4xHS
 	    Kvaser PCIEcan 2xHS v2
 	    Kvaser PCIEcan HS v2
+	    Kvaser PCIEcan 1xCAN v3
+	    Kvaser PCIEcan 2xCAN v3
+	    Kvaser PCIEcan 4xCAN v2
 	    Kvaser Mini PCI Express HS v2
 	    Kvaser Mini PCI Express 2xHS v2
+	    Kvaser Mini PCI Express 1xCAN v3
+	    Kvaser Mini PCI Express 2xCAN v3
 
 config CAN_SLCAN
 	tristate "Serial / USB serial CAN Adaptors (slcan)"
diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 539f97390761..cd3a9fe29895 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /* Copyright (C) 2018 KVASER AB, Sweden. All rights reserved.
  * Parts of this driver are based on the following:
- *  - Kvaser linux pciefd driver (version 5.25)
+ *  - Kvaser linux pciefd driver (version 5.42)
  *  - PEAK linux canfd driver
  */
 
@@ -40,9 +40,19 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_MINIPCIE_HS_V2_DEVICE_ID 0x0010
 #define KVASER_PCIEFD_MINIPCIE_2HS_V2_DEVICE_ID 0x0011
 
+/* SmartFusion2 based devices */
+#define KVASER_PCIEFD_2CAN_V3_DEVICE_ID 0x0012
+#define KVASER_PCIEFD_1CAN_V3_DEVICE_ID 0x0013
+#define KVASER_PCIEFD_4CAN_V2_DEVICE_ID 0x0014
+#define KVASER_PCIEFD_MINIPCIE_2CAN_V3_DEVICE_ID 0x0015
+#define KVASER_PCIEFD_MINIPCIE_1CAN_V3_DEVICE_ID 0x0016
+
 /* Altera SerDes Enable 64-bit DMA address translation */
 #define KVASER_PCIEFD_ALTERA_DMA_64BIT BIT(0)
 
+/* SmartFusion2 SerDes LSB address translation mask */
+#define KVASER_PCIEFD_SF2_DMA_LSB_MASK GENMASK(31, 12)
+
 /* Kvaser KCAN CAN controller registers */
 #define KVASER_PCIEFD_KCAN_FIFO_REG 0x100
 #define KVASER_PCIEFD_KCAN_FIFO_LAST_REG 0x180
@@ -269,6 +279,8 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 struct kvaser_pciefd;
 static void kvaser_pciefd_write_dma_map_altera(struct kvaser_pciefd *pcie,
 					       dma_addr_t addr, int index);
+static void kvaser_pciefd_write_dma_map_sf2(struct kvaser_pciefd *pcie,
+					    dma_addr_t addr, int index);
 
 struct kvaser_pciefd_address_offset {
 	u32 serdes;
@@ -311,22 +323,50 @@ const struct kvaser_pciefd_address_offset kvaser_pciefd_altera_address_offset =
 	.kcan_ch1 = 0x11000,
 };
 
+const struct kvaser_pciefd_address_offset kvaser_pciefd_sf2_address_offset = {
+	.serdes = 0x280c8,
+	.pci_ien = 0x102004,
+	.pci_irq = 0x102008,
+	.sysid = 0x100000,
+	.loopback = 0x103000,
+	.kcan_srb_fifo = 0x120000,
+	.kcan_srb = 0x121000,
+	.kcan_ch0 = 0x140000,
+	.kcan_ch1 = 0x142000,
+};
+
 const struct kvaser_pciefd_irq_mask kvaser_pciefd_altera_irq_mask = {
 	.kcan_rx0 = BIT(4),
 	.kcan_tx = { BIT(0), BIT(1), BIT(2), BIT(3) },
 	.all = GENMASK(4, 0),
 };
 
+const struct kvaser_pciefd_irq_mask kvaser_pciefd_sf2_irq_mask = {
+	.kcan_rx0 = BIT(4),
+	.kcan_tx = { BIT(16), BIT(17), BIT(18), BIT(19) },
+	.all = GENMASK(19, 16) | BIT(4),
+};
+
 const struct kvaser_pciefd_dev_ops kvaser_pciefd_altera_dev_ops = {
 	.kvaser_pciefd_write_dma_map = kvaser_pciefd_write_dma_map_altera,
 };
 
+const struct kvaser_pciefd_dev_ops kvaser_pciefd_sf2_dev_ops = {
+	.kvaser_pciefd_write_dma_map = kvaser_pciefd_write_dma_map_sf2,
+};
+
 const struct kvaser_pciefd_driver_data kvaser_pciefd_altera_driver_data = {
 	.address_offset = &kvaser_pciefd_altera_address_offset,
 	.irq_mask = &kvaser_pciefd_altera_irq_mask,
 	.ops = &kvaser_pciefd_altera_dev_ops,
 };
 
+const struct kvaser_pciefd_driver_data kvaser_pciefd_sf2_driver_data = {
+	.address_offset = &kvaser_pciefd_sf2_address_offset,
+	.irq_mask = &kvaser_pciefd_sf2_irq_mask,
+	.ops = &kvaser_pciefd_sf2_dev_ops,
+};
+
 struct kvaser_pciefd_can {
 	struct can_priv can;
 	struct kvaser_pciefd *kv_pcie;
@@ -396,6 +436,26 @@ static struct pci_device_id kvaser_pciefd_id_table[] = {
 		PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_MINIPCIE_2HS_V2_DEVICE_ID),
 		.driver_data = (kernel_ulong_t)&kvaser_pciefd_altera_driver_data,
 	},
+	{
+		PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_2CAN_V3_DEVICE_ID),
+		.driver_data = (kernel_ulong_t)&kvaser_pciefd_sf2_driver_data,
+	},
+	{
+		PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_1CAN_V3_DEVICE_ID),
+		.driver_data = (kernel_ulong_t)&kvaser_pciefd_sf2_driver_data,
+	},
+	{
+		PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_4CAN_V2_DEVICE_ID),
+		.driver_data = (kernel_ulong_t)&kvaser_pciefd_sf2_driver_data,
+	},
+	{
+		PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_MINIPCIE_2CAN_V3_DEVICE_ID),
+		.driver_data = (kernel_ulong_t)&kvaser_pciefd_sf2_driver_data,
+	},
+	{
+		PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_MINIPCIE_1CAN_V3_DEVICE_ID),
+		.driver_data = (kernel_ulong_t)&kvaser_pciefd_sf2_driver_data,
+	},
 	{
 		0,
 	},
@@ -960,6 +1020,21 @@ static void kvaser_pciefd_write_dma_map_altera(struct kvaser_pciefd *pcie,
 	iowrite32(word2, serdes_base + 0x4);
 }
 
+static void kvaser_pciefd_write_dma_map_sf2(struct kvaser_pciefd *pcie,
+					    dma_addr_t addr, int index)
+{
+	void __iomem *serdes_base;
+	u32 lsb = addr & KVASER_PCIEFD_SF2_DMA_LSB_MASK;
+	u32 msb = 0x0;
+
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	msb = addr >> 32;
+#endif
+	serdes_base = KVASER_PCIEFD_SERDES_ADDR(pcie) + 0x10 * index;
+	iowrite32(lsb, serdes_base);
+	iowrite32(msb, serdes_base + 0x4);
+}
+
 static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
 {
 	int i;
-- 
2.40.0

