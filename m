Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30335B5ED5
	for <lists+linux-can@lfdr.de>; Mon, 12 Sep 2022 19:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiILRHw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 12 Sep 2022 13:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiILRHu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 12 Sep 2022 13:07:50 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8882122BC0
        for <linux-can@vger.kernel.org>; Mon, 12 Sep 2022 10:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1663002466;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=K23FaJNOoFMdT7UX1XVF8Oovy1ru/enOHdM6P0lmF+0=;
    b=tV7b6V4chGsf+YSV6qVgTMkKkVsojjzEJKGdCRSNuv1PcvuvrKx80sdX9grwcHB4H+
    JNLoQNMInNU4EZ9qKb0nlUwyHkM1J+Jmz29xMXc1jPYPauNXmRC/jg8297C3zm3xgOJ0
    FXEZTbheyV0dBY3vOtSJirj0FfS/cAIj0IDD2UUXTLIjBAec1TYiCRUwdDV3Ie9j7BFd
    a2dmUdGiqxPjMJ3VP96Y3sPjIc8mYfhRAY405+jlOQnD4/iI59SMcuQIDF/Rw99OLtRc
    Uvjy1Cwhqu5jQyQ3iG/q8gQVE9SGzVNqZ5aivQDwUzQVnCWsGPoJHRrM0yGqP7dn1Y79
    DFjw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JiLceSWJaYxMWqfZ"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 48.1.0 AUTH)
    with ESMTPSA id d25a93y8CH7k1O7
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 12 Sep 2022 19:07:46 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v9 2/7] can: skb: add skb CAN frame data length helpers
Date:   Mon, 12 Sep 2022 19:07:20 +0200
Message-Id: <20220912170725.120748-3-socketcan@hartkopp.net>
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

Add two helpers to retrieve the data length from CAN sk_buffs and prepare
the length information to be a uint16 value for the CAN XL support.

Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/rx-offload.c |  2 +-
 drivers/net/can/dev/skb.c        | 12 ++++--------
 include/linux/can/skb.h          | 24 +++++++++++++++++++++++-
 3 files changed, 28 insertions(+), 10 deletions(-)

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
index f457c94ba82f..b896e1ce3b47 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -89,12 +89,12 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
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
@@ -106,20 +106,16 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
 		/* Using "struct canfd_frame::len" for the frame
 		 * length is supported on both CAN and CANFD frames.
 		 */
 		struct sk_buff *skb = priv->echo_skb[idx];
 		struct can_skb_priv *can_skb_priv = can_skb_prv(skb);
-		struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 
 		if (skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS)
 			skb_tstamp_tx(skb, skb_hwtstamps(skb));
 
 		/* get the real payload length for netdev statistics */
-		if (cf->can_id & CAN_RTR_FLAG)
-			*len_ptr = 0;
-		else
-			*len_ptr = cf->len;
+		*len_ptr = can_skb_get_data_len(skb);
 
 		if (frame_len_ptr)
 			*frame_len_ptr = can_skb_priv->frame_len;
 
 		priv->echo_skb[idx] = NULL;
@@ -145,11 +141,11 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
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
 
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index 27ebfc28510f..ddffc2fc008c 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -18,11 +18,12 @@
 
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
@@ -111,6 +112,27 @@ static inline bool can_is_canfd_skb(const struct sk_buff *skb)
 
 	/* the CAN specific type of skb is identified by its data length */
 	return (skb->len == CANFD_MTU && cfd->len <= CANFD_MAX_DLEN);
 }
 
+/* get length element value from can[fd]_frame structure */
+static inline unsigned int can_skb_get_len_val(struct sk_buff *skb)
+{
+	const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
+
+	return cfd->len;
+}
+
+/* get needed data length inside CAN frame for all frame types (RTR aware) */
+static inline unsigned int can_skb_get_data_len(struct sk_buff *skb)
+{
+	unsigned int len = can_skb_get_len_val(skb);
+	const struct can_frame *cf = (struct can_frame *)skb->data;
+
+	/* RTR frames have an actual length of zero */
+	if (can_is_can_skb(skb) && cf->can_id & CAN_RTR_FLAG)
+		return 0;
+
+	return len;
+}
+
 #endif /* !_CAN_SKB_H */
-- 
2.30.2

