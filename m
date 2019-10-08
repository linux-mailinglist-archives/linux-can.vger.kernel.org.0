Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F888CF695
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2019 11:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbfJHJ5K (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Oct 2019 05:57:10 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46531 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbfJHJ5K (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Oct 2019 05:57:10 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iHmEu-00031I-Mf; Tue, 08 Oct 2019 11:57:08 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        Joe Burmeister <joe.burmeister@devtank.co.uk>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2] can: c_can: c_can_poll(): only read status register after status IRQ
Date:   Tue,  8 Oct 2019 11:57:07 +0200
Message-Id: <20191008095707.23902-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

When the status register is read without status IRQ pending, it may get
into a state that it goes into busoff state without having its irq
activated, so the driver wil never know.

Thanks to Wolfgang and Joe for bringing up the first idea.

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Joe Burmeister <joe.burmeister@devtank.co.uk>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

as mentioned in another mail, I'll take this patch for the can branch to
fix this problem before switching to rx-offload.

Marc

changes since v1:
- c_can_isr(): rename intreg -> reg_into to match name scheme in driver.

 drivers/net/can/c_can/c_can.c | 25 ++++++++++++++++++++-----
 drivers/net/can/c_can/c_can.h |  1 +
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index e1e9b87dd4d2..8e9f5620c9a2 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -98,6 +98,9 @@
 #define BTR_TSEG2_SHIFT		12
 #define BTR_TSEG2_MASK		(0x7 << BTR_TSEG2_SHIFT)
 
+/* interrupt register */
+#define INT_STS_PENDING		0x8000
+
 /* brp extension register */
 #define BRP_EXT_BRPE_MASK	0x0f
 #define BRP_EXT_BRPE_SHIFT	0
@@ -1065,10 +1068,16 @@ static int c_can_poll(struct napi_struct *napi, int quota)
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
+	} else {
+		/* no change detected ... */
+		curr = last;
+	}
 
 	/* handle state changes */
 	if ((curr & STATUS_EWARN) && (!(last & STATUS_EWARN))) {
@@ -1125,10 +1134,16 @@ static irqreturn_t c_can_isr(int irq, void *dev_id)
 {
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct c_can_priv *priv = netdev_priv(dev);
+	int reg_int;
 
-	if (!priv->read_reg(priv, C_CAN_INT_REG))
+	reg_int = priv->read_reg(priv, C_CAN_INT_REG);
+	if (!reg_int)
 		return IRQ_NONE;
 
+	/* save for later use */
+	if (reg_int & INT_STS_PENDING)
+		atomic_set(&priv->sie_pending, 1);
+
 	/* disable all interrupts and schedule the NAPI */
 	c_can_irq_control(priv, false);
 	napi_schedule(&priv->napi);
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 8acdc7fa4792..d5567a7c1c6d 100644
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
2.23.0

