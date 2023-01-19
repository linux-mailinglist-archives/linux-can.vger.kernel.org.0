Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527BE673E3B
	for <lists+linux-can@lfdr.de>; Thu, 19 Jan 2023 17:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjASQID (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Jan 2023 11:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjASQHs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2023 11:07:48 -0500
Received: from mail3.ems-wuensche.com (mail3.ems-wuensche.com [81.169.186.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECB2F8A0F6
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 08:06:55 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id D477FFF9E8
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 15:46:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Score: -1.902
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 17do_SW-1BGi for <linux-can@vger.kernel.org>;
        Thu, 19 Jan 2023 16:46:24 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     mkl@pengutronix.de, linux-can@vger.kernel.org
Cc:     wg@grandegger.com,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH 3/8] can: ems_pci: Initialize BAR registers
Date:   Thu, 19 Jan 2023 16:45:23 +0100
Message-Id: <20230119154528.28425-4-uttenthaler@ems-wuensche.com>
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

Fix the base register defines and their usage for all three card versions

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/sja1000/ems_pci.c | 37 +++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
index 216ebc14f243..be61d39149c4 100644
--- a/drivers/net/can/sja1000/ems_pci.c
+++ b/drivers/net/can/sja1000/ems_pci.c
@@ -87,12 +87,23 @@ struct ems_pci_card {
  */
 #define EMS_PCI_CDR             (CDR_CBP | CDR_CLKOUT_MASK)
 
-#define EMS_PCI_V1_BASE_BAR     1
-#define EMS_PCI_V1_CONF_SIZE    4096 /* size of PITA control area */
-#define EMS_PCI_V2_BASE_BAR     2
-#define EMS_PCI_V2_CONF_SIZE    128 /* size of PLX control area */
-#define EMS_PCI_CAN_BASE_OFFSET 0x400 /* offset where the controllers starts */
-#define EMS_PCI_CAN_CTRL_SIZE   0x200 /* memory size for each controller */
+#define EMS_PCI_V1_BASE_BAR 1
+#define EMS_PCI_V1_CONF_BAR 0
+#define EMS_PCI_V1_CONF_SIZE 4096 /* size of PITA control area */
+#define EMS_PCI_V1_CAN_BASE_OFFSET 0x400 /* offset where the controllers start */
+#define EMS_PCI_V1_CAN_CTRL_SIZE 0x200 /* memory size for each controller */
+
+#define EMS_PCI_V2_BASE_BAR 2
+#define EMS_PCI_V2_CONF_BAR 0
+#define EMS_PCI_V2_CONF_SIZE 128 /* size of PLX control area */
+#define EMS_PCI_V2_CAN_BASE_OFFSET 0x400 /* offset where the controllers start */
+#define EMS_PCI_V2_CAN_CTRL_SIZE 0x200 /* memory size for each controller */
+
+#define EMS_PCI_V3_BASE_BAR 0
+#define EMS_PCI_V3_CONF_BAR 5
+#define EMS_PCI_V3_CONF_SIZE 128 /* size of ASIX control area */
+#define EMS_PCI_V3_CAN_BASE_OFFSET 0x00 /* offset where the controllers starts */
+#define EMS_PCI_V3_CAN_CTRL_SIZE 0x100 /* memory size for each controller */
 
 #define EMS_PCI_BASE_SIZE  4096 /* size of controller area */
 
@@ -225,7 +236,7 @@ static int ems_pci_add_card(struct pci_dev *pdev,
 	struct sja1000_priv *priv;
 	struct net_device *dev;
 	struct ems_pci_card *card;
-	int max_chan, conf_size, base_bar;
+	int max_chan, conf_size, base_bar, conf_bar;
 	int err, i;
 
 	/* Enabling PCI device */
@@ -247,20 +258,28 @@ static int ems_pci_add_card(struct pci_dev *pdev,
 
 	card->channels = 0;
 
-	if (pdev->vendor == PCI_VENDOR_ID_PLX) {
+	if (pdev->vendor == PCI_VENDOR_ID_ASIX) {
+		card->version = 3; /* CPC-PCI v3 */
+		max_chan = EMS_PCI_V3_MAX_CHAN;
+		base_bar = EMS_PCI_V3_BASE_BAR;
+		conf_bar = EMS_PCI_V3_CONF_BAR;
+		conf_size = EMS_PCI_V3_CONF_SIZE;
+	} else if (pdev->vendor == PCI_VENDOR_ID_PLX) {
 		card->version = 2; /* CPC-PCI v2 */
 		max_chan = EMS_PCI_V2_MAX_CHAN;
 		base_bar = EMS_PCI_V2_BASE_BAR;
+		conf_bar = EMS_PCI_V2_CONF_BAR;
 		conf_size = EMS_PCI_V2_CONF_SIZE;
 	} else {
 		card->version = 1; /* CPC-PCI v1 */
 		max_chan = EMS_PCI_V1_MAX_CHAN;
 		base_bar = EMS_PCI_V1_BASE_BAR;
+		conf_bar = EMS_PCI_V1_CONF_BAR;
 		conf_size = EMS_PCI_V1_CONF_SIZE;
 	}
 
 	/* Remap configuration space and controller memory area */
-	card->conf_addr = pci_iomap(pdev, 0, conf_size);
+	card->conf_addr = pci_iomap(pdev, conf_bar, conf_size);
 	if (!card->conf_addr) {
 		err = -ENOMEM;
 		goto failure_cleanup;
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
