Return-Path: <linux-can+bounces-1283-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D22E966BDA
	for <lists+linux-can@lfdr.de>; Sat, 31 Aug 2024 00:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB7E1C21D32
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 22:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9C01C2306;
	Fri, 30 Aug 2024 21:59:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8871C1AC0
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 21:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725055166; cv=none; b=Yvo/6WKXUdjop2QKBP72Ws4CE/YTEU+5e0uap2mVJncjeBOrwy3pzGsqFBGpdwILUWQ8xgrxKAdK2/fQ1JHJj92R4DvXTXwGC+5TJ9vtQdjOL6Gm265OeppKMyH8TqxAaH5UZI7n3msr9jdItwwuTgl+FcvP2pChMwSi0N5kF+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725055166; c=relaxed/simple;
	bh=fRm+zAV++uiIA1RX1bzFhZPUsOqrZ6B9He4C3KFgoUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dq6hPifYeDH99/L4PhttbEG+87/ENwCG3x4Y/7BxsKYWqGlsR/FTX6qM+85V8yFNK9JetEYbrBgYEYcs05VuwPVURbZtpxXyfQ5bZkSCtwYXOjW+fdfuttagMF1MEV6hQbvncdrgjEG6MXsSZjjuLfKCVU7UdhNdGkqMLyKJqNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9eM-0004EW-4d
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 23:59:22 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9eJ-004FXe-WA
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 23:59:20 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 7098032E521
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 21:59:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 190CF32E4DC;
	Fri, 30 Aug 2024 21:59:17 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 41b97354;
	Fri, 30 Aug 2024 21:59:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 06/13] can: m_can: Do not cancel timer from within timer
Date: Fri, 30 Aug 2024 23:53:41 +0200
Message-ID: <20240830215914.1610393-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240830215914.1610393-1-mkl@pengutronix.de>
References: <20240830215914.1610393-1-mkl@pengutronix.de>
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

From: Markus Schneider-Pargmann <msp@baylibre.com>

On setups without interrupts, the interrupt handler is called from a
timer callback. For non-peripheral receives napi is scheduled,
interrupts are disabled and the timer is canceled with a blocking call.
In case of an error this can happen as well.

Check if napi is scheduled in the timer callback after the interrupt
handler executed. If napi is scheduled, the timer is disabled. It will
be reenabled by m_can_poll().

Return error values from the interrupt handler so that interrupt threads
and timer callback can deal differently with it. In case of the timer
we only disable the timer. The rest will be done when stopping the
interface.

Fixes: b382380c0d2d ("can: m_can: Add hrtimer to generate software interrupt")
Fixes: a163c5761019 ("can: m_can: Start/Cancel polling timer together with interrupts")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Link: https://lore.kernel.org/all/20240805183047.305630-5-msp@baylibre.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 57 ++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a37ed376de9b..5228304779f1 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -487,7 +487,7 @@ static inline void m_can_disable_all_interrupts(struct m_can_classdev *cdev)
 
 	if (!cdev->net->irq) {
 		dev_dbg(cdev->dev, "Stop hrtimer\n");
-		hrtimer_cancel(&cdev->hrtimer);
+		hrtimer_try_to_cancel(&cdev->hrtimer);
 	}
 }
 
@@ -1201,11 +1201,15 @@ static void m_can_coalescing_update(struct m_can_classdev *cdev, u32 ir)
 			      HRTIMER_MODE_REL);
 }
 
-static irqreturn_t m_can_isr(int irq, void *dev_id)
+/* This interrupt handler is called either from the interrupt thread or a
+ * hrtimer. This has implications like cancelling a timer won't be possible
+ * blocking.
+ */
+static int m_can_interrupt_handler(struct m_can_classdev *cdev)
 {
-	struct net_device *dev = (struct net_device *)dev_id;
-	struct m_can_classdev *cdev = netdev_priv(dev);
+	struct net_device *dev = cdev->net;
 	u32 ir;
+	int ret;
 
 	if (pm_runtime_suspended(cdev->dev))
 		return IRQ_NONE;
@@ -1232,11 +1236,9 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 			m_can_disable_all_interrupts(cdev);
 			napi_schedule(&cdev->napi);
 		} else {
-			int pkts;
-
-			pkts = m_can_rx_handler(dev, NAPI_POLL_WEIGHT, ir);
-			if (pkts < 0)
-				goto out_fail;
+			ret = m_can_rx_handler(dev, NAPI_POLL_WEIGHT, ir);
+			if (ret < 0)
+				return ret;
 		}
 	}
 
@@ -1254,8 +1256,9 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	} else  {
 		if (ir & (IR_TEFN | IR_TEFW)) {
 			/* New TX FIFO Element arrived */
-			if (m_can_echo_tx_event(dev) != 0)
-				goto out_fail;
+			ret = m_can_echo_tx_event(dev);
+			if (ret != 0)
+				return ret;
 		}
 	}
 
@@ -1263,16 +1266,31 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 		can_rx_offload_threaded_irq_finish(&cdev->offload);
 
 	return IRQ_HANDLED;
+}
 
-out_fail:
-	m_can_disable_all_interrupts(cdev);
-	return IRQ_HANDLED;
+static irqreturn_t m_can_isr(int irq, void *dev_id)
+{
+	struct net_device *dev = (struct net_device *)dev_id;
+	struct m_can_classdev *cdev = netdev_priv(dev);
+	int ret;
+
+	ret =  m_can_interrupt_handler(cdev);
+	if (ret < 0) {
+		m_can_disable_all_interrupts(cdev);
+		return IRQ_HANDLED;
+	}
+
+	return ret;
 }
 
 static enum hrtimer_restart m_can_coalescing_timer(struct hrtimer *timer)
 {
 	struct m_can_classdev *cdev = container_of(timer, struct m_can_classdev, hrtimer);
 
+	if (cdev->can.state == CAN_STATE_BUS_OFF ||
+	    cdev->can.state == CAN_STATE_STOPPED)
+		return HRTIMER_NORESTART;
+
 	irq_wake_thread(cdev->net->irq, cdev->net);
 
 	return HRTIMER_NORESTART;
@@ -1973,8 +1991,17 @@ static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer)
 {
 	struct m_can_classdev *cdev = container_of(timer, struct
 						   m_can_classdev, hrtimer);
+	int ret;
 
-	m_can_isr(0, cdev->net);
+	if (cdev->can.state == CAN_STATE_BUS_OFF ||
+	    cdev->can.state == CAN_STATE_STOPPED)
+		return HRTIMER_NORESTART;
+
+	ret = m_can_interrupt_handler(cdev);
+
+	/* On error or if napi is scheduled to read, stop the timer */
+	if (ret < 0 || napi_is_scheduled(&cdev->napi))
+		return HRTIMER_NORESTART;
 
 	hrtimer_forward_now(timer, ms_to_ktime(HRTIMER_POLL_INTERVAL_MS));
 
-- 
2.45.2



