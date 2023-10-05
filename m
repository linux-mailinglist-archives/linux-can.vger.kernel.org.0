Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10737B9FA0
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 16:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbjJEOZ2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 10:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjJEOXr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 10:23:47 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98FA7EE8
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 00:50:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7j-0001L9-55
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:19 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7g-00BDO2-MD
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:16 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 62D4722F7EE
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 07:50:16 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id B138B22F7D8;
        Thu,  5 Oct 2023 07:50:15 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 4e3b47c2;
        Thu, 5 Oct 2023 07:50:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Thu, 05 Oct 2023 09:49:52 +0200
Subject: [PATCH v2 24/27] can: at91_can: at91_irq_err_line(): make use of
 can_change_state() and can_bus_off()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-at91_can-rx_offload-v2-24-9987d53600e0@pengutronix.de>
References: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
In-Reply-To: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=5744; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=UIAPbrlv9lZ+hkzFKRzVFt/TJWudKYryvGHX/i0f3O8=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHmqv9GOghgXyAwJrlCwYSCpktdh2EfRSDXyhw
 fwlM/TdkiiJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR5qrwAKCRC+UBxKKooE
 6GlFB/0acmO1EFALPAOVWbtvBFoVy45zdiThXO7GUOsTZWIAkH03RAtpOrIIhhuBeQJe+KMxdRV
 8FA+2UJetA5v65uOZJXdc4RXgrri7FxLRN24jna3qaw0SVcblxEz8OYeww55AfUaBPXoyIwEk8a
 yPjgp6y4fJtguiDIbZDJU2LPRQMXVC085PmtO2ZsHBxMq66DdHfz8qlg6sqrpbaDCn8cm52XPmd
 YDBtnSgX5NImIkiK5LCZDjm3PhXuE0Wu6WmPiHjhzG6LcC5XWVU12LGmOjB2AFqy2XkEs/q1wsk
 DOqkbZ3e/41ynjU1dMCeCpmy9XPVbryj6zODkK56fyeWt/Td
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
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

The driver implements a hand crafted CAN state handling. Update the
driver to make use of can_change_state(), introduced in ("can: dev:
Consolidate and unify state change handling")

Also switch from hand crafted CAN bus off handling to can_bus_off():
In case of a bus off, abort all pending TX requests, switch off the
device and let can_bus_off() handle the device restart.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 131 ++++++++-------------------------------------
 1 file changed, 21 insertions(+), 110 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index fbe58a1a1989..a413589109b2 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -443,7 +443,7 @@ static void at91_chip_start(struct net_device *dev)
 	at91_read(priv, AT91_SR);
 
 	/* Enable interrupts */
-	reg_ier = get_irq_mb_rx(priv) | AT91_IRQ_ERRP | AT91_IRQ_ERR_FRAME;
+	reg_ier = get_irq_mb_rx(priv) | AT91_IRQ_ERR_LINE | AT91_IRQ_ERR_FRAME;
 	at91_write(priv, AT91_IER, reg_ier);
 }
 
@@ -452,6 +452,11 @@ static void at91_chip_stop(struct net_device *dev, enum can_state state)
 	struct at91_priv *priv = netdev_priv(dev);
 	u32 reg_mr;
 
+	/* Abort any pending TX requests. However this doesn't seem to
+	 * work in case of bus-off on sama5d3.
+	 */
+	at91_write(priv, AT91_ACR, get_irq_mb_tx(priv));
+
 	/* disable interrupts */
 	at91_write(priv, AT91_IDR, AT91_IRQ_ALL);
 
@@ -832,111 +837,6 @@ static void at91_irq_tx(struct net_device *dev, u32 reg_sr)
 		netif_wake_queue(dev);
 }
 
