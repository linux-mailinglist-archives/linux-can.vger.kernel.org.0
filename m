Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665737BAAFA
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 21:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjJET6i (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 15:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjJET63 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 15:58:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D00EA
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 12:58:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoUUK-0004ps-Pf
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 21:58:24 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoUUG-00BLLL-En
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 21:58:20 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 34E65230049
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 19:58:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 96E2522FFDB;
        Thu,  5 Oct 2023 19:58:17 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ff8ba5d4;
        Thu, 5 Oct 2023 19:58:15 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 30/37] can: at91_can: at91_irq_err_frame(): move next to at91_irq_err()
Date:   Thu,  5 Oct 2023 21:58:05 +0200
Message-Id: <20231005195812.549776-31-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231005195812.549776-1-mkl@pengutronix.de>
References: <20231005195812.549776-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is a cleanup patch, no functional change intended. As
at91_irq_err_frame() is called from the IRQ handler move it in front
of the IRQ handler next to at91_irq_err().

Link: https://lore.kernel.org/all/20231005-at91_can-rx_offload-v2-20-9987d53600e0@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 122 ++++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 61 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index a84da1995816..6b017fd695c0 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -750,67 +750,6 @@ static int at91_poll_rx(struct net_device *dev, int quota)
 	return received;
 }
 
-static void at91_irq_err_frame(struct net_device *dev, const u32 reg_sr)
-{
-	struct net_device_stats *stats = &dev->stats;
-	struct at91_priv *priv = netdev_priv(dev);
-	struct sk_buff *skb;
-	struct can_frame *cf = NULL;
-
-	priv->can.can_stats.bus_error++;
-
-	skb = alloc_can_err_skb(dev, &cf);
-	if (cf)
-		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
-
-	if (reg_sr & AT91_IRQ_CERR) {
-		netdev_dbg(dev, "CRC error\n");
-
-		stats->rx_errors++;
-		if (cf)
-			cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ;
-	}
-
-	if (reg_sr & AT91_IRQ_SERR) {
-		netdev_dbg(dev, "Stuff error\n");
-
-		stats->rx_errors++;
-		if (cf)
-			cf->data[2] |= CAN_ERR_PROT_STUFF;
-	}
-
-	if (reg_sr & AT91_IRQ_AERR) {
-		netdev_dbg(dev, "NACK error\n");
-
-		stats->tx_errors++;
-		if (cf) {
-			cf->can_id |= CAN_ERR_ACK;
-			cf->data[2] |= CAN_ERR_PROT_TX;
-		}
-	}
-
-	if (reg_sr & AT91_IRQ_FERR) {
-		netdev_dbg(dev, "Format error\n");
-
-		stats->rx_errors++;
-		if (cf)
-			cf->data[2] |= CAN_ERR_PROT_FORM;
-	}
-
-	if (reg_sr & AT91_IRQ_BERR) {
-		netdev_dbg(dev, "Bit error\n");
-
-		stats->tx_errors++;
-		if (cf)
-			cf->data[2] |= CAN_ERR_PROT_TX | CAN_ERR_PROT_BIT;
-	}
-
-	if (!cf)
-		return;
-
-	netif_receive_skb(skb);
-}
-
 static int at91_poll(struct napi_struct *napi, int quota)
 {
 	struct net_device *dev = napi->dev;
@@ -1061,6 +1000,67 @@ static void at91_irq_err(struct net_device *dev)
 	priv->can.state = new_state;
 }
 
+static void at91_irq_err_frame(struct net_device *dev, const u32 reg_sr)
+{
+	struct net_device_stats *stats = &dev->stats;
+	struct at91_priv *priv = netdev_priv(dev);
+	struct sk_buff *skb;
+	struct can_frame *cf = NULL;
+
+	priv->can.can_stats.bus_error++;
+
+	skb = alloc_can_err_skb(dev, &cf);
+	if (cf)
+		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+
+	if (reg_sr & AT91_IRQ_CERR) {
+		netdev_dbg(dev, "CRC error\n");
+
+		stats->rx_errors++;
+		if (cf)
+			cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ;
+	}
+
+	if (reg_sr & AT91_IRQ_SERR) {
+		netdev_dbg(dev, "Stuff error\n");
+
+		stats->rx_errors++;
+		if (cf)
+			cf->data[2] |= CAN_ERR_PROT_STUFF;
+	}
+
+	if (reg_sr & AT91_IRQ_AERR) {
+		netdev_dbg(dev, "NACK error\n");
+
+		stats->tx_errors++;
+		if (cf) {
+			cf->can_id |= CAN_ERR_ACK;
+			cf->data[2] |= CAN_ERR_PROT_TX;
+		}
+	}
+
+	if (reg_sr & AT91_IRQ_FERR) {
+		netdev_dbg(dev, "Format error\n");
+
+		stats->rx_errors++;
+		if (cf)
+			cf->data[2] |= CAN_ERR_PROT_FORM;
+	}
+
+	if (reg_sr & AT91_IRQ_BERR) {
+		netdev_dbg(dev, "Bit error\n");
+
+		stats->tx_errors++;
+		if (cf)
+			cf->data[2] |= CAN_ERR_PROT_TX | CAN_ERR_PROT_BIT;
+	}
+
+	if (!cf)
+		return;
+
+	netif_receive_skb(skb);
+}
+
 /* interrupt handler
  */
 static irqreturn_t at91_irq(int irq, void *dev_id)
-- 
2.40.1


