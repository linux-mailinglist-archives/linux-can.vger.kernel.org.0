Return-Path: <linux-can+bounces-2589-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3721EA08F61
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 12:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301FC188DA2D
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 11:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB78920E305;
	Fri, 10 Jan 2025 11:27:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B31620CCDE
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508449; cv=none; b=UORz+MS1AXLHMoqhd8baFHHw4y0S40lCcNaxQ3z/jjcDbmeyAvOQGNeHDqdFeQ1jKK8r28j9bbg3nmotED004IuuVL0SG6BZ4j4AknI0aIA93wCLxjpUdVUAeodj0cddILp+SaIYvhOozlJPPnYr2ZbQkzOfMGSWuOZghS+4CZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508449; c=relaxed/simple;
	bh=1+cqpmdYF3RWxdDfLOIh10HJEiaOXWwi47Kj+fr2RDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqkMKpniQUJhU5cIU/kRVVMVdMKXV5YX7WD1UA+qIyth0KVgApWbWPsnTquHs+q0qyGmcpwDTCnNMsRKmN1n4IDWEsJlN0oSuEoTh7vj2E6OVABc5Lo5M+Qfw/kejzOqs4WVH3oh41ERKV9xRrIw6q6aqpom8ztHiYcjkZDFrZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAg-00054S-CY
	for linux-can@vger.kernel.org; Fri, 10 Jan 2025 12:27:22 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAd-0009iH-0q
	for linux-can@vger.kernel.org;
	Fri, 10 Jan 2025 12:27:19 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id EA7873A4619
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 11:27:18 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 691743A45AB;
	Fri, 10 Jan 2025 11:27:15 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 6c33d6c1;
	Fri, 10 Jan 2025 11:27:14 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 15/18] can: kvaser_usb: Update stats and state even if alloc_can_err_skb() fails
Date: Fri, 10 Jan 2025 12:04:23 +0100
Message-ID: <20250110112712.3214173-16-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250110112712.3214173-1-mkl@pengutronix.de>
References: <20250110112712.3214173-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Ensure statistics, error counters, and CAN state are updated consistently,
even when alloc_can_err_skb() fails during state changes or error message
frame reception.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20241230142645.128244-1-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 124 +++++++-----------
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  |  31 ++---
 2 files changed, 60 insertions(+), 95 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 3764b263add3..5ec8b300bebf 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -926,6 +926,42 @@ kvaser_usb_hydra_bus_status_to_can_state(const struct kvaser_usb_net_priv *priv,
 	}
 }
 
+static void kvaser_usb_hydra_change_state(struct kvaser_usb_net_priv *priv,
+					  const struct can_berr_counter *bec,
+					  struct can_frame *cf,
+					  enum can_state new_state)
+{
+	struct net_device *netdev = priv->netdev;
+	enum can_state old_state = priv->can.state;
+	enum can_state tx_state, rx_state;
+
+	tx_state = (bec->txerr >= bec->rxerr) ?
+				new_state : CAN_STATE_ERROR_ACTIVE;
+	rx_state = (bec->txerr <= bec->rxerr) ?
+				new_state : CAN_STATE_ERROR_ACTIVE;
+	can_change_state(netdev, cf, tx_state, rx_state);
+
+	if (new_state == CAN_STATE_BUS_OFF && old_state < CAN_STATE_BUS_OFF) {
+		if (priv->can.restart_ms == 0)
+			kvaser_usb_hydra_send_simple_cmd_async(priv, CMD_STOP_CHIP_REQ);
+
+		can_bus_off(netdev);
+	}
+
+	if (priv->can.restart_ms &&
+	    old_state >= CAN_STATE_BUS_OFF &&
+	    new_state < CAN_STATE_BUS_OFF) {
+		priv->can.can_stats.restarts++;
+		if (cf)
+			cf->can_id |= CAN_ERR_RESTARTED;
+	}
+	if (cf && new_state != CAN_STATE_BUS_OFF) {
+		cf->can_id |= CAN_ERR_CNT;
+		cf->data[6] = bec->txerr;
+		cf->data[7] = bec->rxerr;
+	}
+}
+
 static void kvaser_usb_hydra_update_state(struct kvaser_usb_net_priv *priv,
 					  u8 bus_status,
 					  const struct can_berr_counter *bec)
