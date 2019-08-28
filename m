Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14FF39FAD4
	for <lists+linux-can@lfdr.de>; Wed, 28 Aug 2019 08:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfH1Gwd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Aug 2019 02:52:33 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41183 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfH1Gwb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Aug 2019 02:52:31 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1i2rok-0002oO-5J; Wed, 28 Aug 2019 08:52:30 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH 08/21] can: af_can: rename find_rcv_list() to can_rcv_list_find()
Date:   Wed, 28 Aug 2019 08:52:13 +0200
Message-Id: <20190828065226.23604-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190828065226.23604-1-mkl@pengutronix.de>
References: <20190828065226.23604-1-mkl@pengutronix.de>
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

This patch add the commonly used prefix "can_" to the find_rcv_list()
function and add the "find" to the end, as the function returns a struct
rcv_list. This improves the overall readability of the code.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/af_can.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 0d51c06a88ac..0b008187a840 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -331,7 +331,7 @@ static unsigned int effhash(canid_t can_id)
 }
 
 /**
- * find_rcv_list - determine optimal filterlist inside device filter struct
+ * can_rcv_list_find - determine optimal filterlist inside device filter struct
  * @can_id: pointer to CAN identifier of a given can_filter
  * @mask: pointer to CAN mask of a given can_filter
  * @d: pointer to the device filter struct
@@ -357,8 +357,8 @@ static unsigned int effhash(canid_t can_id)
  *  Constistency checked mask.
  *  Reduced can_id to have a preprocessed filter compare value.
  */
-static struct hlist_head *find_rcv_list(canid_t *can_id, canid_t *mask,
-					struct can_dev_rcv_lists *dev_rcv_lists)
+static struct hlist_head *can_rcv_list_find(canid_t *can_id, canid_t *mask,
+					    struct can_dev_rcv_lists *dev_rcv_lists)
 {
 	canid_t inv = *can_id & CAN_INV_FILTER; /* save flag before masking */
 
@@ -460,7 +460,7 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 
 	dev_rcv_lists = find_dev_rcv_lists(net, dev);
 	if (dev_rcv_lists) {
-		rl = find_rcv_list(&can_id, &mask, dev_rcv_lists);
+		rl = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
 
 		r->can_id  = can_id;
 		r->mask    = mask;
@@ -533,7 +533,7 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 		goto out;
 	}
 
-	rl = find_rcv_list(&can_id, &mask, dev_rcv_lists);
+	rl = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
 
 	/* Search the receiver list for the item to delete.  This should
 	 * exist, since no receiver may be unregistered that hasn't
-- 
2.23.0.rc1

