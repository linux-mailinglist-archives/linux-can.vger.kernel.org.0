Return-Path: <linux-can+bounces-1551-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2553983D0A
	for <lists+linux-can@lfdr.de>; Tue, 24 Sep 2024 08:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E5A1C20D7B
	for <lists+linux-can@lfdr.de>; Tue, 24 Sep 2024 06:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCAB6EB5C;
	Tue, 24 Sep 2024 06:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cNu3hMTT"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE0F558A5
	for <linux-can@vger.kernel.org>; Tue, 24 Sep 2024 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158883; cv=none; b=O1fE907eP6EwVDMHTvK9TuTD/ry70k6X+FjMMq3hKY82t1aGEGPROgm48DvSni4MHfUfaNLjZh3QzI8BREVWzgBngNxF5Nv94mnUOEEKvB6NoNQEmB5LAoHaAHaWPV59Z0uvGQK2aptvCk/1B+HrrGCcnxWE+91tU55HV6l3GJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158883; c=relaxed/simple;
	bh=wRwKON423yZqXPqJ5rTGOSCIBIr9IskAzhplTcV4fdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VN5CIwS+3clyxQ/NmRZYneFnHkHuaO531Ya91vCQiOtdcmGC+YSsH1agMA1LzlmEUi37Iv9v+CFLT0vXXmF1paZGH5t8/+EbmiJX8DdbO+N9uR9nl5/kK9sv6gr4nUDS59kcTVUvYdXGqz0n9RkwCO/jNtpKUTDQM8kXBrD5588=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cNu3hMTT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42e5e758093so44303095e9.1
        for <linux-can@vger.kernel.org>; Mon, 23 Sep 2024 23:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727158878; x=1727763678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gk89L1Uzp22QgNm9C+CJpSMQA20Mf2rtUhzwasdOsN0=;
        b=cNu3hMTTy3ECwrP4mAFN7jhkQfgMRHCeM13EZB1Py4LmRE65E0yl9puZZjqtWL0HXA
         ofwDo81LcVp7xKTzi4XYc+v9QdwaKiribtwKGnafOi6dmUayr+ZVMZjaoNYdHtBwE5Sz
         udXQmy1Z8auwSCnTayVP4UVp5J6sGEi4knd8Y8NXufM/OGVL5pcB8I0CwVefwRkdCsEO
         5zab2QZ9+ENiqAGEJsVOb+A4p1cVbOvI6uG5KVY3KsHnDYvxp/iJbLJ4j1r65o6DlU/l
         o3NJo9Z+N/xS43WfCXuez99RWwcdvXsh0LH6ILIqj+5rc5fsR6yKJk8/iiHuZd5y+Asg
         9uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727158878; x=1727763678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gk89L1Uzp22QgNm9C+CJpSMQA20Mf2rtUhzwasdOsN0=;
        b=BEz3GH93rEEq/x8vcHrzs9ELpM+9AMRcA3nC4gp84nxLb7I+5SzSMcWm3RVmfiGfc/
         lBIiKZizj2dn+WTSBBJjW9AgGNS+eZRGs9el9wg7vJph6Xvb01iZ/pvwXw44f+xqqDGC
         ynMXmU+q432EBeQv3flXlg+lah9YakSGrqw2oPCBdGDMvg+wgPXyikMoTR1MMWCGjlF8
         tWQoszs0FEkePEGmrIgT2D63lSyOHixk6u2Qinkf7m6KfRQ/x9uPnpwFsYa8r2Htl86I
         di8G1GvfInGZ9iWgkfmvRWp3x9CKc3TIwQfLBoCvgPZi30GrG6e4fp5UaXIkjDNPzSxd
         bQ0A==
X-Forwarded-Encrypted: i=1; AJvYcCXYpjNISYbw/6MwzCue0Hd3+dE6SgN99OX2Qrz4bGiNeHQ5td4i+S56zM7tFVwPsQg5ipf3gi4x6ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUUz7Isyo3PJyJcUsvdeBkbtnEvkj5hi8Ayd/mB5n1xIdEdnPW
	+Qmgu1FtnojJUUbM/FLw+I69i/1iZI5V2NSCeWc4ytbDQAez1Jpw80frPcvgjUEchqPWdTJOub0
	cdYc=
X-Google-Smtp-Source: AGHT+IG84zxrtOVvKIUK7BWEiXaQEvq8dlgEmna+eHGCrpp8ivpSmnjxzyrcAtUQEjeDH4s/KoXwXA==
X-Received: by 2002:a05:600c:3553:b0:426:689b:65b7 with SMTP id 5b1f17b1804b1-42e7ad92431mr111899425e9.25.1727158878387;
        Mon, 23 Sep 2024 23:21:18 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8155:f78b:11e0:5100:a478])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754a6379sm147037375e9.35.2024.09.23.23.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 23:21:17 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>,
	"Felipe Balbi (Intel)" <balbi@kernel.org>,
	Raymond Tan <raymond.tan@intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH DO_NOT_APPLY] net: can: m_can: Support tcan level with edge interrupts
