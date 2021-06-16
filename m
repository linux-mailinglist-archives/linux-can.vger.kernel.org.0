Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0003A9746
	for <lists+linux-can@lfdr.de>; Wed, 16 Jun 2021 12:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbhFPKae (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Jun 2021 06:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbhFPKa3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Jun 2021 06:30:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D3AC061760
        for <linux-can@vger.kernel.org>; Wed, 16 Jun 2021 03:28:22 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ltSmT-0005Ea-7d
        for linux-can@vger.kernel.org; Wed, 16 Jun 2021 12:28:21 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 515F863D198
        for <linux-can@vger.kernel.org>; Wed, 16 Jun 2021 10:28:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 6BD5663D16F;
        Wed, 16 Jun 2021 10:28:14 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 362d842c;
        Wed, 16 Jun 2021 10:28:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 9/9] can: peak_pci: Add name and FW version of the card in kernel buffer
Date:   Wed, 16 Jun 2021 12:28:11 +0200
Message-Id: <20210616102811.2449426-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616102811.2449426-1-mkl@pengutronix.de>
References: <20210616102811.2449426-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Stephane Grosjean <s.grosjean@peak-system.com>

This patch adds name and (possibly) firmware version information to
the kernel about the detected PEAK-System CAN - PCI/PCIe interface
card.

Link: https://lore.kernel.org/r/20210607151720.13571-1-s.grosjean@peak-system.com
Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
[mkl: reformated struct pci_device_id peak_pci_tbl]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/peak_pci.c | 64 +++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index aff8a1dee135..6db90dc4bc9d 100644
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
@@ -68,19 +72,41 @@ static const u16 peak_pci_icr_masks[PEAK_PCI_CHAN_MAX] = {
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
+	{
+		PEAK_PCI_VENDOR_ID, PEAK_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
+		.driver_data = (kernel_ulong_t)"PCAN-PCI",
+	}, {
+		PEAK_PCI_VENDOR_ID, PEAK_PCIE_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
+		.driver_data = (kernel_ulong_t)"PCAN-PCI Express",
+	}, {
+		PEAK_PCI_VENDOR_ID, PEAK_MPCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
+		.driver_data = (kernel_ulong_t)"PCAN-miniPCI",
+	}, {
+		PEAK_PCI_VENDOR_ID, PEAK_MPCIE_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
+		.driver_data = (kernel_ulong_t)"PCAN-miniPCIe",
+	}, {
+		PEAK_PCI_VENDOR_ID, PEAK_PC_104P_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
+		.driver_data = (kernel_ulong_t)"PCAN-PC/104-Plus Quad",
+	}, {
+		PEAK_PCI_VENDOR_ID, PEAK_PCI_104E_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
+		.driver_data = (kernel_ulong_t)"PCAN-PCI/104-Express",
+	}, {
+		PEAK_PCI_VENDOR_ID, PEAK_CPCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
+		.driver_data = (kernel_ulong_t)"PCAN-cPCI",
+	}, {
+		PEAK_PCI_VENDOR_ID, PEAK_PCIE_OEM_ID, PCI_ANY_ID, PCI_ANY_ID,
+		.driver_data = (kernel_ulong_t)"PCAN-Chip PCIe",
+	},
 #ifdef CONFIG_CAN_PEAK_PCIEC
-	{PEAK_PCI_VENDOR_ID, PEAK_PCIEC_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
-	{PEAK_PCI_VENDOR_ID, PEAK_PCIEC34_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{
+		PEAK_PCI_VENDOR_ID, PEAK_PCIEC_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
+		.driver_data = (kernel_ulong_t)"PCAN-ExpressCard",
+	}, {
+		PEAK_PCI_VENDOR_ID, PEAK_PCIEC34_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
+		.driver_data = (kernel_ulong_t)"PCAN-ExpressCard 34",
+	},
 #endif
-	{0,}
+	{ /* sentinel */ }
 };
 
 MODULE_DEVICE_TABLE(pci, peak_pci_tbl);
@@ -530,6 +556,7 @@ static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	void __iomem *cfg_base, *reg_base;
 	u16 sub_sys_id, icr;
 	int i, err, channels;
+	char fw_str[14] = "";
 
 	err = pci_enable_device(pdev);
 	if (err)
@@ -583,6 +610,21 @@ static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
2.30.2


