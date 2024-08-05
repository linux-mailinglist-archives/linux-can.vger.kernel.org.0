Return-Path: <linux-can+bounces-1120-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 812FC94819E
	for <lists+linux-can@lfdr.de>; Mon,  5 Aug 2024 20:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023BF1F23314
	for <lists+linux-can@lfdr.de>; Mon,  5 Aug 2024 18:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D564916B739;
	Mon,  5 Aug 2024 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Dhj8A0l1"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0CD16B385
	for <linux-can@vger.kernel.org>; Mon,  5 Aug 2024 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722882685; cv=none; b=Kh0/QAs8bWDExMn78Q3x7Qu3sr9ROgZ022sUVjkUgVVaVSX+EKA4UP9M51HDNu1sVk9Mh341RQ3OzBHrEKQd+h3ERgdpxcwqXGOClmXQvfsMYuJ34FPNl16RCETm52G0A6e129mMIwwugPp1v3b4WxinRaAxTR3sNHeDzVJziOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722882685; c=relaxed/simple;
	bh=1sCAMwHlLhrTJzQWswIXJnmmANEP5KJsAtG838cx+CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgxGhbsLRUDIZCXRJfqdnxTeqKcVLHaszULklX04IqD/ni0e1gjwc0mhV0yq3HfPh8WHhjghRRxapzQ1/rVxYw2tgvW67BLO+iMSgO3P1m01VotHAJO7GjH7g2d0NgaHB441yIl2uKB2oxw+I5MJ10QbSHUjYc/KAi7G1Ktl2NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Dhj8A0l1; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39b3cae5675so125195ab.1
        for <linux-can@vger.kernel.org>; Mon, 05 Aug 2024 11:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722882683; x=1723487483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JGlrEXu3NtOZu5ryCLf4wFhjQ6Lr9D+AY1HpLPHozk=;
        b=Dhj8A0l1T2+6XVR7ZfoX51L4Chh/K7x8xlxr0f3spvHa8A35r1tnxuP17OfwXTV2uj
         tdz9dWaHJNf/2XRE7kzMxOWSukXl1EwsHqFE8lx9q9JQfhpLgPsGCGDghgVmU3JUj+9M
         h+7vUbIvZUWtZJZr/Id+o054jiSFq8jDZ7W9/ZVIogYFWlCWbnqWQWzJhUdDe7UKwLcb
         23r+qK/5hcgjnb/m6gAN7O1Um8idcFp7UDG9/CKB6KkzcVCGfRxUDq0LEACQ1W5pPzbi
         GC9TEqPe27Eecb9f0qbCVvGJkMkBq34M7xlPN5f0U9RyWZRZM0BMtRZdpn1jPIwReORq
         6YRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722882683; x=1723487483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JGlrEXu3NtOZu5ryCLf4wFhjQ6Lr9D+AY1HpLPHozk=;
        b=mduoaWdy56k17oey29S2SUZ8j3aj5TR4XMXs8WlLwSGl3iy6Ui6zDpAx2rkUKRjvO3
         AtkMqgpWH5PfPMHMc6UbVjyyN/mwa8CA2m2xbx/QrxS5OuWqDrtRLeARMh2QNkOYZWLX
         uewd5qYIbKDWADeLb7bOqiSmqarLns5BNF0sE6khy7FQxtsGbf/apxaHl9HKR6+FnlH+
         n6yIWVg4G7jRULeVyGj8pL6W4UGYpLO0sifCIQP0Plm+puvgVn9jruI4tv1P+M1irqY5
         LX79Ld7oxUA/OyF13yQ3JKjEnZY4wJYQz0TfZRTDEwxTjlgUBcl+8CpotQghe14IbEGv
         wcCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqNZGG/LfOcFzdcpszTw7o8956CmQu4KDQgrJMxXTclSRDj4T6JFxaellMLP+0Tk1BSEcHptEfl2JeekSjGVJtJO9Iwvb1Fzys
X-Gm-Message-State: AOJu0Yx/iIjBgZ2fEz98yLyDkLK18am8vMMHRTprJWYCvU29EURijce9
	ucZQ0YHjBjjCtHjU9f9jCKHgXgaX1DJZGsoOSv0mdHgb0jQ515CrYD3UeVOeQtE=
X-Google-Smtp-Source: AGHT+IHksmBssQdErDi7l3d3mDIMU7STM/GX8eeApV/gOKjo26laMPcbWqj8OJnsZcu3YNThhvyYJw==
X-Received: by 2002:a92:c52e:0:b0:39a:16b2:7290 with SMTP id e9e14a558f8ab-39b201c25d2mr98433625ab.9.1722882682647;
        Mon, 05 Aug 2024 11:31:22 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b20a9af29sm30867925ab.13.2024.08.05.11.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 11:31:22 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Judith Mendez <jm@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Simon Horman <horms@kernel.org>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Linux regression tracking <regressions@leemhuis.info>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] can: m_can: Do not cancel timer from within timer
Date: Mon,  5 Aug 2024 20:30:44 +0200
Message-ID: <20240805183047.305630-5-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805183047.305630-1-msp@baylibre.com>
References: <20240805183047.305630-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/net/can/m_can/m_can.c | 57 ++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 42ed7f0fea78..f2fc862fb21c 100644
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


