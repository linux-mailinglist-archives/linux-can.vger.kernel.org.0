Return-Path: <linux-can+bounces-4179-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD03B121D9
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 18:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF965548021
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 16:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F0D2EF2AC;
	Fri, 25 Jul 2025 16:21:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C002EE99C
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460479; cv=none; b=brrk9yI6e69Re/hL2cWB9O6tNpPiwv586/A82E2Nmd5eoRrq5EKXmQWoWx6NFYLvzpNhqAi/yEy8v4p5IlEw2zvqVFm0Ft5CcE+pwkm4ssU4620yaCwpv5+WggTLQXA2LT9iH1xWohC0IK1bvZMoa08rx1p2/KvHj2q9niP3Evg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460479; c=relaxed/simple;
	bh=1eIcxyuca51ybeYGnuCcjM8ZGqFmJKz1avJ5XsP0QfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aI8k792/sznM9zw2A7pY9Ns5mDZ6OM+xuqVIVGkm6wtmjQy6G5PGNmna+0mT6kEnKb4gnpcVSq7kBpKjJ2gaVnBp35imWiOV8JrdNLxhNbm4XnhMBh9sfeeg+NOIED35Pn9MDg7g7RK0EPK/QeoqaBHog+T82QyquUTR1Y0TWvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufLAa-0000oO-78
	for linux-can@vger.kernel.org; Fri, 25 Jul 2025 18:21:16 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufLAZ-00AFhF-38
	for linux-can@vger.kernel.org;
	Fri, 25 Jul 2025 18:21:16 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 37F09449880
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:33 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id A164E449820;
	Fri, 25 Jul 2025 16:13:30 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 97ea3b3f;
	Fri, 25 Jul 2025 16:13:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 12/27] can: kvaser_pciefd: Split driver into C-file and header-file.
Date: Fri, 25 Jul 2025 18:05:22 +0200
Message-ID: <20250725161327.4165174-13-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725161327.4165174-1-mkl@pengutronix.de>
References: <20250725161327.4165174-1-mkl@pengutronix.de>
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

Split driver into C-file and header-file, to simplify future patches.
Move common definitions and declarations to a header file.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20250725123230.8-7-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/Makefile                      |  2 +-
 drivers/net/can/kvaser_pciefd/Makefile        |  3 +
 drivers/net/can/kvaser_pciefd/kvaser_pciefd.h | 90 +++++++++++++++++++
 .../kvaser_pciefd_core.c}                     | 72 +--------------
 4 files changed, 96 insertions(+), 71 deletions(-)
 create mode 100644 drivers/net/can/kvaser_pciefd/Makefile
 create mode 100644 drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
 rename drivers/net/can/{kvaser_pciefd.c => kvaser_pciefd/kvaser_pciefd_core.c} (97%)

diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index a71db2cfe990..56138d8ddfd2 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_CAN_FLEXCAN)	+= flexcan/
 obj-$(CONFIG_CAN_GRCAN)		+= grcan.o
 obj-$(CONFIG_CAN_IFI_CANFD)	+= ifi_canfd/
 obj-$(CONFIG_CAN_JANZ_ICAN3)	+= janz-ican3.o
-obj-$(CONFIG_CAN_KVASER_PCIEFD)	+= kvaser_pciefd.o
+obj-$(CONFIG_CAN_KVASER_PCIEFD)	+= kvaser_pciefd/
 obj-$(CONFIG_CAN_MSCAN)		+= mscan/
 obj-$(CONFIG_CAN_M_CAN)		+= m_can/
 obj-$(CONFIG_CAN_PEAK_PCIEFD)	+= peak_canfd/
diff --git a/drivers/net/can/kvaser_pciefd/Makefile b/drivers/net/can/kvaser_pciefd/Makefile
new file mode 100644
index 000000000000..ea1bf1000760
--- /dev/null
+++ b/drivers/net/can/kvaser_pciefd/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CAN_KVASER_PCIEFD) += kvaser_pciefd.o
+kvaser_pciefd-y = kvaser_pciefd_core.o
diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h b/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
new file mode 100644
index 000000000000..55bb7e078340
--- /dev/null
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* kvaser_pciefd common definitions and declarations
+ *
+ * Copyright (C) 2025 KVASER AB, Sweden. All rights reserved.
+ */
+
+#ifndef _KVASER_PCIEFD_H
+#define _KVASER_PCIEFD_H
+
+#include <linux/can/dev.h>
+#include <linux/completion.h>
+#include <linux/pci.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
+#include <linux/types.h>
+
+#define KVASER_PCIEFD_MAX_CAN_CHANNELS 8UL
+#define KVASER_PCIEFD_DMA_COUNT 2U
+#define KVASER_PCIEFD_DMA_SIZE (4U * 1024U)
+#define KVASER_PCIEFD_CAN_TX_MAX_COUNT 17U
+
+struct kvaser_pciefd;
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
+struct kvaser_pciefd_irq_mask {
+	u32 kcan_rx0;
+	u32 kcan_tx[KVASER_PCIEFD_MAX_CAN_CHANNELS];
+	u32 all;
+};
+
+struct kvaser_pciefd_dev_ops {
+	void (*kvaser_pciefd_write_dma_map)(struct kvaser_pciefd *pcie,
+					    dma_addr_t addr, int index);
+};
+
+struct kvaser_pciefd_driver_data {
+	const struct kvaser_pciefd_address_offset *address_offset;
+	const struct kvaser_pciefd_irq_mask *irq_mask;
+	const struct kvaser_pciefd_dev_ops *ops;
+};
+
+struct kvaser_pciefd_fw_version {
+	u8 major;
+	u8 minor;
+	u16 build;
+};
+
+struct kvaser_pciefd_can {
+	struct can_priv can;
+	struct kvaser_pciefd *kv_pcie;
+	void __iomem *reg_base;
+	struct can_berr_counter bec;
+	u32 ioc;
+	u8 cmd_seq;
+	u8 tx_max_count;
+	u8 tx_idx;
+	u8 ack_idx;
+	int err_rep_cnt;
+	unsigned int completed_tx_pkts;
+	unsigned int completed_tx_bytes;
+	spinlock_t lock; /* Locks sensitive registers (e.g. MODE) */
+	struct timer_list bec_poll_timer;
+	struct completion start_comp, flush_comp;
+};
+
+struct kvaser_pciefd {
+	struct pci_dev *pci;
+	void __iomem *reg_base;
+	struct kvaser_pciefd_can *can[KVASER_PCIEFD_MAX_CAN_CHANNELS];
+	const struct kvaser_pciefd_driver_data *driver_data;
+	void *dma_data[KVASER_PCIEFD_DMA_COUNT];
+	u8 nr_channels;
+	u32 bus_freq;
+	u32 freq;
+	u32 freq_to_ticks_div;
+	struct kvaser_pciefd_fw_version fw_version;
+};
+
+#endif /* _KVASER_PCIEFD_H */
diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
similarity index 97%
rename from drivers/net/can/kvaser_pciefd.c
rename to drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
index 8dcb1d1c67e4..97cbe07c4ee3 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
@@ -5,6 +5,8 @@
  *  - PEAK linux canfd driver
  */
 
