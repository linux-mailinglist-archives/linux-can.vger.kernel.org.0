Return-Path: <linux-can+bounces-8285-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6W7UCErgUGrU6gIAu9opvQ
	(envelope-from <linux-can+bounces-8285-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 14:06:34 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D08F73A839
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 14:06:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8285-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-8285-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 247E63001392
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 12:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9493F54B4;
	Fri, 10 Jul 2026 12:06:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C493BC696;
	Fri, 10 Jul 2026 12:06:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783685188; cv=none; b=jxveRjVhG5wGePbFycJ4hXDIqKL0IAXBYcE/W4ecto5G0LAdZajOxX6lh2WSGjy0/DQ+iulZ1Ru5etiARYsTrOLd4SUItBFq2p8WctueVSxxzyP2PkPY646mgWiVDhzgP9u7aoYp8OMAzPtWkBUTUbDcBnLZ2jwWDJYcl54B1UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783685188; c=relaxed/simple;
	bh=MSQBMx5zpiHKFLhws3XUuZXLrjS4VTkDwO6oi6fjIdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sfrS0NK8BFf2Z/1G1jAsCHNKFAJET6tHTwS0WGPvlmgBV/qqGcPRVNLQpSKezCEl6RxUn//wZw4KyB6FW6LEkuFdPGF/fUm5gvwtkVjkysG66uWLF5lJkomDVvYk9o6QLUWs4DfN1k3R/RO+UuNpOmrvlONJIwOTvbBxJlO/TJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D2FFC201FD8;
	Fri, 10 Jul 2026 14:06:22 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wi9zq-0014gJ-2M;
	Fri, 10 Jul 2026 14:06:22 +0200
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3C16E56505D;
	Fri, 10 Jul 2026 11:50:42 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 10 Jul 2026 13:50:39 +0200
Subject: [PATCH can-next v2] can: m_can: switch to rx-offload
 implementation
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-m_can-rx-offload-v2-1-aa6597eb194e@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAI7cUGoC/3WNwQ6CMBBEf8Xs2ZpSVMCT/2GIWekW1mhL2kJqC
 P8u4NnjZN68mSCQZwpw2U3gaeTAzi5B7XfQdGhbEqyXDEqqsyxkJd73Bq3wSThjXg61QKXKk5S
 6MjnCMus9GU6b8gYraylFqH9NGB5PauJqXNmOQ3T+s72P2bb4fzRmIhNocjJY0lEV6tqTbYfon
 eV00AT1PM9fxupiY9EAAAA=
X-Change-ID: 20260709-m_can-rx-offload-a228500d9f3a
To: Markus Schneider-Pargmann <msp@baylibre.com>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12791; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=MSQBMx5zpiHKFLhws3XUuZXLrjS4VTkDwO6oi6fjIdE=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsgKuDMh6mnekWtz9naJ3GllSwjym3HoX02x4Mq3/tqzk
 oS+/9wv3FHKwiDGxSArpsiy9McJRYFAh9LelwmTYOawMoEMYeDiFICJhIUw/LN637w76OE94Qn/
 pZh2r+4UrZDu+rZLnLPs1gKlSeIFD+wZGeau/L56x6+Nnza+UoxTt6x8OP/publ3F8+vlW+f7nq
 aP4EZAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8285-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS(0.00)[m:msp@baylibre.com,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kernel@pengutronix.de,m:mkl@pengutronix.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,pengutronix.de:from_mime,pengutronix.de:email,pengutronix.de:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,baylibre.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D08F73A839

The current m_can driver uses NAPI for mmio devices to handle RX'ed CAN
frames, the RX IRQ is disabled and a NAPI poll is scheduled. Then in
m_can_poll() the RX'ed CAN frames are read from the device.

The driver already uses rx-offload for SPI devices like the tcan4x5x,
indicated by struct m_can_classdev::is_peripheral being set.

This approach has 2 drawbacks:

- Under high system load it might take too long from the initial RX IRQ to
  the NAPI poll function to run. This causes RX buffer overflows.
- The driver contains several checks if it handles a peripheral or a memory
  mapped device, that makes maintenance harder.

Convert the driver to unconditionally call m_can_rx_handler() from the IRQ
handler (m_can_interrupt_handler()), which reads the RX'ed CAN frames from
the hardware and adds it to a list sorted by RX timestamp. This list of
RX'ed SKBs is then passed to the networking stack in a later NAPI context.

Remove all manual napi handling from the driver and keep the
can_rx_offload_*().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v2:
- m_can_receive_skb(): remove double accounting of RX packets (found by sashiko)
- remove obsolete struct m_can_classdev::napi (found by sashiko)
- m_can_do_rx_poll(): remove quota, read all RX'ed messages (found by sashiko)
- Link to v1: https://patch.msgid.link/20260709-m_can-rx-offload-v1-1-af3efa8e4272@pengutronix.de

To: Markus Schneider-Pargmann <msp@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/can/m_can/m_can.c | 151 +++++++++++-------------------------------
 drivers/net/can/m_can/m_can.h |   2 -
 2 files changed, 38 insertions(+), 115 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index eb856547ae7d..866c4b501dad 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -530,26 +530,17 @@ static void m_can_clean(struct net_device *net)
 	spin_unlock_irqrestore(&cdev->tx_handling_spinlock, irqflags);
 }
 
-/* For peripherals, pass skb to rx-offload, which will push skb from
- * napi. For non-peripherals, RX is done in napi already, so push
- * directly. timestamp is used to ensure good skb ordering in
- * rx-offload and is ignored for non-peripherals.
- */
 static void m_can_receive_skb(struct m_can_classdev *cdev,
 			      struct sk_buff *skb,
 			      u32 timestamp)
 {
-	if (cdev->is_peripheral) {
-		struct net_device_stats *stats = &cdev->net->stats;
-		int err;
+	struct net_device_stats *stats = &cdev->net->stats;
+	int err;
 
-		err = can_rx_offload_queue_timestamp(&cdev->offload, skb,
-						     timestamp);
-		if (err)
-			stats->rx_fifo_errors++;
-	} else {
-		netif_receive_skb(skb);
-	}
+	err = can_rx_offload_queue_timestamp(&cdev->offload, skb,
+					     timestamp);
+	if (err)
+		stats->rx_fifo_errors++;
 }
 
 static int m_can_read_fifo(struct net_device *dev, u32 fgi)
@@ -600,10 +591,7 @@ static int m_can_read_fifo(struct net_device *dev, u32 fgi)
 				      cf->data, DIV_ROUND_UP(cf->len, 4));
 		if (err)
 			goto out_free_skb;
