Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9687BAB10
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 21:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjJET6t (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 15:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjJET6b (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 15:58:31 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F75B11F
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 12:58:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoUUM-0004sj-E6
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 21:58:26 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoUUH-00BLO5-Iu
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 21:58:21 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 2D294230084
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 19:58:21 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 0474222FFF2;
        Thu,  5 Oct 2023 19:58:18 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 91987050;
        Thu, 5 Oct 2023 19:58:15 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 33/37] can: at91_can: at91_irq_err_line(): take reg_sr into account for bus off
Date:   Thu,  5 Oct 2023 21:58:08 +0200
Message-Id: <20231005195812.549776-34-mkl@pengutronix.de>
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

The at91 CAN controller automatically recovers from bus-off after 128
occurrences of 11 consecutive recessive bits.

After an auto-recovered bus-off, the error counters no longer reflect
this fact. On the sam9263 the state bits in the SR register show the
current state (based on the current error counters), while on sam9x5
and newer SoCs these bits are latched.

Take any latched bus-off information from the SR register into account
when calculating the CAN new state, to start the standard CAN bus off
handling.

Link: https://lore.kernel.org/all/20231005-at91_can-rx_offload-v2-23-9987d53600e0@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 68b611d0fa6c..fbe58a1a1989 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -437,6 +437,11 @@ static void at91_chip_start(struct net_device *dev)
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
+	/* Dummy read to clear latched line error interrupts on
+	 * sam9x5 and newer SoCs.
+	 */
+	at91_read(priv, AT91_SR);
+
 	/* Enable interrupts */
 	reg_ier = get_irq_mb_rx(priv) | AT91_IRQ_ERRP | AT91_IRQ_ERR_FRAME;
 	at91_write(priv, AT91_IER, reg_ier);
@@ -932,7 +937,7 @@ static void at91_irq_err_state(struct net_device *dev,
 	at91_write(priv, AT91_IER, reg_ier);
 }
 
-static void at91_irq_err_line(struct net_device *dev)
+static void at91_irq_err_line(struct net_device *dev, const u32 reg_sr)
 {
 	enum can_state new_state, rx_state, tx_state;
 	struct at91_priv *priv = netdev_priv(dev);
@@ -942,6 +947,23 @@ static void at91_irq_err_line(struct net_device *dev)
 
 	at91_get_berr_counter(dev, &bec);
 	can_state_get_by_berr_counter(dev, &bec, &tx_state, &rx_state);
+
+	/* The chip automatically recovers from bus-off after 128
+	 * occurrences of 11 consecutive recessive bits.
+	 *
+	 * After an auto-recovered bus-off, the error counters no
+	 * longer reflect this fact. On the sam9263 the state bits in
+	 * the SR register show the current state (based on the
+	 * current error counters), while on sam9x5 and newer SoCs
+	 * these bits are latched.
+	 *
+	 * Take any latched bus-off information from the SR register
+	 * into account when calculating the CAN new state, to start
+	 * the standard CAN bus off handling.
+	 */
+	if (reg_sr & AT91_IRQ_BOFF)
+		rx_state = CAN_STATE_BUS_OFF;
+
 	new_state = max(tx_state, rx_state);
 
 	/* state hasn't changed */
@@ -1050,7 +1072,7 @@ static irqreturn_t at91_irq(int irq, void *dev_id)
 	if (reg_sr & get_irq_mb_tx(priv))
 		at91_irq_tx(dev, reg_sr);
 
-	at91_irq_err_line(dev);
+	at91_irq_err_line(dev, reg_sr);
 
 	/* Frame Error Interrupt */
 	if (reg_sr & AT91_IRQ_ERR_FRAME)
-- 
2.40.1