+#include "kvaser_pciefd.h"
+
 #include <linux/bitfield.h>
 #include <linux/can/dev.h>
 #include <linux/device.h>
@@ -27,10 +29,6 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_WAIT_TIMEOUT msecs_to_jiffies(1000)
 #define KVASER_PCIEFD_BEC_POLL_FREQ (jiffies + msecs_to_jiffies(200))
 #define KVASER_PCIEFD_MAX_ERR_REP 256U
-#define KVASER_PCIEFD_CAN_TX_MAX_COUNT 17U
-#define KVASER_PCIEFD_MAX_CAN_CHANNELS 8UL
-#define KVASER_PCIEFD_DMA_COUNT 2U
-#define KVASER_PCIEFD_DMA_SIZE (4U * 1024U)
 
 #define KVASER_PCIEFD_VENDOR 0x1a07
 
@@ -296,41 +294,6 @@ static void kvaser_pciefd_write_dma_map_sf2(struct kvaser_pciefd *pcie,
 static void kvaser_pciefd_write_dma_map_xilinx(struct kvaser_pciefd *pcie,
 					       dma_addr_t addr, int index);
 
-struct kvaser_pciefd_address_offset {
-	u32 serdes;
-	u32 pci_ien;
-	u32 pci_irq;
-	u32 sysid;
-	u32 loopback;
-	u32 kcan_srb_fifo;
-	u32 kcan_srb;
-	u32 kcan_ch0;
-	u32 kcan_ch1;
-};
-
-struct kvaser_pciefd_dev_ops {
-	void (*kvaser_pciefd_write_dma_map)(struct kvaser_pciefd *pcie,
-					    dma_addr_t addr, int index);
-};
-
-struct kvaser_pciefd_irq_mask {
-	u32 kcan_rx0;
-	u32 kcan_tx[KVASER_PCIEFD_MAX_CAN_CHANNELS];
-	u32 all;
-};
-
-struct kvaser_pciefd_driver_data {
-	const struct kvaser_pciefd_address_offset *address_offset;
-	const struct kvaser_pciefd_irq_mask *irq_mask;
-	const struct kvaser_pciefd_dev_ops *ops;
-};
-
-struct kvaser_pciefd_fw_version {
-	u8 major;
-	u8 minor;
-	u16 build;
-};
-
 static const struct kvaser_pciefd_address_offset kvaser_pciefd_altera_address_offset = {
 	.serdes = 0x1000,
 	.pci_ien = 0x50,
@@ -415,37 +378,6 @@ static const struct kvaser_pciefd_driver_data kvaser_pciefd_xilinx_driver_data =
 	.ops = &kvaser_pciefd_xilinx_dev_ops,
 };
 
-struct kvaser_pciefd_can {
-	struct can_priv can;
-	struct kvaser_pciefd *kv_pcie;
-	void __iomem *reg_base;
-	struct can_berr_counter bec;
-	u32 ioc;
-	u8 cmd_seq;
-	u8 tx_max_count;
-	u8 tx_idx;
-	u8 ack_idx;
-	int err_rep_cnt;
-	unsigned int completed_tx_pkts;
-	unsigned int completed_tx_bytes;
-	spinlock_t lock; /* Locks sensitive registers (e.g. MODE) */
-	struct timer_list bec_poll_timer;
-	struct completion start_comp, flush_comp;
-};
-
-struct kvaser_pciefd {
-	struct pci_dev *pci;
-	void __iomem *reg_base;
-	struct kvaser_pciefd_can *can[KVASER_PCIEFD_MAX_CAN_CHANNELS];
-	const struct kvaser_pciefd_driver_data *driver_data;
-	void *dma_data[KVASER_PCIEFD_DMA_COUNT];
-	u8 nr_channels;
-	u32 bus_freq;
-	u32 freq;
-	u32 freq_to_ticks_div;
-	struct kvaser_pciefd_fw_version fw_version;
-};
-
 struct kvaser_pciefd_rx_packet {
 	u32 header[2];
 	u64 timestamp;
-- 
2.47.2



