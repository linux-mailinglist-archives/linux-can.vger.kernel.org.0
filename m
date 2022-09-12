Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F16D5B5EDA
	for <lists+linux-can@lfdr.de>; Mon, 12 Sep 2022 19:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiILRHx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 12 Sep 2022 13:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiILRHv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 12 Sep 2022 13:07:51 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD82922BE4
        for <linux-can@vger.kernel.org>; Mon, 12 Sep 2022 10:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1663002466;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=tHycnBS4cHJ06EdgOS84GvtMjDJtRxEmDKC4O3PA/ww=;
    b=gLkghOn/HtL94SZfKX5xwFdNOOEzf++QXbNs+5hY0GuC6HQPASj2Mbk5p8NoELGHsD
    8mh2pkg6aFsTV1rLSwoq3+TrIlsjZqCM+GFL+CiWS33G3w8dFUSudrq0B5Gb3PugqcQU
    5jW11wsSQO4pf+nkrFpE8IEN7QEd+NimHiof/GiZhrjTF1+K6CuqF9QfB5DGmvUBJOFH
    8UXFGTWhOYIYMwfbWbuAttc17d4QY3M1W9DQbTnqkZd1IWAQ4NC1/JJAyb6lOhA4NEOP
    quLz0WejVmgf7MVXGL2VkyGZUp8ClMXxQuBhztyFTgYOYi75jenwP73JCpfD489pmHFg
    /JqA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JiLceSWJaYxMWqfZ"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 48.1.0 AUTH)
    with ESMTPSA id d25a93y8CH7k1O8
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 12 Sep 2022 19:07:46 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v9 3/7] can: set CANFD_FDF flag in all CAN FD frame structures
Date:   Mon, 12 Sep 2022 19:07:21 +0200
Message-Id: <20220912170725.120748-4-socketcan@hartkopp.net>
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

To simplify the testing in user space all struct canfd_frame's provided by
the CAN subsystem of the Linux kernel now have the CANFD_FDF flag set in
canfd_frame::flags.

NB: Handcrafted ETH_P_CANFD frames introduced via PF_PACKET socket might
not set this bit correctly. During the check for sufficient headroom in
PF_PACKET sk_buffs the uninitialized CAN sk_buff data structures are filled.
In the case of a CAN FD frame the CANFD_FDF flag is set accordingly.

As the CAN frame content is already zero initialized in alloc_canfd_skb()
the obsolete initialization of cf->flags in the CTU CAN FD driver has been
removed as it would overwrite the already set CANFD_FDF flag.

Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/ctucanfd/ctucanfd_base.c |  1 -
 drivers/net/can/dev/skb.c                | 11 +++++++++++
 include/uapi/linux/can.h                 |  4 ++--
 net/can/af_can.c                         |  5 +++++
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index 3c18d028bd8c..c4026712ab7d 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -655,11 +655,10 @@ static void ctucan_read_rx_frame(struct ctucan_priv *priv, struct canfd_frame *c
 		cf->can_id = (idw & CAN_EFF_MASK) | CAN_EFF_FLAG;
 	else
 		cf->can_id = (idw >> 18) & CAN_SFF_MASK;
 
 	/* BRS, ESI, RTR Flags */
-	cf->flags = 0;
 	if (FIELD_GET(REG_FRAME_FORMAT_W_FDF, ffw)) {
 		if (FIELD_GET(REG_FRAME_FORMAT_W_BRS, ffw))
 			cf->flags |= CANFD_BRS;
 		if (FIELD_GET(REG_FRAME_FORMAT_W_ESI_RSV, ffw))
 			cf->flags |= CANFD_ESI;
diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index b896e1ce3b47..adb413bdd734 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -242,10 +242,13 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 	can_skb_prv(skb)->ifindex = dev->ifindex;
 	can_skb_prv(skb)->skbcnt = 0;
 
 	*cfd = skb_put_zero(skb, sizeof(struct canfd_frame));
 
+	/* set CAN FD flag by default */
+	(*cfd)->flags = CANFD_FDF;
+
 	return skb;
 }
 EXPORT_SYMBOL_GPL(alloc_canfd_skb);
 
 struct sk_buff *alloc_can_err_skb(struct net_device *dev, struct can_frame **cf)
@@ -285,10 +288,18 @@ static bool can_skb_headroom_valid(struct net_device *dev, struct sk_buff *skb)
 			skb->pkt_type = PACKET_HOST;
 
 		skb_reset_mac_header(skb);
 		skb_reset_network_header(skb);
 		skb_reset_transport_header(skb);
+
+		/* set CANFD_FDF flag for CAN FD frames */
+		if (can_is_canfd_skb(skb)) {
+			struct canfd_frame *cfd;
+
+			cfd = (struct canfd_frame *)skb->data;
+			cfd->flags |= CANFD_FDF;
+		}
 	}
 
 	return true;
 }
 
diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index 90801ada2bbe..7b23eeeb3273 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -139,12 +139,12 @@ struct can_frame {
  * The struct can_frame and struct canfd_frame intentionally share the same
  * layout to be able to write CAN frame content into a CAN FD frame structure.
  * When this is done the former differentiation via CAN_MTU / CANFD_MTU gets
  * lost. CANFD_FDF allows programmers to mark CAN FD frames in the case of
  * using struct canfd_frame for mixed CAN / CAN FD content (dual use).
- * N.B. the Kernel APIs do NOT provide mixed CAN / CAN FD content inside of
- * struct canfd_frame therefore the CANFD_FDF flag is disregarded by Linux.
+ * Since the introduction of CAN XL the CANFD_FDF flag is set in all CAN FD
+ * frame structures provided by the CAN subsystem of the Linux kernel.
  */
 #define CANFD_BRS 0x01 /* bit rate switch (second bitrate for payload data) */
 #define CANFD_ESI 0x02 /* error state indicator of the transmitting node */
 #define CANFD_FDF 0x04 /* mark CAN FD for dual use of struct canfd_frame */
 
diff --git a/net/can/af_can.c b/net/can/af_can.c
index afa6c2151bc4..072a6a5c9dd1 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -203,11 +203,16 @@ int can_send(struct sk_buff *skb, int loop)
 	int err = -EINVAL;
 
 	if (can_is_can_skb(skb)) {
 		skb->protocol = htons(ETH_P_CAN);
 	} else if (can_is_canfd_skb(skb)) {
+		struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
+
 		skb->protocol = htons(ETH_P_CANFD);
+
+		/* set CAN FD flag for CAN FD frames by default */
+		cfd->flags |= CANFD_FDF;
 	} else {
 		goto inval_skb;
 	}
 
 	/* Make sure the CAN frame can pass the selected CAN netdevice. */
-- 
2.30.2

