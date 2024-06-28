Return-Path: <linux-can+bounces-886-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D4B91C847
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 23:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF799B22A71
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 21:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F5B8288C;
	Fri, 28 Jun 2024 21:41:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36D080624
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 21:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719610888; cv=none; b=K+G+VxsIxZDNTTKcEe4f2PH/zH7kFbyEf/ODUE554LVXb7oFpi8E8Y7ryCHiVvI628QmOLMum3VDPRoTrQEsbrSoTz89HRR051QXi/VBM2dS9Z5ng+YEwUTy52LMkDKZZ2P386WItKCaZYdJUv9dPYHo7kvbJ5whL7JLa3/svFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719610888; c=relaxed/simple;
	bh=7fX6P9inXkmqbhQACtljPGU4NKsrF9QyK3s5rxirKho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PV7d4Bw/BW9HeuOKczXZuyjJcBb8iYnw+IgldHyKHZzxR1+j8gx55BNfiyejwZeX+1VQ0I9t/IkJZCsIMBLbbpP1YK9btubhNQjU3c6OaBdSyi4kNY5gAJIrx5bxWyf0DHI5jwTOqpycAsNFRey4mLZs5eDdmzXjh4jZE9apf+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNJLP-0001cn-PQ
	for linux-can@vger.kernel.org; Fri, 28 Jun 2024 23:41:23 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNJLN-005h4T-Sa
	for linux-can@vger.kernel.org; Fri, 28 Jun 2024 23:41:21 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 91FBE2F60CA
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 21:41:21 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 8DCE82F6081;
	Fri, 28 Jun 2024 21:41:18 +0000 (UTC)
Received: from [10.11.86.119] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 504e4af3;
	Fri, 28 Jun 2024 21:41:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 28 Jun 2024 23:40:28 +0200
