Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881727BA6F0
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 18:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjJEQnV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 12:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjJEQlj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 12:41:39 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D9721D23
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 02:46:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoKwR-0002y6-4T
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 11:46:47 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoKwQ-00BEdV-2R
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 11:46:46 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id BDAA722F95F
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 09:46:45 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 4C8F222F93B;
        Thu,  5 Oct 2023 09:46:44 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2ef889b9;
        Thu, 5 Oct 2023 09:46:43 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Miquel Raynal <miquel.raynal@bootlin.com>,
        stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 4/7] can: sja1000: Always restart the Tx queue after an overrun
Date:   Thu,  5 Oct 2023 11:46:36 +0200
Message-Id: <20231005094639.387019-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231005094639.387019-1-mkl@pengutronix.de>
References: <20231005094639.387019-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

Upstream commit 717c6ec241b5 ("can: sja1000: Prevent overrun stalls with
a soft reset on Renesas SoCs") fixes an issue with Renesas own SJA1000
CAN controller reception: the Rx buffer is only 5 messages long, so when
the bus loaded (eg. a message every 50us), overrun may easily
happen. Upon an overrun situation, due to a possible internal crosstalk
situation, the controller enters a frozen state which only can be
unlocked with a soft reset (experimentally). The solution was to offload
a call to sja1000_start() in a threaded handler. This needs to happen in
process context as this operation requires to sleep. sja1000_start()
basically enters "reset mode", performs a proper software reset and
returns back into "normal mode".

Since this fix was introduced, we no longer observe any stalls in
reception. However it was sporadically observed that the transmit path
would now freeze. Further investigation blamed the fix mentioned above,
and especially the reset operation. Reproducing the reset in a loop
helped identifying what could possibly go wrong. The sja1000 is a single
Tx queue device, which leverages the netdev helpers to process one Tx
message at a time. The logic is: the queue is stopped, the message sent
to the transceiver, once properly transmitted the controller sets a
status bit which triggers an interrupt, in the interrupt handler the
transmission status is checked and the queue woken up. Unfortunately, if
an overrun happens, we might perform the soft reset precisely between
the transmission of the buffer to the transceiver and the advent of the
transmission status bit. We would then stop the transmission operation
without re-enabling the queue, leading to all further transmissions to
be ignored.

The reset interrupt can only happen while the device is "open", and
after a reset we anyway want to resume normal operations, no matter if a
packet to transmit got dropped in the process, so we shall wake up the
queue. Restarting the device and waking-up the queue is exactly what
sja1000_set_mode(CAN_MODE_START) does. In order to be consistent about
the queue state, we must acquire a lock both in the reset handler and in
the transmit path to ensure serialization of both operations. It turns
out, a lock is already held when entering the transmit path, so we can
just acquire/release it as well with the regular net helpers inside the
threaded interrupt handler and this way we should be safe. As the
reset handler might still be called after the transmission of a frame to
the transceiver but before it actually gets transmitted, we must ensure
we don't leak the skb, so we free it (the behavior is consistent, no
matter if there was an skb on the stack or not).

Fixes: 717c6ec241b5 ("can: sja1000: Prevent overrun stalls with a soft reset on Renesas SoCs")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/all/20231002160206.190953-1-miquel.raynal@bootlin.com
[mkl: fixed call to can_free_echo_skb()]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/sja1000.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 0ada0e160e93..743c2eb62b87 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -392,7 +392,13 @@ static irqreturn_t sja1000_reset_interrupt(int irq, void *dev_id)
 	struct net_device *dev = (struct net_device *)dev_id;
 
 	netdev_dbg(dev, "performing a soft reset upon overrun\n");
-	sja1000_start(dev);
+
+	netif_tx_lock(dev);
+
+	can_free_echo_skb(dev, 0, NULL);
+	sja1000_set_mode(dev, CAN_MODE_START);
+
+	netif_tx_unlock(dev);
 
 	return IRQ_HANDLED;
 }
-- 
2.40.1