@@ -951,41 +987,11 @@ static void kvaser_usb_hydra_update_state(struct kvaser_usb_net_priv *priv,
 		return;
 
 	skb = alloc_can_err_skb(netdev, &cf);
-	if (skb) {
-		enum can_state tx_state, rx_state;
-
-		tx_state = (bec->txerr >= bec->rxerr) ?
-					new_state : CAN_STATE_ERROR_ACTIVE;
-		rx_state = (bec->txerr <= bec->rxerr) ?
-					new_state : CAN_STATE_ERROR_ACTIVE;
-		can_change_state(netdev, cf, tx_state, rx_state);
-	}
-
-	if (new_state == CAN_STATE_BUS_OFF && old_state < CAN_STATE_BUS_OFF) {
-		if (!priv->can.restart_ms)
-			kvaser_usb_hydra_send_simple_cmd_async
-						(priv, CMD_STOP_CHIP_REQ);
-
-		can_bus_off(netdev);
-	}
-
-	if (!skb) {
+	kvaser_usb_hydra_change_state(priv, bec, cf, new_state);
+	if (skb)
+		netif_rx(skb);
+	else
 		netdev_warn(netdev, "No memory left for err_skb\n");
-		return;
-	}
-
-	if (priv->can.restart_ms &&
-	    old_state >= CAN_STATE_BUS_OFF &&
-	    new_state < CAN_STATE_BUS_OFF)
-		priv->can.can_stats.restarts++;
-
-	if (new_state != CAN_STATE_BUS_OFF) {
-		cf->can_id |= CAN_ERR_CNT;
-		cf->data[6] = bec->txerr;
-		cf->data[7] = bec->rxerr;
-	}
-
-	netif_rx(skb);
 }
 
 static void kvaser_usb_hydra_state_event(const struct kvaser_usb *dev,
@@ -1080,7 +1086,6 @@ kvaser_usb_hydra_error_frame(struct kvaser_usb_net_priv *priv,
 	struct net_device_stats *stats = &netdev->stats;
 	struct can_frame *cf;
 	struct sk_buff *skb;
-	struct skb_shared_hwtstamps *shhwtstamps;
 	struct can_berr_counter bec;
 	enum can_state new_state, old_state;
 	u8 bus_status;
@@ -1097,51 +1102,22 @@ kvaser_usb_hydra_error_frame(struct kvaser_usb_net_priv *priv,
 						 &new_state);
 
 	skb = alloc_can_err_skb(netdev, &cf);
+	if (new_state != old_state)
+		kvaser_usb_hydra_change_state(priv, &bec, cf, new_state);
 
-	if (new_state != old_state) {
-		if (skb) {
-			enum can_state tx_state, rx_state;
+	if (skb) {
+		struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
 
-			tx_state = (bec.txerr >= bec.rxerr) ?
-					new_state : CAN_STATE_ERROR_ACTIVE;
-			rx_state = (bec.txerr <= bec.rxerr) ?
-					new_state : CAN_STATE_ERROR_ACTIVE;
-
-			can_change_state(netdev, cf, tx_state, rx_state);
-
-			if (priv->can.restart_ms &&
-			    old_state >= CAN_STATE_BUS_OFF &&
-			    new_state < CAN_STATE_BUS_OFF)
-				cf->can_id |= CAN_ERR_RESTARTED;
-		}
-
-		if (new_state == CAN_STATE_BUS_OFF) {
-			if (!priv->can.restart_ms)
-				kvaser_usb_hydra_send_simple_cmd_async
-						(priv, CMD_STOP_CHIP_REQ);
-
-			can_bus_off(netdev);
-		}
-	}
-
-	if (!skb) {
-		stats->rx_dropped++;
-		netdev_warn(netdev, "No memory left for err_skb\n");
-		return;
-	}
-
-	shhwtstamps = skb_hwtstamps(skb);
-	shhwtstamps->hwtstamp = hwtstamp;
-
-	cf->can_id |= CAN_ERR_BUSERROR;
-	if (new_state != CAN_STATE_BUS_OFF) {
-		cf->can_id |= CAN_ERR_CNT;
+		shhwtstamps->hwtstamp = hwtstamp;
+		cf->can_id |= CAN_ERR_BUSERROR | CAN_ERR_CNT;
 		cf->data[6] = bec.txerr;
 		cf->data[7] = bec.rxerr;
+		netif_rx(skb);
+	} else {
+		stats->rx_dropped++;
+		netdev_warn(netdev, "No memory left for err_skb\n");
 	}
 
-	netif_rx(skb);
-
 	priv->bec.txerr = bec.txerr;
 	priv->bec.rxerr = bec.rxerr;
 }
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 6b9122ab1464..0491b4a6d8e8 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -1121,8 +1121,6 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 				     const struct kvaser_usb_err_summary *es)
 {
 	struct can_frame *cf;
-	struct can_frame tmp_cf = { .can_id = CAN_ERR_FLAG,
-				    .len = CAN_ERR_DLC };
 	struct sk_buff *skb;
 	struct net_device_stats *stats;
 	struct kvaser_usb_net_priv *priv;
@@ -1143,18 +1141,9 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 	if (!netif_running(priv->netdev))
 		return;
 
-	/* Update all of the CAN interface's state and error counters before
-	 * trying any memory allocation that can actually fail with -ENOMEM.
-	 *
-	 * We send a temporary stack-allocated error CAN frame to
-	 * can_change_state() for the very same reason.
-	 *
-	 * TODO: Split can_change_state() responsibility between updating the
-	 * CAN interface's state and counters, and the setting up of CAN error
-	 * frame ID and data to userspace. Remove stack allocation afterwards.
-	 */
 	old_state = priv->can.state;
-	kvaser_usb_leaf_rx_error_update_can_state(priv, es, &tmp_cf);
+	skb = alloc_can_err_skb(priv->netdev, &cf);
+	kvaser_usb_leaf_rx_error_update_can_state(priv, es, cf);
 	new_state = priv->can.state;
 
 	/* If there are errors, request status updates periodically as we do
@@ -1168,13 +1157,6 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 		schedule_delayed_work(&leaf->chip_state_req_work,
 				      msecs_to_jiffies(500));
 
-	skb = alloc_can_err_skb(priv->netdev, &cf);
-	if (!skb) {
-		stats->rx_dropped++;
-		return;
-	}
-	memcpy(cf, &tmp_cf, sizeof(*cf));
-
 	if (new_state != old_state) {
 		if (es->status &
 		    (M16C_STATE_BUS_OFF | M16C_STATE_BUS_RESET)) {
@@ -1187,11 +1169,18 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 		if (priv->can.restart_ms &&
 		    old_state == CAN_STATE_BUS_OFF &&
 		    new_state < CAN_STATE_BUS_OFF) {
-			cf->can_id |= CAN_ERR_RESTARTED;
+			if (cf)
+				cf->can_id |= CAN_ERR_RESTARTED;
 			netif_carrier_on(priv->netdev);
 		}
 	}
 
+	if (!skb) {
+		stats->rx_dropped++;
+		netdev_warn(priv->netdev, "No memory left for err_skb\n");
+		return;
+	}
+
 	switch (dev->driver_info->family) {
 	case KVASER_LEAF:
 		if (es->leaf.error_factor) {
-- 
2.45.2



