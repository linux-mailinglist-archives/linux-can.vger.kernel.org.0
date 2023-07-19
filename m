Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291E4758EDF
	for <lists+linux-can@lfdr.de>; Wed, 19 Jul 2023 09:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjGSHYh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 19 Jul 2023 03:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGSHYf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 19 Jul 2023 03:24:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B31BE47
        for <linux-can@vger.kernel.org>; Wed, 19 Jul 2023 00:24:34 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qM1Y0-0002uc-VZ
        for linux-can@vger.kernel.org; Wed, 19 Jul 2023 09:24:33 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id EA05F1F4C96
        for <linux-can@vger.kernel.org>; Wed, 19 Jul 2023 07:23:53 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id EA9D71F4C22;
        Wed, 19 Jul 2023 07:23:50 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 737d800c;
        Wed, 19 Jul 2023 07:23:50 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Jimmy Assarsson <extja@kvaser.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 7/8] can: kvaser_pciefd: Add support for new Kvaser pciefd devices
Date:   Wed, 19 Jul 2023 09:23:47 +0200
Message-Id: <20230719072348.525039-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719072348.525039-1-mkl@pengutronix.de>
References: <20230719072348.525039-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Add support for new Kvaser pciefd devices, based on SmartFusion2 SoC.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://lore.kernel.org/all/20230622151153.294844-3-extja@kvaser.com
[mkl: mark structs as static]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
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
index 3d478e6fb73b..a57005faa04f 100644
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
@@ -311,22 +323,50 @@ static const struct kvaser_pciefd_address_offset kvaser_pciefd_altera_address_of
 	.kcan_ch1 = 0x11000,
 };
 
+static const struct kvaser_pciefd_address_offset kvaser_pciefd_sf2_address_offset = {
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
 static const struct kvaser_pciefd_irq_mask kvaser_pciefd_altera_irq_mask = {
 	.kcan_rx0 = BIT(4),
 	.kcan_tx = { BIT(0), BIT(1), BIT(2), BIT(3) },
 	.all = GENMASK(4, 0),
 };
 
+static const struct kvaser_pciefd_irq_mask kvaser_pciefd_sf2_irq_mask = {
+	.kcan_rx0 = BIT(4),
+	.kcan_tx = { BIT(16), BIT(17), BIT(18), BIT(19) },
+	.all = GENMASK(19, 16) | BIT(4),
+};
+
 static const struct kvaser_pciefd_dev_ops kvaser_pciefd_altera_dev_ops = {
 	.kvaser_pciefd_write_dma_map = kvaser_pciefd_write_dma_map_altera,
 };
 
+static const struct kvaser_pciefd_dev_ops kvaser_pciefd_sf2_dev_ops = {
+	.kvaser_pciefd_write_dma_map = kvaser_pciefd_write_dma_map_sf2,
+};
+
 static const struct kvaser_pciefd_driver_data kvaser_pciefd_altera_driver_data = {
 	.address_offset = &kvaser_pciefd_altera_address_offset,
 	.irq_mask = &kvaser_pciefd_altera_irq_mask,
 	.ops = &kvaser_pciefd_altera_dev_ops,
 };
 
+static const struct kvaser_pciefd_driver_data kvaser_pciefd_sf2_driver_data = {
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
2.40.1


