Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9085B9FAE0
	for <lists+linux-can@lfdr.de>; Wed, 28 Aug 2019 08:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfH1Gwf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Aug 2019 02:52:35 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60625 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfH1Gwe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Aug 2019 02:52:34 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1i2rol-0002oO-Ss; Wed, 28 Aug 2019 08:52:31 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH 12/21] can: af_can: can_pernet_exit(): no need to iterate over and cleanup registered CAN devices
Date:   Wed, 28 Aug 2019 08:52:17 +0200
Message-Id: <20190828065226.23604-13-mkl@pengutronix.de>
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

The networking core takes care and unregisters every network device in
a namespace before calling the can_pernet_exit() hook. This patch
removes the unneeded cleanup.

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Suggested-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/af_can.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 28ea80274121..d65b19003a24 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -866,27 +866,12 @@ static int can_pernet_init(struct net *net)
 
 static void can_pernet_exit(struct net *net)
 {
-	struct net_device *dev;
-
 	if (IS_ENABLED(CONFIG_PROC_FS)) {
 		can_remove_proc(net);
 		if (stats_timer)
 			del_timer_sync(&net->can.stattimer);
 	}
 
-	/* remove created dev_rcv_lists from still registered CAN devices */
-	rcu_read_lock();
-	for_each_netdev_rcu(net, dev) {
-		if (dev->type == ARPHRD_CAN && dev->ml_priv) {
-			struct can_dev_rcv_lists *dev_rcv_lists = dev->ml_priv;
-
-			BUG_ON(dev_rcv_lists->entries);
-			kfree(dev_rcv_lists);
-			dev->ml_priv = NULL;
-		}
-	}
-	rcu_read_unlock();
-
 	kfree(net->can.rx_alldev_list);
 	kfree(net->can.pkg_stats);
 	kfree(net->can.rcv_lists_stats);
-- 
2.23.0.rc1