Subject: [PATCH v4 4/9] can: mcp251xfd: clarify the meaning of timestamp
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240628-mcp251xfd-workaround-erratum-6-v4-4-53586f168524@pengutronix.de>
References: <20240628-mcp251xfd-workaround-erratum-6-v4-0-53586f168524@pengutronix.de>
In-Reply-To: <20240628-mcp251xfd-workaround-erratum-6-v4-0-53586f168524@pengutronix.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 =?utf-8?q?Stefan_Alth=C3=B6fer?= <Stefan.Althoefer@janztec.com>, 
 kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=openpgp-sha256; l=10460; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=7fX6P9inXkmqbhQACtljPGU4NKsrF9QyK3s5rxirKho=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmfy3yCrACX4yR26lcJa5My4Hpz8dyL5gHBOWfJ
 sJt83ZbpSGJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZn8t8gAKCRAoOKI+ei28
 bxakB/9Xe1v5HVamxFMqgC45yRrNva3PbsHQ+yMkEfOBO5x7BgJJW1Wa3oZVUAr6QYvKSLcf/1Z
 HmGv71IdT5fKuks420P4KaLJs8RFVTdiN6N5H8Q2BWOVeWXP/odm1b2hcZhrQ8tdgJDv2UK2Otg
 wki9XsYGXZKAXFuA7gd3znXwKVuN2W47XxDupdSJDzZYEy1Pj1inIuJVLhWXSFl5vi535/Dbdnm
 40yTl0SyfAFiasnjVd+CrYnuSi6++08FGxI248n42Jn3mpFaoUSj8zsG1pRM+7z/VhYQf0MrJGk
 K6RMhJhB6z4WcGmsx613N7hfUPw/XO+GOZe5Bbmx2Zu9P8UQ
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

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
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     | 28 +++++++++++-----------
 drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c       |  2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c      |  2 +-
 .../net/can/spi/mcp251xfd/mcp251xfd-timestamp.c    | 22 +++++------------
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h          | 27 ++++++++++++++++-----
 5 files changed, 43 insertions(+), 38 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index e8e11c32cfda..3e7526274e34 100644
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
@@ -870,18 +870,18 @@ static int mcp251xfd_get_berr_counter(const struct net_device *ndev,
 
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
@@ -892,7 +892,7 @@ static int mcp251xfd_handle_rxovif(struct mcp251xfd_priv *priv)
 	struct mcp251xfd_rx_ring *ring;
 	struct sk_buff *skb;
 	struct can_frame *cf;
-	u32 timestamp, rxovif;
+	u32 ts_raw, rxovif;
 	int err, i;
 
 	stats->rx_over_errors++;
@@ -927,14 +927,14 @@ static int mcp251xfd_handle_rxovif(struct mcp251xfd_priv *priv)
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
 
@@ -951,12 +951,12 @@ static int mcp251xfd_handle_txatif(struct mcp251xfd_priv *priv)
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
 
@@ -1038,8 +1038,8 @@ static int mcp251xfd_handle_ivmif(struct mcp251xfd_priv *priv)
 	if (!cf)
 		return 0;
 
-	mcp251xfd_skb_set_timestamp(priv, skb, timestamp);
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	mcp251xfd_skb_set_timestamp_raw(priv, skb, ts_raw);
+	err = can_rx_offload_queue_timestamp(&priv->offload, skb, ts_raw);
 	if (err)
 		stats->rx_fifo_errors++;
 
@@ -1052,7 +1052,7 @@ static int mcp251xfd_handle_cerrif(struct mcp251xfd_priv *priv)
 	struct sk_buff *skb;
 	struct can_frame *cf = NULL;
 	enum can_state new_state, rx_state, tx_state;
-	u32 trec, timestamp;
+	u32 trec, ts_raw;
 	int err;
 
 	err = regmap_read(priv->map_reg, MCP251XFD_REG_TREC, &trec);
@@ -1082,7 +1082,7 @@ static int mcp251xfd_handle_cerrif(struct mcp251xfd_priv *priv)
 	/* The skb allocation might fail, but can_change_state()
 	 * handles cf == NULL.
 	 */
-	skb = mcp251xfd_alloc_can_err_skb(priv, &cf, &timestamp);
+	skb = mcp251xfd_alloc_can_err_skb(priv, &cf, &ts_raw);
 	can_change_state(priv->ndev, cf, tx_state, rx_state);
 
 	if (new_state == CAN_STATE_BUS_OFF) {
@@ -1113,7 +1113,7 @@ static int mcp251xfd_handle_cerrif(struct mcp251xfd_priv *priv)
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
index ee7028c027b5..4bc8d71fc491 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
@@ -109,7 +109,7 @@ mcp251xfd_handle_tefif_one(struct mcp251xfd_priv *priv,
 	tef_tail = mcp251xfd_get_tef_tail(priv);
 	skb = priv->can.echo_skb[tef_tail];
 	if (skb)
-		mcp251xfd_skb_set_timestamp(priv, skb, hw_tef_obj->ts);
+		mcp251xfd_skb_set_timestamp_raw(priv, skb, hw_tef_obj->ts);
 	stats->tx_bytes +=
 		can_rx_offload_get_echo_skb_queue_timestamp(&priv->offload,
 							    tef_tail, hw_tef_obj->ts,
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
index 7bbf4603038b..202ca0d24d03 100644
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
index d6f6b3182e6a..4d31689d73c8 100644
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
@@ -809,10 +809,27 @@ mcp251xfd_spi_cmd_write(const struct mcp251xfd_priv *priv,
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
@@ -951,8 +968,6 @@ void mcp251xfd_ring_free(struct mcp251xfd_priv *priv);
 int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv);
 int mcp251xfd_handle_rxif(struct mcp251xfd_priv *priv);
 int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv);
-void mcp251xfd_skb_set_timestamp(const struct mcp251xfd_priv *priv,
-				 struct sk_buff *skb, u32 timestamp);
 void mcp251xfd_timestamp_init(struct mcp251xfd_priv *priv);
 void mcp251xfd_timestamp_start(struct mcp251xfd_priv *priv);
 void mcp251xfd_timestamp_stop(struct mcp251xfd_priv *priv);

-- 
2.43.0



