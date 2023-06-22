Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38357739992
	for <lists+linux-can@lfdr.de>; Thu, 22 Jun 2023 10:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjFVI1j (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jun 2023 04:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjFVI1c (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Jun 2023 04:27:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB02E1FC0
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 01:27:11 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qCFen-0002Yy-Hw
        for linux-can@vger.kernel.org; Thu, 22 Jun 2023 10:27:09 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 935BD1DF3B4
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 08:27:04 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 54F1A1DF359;
        Thu, 22 Jun 2023 08:27:02 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 23f5cced;
        Thu, 22 Jun 2023 08:27:00 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Miquel Raynal <miquel.raynal@bootlin.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 11/33] can: sja1000: Prepare the use of a threaded handler
Date:   Thu, 22 Jun 2023 10:26:36 +0200
Message-Id: <20230622082658.571150-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622082658.571150-1-mkl@pengutronix.de>
References: <20230622082658.571150-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

In order to support a flavor of the sja1000 which sometimes freezes, it
will be needed upon certain interrupts to perform a soft reset. The soft
reset operation takes a bit of time, so better not do it within the hard
interrupt handler but rather in a threaded handler. Let's prepare the
possibility for sja1000_err() to request "interrupting" the current flow
and request the threaded handler to be run while keeping the interrupt
line low.

There is no functional change.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/all/20230616134553.2786391-1-miquel.raynal@bootlin.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/sja1000.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index aac5956e4a53..4719806e3a9f 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -501,7 +501,8 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 	struct sja1000_priv *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
 	uint8_t isrc, status;
-	int n = 0;
+	irqreturn_t ret = 0;
+	int n = 0, err;
 
 	if (priv->pre_irq)
 		priv->pre_irq(priv);
@@ -546,19 +547,23 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 		}
 		if (isrc & (IRQ_DOI | IRQ_EI | IRQ_BEI | IRQ_EPI | IRQ_ALI)) {
 			/* error interrupt */
-			if (sja1000_err(dev, isrc, status))
+			err = sja1000_err(dev, isrc, status);
+			if (err)
 				break;
 		}
 		n++;
 	}
 out:
+	if (!ret)
+		ret = (n) ? IRQ_HANDLED : IRQ_NONE;
+
 	if (priv->post_irq)
 		priv->post_irq(priv);
 
 	if (n >= SJA1000_MAX_IRQ)
 		netdev_dbg(dev, "%d messages handled in ISR", n);
 
-	return (n) ? IRQ_HANDLED : IRQ_NONE;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(sja1000_interrupt);
 
-- 
2.40.1


