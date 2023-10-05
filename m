Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4522B7BAB05
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 21:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjJET6r (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 15:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjJET6a (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 15:58:30 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B0ADE
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 12:58:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoUUL-0004pD-7x
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 21:58:25 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoUUG-00BLKs-31
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 21:58:20 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 0326F230036
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 19:58:18 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 989A322FFAD;
        Thu,  5 Oct 2023 19:58:16 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3a5dd773;
        Thu, 5 Oct 2023 19:58:14 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 22/37] can: at91_can: rename struct at91_priv::{tx_next,tx_echo} to {tx_head,tx_tail}
Date:   Thu,  5 Oct 2023 21:57:57 +0200
Message-Id: <20231005195812.549776-23-mkl@pengutronix.de>
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

To increase code readability, use the same naming of the counters for
the TX FIFO as in the other drivers implementing the same algorithm.

Link: https://lore.kernel.org/all/20231005-at91_can-rx_offload-v2-12-9987d53600e0@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 56 +++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index b94fb35dc59e..092652fd7352 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -154,8 +154,8 @@ struct at91_priv {
 	void __iomem *reg_base;
 
 	u32 reg_sr;
-	unsigned int tx_next;
-	unsigned int tx_echo;
+	unsigned int tx_head;
+	unsigned int tx_tail;
 	unsigned int rx_next;
 	struct at91_devtype_data devtype_data;
 
@@ -253,24 +253,24 @@ static inline unsigned int get_mb_tx_last(const struct at91_priv *priv)
 	return get_mb_tx_first(priv) + get_mb_tx_num(priv) - 1;
 }
 
-static inline unsigned int get_next_prio_shift(const struct at91_priv *priv)
+static inline unsigned int get_head_prio_shift(const struct at91_priv *priv)
 {
 	return get_mb_tx_shift(priv);
 }
 
-static inline unsigned int get_next_prio_mask(const struct at91_priv *priv)
+static inline unsigned int get_head_prio_mask(const struct at91_priv *priv)
 {
 	return 0xf << get_mb_tx_shift(priv);
 }
 
-static inline unsigned int get_next_mb_mask(const struct at91_priv *priv)
+static inline unsigned int get_head_mb_mask(const struct at91_priv *priv)
 {
 	return AT91_MB_MASK(get_mb_tx_shift(priv));
 }
 
-static inline unsigned int get_next_mask(const struct at91_priv *priv)
+static inline unsigned int get_head_mask(const struct at91_priv *priv)
 {
-	return get_next_mb_mask(priv) | get_next_prio_mask(priv);
+	return get_head_mb_mask(priv) | get_head_prio_mask(priv);
 }
 
 static inline unsigned int get_irq_mb_rx(const struct at91_priv *priv)
@@ -285,19 +285,19 @@ static inline unsigned int get_irq_mb_tx(const struct at91_priv *priv)
 		~AT91_MB_MASK(get_mb_tx_first(priv));
 }
 
-static inline unsigned int get_tx_next_mb(const struct at91_priv *priv)
+static inline unsigned int get_tx_head_mb(const struct at91_priv *priv)
 {
-	return (priv->tx_next & get_next_mb_mask(priv)) + get_mb_tx_first(priv);
+	return (priv->tx_head & get_head_mb_mask(priv)) + get_mb_tx_first(priv);
 }
 
-static inline unsigned int get_tx_next_prio(const struct at91_priv *priv)
+static inline unsigned int get_tx_head_prio(const struct at91_priv *priv)
 {
-	return (priv->tx_next >> get_next_prio_shift(priv)) & 0xf;
+	return (priv->tx_head >> get_head_prio_shift(priv)) & 0xf;
 }
 
-static inline unsigned int get_tx_echo_mb(const struct at91_priv *priv)
+static inline unsigned int get_tx_tail_mb(const struct at91_priv *priv)
 {
-	return (priv->tx_echo & get_next_mb_mask(priv)) + get_mb_tx_first(priv);
+	return (priv->tx_tail & get_head_mb_mask(priv)) + get_mb_tx_first(priv);
 }
 
 static inline u32 at91_read(const struct at91_priv *priv, enum at91_reg reg)
