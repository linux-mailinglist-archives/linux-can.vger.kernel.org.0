Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1546E5B5ED9
	for <lists+linux-can@lfdr.de>; Mon, 12 Sep 2022 19:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiILRHz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 12 Sep 2022 13:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiILRHv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 12 Sep 2022 13:07:51 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D1B26540
        for <linux-can@vger.kernel.org>; Mon, 12 Sep 2022 10:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1663002466;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=UrBXyW76rPjNLlMZfhhBPiCueFecxce9IEa8SNfTwhY=;
    b=F7K6OZZqNkv8kxJ0AGslmvnD03ijJiToLgguZI9Zf3EKAcVfm0Hum4fV0isuuygx4F
    xRQa0s3aQB+EKg0Qy5L6zWP4WkPpdAaMPzo8nq6cU2ncz7FLHGd8oejDdCUNSiU9ZTyo
    izpWjyeOcF2o8a2c7cQVAv9bJCLS9pe3F5A3Kag42vZxgsL7Kk9MvhIdLnHNHnfq94Hp
    CBIN2n3/86JxvbEvjNNTAkBQPMZ/r8gdOBiY1z0C8FjRwjdYlGPvOHp3ruHoEJBHDWO1
    OtX+e4/C9Y+Le5zt8pbsdHKcOi8SorGNH5JAFbgzhTsNwjgRnwxeUSqtwQpGgd+z7csw
    BD2w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JiLceSWJaYxMWqfZ"
X-RZG-CLASS-ID: mo01
Received: from silver.lan
    by smtp.strato.de (RZmta 48.1.0 AUTH)
    with ESMTPSA id d25a93y8CH7k1OA
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 12 Sep 2022 19:07:46 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v9 5/7] can: canxl: update CAN infrastructure for CAN XL frames
Date:   Mon, 12 Sep 2022 19:07:23 +0200
Message-Id: <20220912170725.120748-6-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220912170725.120748-1-socketcan@hartkopp.net>
References: <20220912170725.120748-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

- add new ETH_P_CANXL ethernet protocol type
- update skb checks for CAN XL
- add alloc_canxl_skb() which now needs a data length parameter
- introduce init_can_skb_reserve() to reduce code duplication

Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/skb.c     | 72 ++++++++++++++++++++++++++---------
 include/linux/can/skb.h       | 23 ++++++++++-
 include/uapi/linux/if_ether.h |  1 +
 net/can/af_can.c              | 25 +++++++++++-
 4 files changed, 101 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index adb413bdd734..791a51e2f5d6 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -185,10 +185,24 @@ void can_free_echo_skb(struct net_device *dev, unsigned int idx,
 		priv->echo_skb[idx] = NULL;
 	}
 }
 EXPORT_SYMBOL_GPL(can_free_echo_skb);
 
+/* fill common values for CAN sk_buffs */
+static void init_can_skb_reserve(struct sk_buff *skb)
+{
+	skb->pkt_type = PACKET_BROADCAST;
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	skb_reset_mac_header(skb);
+	skb_reset_network_header(skb);
+	skb_reset_transport_header(skb);
+
+	can_skb_reserve(skb);
+	can_skb_prv(skb)->skbcnt = 0;
+}
+
 struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 {
 	struct sk_buff *skb;
 
 	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
@@ -198,20 +212,12 @@ struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 
 		return NULL;
 	}
 
 	skb->protocol = htons(ETH_P_CAN);
-	skb->pkt_type = PACKET_BROADCAST;
-	skb->ip_summed = CHECKSUM_UNNECESSARY;
-
-	skb_reset_mac_header(skb);
-	skb_reset_network_header(skb);
-	skb_reset_transport_header(skb);
-
-	can_skb_reserve(skb);
+	init_can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	*cf = skb_put_zero(skb, sizeof(struct can_frame));
 
 	return skb;
 }
@@ -229,30 +235,55 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 
 		return NULL;
 	}
 
 	skb->protocol = htons(ETH_P_CANFD);
