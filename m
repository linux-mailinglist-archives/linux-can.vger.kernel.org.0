Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CAA4D04B9
	for <lists+linux-can@lfdr.de>; Mon,  7 Mar 2022 17:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241609AbiCGQ5u (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 7 Mar 2022 11:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbiCGQ5t (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Mar 2022 11:57:49 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D96C7E583
        for <linux-can@vger.kernel.org>; Mon,  7 Mar 2022 08:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1646672212;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=vGzmQlNmQbzAr/LsjT9GhqFSyqpihJ0mFI9SveLOnUU=;
    b=qpu6pWKnGNMsJJLJW4TP3xRjL9mmftn2J4h6G+K9ZPMbLxUIyuLY2YRjyFpyo0Zpwe
    iAaAX5PAGiD2BHfKEDjv+OjStS1na8uJYS5Kt1ubjGkDXpEhJ+09ObkcInbTKbHsv4eZ
    3927pd2hRfPo1iZeiB65RD7daO8msgbgrQiRRMwO2OIwvF9LXWRMPBOK/6d2YV1i4qCd
    glaTiareitGbNOjMeAPOU5rl3nhsmOauqYKNEIZjW//kwBqIpFWBw2qzfXWMdTdYsEnI
    +9Mktq4Cr7ZpeTVUe1tbzynWoWUUantNBJ/H1YRiR1RuGQIqjtbA4ILK07o0qRaCWwng
    3zbQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9IyLecSWJafUvprl4"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.40.1 AUTH)
    with ESMTPSA id 6c57e6y27Guq8ga
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 7 Mar 2022 17:56:52 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [can-next 1/2] vxcan: remove sk reference in peer skb
Date:   Mon,  7 Mar 2022 17:56:43 +0100
Message-Id: <20220307165644.9689-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
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

