Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E914A673E1F
	for <lists+linux-can@lfdr.de>; Thu, 19 Jan 2023 17:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjASQBc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Jan 2023 11:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjASQBa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2023 11:01:30 -0500
Received: from mail3.ems-wuensche.com (mail3.ems-wuensche.com [81.169.186.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EAE098386F
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 08:01:24 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id A28D1FF539
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 15:46:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Score: -1.902
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id W52VsoHmwp9l for <linux-can@vger.kernel.org>;
        Thu, 19 Jan 2023 16:46:22 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     mkl@pengutronix.de, linux-can@vger.kernel.org
Cc:     wg@grandegger.com,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH 2/8] can: ems_pci: Added Asix AX99100 definitions
Date:   Thu, 19 Jan 2023 16:45:22 +0100
Message-Id: <20230119154528.28425-3-uttenthaler@ems-wuensche.com>
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

Added Asix AX99100 PCI IDs and added the v3 to the ems_pci_tbl. 
Add define for maximum CAN channel count

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/sja1000/ems_pci.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
index 8071ff4708dc..216ebc14f243 100644
--- a/drivers/net/can/sja1000/ems_pci.c
+++ b/drivers/net/can/sja1000/ems_pci.c
@@ -26,6 +26,7 @@ MODULE_LICENSE("GPL v2");
 
 #define EMS_PCI_V1_MAX_CHAN 2
 #define EMS_PCI_V2_MAX_CHAN 4
+#define EMS_PCI_V3_MAX_CHAN 4
 #define EMS_PCI_MAX_CHAN    EMS_PCI_V2_MAX_CHAN
 
 struct ems_pci_card {
@@ -61,6 +62,15 @@ struct ems_pci_card {
 #define PLX_ICSR_ENA_CLR    (PLX_ICSR_LINTI1_ENA | PLX_ICSR_PCIINT_ENA | \
 			     PLX_ICSR_LINTI1_CLR)
 
+/* Register definitions for the ASIX99100
+ */
+#define ASIX_LINTSR 0x28 /* Interrupt Control/Status register */
+#define ASIX_LINTSR_INT0AC BIT(0) /* Writing 1 enables or clears interrupt */
+
+#define ASIX_LIEMR 0x24 /* Local Interrupt Enable / Miscellaneous Register */
+#define ASIX_LIEMR_L0EINTEN BIT(16) /* Local INT0 input assertion enable */
+#define ASIX_LIEMR_LRST BIT(14) /* Local Reset assert */
+
 /* The board configuration is probably following:
  * RX1 is connected to ground.
  * TX1 is not connected.
@@ -86,6 +96,13 @@ struct ems_pci_card {
 
 #define EMS_PCI_BASE_SIZE  4096 /* size of controller area */
 
+#ifndef PCI_VENDOR_ID_ASIX
+#define PCI_VENDOR_ID_ASIX 0x125b
+#define PCI_DEVICE_ID_ASIX_9110 0x9110
+#define PCI_SUBVENDOR_ID_ASIX 0xa000
+#endif
+#define PCI_SUBDEVICE_ID_EMS 0x4010
+
 static const struct pci_device_id ems_pci_tbl[] = {
 	/* CPC-PCI v1 */
 	{PCI_VENDOR_ID_SIEMENS, 0x2104, PCI_ANY_ID, PCI_ANY_ID,},
@@ -93,6 +110,8 @@ static const struct pci_device_id ems_pci_tbl[] = {
 	{PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030, PCI_VENDOR_ID_PLX, 0x4000},
 	/* CPC-104P v2 */
 	{PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030, PCI_VENDOR_ID_PLX, 0x4002},
+	/* CPC-PCIe v3 */
+	{PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_9110, PCI_SUBVENDOR_ID_ASIX, PCI_SUBDEVICE_ID_EMS},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, ems_pci_tbl);
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
