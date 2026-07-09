Return-Path: <linux-can+bounces-8208-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +0PkIDK/T2r6ngIAu9opvQ
	(envelope-from <linux-can+bounces-8208-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 17:33:06 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC61A732F1F
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 17:33:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8208-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8208-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D197303925D
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 15:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB6337BE98;
	Thu,  9 Jul 2026 15:26:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535CE36D51D;
	Thu,  9 Jul 2026 15:26:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610793; cv=none; b=XDcQ0RN/G2bgQmFTJonwcRNkm7ED8wyoOgN20CJysz0y4xw/WhD+/7Lv6RnrLF6NAD4djdsdsqoFjGuQQogTt9TfxWFLHjV+ubmlwgiCE/0om4zxqnUwXBgTAZQzw77TMbrajr9b0wTzdsQ3yX5X025oMOJY2z/INMJtu3AtUpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610793; c=relaxed/simple;
	bh=rWPZiV3xKHr7rGvnF6Qqjeq8D1iKzgL6iB7og2773J0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Afy4e1lMu5nG9ZW7gvcQLVQT6u2YH8msVSbOUElPc9sqlWIWIJzEMqPUS0sWFSMO/0+dRp9H3V8EimHonDk2hY2FBbSoCDK6gE4M53As+29+GmoEYB8WhV+MSbbW50+AqAnTHiijCUe14FHSzu90CDhLhvWXI5Sem9kgPuIQqTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 07574201CEF;
	Thu, 09 Jul 2026 17:26:27 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1whqdu-000wFK-2r;
	Thu, 09 Jul 2026 17:26:26 +0200
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9B18D564309;
	Thu, 09 Jul 2026 15:26:26 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 09 Jul 2026 17:26:23 +0200
Subject: [PATCH can-next] can: m_can: switch to rx-offload implementation
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-m_can-rx-offload-v1-1-af3efa8e4272@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAJ69T2oC/yWMUQrCMBAFr1L224U1orVeRUpZk42uaFKSKoHSu
 5vaz+G9mRmyJJUMl2aGJF/NGkOF/a4B++BwF1RXGQyZE7XU4XuwHDAVjN6/IjtkY85HItf5A0P
 VxiReyz95hfUbpEzQb0v+3J5ip7UIy/IDbdyFan4AAAA=
X-Change-ID: 20260709-m_can-rx-offload-a228500d9f3a
To: Markus Schneider-Pargmann <msp@baylibre.com>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10314; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=rWPZiV3xKHr7rGvnF6Qqjeq8D1iKzgL6iB7og2773J0=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjy3zv/xsJp/xYzzFwXdG7btwnvbJt+5fOee71b5KDrb
 /2dtzeLZHaUsjCIcTHIiimyLP1xQlEg0KG092XCJJg5rEwgQxi4OAVgIkcCGP6XsLtc62Y6+UP/
 wTnNvuru2LWi1utsz4pkbOD5xbUtPPENI8OTSeJtWuWcTirW2ovUL3xOdgmdO3WlyEqF1NYj3ZO
 /ufMDAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8208-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pengutronix.de:from_mime,pengutronix.de:email,pengutronix.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC61A732F1F

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
 drivers/net/can/m_can/m_can.c | 134 +++++++++++-------------------------------
 drivers/net/can/m_can/m_can.h |   1 -
 2 files changed, 34 insertions(+), 101 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index eb856547ae7d..8175b030257b 100644
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
@@ -678,8 +669,7 @@ static int m_can_handle_lost_msg(struct net_device *dev)
 	frame->can_id |= CAN_ERR_CRTL;
 	frame->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 
-	if (cdev->is_peripheral)
-		timestamp = m_can_get_timestamp(cdev);
+	timestamp = m_can_get_timestamp(cdev);
 
 	m_can_receive_skb(cdev, skb, timestamp);
 
@@ -750,8 +740,7 @@ static int m_can_handle_lec_err(struct net_device *dev,
 	if (unlikely(!skb))
 		return 0;
 
-	if (cdev->is_peripheral)
-		timestamp = m_can_get_timestamp(cdev);
+	timestamp = m_can_get_timestamp(cdev);
 
 	m_can_receive_skb(cdev, skb, timestamp);
 
@@ -883,8 +872,7 @@ static int m_can_handle_state_change(struct net_device *dev,
 		break;
 	}
 
-	if (cdev->is_peripheral)
-		timestamp = m_can_get_timestamp(cdev);
+	timestamp = m_can_get_timestamp(cdev);
 
 	m_can_receive_skb(cdev, skb, timestamp);
 
@@ -973,8 +961,7 @@ static int m_can_handle_protocol_error(struct net_device *dev, u32 irqstatus)
 		return 0;
 	}
 
-	if (cdev->is_peripheral)
-		timestamp = m_can_get_timestamp(cdev);
+	timestamp = m_can_get_timestamp(cdev);
 
 	m_can_receive_skb(cdev, skb, timestamp);
 
@@ -1065,32 +1052,6 @@ static int m_can_rx_handler(struct net_device *dev, int quota, u32 irqstatus)
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
@@ -1098,14 +1059,11 @@ static unsigned int m_can_tx_update_stats(struct m_can_classdev *cdev,
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
 
@@ -1265,21 +1223,10 @@ static int m_can_interrupt_handler(struct m_can_classdev *cdev)
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
@@ -1288,8 +1235,7 @@ static int m_can_interrupt_handler(struct m_can_classdev *cdev)
 			u32 timestamp = 0;
 			unsigned int frame_len;
 
-			if (cdev->is_peripheral)
-				timestamp = m_can_get_timestamp(cdev);
+			timestamp = m_can_get_timestamp(cdev);
 			frame_len = m_can_tx_update_stats(cdev, 0, timestamp);
 			m_can_finish_tx(cdev, 1, frame_len);
 		}
@@ -1304,6 +1250,8 @@ static int m_can_interrupt_handler(struct m_can_classdev *cdev)
 
 	if (cdev->is_peripheral)
 		can_rx_offload_threaded_irq_finish(&cdev->offload);
+	else
+		can_rx_offload_irq_finish(&cdev->offload);
 
 	return IRQ_HANDLED;
 }