@@ -374,7 +374,7 @@ static void at91_setup_mailboxes(struct net_device *dev)
 		set_mb_mode_prio(priv, i, AT91_MB_MODE_TX, 0);
 
 	/* Reset tx and rx helper pointers */
-	priv->tx_next = priv->tx_echo = 0;
+	priv->tx_head = priv->tx_tail = 0;
 	priv->rx_next = get_mb_rx_first(priv);
 }
 
@@ -470,11 +470,11 @@ static void at91_chip_stop(struct net_device *dev, enum can_state state)
  * stop sending, waiting for all messages to be delivered, then start
  * again with mailbox AT91_MB_TX_FIRST prio 0.
  *
- * We use the priv->tx_next as counter for the next transmission
+ * We use the priv->tx_head as counter for the next transmission
  * mailbox, but without the offset AT91_MB_TX_FIRST. The lower bits
  * encode the mailbox number, the upper 4 bits the mailbox priority:
  *
- * priv->tx_next = (prio << get_next_prio_shift(priv)) |
+ * priv->tx_head = (prio << get_next_prio_shift(priv)) |
  *                 (mb - get_mb_tx_first(priv));
  *
  */
@@ -488,8 +488,8 @@ static netdev_tx_t at91_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
 
-	mb = get_tx_next_mb(priv);
-	prio = get_tx_next_prio(priv);
+	mb = get_tx_head_mb(priv);
+	prio = get_tx_head_prio(priv);
 
 	if (unlikely(!(at91_read(priv, AT91_MSR(mb)) & AT91_MSR_MRDY))) {
 		netif_stop_queue(dev);
@@ -521,15 +521,15 @@ static netdev_tx_t at91_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	/* we have to stop the queue and deliver all messages in case
 	 * of a prio+mb counter wrap around. This is the case if
-	 * tx_next buffer prio and mailbox equals 0.
+	 * tx_head buffer prio and mailbox equals 0.
 	 *
 	 * also stop the queue if next buffer is still in use
 	 * (== not ready)
 	 */
-	priv->tx_next++;
-	if (!(at91_read(priv, AT91_MSR(get_tx_next_mb(priv))) &
+	priv->tx_head++;
+	if (!(at91_read(priv, AT91_MSR(get_tx_head_mb(priv))) &
 	      AT91_MSR_MRDY) ||
-	    (priv->tx_next & get_next_mask(priv)) == 0)
+	    (priv->tx_head & get_head_mask(priv)) == 0)
 		netif_stop_queue(dev);
 
 	/* Enable interrupt for this mailbox */
@@ -849,11 +849,11 @@ static int at91_poll(struct napi_struct *napi, int quota)
 
 /* theory of operation:
  *
- * priv->tx_echo holds the number of the oldest can_frame put for
+ * priv->tx_tail holds the number of the oldest can_frame put for
  * transmission into the hardware, but not yet ACKed by the CAN tx
  * complete IRQ.
  *
- * We iterate from priv->tx_echo to priv->tx_next and check if the
+ * We iterate from priv->tx_tail to priv->tx_head and check if the
  * packet has been transmitted, echo it back to the CAN framework. If
  * we discover a not yet transmitted package, stop looking for more.
  *
@@ -866,8 +866,8 @@ static void at91_irq_tx(struct net_device *dev, u32 reg_sr)
 
 	/* masking of reg_sr not needed, already done by at91_irq */
 
-	for (/* nix */; (priv->tx_next - priv->tx_echo) > 0; priv->tx_echo++) {
-		mb = get_tx_echo_mb(priv);
+	for (/* nix */; (priv->tx_head - priv->tx_tail) > 0; priv->tx_tail++) {
+		mb = get_tx_tail_mb(priv);
 
 		/* no event in mailbox? */
 		if (!(reg_sr & (1 << mb)))
@@ -896,8 +896,8 @@ static void at91_irq_tx(struct net_device *dev, u32 reg_sr)
 	 * we get a TX int for the last can frame directly before a
 	 * wrap around.
 	 */
-	if ((priv->tx_next & get_next_mask(priv)) != 0 ||
-	    (priv->tx_echo & get_next_mask(priv)) == 0)
+	if ((priv->tx_head & get_head_mask(priv)) != 0 ||
+	    (priv->tx_tail & get_head_mask(priv)) == 0)
 		netif_wake_queue(dev);
 }
 
-- 
2.40.1


