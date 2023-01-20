Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B42675364
	for <lists+linux-can@lfdr.de>; Fri, 20 Jan 2023 12:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjATL1O (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 Jan 2023 06:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjATL1N (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Jan 2023 06:27:13 -0500
Received: from mail3.ems-wuensche.com (mail3.ems-wuensche.com [81.169.186.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC75E45F58
        for <linux-can@vger.kernel.org>; Fri, 20 Jan 2023 03:27:12 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 32F48FF6E1
        for <linux-can@vger.kernel.org>; Fri, 20 Jan 2023 11:27:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Score: -1.902
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Eiqu7-_uMvDw for <linux-can@vger.kernel.org>;
        Fri, 20 Jan 2023 12:27:10 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org, mkl@pengutronix.de
Cc:     vincent.mailhol@gmail.com, wg@grandegger.com,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH v2 6/8] can: ems_pci: Add IRQ enable
Date:   Fri, 20 Jan 2023 12:26:14 +0100
Message-Id: <20230120112616.6071-7-uttenthaler@ems-wuensche.com>
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

Add IRQ enable

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/sja1000/ems_pci.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
index 1d7314ea42f3..73f3ca9ebe02 100644
--- a/drivers/net/can/sja1000/ems_pci.c
+++ b/drivers/net/can/sja1000/ems_pci.c
@@ -372,14 +372,21 @@ static int ems_pci_add_card(struct pci_dev *pdev,
 			SET_NETDEV_DEV(dev, &pdev->dev);
 			dev->dev_id = i;
 
-			if (card->version == 1)
+			if (card->version == 1) {
 				/* reset int flag of pita */
 				writel(PITA2_ICR_INT0_EN | PITA2_ICR_INT0,
 				       card->conf_addr + PITA2_ICR);
-			else
+			} else if (card->version == 2) {
 				/* enable IRQ in PLX 9030 */
 				writel(PLX_ICSR_ENA_CLR,
 				       card->conf_addr + PLX_ICSR);
+			} else {
+				/* Enable IRQ in AX99100 */
+				writel(ASIX_LINTSR_INT0AC, card->conf_addr + ASIX_LINTSR);
+				/* Enable local INT0 input enable */
+				writel(readl(card->conf_addr + ASIX_LIEMR) | ASIX_LIEMR_L0EINTEN,
+				       card->conf_addr + ASIX_LIEMR);
+			}
 
 			/* Register SJA1000 device */
 			err = register_sja1000dev(dev);
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
