Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F755675363
	for <lists+linux-can@lfdr.de>; Fri, 20 Jan 2023 12:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjATL1L (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 Jan 2023 06:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjATL1L (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Jan 2023 06:27:11 -0500
Received: from mail3.ems-wuensche.com (mail3.ems-wuensche.com [81.169.186.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CF7A45F75
        for <linux-can@vger.kernel.org>; Fri, 20 Jan 2023 03:27:10 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id B9414FF6E1
        for <linux-can@vger.kernel.org>; Fri, 20 Jan 2023 11:27:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Score: -1.902
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tmTU4ti7hDpg for <linux-can@vger.kernel.org>;
        Fri, 20 Jan 2023 12:27:08 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org, mkl@pengutronix.de
Cc:     vincent.mailhol@gmail.com, wg@grandegger.com,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH v2 5/8] can: ems_pci: Initialize CAN controller base addresses
Date:   Fri, 20 Jan 2023 12:26:13 +0100
Message-Id: <20230120112616.6071-6-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230120112616.6071-1-uttenthaler@ems-wuensche.com>
References: <20230120112616.6071-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add CAN controller base registers

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/sja1000/ems_pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
index e9d2406d2338..1d7314ea42f3 100644
--- a/drivers/net/can/sja1000/ems_pci.c
+++ b/drivers/net/can/sja1000/ems_pci.c
@@ -342,20 +342,25 @@ static int ems_pci_add_card(struct pci_dev *pdev,
 		priv->irq_flags = IRQF_SHARED;
 
 		dev->irq = pdev->irq;
-		priv->reg_base = card->base_addr + EMS_PCI_CAN_BASE_OFFSET
-					+ (i * EMS_PCI_CAN_CTRL_SIZE);
+
 		if (card->version == 1) {
 			priv->read_reg  = ems_pci_v1_read_reg;
 			priv->write_reg = ems_pci_v1_write_reg;
 			priv->post_irq  = ems_pci_v1_post_irq;
+			priv->reg_base = card->base_addr + EMS_PCI_V1_CAN_BASE_OFFSET
+					+ (i * EMS_PCI_V1_CAN_CTRL_SIZE);
 		} else if (card->version == 2) {
 			priv->read_reg  = ems_pci_v2_read_reg;
 			priv->write_reg = ems_pci_v2_write_reg;
 			priv->post_irq  = ems_pci_v2_post_irq;
+			priv->reg_base = card->base_addr + EMS_PCI_V2_CAN_BASE_OFFSET
+					+ (i * EMS_PCI_V2_CAN_CTRL_SIZE);
 		} else {
 			priv->read_reg  = ems_pci_v3_read_reg;
 			priv->write_reg = ems_pci_v3_write_reg;
 			priv->post_irq  = ems_pci_v3_post_irq;
+			priv->reg_base = card->base_addr + EMS_PCI_V3_CAN_BASE_OFFSET
+					+ (i * EMS_PCI_V3_CAN_CTRL_SIZE);
 		}
 
 		/* Check if channel is present */
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
