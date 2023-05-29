Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733CB714A8B
	for <lists+linux-can@lfdr.de>; Mon, 29 May 2023 15:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjE2Now (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 May 2023 09:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjE2Nou (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 May 2023 09:44:50 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E18C9
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 06:44:49 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f3b9c88af8so3739599e87.2
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 06:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1685367887; x=1687959887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDz85CgYz9ViMIuawotBn/rMfmJ7JaWBqAhHGDsW2UM=;
        b=mzVI7Aoa0kLbfu7pQTzdM5RiMxrKSSsHE9+Y/lXObCU7upioHim6iaSLvSyk2/hjsH
         bXpROUL2nfSpmYucDESG8JrDSidpVXrCeEiVvxby9SV1NFUDXQWcOXr0KvcZVhrBJzTa
         +smsn7jbtF2Mz4eXwITgCOtD+5FcHRkEs5Qy7cVxoiJpDwpgx3uPkA8UhL0fNhtJKOMo
         oVg2zy6YgYCgFZr+jnXtqHWyL8F0Q+rKYG2hfhwVGmDsK1zQsPCeSg5m4ZJNklwl7DH4
         jEbAKXgsYmrWKNAr5hHq0dcT/jvW0QMmDQho63lJMwaV6B17KVECxps3wk1cFSf5O889
         NpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685367887; x=1687959887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDz85CgYz9ViMIuawotBn/rMfmJ7JaWBqAhHGDsW2UM=;
        b=f2i6sizhkN+vHi1U8EWdlIuRzjNLTl+Ght4NOaunvgKteLBbHUVIJsjbpylHykc+lj
         fYL4J85WXzNeqViT9J2Ct0QbGgCPtYwr7bWUjV1duACUOOf6OialwbSYaHVscQQ5q5zY
         SUJtdvRN/pQLy2jU47ElPkqC7lK8bsvW7tTTDAFk1NWmAmF27yJlRNlqJV/BtL5mbh0n
         IR2K+B6jkgnLGC5wAOJy0oZfCwRiiC0T/bMJeWRURe0YdAe+ehAQ4Secz0xaXoYmcIQX
         Xo+MBc46gYP3F5p5xABLTG7NmF3pzW4CR4aaGuK/qrePEDn1NL/7Vv4bOti5MRdWocYT
         XW5A==
X-Gm-Message-State: AC+VfDyHxvdpi0D6zS9z3ISpX70lcvo85W5e7HiqXGk7xenwNPlFdkVG
        9QPZGl6sDWDsGWzFkZkJh//itgHrVJzSeEL4lnI=
X-Google-Smtp-Source: ACHHUZ4Ujaje3FcZ0cWi1ex/w7+NTpIuIoLPCqJaKM0wsDa2jiSs4/DFLPfrV3Ywk3cC/Rfe5UEwjg==
X-Received: by 2002:ac2:47eb:0:b0:4f3:aa09:5566 with SMTP id b11-20020ac247eb000000b004f3aa095566mr3274846lfp.65.1685367887585;
        Mon, 29 May 2023 06:44:47 -0700 (PDT)
Received: from freke.kvaser.se (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id s7-20020a19ad47000000b004ebae99cc1dsm580lfd.159.2023.05.29.06.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 06:44:47 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 03/14] can: kvaser_pciefd: Add function to set skb hwtstamps
Date:   Mon, 29 May 2023 15:42:37 +0200
Message-Id: <20230529134248.752036-4-extja@kvaser.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230529134248.752036-1-extja@kvaser.com>
References: <20230529134248.752036-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

