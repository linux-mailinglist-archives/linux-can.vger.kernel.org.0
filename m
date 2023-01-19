Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FEE6736C8
	for <lists+linux-can@lfdr.de>; Thu, 19 Jan 2023 12:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjASL2w (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Jan 2023 06:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjASL2w (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2023 06:28:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580996D68B
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 03:28:49 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pIT67-0003t0-QE
        for linux-can@vger.kernel.org; Thu, 19 Jan 2023 12:28:47 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id C45B315D1AB
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 11:28:45 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 60B4215D18C;
        Thu, 19 Jan 2023 11:28:44 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3ebe0d71;
        Thu, 19 Jan 2023 11:28:43 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        =?UTF-8?q?Stefan=20Alth=C3=B6fer?= <Stefan.Althoefer@janztec.com>,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 2/5] can: mcp251xfd: clarify the meaning of timestamp
Date:   Thu, 19 Jan 2023 12:28:39 +0100
Message-Id: <20230119112842.500709-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119112842.500709-1-mkl@pengutronix.de>
References: <20230119112842.500709-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The mcp251xfd chip is configured to provide a timestamp with each
received and transmitted CAN frame. The timestamp is derived from the
internal free-running timer, which can also be read from the TBC
register via SPI. The timer is 32 bits wide and is clocked by the
external oscillator (typically 20 or 40 MHz).

To avoid confusion, we call this timestamp "timestamp_raw" or "ts_raw"
for short.

Using the timecounter framework, the "ts_raw" is converted to 64 bit
nanoseconds since the epoch. This is what we call "timestamp".

This is a preparation for the next patches which use the "timestamp"
to work around a bug where so far only the "ts_raw" is used.

Tested-by: Stefan Althöfer <Stefan.Althoefer@janztec.com>
Tested-by: Thomas Kopp <thomas.kopp@microchip.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 28 +++++++++----------
 drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c  |  2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c |  2 +-
 .../can/spi/mcp251xfd/mcp251xfd-timestamp.c   | 22 ++++-----------
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     | 27 ++++++++++++++----
 5 files changed, 43 insertions(+), 38 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 4c0e3580efc1..5d7760803503 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -2,7 +2,7 @@
 //
 // mcp251xfd - Microchip MCP251xFD Family CAN controller driver
 //
-// Copyright (c) 2019, 2020, 2021 Pengutronix,
+// Copyright (c) 2019, 2020, 2021, 2023 Pengutronix,
 //               Marc Kleine-Budde <kernel@pengutronix.de>
 //
 // Based on:
@@ -866,18 +866,18 @@ static int mcp251xfd_get_berr_counter(const struct net_device *ndev,
 
 static struct sk_buff *
 mcp251xfd_alloc_can_err_skb(struct mcp251xfd_priv *priv,
-			    struct can_frame **cf, u32 *timestamp)
+			    struct can_frame **cf, u32 *ts_raw)
 {
 	struct sk_buff *skb;
 	int err;
 
-	err = mcp251xfd_get_timestamp(priv, timestamp);
+	err = mcp251xfd_get_timestamp_raw(priv, ts_raw);
 	if (err)
 		return NULL;
 
 	skb = alloc_can_err_skb(priv->ndev, cf);
 	if (skb)
-		mcp251xfd_skb_set_timestamp(priv, skb, *timestamp);
+		mcp251xfd_skb_set_timestamp_raw(priv, skb, *ts_raw);
 
 	return skb;
 }
@@ -888,7 +888,7 @@ static int mcp251xfd_handle_rxovif(struct mcp251xfd_priv *priv)
 	struct mcp251xfd_rx_ring *ring;
 	struct sk_buff *skb;
 	struct can_frame *cf;
-	u32 timestamp, rxovif;
+	u32 ts_raw, rxovif;
 	int err, i;
 
 	stats->rx_over_errors++;
@@ -923,14 +923,14 @@ static int mcp251xfd_handle_rxovif(struct mcp251xfd_priv *priv)
 			return err;
 	}
 
-	skb = mcp251xfd_alloc_can_err_skb(priv, &cf, &timestamp);
+	skb = mcp251xfd_alloc_can_err_skb(priv, &cf, &ts_raw);
 	if (!skb)
 		return 0;
 
 	cf->can_id |= CAN_ERR_CRTL;
 	cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	err = can_rx_offload_queue_timestamp(&priv->offload, skb, ts_raw);
 	if (err)
 		stats->rx_fifo_errors++;
 
