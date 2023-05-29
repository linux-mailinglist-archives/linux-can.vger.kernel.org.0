Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2216A714A8C
	for <lists+linux-can@lfdr.de>; Mon, 29 May 2023 15:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjE2Nox (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 May 2023 09:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjE2Nov (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 May 2023 09:44:51 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4BC9C
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 06:44:50 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f3b9755961so3538940e87.0
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 06:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1685367888; x=1687959888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzVOv7hNYuzU6xDeRF9d44eaUEeVDuI93b5g5p8Z0Cg=;
        b=ab5Isl9Rho3xv6qb6Nl9bTzX8MyE+54hkEE+9wrHJR368BIUUVV0Un2WvvWQITWAJT
         hZTsn7NO58ZNXpWDmTEK4qOhUdAbO8/1/tNpEOIxOqaZ3566xA8aofhRWlutAehBOc6a
         QXwRKibI1VId4YOR2wp61KjAyB089NaGszDG3u4lQlUkTBuK620j3iVDB4yciqmuRCWM
         kHVQkfap0KeamkDriQOuAFrhiWzmTZCRDf6KnK1req5pueNRq0PDgCCx/wny/irQgdrd
         zFzc8ibhnWIR9BTHOeOgCLLJ36T69HEpPPfg3AZ5A0836hVQlnNMNPv7KrbNWh/r+Gcx
         Ynmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685367888; x=1687959888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzVOv7hNYuzU6xDeRF9d44eaUEeVDuI93b5g5p8Z0Cg=;
        b=FcoLKjmF+lbUcBpz7WvLDEFyEBlqkvS5aPh2Enj64WABnMIyZl0aLwWPYOSP6xBxaa
         Ue5aCo0HlICt+IWhnDgBuFP0pq7bOaYpCKC8rrn71EVpL4+TnW9KDuhi1gKgTaajqTrf
         SF7fWfLDMpgLQZb5s+7IN0dpU3ZDhF//6X5pkPBEfBPzThmRobibChzRJO/dNmXyuAju
         UjOsoNc+T+amp+yljRfjoftZHQrkQ/wlSzzAfjn6lfnZPk/5eJvMoSk5SC/lEi/ms95W
         vLjMtWx6Bx2NCcplMpjZl6RdGa1Z2ZBwOoKDA0gXl68n8q7gFN/ldJqyE/XlQ77XgGNe
         qAbw==
X-Gm-Message-State: AC+VfDwBeSnIKbd2PUuq/f4Qxwm6ravZ/ivcVdLv47tmXRWYHPw2Q8RY
        DEM17ZtQcc+W5YB8xVGNgC34EubYtNz7+F5S32Y=
X-Google-Smtp-Source: ACHHUZ7MFQMrHXH9bMNpc+J9zYxx7HP3pqBCP2907Z3zEGC/ivhNa3XPOKlTuzR0mu8HVYxLY1CBxQ==
X-Received: by 2002:ac2:4d18:0:b0:4f3:79af:fcb7 with SMTP id r24-20020ac24d18000000b004f379affcb7mr4112682lfi.26.1685367888524;
        Mon, 29 May 2023 06:44:48 -0700 (PDT)
Received: from freke.kvaser.se (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id s7-20020a19ad47000000b004ebae99cc1dsm580lfd.159.2023.05.29.06.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 06:44:48 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 04/14] can: kvaser_pciefd: Set hardware timestamp on transmitted packets
Date:   Mon, 29 May 2023 15:42:38 +0200
Message-Id: <20230529134248.752036-5-extja@kvaser.com>
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

