Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BDA675362
	for <lists+linux-can@lfdr.de>; Fri, 20 Jan 2023 12:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjATL1K (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 Jan 2023 06:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjATL1J (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Jan 2023 06:27:09 -0500
Received: from mail3.ems-wuensche.com (mail3.ems-wuensche.com [81.169.186.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A86344F848
        for <linux-can@vger.kernel.org>; Fri, 20 Jan 2023 03:27:08 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id ED23AFF6E1
        for <linux-can@vger.kernel.org>; Fri, 20 Jan 2023 11:27:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Score: -1.902
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mHSj56EEf4e5 for <linux-can@vger.kernel.org>;
        Fri, 20 Jan 2023 12:27:07 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org, mkl@pengutronix.de
Cc:     vincent.mailhol@gmail.com, wg@grandegger.com,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH v2 4/8] can: ems_pci: Add read/write register and post irq functions
Date:   Fri, 20 Jan 2023 12:26:12 +0100
Message-Id: <20230120112616.6071-5-uttenthaler@ems-wuensche.com>
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

Add functions to read and write SJA1000 registers and also the
post irq routine

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/sja1000/ems_pci.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
index 429183a87001..e9d2406d2338 100644
--- a/drivers/net/can/sja1000/ems_pci.c
+++ b/drivers/net/can/sja1000/ems_pci.c
@@ -172,6 +172,24 @@ static void ems_pci_v2_post_irq(const struct sja1000_priv *priv)
 	writel(PLX_ICSR_ENA_CLR, card->conf_addr + PLX_ICSR);
 }
 
+static u8 ems_pci_v3_read_reg(const struct sja1000_priv *priv, int port)
+{
+	return readb(priv->reg_base + port);
+}
+
+static void ems_pci_v3_write_reg(const struct sja1000_priv *priv,
+				 int port, u8 val)
+{
+	writeb(val, priv->reg_base + port);
+}
+
+static void ems_pci_v3_post_irq(const struct sja1000_priv *priv)
+{
+	struct ems_pci_card *card = (struct ems_pci_card *)priv->priv;
+
+	writel(ASIX_LINTSR_INT0AC, card->conf_addr + ASIX_LINTSR);
+}
+
 /* Check if a CAN controller is present at the specified location
  * by trying to set 'em into the PeliCAN mode
  */
@@ -330,10 +348,14 @@ static int ems_pci_add_card(struct pci_dev *pdev,
 			priv->read_reg  = ems_pci_v1_read_reg;
 			priv->write_reg = ems_pci_v1_write_reg;
 			priv->post_irq  = ems_pci_v1_post_irq;
-		} else {
+		} else if (card->version == 2) {
 			priv->read_reg  = ems_pci_v2_read_reg;
 			priv->write_reg = ems_pci_v2_write_reg;
 			priv->post_irq  = ems_pci_v2_post_irq;
+		} else {
+			priv->read_reg  = ems_pci_v3_read_reg;
+			priv->write_reg = ems_pci_v3_write_reg;
+			priv->post_irq  = ems_pci_v3_post_irq;
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
