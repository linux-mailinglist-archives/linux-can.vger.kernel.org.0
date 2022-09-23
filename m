Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944BC5E79BE
	for <lists+linux-can@lfdr.de>; Fri, 23 Sep 2022 13:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiIWLie (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 23 Sep 2022 07:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiIWLia (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 23 Sep 2022 07:38:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0066D137450
        for <linux-can@vger.kernel.org>; Fri, 23 Sep 2022 04:38:28 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1obh0l-00037J-Fk
        for linux-can@vger.kernel.org; Fri, 23 Sep 2022 13:38:27 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id D00C6EB0B6
        for <linux-can@vger.kernel.org>; Fri, 23 Sep 2022 11:38:26 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 17BE2EB0B3;
        Fri, 23 Sep 2022 11:38:26 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2e1f5021;
        Fri, 23 Sep 2022 11:38:25 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Jacob Kroon <jacob.kroon@gmail.com>
Subject: [PATCH RFC] can: c_can: wake TX queue after kicking TX of cached CAN frames
Date:   Fri, 23 Sep 2022 13:38:21 +0200
Message-Id: <20220923113821.718486-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Link: https://lore.kernel.org/all/15a8084b-9617-2da1-6704-d7e39d60643b@gmail.com
Reported-by: Jacob Kroon <jacob.kroon@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can_main.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
index dc8132862f33..fcf71c1f3b72 100644
--- a/drivers/net/can/c_can/c_can_main.c
+++ b/drivers/net/can/c_can/c_can_main.c
@@ -748,19 +748,8 @@ static void c_can_do_tx(struct net_device *dev)
 		return;
 
 	tx_ring->tail += pkts;
-	if (c_can_get_tx_free(tx_ring)) {
-		/* Make sure that anybody stopping the queue after
-		 * this sees the new tx_ring->tail.
-		 */
-		smp_mb();
-		netif_wake_queue(priv->dev);
-	}
-
-	stats->tx_bytes += bytes;
-	stats->tx_packets += pkts;
 
 	tail = c_can_get_tx_tail(tx_ring);
-
 	if (tail == 0) {
 		u8 head = c_can_get_tx_head(tx_ring);
 
@@ -770,6 +759,17 @@ static void c_can_do_tx(struct net_device *dev)
 			c_can_object_put(dev, IF_NAPI, obj, IF_COMM_TXRQST);
 		}
 	}
+
+	if (c_can_get_tx_free(tx_ring)) {
+		/* Make sure that anybody stopping the queue after
+		 * this sees the new tx_ring->tail.
+		 */
+		smp_mb();
+		netif_wake_queue(priv->dev);
+	}
+
+	stats->tx_bytes += bytes;
+	stats->tx_packets += pkts;
 }
 
 /* If we have a gap in the pending bits, that means we either
-- 
2.35.1


