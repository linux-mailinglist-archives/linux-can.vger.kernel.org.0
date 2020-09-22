Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417F2274489
	for <lists+linux-can@lfdr.de>; Tue, 22 Sep 2020 16:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgIVOok (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Sep 2020 10:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgIVOoh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Sep 2020 10:44:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F754C061755
        for <linux-can@vger.kernel.org>; Tue, 22 Sep 2020 07:44:37 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kKjX1-0001FU-FQ; Tue, 22 Sep 2020 16:44:35 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, michael@walle.cc, qiangqing.zhang@nxp.com,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 06/20] can: flexcan: Ack wakeup interrupt separately
Date:   Tue, 22 Sep 2020 16:44:15 +0200
Message-Id: <20200922144429.2613631-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922144429.2613631-1-mkl@pengutronix.de>
References: <20200922144429.2613631-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Joakim Zhang <qiangqing.zhang@nxp.com>

As FLEXCAN_ESR_ALL_INT is for all bus errors and state change IRQ
sources, strictly speaking FLEXCAN_ESR_WAK_INT does not belong to these.
So add wakeup interrupt ack separately to existing ack of the
interrupts.

Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Link: https://lore.kernel.org/r/20191204113249.3381-3-qiangqing.zhang@nxp.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index b180dd1ba763..06cddc468739 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -134,8 +134,7 @@
 	(FLEXCAN_ESR_ERR_BUS | FLEXCAN_ESR_ERR_STATE)
 #define FLEXCAN_ESR_ALL_INT \
 	(FLEXCAN_ESR_TWRN_INT | FLEXCAN_ESR_RWRN_INT | \
-	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT | \
-	 FLEXCAN_ESR_WAK_INT)
+	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT)
 
 /* FLEXCAN interrupt flag register (IFLAG) bits */
 /* Errata ERR005829 step7: Reserve first valid MB */
@@ -979,10 +978,10 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 
 	reg_esr = priv->read(&regs->esr);
 
-	/* ACK all bus error and state change IRQ sources */
-	if (reg_esr & FLEXCAN_ESR_ALL_INT) {
+	/* ACK all bus error, state change and wake IRQ sources */
+	if (reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_WAK_INT)) {
 		handled = IRQ_HANDLED;
-		priv->write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
+		priv->write(reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_WAK_INT), &regs->esr);
 	}
 
 	/* state change interrupt or broken error state quirk fix is enabled */
-- 
2.28.0

