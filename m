Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022DE70D95C
	for <lists+linux-can@lfdr.de>; Tue, 23 May 2023 11:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbjEWJpV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 May 2023 05:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbjEWJpK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 May 2023 05:45:10 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511DC126
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:07 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2af98eb6ef0so29474971fa.3
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684835045; x=1687427045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDz85CgYz9ViMIuawotBn/rMfmJ7JaWBqAhHGDsW2UM=;
        b=ZPVptygvdYUBkAFUVHhhcvLPduj6ZAbNXCPXdxUhVQEYJiT1HGcrF8NEKdnmMldO8A
         E1dpNLmLM3pahnhd/W8g8tJ/SCkxBGXKTgz8c4bLsIDLImyRyRwW1inyoyHvC/8RLu9/
         qqoDGtyGmB8Hc7UhSDVz4CNmPpreNVYLCKr0msonCq0HmlyI4nnudKziGhW7c7zEPbtU
         e0QBsXySbsAq6Nb7K/fKLS7/6GGmPv/Li3KAXCZBPkP7xYGKgBS4s1+pOd1cYeQetuy7
         6BmlsdPgIhdx2PO3IpCVgO+kqofYEiM6DUEzrfrS+D4AxO8KzUMGlOELLTjwiZSBSXru
         iOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835045; x=1687427045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDz85CgYz9ViMIuawotBn/rMfmJ7JaWBqAhHGDsW2UM=;
        b=LyUv+GkaDRgcAUIOpYikwkXTU5Wc70sWYy2jP3z+FrbTFqGDF1Nh/MF5IrNxJd7g1a
         C4yci3lQyAxRmkSHJSsYYnWaMBxdRrVr2yOsAvT52m8kB4thTVCkcx+H74MXFSA6piCs
         LUSibKrjp135Kmmvzg43fFy3yia96xz/DNGYFUXgHvODzSeZfACPZQkxwSJxVZliHav6
         fX/MqOTMMmDtaAB8ehZvP5BW0BPsvpSXXP7BNszQF04w/nnj496iqWTIcyiD3F39/TK4
         dc3smBnJ4IplzeFWUmBfHQ5MvvP7uJ9sC82uvPxuykEtWvvV6YkVUuOtk0vdcFIEo1mY
         YHbA==
X-Gm-Message-State: AC+VfDyW9Oh8wNw/+51lRCf0EEMBrTaTfMUf+2SB4OCY63vpUlevVEmn
        HANZ8n3pQ66z8+V3IK6ZHqTfQtS4rWeDSbCzX0E=
X-Google-Smtp-Source: ACHHUZ495a9dl58MTFiEHfKQ34I+3F295UniCZgaSNATXxY58n2gI7xB4Eg7VRgaBb00jmZQF3X9kg==
X-Received: by 2002:a2e:b209:0:b0:2a7:7d70:6bb with SMTP id l9-20020a2eb209000000b002a77d7006bbmr4606609ljm.2.1684835045795;
        Tue, 23 May 2023 02:44:05 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id c16-20020a2e9490000000b002ac87c15fd4sm1535551ljh.95.2023.05.23.02.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:44:05 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 03/12] can: kvaser_pciefd: Add function to set skb hwtstamps
Date:   Tue, 23 May 2023 11:43:41 +0200
Message-Id: <20230523094354.83792-4-extja@kvaser.com>
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

Add new function, kvaser_pciefd_set_skb_timestamp(), to set skb hwtstamps.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 1821ffa4ca79..7646338d4d44 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -538,6 +538,13 @@ static int kvaser_pciefd_set_tx_irq(struct kvaser_pciefd_can *can)
 	return 0;
 }
 
+static inline void kvaser_pciefd_set_skb_timestamp(const struct kvaser_pciefd *pcie,
+						   struct sk_buff *skb, u64 timestamp)
+{
+	skb_hwtstamps(skb)->hwtstamp =
+		ns_to_ktime(div_u64(timestamp * 1000, pcie->freq_to_ticks_div));
+}
+
 static void kvaser_pciefd_setup_controller(struct kvaser_pciefd_can *can)
 {
 	u32 mode;
@@ -1171,7 +1178,6 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 	struct canfd_frame *cf;
 	struct can_priv *priv;
 	struct net_device_stats *stats;
-	struct skb_shared_hwtstamps *shhwtstamps;
 	u8 ch_id = (p->header[1] >> KVASER_PCIEFD_PACKET_CHID_SHIFT) & 0x7;
 
 	if (ch_id >= pcie->nr_channels)
@@ -1214,12 +1220,7 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 		stats->rx_bytes += cf->len;
 	}
 	stats->rx_packets++;
-
-	shhwtstamps = skb_hwtstamps(skb);
-
-	shhwtstamps->hwtstamp =
-		ns_to_ktime(div_u64(p->timestamp * 1000,
-				    pcie->freq_to_ticks_div));
+	kvaser_pciefd_set_skb_timestamp(pcie, skb, p->timestamp);
 
 	return netif_rx(skb);
 }
@@ -1282,7 +1283,6 @@ static int kvaser_pciefd_rx_error_frame(struct kvaser_pciefd_can *can,
 	struct net_device *ndev = can->can.dev;
 	struct sk_buff *skb;
 	struct can_frame *cf = NULL;
-	struct skb_shared_hwtstamps *shhwtstamps;
 	struct net_device_stats *stats = &ndev->stats;
 
 	old_state = can->can.state;
@@ -1323,10 +1323,7 @@ static int kvaser_pciefd_rx_error_frame(struct kvaser_pciefd_can *can,
 		return -ENOMEM;
 	}
 
-	shhwtstamps = skb_hwtstamps(skb);
-	shhwtstamps->hwtstamp =
-		ns_to_ktime(div_u64(p->timestamp * 1000,
-				    can->kv_pcie->freq_to_ticks_div));
+	kvaser_pciefd_set_skb_timestamp(can->kv_pcie, skb, p->timestamp);
 	cf->can_id |= CAN_ERR_BUSERROR | CAN_ERR_CNT;
 
 	cf->data[6] = bec.txerr;
@@ -1374,7 +1371,6 @@ static int kvaser_pciefd_handle_status_resp(struct kvaser_pciefd_can *can,
 		struct net_device *ndev = can->can.dev;
 		struct sk_buff *skb;
 		struct can_frame *cf;
-		struct skb_shared_hwtstamps *shhwtstamps;
 
 		skb = alloc_can_err_skb(ndev, &cf);
 		if (!skb) {
@@ -1394,10 +1390,7 @@ static int kvaser_pciefd_handle_status_resp(struct kvaser_pciefd_can *can,
 			cf->can_id |= CAN_ERR_RESTARTED;
 		}
 
-		shhwtstamps = skb_hwtstamps(skb);
-		shhwtstamps->hwtstamp =
-			ns_to_ktime(div_u64(p->timestamp * 1000,
-					    can->kv_pcie->freq_to_ticks_div));
+		kvaser_pciefd_set_skb_timestamp(can->kv_pcie, skb, p->timestamp);
 
 		cf->data[6] = bec.txerr;
 		cf->data[7] = bec.rxerr;
-- 
2.40.0

