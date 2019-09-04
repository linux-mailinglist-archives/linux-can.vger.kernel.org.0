Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6423AA8089
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2019 12:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfIDKoO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Sep 2019 06:44:14 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50457 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfIDKoO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Sep 2019 06:44:14 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1i5Slo-0003XS-N2; Wed, 04 Sep 2019 12:44:12 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2 13/21] can: introduce CAN midlayer private and allocate it automatically
Date:   Wed,  4 Sep 2019 12:43:57 +0200
Message-Id: <20190904104405.21675-14-mkl@pengutronix.de>
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

This patch introduces the CAN midlayer private structure ("struct
can_ml_priv") which should be used to hold protocol specific per device
data structures. For now it's only member is "struct can_dev_rcv_lists".

The CAN midlayer private is allocated via alloc_netdev()'s private and
assigned to "struct net_device::ml_priv" during device creation. This is
done transparently for CAN drivers using alloc_candev(). The slcan, vcan
and vxcan drivers which are not using alloc_candev() have been adopted
manually. The memory layout of the netdev_priv allocated via
alloc_candev() will looke like this:

  +-------------------------+
  | driver's priv           |
  +-------------------------+
  | struct can_ml_priv      |
  +-------------------------+
  | array of struct sk_buff |
  +-------------------------+

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c      | 22 ++++++++++---
 drivers/net/can/slcan.c    |  5 ++-
 drivers/net/can/vcan.c     |  6 ++--
 drivers/net/can/vxcan.c    |  3 +-
 include/linux/can/can-ml.h | 66 ++++++++++++++++++++++++++++++++++++++
 net/can/af_can.c           |  1 +
 net/can/af_can.h           | 15 ---------
 net/can/proc.c             |  1 +
 8 files changed, 96 insertions(+), 23 deletions(-)
 create mode 100644 include/linux/can/can-ml.h

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 483d270664cc..9e688dc29521 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -12,6 +12,7 @@
 #include <linux/if_arp.h>
 #include <linux/workqueue.h>
 #include <linux/can.h>
+#include <linux/can/can-ml.h>
 #include <linux/can/dev.h>
 #include <linux/can/skb.h>
 #include <linux/can/netlink.h>
@@ -718,11 +719,24 @@ struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
 	struct can_priv *priv;
 	int size;
 
+	/* We put the driver's priv, the CAN mid layer priv and the
+	 * echo skb into the netdevice's priv. The memory layout for
+	 * the netdev_priv is like this:
+	 *
+	 * +-------------------------+
+	 * | driver's priv           |
+	 * +-------------------------+
+	 * | struct can_ml_priv      |
+	 * +-------------------------+
+	 * | array of struct sk_buff |
+	 * +-------------------------+
+	 */
+
+	size = ALIGN(sizeof_priv, NETDEV_ALIGN) + sizeof(struct can_ml_priv);
+
 	if (echo_skb_max)
-		size = ALIGN(sizeof_priv, sizeof(struct sk_buff *)) +
+		size = ALIGN(size, sizeof(struct sk_buff *)) +
 			echo_skb_max * sizeof(struct sk_buff *);
-	else
-		size = sizeof_priv;
 
 	dev = alloc_netdev_mqs(size, "can%d", NET_NAME_UNKNOWN, can_setup,
 			       txqs, rxqs);
@@ -735,7 +749,7 @@ struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
 	if (echo_skb_max) {
 		priv->echo_skb_max = echo_skb_max;
 		priv->echo_skb = (void *)priv +
-			ALIGN(sizeof_priv, sizeof(struct sk_buff *));
+			(size - echo_skb_max * sizeof(struct sk_buff *));
 	}
 
 	priv->state = CAN_STATE_STOPPED;
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index aa97dbc797b6..5b2e95425e69 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -55,6 +55,7 @@
 #include <linux/workqueue.h>
 #include <linux/can.h>
 #include <linux/can/skb.h>
+#include <linux/can/can-ml.h>
 
 MODULE_ALIAS_LDISC(N_SLCAN);
 MODULE_DESCRIPTION("serial line CAN interface");
@@ -514,6 +515,7 @@ static struct slcan *slc_alloc(void)
 	char name[IFNAMSIZ];
 	struct net_device *dev = NULL;
 	struct slcan       *sl;
+	int size;
 
 	for (i = 0; i < maxdev; i++) {
 		dev = slcan_devs[i];
@@ -527,7 +529,8 @@ static struct slcan *slc_alloc(void)
 		return NULL;
 
 	sprintf(name, "slcan%d", i);
-	dev = alloc_netdev(sizeof(*sl), name, NET_NAME_UNKNOWN, slc_setup);
+	size = ALIGN(sizeof(*sl), NETDEV_ALIGN) + sizeof(struct can_ml_priv);
+	dev = alloc_netdev(size, name, NET_NAME_UNKNOWN, slc_setup);
 	if (!dev)
 		return NULL;
 
diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
index daf27133887b..6973ae09a37a 100644
--- a/drivers/net/can/vcan.c
+++ b/drivers/net/can/vcan.c
@@ -46,6 +46,7 @@
 #include <linux/if_arp.h>
 #include <linux/if_ether.h>
 #include <linux/can.h>
+#include <linux/can/can-ml.h>
 #include <linux/can/dev.h>
 #include <linux/can/skb.h>
 #include <linux/slab.h>
@@ -162,8 +163,9 @@ static void vcan_setup(struct net_device *dev)
 }
 
 static struct rtnl_link_ops vcan_link_ops __read_mostly = {
-	.kind	= DRV_NAME,
-	.setup	= vcan_setup,
+	.kind = DRV_NAME,
+	.priv_size = sizeof(struct can_ml_priv),
+	.setup = vcan_setup,
 };
 
 static __init int vcan_init_module(void)
diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index b2106292230e..4c3eed796432 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -18,6 +18,7 @@
 #include <linux/can/dev.h>
 #include <linux/can/skb.h>
 #include <linux/can/vxcan.h>
+#include <linux/can/can-ml.h>
 #include <linux/slab.h>
 #include <net/rtnetlink.h>
 
@@ -281,7 +282,7 @@ static struct net *vxcan_get_link_net(const struct net_device *dev)
 
 static struct rtnl_link_ops vxcan_link_ops = {
 	.kind		= DRV_NAME,
-	.priv_size	= sizeof(struct vxcan_priv),
+	.priv_size	= ALIGN(sizeof(struct vxcan_priv), NETDEV_ALIGN) + sizeof(struct can_ml_priv),
 	.setup		= vxcan_setup,
 	.newlink	= vxcan_newlink,
 	.dellink	= vxcan_dellink,
diff --git a/include/linux/can/can-ml.h b/include/linux/can/can-ml.h
new file mode 100644
index 000000000000..0a9d778de8af
--- /dev/null
+++ b/include/linux/can/can-ml.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/* Copyright (c) 2002-2007 Volkswagen Group Electronic Research
+ * Copyright (c) 2017 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of Volkswagen nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * Alternatively, provided that this notice is retained in full, this
+ * software may be distributed under the terms of the GNU General
+ * Public License ("GPL") version 2, in which case the provisions of the
+ * GPL apply INSTEAD OF those given above.
+ *
+ * The provided data structures and external interfaces from this code
+ * are not restricted to be used by modules with a GPL compatible license.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ *
+ */
+
+#ifndef CAN_ML_H
+#define CAN_ML_H
+
+#include <linux/can.h>
+#include <linux/list.h>
+
+#define CAN_SFF_RCV_ARRAY_SZ (1 << CAN_SFF_ID_BITS)
+#define CAN_EFF_RCV_HASH_BITS 10
+#define CAN_EFF_RCV_ARRAY_SZ (1 << CAN_EFF_RCV_HASH_BITS)
+
+enum { RX_ERR, RX_ALL, RX_FIL, RX_INV, RX_MAX };
+
+struct can_dev_rcv_lists {
+	struct hlist_head rx[RX_MAX];
+	struct hlist_head rx_sff[CAN_SFF_RCV_ARRAY_SZ];
+	struct hlist_head rx_eff[CAN_EFF_RCV_ARRAY_SZ];
+	int remove_on_zero_entries;
+	int entries;
+};
+
+struct can_ml_priv {
+	struct can_dev_rcv_lists dev_rcv_lists;
+};
+
+#endif /* CAN_ML_H */
diff --git a/net/can/af_can.c b/net/can/af_can.c
index d65b19003a24..723299daa04e 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -58,6 +58,7 @@
 #include <linux/can.h>
 #include <linux/can/core.h>
 #include <linux/can/skb.h>
+#include <linux/can/can-ml.h>
 #include <linux/ratelimit.h>
 #include <net/net_namespace.h>
 #include <net/sock.h>
diff --git a/net/can/af_can.h b/net/can/af_can.h
index 25d22e534506..7c2d9161e224 100644
--- a/net/can/af_can.h
+++ b/net/can/af_can.h
@@ -60,21 +60,6 @@ struct receiver {
 	struct rcu_head rcu;
 };
 
-#define CAN_SFF_RCV_ARRAY_SZ (1 << CAN_SFF_ID_BITS)
-#define CAN_EFF_RCV_HASH_BITS 10
-#define CAN_EFF_RCV_ARRAY_SZ (1 << CAN_EFF_RCV_HASH_BITS)
-
-enum { RX_ERR, RX_ALL, RX_FIL, RX_INV, RX_MAX };
-
-/* per device receive filters linked at dev->ml_priv */
-struct can_dev_rcv_lists {
-	struct hlist_head rx[RX_MAX];
-	struct hlist_head rx_sff[CAN_SFF_RCV_ARRAY_SZ];
-	struct hlist_head rx_eff[CAN_EFF_RCV_ARRAY_SZ];
-	int remove_on_zero_entries;
-	int entries;
-};
-
 /* statistic structures */
 
 /* can be reset e.g. by can_init_stats() */
diff --git a/net/can/proc.c b/net/can/proc.c
index 560fa3c132bf..e6881bfc3ed1 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -45,6 +45,7 @@
 #include <linux/list.h>
 #include <linux/rcupdate.h>
 #include <linux/if_arp.h>
+#include <linux/can/can-ml.h>
 #include <linux/can/core.h>
 
 #include "af_can.h"
-- 
2.23.0.rc1