-	skb->pkt_type = PACKET_BROADCAST;
-	skb->ip_summed = CHECKSUM_UNNECESSARY;
-
-	skb_reset_mac_header(skb);
-	skb_reset_network_header(skb);
-	skb_reset_transport_header(skb);
-
-	can_skb_reserve(skb);
+	init_can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	*cfd = skb_put_zero(skb, sizeof(struct canfd_frame));
 
 	/* set CAN FD flag by default */
 	(*cfd)->flags = CANFD_FDF;
 
 	return skb;
 }
 EXPORT_SYMBOL_GPL(alloc_canfd_skb);
 
+struct sk_buff *alloc_canxl_skb(struct net_device *dev,
+				struct canxl_frame **cxl,
+				unsigned int data_len)
+{
+	struct sk_buff *skb;
+
+	if (data_len < CANXL_MIN_DLEN || data_len > CANXL_MAX_DLEN)
+		goto out_error;
+
+	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
+			       CANXL_HDR_SIZE + data_len);
+	if (unlikely(!skb))
+		goto out_error;
+
+	skb->protocol = htons(ETH_P_CANXL);
+	init_can_skb_reserve(skb);
+	can_skb_prv(skb)->ifindex = dev->ifindex;
+
+	*cxl = skb_put_zero(skb, CANXL_HDR_SIZE + data_len);
+
+	/* set CAN XL flag and length information by default */
+	(*cxl)->flags = CANXL_XLF;
+	(*cxl)->len = data_len;
+
+	return skb;
+
+out_error:
+	*cxl = NULL;
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(alloc_canxl_skb);
+
 struct sk_buff *alloc_can_err_skb(struct net_device *dev, struct can_frame **cf)
 {
 	struct sk_buff *skb;
 
 	skb = alloc_can_skb(dev, cf);
@@ -317,10 +348,15 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
 	case ETH_P_CANFD:
 		if (!can_is_canfd_skb(skb))
 			goto inval_skb;
 		break;
 
+	case ETH_P_CANXL:
+		if (!can_is_canxl_skb(skb))
+			goto inval_skb;
+		break;
+
 	default:
 		goto inval_skb;
 	}
 
 	if (!can_skb_headroom_valid(dev, skb)) {
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index ddffc2fc008c..1abc25a8d144 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -28,10 +28,13 @@ unsigned int __must_check can_get_echo_skb(struct net_device *dev,
 void can_free_echo_skb(struct net_device *dev, unsigned int idx,
 		       unsigned int *frame_len_ptr);
 struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf);
 struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 				struct canfd_frame **cfd);
+struct sk_buff *alloc_canxl_skb(struct net_device *dev,
+				struct canxl_frame **cxl,
+				unsigned int data_len);
 struct sk_buff *alloc_can_err_skb(struct net_device *dev,
 				  struct can_frame **cf);
 bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb);
 
 /*
@@ -112,15 +115,33 @@ static inline bool can_is_canfd_skb(const struct sk_buff *skb)
 
 	/* the CAN specific type of skb is identified by its data length */
 	return (skb->len == CANFD_MTU && cfd->len <= CANFD_MAX_DLEN);
 }
 
-/* get length element value from can[fd]_frame structure */
+static inline bool can_is_canxl_skb(const struct sk_buff *skb)
+{
+	const struct canxl_frame *cxl = (struct canxl_frame *)skb->data;
+
+	if (skb->len < CANXL_HDR_SIZE + CANXL_MIN_DLEN || skb->len > CANXL_MTU)
+		return false;
+
+	/* this also checks valid CAN XL data length boundaries */
+	if (skb->len != CANXL_HDR_SIZE + cxl->len)
+		return false;
+
+	return cxl->flags & CANXL_XLF;
+}
+
+/* get length element value from can[|fd|xl]_frame structure */
 static inline unsigned int can_skb_get_len_val(struct sk_buff *skb)
 {
+	const struct canxl_frame *cxl = (struct canxl_frame *)skb->data;
 	const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 
+	if (can_is_canxl_skb(skb))
+		return cxl->len;
+
 	return cfd->len;
 }
 
 /* get needed data length inside CAN frame for all frame types (RTR aware) */
 static inline unsigned int can_skb_get_data_len(struct sk_buff *skb)
diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
index d370165bc621..69e0457eb200 100644
--- a/include/uapi/linux/if_ether.h
+++ b/include/uapi/linux/if_ether.h
@@ -136,10 +136,11 @@
 #define ETH_P_WAN_PPP   0x0007          /* Dummy type for WAN PPP frames*/
 #define ETH_P_PPP_MP    0x0008          /* Dummy type for PPP MP frames */
 #define ETH_P_LOCALTALK 0x0009		/* Localtalk pseudo type 	*/
 #define ETH_P_CAN	0x000C		/* CAN: Controller Area Network */
 #define ETH_P_CANFD	0x000D		/* CANFD: CAN flexible data rate*/
+#define ETH_P_CANXL	0x000E		/* CANXL: eXtended frame Length */
 #define ETH_P_PPPTALK	0x0010		/* Dummy type for Atalk over PPP*/
 #define ETH_P_TR_802_2	0x0011		/* 802.2 frames 		*/
 #define ETH_P_MOBITEX	0x0015		/* Mobitex (kaz@cafe.net)	*/
 #define ETH_P_CONTROL	0x0016		/* Card specific control frames */
 #define ETH_P_IRDA	0x0017		/* Linux-IrDA			*/
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 072a6a5c9dd1..9503ab10f9b8 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -200,11 +200,13 @@ int can_send(struct sk_buff *skb, int loop)
 {
 	struct sk_buff *newskb = NULL;
 	struct can_pkg_stats *pkg_stats = dev_net(skb->dev)->can.pkg_stats;
 	int err = -EINVAL;
 
-	if (can_is_can_skb(skb)) {
+	if (can_is_canxl_skb(skb)) {
+		skb->protocol = htons(ETH_P_CANXL);
+	} else if (can_is_can_skb(skb)) {
 		skb->protocol = htons(ETH_P_CAN);
 	} else if (can_is_canfd_skb(skb)) {
 		struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 
 		skb->protocol = htons(ETH_P_CANFD);
@@ -700,10 +702,25 @@ static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 
 	can_receive(skb, dev);
 	return NET_RX_SUCCESS;
 }
 
+static int canxl_rcv(struct sk_buff *skb, struct net_device *dev,
+		     struct packet_type *pt, struct net_device *orig_dev)
+{
+	if (unlikely(dev->type != ARPHRD_CAN || (!can_is_canxl_skb(skb)))) {
+		pr_warn_once("PF_CAN: dropped non conform CAN XL skbuff: dev type %d, len %d\n",
+			     dev->type, skb->len);
+
+		kfree_skb(skb);
+		return NET_RX_DROP;
+	}
+
+	can_receive(skb, dev);
+	return NET_RX_SUCCESS;
+}
+
 /* af_can protocol functions */
 
 /**
  * can_proto_register - register CAN transport protocol
  * @cp: pointer to CAN protocol structure
@@ -824,10 +841,15 @@ static struct packet_type can_packet __read_mostly = {
 static struct packet_type canfd_packet __read_mostly = {
 	.type = cpu_to_be16(ETH_P_CANFD),
 	.func = canfd_rcv,
 };
 
+static struct packet_type canxl_packet __read_mostly = {
+	.type = cpu_to_be16(ETH_P_CANXL),
+	.func = canxl_rcv,
+};
+
 static const struct net_proto_family can_family_ops = {
 	.family = PF_CAN,
 	.create = can_create,
 	.owner  = THIS_MODULE,
 };
@@ -863,10 +885,11 @@ static __init int can_init(void)
 	if (err)
 		goto out_sock;
 
 	dev_add_pack(&can_packet);
 	dev_add_pack(&canfd_packet);
+	dev_add_pack(&canxl_packet);
 
 	return 0;
 
 out_sock:
 	unregister_pernet_subsys(&can_pernet_ops);
-- 
2.30.2

