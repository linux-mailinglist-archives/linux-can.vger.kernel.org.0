Return-Path: <linux-can+bounces-264-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D69852F97
	for <lists+linux-can@lfdr.de>; Tue, 13 Feb 2024 12:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02D3280E5F
	for <lists+linux-can@lfdr.de>; Tue, 13 Feb 2024 11:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9CA3A8E4;
	Tue, 13 Feb 2024 11:34:55 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDFF38DEC
	for <linux-can@vger.kernel.org>; Tue, 13 Feb 2024 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824095; cv=none; b=MgGTkBFORYjIIOcAAIw6ULSem/KYdin4Nm7L3jpzMs03h8O5+5PUxec44Kl6oqvkUkaK4wXMjtF91rPSztxy2LPjKOh9r3rghPj1V6fGxdtJ4QOyWyQnhgnjdUUIEJu+n0nbtTln4tWfodjx4NxC9c/fPI2HhHnsy7kgnF45CWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824095; c=relaxed/simple;
	bh=PgKEsmf28QqUee3tKcRim3f/PqAfhToO6QYdC4wpF8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rV6bAxQtaPEkMUC3XCeYCsYe2kGv9exgvBJuGogGLX0WqJC7NLoNdJgPyV2Ub8u/ArqDLnO1L+UHxjydkfyRpqKptJ5n87R43UWZS6s5ZUI1kPugEnge7tEmQgc0L4T3C99nfYj+E4Hi8+7wJxYAMbjE1We4eVt5slT0bPlaY6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZr3p-0001BM-86
	for linux-can@vger.kernel.org; Tue, 13 Feb 2024 12:34:49 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZr3k-000TXM-FH
	for linux-can@vger.kernel.org; Tue, 13 Feb 2024 12:34:44 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 2726828D6D8
	for <linux-can@vger.kernel.org>; Tue, 13 Feb 2024 11:34:44 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id A3A1228D677;
	Tue, 13 Feb 2024 11:34:41 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 774cb0b5;
	Tue, 13 Feb 2024 11:34:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 20/23] can: kvaser_pciefd: Add support for Kvaser M.2 PCIe 4xCAN
Date: Tue, 13 Feb 2024 12:25:23 +0100
Message-ID: <20240213113437.1884372-21-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213113437.1884372-1-mkl@pengutronix.de>
References: <20240213113437.1884372-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Add support for new Kvaser pciefd device, M.2 PCIe 4xCAN, based on
Xilinx FPGA.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://lore.kernel.org/all/20231113134717.515037-1-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/Kconfig         |  1 +
 drivers/net/can/kvaser_pciefd.c | 55 +++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 2da126f13641..620766eb6bc1 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -168,6 +168,7 @@ config CAN_KVASER_PCIEFD
 	    Kvaser Mini PCI Express 2xHS v2
 	    Kvaser Mini PCI Express 1xCAN v3
 	    Kvaser Mini PCI Express 2xCAN v3
+	    Kvaser M.2 PCIe 4xCAN
 
 config CAN_SLCAN
 	tristate "Serial / USB serial CAN Adaptors (slcan)"
diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index a57005faa04f..416f10480b40 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -47,12 +47,18 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_MINIPCIE_2CAN_V3_DEVICE_ID 0x0015
 #define KVASER_PCIEFD_MINIPCIE_1CAN_V3_DEVICE_ID 0x0016
 
+/* Xilinx based devices */
+#define KVASER_PCIEFD_M2_4CAN_DEVICE_ID 0x0017
+
 /* Altera SerDes Enable 64-bit DMA address translation */
 #define KVASER_PCIEFD_ALTERA_DMA_64BIT BIT(0)
 
 /* SmartFusion2 SerDes LSB address translation mask */
 #define KVASER_PCIEFD_SF2_DMA_LSB_MASK GENMASK(31, 12)
 
+/* Xilinx SerDes LSB address translation mask */
+#define KVASER_PCIEFD_XILINX_DMA_LSB_MASK GENMASK(31, 12)
+
 /* Kvaser KCAN CAN controller registers */
 #define KVASER_PCIEFD_KCAN_FIFO_REG 0x100
 #define KVASER_PCIEFD_KCAN_FIFO_LAST_REG 0x180
