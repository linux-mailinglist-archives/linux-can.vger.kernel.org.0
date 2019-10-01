Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 172DBC2E4D
	for <lists+linux-can@lfdr.de>; Tue,  1 Oct 2019 09:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733081AbfJAHk4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 1 Oct 2019 03:40:56 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:60038 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732954AbfJAHkz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 1 Oct 2019 03:40:55 -0400
X-ASG-Debug-ID: 1569915652-0a7b8d53c2e3e0a0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.119.18.adsl.dyn.edpnet.net [77.109.119.18]) by relay-b02.edpnet.be with ESMTP id G7z7TCVZAPAR1waZ; Tue, 01 Oct 2019 09:40:52 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Apparent-Source-IP: 77.109.119.18
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id B9AFEA1D9CD;
        Tue,  1 Oct 2019 09:40:51 +0200 (CEST)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     dev.kurt@vandijck-laurijssen.be, jhofstee@victronenergy.com,
        Wolfgang Grandegger <wg@grandegger.com>,
        Joe Burmeister <joe.burmeister@devtank.co.uk>
Subject: [PATCH 1/3] net can c_can: only read status register after status irq
Date:   Tue,  1 Oct 2019 09:40:36 +0200
X-ASG-Orig-Subj: [PATCH 1/3] net can c_can: only read status register after status irq
Message-Id: <1569915638-4605-2-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1569915638-4605-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <1569915638-4605-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Start-Time: 1569915652
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 2863
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.6073 1.0000 0.7839
X-Barracuda-Spam-Score: 1.28
X-Barracuda-Spam-Status: No, SCORE=1.28 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.76991
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
Thanks to Wolfgang and Joe for bringing up the first idea.

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
CC: Wolfgang Grandegger <wg@grandegger.com>
CC: Joe Burmeister <joe.burmeister@devtank.co.uk>
---
 drivers/net/can/c_can/c_can.c | 24 +++++++++++++++++++-----
 drivers/net/can/c_can/c_can.h |  1 +
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 606b7d8..b8e395a3 100644
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
@@ -1029,10 +1032,15 @@ static int c_can_poll(struct napi_struct *napi, int quota)
 	u16 curr, last = priv->last_status;
 	int work_done = 0;
 
-	priv->last_status = curr = priv->read_reg(priv, C_CAN_STS_REG);
-	/* Ack status on C_CAN. D_CAN is self clearing */
-	if (priv->type != BOSCH_D_CAN)
-		priv->write_reg(priv, C_CAN_STS_REG, LEC_UNUSED);
+	/* Only read the status register if a status interrupt was pending */
+	if (atomic_xchg(&priv->sie_pending, 0)) {
+		priv->last_status = curr = priv->read_reg(priv, C_CAN_STS_REG);
+		/* Ack status on C_CAN. D_CAN is self clearing */
+		if (priv->type != BOSCH_D_CAN)
+			priv->write_reg(priv, C_CAN_STS_REG, LEC_UNUSED);
+	} else
+		/* no change detected ... */
+		curr = last;
 
 	/* handle state changes */
 	if ((curr & STATUS_EWARN) && (!(last & STATUS_EWARN))) {
@@ -1083,10 +1091,16 @@ static irqreturn_t c_can_isr(int irq, void *dev_id)
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

