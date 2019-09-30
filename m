Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68ED4C274A
	for <lists+linux-can@lfdr.de>; Mon, 30 Sep 2019 22:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfI3Uvy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 30 Sep 2019 16:51:54 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:48267 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbfI3Uvx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 30 Sep 2019 16:51:53 -0400
X-ASG-Debug-ID: 1569871852-0a7b8d53c0de4080001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.119.18.adsl.dyn.edpnet.net [77.109.119.18]) by relay-b02.edpnet.be with ESMTP id jla4dweUhPjxnDzv for <linux-can@vger.kernel.org>; Mon, 30 Sep 2019 21:30:52 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Apparent-Source-IP: 77.109.119.18
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [192.168.0.36])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id B9BA4A1A586;
        Mon, 30 Sep 2019 21:30:51 +0200 (CEST)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     dev.kurt@vandijck-laurijssen.be
Subject: [PATCH 1/3] net can c_can: only read status register after status irq
Date:   Mon, 30 Sep 2019 21:30:41 +0200
X-ASG-Orig-Subj: [PATCH 1/3] net can c_can: only read status register after status irq
Message-Id: <1569871843-28655-2-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1569871843-28655-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <1569871843-28655-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Start-Time: 1569871852
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Scan-Msg-Size: 4550
X-Barracuda-Bayes: INNOCENT GLOBAL 0.8024 1.0000 2.2443
X-Barracuda-Spam-Score: 2.74
X-Barracuda-Spam-Status: No, SCORE=2.74 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.76973
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 BSF_RULE7568M          Custom Rule 7568M
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

When the status register is read without status irq pending,
it may get into a state that it goes into busoff state
without having its irq activated, so the driver wil never know.

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 drivers/net/can/c_can/c_can.c | 68 +++++++++++++++++++++++++------------------
 drivers/net/can/c_can/c_can.h |  1 +
 2 files changed, 41 insertions(+), 28 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 606b7d8..83ab835 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -97,6 +97,9 @@
 #define BTR_TSEG2_SHIFT		12
 #define BTR_TSEG2_MASK		(0x7 << BTR_TSEG2_SHIFT)
 
+/* interrupt register */
+#define INT_STS_PENDING		0x8000
+
 /* brp extension register */
 #define BRP_EXT_BRPE_MASK	0x0f
 #define BRP_EXT_BRPE_SHIFT	0
@@ -1029,36 +1032,39 @@ static int c_can_poll(struct napi_struct *napi, int quota)
 	u16 curr, last = priv->last_status;
 	int work_done = 0;
 
-	priv->last_status = curr = priv->read_reg(priv, C_CAN_STS_REG);
-	/* Ack status on C_CAN. D_CAN is self clearing */
-	if (priv->type != BOSCH_D_CAN)
-		priv->write_reg(priv, C_CAN_STS_REG, LEC_UNUSED);
-
-	/* handle state changes */
-	if ((curr & STATUS_EWARN) && (!(last & STATUS_EWARN))) {
-		netdev_dbg(dev, "entered error warning state\n");
-		work_done += c_can_handle_state_change(dev, C_CAN_ERROR_WARNING);
-	}
+	/* Only read the status register if a status interrupt was pending */
+	if (atomic_xchg(&priv->sie_pending, 0)) {
+		priv->last_status = curr = priv->read_reg(priv, C_CAN_STS_REG);
+		/* Ack status on C_CAN. D_CAN is self clearing */
+		if (priv->type != BOSCH_D_CAN)
+			priv->write_reg(priv, C_CAN_STS_REG, LEC_UNUSED);
+
+		/* handle state changes */
+		if ((curr & STATUS_EWARN) && (!(last & STATUS_EWARN))) {
+			netdev_dbg(dev, "entered error warning state\n");
+			work_done += c_can_handle_state_change(dev, C_CAN_ERROR_WARNING);
+		}
 
-	if ((curr & STATUS_EPASS) && (!(last & STATUS_EPASS))) {
-		netdev_dbg(dev, "entered error passive state\n");
-		work_done += c_can_handle_state_change(dev, C_CAN_ERROR_PASSIVE);
-	}
+		if ((curr & STATUS_EPASS) && (!(last & STATUS_EPASS))) {
+			netdev_dbg(dev, "entered error passive state\n");
+			work_done += c_can_handle_state_change(dev, C_CAN_ERROR_PASSIVE);
+		}
 
-	if ((curr & STATUS_BOFF) && (!(last & STATUS_BOFF))) {
-		netdev_dbg(dev, "entered bus off state\n");
-		work_done += c_can_handle_state_change(dev, C_CAN_BUS_OFF);
-		goto end;
-	}
+		if ((curr & STATUS_BOFF) && (!(last & STATUS_BOFF))) {
+			netdev_dbg(dev, "entered bus off state\n");
+			work_done += c_can_handle_state_change(dev, C_CAN_BUS_OFF);
+			goto end;
+		}
 
-	/* handle bus recovery events */
-	if ((!(curr & STATUS_BOFF)) && (last & STATUS_BOFF)) {
-		netdev_dbg(dev, "left bus off state\n");
-		priv->can.state = CAN_STATE_ERROR_ACTIVE;
-	}
-	if ((!(curr & STATUS_EPASS)) && (last & STATUS_EPASS)) {
-		netdev_dbg(dev, "left error passive state\n");
-		priv->can.state = CAN_STATE_ERROR_ACTIVE;
+		/* handle bus recovery events */
+		if ((!(curr & STATUS_BOFF)) && (last & STATUS_BOFF)) {
+			netdev_dbg(dev, "left bus off state\n");
+			priv->can.state = CAN_STATE_ERROR_ACTIVE;
+		}
+		if ((!(curr & STATUS_EPASS)) && (last & STATUS_EPASS)) {
+			netdev_dbg(dev, "left error passive state\n");
+			priv->can.state = CAN_STATE_ERROR_ACTIVE;
+		}
 	}
 
 	/* handle lec errors on the bus */
@@ -1083,10 +1089,16 @@ static irqreturn_t c_can_isr(int irq, void *dev_id)
 {
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct c_can_priv *priv = netdev_priv(dev);
+	int intreg;
 
-	if (!priv->read_reg(priv, C_CAN_INT_REG))
+	intreg = priv->read_reg(priv, C_CAN_INT_REG);
+	if (!intreg)
 		return IRQ_NONE;
 
+	/* save for later use */
+	if (intreg & INT_STS_PENDING)
+		atomic_set(&priv->sie_pending, 1);
+
 	/* disable all interrupts and schedule the NAPI */
 	c_can_irq_control(priv, false);
 	napi_schedule(&priv->napi);
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 8acdc7f..d5567a7 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -198,6 +198,7 @@ struct c_can_priv {
 	struct net_device *dev;
 	struct device *device;
 	atomic_t tx_active;
+	atomic_t sie_pending;
 	unsigned long tx_dir;
 	int last_status;
 	u16 (*read_reg) (const struct c_can_priv *priv, enum reg index);
-- 
1.8.5.rc3

