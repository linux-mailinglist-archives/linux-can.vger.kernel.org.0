Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7D409FADE
	for <lists+linux-can@lfdr.de>; Wed, 28 Aug 2019 08:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfH1Gwf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Aug 2019 02:52:35 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37977 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfH1Gwe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Aug 2019 02:52:34 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1i2rom-0002oO-DQ; Wed, 28 Aug 2019 08:52:32 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH 14/21] can: make use of preallocated can_ml_priv for per device struct can_dev_rcv_lists
Date:   Wed, 28 Aug 2019 08:52:19 +0200
Message-Id: <20190828065226.23604-15-mkl@pengutronix.de>
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

This patch removes the old method of allocating the per device protocol
specific memory via a netdevice_notifier. This had the drawback, that
the allocation can fail, leading to a lot of null pointer checks in the
code. This also makes the live cycle management of this memory quite
complicated.

This patch switches from the allocating the struct can_dev_rcv_lists in
a NETDEV_REGISTER call to using the dev->ml_priv, which is allocated by
the driver since the previous patch.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c   |  2 ++
 drivers/net/can/slcan.c |  1 +
 drivers/net/can/vcan.c  |  1 +
 drivers/net/can/vxcan.c |  1 +
 net/can/af_can.c        | 45 +++++++----------------------------------
 net/can/af_can.h        |  1 -
 6 files changed, 12 insertions(+), 39 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 9e688dc29521..b429550c4cc2 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -746,6 +746,8 @@ struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
 	priv = netdev_priv(dev);
 	priv->dev = dev;
 
+	dev->ml_priv = (void *)priv + ALIGN(sizeof_priv, NETDEV_ALIGN);
+
 	if (echo_skb_max) {
 		priv->echo_skb_max = echo_skb_max;
 		priv->echo_skb = (void *)priv +
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 5b2e95425e69..bb6032211043 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -536,6 +536,7 @@ static struct slcan *slc_alloc(void)
 
 	dev->base_addr  = i;
 	sl = netdev_priv(dev);
+	dev->ml_priv = (void *)sl + ALIGN(sizeof(*sl), NETDEV_ALIGN);
 
 	/* Initialize channel control data */
 	sl->magic = SLCAN_MAGIC;
diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
index 6973ae09a37a..39ca14b0585d 100644
--- a/drivers/net/can/vcan.c
+++ b/drivers/net/can/vcan.c
@@ -153,6 +153,7 @@ static void vcan_setup(struct net_device *dev)
 	dev->addr_len		= 0;
 	dev->tx_queue_len	= 0;
 	dev->flags		= IFF_NOARP;
+	dev->ml_priv		= netdev_priv(dev);
 
 	/* set flags according to driver capabilities */
 	if (echo)
diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 4c3eed796432..d6ba9426be4d 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -147,6 +147,7 @@ static void vxcan_setup(struct net_device *dev)
 	dev->flags		= (IFF_NOARP|IFF_ECHO);
 	dev->netdev_ops		= &vxcan_netdev_ops;
 	dev->needs_free_netdev	= true;
+	dev->ml_priv		= netdev_priv(dev) + ALIGN(sizeof(struct vxcan_priv), NETDEV_ALIGN);
 }
 
 /* forward declaration for rtnl_create_link() */
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 723299daa04e..6ed85e2f72f0 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -302,10 +302,12 @@ EXPORT_SYMBOL(can_send);
 static struct can_dev_rcv_lists *can_dev_rcv_lists_find(struct net *net,
 							struct net_device *dev)
 {
-	if (!dev)
+	if (dev) {
+		struct can_ml_priv *ml_priv = dev->ml_priv;
+		return &ml_priv->dev_rcv_lists;
+	} else {
 		return net->can.rx_alldev_list;
-	else
-		return (struct can_dev_rcv_lists *)dev->ml_priv;
+	}
 }
 
 /**
@@ -561,12 +563,6 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	if (rcv_lists_stats->rcv_entries > 0)
 		rcv_lists_stats->rcv_entries--;
 
-	/* remove device structure requested by NETDEV_UNREGISTER */
-	if (dev_rcv_lists->remove_on_zero_entries && !dev_rcv_lists->entries) {
-		kfree(dev_rcv_lists);
-		dev->ml_priv = NULL;
-	}
-
  out:
 	spin_unlock(&net->can.rcvlists_lock);
 
@@ -788,41 +784,14 @@ static int can_notifier(struct notifier_block *nb, unsigned long msg,
 			void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
-	struct can_dev_rcv_lists *dev_rcv_lists;
 
 	if (dev->type != ARPHRD_CAN)
 		return NOTIFY_DONE;
 
 	switch (msg) {
 	case NETDEV_REGISTER:
-
-		/* create new dev_rcv_lists for this device */
-		dev_rcv_lists = kzalloc(sizeof(*dev_rcv_lists), GFP_KERNEL);
-		if (!dev_rcv_lists)
-			return NOTIFY_DONE;
-		BUG_ON(dev->ml_priv);
-		dev->ml_priv = dev_rcv_lists;
-
-		break;
-
-	case NETDEV_UNREGISTER:
-		spin_lock(&dev_net(dev)->can.rcvlists_lock);
-
-		dev_rcv_lists = dev->ml_priv;
-		if (dev_rcv_lists) {
-			if (dev_rcv_lists->entries)
-				dev_rcv_lists->remove_on_zero_entries = 1;
-			else {
-				kfree(dev_rcv_lists);
-				dev->ml_priv = NULL;
-			}
-		} else {
-			pr_err("can: notifier: receive list not found for dev %s\n",
-			       dev->name);
-		}
-
-		spin_unlock(&dev_net(dev)->can.rcvlists_lock);
-
+		WARN(!dev->ml_priv,
+		     "No CAN mid layer private allocated, please fix your driver and use alloc_candev()!\n");
 		break;
 	}
 
diff --git a/net/can/af_can.h b/net/can/af_can.h
index 25d22e534506..56a31a99bc6e 100644
--- a/net/can/af_can.h
+++ b/net/can/af_can.h
@@ -71,7 +71,6 @@ struct can_dev_rcv_lists {
 	struct hlist_head rx[RX_MAX];
 	struct hlist_head rx_sff[CAN_SFF_RCV_ARRAY_SZ];
 	struct hlist_head rx_eff[CAN_EFF_RCV_ARRAY_SZ];
-	int remove_on_zero_entries;
 	int entries;
 };
 
-- 
2.23.0.rc1

