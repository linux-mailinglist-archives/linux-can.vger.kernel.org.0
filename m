Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD0A738510
	for <lists+linux-can@lfdr.de>; Wed, 21 Jun 2023 15:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjFUN3g (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Jun 2023 09:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjFUN3e (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Jun 2023 09:29:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCA119BB
        for <linux-can@vger.kernel.org>; Wed, 21 Jun 2023 06:29:28 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qBxtm-0006di-4q
        for linux-can@vger.kernel.org; Wed, 21 Jun 2023 15:29:26 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 558E11DE8EB
        for <linux-can@vger.kernel.org>; Wed, 21 Jun 2023 13:29:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 0E1021DE883;
        Wed, 21 Jun 2023 13:29:18 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id bff4fb4b;
        Wed, 21 Jun 2023 13:29:16 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= 
        <jeremie.dautheribes@bootlin.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 13/33] can: sja1000: Prevent overrun stalls with a soft reset on Renesas SoCs
Date:   Wed, 21 Jun 2023 15:28:54 +0200
Message-Id: <20230621132914.412546-14-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621132914.412546-1-mkl@pengutronix.de>
References: <20230621132914.412546-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In their RZN1 SoC, Renesas put a CAN controller supposed to act very
similarly to the original Philips sja1000. In practice, while flooding
the bus with another device, we discovered that the controller very
often after an overrun situation would just refuse any new frame, drop
them all and trigger over and over again the overrun interrupt, even
though the buffer would have been totally emptied. The controller acts
like if its internal buffer offsets (where it writes and where the host
reads) where totally screwed-up.

Renesas manual mentions a single action to perform in order to
resynchronize the read and write offsets within the buffer: performing
a soft reset.

Performing a soft reset takes a bit of time and involves small delays,
so better do that in a threaded handler rather than inside the hard IRQ
handler.

Add platform data to recognize the platforms which need this workaround,
and when the faulty situation is diagnosed, stop what is being
performed and request the threaded handler to be executed in order to
perform the reset.

Tested-by: Jérémie Dautheribes  <jeremie.dautheribes@bootlin.com> # 5.10
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/all/20230616134553.2786391-2-miquel.raynal@bootlin.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/sja1000.c          | 29 +++++++++++++++++++---
 drivers/net/can/sja1000/sja1000.h          |  1 +
 drivers/net/can/sja1000/sja1000_platform.c |  5 +++-
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 4719806e3a9f..0ada0e160e93 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -387,6 +387,16 @@ static void sja1000_rx(struct net_device *dev)
 	netif_rx(skb);
 }
 
+static irqreturn_t sja1000_reset_interrupt(int irq, void *dev_id)
+{
+	struct net_device *dev = (struct net_device *)dev_id;
+
+	netdev_dbg(dev, "performing a soft reset upon overrun\n");
+	sja1000_start(dev);
+
+	return IRQ_HANDLED;
+}
+
 static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 {
 	struct sja1000_priv *priv = netdev_priv(dev);
@@ -397,6 +407,7 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	enum can_state rx_state, tx_state;
 	unsigned int rxerr, txerr;
 	uint8_t ecc, alc;
+	int ret = 0;
 
 	skb = alloc_can_err_skb(dev, &cf);
 	if (skb == NULL)
@@ -413,6 +424,15 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 		stats->rx_over_errors++;
 		stats->rx_errors++;
 		sja1000_write_cmdreg(priv, CMD_CDO);	/* clear bit */
+
+		/* Some controllers needs additional handling upon overrun
+		 * condition: the controller may sometimes be totally confused
+		 * and refuse any new frame while its buffer is empty. The only
+		 * way to re-sync the read vs. write buffer offsets is to
+		 * stop any current handling and perform a reset.
+		 */
+		if (priv->flags & SJA1000_QUIRK_RESET_ON_OVERRUN)
+			ret = IRQ_WAKE_THREAD;
 	}
 
 	if (isrc & IRQ_EI) {
@@ -492,7 +512,7 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 
 	netif_rx(skb);
 
-	return 0;
+	return ret;
 }
 
 irqreturn_t sja1000_interrupt(int irq, void *dev_id)
@@ -548,6 +568,8 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 		if (isrc & (IRQ_DOI | IRQ_EI | IRQ_BEI | IRQ_EPI | IRQ_ALI)) {
 			/* error interrupt */
 			err = sja1000_err(dev, isrc, status);
+			if (err == IRQ_WAKE_THREAD)
+				ret = err;
 			if (err)
 				break;
 		}
@@ -582,8 +604,9 @@ static int sja1000_open(struct net_device *dev)
 
 	/* register interrupt handler, if not done by the device driver */
 	if (!(priv->flags & SJA1000_CUSTOM_IRQ_HANDLER)) {
-		err = request_irq(dev->irq, sja1000_interrupt, priv->irq_flags,
-				  dev->name, (void *)dev);
+		err = request_threaded_irq(dev->irq, sja1000_interrupt,
+					   sja1000_reset_interrupt,
+					   priv->irq_flags, dev->name, (void *)dev);
 		if (err) {
 			close_candev(dev);
 			return -EAGAIN;
diff --git a/drivers/net/can/sja1000/sja1000.h b/drivers/net/can/sja1000/sja1000.h
index 7f736f1df547..f015e39e2224 100644
--- a/drivers/net/can/sja1000/sja1000.h
+++ b/drivers/net/can/sja1000/sja1000.h
@@ -147,6 +147,7 @@
  */
 #define SJA1000_CUSTOM_IRQ_HANDLER	BIT(0)
 #define SJA1000_QUIRK_NO_CDR_REG	BIT(1)
+#define SJA1000_QUIRK_RESET_ON_OVERRUN	BIT(2)
 
 /*
  * SJA1000 private data structure
diff --git a/drivers/net/can/sja1000/sja1000_platform.c b/drivers/net/can/sja1000/sja1000_platform.c
index b4889b5746e5..4e59952c66d4 100644
--- a/drivers/net/can/sja1000/sja1000_platform.c
+++ b/drivers/net/can/sja1000/sja1000_platform.c
@@ -106,7 +106,7 @@ static void sp_technologic_init(struct sja1000_priv *priv, struct device_node *o
 
 static void sp_rzn1_init(struct sja1000_priv *priv, struct device_node *of)
 {
-	priv->flags = SJA1000_QUIRK_NO_CDR_REG;
+	priv->flags = SJA1000_QUIRK_NO_CDR_REG | SJA1000_QUIRK_RESET_ON_OVERRUN;
 }
 
 static void sp_populate(struct sja1000_priv *priv,
@@ -277,6 +277,9 @@ static int sp_probe(struct platform_device *pdev)
 		priv->irq_flags = IRQF_SHARED;
 	}
 
+	if (priv->flags & SJA1000_QUIRK_RESET_ON_OVERRUN)
+		priv->irq_flags |= IRQF_ONESHOT;
+
 	dev->irq = irq;
 	priv->reg_base = addr;
 
-- 
2.40.1


