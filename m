Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E546FA8081
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2019 12:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbfIDKoL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Sep 2019 06:44:11 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43871 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729537AbfIDKoK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Sep 2019 06:44:10 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1i5Slk-0003XS-UG; Wed, 04 Sep 2019 12:44:09 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2 07/21] can: proc: give variable holding the CAN per device receive lists a sensible name
Date:   Wed,  4 Sep 2019 12:43:51 +0200
Message-Id: <20190904104405.21675-8-mkl@pengutronix.de>
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

This patch gives the variables holding the CAN per device receive filter lists
a better name by renaming them from "d" to "dev_rcv_lists".

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/proc.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/net/can/proc.c b/net/can/proc.c
index 6561d74a1012..560fa3c132bf 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -300,11 +300,11 @@ static int can_version_proc_show(struct seq_file *m, void *v)
 
 static inline void can_rcvlist_proc_show_one(struct seq_file *m, int idx,
 					     struct net_device *dev,
-					     struct can_dev_rcv_lists *d)
+					     struct can_dev_rcv_lists *dev_rcv_lists)
 {
-	if (!hlist_empty(&d->rx[idx])) {
+	if (!hlist_empty(&dev_rcv_lists->rx[idx])) {
 		can_print_recv_banner(m);
-		can_print_rcvlist(m, &d->rx[idx], dev);
+		can_print_rcvlist(m, &dev_rcv_lists->rx[idx], dev);
 	} else
 		seq_printf(m, "  (%s: no entry)\n", DNAME(dev));
 
@@ -315,7 +315,7 @@ static int can_rcvlist_proc_show(struct seq_file *m, void *v)
 	/* double cast to prevent GCC warning */
 	int idx = (int)(long)PDE_DATA(m->file->f_inode);
 	struct net_device *dev;
-	struct can_dev_rcv_lists *d;
+	struct can_dev_rcv_lists *dev_rcv_lists;
 	struct net *net = m->private;
 
 	seq_printf(m, "\nreceive list '%s':\n", rx_list_name[idx]);
@@ -323,8 +323,8 @@ static int can_rcvlist_proc_show(struct seq_file *m, void *v)
 	rcu_read_lock();
 
 	/* receive list for 'all' CAN devices (dev == NULL) */
-	d = net->can.rx_alldev_list;
-	can_rcvlist_proc_show_one(m, idx, NULL, d);
+	dev_rcv_lists = net->can.rx_alldev_list;
+	can_rcvlist_proc_show_one(m, idx, NULL, dev_rcv_lists);
 
 	/* receive list for registered CAN devices */
 	for_each_netdev_rcu(net, dev) {
@@ -366,7 +366,7 @@ static inline void can_rcvlist_proc_show_array(struct seq_file *m,
 static int can_rcvlist_sff_proc_show(struct seq_file *m, void *v)
 {
 	struct net_device *dev;
-	struct can_dev_rcv_lists *d;
+	struct can_dev_rcv_lists *dev_rcv_lists;
 	struct net *net = m->private;
 
 	/* RX_SFF */
@@ -375,15 +375,16 @@ static int can_rcvlist_sff_proc_show(struct seq_file *m, void *v)
 	rcu_read_lock();
 
 	/* sff receive list for 'all' CAN devices (dev == NULL) */
-	d = net->can.rx_alldev_list;
-	can_rcvlist_proc_show_array(m, NULL, d->rx_sff, ARRAY_SIZE(d->rx_sff));
+	dev_rcv_lists = net->can.rx_alldev_list;
+	can_rcvlist_proc_show_array(m, NULL, dev_rcv_lists->rx_sff,
+				    ARRAY_SIZE(dev_rcv_lists->rx_sff));
 
 	/* sff receive list for registered CAN devices */
 	for_each_netdev_rcu(net, dev) {
 		if (dev->type == ARPHRD_CAN && dev->ml_priv) {
-			d = dev->ml_priv;
-			can_rcvlist_proc_show_array(m, dev, d->rx_sff,
-						    ARRAY_SIZE(d->rx_sff));
+			dev_rcv_lists = dev->ml_priv;
+			can_rcvlist_proc_show_array(m, dev, dev_rcv_lists->rx_sff,
+						    ARRAY_SIZE(dev_rcv_lists->rx_sff));
 		}
 	}
 
@@ -396,7 +397,7 @@ static int can_rcvlist_sff_proc_show(struct seq_file *m, void *v)
 static int can_rcvlist_eff_proc_show(struct seq_file *m, void *v)
 {
 	struct net_device *dev;
-	struct can_dev_rcv_lists *d;
+	struct can_dev_rcv_lists *dev_rcv_lists;
 	struct net *net = m->private;
 
 	/* RX_EFF */
@@ -405,15 +406,16 @@ static int can_rcvlist_eff_proc_show(struct seq_file *m, void *v)
 	rcu_read_lock();
 
 	/* eff receive list for 'all' CAN devices (dev == NULL) */
-	d = net->can.rx_alldev_list;
-	can_rcvlist_proc_show_array(m, NULL, d->rx_eff, ARRAY_SIZE(d->rx_eff));
+	dev_rcv_lists = net->can.rx_alldev_list;
+	can_rcvlist_proc_show_array(m, NULL, dev_rcv_lists->rx_eff,
+				    ARRAY_SIZE(dev_rcv_lists->rx_eff));
 
 	/* eff receive list for registered CAN devices */
 	for_each_netdev_rcu(net, dev) {
 		if (dev->type == ARPHRD_CAN && dev->ml_priv) {
-			d = dev->ml_priv;
-			can_rcvlist_proc_show_array(m, dev, d->rx_eff,
-						    ARRAY_SIZE(d->rx_eff));
+			dev_rcv_lists = dev->ml_priv;
+			can_rcvlist_proc_show_array(m, dev, dev_rcv_lists->rx_eff,
+						    ARRAY_SIZE(dev_rcv_lists->rx_eff));
 		}
 	}
 
-- 
2.23.0.rc1

