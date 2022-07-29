Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E065852F8
	for <lists+linux-can@lfdr.de>; Fri, 29 Jul 2022 17:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbiG2Plc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 29 Jul 2022 11:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237961AbiG2PlT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 29 Jul 2022 11:41:19 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF3C86C24
        for <linux-can@vger.kernel.org>; Fri, 29 Jul 2022 08:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1659109274;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=DyC1Bci4NP0efT/OV+Vm8+N4maK529RK6bSh6buXtZ0=;
    b=OZ40HkFfx88p5B/WFV/TPiQ7ZoctikoE6wPueaXUYY0EHRW1Zr2jMCPK9sVeFk7t5Y
    BRYBUi68LcTtPPnu4SLgwVMqdD8Nz8s6FiU9pHkpCLAsTfE2W99JDP6iNmReU7haL8UA
    V7l0hahP2r+GnfYpBTOn+fYWU8GF0/CYQNNhd5hpSXWvmvQdw5XRsoAXw7PMJ3QXCmcl
    ry2AF0d4IbNeLXaCGuNoMogd8PEyNpYbiThY68GkMwO/KwY6jNKbugc2Kc3IAZMGmiBi
    6J2DZxUjEWk9KVGDdCkqRFGmf2pPuJovYouWEYbLREsu3cOL/YVpI/OBJF9v0zjlIRjl
    00ZQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JiLceSWJaYwXUKbZ"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id Icb1b0y6TFfECnt
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 29 Jul 2022 17:41:14 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v7 6/7] can: dev: add CAN XL support to virtual CAN
Date:   Fri, 29 Jul 2022 17:41:06 +0200
Message-Id: <20220729154107.1875-7-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220729154107.1875-1-socketcan@hartkopp.net>
References: <20220729154107.1875-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Make use of new can_skb_get_data_len() helper.
Add support for variable CANXL MTU using the new can_is_canxl_dev_mtu().

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/vcan.c  | 12 ++++++------
 drivers/net/can/vxcan.c |  8 ++++----
 include/linux/can/dev.h |  5 +++++
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
index a15619d883ec..6c4d4ef93e80 100644
--- a/drivers/net/can/vcan.c
+++ b/drivers/net/can/vcan.c
@@ -68,33 +68,32 @@ static bool echo; /* echo testing. Default: 0 (Off) */
 module_param(echo, bool, 0444);
 MODULE_PARM_DESC(echo, "Echo sent frames (for testing). Default: 0 (Off)");
 
 static void vcan_rx(struct sk_buff *skb, struct net_device *dev)
 {
-	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 	struct net_device_stats *stats = &dev->stats;
 
 	stats->rx_packets++;
-	stats->rx_bytes += cfd->len;
+	stats->rx_bytes += can_skb_get_data_len(skb);
 
 	skb->pkt_type  = PACKET_BROADCAST;
 	skb->dev       = dev;
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 	netif_rx(skb);
 }
 
 static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
 {
-	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 	struct net_device_stats *stats = &dev->stats;
-	int loop, len;
+	unsigned int len;
+	int loop;
 
 	if (can_dropped_invalid_skb(dev, skb))
 		return NETDEV_TX_OK;
 
-	len = cfd->can_id & CAN_RTR_FLAG ? 0 : cfd->len;
+	len = can_skb_get_data_len(skb);
 	stats->tx_packets++;
 	stats->tx_bytes += len;
 
 	/* set flag whether this packet has to be looped back */
 	loop = skb->pkt_type == PACKET_LOOPBACK;
@@ -132,11 +131,12 @@ static int vcan_change_mtu(struct net_device *dev, int new_mtu)
 {
 	/* Do not allow changing the MTU while running */
 	if (dev->flags & IFF_UP)
 		return -EBUSY;
 
-	if (new_mtu != CAN_MTU && new_mtu != CANFD_MTU)
+	if (new_mtu != CAN_MTU && new_mtu != CANFD_MTU &&
+	    !can_is_canxl_dev_mtu(new_mtu))
 		return -EINVAL;
 
 	dev->mtu = new_mtu;
 	return 0;
 }
diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 577a80300514..189f51428c24 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -35,14 +35,13 @@ struct vxcan_priv {
 
 static netdev_tx_t vxcan_xmit(struct sk_buff *oskb, struct net_device *dev)
 {
 	struct vxcan_priv *priv = netdev_priv(dev);
 	struct net_device *peer;
-	struct canfd_frame *cfd = (struct canfd_frame *)oskb->data;
 	struct net_device_stats *peerstats, *srcstats = &dev->stats;
 	struct sk_buff *skb;
-	u8 len;
+	unsigned int len;
 
 	if (can_dropped_invalid_skb(dev, oskb))
 		return NETDEV_TX_OK;
 
 	rcu_read_lock();
@@ -65,11 +64,11 @@ static netdev_tx_t vxcan_xmit(struct sk_buff *oskb, struct net_device *dev)
 	skb->csum_start = 0;
 	skb->pkt_type   = PACKET_BROADCAST;
 	skb->dev        = peer;
 	skb->ip_summed  = CHECKSUM_UNNECESSARY;
 
-	len = cfd->can_id & CAN_RTR_FLAG ? 0 : cfd->len;
+	len = can_skb_get_data_len(skb);
 	if (netif_rx(skb) == NET_RX_SUCCESS) {
 		srcstats->tx_packets++;
 		srcstats->tx_bytes += len;
 		peerstats = &peer->stats;
 		peerstats->rx_packets++;
@@ -127,11 +126,12 @@ static int vxcan_change_mtu(struct net_device *dev, int new_mtu)
 {
 	/* Do not allow changing the MTU while running */
 	if (dev->flags & IFF_UP)
 		return -EBUSY;
 
-	if (new_mtu != CAN_MTU && new_mtu != CANFD_MTU)
+	if (new_mtu != CAN_MTU && new_mtu != CANFD_MTU &&
+	    !can_is_canxl_dev_mtu(new_mtu))
 		return -EINVAL;
 
 	dev->mtu = new_mtu;
 	return 0;
 }
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index e22dc03c850e..8245ec7d2667 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -144,10 +144,15 @@ static inline int __must_check can_set_static_ctrlmode(struct net_device *dev,
 static inline u32 can_get_static_ctrlmode(struct can_priv *priv)
 {
 	return priv->ctrlmode & ~priv->ctrlmode_supported;
 }
 
+static inline bool can_is_canxl_dev_mtu(unsigned int mtu)
+{
+	return (mtu >= CANXL_MIN_MTU && mtu <= CANXL_MAX_MTU);
+}
+
 void can_setup(struct net_device *dev);
 
 struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
 				    unsigned int txqs, unsigned int rxqs);
 #define alloc_candev(sizeof_priv, echo_skb_max) \
-- 
2.30.2

