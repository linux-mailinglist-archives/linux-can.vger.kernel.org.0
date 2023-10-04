Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368177B7BF3
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 11:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjJDJY1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 05:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241776AbjJDJYW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 05:24:22 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894AEAB
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 02:24:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny76-0005QY-NM
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:16 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny74-00Azlt-9D
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:14 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id C706622EB80
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 09:24:13 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 2F04922EB67;
        Wed,  4 Oct 2023 09:24:13 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 83d55a49;
        Wed, 4 Oct 2023 09:24:10 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Wed, 04 Oct 2023 11:23:37 +0200
Subject: [PATCH 18/27] can: at91_can: at91_poll_err(): increase stats even
 if no quota left or OOM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-at91_can-rx_offload-v1-18-c32bf99097db@pengutronix.de>
References: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
In-Reply-To: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3406; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=5rbdFIiR/Z/p3f8J+hdbbnVVRmgtjPB/ER2etF/cbrc=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHS8syq32rYm5QB5s4ZWOYzWKXG6bI/Pzo6SGw
 kymMhrvxDuJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR0vLAAKCRC+UBxKKooE
 6LQoB/42HiA241qr5aRzhAsk8CNLSPFng30/Z87nS9By+xVlO/YKyqt+J2nfDY70RhN2i+HW8Tb
 IAX3viru4oBvqp9YGxehG7LojxTY7s5o8MzImxb3mF9m3+i17FSrq4OPXQ6elP9p5v4Ol4BYk0P
 XSgvFUAA2V1TKtgn1++AdKdJKcSbsCQmJh4C6Lw2wMaCbODBQYkJduzA3DQJbG3ymJD+KL0ikRS
 3kHJyrqaPcrfChtyPIE+zguv29c4lPNiaz/YlbMzVbxNiDmWDC4QFakD+bdSxiOGZq3V3w9JrWQ
 2Xu4TqOBbc6hxk52+uGMDAPtubJttJ5nMaCGTZKdhWjiaGPb
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

at91_poll_err() allocates a can error SKB, to inform the user space
about the CAN error. Then it fills the SKB with information the error
information and increases the net device error stats.

In case no SBK can be allocated (e.g. due to an OOM) or the NAPI quota
is 0 the function is left early and no stats are updated. This is not
helpful to the user, as there is no information about the faulty CAN
bus.

Increase the error stats even if no quota is left or no SKB can be
allocated.

While there treat No-Acknowledgment as a bus error, too.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 71 +++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 2071011ee812..5b611657b41f 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -753,59 +753,64 @@ static int at91_poll_rx(struct net_device *dev, int quota)
 
 static int at91_poll_err(struct net_device *dev, int quota, u32 reg_sr)
 {
+	struct net_device_stats *stats = &dev->stats;
 	struct at91_priv *priv = netdev_priv(dev);
 	struct sk_buff *skb;
-	struct can_frame *cf;
+	struct can_frame *cf = NULL;
 
-	if (quota == 0)
-		return 0;
+	priv->can.can_stats.bus_error++;
 
-	skb = alloc_can_err_skb(dev, &cf);
-	if (unlikely(!skb))
-		return 0;
+	if (quota) {
+		skb = alloc_can_err_skb(dev, &cf);
+		if (cf)
+			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+	}
 
-	/* CRC error */
 	if (reg_sr & AT91_IRQ_CERR) {
-		netdev_dbg(dev, "CERR irq\n");
-		dev->stats.rx_errors++;
-		priv->can.can_stats.bus_error++;
-		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+		netdev_dbg(dev, "CRC error\n");
+
+		stats->rx_errors++;
+		if (cf)
+			cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ;
 	}
 
-	/* Stuffing Error */
 	if (reg_sr & AT91_IRQ_SERR) {
-		netdev_dbg(dev, "SERR irq\n");
-		dev->stats.rx_errors++;
-		priv->can.can_stats.bus_error++;
-		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
-		cf->data[2] |= CAN_ERR_PROT_STUFF;
+		netdev_dbg(dev, "Stuff error\n");
+
+		stats->rx_errors++;
+		if (cf)
+			cf->data[2] |= CAN_ERR_PROT_STUFF;
 	}
 
-	/* Acknowledgement Error */
 	if (reg_sr & AT91_IRQ_AERR) {
-		netdev_dbg(dev, "AERR irq\n");
-		dev->stats.tx_errors++;
-		cf->can_id |= CAN_ERR_ACK;
+		netdev_dbg(dev, "NACK error\n");
+
+		stats->tx_errors++;
+		if (cf) {
+			cf->can_id |= CAN_ERR_ACK;
+			cf->data[2] |= CAN_ERR_PROT_TX;
+		}
 	}
 
-	/* Form error */
 	if (reg_sr & AT91_IRQ_FERR) {
-		netdev_dbg(dev, "FERR irq\n");
-		dev->stats.rx_errors++;
-		priv->can.can_stats.bus_error++;
-		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
-		cf->data[2] |= CAN_ERR_PROT_FORM;
+		netdev_dbg(dev, "Format error\n");
+
+		stats->rx_errors++;
+		if (cf)
+			cf->data[2] |= CAN_ERR_PROT_FORM;
 	}
 
-	/* Bit Error */
 	if (reg_sr & AT91_IRQ_BERR) {
-		netdev_dbg(dev, "BERR irq\n");
-		dev->stats.tx_errors++;
-		priv->can.can_stats.bus_error++;
-		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
-		cf->data[2] |= CAN_ERR_PROT_BIT;
+		netdev_dbg(dev, "Bit error\n");
+
+		stats->tx_errors++;
+		if (cf)
+			cf->data[2] |= CAN_ERR_PROT_TX | CAN_ERR_PROT_BIT;
 	}
 
+	if (!cf)
+		return 0;
+
 	netif_receive_skb(skb);
 
 	return 1;

-- 
2.40.1


