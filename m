Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B205709FF
	for <lists+linux-can@lfdr.de>; Mon, 11 Jul 2022 20:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiGKSex (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Jul 2022 14:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiGKSew (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Jul 2022 14:34:52 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C4C5FAD4
        for <linux-can@vger.kernel.org>; Mon, 11 Jul 2022 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657564481;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=cZslEVCgvl9upfOlHgNmQcAlBTqurf1yZJb80IHLsE4=;
    b=a2JT8m0TUgB8xEyn9wxg6PXPoY9D+fw6mHhHU2yO8txj1UQp1Ak18Fontc8Tn6W8R7
    GUPV3xkaPjXJtM2wsYlF5zHhkQ9CbUu6UsMlCMS/P3J5aYwI8W6IOSrdX8j62B6cFvKX
    HSEawAvZGrruuNsWLWzkmpErh5/781Oy0xmGzkLKmHpxfZUwACphZW3dXj+hd37DIsTC
    YlveAGSis/kZDtV0lTiy+hfv2+1EzWzvtuKOrLvO8eqTI3zWybs1uWyrLLfuySJAIMBC
    OMR7ejkLQHO1joqGImpUILRy08XGdHUWrdM9Aad2zcDRmLCza2avuIzPl8HivEGV/dwy
    PezQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JiLceSWJaYwXUKbZ"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.46.1 AUTH)
    with ESMTPSA id 398cccy6BIYeReO
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 11 Jul 2022 20:34:40 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH 4/5] can: vcan: add CAN XL support
Date:   Mon, 11 Jul 2022 20:34:25 +0200
Message-Id: <20220711183426.96446-5-socketcan@hartkopp.net>
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

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/vcan.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
index a15619d883ec..a8de50fbfe3d 100644
--- a/drivers/net/can/vcan.c
+++ b/drivers/net/can/vcan.c
@@ -68,15 +68,15 @@ static bool echo; /* echo testing. Default: 0 (Off) */
 module_param(echo, bool, 0444);
 MODULE_PARM_DESC(echo, "Echo sent frames (for testing). Default: 0 (Off)");
 
 static void vcan_rx(struct sk_buff *skb, struct net_device *dev)
 {
-	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
+	unsigned int len = can_get_data_len(skb);
 	struct net_device_stats *stats = &dev->stats;
 
 	stats->rx_packets++;
-	stats->rx_bytes += cfd->len;
+	stats->rx_bytes += len;
 
 	skb->pkt_type  = PACKET_BROADCAST;
 	skb->dev       = dev;
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
 
@@ -85,16 +85,17 @@ static void vcan_rx(struct sk_buff *skb, struct net_device *dev)
 
 static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 	struct net_device_stats *stats = &dev->stats;
-	int loop, len;
+	unsigned int len = can_get_data_len(skb);
+	int loop;
 
 	if (can_dropped_invalid_skb(dev, skb))
 		return NETDEV_TX_OK;
 
-	len = cfd->can_id & CAN_RTR_FLAG ? 0 : cfd->len;
+	len = cfd->can_id & CAN_RTR_FLAG ? 0 : len;
 	stats->tx_packets++;
 	stats->tx_bytes += len;
 
 	/* set flag whether this packet has to be looped back */
 	loop = skb->pkt_type == PACKET_LOOPBACK;
@@ -132,11 +133,11 @@ static int vcan_change_mtu(struct net_device *dev, int new_mtu)
 {
 	/* Do not allow changing the MTU while running */
 	if (dev->flags & IFF_UP)
 		return -EBUSY;
 
-	if (new_mtu != CAN_MTU && new_mtu != CANFD_MTU)
+	if (new_mtu != CAN_MTU && new_mtu != CANFD_MTU && new_mtu != CANXL_MTU)
 		return -EINVAL;
 
 	dev->mtu = new_mtu;
 	return 0;
 }
-- 
2.30.2

