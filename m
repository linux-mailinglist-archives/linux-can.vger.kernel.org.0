Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2D870D964
	for <lists+linux-can@lfdr.de>; Tue, 23 May 2023 11:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbjEWJp2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 May 2023 05:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236266AbjEWJpW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 May 2023 05:45:22 -0400
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAE71B0
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:14 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2af28303127so48303041fa.3
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684835053; x=1687427053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8h2XeNKIQxjaPx6SlsE3dF3h/GM8EwkdLm+c7ncs9S0=;
        b=LOvflNkmohwkH1MukclimSNKuVox8/y5xvwXlEGreFvtpzY380AfF6Xaw2tpM6W5sU
         GdnP3O5HxtKY0F5pOwNk53nTKt4+a4azKrUcqrraaEsUxBOFUfoh/m2WKLbv9Av5BgtO
         2CpEn65241lAULVentQf+MVIcD6vHB/W+DAZ0msAbRlfM/PRdsmtOS52amWoiiwcq0Dj
         jHUGX/6KYNDv0GRHSAxWXhjsoiPoWOTOoRTAdTr6JLXhEJZiPqtUmZUh9jGU3wzUthvB
         WmG3XsiG4ZjX04/rsUkD2b+I47P3+JcCYU+MsALQF6GmCgz4ihqX/hkJeaMU4ByxsA+p
         A+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835053; x=1687427053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8h2XeNKIQxjaPx6SlsE3dF3h/GM8EwkdLm+c7ncs9S0=;
        b=MnKbnM4UlBuM8QWKojr9cYlb1nVOSQVNR5wGxMXHJl3AaztEpCX7kzFKQ0zfHbEeWy
         gvtHT85j/TgH/quVCadoS4IFGouxEWY9xYZ93B2zrD4LsQIQK34GT1CuS2/uTEjQvMpQ
         IHVQ8skgsEzQOthiiLjTLHkYj5rM+lXGksZgDsb5R5gCWValJPl4H1G5UgG5lphy857O
         doYDO+4dBUrwSfnNhqQC9+dFfJijkO2XbZ7sxmoWXU3PRLljdpgY50ztd3YIny3SQiTK
         3PQkhmltk8q5KC2R2zbPDXBiL/+PnxLVO1Affq6ETcxKdosto/Tq+CC5I/Xa2KfKWubd
         unQQ==
X-Gm-Message-State: AC+VfDzvs/kW6OPMeznlMJv6LqnQL+nia0vAL9yR9JQkerxiw1VEf9LK
        ESzWFng4b5B6UalfHki4FJnus7Sq2RF6hLVEjC0=
X-Google-Smtp-Source: ACHHUZ58HVj9YZq9sKCVODyd+clP3nD1Jago3lsBqqanxrkdMGwVBx/PVkaHoYxDk4tR3OVcE/gzKg==
X-Received: by 2002:a2e:8058:0:b0:2af:47b2:3f6a with SMTP id p24-20020a2e8058000000b002af47b23f6amr2466485ljg.53.1684835052984;
        Tue, 23 May 2023 02:44:12 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id c16-20020a2e9490000000b002ac87c15fd4sm1535551ljh.95.2023.05.23.02.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:44:12 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 12/12] can: kvaser_pciefd: Use TX FIFO size read from CAN controller
Date:   Tue, 23 May 2023 11:43:50 +0200
Message-Id: <20230523094354.83792-13-extja@kvaser.com>
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

Use the TX FIFO size read from CAN controller register, instead of using
hard coded value.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 0575bb84b280..5f67414e2875 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -640,8 +640,7 @@ static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
 	/* No room for a new message, stop the queue until at least one
 	 * successful transmit
 	 */
-	if (count >= KVASER_PCIEFD_CAN_TX_MAX_COUNT ||
-	    can->can.echo_skb[can->echo_idx])
+	if (count >= can->can.echo_skb_max || can->can.echo_skb[can->echo_idx])
 		netif_stop_queue(netdev);
 	spin_unlock_irqrestore(&can->echo_lock, irq_flags);
 
@@ -760,7 +759,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 	for (i = 0; i < pcie->nr_channels; i++) {
 		struct net_device *netdev;
 		struct kvaser_pciefd_can *can;
-		u32 status, tx_nr_packets;
+		u32 status, tx_nr_packets, tx_nr_packets_max;
 
 		netdev = alloc_candev(sizeof(struct kvaser_pciefd_can),
 				      KVASER_PCIEFD_CAN_TX_MAX_COUNT);
@@ -786,17 +785,11 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_BUS_LOAD_REG);
 
 		tx_nr_packets = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG);
-		if (((tx_nr_packets >> KVASER_PCIEFD_KCAN_TX_NR_PACKETS_MAX_SHIFT) &
-		      0xff) < KVASER_PCIEFD_CAN_TX_MAX_COUNT) {
-			dev_err(&pcie->pci->dev,
-				"Max Tx count is smaller than expected\n");
-
-			free_candev(netdev);
-			return -ENODEV;
-		}
+		tx_nr_packets_max =
+			(tx_nr_packets >> KVASER_PCIEFD_KCAN_TX_NR_PACKETS_MAX_SHIFT) & 0xff;
 
 		can->can.clock.freq = pcie->freq;
-		can->can.echo_skb_max = KVASER_PCIEFD_CAN_TX_MAX_COUNT;
+		can->can.echo_skb_max = min(KVASER_PCIEFD_CAN_TX_MAX_COUNT, tx_nr_packets_max - 1);
 		can->echo_idx = 0;
 		spin_lock_init(&can->echo_lock);
 		spin_lock_init(&can->lock);
@@ -1295,8 +1288,7 @@ static int kvaser_pciefd_handle_ack_packet(struct kvaser_pciefd *pcie,
 		len = can_get_echo_skb(can->can.dev, echo_idx, NULL);
 		count = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG) & 0xff;
 
-		if (count < KVASER_PCIEFD_CAN_TX_MAX_COUNT &&
-		    netif_queue_stopped(can->can.dev))
+		if (count < can->can.echo_skb_max && netif_queue_stopped(can->can.dev))
 			netif_wake_queue(can->can.dev);
 
 		if (!one_shot_fail) {
-- 
2.40.0

