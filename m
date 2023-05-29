Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79190714A96
	for <lists+linux-can@lfdr.de>; Mon, 29 May 2023 15:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjE2NpN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 May 2023 09:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjE2NpM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 May 2023 09:45:12 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84D0E3
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 06:45:00 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f3edc05aa5so3566765e87.3
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 06:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1685367899; x=1687959899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xxhb5aEZpD3+WBkM+NW9x4nVd6k3ixrIRRsc45uHdo=;
        b=unwtn3lC3pzVlL0Y9/RZ4e+0nXng7kdvsG/FKoO0G6cLHzXZ4WUSNDoDday0x2kF34
         +SKXQN5Qh0XvJJTsHs1JqI+PpsxnaaSm+XWg+Cs5C2kkZxyACYzuRcrEfT91sXAA83wN
         kyN2Pqn0ctj9X+dr9mtd0qKCzQA7cRK0ekvQpC6eiCgrPqax/p3xzynxnIejAv/CuUq6
         bM8vxDt8rEQPh/aimwQPbw0gkHQhFHSlcVW/NJ3vSmf+13FK3P3m0A7RpdMrJzZahfGP
         jx9ODu6MwWq8Q1JWG+SIfOphSsL3E+1Wt33IkWu+61xMA0SoMCBWxG5q97iy/zifT498
         yENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685367899; x=1687959899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xxhb5aEZpD3+WBkM+NW9x4nVd6k3ixrIRRsc45uHdo=;
        b=mA5ibvMSQrPHYphAc/niGHRHaQuAfoc+tIM988k1K5xHirBmYOYbACLis1D3S/TBln
         QQrpMUQeu/KIf63GoFDJsJ3gH+uNGD9Cdb0+xN417kOksndLNXm7T3NJNBfINXvhzRaC
         CHatNaHF9PQD8+IlZzf4pr26y9ECcC70v/H4lYOZ1boW8ixLjbSxCtfU1fUMoLW2nTTO
         0TcDsIL9ThAMR6XCnwh7q+qDZ/AVjz18wH4+gY/jFW4aagIu0dDkQlp2mb3eIpMX+EmH
         ObmP/hgek2xrEIKO0vccOZwPjp3KvluL5H+tBbW0LA1HUL2JON32JX4pMGisI79hDmPg
         RkpA==
X-Gm-Message-State: AC+VfDyucbpVPY/VU1o9NE5cOfgShyzEs66jEDXNm4Y0G5bkCvmmsaIf
        n2gXyTR6emBybs7C67VyT3kPmKlfh8HY1Pj8Y6I=
X-Google-Smtp-Source: ACHHUZ7W2oE4MOSmLLS3Jv7Wa+YacjEalHNoJRL9lauJg7Y8hPcRvm/fRU+rGxz8o+96hz5H0JtVhQ==
X-Received: by 2002:ac2:532d:0:b0:4e9:74a8:134c with SMTP id f13-20020ac2532d000000b004e974a8134cmr3195197lfh.43.1685367898867;
        Mon, 29 May 2023 06:44:58 -0700 (PDT)
Received: from freke.kvaser.se (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id s7-20020a19ad47000000b004ebae99cc1dsm580lfd.159.2023.05.29.06.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 06:44:58 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 14/14] can: kvaser_pciefd: Use TX FIFO size read from CAN controller
Date:   Mon, 29 May 2023 15:42:48 +0200
Message-Id: <20230529134248.752036-15-extja@kvaser.com>
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

Use the TX FIFO size read from CAN controller register, instead of using
hard coded value.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
 - Rebased on
  can: kvaser_pciefd: Use FIELD_{GET,PREP} and GENMASK where appropriate

 drivers/net/can/kvaser_pciefd.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 0321b70a3b71..db6256f2b1b3 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -658,8 +658,7 @@ static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
 	/* No room for a new message, stop the queue until at least one
 	 * successful transmit
 	 */
-	if (count >= KVASER_PCIEFD_CAN_TX_MAX_COUNT ||
-	    can->can.echo_skb[can->echo_idx])
+	if (count >= can->can.echo_skb_max || can->can.echo_skb[can->echo_idx])
 		netif_stop_queue(netdev);
 	spin_unlock_irqrestore(&can->echo_lock, irq_flags);
 
@@ -802,16 +801,9 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		tx_nr_packets_max =
 			FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_MAX_MASK,
 				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
-		if (tx_nr_packets_max < KVASER_PCIEFD_CAN_TX_MAX_COUNT) {
-			dev_err(&pcie->pci->dev,
-				"Max Tx count is smaller than expected\n");
-
-			free_candev(netdev);
-			return -ENODEV;
-		}
 
 		can->can.clock.freq = pcie->freq;
-		can->can.echo_skb_max = KVASER_PCIEFD_CAN_TX_MAX_COUNT;
+		can->can.echo_skb_max = min(KVASER_PCIEFD_CAN_TX_MAX_COUNT, tx_nr_packets_max - 1);
 		can->echo_idx = 0;
 		spin_lock_init(&can->echo_lock);
 		spin_lock_init(&can->lock);
@@ -1311,8 +1303,7 @@ static int kvaser_pciefd_handle_ack_packet(struct kvaser_pciefd *pcie,
 		count = FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_CURRENT_MASK,
 				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
 
-		if (count < KVASER_PCIEFD_CAN_TX_MAX_COUNT &&
-		    netif_queue_stopped(can->can.dev))
+		if (count < can->can.echo_skb_max && netif_queue_stopped(can->can.dev))
 			netif_wake_queue(can->can.dev);
 
 		if (!one_shot_fail) {
-- 
2.40.0

