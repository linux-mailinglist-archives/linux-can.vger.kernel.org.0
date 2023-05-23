Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7A970D95D
	for <lists+linux-can@lfdr.de>; Tue, 23 May 2023 11:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbjEWJpW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 May 2023 05:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbjEWJpN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 May 2023 05:45:13 -0400
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA88119
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:08 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4f3bb395e69so3225276e87.2
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684835046; x=1687427046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzVOv7hNYuzU6xDeRF9d44eaUEeVDuI93b5g5p8Z0Cg=;
        b=gMqfBFAeRs/r4/hdJ2rDL3ujR/qwU+zPiinmIPz/iQU/yq5ZdDse5rZEIaauot0cR5
         ytnnHzpvEx4eZxuRvK2ROG3wZq+qi3Zhm1KvwRHnkcO5crwMQjq+klJEtJtpW0NPCJhu
         ciXU2/idQjVisjNKK9peGB6sPrAoZgBDpMmc/O1NxQ6w0REpN2zE+vVUYC49o6lAlRam
         qoRp44IX9uOufdZQQCYPSnVVPIHMKDduCMvHOGKpR1y4GStCX0rdRFDse3qdHfNGTTEF
         50BEmYy9M6XHjYBmCEFM4vYn3Z9mmW59CfiHB4dfpJeUkCevMtSfC4matcs8OG9CmL0i
         FRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835046; x=1687427046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzVOv7hNYuzU6xDeRF9d44eaUEeVDuI93b5g5p8Z0Cg=;
        b=GIIE1bdp/lUPNjLqwVwMykborXMZriG8hkD8bHTl9O4W1f+ppbpjRyQSuCGbzHIrdC
         9fEKLfFFpJcaS2uwcgPnxUh2rhXqt3H2sSl1wtBYNxj2MBFvvx/XqqvLdhYuZUGg7vu1
         zuejLdsWu+w5/5agDBOL+BjHM/FzDZHM1tEMVWnad2DAPS34dS+ds03DmOf35t3lFj+q
         wprBPIMvarG6pi3R1ArYoDSfFR+ozEbODxMpB5UKSUsD/2o9c1Dn+d8kEX+ks3x7EAb0
         FqIcAh5jq3wwaEtIObcBV0XjrHvkvyD4bhtlhBgNA9JyGGAdX6q8JgFoevjzDDE0kP0/
         yIAg==
X-Gm-Message-State: AC+VfDyhyp6ndbdsi56O8uEM7u2lNZNrXbhIDCTolWVs4+eP3SeWm1AG
        BT+Ta27iCcHU6Xv3EokVJVp36U4qea64eLLaTdQ=
X-Google-Smtp-Source: ACHHUZ6aEg0YkkuCwrH5uTpbxm8noN1kyBvmpFaFpd3n2PBXfvuBXYOtZHk3/TmNZDr3qtkRyzAvPA==
X-Received: by 2002:ac2:44ac:0:b0:4f3:b07e:7eb8 with SMTP id c12-20020ac244ac000000b004f3b07e7eb8mr4387695lfm.29.1684835046561;
        Tue, 23 May 2023 02:44:06 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id c16-20020a2e9490000000b002ac87c15fd4sm1535551ljh.95.2023.05.23.02.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:44:06 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 04/12] can: kvaser_pciefd: Set hardware timestamp on transmitted packets
Date:   Tue, 23 May 2023 11:43:42 +0200
Message-Id: <20230523094354.83792-5-extja@kvaser.com>
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

Set hardware timestamp on transmitted packets.

Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 7646338d4d44..88bad2c2b641 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1485,6 +1485,7 @@ static void kvaser_pciefd_handle_nack_packet(struct kvaser_pciefd_can *can,
 
 	if (skb) {
 		cf->can_id |= CAN_ERR_BUSERROR;
+		kvaser_pciefd_set_skb_timestamp(can->kv_pcie, skb, p->timestamp);
 		netif_rx(skb);
 	} else {
 		stats->rx_dropped++;
@@ -1516,8 +1517,15 @@ static int kvaser_pciefd_handle_ack_packet(struct kvaser_pciefd *pcie,
 		netdev_dbg(can->can.dev, "Packet was flushed\n");
 	} else {
 		int echo_idx = p->header[0] & KVASER_PCIEFD_PACKET_SEQ_MSK;
-		int dlc = can_get_echo_skb(can->can.dev, echo_idx, NULL);
-		u8 count = ioread32(can->reg_base +
+		int dlc;
+		u8 count;
+		struct sk_buff *skb;
+
+		skb = can->can.echo_skb[echo_idx];
+		if (skb)
+			kvaser_pciefd_set_skb_timestamp(pcie, skb, p->timestamp);
+		dlc = can_get_echo_skb(can->can.dev, echo_idx, NULL);
+		count = ioread32(can->reg_base +
 				    KVASER_PCIEFD_KCAN_TX_NPACKETS_REG) & 0xff;
 
 		if (count < KVASER_PCIEFD_CAN_TX_MAX_COUNT &&
-- 
2.40.0

