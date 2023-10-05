Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00567BA658
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 18:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjJEQdi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 12:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjJEQck (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 12:32:40 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCB77EED
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 00:50:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7j-0001M8-GU
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:19 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7g-00BDOO-VT
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:17 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id AA2E722F7F2
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 07:50:16 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 09F6122F7E4;
        Thu,  5 Oct 2023 07:50:16 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id cc78f912;
        Thu, 5 Oct 2023 07:50:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Thu, 05 Oct 2023 09:49:55 +0200
Subject: [PATCH v2 27/27] can: at91_can: switch to rx-offload
 implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-at91_can-rx_offload-v2-27-9987d53600e0@pengutronix.de>
References: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
In-Reply-To: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=18311; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=c34hD9ohedtqR5ak8pzJlho7Dkrz1vHB/kUIbQ/a6wA=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHmqz87ByfcKil2giQOpeYALjiAIdbGSQvqkk+
 c04g9hjQyaJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR5qswAKCRC+UBxKKooE
 6LCOB/9Oysz725FbjoDEJYhBbJx9T5yUZYMGrXuTABIZjBzL1TI5or9mHB+OETkNfRop3VIgubB
 AX3Jnqo2R4COaOFwzpsw0K/JWSRhhG8g7ArCP+5EVOCnBvOHBI6KYJZvrTgr/zGN4bzPZ+0r7DE
 /VzUymjCArGu/bvbcBmcQkj+rg7oCK6Kk4dQOoLmhfrnPL1CWTnPFzRGZS7sUCJCT3ZZrHcH9nm
 kjAxXNDSGlZoCr5DNfMUjfUX9EAjdp7UgzFVPW4eKM7w7pIQeq8obOtXTUBeYrWPKt6cibROQco
 fvtlf3rPSU6lgkQPcAfymaR48Ka3o77zPyBv/bHEtB1qLEt+
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

The current at91_can driver uses NAPI to handle RX'ed CAN frames, the
RX IRQ is disabled and a NAPI poll is scheduled. Then in
at91_poll_rx() the RX'ed CAN frames are tried to read in order from
the device.

This approach has 2 drawbacks:

- Under high system load it might take too long from the initial RX
  IRQ to the NAPI poll function to run. This causes RX buffer
  overflows.
- The algorithm to read the CAN frames in order is not bullet proof
  and may fail under certain use cases/system loads.

The rx-offload helper fixes these problems by reading the RX'ed CAN
frames in the interrupt handler and adding it to a list sorted by RX
timestamp. This list of RX'ed SKBs is then passed to the networking
stack via NAPI.

Convert the RX path to rx-offload, pass all CAN error frames with
can_rx_offload_queue_timestamp().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/Kconfig    |   1 +
 drivers/net/can/at91_can.c | 340 +++++++++++++--------------------------------
 2 files changed, 100 insertions(+), 241 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 649453a3c858..8d6fc0852bf7 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -89,6 +89,7 @@ config CAN_RX_OFFLOAD
 config CAN_AT91
 	tristate "Atmel AT91 onchip CAN controller"
 	depends on (ARCH_AT91 || COMPILE_TEST) && HAS_IOMEM
+	select CAN_RX_OFFLOAD
 	help
 	  This is a driver for the SoC CAN controller in Atmel's AT91SAM9263
 	  and AT91SAM9X5 processors.
diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index ca62aa027e5f..11f434d708b3 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -3,7 +3,7 @@
  * at91_can.c - CAN network driver for AT91 SoC CAN controller
  *
  * (C) 2007 by Hans J. Koch <hjk@hansjkoch.de>
- * (C) 2008, 2009, 2010, 2011 by Marc Kleine-Budde <kernel@pengutronix.de>
+ * (C) 2008, 2009, 2010, 2011, 2023 by Marc Kleine-Budde <kernel@pengutronix.de>
  */
 
 #include <linux/bitfield.h>
@@ -26,6 +26,7 @@
 
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
+#include <linux/can/rx-offload.h>
 
 #define AT91_MB_MASK(i) ((1 << (i)) - 1)
 
@@ -142,7 +143,6 @@ enum at91_devtype {
 
 struct at91_devtype_data {
 	unsigned int rx_first;
-	unsigned int rx_split;
 	unsigned int rx_last;
 	unsigned int tx_shift;
 	enum at91_devtype type;
@@ -150,14 +150,13 @@ struct at91_devtype_data {
 
 struct at91_priv {
 	struct can_priv can;		/* must be the first member! */
-	struct napi_struct napi;
+	struct can_rx_offload offload;
 	struct phy *transceiver;
 
 	void __iomem *reg_base;
 
 	unsigned int tx_head;
 	unsigned int tx_tail;
-	unsigned int rx_next;
 	struct at91_devtype_data devtype_data;
 
 	struct clk *clk;
@@ -166,9 +165,13 @@ struct at91_priv {
 	canid_t mb0_id;
 };
 
+static inline struct at91_priv *rx_offload_to_priv(struct can_rx_offload *offload)
+{
+	return container_of(offload, struct at91_priv, offload);
+}
+
 static const struct at91_devtype_data at91_at91sam9263_data = {
 	.rx_first = 1,
-	.rx_split = 8,
 	.rx_last = 11,
 	.tx_shift = 2,
 	.type = AT91_DEVTYPE_SAM9263,
@@ -176,7 +179,6 @@ static const struct at91_devtype_data at91_at91sam9263_data = {
 
 static const struct at91_devtype_data at91_at91sam9x5_data = {
 	.rx_first = 0,
-	.rx_split = 4,
 	.rx_last = 5,
 	.tx_shift = 1,
 	.type = AT91_DEVTYPE_SAM9X5,
@@ -213,27 +215,6 @@ static inline unsigned int get_mb_rx_last(const struct at91_priv *priv)
 	return priv->devtype_data.rx_last;
 }
 
-static inline unsigned int get_mb_rx_split(const struct at91_priv *priv)
-{
-	return priv->devtype_data.rx_split;
-}
-
-static inline unsigned int get_mb_rx_num(const struct at91_priv *priv)
-{
-	return get_mb_rx_last(priv) - get_mb_rx_first(priv) + 1;
-}
-
-static inline unsigned int get_mb_rx_low_last(const struct at91_priv *priv)
-{
-	return get_mb_rx_split(priv) - 1;
-}
-
-static inline unsigned int get_mb_rx_low_mask(const struct at91_priv *priv)
-{
-	return AT91_MB_MASK(get_mb_rx_split(priv)) &
-		~AT91_MB_MASK(get_mb_rx_first(priv));
-}
-
 static inline unsigned int get_mb_tx_shift(const struct at91_priv *priv)
 {
 	return priv->devtype_data.tx_shift;
@@ -374,9 +355,8 @@ static void at91_setup_mailboxes(struct net_device *dev)
 	for (i = get_mb_tx_first(priv); i <= get_mb_tx_last(priv); i++)
 		set_mb_mode_prio(priv, i, AT91_MB_MODE_TX, 0);
 
-	/* Reset tx and rx helper pointers */
+	/* Reset tx helper pointers */
 	priv->tx_head = priv->tx_tail = 0;
-	priv->rx_next = get_mb_rx_first(priv);
 }
 
 static int at91_set_bittiming(struct net_device *dev)
@@ -548,34 +528,6 @@ static netdev_tx_t at91_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-/**
- * at91_activate_rx_low - activate lower rx mailboxes
- * @priv: a91 context
- *
- * Reenables the lower mailboxes for reception of new CAN messages
- */
-static inline void at91_activate_rx_low(const struct at91_priv *priv)
-{
-	u32 mask = get_mb_rx_low_mask(priv);
-
-	at91_write(priv, AT91_TCR, mask);
-}
-
-/**
- * at91_activate_rx_mb - reactive single rx mailbox
- * @priv: a91 context
- * @mb: mailbox to reactivate
- *
- * Reenables given mailbox for reception of new CAN messages
- */
-static inline void at91_activate_rx_mb(const struct at91_priv *priv,
-				       unsigned int mb)
-{
-	u32 mask = 1 << mb;
-
-	at91_write(priv, AT91_TCR, mask);
-}
-
 static inline u32 at91_get_timestamp(const struct at91_priv *priv)
 {
 	return at91_read(priv, AT91_TIM);
@@ -600,37 +552,60 @@ static void at91_rx_overflow_err(struct net_device *dev)
 {
 	struct net_device_stats *stats = &dev->stats;
 	struct sk_buff *skb;
+	struct at91_priv *priv = netdev_priv(dev);
 	struct can_frame *cf;
+	u32 timestamp;
+	int err;
 
 	netdev_dbg(dev, "RX buffer overflow\n");
 	stats->rx_over_errors++;
 	stats->rx_errors++;
 
-	skb = alloc_can_err_skb(dev, &cf);
+	skb = at91_alloc_can_err_skb(dev, &cf, &timestamp);
 	if (unlikely(!skb))
 		return;
 
 	cf->can_id |= CAN_ERR_CRTL;
 	cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 
-	netif_receive_skb(skb);
+	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	if (err)
+		stats->rx_fifo_errors++;
 }
 
 /**
- * at91_read_mb - read CAN msg from mailbox (lowlevel impl)
- * @dev: net device
+ * at91_mailbox_read - read CAN msg from mailbox
+ * @offload: rx-offload
  * @mb: mailbox number to read from
- * @cf: can frame where to store message
+ * @timestamp: pointer to 32 bit timestamp
+ * @drop: true indicated mailbox to mark as read and drop frame
  *
- * Reads a CAN message from the given mailbox and stores data into
- * given can frame. "mb" and "cf" must be valid.
+ * Reads a CAN message from the given mailbox if not empty.
  */
-static void at91_read_mb(struct net_device *dev, unsigned int mb,
-			 struct can_frame *cf)
+static struct sk_buff *at91_mailbox_read(struct can_rx_offload *offload,
+					 unsigned int mb, u32 *timestamp,
+					 bool drop)
 {
-	const struct at91_priv *priv = netdev_priv(dev);
+	const struct at91_priv *priv = rx_offload_to_priv(offload);
+	struct can_frame *cf;
+	struct sk_buff *skb;
 	u32 reg_msr, reg_mid;
 
+	reg_msr = at91_read(priv, AT91_MSR(mb));
+	if (!(reg_msr & AT91_MSR_MRDY))
+		return NULL;
+
+	if (unlikely(drop)) {
+		skb = ERR_PTR(-ENOBUFS);
+		goto mark_as_read;
+	}
+
+	skb = alloc_can_skb(offload->dev, &cf);
+	if (unlikely(!skb)) {
+		skb = ERR_PTR(-ENOMEM);
+		goto mark_as_read;
+	}
+
 	reg_mid = at91_read(priv, AT91_MID(mb));
 	if (reg_mid & AT91_MID_MIDE)
 		cf->can_id = FIELD_GET(AT91_MID_MIDVA_MASK | AT91_MID_MIDVB_MASK, reg_mid) |
@@ -638,7 +613,9 @@ static void at91_read_mb(struct net_device *dev, unsigned int mb,
 	else
 		cf->can_id = FIELD_GET(AT91_MID_MIDVA_MASK, reg_mid);
 
-	reg_msr = at91_read(priv, AT91_MSR(mb));
+	/* extend timestamp to full 32 bit */
+	*timestamp = FIELD_GET(AT91_MSR_MTIMESTAMP_MASK, reg_msr) << 16;
+
 	cf->len = can_cc_dlc2len(FIELD_GET(AT91_MSR_MDLC_MASK, reg_msr));
 
 	if (reg_msr & AT91_MSR_MRTR) {
@@ -652,151 +629,12 @@ static void at91_read_mb(struct net_device *dev, unsigned int mb,
 	at91_write(priv, AT91_MID(mb), AT91_MID_MIDE);
 
 	if (unlikely(mb == get_mb_rx_last(priv) && reg_msr & AT91_MSR_MMI))
-		at91_rx_overflow_err(dev);
-}
+		at91_rx_overflow_err(offload->dev);
 
-/**
- * at91_read_msg - read CAN message from mailbox
- * @dev: net device
- * @mb: mail box to read from
- *
- * Reads a CAN message from given mailbox, and put into linux network
- * RX queue, does all housekeeping chores (stats, ...)
- */
-static void at91_read_msg(struct net_device *dev, unsigned int mb)
-{
-	struct net_device_stats *stats = &dev->stats;
-	struct can_frame *cf;
-	struct sk_buff *skb;
+ mark_as_read:
+	at91_write(priv, AT91_MCR(mb), AT91_MCR_MTCR);
 
-	skb = alloc_can_skb(dev, &cf);
-	if (unlikely(!skb)) {
-		stats->rx_dropped++;
-		return;
-	}
-
-	at91_read_mb(dev, mb, cf);
-
-	stats->rx_packets++;
-	if (!(cf->can_id & CAN_RTR_FLAG))
-		stats->rx_bytes += cf->len;
-
-	netif_receive_skb(skb);
-}
-
-/**
- * at91_poll_rx - read multiple CAN messages from mailboxes
- * @dev: net device
- * @quota: max number of pkgs we're allowed to receive
- *
- * Theory of Operation:
- *
- * About 3/4 of the mailboxes (get_mb_rx_first()...get_mb_rx_last())
- * on the chip are reserved for RX. We split them into 2 groups. The
- * lower group ranges from get_mb_rx_first() to get_mb_rx_low_last().
- *
- * Like it or not, but the chip always saves a received CAN message
- * into the first free mailbox it finds (starting with the
- * lowest). This makes it very difficult to read the messages in the
- * right order from the chip. This is how we work around that problem:
- *
- * The first message goes into mb nr. 1 and issues an interrupt. All
- * rx ints are disabled in the interrupt handler and a napi poll is
- * scheduled. We read the mailbox, but do _not_ re-enable the mb (to
- * receive another message).
- *
- *    lower mbxs      upper
- *     ____^______    __^__
- *    /           \  /     \
- * +-+-+-+-+-+-+-+-++-+-+-+-+
- * | |x|x|x|x|x|x|x|| | | | |
- * +-+-+-+-+-+-+-+-++-+-+-+-+
- *  0 0 0 0 0 0  0 0 0 0 1 1  \ mail
- *  0 1 2 3 4 5  6 7 8 9 0 1  / box
- *  ^
- *  |
- *   \
- *     unused, due to chip bug
- *
- * The variable priv->rx_next points to the next mailbox to read a
- * message from. As long we're in the lower mailboxes we just read the
- * mailbox but not re-enable it.
- *
- * With completion of the last of the lower mailboxes, we re-enable the
- * whole first group, but continue to look for filled mailboxes in the
- * upper mailboxes. Imagine the second group like overflow mailboxes,
- * which takes CAN messages if the lower goup is full. While in the
- * upper group we re-enable the mailbox right after reading it. Giving
- * the chip more room to store messages.
- *
- * After finishing we look again in the lower group if we've still
- * quota.
- *
- */
-static int at91_poll_rx(struct net_device *dev, int quota)
-{
-	struct at91_priv *priv = netdev_priv(dev);
-	u32 reg_sr = at91_read(priv, AT91_SR);
-	const unsigned long *addr = (unsigned long *)&reg_sr;
-	unsigned int mb;
-	int received = 0;
-
-	if (priv->rx_next > get_mb_rx_low_last(priv) &&
-	    reg_sr & get_mb_rx_low_mask(priv))
-		netdev_info(dev,
-			    "order of incoming frames cannot be guaranteed\n");
-
- again:
-	for (mb = find_next_bit(addr, get_mb_tx_first(priv), priv->rx_next);
-	     mb < get_mb_tx_first(priv) && quota > 0;
-	     reg_sr = at91_read(priv, AT91_SR),
-	     mb = find_next_bit(addr, get_mb_tx_first(priv), ++priv->rx_next)) {
-		at91_read_msg(dev, mb);
-
-		/* reactivate mailboxes */
-		if (mb == get_mb_rx_low_last(priv))
-			/* all lower mailboxed, if just finished it */
-			at91_activate_rx_low(priv);
-		else if (mb > get_mb_rx_low_last(priv))
-			/* only the mailbox we read */
-			at91_activate_rx_mb(priv, mb);
-
-		received++;
-		quota--;
-	}
-
-	/* upper group completed, look again in lower */
-	if (priv->rx_next > get_mb_rx_low_last(priv) &&
-	    mb > get_mb_rx_last(priv)) {
-		priv->rx_next = get_mb_rx_first(priv);
-		if (quota > 0)
-			goto again;
-	}
-
-	return received;
-}
-
-static int at91_poll(struct napi_struct *napi, int quota)
-{
-	struct net_device *dev = napi->dev;
-	const struct at91_priv *priv = netdev_priv(dev);
-	u32 reg_sr = at91_read(priv, AT91_SR);
-	int work_done = 0;
-
-	if (reg_sr & get_irq_mb_rx(priv))
-		work_done += at91_poll_rx(dev, quota - work_done);
-
-	if (work_done < quota) {
-		/* enable IRQs for frame errors and all mailboxes >= rx_next */
-		u32 reg_ier = AT91_IRQ_ERR_FRAME;
-
-		reg_ier |= get_irq_mb_rx(priv) & ~AT91_MB_MASK(priv->rx_next);
-
-		napi_complete_done(napi, work_done);
-		at91_write(priv, AT91_IER, reg_ier);
-	}
-
-	return work_done;
+	return skb;
 }
 
 /* theory of operation:
@@ -816,8 +654,6 @@ static void at91_irq_tx(struct net_device *dev, u32 reg_sr)
 	u32 reg_msr;
 	unsigned int mb;
 
-	/* masking of reg_sr not needed, already done by at91_irq */
-
 	for (/* nix */; (priv->tx_head - priv->tx_tail) > 0; priv->tx_tail++) {
 		mb = get_tx_tail_mb(priv);
 
@@ -855,11 +691,14 @@ static void at91_irq_tx(struct net_device *dev, u32 reg_sr)
 
 static void at91_irq_err_line(struct net_device *dev, const u32 reg_sr)
 {
+	struct net_device_stats *stats = &dev->stats;
 	enum can_state new_state, rx_state, tx_state;
 	struct at91_priv *priv = netdev_priv(dev);
 	struct can_berr_counter bec;
 	struct sk_buff *skb;
 	struct can_frame *cf;
+	u32 timestamp;
+	int err;
 
 	at91_get_berr_counter(dev, &bec);
 	can_state_get_by_berr_counter(dev, &bec, &tx_state, &rx_state);
@@ -889,7 +728,7 @@ static void at91_irq_err_line(struct net_device *dev, const u32 reg_sr)
 	/* The skb allocation might fail, but can_change_state()
 	 * handles cf == NULL.
 	 */
-	skb = alloc_can_err_skb(dev, &cf);
+	skb = at91_alloc_can_err_skb(dev, &cf, &timestamp);
 	can_change_state(dev, cf, tx_state, rx_state);
 
 	if (new_state == CAN_STATE_BUS_OFF) {
@@ -906,19 +745,23 @@ static void at91_irq_err_line(struct net_device *dev, const u32 reg_sr)
 		cf->data[7] = bec.rxerr;
 	}
 
-	netif_rx(skb);
+	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	if (err)
+		stats->rx_fifo_errors++;
 }
 
 static void at91_irq_err_frame(struct net_device *dev, const u32 reg_sr)
 {
 	struct net_device_stats *stats = &dev->stats;
 	struct at91_priv *priv = netdev_priv(dev);
+	struct can_frame *cf;
 	struct sk_buff *skb;
-	struct can_frame *cf = NULL;
+	u32 timestamp;
+	int err;
 
 	priv->can.can_stats.bus_error++;
 
-	skb = alloc_can_err_skb(dev, &cf);
+	skb = at91_alloc_can_err_skb(dev, &cf, &timestamp);
 	if (cf)
 		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
@@ -967,50 +810,62 @@ static void at91_irq_err_frame(struct net_device *dev, const u32 reg_sr)
 	if (!cf)
 		return;
 
-	netif_receive_skb(skb);
+	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	if (err)
+		stats->rx_fifo_errors++;
+}
+
+static u32 at91_get_reg_sr_rx(const struct at91_priv *priv, u32 *reg_sr_p)
+{
+	const u32 reg_sr = at91_read(priv, AT91_SR);
+
+	*reg_sr_p |= reg_sr;
+
+	return reg_sr & get_irq_mb_rx(priv);
 }
 
-/* interrupt handler
- */
 static irqreturn_t at91_irq(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
 	struct at91_priv *priv = netdev_priv(dev);
 	irqreturn_t handled = IRQ_NONE;
-	u32 reg_sr, reg_imr;
+	u32 reg_sr = 0, reg_sr_rx;
+	int ret;
 
-	reg_sr = at91_read(priv, AT91_SR);
-	reg_imr = at91_read(priv, AT91_IMR);
+	/* Receive interrupt
+	 * Some bits of AT91_SR are cleared on read, keep them in reg_sr.
+	 */
+	while ((reg_sr_rx = at91_get_reg_sr_rx(priv, &reg_sr))) {
+		ret = can_rx_offload_irq_offload_timestamp(&priv->offload,
+							   reg_sr_rx);
+		handled = IRQ_HANDLED;
 
-	/* Ignore masked interrupts */
-	reg_sr &= reg_imr;
-	if (!reg_sr)
-		goto exit;
-
-	handled = IRQ_HANDLED;
-
-	/* Receive interrupt? -> napi */
-	if (reg_sr & get_irq_mb_rx(priv)) {
-		at91_write(priv, AT91_IDR,
-			   get_irq_mb_rx(priv));
-		napi_schedule(&priv->napi);
+		if (!ret)
+			break;
 	}
 
 	/* Transmission complete interrupt */
-	if (reg_sr & get_irq_mb_tx(priv))
+	if (reg_sr & get_irq_mb_tx(priv)) {
 		at91_irq_tx(dev, reg_sr);
+		handled = IRQ_HANDLED;
+	}
 
 	/* Line Error interrupt */
 	if (reg_sr & AT91_IRQ_ERR_LINE ||
 	    priv->can.state > CAN_STATE_ERROR_ACTIVE) {
 		at91_irq_err_line(dev, reg_sr);
+		handled = IRQ_HANDLED;
 	}
 
 	/* Frame Error Interrupt */
-	if (reg_sr & AT91_IRQ_ERR_FRAME)
+	if (reg_sr & AT91_IRQ_ERR_FRAME) {
 		at91_irq_err_frame(dev, reg_sr);
+		handled = IRQ_HANDLED;
+	}
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
 
- exit:
 	return handled;
 }
 
@@ -1040,7 +895,7 @@ static int at91_open(struct net_device *dev)
 
 	/* start chip and queuing */
 	at91_chip_start(dev);
-	napi_enable(&priv->napi);
+	can_rx_offload_enable(&priv->offload);
 	netif_start_queue(dev);
 
 	return 0;
@@ -1062,7 +917,7 @@ static int at91_close(struct net_device *dev)
 	struct at91_priv *priv = netdev_priv(dev);
 
 	netif_stop_queue(dev);
-	napi_disable(&priv->napi);
+	can_rx_offload_disable(&priv->offload);
 	at91_chip_stop(dev, CAN_STATE_STOPPED);
 
 	free_irq(dev->irq, dev);
@@ -1265,8 +1120,11 @@ static int at91_can_probe(struct platform_device *pdev)
 	priv->clk = clk;
 	priv->pdata = dev_get_platdata(&pdev->dev);
 	priv->mb0_id = 0x7ff;
+	priv->offload.mailbox_read = at91_mailbox_read;
+	priv->offload.mb_first = devtype_data->rx_first;
+	priv->offload.mb_last = devtype_data->rx_last;
 
-	netif_napi_add_weight(dev, &priv->napi, at91_poll, get_mb_rx_num(priv));
+	can_rx_offload_add_timestamp(dev, &priv->offload);
 
 	if (transceiver)
 		priv->can.bitrate_max = transceiver->attrs.max_link_rate;

-- 
2.40.1


