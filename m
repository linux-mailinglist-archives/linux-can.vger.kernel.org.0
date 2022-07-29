Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458965852F7
	for <lists+linux-can@lfdr.de>; Fri, 29 Jul 2022 17:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbiG2Pla (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 29 Jul 2022 11:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237949AbiG2PlT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 29 Jul 2022 11:41:19 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C405060693
        for <linux-can@vger.kernel.org>; Fri, 29 Jul 2022 08:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1659109274;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=x6tlDQG9zziy1iqWbP0xVzVLL9lfi3n62O/tsLBBk9s=;
    b=OUJzKPGSwil1afvhbuGOyN7RZOG7F2YD4uLfw04DU22i/+YEtw2p0Y+n17bYmyVcco
    paQREPRZ0a7IoNFLdJD03ZYqi+e441BGdqjY0QjrvWfxhvz08JUSLF3dmyfdX9qs/duf
    NjRIQSuSMd0TY9jFgTKXCV0Q77jJlaEiuYfmEKS3oNTkQrmw/UDaSGm8AwbXW5bPAxSU
    xo3RETqZVxuYVcfnAn6XeJfdJOfIncAV7i7gdbDhdhtW1OoaepG4GvHFm8cRUdZlmlri
    +SaeR41PyhpCDWx+hJT1ShNyw3ck1q1m05UC2sQAVYPQPrVLTrO9YF1SSkg9fXmHlgLX
    UwSQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JiLceSWJaYwXUKbZ"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id Icb1b0y6TFfDCno
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 29 Jul 2022 17:41:13 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v7 1/7] can: skb: unify skb CAN frame identification helpers
Date:   Fri, 29 Jul 2022 17:41:01 +0200
Message-Id: <20220729154107.1875-2-socketcan@hartkopp.net>
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

Replace open coded checks for sk_buffs containing Classical CAN and
CAN FD frame structures as a preparation for CAN XL support.

With the added length check the unintended processing of CAN XL frames
having the CANXL_XLF bit set can be suppressed even when the skb->len
fits to non CAN XL frames.

The CAN_RAW socket needs a rework to use these helpers. Therefore the
use of these helpers is postponed to the CAN_RAW CAN XL integration.

