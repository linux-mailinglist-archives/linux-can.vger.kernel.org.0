Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC9F70D95B
	for <lists+linux-can@lfdr.de>; Tue, 23 May 2023 11:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbjEWJpL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 May 2023 05:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbjEWJpH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 May 2023 05:45:07 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8703A12B
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:06 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so8344012e87.3
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684835045; x=1687427045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vI+QgWQ2DMzBFFxUrz1+8rCe6YyqzMwcF40P0c1WSU=;
        b=bXsPyCB67SrDtOWU5yPAfiZ74gmpLqwNjY+zrhS25e48G8tfs/uPNA+dsLLEZnPLPK
         FBLjnWKfUoJKDJ1RC/VhYNS5L4T6Hs5+YJd0be2QPHGPBMWiS0enuRmee5xAxdEnhfKo
         Zi8i6u2gHy9W/kdYnS8zsG8LaTKEWc1X3MUBvJTdvmd9yPkO0drv0o4BI4z+3hjlSzof
         A9bp2qfJe2p2miEIGA1QrtSspt9Q2Mxyd4Iio29H3XFyG+mm6VSNSeaOO2aiRj62Ae60
         ftNlJrIbE65lFjowwk55iJr25DbmxNX0vnTxecGwGLVj7G08/i4vc8xF8CaLRvBwBy4S
         hmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835045; x=1687427045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vI+QgWQ2DMzBFFxUrz1+8rCe6YyqzMwcF40P0c1WSU=;
        b=PaPvq8amgefZLypmww+Wc9tadOc9MeTzxPUII1ebmGbZIvfJV+ZlExQkm5B7kANY84
         mhKO3MiB/r2g6m1PE5+TcZ6kEm1ng/b/iZc4Kgp2xextIYsu3tVa+FoERWLYLm0yWzbW
         OLEKxiQZ467m+Joi2Fxi+yeLeHXDBCt0PBLZMDTYF8IXVWexkTLN2ooH09eWBOrvmNCy
         d30Hs69sxKrS4mWvREjvF6U2RQG+B+a79bSlup+s7wppZBGTvz5RIEI4RuzNnsY/IlSB
         bt+WRELiwiGi+Du79QAFUTWfT21rvUWwLpalVnJJLQSS/hPVodtU6Jzapgyq0ivt/v1R
         +JFQ==
X-Gm-Message-State: AC+VfDzNzKFLoJUbFAu+lM4p7PkZoUN4FcrmBXA/QS6yyJ6vamG0sLB8
        fewGewUuVDS7YoLxSCzIwMuDeINASWN/AH0vu0s=
X-Google-Smtp-Source: ACHHUZ7uunxDEcsxg2k3XGfKnR8g7XGaF106jr9ZsrFwqYwpnuAQZzk8KJXvwIRKPyPSkbKZ9TaTRw==
X-Received: by 2002:a19:f608:0:b0:4ef:ef67:65c9 with SMTP id x8-20020a19f608000000b004efef6765c9mr4749872lfe.23.1684835044998;
        Tue, 23 May 2023 02:44:04 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id c16-20020a2e9490000000b002ac87c15fd4sm1535551ljh.95.2023.05.23.02.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:44:04 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 02/12] can: kvaser_pciefd: Remove handler for unused KVASER_PCIEFD_PACK_TYPE_EFRAME_ACK
Date:   Tue, 23 May 2023 11:43:40 +0200
Message-Id: <20230523094354.83792-3-extja@kvaser.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230523094354.83792-1-extja@kvaser.com>
References: <20230523094354.83792-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The Kvaser KCAN controller got a feature to send error frames on request.
The packet KVASER_PCIEFD_PACK_TYPE_EFRAME_ACK signals that the requested
error frame was transmitted.
Since this feature is not supported by the driver, drop the handler and add
KVASER_PCIEFD_PACK_TYPE_EFRAME_ACK to the list of unexpected packet types.

Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 39 +--------------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index d60d17199a1b..1821ffa4ca79 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1472,40 +1472,6 @@ static int kvaser_pciefd_handle_status_packet(struct kvaser_pciefd *pcie,
 	return 0;
 }
 
-static int kvaser_pciefd_handle_eack_packet(struct kvaser_pciefd *pcie,
-					    struct kvaser_pciefd_rx_packet *p)
-{
-	struct kvaser_pciefd_can *can;
-	u8 ch_id = (p->header[1] >> KVASER_PCIEFD_PACKET_CHID_SHIFT) & 0x7;
-
-	if (ch_id >= pcie->nr_channels)
-		return -EIO;
-
-	can = pcie->can[ch_id];
-
-	/* If this is the last flushed packet, send end of flush */
-	if (p->header[0] & KVASER_PCIEFD_APACKET_FLU) {
-		u8 count = ioread32(can->reg_base +
-				    KVASER_PCIEFD_KCAN_TX_NPACKETS_REG) & 0xff;
-
-		if (count == 0)
-			iowrite32(KVASER_PCIEFD_KCAN_CTRL_EFLUSH,
-				  can->reg_base + KVASER_PCIEFD_KCAN_CTRL_REG);
-	} else {
-		int echo_idx = p->header[0] & KVASER_PCIEFD_PACKET_SEQ_MSK;
-		int dlc = can_get_echo_skb(can->can.dev, echo_idx, NULL);
-		struct net_device_stats *stats = &can->can.dev->stats;
-
-		stats->tx_bytes += dlc;
-		stats->tx_packets++;
-
-		if (netif_queue_stopped(can->can.dev))
-			netif_wake_queue(can->can.dev);
-	}
-
-	return 0;
-}
-
 static void kvaser_pciefd_handle_nack_packet(struct kvaser_pciefd_can *can,
 					     struct kvaser_pciefd_rx_packet *p)
 {
@@ -1644,16 +1610,13 @@ static int kvaser_pciefd_read_packet(struct kvaser_pciefd *pcie, int *start_pos,
 		ret = kvaser_pciefd_handle_error_packet(pcie, p);
 		break;
 
-	case KVASER_PCIEFD_PACK_TYPE_EFRAME_ACK:
-		ret = kvaser_pciefd_handle_eack_packet(pcie, p);
-		break;
-
 	case KVASER_PCIEFD_PACK_TYPE_EFLUSH_ACK:
 		ret = kvaser_pciefd_handle_eflush_packet(pcie, p);
 		break;
 
 	case KVASER_PCIEFD_PACK_TYPE_ACK_DATA:
 	case KVASER_PCIEFD_PACK_TYPE_BUS_LOAD:
+	case KVASER_PCIEFD_PACK_TYPE_EFRAME_ACK:
 	case KVASER_PCIEFD_PACK_TYPE_TXRQ:
 		dev_info(&pcie->pci->dev,
 			 "Received unexpected packet type 0x%08X\n", type);
-- 
2.40.0

