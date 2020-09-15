Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7E426B1BE
	for <lists+linux-can@lfdr.de>; Wed, 16 Sep 2020 00:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgIOWf4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Sep 2020 18:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbgIOWfo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Sep 2020 18:35:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76349C0612F2
        for <linux-can@vger.kernel.org>; Tue, 15 Sep 2020 15:35:34 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kIJXw-0002Tb-DA; Wed, 16 Sep 2020 00:35:32 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 12/37] can: dev: can_change_state(): print human readable state change messages
Date:   Wed, 16 Sep 2020 00:35:02 +0200
Message-Id: <20200915223527.1417033-13-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915223527.1417033-1-mkl@pengutronix.de>
References: <20200915223527.1417033-1-mkl@pengutronix.de>
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

In order to ease debugging let can_change_state() print the human readable
state change messages. Also print the old and new state.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 77a5663693af..e0caf969e342 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -371,6 +371,28 @@ static int can_rx_state_to_frame(struct net_device *dev, enum can_state state)
 	}
 }
 
+static const char *can_get_state_str(const enum can_state state)
+{
+	switch (state) {
+	case CAN_STATE_ERROR_ACTIVE:
+		return "Error Active";
+	case CAN_STATE_ERROR_WARNING:
+		return "Error Warning";
+	case CAN_STATE_ERROR_PASSIVE:
+		return "Error Passive";
+	case CAN_STATE_BUS_OFF:
+		return "Bus Off";
+	case CAN_STATE_STOPPED:
+		return "Stopped";
+	case CAN_STATE_SLEEPING:
+		return "Sleeping";
+	default:
+		return "<unknown>";
+	}
+
+	return "<unknown>";
+}
+
 void can_change_state(struct net_device *dev, struct can_frame *cf,
 		      enum can_state tx_state, enum can_state rx_state)
 {
@@ -382,7 +404,9 @@ void can_change_state(struct net_device *dev, struct can_frame *cf,
 		return;
 	}
 
-	netdev_dbg(dev, "New error state: %d\n", new_state);
+	netdev_dbg(dev, "Controller changed from %s State (%d) into %s State (%d).\n",
+		   can_get_state_str(priv->state), priv->state,
+		   can_get_state_str(new_state), new_state);
 
 	can_update_state_error_stats(dev, new_state);
 	priv->state = new_state;
-- 
2.28.0

