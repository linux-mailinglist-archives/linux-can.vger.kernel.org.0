Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67E37B7BF2
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 11:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbjJDJY1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 05:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjJDJYW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 05:24:22 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992F7B8
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 02:24:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny76-0005R5-PO
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:16 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny74-00AzmO-Gx
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:14 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id E6E3322EB85
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 09:24:13 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 4622622EB6C;
        Wed,  4 Oct 2023 09:24:13 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8543aa49;
        Wed, 4 Oct 2023 09:24:10 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Wed, 04 Oct 2023 11:23:38 +0200
Subject: [PATCH 19/27] can: at91_can: at91_irq_err_frame(): call directly
 from IRQ handler
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-at91_can-rx_offload-v1-19-c32bf99097db@pengutronix.de>
References: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
In-Reply-To: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3299; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=1z/F9uYotkMm5Rx15rBfqS8RX14a9OPdhlcH6ptwk+g=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHS8tB1Sk9C/W3n1x1WSofLmTyBY1jaOFErjRp
 6epgfGV2m2JATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR0vLQAKCRC+UBxKKooE
 6MqvB/9BNjtrssrgGDBssKCXTkbl5DsE6qdgPuGaV+94Bw2XL7ZUu1bDNO0n7b/wQD7jtY4wyBc
 zUF2dfzZfNU63jZD3tlyq7OIg3QE4oPzufu/iPFcq6TMjcIylvFxSL1X+HRnYTpw7Bgx/gQxjaI
 0t5ym/P0XjeoEVkorqSm68v1hG+Ak0VPnV0+FUiN9boPimze4ULBbfKhP4jx4GQv5rxn3b8fqLL
 /OUD/qqvYn8G4jtBYCPFTF3oocOwfNq/9l5BEUsZvVus9uPRnDjHC+8R4GoF3XGZ/SIBRA+YewU
 o2HLNIJayz3qRXRHOfdKZqn+0mF4zTVTXjBYvUL1yltkgroy
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

This is a preparation patch to convert the driver to the rx-offload
helper. In rx-offload RX, TX-done and CAN error handling are done in
the IRQ handler, SKB are pushed to the network stack in the NAPI poll
function.

Move the CAN frame error handling from the NAPI function at91_poll()
to the IRQ handler at91_poll(). To reflect this change, rename
at91_poll_err() to at91_irq_err_frame().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 5b611657b41f..a84da1995816 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -155,7 +155,6 @@ struct at91_priv {
 
 	void __iomem *reg_base;
 
-	u32 reg_sr;
 	unsigned int tx_head;
 	unsigned int tx_tail;
 	unsigned int rx_next;
@@ -751,7 +750,7 @@ static int at91_poll_rx(struct net_device *dev, int quota)
 	return received;
 }
 
-static int at91_poll_err(struct net_device *dev, int quota, u32 reg_sr)
+static void at91_irq_err_frame(struct net_device *dev, const u32 reg_sr)
 {
 	struct net_device_stats *stats = &dev->stats;
 	struct at91_priv *priv = netdev_priv(dev);
@@ -760,11 +759,9 @@ static int at91_poll_err(struct net_device *dev, int quota, u32 reg_sr)
 
 	priv->can.can_stats.bus_error++;
 
-	if (quota) {
-		skb = alloc_can_err_skb(dev, &cf);
-		if (cf)
-			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
-	}
+	skb = alloc_can_err_skb(dev, &cf);
+	if (cf)
+		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
 	if (reg_sr & AT91_IRQ_CERR) {
 		netdev_dbg(dev, "CRC error\n");
@@ -809,11 +806,9 @@ static int at91_poll_err(struct net_device *dev, int quota, u32 reg_sr)
 	}
 
 	if (!cf)
-		return 0;
+		return;
 
 	netif_receive_skb(skb);
-
-	return 1;
 }
 
 static int at91_poll(struct napi_struct *napi, int quota)
@@ -826,13 +821,6 @@ static int at91_poll(struct napi_struct *napi, int quota)
 	if (reg_sr & get_irq_mb_rx(priv))
 		work_done += at91_poll_rx(dev, quota - work_done);
 
-	/* The error bits are clear on read,
-	 * so use saved value from irq handler.
-	 */
-	reg_sr |= priv->reg_sr;
-	if (reg_sr & AT91_IRQ_ERR_FRAME)
-		work_done += at91_poll_err(dev, quota - work_done, reg_sr);
-
 	if (work_done < quota) {
 		/* enable IRQs for frame errors and all mailboxes >= rx_next */
 		u32 reg_ier = AT91_IRQ_ERR_FRAME;
@@ -1092,14 +1080,10 @@ static irqreturn_t at91_irq(int irq, void *dev_id)
 
 	handled = IRQ_HANDLED;
 
-	/* Receive or error interrupt? -> napi */
-	if (reg_sr & (get_irq_mb_rx(priv) | AT91_IRQ_ERR_FRAME)) {
-		/* The error bits are clear on read,
-		 * save for later use.
-		 */
-		priv->reg_sr = reg_sr;
+	/* Receive interrupt? -> napi */
+	if (reg_sr & get_irq_mb_rx(priv)) {
 		at91_write(priv, AT91_IDR,
-			   get_irq_mb_rx(priv) | AT91_IRQ_ERR_FRAME);
+			   get_irq_mb_rx(priv));
 		napi_schedule(&priv->napi);
 	}
 
@@ -1109,6 +1093,10 @@ static irqreturn_t at91_irq(int irq, void *dev_id)
 
 	at91_irq_err(dev);
 
+	/* Frame Error Interrupt */
+	if (reg_sr & AT91_IRQ_ERR_FRAME)
+		at91_irq_err_frame(dev, reg_sr);
+
  exit:
 	return handled;
 }

-- 
2.40.1


