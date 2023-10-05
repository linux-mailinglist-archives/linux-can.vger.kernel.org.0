Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43C77BAAFF
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 21:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjJET6v (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 15:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbjJET6b (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 15:58:31 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E61D11C
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 12:58:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoUUM-0004sk-4v
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 21:58:26 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoUUH-00BLO6-JF
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 21:58:21 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 35DC0230085
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 19:58:21 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id CF63F22FFE8;
        Thu,  5 Oct 2023 19:58:17 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8d10ecff;
        Thu, 5 Oct 2023 19:58:15 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 32/37] can: at91_can: at91_irq_err_line(): make use of can_state_get_by_berr_counter()
Date:   Thu,  5 Oct 2023 21:58:07 +0200
Message-Id: <20231005195812.549776-33-mkl@pengutronix.de>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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

Link: https://lore.kernel.org/all/20231005-at91_can-rx_offload-v2-22-9987d53600e0@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 51 ++++----------------------------------
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


