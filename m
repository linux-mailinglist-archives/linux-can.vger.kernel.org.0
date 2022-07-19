Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F42579299
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 07:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbiGSFmW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 01:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbiGSFmT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 01:42:19 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF4530545
        for <linux-can@vger.kernel.org>; Mon, 18 Jul 2022 22:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658209334;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=JjN/DGsdpavp1kb81Ij+8OcP+L5zG5fFcwrS8XLVLf4=;
    b=tV8N0szeD5WFq2ZeVgYgJtXhPg4KfmYxPnroQZUwLbxSsiPIvkOPn/tJcHe0Bu5sZp
    jgIozDdjmQ5t39simerLp1dIFhigNQhlc/ibjWZ0kOYxkqDmc8D0PJRoRHxs0abhdFUc
    fDYOi/CMy9ePCG+Knw0ic8qlqHswCIlj5y7+PQ4ZxfhiUw3E2Y9Q6iwWlkudfmf4B/gh
    g/3kMlROfYE+Hl8aMCTAWoEb6NjFxpVoZTncrha5visMFetYg7ISsv84OcjCKNQUzIxQ
    H0V6CNSl4XQmyAepqhQ2NCbnkvA4v4RhQI4sjyxvKIaInSpFPCNro2NVtrhdbw1cvajp
    cgEA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JiLceSWJaYwXUKbZ"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6J5gEF5k
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 19 Jul 2022 07:42:14 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH v4 2/5] can: canxl: introduce ETH_P_CANXL ethernet protocol handling
Date:   Tue, 19 Jul 2022 07:42:01 +0200
Message-Id: <20220719054204.29061-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220719054204.29061-1-socketcan@hartkopp.net>
References: <20220719054204.29061-1-socketcan@hartkopp.net>
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
 net/can/af_can.c              | 32 +++++++++++++++++++++++-----
 3 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index 182749e858b3..51481f5afe62 100644
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
+	if (skb->len != CANXL_MTU)
+		return false;
+
+	/* check valid CAN XL data length boundaries */
+	if (cfx->len < CANXL_MIN_DLEN || cfx->len > CANXL_MAX_DLEN)
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
index 1fb49d51b25d..23e56e4e2457 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -209,19 +209,20 @@ int can_send(struct sk_buff *skb, int loop)
 			goto inval_skb;
 	} else if (skb->len == CANFD_MTU) {
 		skb->protocol = htons(ETH_P_CANFD);
 		if (unlikely(cfd->len > CANFD_MAX_DLEN))
 			goto inval_skb;
+	} else if (skb->len == CANXL_MTU) {
+		skb->protocol = htons(ETH_P_CANXL);
+		if (unlikely(!can_is_canxl_skb(skb)))
+			goto inval_skb;
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

