Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C1B7B5791
	for <lists+linux-can@lfdr.de>; Mon,  2 Oct 2023 18:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbjJBQCP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 2 Oct 2023 12:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238422AbjJBQCP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 2 Oct 2023 12:02:15 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCA3E5;
        Mon,  2 Oct 2023 09:02:10 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 71297240004;
        Mon,  2 Oct 2023 16:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696262529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VceR3KZ7j/tRvYYnO2ZWLO0nUF4+UHbP0i80WdJuN3s=;
        b=GG7WmlMedaqR7tTwyF8niW1i9CBEBj8f9xTfUhkr5VmpSgNCSFds5MecI5Do43C6eh+1+R
        4AxOUX/PR4z5S7TdSXep3QcIn65x4OdUN/4IieMjidzIoLhxqcZedu9PreEVub1HhDLJlJ
        Iwm2HQN7uHnZtJDNGSZsJeqnQF1I02VM8A2d+LFYyl1CvL5Dfs/PG7Og0Zdji0LF+og27/
        ZPVXGcI2aemCouo8ZAiTnNrKJVoJ9yh8jhBoS9wcUh8WmGLYPj/pMksmaFFBT/vQCgG/si
        ZYt9Dy83BO2wA66j3E50/t02VT4cP8CVQCDKFU2vuMdCySYwL0btG3Om8v/inw==
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
Subject: [PATCH v3] can: sja1000: Always restart the Tx queue after an overrun
Date:   Mon,  2 Oct 2023 18:02:06 +0200
Message-Id: <20231002160206.190953-1-miquel.raynal@bootlin.com>
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
---

Changes in v3:
* Fix new implementation by just acquiring the tx lock when required.

Changes in v2:
* As Marc sugested, use netif_tx_{,un}lock() instead of our own
  spin_lock.

 drivers/net/can/sja1000/sja1000.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index ae47fc72aa96..9531684d47cd 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -396,7 +396,13 @@ static irqreturn_t sja1000_reset_interrupt(int irq, void *dev_id)
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