@@ -947,12 +947,12 @@ static int mcp251xfd_handle_txatif(struct mcp251xfd_priv *priv)
 static int mcp251xfd_handle_ivmif(struct mcp251xfd_priv *priv)
 {
 	struct net_device_stats *stats = &priv->ndev->stats;
-	u32 bdiag1, timestamp;
+	u32 bdiag1, ts_raw;
 	struct sk_buff *skb;
 	struct can_frame *cf = NULL;
 	int err;
 
-	err = mcp251xfd_get_timestamp(priv, &timestamp);
+	err = mcp251xfd_get_timestamp_raw(priv, &ts_raw);
 	if (err)
 		return err;
 
@@ -1034,8 +1034,8 @@ static int mcp251xfd_handle_ivmif(struct mcp251xfd_priv *priv)
 	if (!cf)
 		return 0;
 
-	mcp251xfd_skb_set_timestamp(priv, skb, timestamp);
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	mcp251xfd_skb_set_timestamp_raw(priv, skb, ts_raw);
+	err = can_rx_offload_queue_timestamp(&priv->offload, skb, ts_raw);
 	if (err)
 		stats->rx_fifo_errors++;
 
@@ -1048,7 +1048,7 @@ static int mcp251xfd_handle_cerrif(struct mcp251xfd_priv *priv)
 	struct sk_buff *skb;
 	struct can_frame *cf = NULL;
 	enum can_state new_state, rx_state, tx_state;
-	u32 trec, timestamp;
+	u32 trec, ts_raw;
 	int err;
 
 	err = regmap_read(priv->map_reg, MCP251XFD_REG_TREC, &trec);
@@ -1078,7 +1078,7 @@ static int mcp251xfd_handle_cerrif(struct mcp251xfd_priv *priv)
 	/* The skb allocation might fail, but can_change_state()
 	 * handles cf == NULL.
 	 */
-	skb = mcp251xfd_alloc_can_err_skb(priv, &cf, &timestamp);
+	skb = mcp251xfd_alloc_can_err_skb(priv, &cf, &ts_raw);
 	can_change_state(priv->ndev, cf, tx_state, rx_state);
 
 	if (new_state == CAN_STATE_BUS_OFF) {
@@ -1109,7 +1109,7 @@ static int mcp251xfd_handle_cerrif(struct mcp251xfd_priv *priv)
 		cf->data[7] = bec.rxerr;
 	}
 
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	err = can_rx_offload_queue_timestamp(&priv->offload, skb, ts_raw);
 	if (err)
 		stats->rx_fifo_errors++;
 
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
index ced8d9c81f8c..6d66b97709b8 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
@@ -149,7 +149,7 @@ mcp251xfd_hw_rx_obj_to_skb(const struct mcp251xfd_priv *priv,
 	if (!(hw_rx_obj->flags & MCP251XFD_OBJ_FLAGS_RTR))
 		memcpy(cfd->data, hw_rx_obj->data, cfd->len);
 
-	mcp251xfd_skb_set_timestamp(priv, skb, hw_rx_obj->ts);
+	mcp251xfd_skb_set_timestamp_raw(priv, skb, hw_rx_obj->ts);
 }
 
 static int
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
index 237617b0c125..0c89e4f33976 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
@@ -109,7 +109,7 @@ mcp251xfd_handle_tefif_one(struct mcp251xfd_priv *priv,
 	tef_tail = mcp251xfd_get_tef_tail(priv);
 	skb = priv->can.echo_skb[tef_tail];
 	if (skb)
-		mcp251xfd_skb_set_timestamp(priv, skb, hw_tef_obj->ts);
+		mcp251xfd_skb_set_timestamp_raw(priv, skb, hw_tef_obj->ts);
 	stats->tx_bytes +=
 		can_rx_offload_get_echo_skb(&priv->offload,
 					    tef_tail, hw_tef_obj->ts,
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
index 712e09186987..1db99aabe85c 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
@@ -2,7 +2,7 @@
 //
 // mcp251xfd - Microchip MCP251xFD Family CAN controller driver
 //
-// Copyright (c) 2021 Pengutronix,
+// Copyright (c) 2021, 2023 Pengutronix,
 //               Marc Kleine-Budde <kernel@pengutronix.de>
 //
 
@@ -11,20 +11,20 @@
 
 #include "mcp251xfd.h"
 
-static u64 mcp251xfd_timestamp_read(const struct cyclecounter *cc)
+static u64 mcp251xfd_timestamp_raw_read(const struct cyclecounter *cc)
 {
 	const struct mcp251xfd_priv *priv;
-	u32 timestamp = 0;
+	u32 ts_raw = 0;
 	int err;
 
 	priv = container_of(cc, struct mcp251xfd_priv, cc);
-	err = mcp251xfd_get_timestamp(priv, &timestamp);
+	err = mcp251xfd_get_timestamp_raw(priv, &ts_raw);
 	if (err)
 		netdev_err(priv->ndev,
 			   "Error %d while reading timestamp. HW timestamps may be inaccurate.",
 			   err);
 
-	return timestamp;
+	return ts_raw;
 }
 
 static void mcp251xfd_timestamp_work(struct work_struct *work)
@@ -39,21 +39,11 @@ static void mcp251xfd_timestamp_work(struct work_struct *work)
 			      MCP251XFD_TIMESTAMP_WORK_DELAY_SEC * HZ);
 }
 
-void mcp251xfd_skb_set_timestamp(const struct mcp251xfd_priv *priv,
-				 struct sk_buff *skb, u32 timestamp)
-{
-	struct skb_shared_hwtstamps *hwtstamps = skb_hwtstamps(skb);
-	u64 ns;
-
-	ns = timecounter_cyc2time(&priv->tc, timestamp);
-	hwtstamps->hwtstamp = ns_to_ktime(ns);
-}
-
 void mcp251xfd_timestamp_init(struct mcp251xfd_priv *priv)
 {
 	struct cyclecounter *cc = &priv->cc;
 
-	cc->read = mcp251xfd_timestamp_read;
+	cc->read = mcp251xfd_timestamp_raw_read;
 	cc->mask = CYCLECOUNTER_MASK(32);
 	cc->shift = 1;
 	cc->mult = clocksource_hz2mult(priv->can.clock.freq, cc->shift);
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 2b0309fedfac..3c410c543dc8 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -2,7 +2,7 @@
  *
  * mcp251xfd - Microchip MCP251xFD Family CAN controller driver
  *
- * Copyright (c) 2019, 2020, 2021 Pengutronix,
+ * Copyright (c) 2019, 2020, 2021, 2023 Pengutronix,
  *               Marc Kleine-Budde <kernel@pengutronix.de>
  * Copyright (c) 2019 Martin Sperl <kernel@martin.sperl.org>
  */
@@ -786,10 +786,27 @@ mcp251xfd_spi_cmd_write(const struct mcp251xfd_priv *priv,
 	return data;
 }
 
-static inline int mcp251xfd_get_timestamp(const struct mcp251xfd_priv *priv,
-					  u32 *timestamp)
+static inline int mcp251xfd_get_timestamp_raw(const struct mcp251xfd_priv *priv,
+					      u32 *ts_raw)
 {
-	return regmap_read(priv->map_reg, MCP251XFD_REG_TBC, timestamp);
+	return regmap_read(priv->map_reg, MCP251XFD_REG_TBC, ts_raw);
+}
+
+static inline void mcp251xfd_skb_set_timestamp(struct sk_buff *skb, u64 ns)
+{
+	struct skb_shared_hwtstamps *hwtstamps = skb_hwtstamps(skb);
+
+	hwtstamps->hwtstamp = ns_to_ktime(ns);
+}
+
+static inline
+void mcp251xfd_skb_set_timestamp_raw(const struct mcp251xfd_priv *priv,
+				     struct sk_buff *skb, u32 ts_raw)
+{
+	u64 ns;
+
+	ns = timecounter_cyc2time(&priv->tc, ts_raw);
+	mcp251xfd_skb_set_timestamp(skb, ns);
 }
 
 static inline u16 mcp251xfd_get_tef_obj_addr(u8 n)
@@ -928,8 +945,6 @@ void mcp251xfd_ring_free(struct mcp251xfd_priv *priv);
 int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv);
 int mcp251xfd_handle_rxif(struct mcp251xfd_priv *priv);
 int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv);
-void mcp251xfd_skb_set_timestamp(const struct mcp251xfd_priv *priv,
-				 struct sk_buff *skb, u32 timestamp);
 void mcp251xfd_timestamp_init(struct mcp251xfd_priv *priv);
 void mcp251xfd_timestamp_stop(struct mcp251xfd_priv *priv);
 
-- 
2.39.0


