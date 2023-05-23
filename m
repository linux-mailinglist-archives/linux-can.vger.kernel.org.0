Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4843570D968
	for <lists+linux-can@lfdr.de>; Tue, 23 May 2023 11:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbjEWJpa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 May 2023 05:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbjEWJpY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 May 2023 05:45:24 -0400
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74572E41
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:17 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4f4bdcde899so567789e87.0
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684835056; x=1687427056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Uama42itDTjKLyc1QrAQgjn9zQiSBgj4fY9gbQ//tk=;
        b=YHg6Cc5E1ZtwFkKyThVBpg5BSCctchQtwmmAjp1HEkulsV1mF4Vk7+CedZY3qsrIAh
         cvIUzPaHzrUwd8/3VOsqt3JV6X4prhXTkycNg9lmMieOCBdrpe+j45iyGuJZ4gH1hpY2
         anxEDaZVuqIW2PDbbksXimkTMzWZzSugT/u+Fr+4UdOVC3Y3SvfXa+UDp/dxNqY6izgb
         LLZ2EqRpzFCeQelB9QqIg5JM746AsNBoYTxg0Mux4sy899qdDRj987IqwiG1W9+HV9E/
         a3/O1B0VeTgH3YhaHTel8ifyqqUUH59EpvMGsJYutO8dzA8tEzAWc5ecgnzqLvH+siCO
         T36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835056; x=1687427056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Uama42itDTjKLyc1QrAQgjn9zQiSBgj4fY9gbQ//tk=;
        b=BvCTWBZEBpwICP3URmGBTU9GC9YLkhfHGb60bERs7cyRHPOi3fUv+cO+Ng1lL395KR
         8MGNkp2bDEYd1DoGRixsIi+QTQXGwq0mrqKI1+uUCUtLr+fD9oMMN5IVPlBCCX9FPrSh
         fNnhVVpOQ7zaTf9ywejtLD3T7nHbfF/u+C0gjUfwI0kB+y2avThqs3Iky0xRMj3lffcB
         46yFZvkwbitHVdTW83wcg0GBuxJeaZQ9zxT7RoVbDhwartWXaCN1URGI1XvymLZwzJ9e
         TgwIFfocu1gVUfoMUd7WHWT1cz+JQc4M/VFTjk9jh7HugEhmg9uMCuMOtgi0vTchjYjy
         biaA==
X-Gm-Message-State: AC+VfDxLBL6lTVCur+l7bOXkmDuDMVq4J7ka78aHWajrat+bFRRp48gG
        w4DT98a2D4TcOJ4P24ByR6gW9WqwxzCO+cIlh5M=
X-Google-Smtp-Source: ACHHUZ45irRYnHL9xuaKjN1+LYsgQGDqh2ag8w02JjqG89ahFCXhHw6AZECdoT/DQZVujKSbXER2+w==
X-Received: by 2002:a05:6512:962:b0:4f1:43ad:7fac with SMTP id v2-20020a056512096200b004f143ad7facmr3971097lft.17.1684835055821;
        Tue, 23 May 2023 02:44:15 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id c16-20020a2e9490000000b002ac87c15fd4sm1535551ljh.95.2023.05.23.02.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:44:15 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 2/3] can: kvaser_pciefd: Add support for new Kvaser pciefd devices
Date:   Tue, 23 May 2023 11:43:53 +0200
Message-Id: <20230523094354.83792-16-extja@kvaser.com>
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

Add support for new Kvaser pciefd devices, based on SmartFusion2 SoC.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/Kconfig         |  5 +++
 drivers/net/can/kvaser_pciefd.c | 74 ++++++++++++++++++++++++++++++++-
 2 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index b929a9da7920..502dcfe4d16a 100644
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
index 992af04c627c..ffe13a1a882a 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /* Copyright (C) 2018 KVASER AB, Sweden. All rights reserved.
  * Parts of this driver are based on the following:
- *  - Kvaser linux pciefd driver (version 5.25)
+ *  - Kvaser linux pciefd driver (version 5.41)
  *  - PEAK linux canfd driver
  */
 
@@ -40,6 +40,13 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_MINIPCIE_HS_V2_DEVICE_ID 0x0010
 #define KVASER_PCIEFD_MINIPCIE_2HS_V2_DEVICE_ID 0x0011
 
+/* SmartFusion2 based devices */
+#define KVASER_PCIEFD_2CAN_V3_DEVICE_ID 0x0012
+#define KVASER_PCIEFD_1CAN_V3_DEVICE_ID 0x0013
+#define KVASER_PCIEFD_4CAN_V2_DEVICE_ID 0x0014
+#define KVASER_PCIEFD_MINIPCIE_2CAN_V3_DEVICE_ID 0x0015
+#define KVASER_PCIEFD_MINIPCIE_1CAN_V3_DEVICE_ID 0x0016
+
 /* Kvaser KCAN CAN controller registers */
 #define KVASER_PCIEFD_KCAN_FIFO_REG 0x100
 #define KVASER_PCIEFD_KCAN_FIFO_LAST_REG 0x180
@@ -232,6 +239,8 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 struct kvaser_pciefd;
 static void kvaser_pciefd_write_dma_map_altera(struct kvaser_pciefd *pcie,
 					       dma_addr_t addr, int index);
+static void kvaser_pciefd_write_dma_map_sf2(struct kvaser_pciefd *pcie,
+					    dma_addr_t addr, int index);
 
 struct kvaser_pciefd_address_offset {
 	u32 serdes;
@@ -274,22 +283,50 @@ const struct kvaser_pciefd_address_offset kvaser_pciefd_altera_address_offset =
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
 	.all = 0x0000001f,
 };
 
+const struct kvaser_pciefd_irq_mask kvaser_pciefd_sf2_irq_mask = {
+	.kcan_rx0 = BIT(4),
+	.kcan_tx = { BIT(16), BIT(17), BIT(18), BIT(19) },
+	.all = 0x000f0010,
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
@@ -359,6 +396,26 @@ static struct pci_device_id kvaser_pciefd_id_table[] = {
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
@@ -928,6 +985,21 @@ static void kvaser_pciefd_write_dma_map_altera(struct kvaser_pciefd *pcie,
 	iowrite32(word2, serdes_base + 0x4);
 }
 
+static void kvaser_pciefd_write_dma_map_sf2(struct kvaser_pciefd *pcie,
+					    dma_addr_t addr, int index)
+{
+	void __iomem *serdes_base;
+	u32 lsb = addr & 0xfffff000;
+	u32 msb = 0x0;
+
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	msb = addr >> 32;
+#endif
+	serdes_base = KVASER_PCIEFD_GET_BLOCK_ADDR(pcie, serdes) + 0x10 * index;
+	iowrite32(lsb, serdes_base);
+	iowrite32(msb, serdes_base + 0x4);
+}
+
 static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
 {
 	void __iomem *kcan_srb_base;
-- 
2.40.0

