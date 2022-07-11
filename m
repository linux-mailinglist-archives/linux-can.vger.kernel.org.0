Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB26570A00
	for <lists+linux-can@lfdr.de>; Mon, 11 Jul 2022 20:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiGKSey (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Jul 2022 14:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiGKSew (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Jul 2022 14:34:52 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E915FAF0
        for <linux-can@vger.kernel.org>; Mon, 11 Jul 2022 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657564480;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=cwBb4DCPShTQMZ4BoyG9p77llosdfBP4f7C4iOG6s2g=;
    b=MGvwWPGHMTu9iZgpiCblJPMPbWr8LSMFiYehXRNjN+2SczQk4/RFnZqv+Ot3knZ+Kx
    63PmkRdKgB8+V2ZeBVzKjx/dS8LXUJ+vsY0H2YEHcSr1fai5fIHmJG9zuuQjR8OiajvD
    33MHashwcZqR3jQNthvyJBKc3gN5lP4mU2s6YbnElcZxz1CjgKVDME6low/W6+T5rNpE
    ZAtMokHtt5EXMht1Uqm4IN2X3ExAd8q6r0EOkVySJsnnoATkM4ycQaT6wlU0bECsx20C
    P7G3lBM1IngQpC9aYP5lye4m2vcx3iQt/zIvzkZHF4fNZtN+9nWrw19HOwgMbpfnzCPR
    txCA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JiLceSWJaYwXUKbZ"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.46.1 AUTH)
    with ESMTPSA id 398cccy6BIYeReM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 11 Jul 2022 20:34:40 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH 2/5] can: canxl: introduce ETH_P_CANXL ethernet protocol handling
Date:   Mon, 11 Jul 2022 20:34:23 +0200
Message-Id: <20220711183426.96446-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220711183426.96446-1-socketcan@hartkopp.net>
References: <20220711183426.96446-1-socketcan@hartkopp.net>
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

As the length information is now a uint16 value for CAN XL a new helper
function can_get_data_len() is introduced to retrieve the data length
from all types of CAN frames.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/skb.h       | 14 ++++++++++
 include/uapi/linux/if_ether.h |  1 +
 net/can/af_can.c              | 49 +++++++++++++++++++++++++++++------
 3 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index 182749e858b3..d043bc4afd6d 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -101,6 +101,20 @@ static inline bool can_is_canfd_skb(const struct sk_buff *skb)
 {
 	/* the CAN specific type of skb is identified by its data length */
 	return skb->len == CANFD_MTU;
 }
 
+/* get data length inside of CAN frame for all frame types */
+static inline unsigned int can_get_data_len(struct sk_buff *skb)
+{
+	if(skb->len == CANXL_MTU) {
+		const struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
+
+		return cfx->len;
+	} else {
+		const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
+
+		return cfd->len;
+	}
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
index 1fb49d51b25d..2c9f48aa5f1f 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -197,31 +197,32 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
  *  -EINVAL when the skb->data does not contain a valid CAN frame
  */
 int can_send(struct sk_buff *skb, int loop)
 {
 	struct sk_buff *newskb = NULL;
-	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
+	unsigned int len = can_get_data_len(skb);
 	struct can_pkg_stats *pkg_stats = dev_net(skb->dev)->can.pkg_stats;
 	int err = -EINVAL;
 
 	if (skb->len == CAN_MTU) {
 		skb->protocol = htons(ETH_P_CAN);
-		if (unlikely(cfd->len > CAN_MAX_DLEN))
+		if (unlikely(len > CAN_MAX_DLEN))
 			goto inval_skb;
 	} else if (skb->len == CANFD_MTU) {
 		skb->protocol = htons(ETH_P_CANFD);
-		if (unlikely(cfd->len > CANFD_MAX_DLEN))
+		if (unlikely(len > CANFD_MAX_DLEN))
+			goto inval_skb;
+	} else if (skb->len == CANXL_MTU) {
+		skb->protocol = htons(ETH_P_CANXL);
+		if (unlikely(len > CANXL_MAX_DLEN || len == 0))
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
+	if (unlikely(skb->len > skb->dev->mtu)) {
 		err = -EMSGSIZE;
 		goto inval_skb;
 	}
 
 	if (unlikely(skb->dev->type != ARPHRD_CAN)) {
@@ -725,10 +726,36 @@ static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 free_skb:
 	kfree_skb(skb);
 	return NET_RX_DROP;
 }
 
+static int canxl_rcv(struct sk_buff *skb, struct net_device *dev,
+		     struct packet_type *pt, struct net_device *orig_dev)
+{
+	struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
+
+	if (unlikely(dev->type != ARPHRD_CAN || skb->len != CANXL_MTU)) {
+		pr_warn_once("PF_CAN: dropped non conform CAN XL skbuff: dev type %d, len %d\n",
+			     dev->type, skb->len);
+		goto free_skb;
+	}
+
+	/* This check is made separately since cfx->len would be uninitialized if skb->len = 0. */
+	if (unlikely(cfx->len > CANXL_MAX_DLEN || cfx->len == 0)) {
+		pr_warn_once("PF_CAN: dropped non conform CAN XL skbuff: dev type %d, len %d, datalen %d\n",
+			     dev->type, skb->len, cfx->len);
+		goto free_skb;
+	}
+
+	can_receive(skb, dev);
+	return NET_RX_SUCCESS;
+
+free_skb:
+	kfree_skb(skb);
+	return NET_RX_DROP;
+}
+
 /* af_can protocol functions */
 
 /**
  * can_proto_register - register CAN transport protocol
  * @cp: pointer to CAN protocol structure
@@ -849,10 +876,15 @@ static struct packet_type can_packet __read_mostly = {
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
@@ -888,10 +920,11 @@ static __init int can_init(void)
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

