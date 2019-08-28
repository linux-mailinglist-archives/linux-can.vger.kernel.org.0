Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2219C9FADF
	for <lists+linux-can@lfdr.de>; Wed, 28 Aug 2019 08:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfH1Gwf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Aug 2019 02:52:35 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34139 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfH1Gwe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Aug 2019 02:52:34 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1i2rom-0002oO-NS; Wed, 28 Aug 2019 08:52:32 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH 15/21] can: af_can: remove NULL-ptr checks from users of can_dev_rcv_lists_find()
Date:   Wed, 28 Aug 2019 08:52:20 +0200
Message-Id: <20190828065226.23604-16-mkl@pengutronix.de>
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

Since using the "struct can_ml_priv" for the per device "struct
dev_rcv_lists" the call can_dev_rcv_lists_find() cannot fail anymore.
This patch simplifies af_can by removing the NULL pointer checks from
the dev_rcv_lists returned by can_dev_rcv_lists_find().

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/af_can.c | 45 ++++++++++++++++-----------------------------
 1 file changed, 16 insertions(+), 29 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 6ed85e2f72f0..25f0d510e1bf 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -462,28 +462,22 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 	spin_lock(&net->can.rcvlists_lock);
 
 	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
-	if (dev_rcv_lists) {
-		rcv_list = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
-
-		rcv->can_id = can_id;
-		rcv->mask = mask;
-		rcv->matches = 0;
-		rcv->func = func;
-		rcv->data = data;
-		rcv->ident = ident;
-		rcv->sk = sk;
-
-		hlist_add_head_rcu(&rcv->list, rcv_list);
-		dev_rcv_lists->entries++;
-
-		rcv_lists_stats->rcv_entries++;
-		rcv_lists_stats->rcv_entries_max = max(rcv_lists_stats->rcv_entries_max,
-						       rcv_lists_stats->rcv_entries);
-	} else {
-		kmem_cache_free(rcv_cache, rcv);
-		err = -ENODEV;
-	}
+	rcv_list = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
+
+	rcv->can_id = can_id;
+	rcv->mask = mask;
+	rcv->matches = 0;
+	rcv->func = func;
+	rcv->data = data;
+	rcv->ident = ident;
+	rcv->sk = sk;
 
+	hlist_add_head_rcu(&rcv->list, rcv_list);
+	dev_rcv_lists->entries++;
+
+	rcv_lists_stats->rcv_entries++;
+	rcv_lists_stats->rcv_entries_max = max(rcv_lists_stats->rcv_entries_max,
+					       rcv_lists_stats->rcv_entries);
 	spin_unlock(&net->can.rcvlists_lock);
 
 	return err;
@@ -530,12 +524,6 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	spin_lock(&net->can.rcvlists_lock);
 
 	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
-	if (!dev_rcv_lists) {
-		pr_err("BUG: receive list not found for dev %s, id %03X, mask %03X\n",
-		       DNAME(dev), can_id, mask);
-		goto out;
-	}
-
 	rcv_list = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
 
 	/* Search the receiver list for the item to delete.  This should
@@ -668,8 +656,7 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 
 	/* find receive list for this device */
 	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
-	if (dev_rcv_lists)
-		matches += can_rcv_filter(dev_rcv_lists, skb);
+	matches += can_rcv_filter(dev_rcv_lists, skb);
 
 	rcu_read_unlock();
 
-- 
2.23.0.rc1

