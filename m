Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C1D577660
	for <lists+linux-can@lfdr.de>; Sun, 17 Jul 2022 15:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiGQN1l (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 17 Jul 2022 09:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbiGQN1j (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 17 Jul 2022 09:27:39 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E7E165AD
        for <linux-can@vger.kernel.org>; Sun, 17 Jul 2022 06:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658064455;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mZBMGCKTzkj0ROLQqCviPkGBOkaYBioNB0iEO8vpFg8=;
    b=iiC9h0X7z1kTIoGftb/0AU59QcQeSILMB79nFQ3/zgknnsu7wagWYNaF2OZGhpBx0N
    Te+Upi6QoPiRIw7XEA8DuELXSRIdr0oDoBQouJ0z8sbFLWfWyqEhqa4FIeDGjADbTWM9
    WnSx0KtrztF/ga8Vlul6dv9sWBgMvvtELT8tq/8QtB+w+fvbmA3Lcw4SK1L5z2TKy1N+
    EDnK2nu5q5xMfq3hC0mLoePnxNPLIcCO9oH6xdEBOHdsVcbKOi/3HpKmf/G51zzWIpC9
    VjrS9ZbZAL7NUvpdSUT2JrE3JEhEhEVsxPU3Rd6ZgExvoz5TIeCGu3ipffkx0TJtGNUy
    wlbw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JiLceSWJaYwXUKbZ"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6HDRZB7s
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 17 Jul 2022 15:27:35 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH v3 3/5] can: dev: add CAN XL support
Date:   Sun, 17 Jul 2022 15:27:28 +0200
Message-Id: <20220717132730.30295-4-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220717132730.30295-1-socketcan@hartkopp.net>
References: <20220717132730.30295-1-socketcan@hartkopp.net>
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

Extend the CAN device driver infrastructure to handle CAN XL frames.
This especially addresses the increased data length which is extended
to uint16 for CAN XL.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/rx-offload.c |  2 +-
 drivers/net/can/dev/skb.c        | 49 ++++++++++++++++++++++++++------
 include/linux/can/skb.h          |  5 +++-
 3 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
index a32a01c172d4..8505e547e922 100644
--- a/drivers/net/can/dev/rx-offload.c
+++ b/drivers/net/can/dev/rx-offload.c
@@ -245,11 +245,11 @@ unsigned int can_rx_offload_get_echo_skb(struct can_rx_offload *offload,
 					 unsigned int *frame_len_ptr)
 {
 	struct net_device *dev = offload->dev;
 	struct net_device_stats *stats = &dev->stats;
 	struct sk_buff *skb;
-	u8 len;
+	unsigned int len;
 	int err;
 
 	skb = __can_get_echo_skb(dev, idx, &len, frame_len_ptr);
 	if (!skb)
 		return 0;
diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 8bb62dd864c8..8531e0c39d1c 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -53,11 +53,12 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 	BUG_ON(idx >= priv->echo_skb_max);
 
 	/* check flag whether this packet has to be looped back */
 	if (!(dev->flags & IFF_ECHO) ||
 	    (skb->protocol != htons(ETH_P_CAN) &&
-	     skb->protocol != htons(ETH_P_CANFD))) {
+	     skb->protocol != htons(ETH_P_CANFD) &&
+	     skb->protocol != htons(ETH_P_CANXL))) {
 		kfree_skb(skb);
 		return 0;
 	}
 
 	if (!priv->echo_skb[idx]) {
@@ -86,12 +87,12 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(can_put_echo_skb);
 
 struct sk_buff *
-__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
-		   unsigned int *frame_len_ptr)
+__can_get_echo_skb(struct net_device *dev, unsigned int idx,
+		   unsigned int *len_ptr, unsigned int *frame_len_ptr)
 {
 	struct can_priv *priv = netdev_priv(dev);
 
 	if (idx >= priv->echo_skb_max) {
 		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
@@ -103,17 +104,13 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
 		/* Using "struct canfd_frame::len" for the frame
 		 * length is supported on both CAN and CANFD frames.
 		 */
 		struct sk_buff *skb = priv->echo_skb[idx];
 		struct can_skb_priv *can_skb_priv = can_skb_prv(skb);
-		struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 
 		/* get the real payload length for netdev statistics */
-		if (cf->can_id & CAN_RTR_FLAG)
-			*len_ptr = 0;
-		else
-			*len_ptr = cf->len;
+		*len_ptr = can_skb_get_data_len(skb);
 
 		if (frame_len_ptr)
 			*frame_len_ptr = can_skb_priv->frame_len;
 
 		priv->echo_skb[idx] = NULL;
@@ -139,11 +136,11 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
  */
 unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx,
 			      unsigned int *frame_len_ptr)
 {
 	struct sk_buff *skb;
-	u8 len;
+	unsigned int len;
 
 	skb = __can_get_echo_skb(dev, idx, &len, frame_len_ptr);
 	if (!skb)
 		return 0;
 
@@ -244,10 +241,41 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 
 	return skb;
 }
 EXPORT_SYMBOL_GPL(alloc_canfd_skb);
 
+struct sk_buff *alloc_canxl_skb(struct net_device *dev,
+				struct canxl_frame **cfx)
+{
+	struct sk_buff *skb;
+
+	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
+			       sizeof(struct canxl_frame));
+	if (unlikely(!skb)) {
+		*cfx = NULL;
+
+		return NULL;
+	}
+
+	skb->protocol = htons(ETH_P_CANXL);
+	skb->pkt_type = PACKET_BROADCAST;
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	skb_reset_mac_header(skb);
+	skb_reset_network_header(skb);
+	skb_reset_transport_header(skb);
+
+	can_skb_reserve(skb);
+	can_skb_prv(skb)->ifindex = dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
+
+	*cfx = skb_put_zero(skb, sizeof(struct canxl_frame));
+
+	return skb;
+}
+EXPORT_SYMBOL_GPL(alloc_canxl_skb);
+
 struct sk_buff *alloc_can_err_skb(struct net_device *dev, struct can_frame **cf)
 {
 	struct sk_buff *skb;
 
 	skb = alloc_can_skb(dev, cf);
@@ -302,10 +330,13 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
 			goto inval_skb;
 	} else if (skb->protocol == htons(ETH_P_CANFD)) {
 		if (unlikely(skb->len != CANFD_MTU ||
 			     cfd->len > CANFD_MAX_DLEN))
 			goto inval_skb;
+	} else if (skb->protocol == htons(ETH_P_CANXL)) {
+		if (unlikely(!can_is_canxl_skb(skb)))
+			goto inval_skb;
 	} else {
 		goto inval_skb;
 	}
 
 	if (!can_skb_headroom_valid(dev, skb)) {
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index 51481f5afe62..9972c9bd73bc 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -18,19 +18,22 @@
 
 void can_flush_echo_skb(struct net_device *dev);
 int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 		     unsigned int idx, unsigned int frame_len);
 struct sk_buff *__can_get_echo_skb(struct net_device *dev, unsigned int idx,
-				   u8 *len_ptr, unsigned int *frame_len_ptr);
+				   unsigned int *len_ptr,
+				   unsigned int *frame_len_ptr);
 unsigned int __must_check can_get_echo_skb(struct net_device *dev,
 					   unsigned int idx,
 					   unsigned int *frame_len_ptr);
 void can_free_echo_skb(struct net_device *dev, unsigned int idx,
 		       unsigned int *frame_len_ptr);
 struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf);
 struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 				struct canfd_frame **cfd);
+struct sk_buff *alloc_canxl_skb(struct net_device *dev,
+				struct canxl_frame **cfx);
 struct sk_buff *alloc_can_err_skb(struct net_device *dev,
 				  struct can_frame **cf);
 bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb);
 
 /*
-- 
2.30.2

