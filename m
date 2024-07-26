Return-Path: <linux-can+bounces-1013-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7752393D977
	for <lists+linux-can@lfdr.de>; Fri, 26 Jul 2024 22:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99BE81C2381E
	for <lists+linux-can@lfdr.de>; Fri, 26 Jul 2024 20:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129E4153BDE;
	Fri, 26 Jul 2024 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yUFpBD0v"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B46B14EC47
	for <linux-can@vger.kernel.org>; Fri, 26 Jul 2024 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722024011; cv=none; b=BMLH3mN7cFojOO/q47sT8c8DJ7wPUm+iijf9JR72z0Agd82AuH1HH4XmdjkvG9sZzj5/rnR4WVhrvoNCq723cLiNulm6Z6T4My2/21dfamBtnOpPu+nWb3oUo2d/L83MBh271HOUAuRFPz5Dz15AD+EzN2FefRccgUnGK2vOfXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722024011; c=relaxed/simple;
	bh=J14Wge9LcsEa7FQuC1M+/lsG9UZ/eoPKBj1txE0yej8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JEqcZnhNwEQWtIAw2Ycag9XpiFy/EWnJ93JXfd5iRe1Qh6/yXY8Ww/co8JdpDVgzCWqk9xTRmb2wuqXLIOyWgSVXDM0rwxd7EXlTgRwy6+HUWj5sEdn4eh/kZ1PhuM8zvpmxSNfRNVQw/8tNVR/cUSun7EuXuM9CznB2ih0K0PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yUFpBD0v; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6fd513f18bso246648766b.3
        for <linux-can@vger.kernel.org>; Fri, 26 Jul 2024 13:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722024005; x=1722628805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvEzDkwz6VWUUds2tie0+9vVLaqnWTgyheAACKxwxaM=;
        b=yUFpBD0v/GYuTjQmepxGGNxZrGzoRuOL+oz4PzCVuJwCRpzuwkErlQy/xZXsjTg0ny
         GtLcy/wbqJvxrm5+38f7bdGDJgI2dQEi+c/9WtZV5aqSWZwwMOzZhxKWtCnrSfj51bIs
         XnkY+o1XFWKzYOOxDf+Jtb+vF4ngbj7qyPykc8Bax9F1Qw1KXGe+7oh5S9sXXlINtmo8
         +wgggMjsCcSRHKso1+U7U06nyHr0jvMSMccZOF/tbh5J1cYCO8wFBqtBraObjc2o6jWZ
         N91H/0FVb0YV4fuRoHJBjDMS5+roRiNZXdqYJ4wqHYp3wnCCerZi4O5OIYa+stLCBzeh
         CqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722024005; x=1722628805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvEzDkwz6VWUUds2tie0+9vVLaqnWTgyheAACKxwxaM=;
        b=eTKaT99D651LIMTDJp2PZbPM+nD8JKvMWPpx8fnD0gLtfDrGHSMRI3ZBWIaiBU7WP8
         siq+uorUwi5CBf6sHstSfcnBbyWnX739vKmaZ7TuYzsc5fMxV453V75+DXfpn5D9WffP
         +5TTP77mRP/T9gnoxdJriodTWaCIl+GbWhr4RuM+A7PiJLasfP4YhAJrcr+/k8LkH4lR
         uGnPzAuM6lOBIFj/1Ekmy+aoZPUn6h/VgaEc3/YRoKiz6yq74+gKou3d0b2mWGIzu7Dx
         g8/eMFQ5iAmqjlPxISrWYu0oacZabN0+EEe2VcuIJdpBkANKUgJG4IKJqQoWV1VQqivD
         7ZQg==
X-Forwarded-Encrypted: i=1; AJvYcCWsvtMPWVoXrqZj95/zRL1DzA2w/ow9Yu8Ar9sEi1h+Ikste3PBRql2hOxDR6KCf9XwndIai9GgbcVz8XvsuvhAdUu70e7WYzom
X-Gm-Message-State: AOJu0YxB+/vDbU4ZTvDEaOEue+RkQZ9pVqw5PnDG600I6eN249t04xeg
	h/NU1l8Oi65llXTcteHmqnDCcTAPbrYYXxCDL9JOoT/73EfAk8FrxljBQxOLpKo=
X-Google-Smtp-Source: AGHT+IEoDGkSOlQQ1HqCH1hfBsQQjAOrogps53xCogk84g3vmjMcSvrVqFKhcBtYalOd4BgYXx9pIg==
X-Received: by 2002:a17:907:9409:b0:a7a:b1a5:21a6 with SMTP id a640c23a62f3a-a7d400a037amr42049766b.33.1722024005422;
        Fri, 26 Jul 2024 13:00:05 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad90e1esm209999166b.151.2024.07.26.13.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 13:00:05 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Simon Horman <horms@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Judith Mendez <jm@ti.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Linux regression tracking <regressions@leemhuis.info>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] can: m_can: Do not cancel timer from within timer
Date: Fri, 26 Jul 2024 21:59:41 +0200
Message-ID: <20240726195944.2414812-5-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726195944.2414812-1-msp@baylibre.com>
References: <20240726195944.2414812-1-msp@baylibre.com>
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
 drivers/net/can/m_can/m_can.c | 58 ++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 42ed7f0fea78..e70c7100a3c9 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -487,7 +487,7 @@ static inline void m_can_disable_all_interrupts(struct m_can_classdev *cdev)
 
 	if (!cdev->net->irq) {
 		dev_dbg(cdev->dev, "Stop hrtimer\n");
-		hrtimer_cancel(&cdev->hrtimer);
+		hrtimer_try_to_cancel(&cdev->hrtimer);
 	}
 }
 
@@ -1201,11 +1201,16 @@ static void m_can_coalescing_update(struct m_can_classdev *cdev, u32 ir)
 			      HRTIMER_MODE_REL);
 }
 
-static irqreturn_t m_can_isr(int irq, void *dev_id)
+/**
+ * This interrupt handler is called either from the interrupt thread or a
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
@@ -1232,11 +1237,9 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
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
 
@@ -1254,8 +1257,9 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
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
 
@@ -1263,16 +1267,31 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
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
@@ -1973,8 +1992,17 @@ static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer)
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


