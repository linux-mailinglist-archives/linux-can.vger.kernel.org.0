Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DCC673E3C
	for <lists+linux-can@lfdr.de>; Thu, 19 Jan 2023 17:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjASQIE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Jan 2023 11:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjASQHs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2023 11:07:48 -0500
Received: from mail3.ems-wuensche.com (mail3.ems-wuensche.com [81.169.186.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE2FF8A0ED
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 08:06:55 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id D5635FF9D6
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 15:46:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Score: -1.902
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZVNPSlslJFfP for <linux-can@vger.kernel.org>;
        Thu, 19 Jan 2023 16:46:34 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     mkl@pengutronix.de, linux-can@vger.kernel.org
Cc:     wg@grandegger.com,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH 7/8] can: ems_pci: Deassert hardware reset
Date:   Thu, 19 Jan 2023 16:45:27 +0100
Message-Id: <20230119154528.28425-8-uttenthaler@ems-wuensche.com>
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

The reset line from the Asix chip to the SJA1000 is asserted after boot up
until it is deasserted by a register write

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/sja1000/ems_pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
index dddbf290c98e..68fdead6ad74 100644
--- a/drivers/net/can/sja1000/ems_pci.c
+++ b/drivers/net/can/sja1000/ems_pci.c
@@ -327,6 +327,13 @@ static int ems_pci_add_card(struct pci_dev *pdev,
 		}
 	}
 
+	if (card->version == 3) {
+		/* ASIX chip asserts local reset to CAN controllers
+		 * after bootup until it is deasserted
+		 */
+		writel(readl(card->conf_addr + ASIX_LIEMR) & ~ASIX_LIEMR_LRST, card->conf_addr + ASIX_LIEMR);
+	}
+
 	ems_pci_card_reset(card);
 
 	/* Detect available channels */
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
