Return-Path: <linux-can+bounces-2586-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2ABA08F54
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 12:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21AE3AA314
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 11:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1293A20DD6E;
	Fri, 10 Jan 2025 11:27:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790DF20CCDD
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508447; cv=none; b=Mh5BA4CH+SbIbMd87+gi8CM8MCFumQwl71gXi1CWK/vftpZmixODitMix9HwiofuVPVPHc07Rw4++DRwxQI+rGoYVQLthBfls8n22mPFgnfgpBWNYrA0wUvLaKbKSYNrkR2B14i+XmtTns+K+mhPp1KNbUTzFdd8JuXxtfLOVos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508447; c=relaxed/simple;
	bh=krr6sS7la2UpKqKt7Ie9GkReuEOkMqeO6Ca8qaOau9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSQHF+QtVGuWLXk6WkwB3kC6oEgO2/19jXFcjT6WP/6/eT50YWGzu9PTnuGlXK+RymqzZvo9NkY8g12OBITn68/A+8u4Z1jyWPe72vYt4e3Ol5W/tvz9zVQVI9f2A13M7lkRdXq/Et6oK8vRmzsm19FfqxBLh+cL0YeCFlqFG/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAg-00055F-5N
	for linux-can@vger.kernel.org; Fri, 10 Jan 2025 12:27:22 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAd-0009iW-1d
	for linux-can@vger.kernel.org;
	Fri, 10 Jan 2025 12:27:19 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 2BFF03A461D
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 11:27:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 844BF3A45B0;
	Fri, 10 Jan 2025 11:27:15 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 6725e3bf;
	Fri, 10 Jan 2025 11:27:14 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 17/18] can: kvaser_pciefd: Update stats and state even if alloc_can_err_skb() fails
Date: Fri, 10 Jan 2025 12:04:25 +0100
Message-ID: <20250110112712.3214173-18-mkl@pengutronix.de>
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
Link: https://patch.msgid.link/20241230142645.128244-3-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 52 ++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index fee012b57f33..e12ff12c4ba3 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1234,11 +1234,15 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 }
 
 static void kvaser_pciefd_change_state(struct kvaser_pciefd_can *can,
+				       const struct can_berr_counter *bec,
 				       struct can_frame *cf,
 				       enum can_state new_state,
 				       enum can_state tx_state,
 				       enum can_state rx_state)
 {
+	enum can_state old_state;
+
+	old_state = can->can.state;
 	can_change_state(can->can.dev, cf, tx_state, rx_state);
 
 	if (new_state == CAN_STATE_BUS_OFF) {
@@ -1254,6 +1258,18 @@ static void kvaser_pciefd_change_state(struct kvaser_pciefd_can *can,
 			can_bus_off(ndev);
 		}
 	}
+	if (old_state == CAN_STATE_BUS_OFF &&
+	    new_state == CAN_STATE_ERROR_ACTIVE &&
+	    can->can.restart_ms) {
+		can->can.can_stats.restarts++;
+		if (cf)
+			cf->can_id |= CAN_ERR_RESTARTED;
+	}
+	if (cf && new_state != CAN_STATE_BUS_OFF) {
+		cf->can_id |= CAN_ERR_CNT;
+		cf->data[6] = bec->txerr;
+		cf->data[7] = bec->rxerr;
+	}
 }
 
 static void kvaser_pciefd_packet_to_state(struct kvaser_pciefd_rx_packet *p,
@@ -1299,14 +1315,7 @@ static int kvaser_pciefd_rx_error_frame(struct kvaser_pciefd_can *can,
 	kvaser_pciefd_packet_to_state(p, &bec, &new_state, &tx_state, &rx_state);
 	skb = alloc_can_err_skb(ndev, &cf);
 	if (new_state != old_state) {
-		kvaser_pciefd_change_state(can, cf, new_state, tx_state, rx_state);
-		if (old_state == CAN_STATE_BUS_OFF &&
-		    new_state == CAN_STATE_ERROR_ACTIVE &&
-		    can->can.restart_ms) {
-			can->can.can_stats.restarts++;
-			if (skb)
-				cf->can_id |= CAN_ERR_RESTARTED;
-		}
+		kvaser_pciefd_change_state(can, &bec, cf, new_state, tx_state, rx_state);
 	}
 
 	can->err_rep_cnt++;
@@ -1359,6 +1368,7 @@ static int kvaser_pciefd_handle_status_resp(struct kvaser_pciefd_can *can,
 {
 	struct can_berr_counter bec;
 	enum can_state old_state, new_state, tx_state, rx_state;
+	int ret = 0;
 
 	old_state = can->can.state;
 
@@ -1372,25 +1382,15 @@ static int kvaser_pciefd_handle_status_resp(struct kvaser_pciefd_can *can,
 		struct can_frame *cf;
 
 		skb = alloc_can_err_skb(ndev, &cf);
-		if (!skb) {
+		kvaser_pciefd_change_state(can, &bec, cf, new_state, tx_state, rx_state);
+		if (skb) {
+			kvaser_pciefd_set_skb_timestamp(can->kv_pcie, skb, p->timestamp);
+			netif_rx(skb);
+		} else {
 			ndev->stats.rx_dropped++;
-			return -ENOMEM;
+			netdev_warn(ndev, "No memory left for err_skb\n");
+			ret = -ENOMEM;
 		}
-
-		kvaser_pciefd_change_state(can, cf, new_state, tx_state, rx_state);
-		if (old_state == CAN_STATE_BUS_OFF &&
-		    new_state == CAN_STATE_ERROR_ACTIVE &&
-		    can->can.restart_ms) {
-			can->can.can_stats.restarts++;
-			cf->can_id |= CAN_ERR_RESTARTED;
-		}
-
-		kvaser_pciefd_set_skb_timestamp(can->kv_pcie, skb, p->timestamp);
-
-		cf->data[6] = bec.txerr;
-		cf->data[7] = bec.rxerr;
-
-		netif_rx(skb);
 	}
 	can->bec.txerr = bec.txerr;
 	can->bec.rxerr = bec.rxerr;
@@ -1398,7 +1398,7 @@ static int kvaser_pciefd_handle_status_resp(struct kvaser_pciefd_can *can,
 	if (bec.txerr || bec.rxerr)
 		mod_timer(&can->bec_poll_timer, KVASER_PCIEFD_BEC_POLL_FREQ);
 
-	return 0;
+	return ret;
 }
 
 static int kvaser_pciefd_handle_status_packet(struct kvaser_pciefd *pcie,
-- 
2.45.2



