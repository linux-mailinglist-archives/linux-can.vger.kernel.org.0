Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B1957526C
	for <lists+linux-can@lfdr.de>; Thu, 14 Jul 2022 18:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbiGNQGB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 14 Jul 2022 12:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237822AbiGNQGA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 14 Jul 2022 12:06:00 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4614E5F113
        for <linux-can@vger.kernel.org>; Thu, 14 Jul 2022 09:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657814754;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=HLm9c+NpqRBJ/KnXV228ASuCgwfHV4fmif/5yud39gE=;
    b=H8EF4TsDfbCS5isLSIskRBRQnOB1h4KostmJT+BhtexQz4HqeEinJvQEWc2LTxl68f
    WQXGJXc661gg6t+87jsiEIguI9LCyvNNmouvBH/v4mr7lzsE+YtafkrfetoYRYBp/z0c
    cY9dkKPwFMcRvGFSaP/dhn5MDFSlHa9p5TvzNMvvP9iLASwCouKvQcKwNK1d+8SIEwV+
    gBrUpBHRYa0KiqO4UANPiYAcAwwel/zD5hQpbMJjFcc+5TmVSUua89u8s0Xu+JcM4N/N
    JXzc6QAU3c5zhcfQJ5DgoG9wKvW3yuK+DiPE2OjzPDD+MTaxsPDd+kDXXUgRmH/PkLG8
    Ru0g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JiLceSWJaYwXDKPZ"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6EG5s6ew
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 14 Jul 2022 18:05:54 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH v2 2/5] can: canxl: introduce ETH_P_CANXL ethernet protocol handling
Date:   Thu, 14 Jul 2022 18:05:38 +0200
Message-Id: <20220714160541.2071-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220714160541.2071-1-socketcan@hartkopp.net>
References: <20220714160541.2071-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Enable the PF_CAN infrastructure to handle CAN XL frames. A new ethernet
protocol type ETH_P_CANXL is defined to tag skbuffs containing the CAN XL
frame data structure.

As the length information is now a uint16 value for CAN XL three new
helper functions have been introduced to retrieve the data length from
all types of CAN frames.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/skb.h       | 39 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/if_ether.h |  1 +
 net/can/af_can.c              | 36 +++++++++++++++++++++++++-------
 3 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index 182749e858b3..87698eac2f15 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -101,6 +101,45 @@ static inline bool can_is_canfd_skb(const struct sk_buff *skb)
 {
 	/* the CAN specific type of skb is identified by its data length */
 	return skb->len == CANFD_MTU;
 }
 
+static inline bool can_is_canxl_skb(const struct sk_buff *skb)
+{
+	const struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
+
+	if (skb->len < CANXL_MINTU || skb->len > CANXL_MTU)
+		return false;
+
+	/* this also checks valid CAN XL data length boundaries */
+	if (skb->len != CANXL_HEAD_SZ + cfx->len)
+		return false;
+
+	return cfx->flags & CANXL_XLF;
+}
+
+/* get length element value from can[|fd|xl]_frame structure */
+static inline unsigned int can_skb_get_len_val(struct sk_buff *skb)
+{
+	const struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
+	const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
+
+	if (can_is_canxl_skb(skb))
+		return cfx->len;
+
+	return cfd->len;
+}
+
+/* get needed data length inside of CAN frame for all frame types (RTR aware) */
+static inline unsigned int can_skb_get_data_len(struct sk_buff *skb)
+{
+	unsigned int len = can_skb_get_len_val(skb);
+	const struct can_frame *cf = (struct can_frame *)skb->data;
+
+	/* RTR frames have an actual length of zero */
+	if (skb->len == CAN_MTU && cf->can_id & CAN_RTR_FLAG)
+		return 0;
+
+	return len;
+}
+
 #endif /* !_CAN_SKB_H */
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
index 1fb49d51b25d..979b1c481dbb 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -199,29 +199,30 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
 int can_send(struct sk_buff *skb, int loop)
 {
 	struct sk_buff *newskb = NULL;
 	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 	struct can_pkg_stats *pkg_stats = dev_net(skb->dev)->can.pkg_stats;
+	unsigned int mtu = skb->len;
 	int err = -EINVAL;
 
-	if (skb->len == CAN_MTU) {
+	if (can_is_canxl_skb(skb)) {
+		skb->protocol = htons(ETH_P_CANXL);
+		mtu = CANXL_MTU;
+	} else if (mtu == CAN_MTU) {
 		skb->protocol = htons(ETH_P_CAN);
 		if (unlikely(cfd->len > CAN_MAX_DLEN))
 			goto inval_skb;
-	} else if (skb->len == CANFD_MTU) {
+	} else if (mtu == CANFD_MTU) {
 		skb->protocol = htons(ETH_P_CANFD);
 		if (unlikely(cfd->len > CANFD_MAX_DLEN))
 			goto inval_skb;
 	} else {
 		goto inval_skb;
 	}
 
-	/* Make sure the CAN frame can pass the selected CAN netdevice.
-	 * As structs can_frame and canfd_frame are similar, we can provide
-	 * CAN FD frames to legacy CAN drivers as long as the length is <= 8
-	 */
-	if (unlikely(skb->len > skb->dev->mtu && cfd->len > CAN_MAX_DLEN)) {
+	/* Make sure the CAN frame can pass the selected CAN netdevice */
+	if (unlikely(mtu > skb->dev->mtu)) {
 		err = -EMSGSIZE;
 		goto inval_skb;
 	}
 
 	if (unlikely(skb->dev->type != ARPHRD_CAN)) {
@@ -725,10 +726,25 @@ static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 free_skb:
 	kfree_skb(skb);
 	return NET_RX_DROP;
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
@@ -849,10 +865,15 @@ static struct packet_type can_packet __read_mostly = {
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
@@ -888,10 +909,11 @@ static __init int can_init(void)
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