@@ -1752,9 +1700,6 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
 	if (err)
 		return err;
 
-	if (!cdev->is_peripheral)
-		netif_napi_add(dev, &cdev->napi, m_can_poll);
-
 	/* Shared properties of all M_CAN versions */
 	cdev->version = m_can_version;
 	cdev->can.do_set_mode = m_can_set_mode;
@@ -1846,11 +1791,10 @@ static int m_can_close(struct net_device *dev)
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
@@ -2069,8 +2013,8 @@ static enum hrtimer_restart m_can_polling_timer(struct hrtimer *timer)
 
 	ret = m_can_interrupt_handler(cdev);
 
-	/* On error or if napi is scheduled to read, stop the timer */
-	if (ret < 0 || napi_is_scheduled(&cdev->napi))
+	/* On error stop the timer */
+	if (ret < 0)
 		return HRTIMER_NORESTART;
 
 	hrtimer_forward_now(timer, ms_to_ktime(HRTIMER_POLL_INTERVAL_MS));
@@ -2102,10 +2046,7 @@ static int m_can_open(struct net_device *dev)
 		goto out_reset_control_assert;
 	}
 
-	if (cdev->is_peripheral)
-		can_rx_offload_enable(&cdev->offload);
-	else
-		napi_enable(&cdev->napi);
+	can_rx_offload_enable(&cdev->offload);
 
 	/* register interrupt handler */
 	if (cdev->is_peripheral) {
@@ -2144,16 +2085,13 @@ static int m_can_open(struct net_device *dev)
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
@@ -2533,12 +2471,10 @@ int m_can_class_register(struct m_can_classdev *cdev)
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
@@ -2575,8 +2511,7 @@ int m_can_class_register(struct m_can_classdev *cdev)
 	return 0;
 
 rx_offload_del:
-	if (cdev->is_peripheral)
-		can_rx_offload_del(&cdev->offload);
+	can_rx_offload_del(&cdev->offload);
 out_reset_control_assert:
 	reset_control_assert(cdev->rst);
 clk_disable:
@@ -2589,8 +2524,7 @@ EXPORT_SYMBOL_GPL(m_can_class_register);
 void m_can_class_unregister(struct m_can_classdev *cdev)
 {
 	unregister_candev(cdev->net);
-	if (cdev->is_peripheral)
-		can_rx_offload_del(&cdev->offload);
+	can_rx_offload_del(&cdev->offload);
 }
 EXPORT_SYMBOL_GPL(m_can_class_unregister);
 
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 4743342b2fba..ca5833650dbf 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -96,7 +96,6 @@ struct m_can_classdev {
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


