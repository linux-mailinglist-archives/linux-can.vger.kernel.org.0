Return-Path: <linux-can+bounces-2587-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9C4A08F55
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 12:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5974188D20C
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 11:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233A220C49E;
	Fri, 10 Jan 2025 11:27:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9614B20C00C
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508448; cv=none; b=narwFP75JkFHiXmE5zMrYwfsXRvKZTmHAAg4lOG5zN6wmxvf5PfBhMtf+UOtTcK8hCjAz1LnC2uiVlCWbOn4jm6MjD8sX7XpFdakAMPvueFSBhOL6hAh1c9qbuRSqCyd9ZVly8Y0rxIFGubwC3iUgWkjCt4ZtXERHEE/DShupKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508448; c=relaxed/simple;
	bh=h210aFJ8XtOBWwum2XpoLB0dXkBYCGJOjOpeqWcShe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jIaJynHT6yHGdagp8/vVL3LZSMAFercF+WMAI+Xh1wFbrXs04y64DDr0hIXLj3RlWKqzDWywFZy6LHxV2KCT2Rlofe5PxzvZKG/5Se+cyQ+NrJA7/c9LLuc+Iee2UHW9L/oNn3dQr9HnrM0uTdzfAo+5TjnrKhGSns+fGRGwwsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAg-00057h-To
	for linux-can@vger.kernel.org; Fri, 10 Jan 2025 12:27:22 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAe-0009jP-33
	for linux-can@vger.kernel.org;
	Fri, 10 Jan 2025 12:27:20 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 9C3913A4627
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 11:27:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 774993A45AE;
	Fri, 10 Jan 2025 11:27:15 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 618ddf05;
	Fri, 10 Jan 2025 11:27:14 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 16/18] can: kvaser_usb: Add support for CAN_CTRLMODE_BERR_REPORTING
Date: Fri, 10 Jan 2025 12:04:24 +0100
Message-ID: <20250110112712.3214173-17-mkl@pengutronix.de>
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

Add support for CAN_CTRLMODE_BERR_REPORTING,
allowing Bus Error Reporting to be enabled or disabled.
Previously, Bus Error Reporting was always active.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20241230142645.128244-2-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  |  3 +-
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 29 ++++++++++---------
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 13 +++++----
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 7d12776ab63e..dcb0bcbe0565 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -818,7 +818,8 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 	init_completion(&priv->stop_comp);
 	init_completion(&priv->flush_comp);
 	init_completion(&priv->get_busparams_comp);
-	priv->can.ctrlmode_supported = CAN_CTRLMODE_CC_LEN8_DLC;
+	priv->can.ctrlmode_supported = CAN_CTRLMODE_CC_LEN8_DLC |
+				       CAN_CTRLMODE_BERR_REPORTING;
 
 	priv->dev = dev;
 	priv->netdev = netdev;
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 5ec8b300bebf..8e88b5917796 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -1084,8 +1084,8 @@ kvaser_usb_hydra_error_frame(struct kvaser_usb_net_priv *priv,
 {
 	struct net_device *netdev = priv->netdev;
 	struct net_device_stats *stats = &netdev->stats;
-	struct can_frame *cf;
-	struct sk_buff *skb;
+	struct can_frame *cf = NULL;
+	struct sk_buff *skb = NULL;
 	struct can_berr_counter bec;
 	enum can_state new_state, old_state;
 	u8 bus_status;
@@ -1101,21 +1101,24 @@ kvaser_usb_hydra_error_frame(struct kvaser_usb_net_priv *priv,
 	kvaser_usb_hydra_bus_status_to_can_state(priv, bus_status, &bec,
 						 &new_state);
 
-	skb = alloc_can_err_skb(netdev, &cf);
+	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
+		skb = alloc_can_err_skb(netdev, &cf);
 	if (new_state != old_state)
 		kvaser_usb_hydra_change_state(priv, &bec, cf, new_state);
 
-	if (skb) {
-		struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
+	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) {
+		if (skb) {
+			struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
 
-		shhwtstamps->hwtstamp = hwtstamp;
-		cf->can_id |= CAN_ERR_BUSERROR | CAN_ERR_CNT;
-		cf->data[6] = bec.txerr;
-		cf->data[7] = bec.rxerr;
-		netif_rx(skb);
-	} else {
-		stats->rx_dropped++;
-		netdev_warn(netdev, "No memory left for err_skb\n");
+			shhwtstamps->hwtstamp = hwtstamp;
+			cf->can_id |= CAN_ERR_BUSERROR | CAN_ERR_CNT;
+			cf->data[6] = bec.txerr;
+			cf->data[7] = bec.rxerr;
+			netif_rx(skb);
+		} else {
+			stats->rx_dropped++;
+			netdev_warn(netdev, "No memory left for err_skb\n");
+		}
 	}
 
 	priv->bec.txerr = bec.txerr;
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 0491b4a6d8e8..6a45adcc45bd 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -1120,8 +1120,8 @@ kvaser_usb_leaf_rx_error_update_can_state(struct kvaser_usb_net_priv *priv,
 static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 				     const struct kvaser_usb_err_summary *es)
 {
-	struct can_frame *cf;
-	struct sk_buff *skb;
+	struct can_frame *cf = NULL;
+	struct sk_buff *skb = NULL;
 	struct net_device_stats *stats;
 	struct kvaser_usb_net_priv *priv;
 	struct kvaser_usb_net_leaf_priv *leaf;
@@ -1142,7 +1142,8 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 		return;
 
 	old_state = priv->can.state;
-	skb = alloc_can_err_skb(priv->netdev, &cf);
+	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
+		skb = alloc_can_err_skb(priv->netdev, &cf);
 	kvaser_usb_leaf_rx_error_update_can_state(priv, es, cf);
 	new_state = priv->can.state;
 
@@ -1176,8 +1177,10 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 	}
 
 	if (!skb) {
-		stats->rx_dropped++;
-		netdev_warn(priv->netdev, "No memory left for err_skb\n");
+		if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) {
+			stats->rx_dropped++;
+			netdev_warn(priv->netdev, "No memory left for err_skb\n");
+		}
 		return;
 	}
 
-- 
2.45.2



