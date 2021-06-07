Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF9739DFE9
	for <lists+linux-can@lfdr.de>; Mon,  7 Jun 2021 17:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFGPEu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 7 Jun 2021 11:04:50 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:12128 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230198AbhFGPEu (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 7 Jun 2021 11:04:50 -0400
Received: from localhost.localdomain (unknown [89.158.142.148])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 502B15FFAD;
        Mon,  7 Jun 2021 17:02:54 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH] can/peak_pci: Add name and FW version of the card in kernel buffer
Date:   Mon,  7 Jun 2021 17:02:27 +0200
Message-Id: <20210607150227.407184-1-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch adds name and (possibly) firmware version information to the
kernel about the detected PEAK-System CAN - PCI/PCIe interface card.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/sja1000/peak_pci.c | 50 ++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index 84eac8cb8686..00743f024657 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -28,6 +28,10 @@ MODULE_LICENSE("GPL v2");
 
 #define DRV_NAME  "peak_pci"
 
+/* FPGA cards FW version registers */
+#define PEAK_VER_REG1		0x40
+#define PEAK_VER_REG2		0x44
+
 struct peak_pciec_card;
 struct peak_pci_chan {
 	void __iomem *cfg_base;		/* Common for all channels */
@@ -70,17 +74,27 @@ static const u16 peak_pci_icr_masks[PEAK_PCI_CHAN_MAX] = {
 };
 
 static const struct pci_device_id peak_pci_tbl[] = {
-	{PEAK_PCI_VENDOR_ID, PEAK_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
-	{PEAK_PCI_VENDOR_ID, PEAK_PCIE_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
-	{PEAK_PCI_VENDOR_ID, PEAK_MPCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
-	{PEAK_PCI_VENDOR_ID, PEAK_MPCIE_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
-	{PEAK_PCI_VENDOR_ID, PEAK_PC_104P_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
-	{PEAK_PCI_VENDOR_ID, PEAK_PCI_104E_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
-	{PEAK_PCI_VENDOR_ID, PEAK_CPCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
-	{PEAK_PCI_VENDOR_ID, PEAK_PCIE_OEM_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{PEAK_PCI_VENDOR_ID, PEAK_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
+	.driver_data = (kernel_ulong_t)"PCAN-PCI",},
+	{PEAK_PCI_VENDOR_ID, PEAK_PCIE_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
+	.driver_data = (kernel_ulong_t)"PCAN-PCI Express",},
+	{PEAK_PCI_VENDOR_ID, PEAK_MPCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
+	.driver_data = (kernel_ulong_t)"PCAN-miniPCI",},
+	{PEAK_PCI_VENDOR_ID, PEAK_MPCIE_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
+	.driver_data = (kernel_ulong_t)"PCAN-miniPCIe",},
+	{PEAK_PCI_VENDOR_ID, PEAK_PC_104P_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
+	.driver_data = (kernel_ulong_t)"PCAN-PC/104-Plus Quad",},
+	{PEAK_PCI_VENDOR_ID, PEAK_PCI_104E_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
+	.driver_data = (kernel_ulong_t)"PCAN-PCI/104-Express",},
+	{PEAK_PCI_VENDOR_ID, PEAK_CPCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
+	.driver_data = (kernel_ulong_t)"PCAN-cPCI",},
+	{PEAK_PCI_VENDOR_ID, PEAK_PCIE_OEM_ID, PCI_ANY_ID, PCI_ANY_ID,
+	.driver_data = (kernel_ulong_t)"PCAN-Chip PCIe",},
 #ifdef CONFIG_CAN_PEAK_PCIEC
-	{PEAK_PCI_VENDOR_ID, PEAK_PCIEC_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
-	{PEAK_PCI_VENDOR_ID, PEAK_PCIEC34_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{PEAK_PCI_VENDOR_ID, PEAK_PCIEC_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
+	.driver_data = (kernel_ulong_t)"PCAN-ExpressCard",},
+	{PEAK_PCI_VENDOR_ID, PEAK_PCIEC34_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
+	.driver_data = (kernel_ulong_t)"PCAN-ExpressCard 34",},
 #endif
 	{0,}
 };
@@ -549,6 +563,7 @@ static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	void __iomem *cfg_base, *reg_base;
 	u16 sub_sys_id, icr;
 	int i, err, channels;
+	char fw_str[14] = "";
 
 	err = pci_enable_device(pdev);
 	if (err)
@@ -602,6 +617,21 @@ static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Leave parport mux mode */
 	writeb(0x04, cfg_base + PITA_MISC + 3);
 
+	/* FPGA equipped card if not 0 */
+	if (readl(cfg_base + PEAK_VER_REG1)) {
+		/* FPGA card: display version of the running firmware */
+		u32 fw_ver = readl(cfg_base + PEAK_VER_REG2);
+
+		snprintf(fw_str, sizeof(fw_str), " FW v%u.%u.%u",
+			 (fw_ver >> 12) & 0xf,
+			 (fw_ver >> 8) & 0xf,
+			 (fw_ver >> 4) & 0xf);
+	}
+
+	/* Display commercial name (and, eventually, FW version) of the card */
+	dev_info(&pdev->dev, "%ux CAN %s%s\n",
+		 channels, (const char *)ent->driver_data, fw_str);
+
 	icr = readw(cfg_base + PITA_ICR + 2);
 
 	for (i = 0; i < channels; i++) {
-- 
2.25.1

