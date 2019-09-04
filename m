Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFC4A808B
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2019 12:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbfIDKoP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Sep 2019 06:44:15 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43559 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729626AbfIDKoP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Sep 2019 06:44:15 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1i5Slp-0003XS-Ll; Wed, 04 Sep 2019 12:44:13 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 16/21] can: af_can: use spin_lock_bh() for &net->can.rcvlists_lock
Date:   Wed,  4 Sep 2019 12:44:00 +0200
Message-Id: <20190904104405.21675-17-mkl@pengutronix.de>
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

From: Oleksij Rempel <o.rempel@pengutronix.de>

The can_rx_unregister() can be called from NAPI (soft IRQ) context, at least
by j1939 stack. This leads to potential dead lock with &net->can.rcvlists_lock
called from can_rx_register:
===============================================================================
 WARNING: inconsistent lock state
 4.19.0-20181029-1-g3e67f95ba0d3 #3 Not tainted
 --------------------------------
 inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
 testj1939/224 [HC0[0]:SC1[1]:HE1:SE0] takes:
 1ad0fda3 (&(&net->can.rcvlists_lock)->rlock){+.?.}, at: can_rx_unregister+0x4c/0x1ac
 {SOFTIRQ-ON-W} state was registered at:
   lock_acquire+0xd0/0x1f4
   _raw_spin_lock+0x30/0x40
   can_rx_register+0x5c/0x14c
   j1939_netdev_start+0xdc/0x1f8
   j1939_sk_bind+0x18c/0x1c8
   __sys_bind+0x70/0xb0
   sys_bind+0x10/0x14
   ret_fast_syscall+0x0/0x28
   0xbedc9b64
 irq event stamp: 2440
 hardirqs last  enabled at (2440): [<c01302c0>] __local_bh_enable_ip+0xac/0x184
 hardirqs last disabled at (2439): [<c0130274>] __local_bh_enable_ip+0x60/0x184
 softirqs last  enabled at (2412): [<c08b0bf4>] release_sock+0x84/0xa4
 softirqs last disabled at (2415): [<c013055c>] irq_exit+0x100/0x1b0

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&(&net->can.rcvlists_lock)->rlock);
   <Interrupt>
     lock(&(&net->can.rcvlists_lock)->rlock);

  *** DEADLOCK ***

 2 locks held by testj1939/224:
  #0: 168eb13b (rcu_read_lock){....}, at: netif_receive_skb_internal+0x3c/0x350
  #1: 168eb13b (rcu_read_lock){....}, at: can_receive+0x88/0x1c0
===============================================================================

To avoid this situation, we should use spin_lock_bh() instead of spin_lock().

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/af_can.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 25f0d510e1bf..5518a7d9eed9 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -459,7 +459,7 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 	if (!rcv)
 		return -ENOMEM;
 
-	spin_lock(&net->can.rcvlists_lock);
+	spin_lock_bh(&net->can.rcvlists_lock);
 
 	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
 	rcv_list = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
@@ -478,7 +478,7 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 	rcv_lists_stats->rcv_entries++;
 	rcv_lists_stats->rcv_entries_max = max(rcv_lists_stats->rcv_entries_max,
 					       rcv_lists_stats->rcv_entries);
-	spin_unlock(&net->can.rcvlists_lock);
+	spin_unlock_bh(&net->can.rcvlists_lock);
 
 	return err;
 }
@@ -521,7 +521,7 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	if (dev && !net_eq(net, dev_net(dev)))
 		return;
 
-	spin_lock(&net->can.rcvlists_lock);
+	spin_lock_bh(&net->can.rcvlists_lock);
 
 	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
 	rcv_list = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
@@ -552,7 +552,7 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 		rcv_lists_stats->rcv_entries--;
 
  out:
-	spin_unlock(&net->can.rcvlists_lock);
+	spin_unlock_bh(&net->can.rcvlists_lock);
 
 	/* schedule the receiver item for deletion */
 	if (rcv) {
-- 
2.23.0.rc1

