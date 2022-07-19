Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79DB579298
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 07:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbiGSFmT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 01:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbiGSFmR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 01:42:17 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98412FFFF
        for <linux-can@vger.kernel.org>; Mon, 18 Jul 2022 22:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658209334;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LAT/HAbljz4cDvISFLQZZfFzkNMrdlMgJCtJ632HkBY=;
    b=V7zZRAsx8OOPLM6ncCi0lUSxrrE4+n5//Sg0zQQ2I9QvB+9uwUyHz9dgWU2P6yyO/T
    z9u5xkN9TrKuAHcCBsctS56i3n1nf4iYugaCtGVuJ0kV7gUMS06vWnY1d9TKIo2t/dYZ
    Xf4US3zK8BPl8qPAz65w+cvHlUmmYB2ZX5Xinm3ygWDoZxXgXVR3hmkC1kPtpnfqsYuJ
    Smoq3CbV5Ddg1EBWvUJ+GXNXbGyiLCkgNrQyOkHdCMCL5ZO+TY18NfAUQmhwt3+bn06s
    sguNI6wCA8DarcQwVgLqHQCOOwDD7Eysyoi8H5jmXuWITppRHjPNtcpw17PytmcWFrYV
    jSIQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JiLceSWJaYwXUKbZ"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6J5gEF5m
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 19 Jul 2022 07:42:14 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH v4 4/5] can: vcan: add CAN XL support
Date:   Tue, 19 Jul 2022 07:42:03 +0200
Message-Id: <20220719054204.29061-5-socketcan@hartkopp.net>
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

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/vcan.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
index a15619d883ec..d72c0727b440 100644
--- a/drivers/net/can/vcan.c
+++ b/drivers/net/can/vcan.c
@@ -68,33 +68,32 @@ static bool echo; /* echo testing. Default: 0 (Off) */
 module_param(echo, bool, 0444);
 MODULE_PARM_DESC(echo, "Echo sent frames (for testing). Default: 0 (Off)");
 
 static void vcan_rx(struct sk_buff *skb, struct net_device *dev)
 {
-	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 	struct net_device_stats *stats = &dev->stats;
 
 	stats->rx_packets++;
-	stats->rx_bytes += cfd->len;
+	stats->rx_bytes += can_skb_get_data_len(skb);
 
 	skb->pkt_type  = PACKET_BROADCAST;
 	skb->dev       = dev;
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 	netif_rx(skb);
 }
 
 static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
 {
-	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 	struct net_device_stats *stats = &dev->stats;
-	int loop, len;
+	unsigned int len;
+	int loop;
 
 	if (can_dropped_invalid_skb(dev, skb))
 		return NETDEV_TX_OK;
 
-	len = cfd->can_id & CAN_RTR_FLAG ? 0 : cfd->len;
+	len = can_skb_get_data_len(skb);
 	stats->tx_packets++;
 	stats->tx_bytes += len;
 
 	/* set flag whether this packet has to be looped back */
 	loop = skb->pkt_type == PACKET_LOOPBACK;
@@ -132,11 +131,11 @@ static int vcan_change_mtu(struct net_device *dev, int new_mtu)
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