The J1939 protocol gets a check for Classical CAN frames too.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/skb.c | 18 +++++++-------
 include/linux/can/skb.h   | 12 +++++++++-
 net/can/af_can.c          | 50 ++++++++-------------------------------
 net/can/bcm.c             |  9 +++++--
 net/can/gw.c              |  4 ++--
 net/can/isotp.c           |  2 +-
 net/can/j1939/main.c      |  4 ++++
 7 files changed, 45 insertions(+), 54 deletions(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 8bb62dd864c8..45313b90005c 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -291,22 +291,24 @@ static bool can_skb_headroom_valid(struct net_device *dev, struct sk_buff *skb)
 }
 
 /* Drop a given socketbuffer if it does not contain a valid CAN frame. */
 bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
 {
-	const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 	struct can_priv *priv = netdev_priv(dev);
 
-	if (skb->protocol == htons(ETH_P_CAN)) {
-		if (unlikely(skb->len != CAN_MTU ||
-			     cfd->len > CAN_MAX_DLEN))
+	switch (ntohs(skb->protocol)) {
+	case ETH_P_CAN:
+		if (!can_is_can_skb(skb))
 			goto inval_skb;
-	} else if (skb->protocol == htons(ETH_P_CANFD)) {
-		if (unlikely(skb->len != CANFD_MTU ||
-			     cfd->len > CANFD_MAX_DLEN))
+		break;
+
+	case ETH_P_CANFD:
+		if (!can_is_canfd_skb(skb))
 			goto inval_skb;
-	} else {
+		break;
+
+	default:
 		goto inval_skb;
 	}
 
 	if (!can_skb_headroom_valid(dev, skb)) {
 		goto inval_skb;
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index 182749e858b3..27ebfc28510f 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -95,12 +95,22 @@ static inline struct sk_buff *can_create_echo_skb(struct sk_buff *skb)
 	can_skb_set_owner(nskb, skb->sk);
 	consume_skb(skb);
 	return nskb;
 }
 
+static inline bool can_is_can_skb(const struct sk_buff *skb)
+{
+	struct can_frame *cf = (struct can_frame *)skb->data;
+
+	/* the CAN specific type of skb is identified by its data length */
+	return (skb->len == CAN_MTU && cf->len <= CAN_MAX_DLEN);
+}
+
 static inline bool can_is_canfd_skb(const struct sk_buff *skb)
 {
+	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
+
 	/* the CAN specific type of skb is identified by its data length */
-	return skb->len == CANFD_MTU;
+	return (skb->len == CANFD_MTU && cfd->len <= CANFD_MAX_DLEN);
 }
 
 #endif /* !_CAN_SKB_H */
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 1fb49d51b25d..afa6c2151bc4 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -197,31 +197,23 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
  *  -EINVAL when the skb->data does not contain a valid CAN frame
  */
 int can_send(struct sk_buff *skb, int loop)
 {
 	struct sk_buff *newskb = NULL;
-	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 	struct can_pkg_stats *pkg_stats = dev_net(skb->dev)->can.pkg_stats;
 	int err = -EINVAL;
 
-	if (skb->len == CAN_MTU) {
+	if (can_is_can_skb(skb)) {
 		skb->protocol = htons(ETH_P_CAN);
-		if (unlikely(cfd->len > CAN_MAX_DLEN))
-			goto inval_skb;
-	} else if (skb->len == CANFD_MTU) {
+	} else if (can_is_canfd_skb(skb)) {
 		skb->protocol = htons(ETH_P_CANFD);
-		if (unlikely(cfd->len > CANFD_MAX_DLEN))
-			goto inval_skb;
 	} else {
 		goto inval_skb;
 	}
 
-	/* Make sure the CAN frame can pass the selected CAN netdevice.
-	 * As structs can_frame and canfd_frame are similar, we can provide
-	 * CAN FD frames to legacy CAN drivers as long as the length is <= 8
-	 */
-	if (unlikely(skb->len > skb->dev->mtu && cfd->len > CAN_MAX_DLEN)) {
+	/* Make sure the CAN frame can pass the selected CAN netdevice. */
+	if (unlikely(skb->len > skb->dev->mtu)) {
 		err = -EMSGSIZE;
 		goto inval_skb;
 	}
 
 	if (unlikely(skb->dev->type != ARPHRD_CAN)) {
@@ -676,57 +668,35 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 }
 
 static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 		   struct packet_type *pt, struct net_device *orig_dev)
 {
-	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
-
-	if (unlikely(dev->type != ARPHRD_CAN || skb->len != CAN_MTU)) {
+	if (unlikely(dev->type != ARPHRD_CAN || (!can_is_can_skb(skb)))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
-		goto free_skb;
-	}
 
-	/* This check is made separately since cfd->len would be uninitialized if skb->len = 0. */
-	if (unlikely(cfd->len > CAN_MAX_DLEN)) {
-		pr_warn_once("PF_CAN: dropped non conform CAN skbuff: dev type %d, len %d, datalen %d\n",
-			     dev->type, skb->len, cfd->len);
-		goto free_skb;
+		kfree_skb(skb);
+		return NET_RX_DROP;
 	}
 
 	can_receive(skb, dev);
 	return NET_RX_SUCCESS;
-
-free_skb:
-	kfree_skb(skb);
-	return NET_RX_DROP;
 }
 
 static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 		     struct packet_type *pt, struct net_device *orig_dev)
 {
-	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
-
-	if (unlikely(dev->type != ARPHRD_CAN || skb->len != CANFD_MTU)) {
+	if (unlikely(dev->type != ARPHRD_CAN || (!can_is_canfd_skb(skb)))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN FD skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
-		goto free_skb;
-	}
 
-	/* This check is made separately since cfd->len would be uninitialized if skb->len = 0. */
-	if (unlikely(cfd->len > CANFD_MAX_DLEN)) {
-		pr_warn_once("PF_CAN: dropped non conform CAN FD skbuff: dev type %d, len %d, datalen %d\n",
-			     dev->type, skb->len, cfd->len);
-		goto free_skb;
+		kfree_skb(skb);
+		return NET_RX_DROP;
 	}
 
 	can_receive(skb, dev);
 	return NET_RX_SUCCESS;
-
-free_skb:
-	kfree_skb(skb);
-	return NET_RX_DROP;
 }
 
 /* af_can protocol functions */
 
 /**
diff --git a/net/can/bcm.c b/net/can/bcm.c
index e60161bec850..e5d179ba6f7d 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -646,12 +646,17 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 
 	if (op->can_id != rxframe->can_id)
 		return;
 
 	/* make sure to handle the correct frame type (CAN / CAN FD) */
-	if (skb->len != op->cfsiz)
-		return;
+	if (op->flags & CAN_FD_FRAME) {
+		if (!can_is_canfd_skb(skb))
+			return;
+	} else {
+		if (!can_is_can_skb(skb))
+			return;
+	}
 
 	/* disable timeout */
 	hrtimer_cancel(&op->timer);
 
 	/* save rx timestamp */
diff --git a/net/can/gw.c b/net/can/gw.c
index 1ea4cc527db3..23a3d89cad81 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -461,14 +461,14 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	struct sk_buff *nskb;
 	int modidx = 0;
 
 	/* process strictly Classic CAN or CAN FD frames */
 	if (gwj->flags & CGW_FLAGS_CAN_FD) {
-		if (skb->len != CANFD_MTU)
+		if (!can_is_canfd_skb(skb))
 			return;
 	} else {
-		if (skb->len != CAN_MTU)
+		if (!can_is_can_skb(skb))
 			return;
 	}
 
 	/* Do not handle CAN frames routed more than 'max_hops' times.
 	 * In general we should never catch this delimiter which is intended
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 43a27d19cdac..a9d1357f8489 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -667,11 +667,11 @@ static void isotp_rcv(struct sk_buff *skb, void *data)
 		sf_dl = cf->data[ae] & 0x0F;
 
 		if (cf->len <= CAN_MAX_DLEN) {
 			isotp_rcv_sf(sk, cf, SF_PCI_SZ4 + ae, skb, sf_dl);
 		} else {
-			if (skb->len == CANFD_MTU) {
+			if (can_is_canfd_skb(skb)) {
 				/* We have a CAN FD frame and CAN_DL is greater than 8:
 				 * Only frames with the SF_DL == 0 ESC value are valid.
 				 *
 				 * If so take care of the increased SF PCI size
 				 * (SF_PCI_SZ8) to point to the message content behind
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 8452b0fbb78c..144c86b0e3ff 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -40,10 +40,14 @@ static void j1939_can_recv(struct sk_buff *iskb, void *data)
 	struct j1939_priv *priv = data;
 	struct sk_buff *skb;
 	struct j1939_sk_buff_cb *skcb, *iskcb;
 	struct can_frame *cf;
 
+	/* make sure we only get Classical CAN frames */
+	if (!can_is_can_skb(iskb))
+		return;
+
 	/* create a copy of the skb
 	 * j1939 only delivers the real data bytes,
 	 * the header goes into sockaddr.
 	 * j1939 may not touch the incoming skb in such way
 	 */
-- 
2.30.2

