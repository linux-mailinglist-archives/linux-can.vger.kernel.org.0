Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D19B673E21
	for <lists+linux-can@lfdr.de>; Thu, 19 Jan 2023 17:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjASQBf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Jan 2023 11:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjASQBb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2023 11:01:31 -0500
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Jan 2023 08:01:24 PST
Received: from mail3.ems-wuensche.com (mail3.ems-wuensche.com [81.169.186.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDCCB8384F
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 08:01:24 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 080A4FF6F3
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 15:46:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Score: -1.902
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rCYbU140U_mQ for <linux-can@vger.kernel.org>;
        Thu, 19 Jan 2023 16:46:20 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     mkl@pengutronix.de, linux-can@vger.kernel.org
Cc:     wg@grandegger.com,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH 1/8] can: ems_pci: Fixed code style, copyright and email address
Date:   Thu, 19 Jan 2023 16:45:21 +0100
Message-Id: <20230119154528.28425-2-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230119154528.28425-1-uttenthaler@ems-wuensche.com>
References: <20230119154528.28425-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Fix code style complained by checkpatch.pl, added Copyright and 
fixed email address

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/sja1000/ems_pci.c | 43 +++++++++++++------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
index 4ab91759a5c6..8071ff4708dc 100644
--- a/drivers/net/can/sja1000/ems_pci.c
+++ b/drivers/net/can/sja1000/ems_pci.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2007 Wolfgang Grandegger <wg@grandegger.com>
  * Copyright (C) 2008 Markus Plessing <plessing@ems-wuensche.com>
  * Copyright (C) 2008 Sebastian Haas <haas@ems-wuensche.com>
+ * Copyright (C) 2023 EMS Dr. Thomas Wuensche
  */
 
 #include <linux/kernel.h>
@@ -19,7 +20,7 @@
 
 #define DRV_NAME  "ems_pci"
 
-MODULE_AUTHOR("Sebastian Haas <haas@ems-wuenche.com>");
+MODULE_AUTHOR("Sebastian Haas <support@ems-wuenche.com>");
 MODULE_DESCRIPTION("Socket-CAN driver for EMS CPC-PCI/PCIe/104P CAN cards");
 MODULE_LICENSE("GPL v2");
 
@@ -40,8 +41,7 @@ struct ems_pci_card {
 
 #define EMS_PCI_CAN_CLOCK (16000000 / 2)
 
-/*
- * Register definitions and descriptions are from LinCAN 0.3.3.
+/* Register definitions and descriptions are from LinCAN 0.3.3.
  *
  * PSB4610 PITA-2 bridge control registers
  */
@@ -52,8 +52,7 @@ struct ems_pci_card {
 #define PITA2_MISC          0x1c	/* Miscellaneous Register */
 #define PITA2_MISC_CONFIG   0x04000000	/* Multiplexed parallel interface */
 
-/*
- * Register definitions for the PLX 9030
+/* Register definitions for the PLX 9030
  */
 #define PLX_ICSR            0x4c   /* Interrupt Control/Status register */
 #define PLX_ICSR_LINTI1_ENA 0x0001 /* LINTi1 Enable */
@@ -62,8 +61,7 @@ struct ems_pci_card {
 #define PLX_ICSR_ENA_CLR    (PLX_ICSR_LINTI1_ENA | PLX_ICSR_PCIINT_ENA | \
 			     PLX_ICSR_LINTI1_CLR)
 
-/*
- * The board configuration is probably following:
+/* The board configuration is probably following:
  * RX1 is connected to ground.
  * TX1 is not connected.
  * CLKO is not connected.
@@ -72,8 +70,7 @@ struct ems_pci_card {
  */
 #define EMS_PCI_OCR         (OCR_TX0_PUSHPULL | OCR_TX1_PUSHPULL)
 
-/*
- * In the CDR register, you should set CBP to 1.
+/* In the CDR register, you should set CBP to 1.
  * You will probably also want to set the clock divider value to 7
  * (meaning direct oscillator output) because the second SJA1000 chip
  * is driven by the first one CLKOUT output.
@@ -100,8 +97,7 @@ static const struct pci_device_id ems_pci_tbl[] = {
 };
 MODULE_DEVICE_TABLE(pci, ems_pci_tbl);
 
-/*
- * Helper to read internal registers from card logic (not CAN)
+/* Helper to read internal registers from card logic (not CAN)
  */
 static u8 ems_pci_v1_readb(struct ems_pci_card *card, unsigned int port)
 {
@@ -146,8 +142,7 @@ static void ems_pci_v2_post_irq(const struct sja1000_priv *priv)
 	writel(PLX_ICSR_ENA_CLR, card->conf_addr + PLX_ICSR);
 }
 
-/*
- * Check if a CAN controller is present at the specified location
+/* Check if a CAN controller is present at the specified location
  * by trying to set 'em into the PeliCAN mode
  */
 static inline int ems_pci_check_chan(const struct sja1000_priv *priv)
@@ -185,10 +180,10 @@ static void ems_pci_del_card(struct pci_dev *pdev)
 		free_sja1000dev(dev);
 	}
 
-	if (card->base_addr != NULL)
+	if (card->base_addr)
 		pci_iounmap(card->pci_dev, card->base_addr);
 
-	if (card->conf_addr != NULL)
+	if (card->conf_addr)
 		pci_iounmap(card->pci_dev, card->conf_addr);
 
 	kfree(card);
@@ -202,8 +197,7 @@ static void ems_pci_card_reset(struct ems_pci_card *card)
 	writeb(0, card->base_addr);
 }
 
-/*
- * Probe PCI device for EMS CAN signature and register each available
+/* Probe PCI device for EMS CAN signature and register each available
  * CAN channel to SJA1000 Socket-CAN subsystem.
  */
 static int ems_pci_add_card(struct pci_dev *pdev,
@@ -222,8 +216,8 @@ static int ems_pci_add_card(struct pci_dev *pdev,
 	}
 
 	/* Allocating card structures to hold addresses, ... */
-	card = kzalloc(sizeof(struct ems_pci_card), GFP_KERNEL);
-	if (card == NULL) {
+	card = kzalloc(sizeof(*card), GFP_KERNEL);
+	if (!card) {
 		pci_disable_device(pdev);
 		return -ENOMEM;
 	}
@@ -248,13 +242,13 @@ static int ems_pci_add_card(struct pci_dev *pdev,
 
 	/* Remap configuration space and controller memory area */
 	card->conf_addr = pci_iomap(pdev, 0, conf_size);
-	if (card->conf_addr == NULL) {
+	if (!card->conf_addr) {
 		err = -ENOMEM;
 		goto failure_cleanup;
 	}
 
 	card->base_addr = pci_iomap(pdev, base_bar, EMS_PCI_BASE_SIZE);
-	if (card->base_addr == NULL) {
+	if (!card->base_addr) {
 		err = -ENOMEM;
 		goto failure_cleanup;
 	}
@@ -281,7 +275,7 @@ static int ems_pci_add_card(struct pci_dev *pdev,
 	/* Detect available channels */
 	for (i = 0; i < max_chan; i++) {
 		dev = alloc_sja1000dev(0);
-		if (dev == NULL) {
+		if (!dev) {
 			err = -ENOMEM;
 			goto failure_cleanup;
 		}
@@ -325,8 +319,7 @@ static int ems_pci_add_card(struct pci_dev *pdev,
 			/* Register SJA1000 device */
 			err = register_sja1000dev(dev);
 			if (err) {
-				dev_err(&pdev->dev, "Registering device failed "
-							"(err=%d)\n", err);
+				dev_err(&pdev->dev, "Registering device failed (err=%d)\n", err);
 				free_sja1000dev(dev);
 				goto failure_cleanup;
 			}
@@ -334,7 +327,7 @@ static int ems_pci_add_card(struct pci_dev *pdev,
 			card->channels++;
 
 			dev_info(&pdev->dev, "Channel #%d at 0x%p, irq %d\n",
-					i + 1, priv->reg_base, dev->irq);
+				 i + 1, priv->reg_base, dev->irq);
 		} else {
 			free_sja1000dev(dev);
 		}
-- 
2.35.3

--
EMS Dr. Thomas Wuensche e.K.
Sonnenhang 3
85304 Ilmmuenster
HR Ingolstadt, HRA 170106

Phone: +49-8441-490260
Fax  : +49-8441-81860
http://www.ems-wuensche.com
