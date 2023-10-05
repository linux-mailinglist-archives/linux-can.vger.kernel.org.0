Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9B87BA523
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 18:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbjJEQOA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 12:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240520AbjJEQNF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 12:13:05 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A4D7EE7
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 00:50:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7j-0001KA-3C
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:19 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7g-00BDNb-G7
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:16 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 255DE22F7E9
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 07:50:16 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 7E53A22F7D0;
        Thu,  5 Oct 2023 07:50:15 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 4d4ceaa0;
        Thu, 5 Oct 2023 07:50:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Thu, 05 Oct 2023 09:49:50 +0200
Subject: [PATCH v2 22/27] can: at91_can: at91_irq_err_line(): make use of
 can_state_get_by_berr_counter()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-at91_can-rx_offload-v2-22-9987d53600e0@pengutronix.de>
References: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
In-Reply-To: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2566; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=NBtg0nSF52ASCwpECUByxMfwkRbieD30ti/dFVOHNU4=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHmqqPu0p4C3SpyoXohPma8taHKTM92sO/FQRj
 Yeo9o9MsDKJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR5qqgAKCRC+UBxKKooE
 6GEFB/97+EZmgHxUBsvuyA6vKCMrIV2SkBJ65wftay+Z+83u4ejFhkLP8BTVamFouatB7Sxvq9Z
 1lhD2Ye3SxjqxH9TTkjaxxenFmKsUPre0d+n1N6AVboAmoX/G1K91aCK0GXuwOp9wLzEm2GCdw+
 VrCGUJxhScZuFW9t/9h7mu35jVKcQE7yAy9N3wVjrO4lroXaEkmHqJ4qYwhcHevjCONS8uZKBpD
 yaN6tNNmoqAv8Qz3FVqqqx9g6mVcQjEg1T7OL9nYNzueI3WBm8Spp5ZX2NWUi1r8PPqzV+EmmlZ
 g8pEowKD0VBFvioghcNcIPfykV79v6oCOc0pvmpOTgaHUQgZ
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
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

On the sam9263 the SR bits for bus off, error passive, warning limit,
and error active are not latched and reflect the current status of the
controller. On the sam9x5 and newer SoCs these bits are latched.

To simplify the code, use can_state_get_by_berr_counter() to get the
state of the controller regardless of the SoC version.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 51 +++++-----------------------------------------
 1 file changed, 5 insertions(+), 46 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 4249a1c95769..68b611d0fa6c 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -932,58 +932,17 @@ static void at91_irq_err_state(struct net_device *dev,
 	at91_write(priv, AT91_IER, reg_ier);
 }
 
-static int at91_get_state_by_bec(const struct net_device *dev,
-				 enum can_state *state)
-{
-	struct can_berr_counter bec;
-	int err;
-
-	err = at91_get_berr_counter(dev, &bec);
-	if (err)
-		return err;
-
-	if (bec.txerr < 96 && bec.rxerr < 96)
-		*state = CAN_STATE_ERROR_ACTIVE;
-	else if (bec.txerr < 128 && bec.rxerr < 128)
-		*state = CAN_STATE_ERROR_WARNING;
-	else if (bec.txerr < 256 && bec.rxerr < 256)
-		*state = CAN_STATE_ERROR_PASSIVE;
-	else
-		*state = CAN_STATE_BUS_OFF;
-
-	return 0;
-}
-
 static void at91_irq_err_line(struct net_device *dev)
 {
+	enum can_state new_state, rx_state, tx_state;
 	struct at91_priv *priv = netdev_priv(dev);
+	struct can_berr_counter bec;
 	struct sk_buff *skb;
 	struct can_frame *cf;
-	enum can_state new_state;
-	u32 reg_sr;
-	int err;
 
-	if (at91_is_sam9263(priv)) {
-		reg_sr = at91_read(priv, AT91_SR);
-
-		/* we need to look at the unmasked reg_sr */
-		if (unlikely(reg_sr & AT91_IRQ_BOFF)) {
-			new_state = CAN_STATE_BUS_OFF;
-		} else if (unlikely(reg_sr & AT91_IRQ_ERRP)) {
-			new_state = CAN_STATE_ERROR_PASSIVE;
-		} else if (unlikely(reg_sr & AT91_IRQ_WARN)) {
-			new_state = CAN_STATE_ERROR_WARNING;
-		} else if (likely(reg_sr & AT91_IRQ_ERRA)) {
-			new_state = CAN_STATE_ERROR_ACTIVE;
-		} else {
-			netdev_err(dev, "BUG! hardware in undefined state\n");
-			return;
-		}
-	} else {
-		err = at91_get_state_by_bec(dev, &new_state);
-		if (err)
-			return;
-	}
+	at91_get_berr_counter(dev, &bec);
+	can_state_get_by_berr_counter(dev, &bec, &tx_state, &rx_state);
+	new_state = max(tx_state, rx_state);
 
 	/* state hasn't changed */
 	if (likely(new_state == priv->can.state))

-- 
2.40.1