-
-		stats->rx_bytes += cf->len;
 	}
-	stats->rx_packets++;
 
 	timestamp = FIELD_GET(RX_BUF_RXTS_MASK, fifo_header.dlc) << 16;
 
@@ -618,10 +606,9 @@ static int m_can_read_fifo(struct net_device *dev, u32 fgi)
 	return err;
 }
 
-static int m_can_do_rx_poll(struct net_device *dev, int quota)
+static int m_can_do_rx_poll(struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
-	u32 pkts = 0;
 	u32 rxfs;
 	u32 rx_count;
 	u32 fgi;
@@ -638,13 +625,11 @@ static int m_can_do_rx_poll(struct net_device *dev, int quota)
 	rx_count = FIELD_GET(RXFS_FFL_MASK, rxfs);
 	fgi = FIELD_GET(RXFS_FGI_MASK, rxfs);
 
-	for (i = 0; i < rx_count && quota > 0; ++i) {
+	for (i = 0; i < rx_count; ++i) {
 		err = m_can_read_fifo(dev, fgi);
 		if (err)
 			break;
 
-		quota--;
-		pkts++;
 		ack_fgi = fgi;
 		fgi = (++fgi >= cdev->mcfg[MRAM_RXF0].num ? 0 : fgi);
 	}
@@ -652,10 +637,7 @@ static int m_can_do_rx_poll(struct net_device *dev, int quota)
 	if (ack_fgi != -1)
 		m_can_write(cdev, M_CAN_RXF0A, ack_fgi);
 
-	if (err)
-		return err;
-
-	return pkts;
+	return err;
 }
 
 static int m_can_handle_lost_msg(struct net_device *dev)
@@ -678,8 +660,7 @@ static int m_can_handle_lost_msg(struct net_device *dev)
 	frame->can_id |= CAN_ERR_CRTL;
 	frame->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 
-	if (cdev->is_peripheral)
-		timestamp = m_can_get_timestamp(cdev);
+	timestamp = m_can_get_timestamp(cdev);
 
 	m_can_receive_skb(cdev, skb, timestamp);
 
@@ -750,8 +731,7 @@ static int m_can_handle_lec_err(struct net_device *dev,
 	if (unlikely(!skb))
 		return 0;
 
-	if (cdev->is_peripheral)
-		timestamp = m_can_get_timestamp(cdev);
+	timestamp = m_can_get_timestamp(cdev);
 
 	m_can_receive_skb(cdev, skb, timestamp);
 
@@ -883,8 +863,7 @@ static int m_can_handle_state_change(struct net_device *dev,
 		break;
 	}
 
-	if (cdev->is_peripheral)
-		timestamp = m_can_get_timestamp(cdev);
+	timestamp = m_can_get_timestamp(cdev);
 
 	m_can_receive_skb(cdev, skb, timestamp);
 
@@ -973,8 +952,7 @@ static int m_can_handle_protocol_error(struct net_device *dev, u32 irqstatus)
 		return 0;
 	}
 
-	if (cdev->is_peripheral)
-		timestamp = m_can_get_timestamp(cdev);
+	timestamp = m_can_get_timestamp(cdev);
 
 	m_can_receive_skb(cdev, skb, timestamp);
 
@@ -1055,7 +1033,7 @@ static int m_can_rx_handler(struct net_device *dev, int quota, u32 irqstatus)
 						     m_can_read(cdev, M_CAN_PSR));
 
 	if (irqstatus & IR_RF0N) {
-		rx_work_or_err = m_can_do_rx_poll(dev, (quota - work_done));
+		rx_work_or_err = m_can_do_rx_poll(dev);
 		if (rx_work_or_err < 0)
 			return rx_work_or_err;
 
@@ -1065,32 +1043,6 @@ static int m_can_rx_handler(struct net_device *dev, int quota, u32 irqstatus)
 	return work_done;
 }
 
