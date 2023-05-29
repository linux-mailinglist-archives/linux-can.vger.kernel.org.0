Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CC4714A8A
	for <lists+linux-can@lfdr.de>; Mon, 29 May 2023 15:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjE2Now (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 May 2023 09:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjE2Not (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 May 2023 09:44:49 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C03A8E
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 06:44:48 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f3baf04f0cso3576585e87.1
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 06:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1685367886; x=1687959886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vI+QgWQ2DMzBFFxUrz1+8rCe6YyqzMwcF40P0c1WSU=;
        b=pIHS3zv/0+k5mIECSBwaS8zPO8OL618uZp0uswS5e+9c+QK+LXeKC19SMOQorvmbkl
         yhpzAHIqiMdHUcVf+uufN2wXTq0g/v2DEQo8RCvrPV4gmXQ4+1o/B5PB+wcLcvP/VgbW
         ROK1AMWfG5+bD5i2t+NnpUDE3uybYXg2WB5LFZLUcjgBOyiqxEfY/cv1diD4eclhtU1l
         JVs8VZVUjDr60To+b6BSOXBtEaLMBOR1so6i5kKtoGOvYKKB1N6+4yhYPU6gbz6cFBtr
         g6FF2SmTRjHDfO1W/n8G0Mz5n0sd5sfY2DcwrlkHlf9aazXEYLg50mOmXmIYGhQSVBon
         1XYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685367886; x=1687959886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vI+QgWQ2DMzBFFxUrz1+8rCe6YyqzMwcF40P0c1WSU=;
        b=AU9Bs6MpFn5A+poD1R4w80YPTeWwhJoky3yd57U1I2tpw+2fXKChEmnwpztAW3uvGv
         xIKg6fqpt/b8cZg9dH8PfzrbNgbMP0TW2b8But3aLooqqpa+vPsJLO3I6NBFRVKYV2Cv
         vq6Ck9QLCV3HVo425jSxSM3eahFp1CYQc47gZv8AiX9o8eGbjEt9ZEU2kMCs9gc7pOiL
         HzJWryseywNaKIqYheiynjfZE1UGQIB3d3Yg1xclA9USRwImavKhyGUclr6pbHqjLypZ
         Ccz9TvRQHuYXLuEexwpm7hLxEDSjf5XnAYpgNoWneZ9LPiF1es5gIGkB2uiy1fE/PIyS
         BE3w==
X-Gm-Message-State: AC+VfDwsQb9kXdTwCWxyxUvIOwA5GSmd/nTonR0GGVb0DOWsa6g4Bldw
        nj5wgKm2xhHkaZk5CJnRXvMsKeXuY6FPCYsWlZk=
X-Google-Smtp-Source: ACHHUZ5nUwEBwdo7wrmMqctMBPml6rLoMFEm04Zq4bPMV/IlhU6ZSbM+UOxUvwBwAdH/twuY+VhMIw==
X-Received: by 2002:ac2:5605:0:b0:4e9:9e45:3470 with SMTP id v5-20020ac25605000000b004e99e453470mr3179784lfd.3.1685367886500;
        Mon, 29 May 2023 06:44:46 -0700 (PDT)
Received: from freke.kvaser.se (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id s7-20020a19ad47000000b004ebae99cc1dsm580lfd.159.2023.05.29.06.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 06:44:46 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 02/14] can: kvaser_pciefd: Remove handler for unused KVASER_PCIEFD_PACK_TYPE_EFRAME_ACK
Date:   Mon, 29 May 2023 15:42:36 +0200
Message-Id: <20230529134248.752036-3-extja@kvaser.com>
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

