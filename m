Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74FB6A8082
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2019 12:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfIDKoL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Sep 2019 06:44:11 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56587 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729587AbfIDKoL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Sep 2019 06:44:11 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1i5Sll-0003XS-JI; Wed, 04 Sep 2019 12:44:09 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2 09/21] can: af_can: rename find_dev_rcv_lists() to can_dev_rcv_lists_find()
Date:   Wed,  4 Sep 2019 12:43:53 +0200
Message-Id: <20190904104405.21675-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190904104405.21675-1-mkl@pengutronix.de>
References: <20190904104405.21675-1-mkl@pengutronix.de>
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

This patch add the commonly used prefix "can_" to the find_dev_rcv_lists()
function and moves the "find" to the end, as the function returns a struct
can_dev_rcv_list. This improves the overall readability of the code.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/af_can.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 0b008187a840..a5bb364cbf61 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -298,8 +298,8 @@ EXPORT_SYMBOL(can_send);
 
 /* af_can rx path */
 
-static struct can_dev_rcv_lists *find_dev_rcv_lists(struct net *net,
-						    struct net_device *dev)
+static struct can_dev_rcv_lists *can_dev_rcv_lists_find(struct net *net,
+							struct net_device *dev)
 {
 	if (!dev)
 		return net->can.rx_alldev_list;
@@ -458,7 +458,7 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 
 	spin_lock(&net->can.rcvlists_lock);
 
-	dev_rcv_lists = find_dev_rcv_lists(net, dev);
+	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
 	if (dev_rcv_lists) {
 		rl = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
 
@@ -526,7 +526,7 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 
 	spin_lock(&net->can.rcvlists_lock);
 
-	dev_rcv_lists = find_dev_rcv_lists(net, dev);
+	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
 	if (!dev_rcv_lists) {
 		pr_err("BUG: receive list not found for dev %s, id %03X, mask %03X\n",
 		       DNAME(dev), can_id, mask);
@@ -671,7 +671,7 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 	matches = can_rcv_filter(net->can.rx_alldev_list, skb);
 
 	/* find receive list for this device */
-	dev_rcv_lists = find_dev_rcv_lists(net, dev);
+	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
 	if (dev_rcv_lists)
 		matches += can_rcv_filter(dev_rcv_lists, skb);
 
-- 
2.23.0.rc1

