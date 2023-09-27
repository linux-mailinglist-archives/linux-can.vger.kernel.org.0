Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334457B0A8C
	for <lists+linux-can@lfdr.de>; Wed, 27 Sep 2023 18:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjI0Qox (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Sep 2023 12:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI0Qow (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Sep 2023 12:44:52 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53C7DE;
        Wed, 27 Sep 2023 09:44:49 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8AB4E40008;
        Wed, 27 Sep 2023 16:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695833088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BEnA+4VbEJeH5HDgFtxvbMfUUuHfAtx7xIumbZLJvA4=;
        b=X0GeJbOQNtxmURcp++OY3IXbD0GThK22N2awW/bcBkxWlbO7+q30TOK96Tk7UMOGEn7iUd
        EJjYU6JvmBMAahB5BUFarxJf8A+OhExS000tW/IYpdLdsdVat9ajGk/bVcv85XLqitJpkp
        SqGtLeY+E5hIzF+X1gwJPhO63+9UNy62OYwRnL1eADRISDQ4dAu2i5mx3+Jc4LW96XW641
        oK0oDhb70nWgNbgdlWXCVMjMXwb+KCmL7Fl51JGGKz4ITtBUvZy3ejJURfg8jDbp6UStWr
        14s9Bzs5oYUyyO2JhCpEh871teMUZKC9vN5DfqyBMYwnO50oZU6PCKCQg/4RKA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-can@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= 
        <jeremie.dautheribes@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        sylvain.girard@se.com, pascal.eberhard@se.com,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] can: sja1000: Always restart the Tx queue after an overrun
Date:   Wed, 27 Sep 2023 18:44:42 +0200
Message-Id: <20230927164442.128204-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

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
the transmit path to ensure serialization of both operations. As the
reset handler might still be called after the transmission of a frame to
the transceiver but before it actually gets transmitted, we must ensure
we don't leak the skb, so we free it (the behavior is consistent, no
matter if there was an skb on the stack or not).

Fixes: 717c6ec241b5 ("can: sja1000: Prevent overrun stalls with a soft reset on Renesas SoCs")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Changes in v2:
* As Marc sugested, use netif_tx_{,un}lock() instead of our own
  spin_lock.

 drivers/net/can/sja1000/sja1000.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index ae47fc72aa96..91e3fb3eed20 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -297,6 +297,7 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
 	if (can_dropped_invalid_skb(dev, skb))
 		return NETDEV_TX_OK;
 
+	netif_tx_lock(dev);
 	netif_stop_queue(dev);
 
 	fi = dlc = cf->can_dlc;
@@ -335,6 +336,8 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
 
 	sja1000_write_cmdreg(priv, cmd_reg_val);
 
+	netif_tx_unlock(dev);
+
 	return NETDEV_TX_OK;
 }
 
@@ -396,7 +399,13 @@ static irqreturn_t sja1000_reset_interrupt(int irq, void *dev_id)
 	struct net_device *dev = (struct net_device *)dev_id;
 
 	netdev_dbg(dev, "performing a soft reset upon overrun\n");
-	sja1000_start(dev);
+
+	netif_tx_lock(dev);
+
+	can_free_echo_skb(dev, 0);
+	sja1000_set_mode(dev, CAN_MODE_START);
+
+	netif_tx_unlock(dev);
 
 	return IRQ_HANDLED;
 }
-- 
2.34.1

