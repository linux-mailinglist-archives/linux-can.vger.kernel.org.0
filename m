Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1CF673E3E
	for <lists+linux-can@lfdr.de>; Thu, 19 Jan 2023 17:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjASQIH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Jan 2023 11:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjASQHz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2023 11:07:55 -0500
Received: from mail3.ems-wuensche.com (mail3.ems-wuensche.com [81.169.186.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 604658B334
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 08:06:56 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id E5F24FF9E7
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 15:46:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Score: -1.902
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oRFrPFa2DXUw for <linux-can@vger.kernel.org>;
        Thu, 19 Jan 2023 16:46:36 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     mkl@pengutronix.de, linux-can@vger.kernel.org
Cc:     wg@grandegger.com,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH 8/8] can: ems_pci: Added MODULE_AUTHOR
Date:   Thu, 19 Jan 2023 16:45:28 +0100
Message-Id: <20230119154528.28425-9-uttenthaler@ems-wuensche.com>
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

Added myself ass module author and fix three code style issues

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/sja1000/ems_pci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
index 68fdead6ad74..5c2f4afba2d0 100644
--- a/drivers/net/can/sja1000/ems_pci.c
+++ b/drivers/net/can/sja1000/ems_pci.c
@@ -21,6 +21,7 @@
 #define DRV_NAME  "ems_pci"
 
 MODULE_AUTHOR("Sebastian Haas <support@ems-wuenche.com>");
+MODULE_AUTHOR("Gerhard Uttenthaler <uttenthaler@ems-wuenche.com>");
 MODULE_DESCRIPTION("Socket-CAN driver for EMS CPC-PCI/PCIe/104P CAN cards");
 MODULE_LICENSE("GPL v2");
 
@@ -283,7 +284,6 @@ static int ems_pci_add_card(struct pci_dev *pdev,
 		conf_bar = EMS_PCI_V3_CONF_BAR;
 		conf_size = EMS_PCI_V3_CONF_SIZE;
 	} else if (pdev->vendor == PCI_VENDOR_ID_PLX) {
-
 		card->version = 2; /* CPC-PCI v2 */
 		max_chan = EMS_PCI_V2_MAX_CHAN;
 		base_bar = EMS_PCI_V2_BASE_BAR;
@@ -331,7 +331,8 @@ static int ems_pci_add_card(struct pci_dev *pdev,
 		/* ASIX chip asserts local reset to CAN controllers
 		 * after bootup until it is deasserted
 		 */
-		writel(readl(card->conf_addr + ASIX_LIEMR) & ~ASIX_LIEMR_LRST, card->conf_addr + ASIX_LIEMR);
+		writel(readl(card->conf_addr + ASIX_LIEMR) & ~ASIX_LIEMR_LRST,
+		       card->conf_addr + ASIX_LIEMR);
 	}
 
 	ems_pci_card_reset(card);
@@ -392,7 +393,8 @@ static int ems_pci_add_card(struct pci_dev *pdev,
 				/* Enable IRQ in AX99100 */
 				writel(ASIX_LINTSR_INT0AC, card->conf_addr + ASIX_LINTSR);
 				/* Enable local INT0 input enable */
-				writel(readl(card->conf_addr + ASIX_LIEMR) | ASIX_LIEMR_L0EINTEN, card->conf_addr + ASIX_LIEMR);
+				writel(readl(card->conf_addr + ASIX_LIEMR) | ASIX_LIEMR_L0EINTEN,
+				       card->conf_addr + ASIX_LIEMR);
 			}
 
 			/* Register SJA1000 device */
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