Date: Tue, 24 Sep 2024 08:16:22 +0200
Message-ID: <20240924062100.2545714-1-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240923-tricky-bird-of-symmetry-68519b-mkl@pengutronix.de>
References: <20240923-tricky-bird-of-symmetry-68519b-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tcan chip has a low level interrupt line that needs to be used.
There are some SoCs and components that do only support edge interrupts
on GPIOs. In the exact example someone wired the tcan chip to a am62
GPIO.

This patch creates a workaround for these situations, enabling the use
of tcan with a falling edge interrupt. Note that this is not the
preferred way to wire a tcan chip to the SoC.

I am detecting the situation by reading the IRQ type. If it is a level
interrupt everything stays the same. Otherwise these were my
considerations and solutions:

With falling edge interrupts we have following issues:
- While handling a IRQF_ONESHOT interrupt the interrupt may be masked as
  long as the interrupt is handled. So if a new interrupt hits during
  the handling of the interrupt may be lost as it is masked. With level
  interrupts that is not a problem because the interrupt line is still
  active/low after the handler is unmasked so it will jump back into
  handling interrupts afterwards. With edge interrupts we will just
  loose the interrupt at this point as we do not see the edge while the
  interrupt is masked. Solution here is to remove the IRQF_ONESHOT flag
  in case edge interrupts are used.
- Reading and clearing the interrupt register is not atomic. So the
  interrupts we clear from the interrupt register may not result in a
  completely cleared interrupt register and leave some unhandled
  interrupt. Again this is fine for level based interrupts as they will
  be causing a new call of the interrupt handler. With edge interrupts
  we will be missing this interrupt. So we need to make sure that the
  clearing of the interrupt register actually cleared it and the
  interrupt line could have gone back to inactive/high. To do that the
  interrupt register is read/cleared/handled repeatedly until it is 0.

Updating the interrupts for coalescing is only done once at the end with
all interrupts that were handled and not for every loop. We don't want
to change interrupts multiple times here.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---

This is the draft that I had for edge interrupts. For am62 I will create
a followup patch that covers minor things like IRQF_ONESHOT removal etc.

