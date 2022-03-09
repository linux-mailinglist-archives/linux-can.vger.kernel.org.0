Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BEE4D2EA6
	for <lists+linux-can@lfdr.de>; Wed,  9 Mar 2022 13:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbiCIMF2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Mar 2022 07:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiCIMFZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Mar 2022 07:05:25 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266BE171EF5
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 04:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1646827462;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=vGzmQlNmQbzAr/LsjT9GhqFSyqpihJ0mFI9SveLOnUU=;
    b=B733wmfL2bfEug4TKZ0WwnqKN9ywVfN+IKRpmHAL3z8eJhNqxuYOIOBXMnCz6ZPkvm
    6Gyn4sGZy3nm0voI7TstLkp7kiyCYODQyFpsuwS4Lv4XnzcqB64R1q9TJ4PIAOsdkURY
    3JvK0+unfy42PffgGTyQvHHGaOmJNZ5PEqYoKlC2eLr6goGLUe2ti8Qt8h1phSReR7UJ
    3fN0xRU03PlCUNOaJmk4dR6bcz1MtZD8a4WJ08mZs0jCohhBT37IFrpYveokPpsYpPS5
    KjpekFtK/VWIYRnJ6XAiMFyCrlP/tVvZglJ+0BULZpdARscYn24ONRaM4Qti7QI59HbA
    vUZQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9IyLecSWJafUvprl4"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.40.1 AUTH)
    with ESMTPSA id 6c57e6y29C4MEQA
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 9 Mar 2022 13:04:22 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [can-next v2 4/5] vxcan: remove sk reference in peer skb
Date:   Wed,  9 Mar 2022 13:04:15 +0100
Message-Id: <20220309120416.83514-4-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220309120416.83514-1-socketcan@hartkopp.net>
References: <20220309120416.83514-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

With can_create_echo_skb() the skb which is forwarded to the peer CAN
interface shares the sk pointer from the originating socket.
This makes the CAN frame show up in the peer namespace as a TX packet.

With the use of skb_clone() analogue to the handling in gw.c the peer
skb gets a new start in the peer namespace and correctly appears as
a RX packet.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/vxcan.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 47ccc15a3486..1c944b7d4bcc 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -31,32 +31,37 @@ MODULE_ALIAS_RTNL_LINK(DRV_NAME);
 
 struct vxcan_priv {
 	struct net_device __rcu	*peer;
 };
 
-static netdev_tx_t vxcan_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t vxcan_xmit(struct sk_buff *oskb, struct net_device *dev)
 {
 	struct vxcan_priv *priv = netdev_priv(dev);
 	struct net_device *peer;
-	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
+	struct canfd_frame *cfd = (struct canfd_frame *)oskb->data;
 	struct net_device_stats *peerstats, *srcstats = &dev->stats;
+	struct sk_buff *skb;
 	u8 len;
 
-	if (can_dropped_invalid_skb(dev, skb))
+	if (can_dropped_invalid_skb(dev, oskb))
 		return NETDEV_TX_OK;
 
 	rcu_read_lock();
 	peer = rcu_dereference(priv->peer);
 	if (unlikely(!peer)) {
-		kfree_skb(skb);
+		kfree_skb(oskb);
 		dev->stats.tx_dropped++;
 		goto out_unlock;
 	}
 
-	skb = can_create_echo_skb(skb);
-	if (!skb)
+	skb = skb_clone(oskb, GFP_ATOMIC);
+	if (skb) {
+		consume_skb(oskb);
+	} else {
+		kfree(oskb);
 		goto out_unlock;
+	}
 
 	/* reset CAN GW hop counter */
 	skb->csum_start = 0;
 	skb->pkt_type   = PACKET_BROADCAST;
 	skb->dev        = peer;
-- 
2.30.2