-static void at91_irq_err_state(struct net_device *dev,
-			       struct can_frame *cf, enum can_state new_state)
-{
-	struct at91_priv *priv = netdev_priv(dev);
-	u32 reg_idr = 0, reg_ier = 0;
-	struct can_berr_counter bec;
-
-	at91_get_berr_counter(dev, &bec);
-
-	switch (priv->can.state) {
-	case CAN_STATE_ERROR_ACTIVE:
-		/* from: ERROR_ACTIVE
-		 * to  : ERROR_WARNING, ERROR_PASSIVE, BUS_OFF
-		 * =>  : there was a warning int
-		 */
-		if (new_state >= CAN_STATE_ERROR_WARNING &&
-		    new_state <= CAN_STATE_BUS_OFF) {
-			netdev_dbg(dev, "Error Warning IRQ\n");
-			priv->can.can_stats.error_warning++;
-
-			cf->can_id |= CAN_ERR_CRTL;
-			cf->data[1] = (bec.txerr > bec.rxerr) ?
-				CAN_ERR_CRTL_TX_WARNING :
-				CAN_ERR_CRTL_RX_WARNING;
-		}
-		fallthrough;
-	case CAN_STATE_ERROR_WARNING:
-		/* from: ERROR_ACTIVE, ERROR_WARNING
-		 * to  : ERROR_PASSIVE, BUS_OFF
-		 * =>  : error passive int
-		 */
-		if (new_state >= CAN_STATE_ERROR_PASSIVE &&
-		    new_state <= CAN_STATE_BUS_OFF) {
-			netdev_dbg(dev, "Error Passive IRQ\n");
-			priv->can.can_stats.error_passive++;
-
-			cf->can_id |= CAN_ERR_CRTL;
-			cf->data[1] = (bec.txerr > bec.rxerr) ?
-				CAN_ERR_CRTL_TX_PASSIVE :
-				CAN_ERR_CRTL_RX_PASSIVE;
-		}
-		break;
-	case CAN_STATE_BUS_OFF:
-		/* from: BUS_OFF
-		 * to  : ERROR_ACTIVE, ERROR_WARNING, ERROR_PASSIVE
-		 */
-		if (new_state <= CAN_STATE_ERROR_PASSIVE) {
-			cf->can_id |= CAN_ERR_RESTARTED;
-
-			netdev_dbg(dev, "restarted\n");
-			priv->can.can_stats.restarts++;
-
-			netif_carrier_on(dev);
-			netif_wake_queue(dev);
-		}
-		break;
-	default:
-		break;
-	}
-
-	/* process state changes depending on the new state */
-	switch (new_state) {
-	case CAN_STATE_ERROR_ACTIVE:
-		/* actually we want to enable AT91_IRQ_WARN here, but
-		 * it screws up the system under certain
-		 * circumstances. so just enable AT91_IRQ_ERRP, thus
-		 * the "fallthrough"
-		 */
-		netdev_dbg(dev, "Error Active\n");
-		cf->can_id |= CAN_ERR_PROT;
-		cf->data[2] = CAN_ERR_PROT_ACTIVE;
-		fallthrough;
-	case CAN_STATE_ERROR_WARNING:
-		reg_idr = AT91_IRQ_ERRA | AT91_IRQ_WARN | AT91_IRQ_BOFF;
-		reg_ier = AT91_IRQ_ERRP;
-		break;
-	case CAN_STATE_ERROR_PASSIVE:
-		reg_idr = AT91_IRQ_ERRA | AT91_IRQ_WARN | AT91_IRQ_ERRP;
-		reg_ier = AT91_IRQ_BOFF;
-		break;
-	case CAN_STATE_BUS_OFF:
-		reg_idr = AT91_IRQ_ERRA | AT91_IRQ_ERRP |
-			AT91_IRQ_WARN | AT91_IRQ_BOFF;
-		reg_ier = 0;
-
-		cf->can_id |= CAN_ERR_BUSOFF;
-
-		netdev_dbg(dev, "bus-off\n");
-		netif_carrier_off(dev);
-		priv->can.can_stats.bus_off++;
-
-		/* turn off chip, if restart is disabled */
-		if (!priv->can.restart_ms) {
-			at91_chip_stop(dev, CAN_STATE_BUS_OFF);
-			return;
-		}
-		break;
-	default:
-		break;
-	}
-
-	at91_write(priv, AT91_IDR, reg_idr);
-	at91_write(priv, AT91_IER, reg_ier);
-}
-
 static void at91_irq_err_line(struct net_device *dev, const u32 reg_sr)
 {
 	enum can_state new_state, rx_state, tx_state;
@@ -970,15 +870,22 @@ static void at91_irq_err_line(struct net_device *dev, const u32 reg_sr)
 	if (likely(new_state == priv->can.state))
 		return;
 
+	/* The skb allocation might fail, but can_change_state()
+	 * handles cf == NULL.
+	 */
 	skb = alloc_can_err_skb(dev, &cf);
+	can_change_state(dev, cf, tx_state, rx_state);
+
+	if (new_state == CAN_STATE_BUS_OFF) {
+		at91_chip_stop(dev, CAN_STATE_BUS_OFF);
+		can_bus_off(dev);
+	}
+
 	if (unlikely(!skb))
 		return;
 
-	at91_irq_err_state(dev, cf, new_state);
 
 	netif_rx(skb);
-
-	priv->can.state = new_state;
 }
 
 static void at91_irq_err_frame(struct net_device *dev, const u32 reg_sr)
@@ -1072,7 +979,11 @@ static irqreturn_t at91_irq(int irq, void *dev_id)
 	if (reg_sr & get_irq_mb_tx(priv))
 		at91_irq_tx(dev, reg_sr);
 
-	at91_irq_err_line(dev, reg_sr);
+	/* Line Error interrupt */
+	if (reg_sr & AT91_IRQ_ERR_LINE ||
+	    priv->can.state > CAN_STATE_ERROR_ACTIVE) {
+		at91_irq_err_line(dev, reg_sr);
+	}
 
 	/* Frame Error Interrupt */
 	if (reg_sr & AT91_IRQ_ERR_FRAME)

-- 
2.40.1


