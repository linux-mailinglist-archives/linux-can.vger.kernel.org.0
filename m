Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987C67BAB02
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 21:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjJET6q (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 15:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjJET61 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 15:58:27 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D21F1
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 12:58:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoUUJ-0004mG-C6
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 21:58:23 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoUUE-00BLIS-Uc
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 21:58:19 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 27B4022FFF9
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 19:58:18 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 7D9EC22FF84;
        Thu,  5 Oct 2023 19:58:15 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e0cf1751;
        Thu, 5 Oct 2023 19:58:14 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 13/37] can: at91_can: at91_irq_tx(): remove one level of indention
Date:   Thu,  5 Oct 2023 21:57:48 +0200
Message-Id: <20231005195812.549776-14-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231005195812.549776-1-mkl@pengutronix.de>
References: <20231005195812.549776-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Improve code readability by removing one level of indention.

If a mailbox is not ready, continue the loop early.

Link: https://lore.kernel.org/all/20231005-at91_can-rx_offload-v2-3-9987d53600e0@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 367ccf109652..966980d4b5dd 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -844,15 +844,14 @@ static void at91_irq_tx(struct net_device *dev, u32 reg_sr)
 		 * parked in the echo queue.
 		 */
 		reg_msr = at91_read(priv, AT91_MSR(mb));
-		if (likely(reg_msr & AT91_MSR_MRDY &&
-			   ~reg_msr & AT91_MSR_MABT)) {
-			/* _NOTE_: subtract AT91_MB_TX_FIRST offset from mb! */
-			dev->stats.tx_bytes +=
-				can_get_echo_skb(dev,
-						 mb - get_mb_tx_first(priv),
-						 NULL);
-			dev->stats.tx_packets++;
-		}
+		if (unlikely(!(reg_msr & AT91_MSR_MRDY &&
+			       ~reg_msr & AT91_MSR_MABT)))
+			continue;
+
+		/* _NOTE_: subtract AT91_MB_TX_FIRST offset from mb! */
+		dev->stats.tx_bytes +=
+			can_get_echo_skb(dev, mb - get_mb_tx_first(priv), NULL);
+		dev->stats.tx_packets++;
 	}
 
 	/* restart queue if we don't have a wrap around but restart if
-- 
2.40.1