Best
Markus

 drivers/net/can/m_can/m_can.c | 114 +++++++++++++++++++++-------------
 drivers/net/can/m_can/m_can.h |   1 +
 2 files changed, 73 insertions(+), 42 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 663eb4247029..4b969f29ba55 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1208,6 +1208,7 @@ static void m_can_coalescing_update(struct m_can_classdev *cdev, u32 ir)
 static int m_can_interrupt_handler(struct m_can_classdev *cdev)
 {
 	struct net_device *dev = cdev->net;
+	u32 all_interrupts = 0;
 	u32 ir;
 	int ret;
 
@@ -1215,56 +1216,75 @@ static int m_can_interrupt_handler(struct m_can_classdev *cdev)
 		return IRQ_NONE;
 
 	ir = m_can_read(cdev, M_CAN_IR);
-	m_can_coalescing_update(cdev, ir);
-	if (!ir)
+	all_interrupts |= ir;
+	if (!ir) {
+		m_can_coalescing_update(cdev, 0);
 		return IRQ_NONE;
-
-	/* ACK all irqs */
-	m_can_write(cdev, M_CAN_IR, ir);
-
-	if (cdev->ops->clear_interrupts)
-		cdev->ops->clear_interrupts(cdev);
-
-	/* schedule NAPI in case of
-	 * - rx IRQ
-	 * - state change IRQ
-	 * - bus error IRQ and bus error reporting
-	 */
-	if (ir & (IR_RF0N | IR_RF0W | IR_ERR_ALL_30X)) {
-		cdev->irqstatus = ir;
-		if (!cdev->is_peripheral) {
-			m_can_disable_all_interrupts(cdev);
-			napi_schedule(&cdev->napi);
-		} else {
-			ret = m_can_rx_handler(dev, NAPI_POLL_WEIGHT, ir);
-			if (ret < 0)
-				return ret;
-		}
 	}
 
-	if (cdev->version == 30) {
-		if (ir & IR_TC) {
-			/* Transmission Complete Interrupt*/
-			u32 timestamp = 0;
-			unsigned int frame_len;
+	do {
+		/* ACK all irqs */
+		m_can_write(cdev, M_CAN_IR, ir);
 
-			if (cdev->is_peripheral)
-				timestamp = m_can_get_timestamp(cdev);
-			frame_len = m_can_tx_update_stats(cdev, 0, timestamp);
-			m_can_finish_tx(cdev, 1, frame_len);
+		if (cdev->ops->clear_interrupts)
+			cdev->ops->clear_interrupts(cdev);
+
+		/* schedule NAPI in case of
+		 * - rx IRQ
+		 * - state change IRQ
+		 * - bus error IRQ and bus error reporting
+		 */
+		if (ir & (IR_RF0N | IR_RF0W | IR_ERR_ALL_30X)) {
+			cdev->irqstatus = ir;
+			if (!cdev->is_peripheral) {
+				m_can_disable_all_interrupts(cdev);
+				napi_schedule(&cdev->napi);
+			} else {
+				ret = m_can_rx_handler(dev, NAPI_POLL_WEIGHT, ir);
+				if (ret < 0)
+					return ret;
+			}
 		}
-	} else  {
-		if (ir & (IR_TEFN | IR_TEFW)) {
-			/* New TX FIFO Element arrived */
-			ret = m_can_echo_tx_event(dev);
-			if (ret != 0)
-				return ret;
+
+		if (cdev->version == 30) {
+			if (ir & IR_TC) {
+				/* Transmission Complete Interrupt*/
+				u32 timestamp = 0;
+				unsigned int frame_len;
+
+				if (cdev->is_peripheral)
+					timestamp = m_can_get_timestamp(cdev);
+				frame_len = m_can_tx_update_stats(cdev, 0, timestamp);
+				m_can_finish_tx(cdev, 1, frame_len);
+			}
+		} else  {
+			if (ir & (IR_TEFN | IR_TEFW)) {
+				/* New TX FIFO Element arrived */
+				ret = m_can_echo_tx_event(dev);
+				if (ret != 0)
+					return ret;
+			}
 		}
-	}
+		if (!cdev->irq_type_edge)
+			break;
+
+
+		/* For edge interrupts we need to read the IR register again to
+		 * check that everything is cleared. If it is not, we can not
+		 * make sure the interrupt line is inactive again which is
+		 * required at this point to not miss any new interrupts. So in
+		 * case there are interrupts signaled in IR we repeat the
+		 * interrupt handling.
+		 */
+		ir = m_can_read(cdev, M_CAN_IR);
+		all_interrupts |= ir;
+	} while (ir);
 
 	if (cdev->is_peripheral)
 		can_rx_offload_threaded_irq_finish(&cdev->offload);
 
+	m_can_coalescing_update(cdev, all_interrupts);
+
 	return IRQ_HANDLED;
 }
 
@@ -2009,6 +2029,11 @@ static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer)
 	return HRTIMER_RESTART;
 }
 
+static irqreturn_t m_can_hardirq(int irq, void *dev_id)
+{
+	return IRQ_WAKE_THREAD;
+}
+
 static int m_can_open(struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
@@ -2034,6 +2059,9 @@ static int m_can_open(struct net_device *dev)
 
 	/* register interrupt handler */
 	if (cdev->is_peripheral) {
+		cdev->irq_type_edge = !(irq_get_trigger_type(dev->irq) &
+					IRQ_TYPE_LEVEL_MASK);
+
 		cdev->tx_wq = alloc_ordered_workqueue("mcan_wq",
 						      WQ_FREEZABLE | WQ_MEM_RECLAIM);
 		if (!cdev->tx_wq) {
@@ -2046,9 +2074,11 @@ static int m_can_open(struct net_device *dev)
 			INIT_WORK(&cdev->tx_ops[i].work, m_can_tx_work_queue);
 		}
 
-		err = request_threaded_irq(dev->irq, NULL, m_can_isr,
-					   IRQF_ONESHOT,
+		err = request_threaded_irq(dev->irq, m_can_hardirq, m_can_isr,
+					   (cdev->irq_type_edge ? 0 : IRQF_ONESHOT),
 					   dev->name, dev);
+		if (cdev->irq_type_edge)
+			netdev_info(dev, "Operating a level interrupt chip with an edge interrupt.\n");
 	} else if (dev->irq) {
 		err = request_irq(dev->irq, m_can_isr, IRQF_SHARED, dev->name,
 				  dev);
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 3a9edc292593..17de56056352 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -99,6 +99,7 @@ struct m_can_classdev {
 	int pm_clock_support;
 	int pm_wake_source;
 	int is_peripheral;
+	bool irq_type_edge;
 
 	// Cached M_CAN_IE register content
 	u32 active_interrupts;
-- 
2.45.2


