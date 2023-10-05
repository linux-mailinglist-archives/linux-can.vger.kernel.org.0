Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2B97B9F9E
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 16:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjJEOZz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 10:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjJEOXy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 10:23:54 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCA37EE6
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 00:50:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7j-0001JH-0G
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:19 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7g-00BDNO-Am
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:16 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id F36FF22F7E3
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 07:50:15 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 5415822F7C9;
        Thu,  5 Oct 2023 07:50:15 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d2f4a62e;
        Thu, 5 Oct 2023 07:50:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Thu, 05 Oct 2023 09:49:48 +0200
Subject: [PATCH v2 20/27] can: at91_can: at91_irq_err_frame(): move next to
 at91_irq_err()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-at91_can-rx_offload-v2-20-9987d53600e0@pengutronix.de>
References: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
In-Reply-To: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3530; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=7Zb1WiUdTmkLRIJ6/vde+PVrjOC/5jImM8qk2Zc1pWc=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHmqnOGRTtns8MvLRwucnVQ0jxlPL0BBdiO/ew
 bJ+7EBoBpCJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR5qpwAKCRC+UBxKKooE
 6MkYCACXGdI3043p5Tt2sVFKz8r662KAVBQmlapbax79isa9mTZh0LVpkmSyfjvk/H9nO1R06Ov
 mpKDF6QFrUfxyx8sQqy3im6VmZwm99h/B/uBZQCJEjU19s9IQsTo7XqoShhilKJS4ibZwoT5zlw
 Aci7+yg5wEMAHOsPyzIOiAY8zQl7pcCdI5kuwMu6O0zc9NQLiKP3dfX5WcyUzfpAS329/yB2IXL
 BqEdtkT9kjXiqOjYKP06FaG+EV4HyCLpoYDviPaf5QdthEKtzk90OBJ8Dy1upxMhNoy2tRNywuV
 gG32EynbJQP9cWckIfjx1C4CShoMKGsnzJNakUwmW+LTA0mS
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

This is a cleanup patch, no functional change intended. As
at91_irq_err_frame() is called from the IRQ handler move it in front
of the IRQ handler next to at91_irq_err().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 122 ++++++++++++++++++++++-----------------------
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