-static int m_can_poll(struct napi_struct *napi, int quota)
-{
-	struct net_device *dev = napi->dev;
-	struct m_can_classdev *cdev = netdev_priv(dev);
-	int work_done;
-	u32 irqstatus;
-
-	irqstatus = cdev->irqstatus | m_can_read(cdev, M_CAN_IR);
-
-	work_done = m_can_rx_handler(dev, quota, irqstatus);
-
-	/* Don't re-enable interrupts if the driver had a fatal error
-	 * (e.g., FIFO read failure).
-	 */
-	if (work_done >= 0 && work_done < quota) {
-		napi_complete_done(napi, work_done);
-		m_can_enable_all_interrupts(cdev);
-	}
-
-	return work_done;
-}
-
-/* Echo tx skb and update net stats. Peripherals use rx-offload for
- * echo. timestamp is used for peripherals to ensure correct ordering
- * by rx-offload, and is ignored for non-peripherals.
- */
 static unsigned int m_can_tx_update_stats(struct m_can_classdev *cdev,
 					  unsigned int msg_mark, u32 timestamp)
 {
@@ -1098,14 +1050,11 @@ static unsigned int m_can_tx_update_stats(struct m_can_classdev *cdev,
 	struct net_device_stats *stats = &dev->stats;
 	unsigned int frame_len;
 
-	if (cdev->is_peripheral)
-		stats->tx_bytes +=
-			can_rx_offload_get_echo_skb_queue_timestamp(&cdev->offload,
-								    msg_mark,
-								    timestamp,
-								    &frame_len);
-	else
-		stats->tx_bytes += can_get_echo_skb(dev, msg_mark, &frame_len);
+	stats->tx_bytes +=
+		can_rx_offload_get_echo_skb_queue_timestamp(&cdev->offload,
+							    msg_mark,
+							    timestamp,
+							    &frame_len);
 
 	stats->tx_packets++;
 
@@ -1265,21 +1214,10 @@ static int m_can_interrupt_handler(struct m_can_classdev *cdev)
 	if (cdev->ops->clear_interrupts)
 		cdev->ops->clear_interrupts(cdev);
 
-	/* schedule NAPI in case of
-	 * - rx IRQ
-	 * - state change IRQ
-	 * - bus error IRQ and bus error reporting
-	 */
 	if (ir & (IR_RF0N | IR_RF0W | IR_ERR_ALL_30X)) {
-		cdev->irqstatus = ir;
-		if (!cdev->is_peripheral) {
-			m_can_disable_all_interrupts(cdev);
-			napi_schedule(&cdev->napi);
-		} else {
-			ret = m_can_rx_handler(dev, NAPI_POLL_WEIGHT, ir);
-			if (ret < 0)
-				return ret;
-		}
+		ret = m_can_rx_handler(dev, NAPI_POLL_WEIGHT, ir);
+		if (ret < 0)
+			return ret;
 	}
 
 	if (cdev->version == 30) {
@@ -1288,8 +1226,7 @@ static int m_can_interrupt_handler(struct m_can_classdev *cdev)
 			u32 timestamp = 0;
 			unsigned int frame_len;
 
-			if (cdev->is_peripheral)
-				timestamp = m_can_get_timestamp(cdev);
+			timestamp = m_can_get_timestamp(cdev);
 			frame_len = m_can_tx_update_stats(cdev, 0, timestamp);
 			m_can_finish_tx(cdev, 1, frame_len);
 		}
@@ -1304,6 +1241,8 @@ static int m_can_interrupt_handler(struct m_can_classdev *cdev)
 
 	if (cdev->is_peripheral)
 		can_rx_offload_threaded_irq_finish(&cdev->offload);
+	else
+		can_rx_offload_irq_finish(&cdev->offload);
 
 	return IRQ_HANDLED;
 }
@@ -1752,9 +1691,6 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
 	if (err)
 		return err;
 
-	if (!cdev->is_peripheral)
-		netif_napi_add(dev, &cdev->napi, m_can_poll);
-
 	/* Shared properties of all M_CAN versions */
 	cdev->version = m_can_version;
 	cdev->can.do_set_mode = m_can_set_mode;
@@ -1846,11 +1782,10 @@ static int m_can_close(struct net_device *dev)
 	if (cdev->is_peripheral) {
 		destroy_workqueue(cdev->tx_wq);
 		cdev->tx_wq = NULL;
-		can_rx_offload_disable(&cdev->offload);
-	} else {
-		napi_disable(&cdev->napi);
 	}
 
+	can_rx_offload_disable(&cdev->offload);
+
 	close_candev(dev);
 
 	reset_control_assert(cdev->rst);
@@ -2069,8 +2004,8 @@ static enum hrtimer_restart m_can_polling_timer(struct hrtimer *timer)
 
 	ret = m_can_interrupt_handler(cdev);
 
-	/* On error or if napi is scheduled to read, stop the timer */
-	if (ret < 0 || napi_is_scheduled(&cdev->napi))
+	/* On error stop the timer */
+	if (ret < 0)
 		return HRTIMER_NORESTART;
 
 	hrtimer_forward_now(timer, ms_to_ktime(HRTIMER_POLL_INTERVAL_MS));
@@ -2102,10 +2037,7 @@ static int m_can_open(struct net_device *dev)
 		goto out_reset_control_assert;
 	}
 
