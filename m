Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C445870A9
	for <lists+linux-can@lfdr.de>; Mon,  1 Aug 2022 21:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbiHATAb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 1 Aug 2022 15:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiHATA3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 1 Aug 2022 15:00:29 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76729BF4D
        for <linux-can@vger.kernel.org>; Mon,  1 Aug 2022 12:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1659380421;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mzjPzDXqaoYaCIDPax32Ri39+fRG/dQ2ATFnn1JaeEM=;
    b=YZaEXBeoEiHTVneCPxXLh/GdkO0hYng48C12/+rKtSj6lrO/YYNYPQfZqogpiHFx8J
    xBkhgP1vnR+pyBATluMzLc743D3inbWafi9H5Yc+NbjWpANek6SdNL+fZiRO3mRIwRle
    AT9Leds45sHoNlhwrwgis67d3ImEsVoN9lytwH3fFORW4V+D5o39grbBkLI57LfDDvC8
    0Y3hZE3OO4Fnbwqcf5Aa6FA9p1hjXFS/eqjhGG9xahU7JIWNgxguBlWyg8x0kTruwtV1
    wmoNuivDHeGZlBszU/Hd/5kl8bUAGSn6F6py2u7nI1cZOwEEulwie2IeQrBuYA6m1TP3
    Vf1w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JiLceSWJaYwXUKbZ"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id Icb1b0y71J0LHvz
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 1 Aug 2022 21:00:21 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v8 6/7] can: dev: add CAN XL support to virtual CAN
Date:   Mon,  1 Aug 2022 21:00:09 +0200
Message-Id: <20220801190010.3344-7-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220801190010.3344-1-socketcan@hartkopp.net>
References: <20220801190010.3344-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 36b6310a2e5b..285635c23443 100644
--- a/drivers/net/can/vcan.c
+++ b/drivers/net/can/vcan.c
@@ -69,33 +69,32 @@ static bool echo; /* echo testing. Default: 0 (Off) */
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
@@ -135,11 +134,12 @@ static int vcan_change_mtu(struct net_device *dev, int new_mtu)
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
index cffd107d8b28..26a472d2ea58 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -36,14 +36,13 @@ struct vxcan_priv {
 
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
@@ -68,11 +67,11 @@ static netdev_tx_t vxcan_xmit(struct sk_buff *oskb, struct net_device *dev)
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
@@ -130,11 +129,12 @@ static int vxcan_change_mtu(struct net_device *dev, int new_mtu)
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
index c3e50e537e39..58f5431a5559 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -145,10 +145,15 @@ static inline int __must_check can_set_static_ctrlmode(struct net_device *dev,
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

