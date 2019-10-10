Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7754D2E31
	for <lists+linux-can@lfdr.de>; Thu, 10 Oct 2019 17:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfJJPxo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 10 Oct 2019 11:53:44 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52311 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJPxo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Oct 2019 11:53:44 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iIal5-0004vS-7X; Thu, 10 Oct 2019 17:53:43 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Jeroen Hofstee <jhofstee@victronenergy.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2] can: ti_hecc: add fifo overflow error reporting
Date:   Thu, 10 Oct 2019 17:53:41 +0200
Message-Id: <20191010155341.5991-1-mkl@pengutronix.de>
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

From: Jeroen Hofstee <jhofstee@victronenergy.com>

When the rx FIFO overflows the ti_hecc would silently drop them since
the overwrite protection is enabled for all mailboxes. So disable it
for the lowest priority mailbox and increment the rx_over_errors when
receive message lost is set. Drop the message itself in that case,
since it might be partially updated.

Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

changes since v1:
- introduce HECC_RX_LAST_MBOX and make use of it
- check for overflow only if HECC_RX_LAST_MBOX is read
- move overflow check to beginning of ti_hecc_mailbox_read()

Marc

 drivers/net/can/ti_hecc.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 6ea29126c60b..87815a5b9170 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -73,6 +73,7 @@ MODULE_VERSION(HECC_MODULE_VERSION);
  */
 #define HECC_MAX_RX_MBOX	(HECC_MAX_MAILBOXES - HECC_MAX_TX_MBOX)
 #define HECC_RX_FIRST_MBOX	(HECC_MAX_MAILBOXES - 1)
+#define HECC_RX_LAST_MBOX	(HECC_MAX_TX_MBOX)
 
 /* TI HECC module registers */
 #define HECC_CANME		0x0	/* Mailbox enable */
@@ -82,7 +83,7 @@ MODULE_VERSION(HECC_MODULE_VERSION);
 #define HECC_CANTA		0x10	/* Transmission acknowledge */
 #define HECC_CANAA		0x14	/* Abort acknowledge */
 #define HECC_CANRMP		0x18	/* Receive message pending */
-#define HECC_CANRML		0x1C	/* Remote message lost */
+#define HECC_CANRML		0x1C	/* Receive message lost */
 #define HECC_CANRFP		0x20	/* Remote frame pending */
 #define HECC_CANGAM		0x24	/* SECC only:Global acceptance mask */
 #define HECC_CANMC		0x28	/* Master control */
@@ -385,8 +386,15 @@ static void ti_hecc_start(struct net_device *ndev)
 	/* Enable tx interrupts */
 	hecc_set_bit(priv, HECC_CANMIM, BIT(HECC_MAX_TX_MBOX) - 1);
 
-	/* Prevent message over-write & Enable interrupts */
-	hecc_write(priv, HECC_CANOPC, HECC_SET_REG);
+	/* Prevent message over-write to create a rx fifo, but not for
+	 * the lowest priority mailbox, since that allows detecting
+	 * overflows instead of the hardware silently dropping the
+	 * messages.
+	 */
+	mbx_mask = ~BIT(HECC_RX_LAST_MBOX);
+	hecc_write(priv, HECC_CANOPC, mbx_mask);
+
+	/* Enable interrupts */
 	if (priv->use_hecc1int) {
 		hecc_write(priv, HECC_CANMIL, HECC_SET_REG);
 		hecc_write(priv, HECC_CANGIM, HECC_CANGIM_DEF_MASK |
@@ -531,8 +539,22 @@ static unsigned int ti_hecc_mailbox_read(struct can_rx_offload *offload,
 {
 	struct ti_hecc_priv *priv = rx_offload_to_priv(offload);
 	u32 data, mbx_mask;
+	int ret = 1;
 
 	mbx_mask = BIT(mbxno);
+
+	/* check if the last mailbox has been overwritten */
+	if (unlikely(mbxno == HECC_RX_LAST_MBOX)) {
+		data = hecc_read(priv, HECC_CANRML);
+		if (unlikely(data & mbx_mask)) {
+			offload->dev->stats.rx_over_errors++;
+			offload->dev->stats.rx_errors++;
+
+			ret = 0;
+			goto mark_ask_read;
+		}
+	}
+
 	data = hecc_read_mbx(priv, mbxno, HECC_CANMID);
 	if (data & HECC_CANMID_IDE)
 		cf->can_id = (data & CAN_EFF_MASK) | CAN_EFF_FLAG;
@@ -552,9 +574,11 @@ static unsigned int ti_hecc_mailbox_read(struct can_rx_offload *offload,
 	}
 
 	*timestamp = hecc_read_stamp(priv, mbxno);
+
+ mark_as_read:
 	hecc_write(priv, HECC_CANRMP, mbx_mask);
 
-	return 1;
+	return ret;
 }
 
 static int ti_hecc_error(struct net_device *ndev, int int_status,
@@ -884,7 +908,7 @@ static int ti_hecc_probe(struct platform_device *pdev)
 
 	priv->offload.mailbox_read = ti_hecc_mailbox_read;
 	priv->offload.mb_first = HECC_RX_FIRST_MBOX;
-	priv->offload.mb_last = HECC_MAX_TX_MBOX;
+	priv->offload.mb_last = HECC_RX_LAST_MBOX;
 	err = can_rx_offload_add_timestamp(ndev, &priv->offload);
 	if (err) {
 		dev_err(&pdev->dev, "can_rx_offload_add_timestamp() failed\n");
-- 
2.23.0