-	if (cdev->is_peripheral)
-		can_rx_offload_enable(&cdev->offload);
-	else
-		napi_enable(&cdev->napi);
+	can_rx_offload_enable(&cdev->offload);
 
 	/* register interrupt handler */
 	if (cdev->is_peripheral) {
@@ -2144,16 +2076,13 @@ static int m_can_open(struct net_device *dev)
 	return 0;
 
 exit_start_fail:
-	if (cdev->is_peripheral || dev->irq)
+	if (dev->irq)
 		free_irq(dev->irq, dev);
 exit_irq_fail:
 	if (cdev->is_peripheral)
 		destroy_workqueue(cdev->tx_wq);
 out_wq_fail:
-	if (cdev->is_peripheral)
-		can_rx_offload_disable(&cdev->offload);
-	else
-		napi_disable(&cdev->napi);
+	can_rx_offload_disable(&cdev->offload);
 	close_candev(dev);
 out_reset_control_assert:
 	reset_control_assert(cdev->rst);
@@ -2533,12 +2462,10 @@ int m_can_class_register(struct m_can_classdev *cdev)
 	if (ret)
 		goto clk_disable;
 
-	if (cdev->is_peripheral) {
-		ret = can_rx_offload_add_manual(cdev->net, &cdev->offload,
-						NAPI_POLL_WEIGHT);
-		if (ret)
-			goto out_reset_control_assert;
-	}
+	ret = can_rx_offload_add_manual(cdev->net, &cdev->offload,
+					NAPI_POLL_WEIGHT);
+	if (ret)
+		goto out_reset_control_assert;
 
 	if (!cdev->net->irq) {
 		netdev_dbg(cdev->net, "Polling enabled, initialize hrtimer");
@@ -2575,8 +2502,7 @@ int m_can_class_register(struct m_can_classdev *cdev)
 	return 0;
 
 rx_offload_del:
-	if (cdev->is_peripheral)
-		can_rx_offload_del(&cdev->offload);
+	can_rx_offload_del(&cdev->offload);
 out_reset_control_assert:
 	reset_control_assert(cdev->rst);
 clk_disable:
@@ -2589,8 +2515,7 @@ EXPORT_SYMBOL_GPL(m_can_class_register);
 void m_can_class_unregister(struct m_can_classdev *cdev)
 {
 	unregister_candev(cdev->net);
-	if (cdev->is_peripheral)
-		can_rx_offload_del(&cdev->offload);
+	can_rx_offload_del(&cdev->offload);
 }
 EXPORT_SYMBOL_GPL(m_can_class_unregister);
 
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 4743342b2fba..9223a77b55d7 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -81,7 +81,6 @@ struct m_can_tx_op {
 struct m_can_classdev {
 	struct can_priv can;
 	struct can_rx_offload offload;
-	struct napi_struct napi;
 	struct net_device *net;
 	struct device *dev;
 	struct clk *hclk;
@@ -96,7 +95,6 @@ struct m_can_classdev {
 	const struct m_can_ops *ops;
 
 	int version;
-	u32 irqstatus;
 
 	int pm_clock_support;
 	int pm_wake_source;

---
base-commit: 08030ddb87b4c6c6a2c03c82731b5e188f02f5b9
change-id: 20260709-m_can-rx-offload-a228500d9f3a

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


