Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC573A9744
	for <lists+linux-can@lfdr.de>; Wed, 16 Jun 2021 12:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhFPKad (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Jun 2021 06:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbhFPKa2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Jun 2021 06:30:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB83C061768
        for <linux-can@vger.kernel.org>; Wed, 16 Jun 2021 03:28:22 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ltSmS-0005D2-TL
        for linux-can@vger.kernel.org; Wed, 16 Jun 2021 12:28:20 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 3A9E363D18B
        for <linux-can@vger.kernel.org>; Wed, 16 Jun 2021 10:28:17 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 20ADE63D16C;
        Wed, 16 Jun 2021 10:28:14 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7c5fc89e;
        Wed, 16 Jun 2021 10:28:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [can-next-rfc 8/9] can: peak_pci: fix checkpatch warnings
Date:   Wed, 16 Jun 2021 12:28:10 +0200
Message-Id: <20210616102811.2449426-9-mkl@pengutronix.de>
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

This patch cleans several checkpatch warnings in the peak_pci driver.

Cc: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/peak_pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index 5fec26c6df42..aff8a1dee135 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -152,12 +152,14 @@ static void peak_pci_write_reg(const struct sja1000_priv *priv,
 static inline void pita_set_scl_highz(struct peak_pciec_card *card)
 {
 	u8 gp_outen = readb(card->cfg_base + PITA_GPOEN) & ~PITA_GPIN_SCL;
+
 	writeb(gp_outen, card->cfg_base + PITA_GPOEN);
 }
 
 static inline void pita_set_sda_highz(struct peak_pciec_card *card)
 {
 	u8 gp_outen = readb(card->cfg_base + PITA_GPOEN) & ~PITA_GPIN_SDA;
+
 	writeb(gp_outen, card->cfg_base + PITA_GPOEN);
 }
 
@@ -242,7 +244,7 @@ static int peak_pciec_write_pca9553(struct peak_pciec_card *card,
 	int ret;
 
 	/* cache led mask */
-	if ((offset == 5) && (data == card->led_cache))
+	if (offset == 5 && data == card->led_cache)
 		return 0;
 
 	ret = i2c_transfer(&card->led_chip, &msg, 1);
@@ -424,7 +426,7 @@ static int peak_pciec_probe(struct pci_dev *pdev, struct net_device *dev)
 	/* channel is the first one: do the init part */
 	} else {
 		/* create the bit banging I2C adapter structure */
-		card = kzalloc(sizeof(struct peak_pciec_card), GFP_KERNEL);
+		card = kzalloc(sizeof(*card), GFP_KERNEL);
 		if (!card)
 			return -ENOMEM;
 
-- 
2.30.2