@@ -281,6 +287,8 @@ static void kvaser_pciefd_write_dma_map_altera(struct kvaser_pciefd *pcie,
 					       dma_addr_t addr, int index);
 static void kvaser_pciefd_write_dma_map_sf2(struct kvaser_pciefd *pcie,
 					    dma_addr_t addr, int index);
+static void kvaser_pciefd_write_dma_map_xilinx(struct kvaser_pciefd *pcie,
+					       dma_addr_t addr, int index);
 
 struct kvaser_pciefd_address_offset {
 	u32 serdes;
@@ -335,6 +343,18 @@ static const struct kvaser_pciefd_address_offset kvaser_pciefd_sf2_address_offse
 	.kcan_ch1 = 0x142000,
 };
 
+static const struct kvaser_pciefd_address_offset kvaser_pciefd_xilinx_address_offset = {
+	.serdes = 0x00208,
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
@@ -347,6 +367,12 @@ static const struct kvaser_pciefd_irq_mask kvaser_pciefd_sf2_irq_mask = {
 	.all = GENMASK(19, 16) | BIT(4),
 };
 
+static const struct kvaser_pciefd_irq_mask kvaser_pciefd_xilinx_irq_mask = {
+	.kcan_rx0 = BIT(4),
+	.kcan_tx = { BIT(16), BIT(17), BIT(18), BIT(19) },
+	.all = GENMASK(19, 16) | BIT(4),
+};
+
 static const struct kvaser_pciefd_dev_ops kvaser_pciefd_altera_dev_ops = {
 	.kvaser_pciefd_write_dma_map = kvaser_pciefd_write_dma_map_altera,
 };
@@ -355,6 +381,10 @@ static const struct kvaser_pciefd_dev_ops kvaser_pciefd_sf2_dev_ops = {
 	.kvaser_pciefd_write_dma_map = kvaser_pciefd_write_dma_map_sf2,
 };
 
+static const struct kvaser_pciefd_dev_ops kvaser_pciefd_xilinx_dev_ops = {
+	.kvaser_pciefd_write_dma_map = kvaser_pciefd_write_dma_map_xilinx,
+};
+
 static const struct kvaser_pciefd_driver_data kvaser_pciefd_altera_driver_data = {
 	.address_offset = &kvaser_pciefd_altera_address_offset,
 	.irq_mask = &kvaser_pciefd_altera_irq_mask,
@@ -367,6 +397,12 @@ static const struct kvaser_pciefd_driver_data kvaser_pciefd_sf2_driver_data = {
 	.ops = &kvaser_pciefd_sf2_dev_ops,
 };
 
+static const struct kvaser_pciefd_driver_data kvaser_pciefd_xilinx_driver_data = {
+	.address_offset = &kvaser_pciefd_xilinx_address_offset,
+	.irq_mask = &kvaser_pciefd_xilinx_irq_mask,
+	.ops = &kvaser_pciefd_xilinx_dev_ops,
+};
+
 struct kvaser_pciefd_can {
 	struct can_priv can;
 	struct kvaser_pciefd *kv_pcie;
@@ -456,6 +492,10 @@ static struct pci_device_id kvaser_pciefd_id_table[] = {
 		PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_MINIPCIE_1CAN_V3_DEVICE_ID),
 		.driver_data = (kernel_ulong_t)&kvaser_pciefd_sf2_driver_data,
 	},
+	{
+		PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_M2_4CAN_DEVICE_ID),
+		.driver_data = (kernel_ulong_t)&kvaser_pciefd_xilinx_driver_data,
+	},
 	{
 		0,
 	},
@@ -1035,6 +1075,21 @@ static void kvaser_pciefd_write_dma_map_sf2(struct kvaser_pciefd *pcie,
 	iowrite32(msb, serdes_base + 0x4);
 }
 
+static void kvaser_pciefd_write_dma_map_xilinx(struct kvaser_pciefd *pcie,
+					       dma_addr_t addr, int index)
+{
+	void __iomem *serdes_base;
+	u32 lsb = addr & KVASER_PCIEFD_XILINX_DMA_LSB_MASK;
+	u32 msb = 0x0;
+
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	msb = addr >> 32;
+#endif
+	serdes_base = KVASER_PCIEFD_SERDES_ADDR(pcie) + 0x8 * index;
+	iowrite32(msb, serdes_base);
+	iowrite32(lsb, serdes_base + 0x4);
+}
+
 static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
 {
 	int i;
-- 
2.43.0



