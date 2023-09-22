Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E277AB512
	for <lists+linux-can@lfdr.de>; Fri, 22 Sep 2023 17:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjIVPrj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 22 Sep 2023 11:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjIVPri (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 22 Sep 2023 11:47:38 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11379102;
        Fri, 22 Sep 2023 08:47:30 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0943AFF804;
        Fri, 22 Sep 2023 15:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695397649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0lon5/x4ZEHfLTXgH5Oz0uMHCKVpaOIfvunrk6KCYY8=;
        b=BtyEAKS9A+HwBtCIGxIpCJdFry61d7vWQPXsZM/EWliyHhbW2mTfsoDI63SXcCyfM1IeJW
        1VQwNqYfNnBQ6xYKTcFpJjLuZhZir3PP43ECpd1H2IwRXoVwFlGDdUbay9G+q9lS1JVn92
        xkgXW6+F+kS9qHOEtEWpX8UcSaSn+qf6HrfQW3o9HP/mE6OJTd4kTAEqENXAsife3Zx+6b
        EBluVNmGSOK27vb7FVZY/wBUoRSo6QnMAnUoYhr0WBJE15NpDnDeZ3B7hK9t6k/+mWCdM8
        ol7DXtK36tL+p88FkmM17o3fVq/MQwN0dHA5Zwl363wy25xsE/efGI1R0vlovA==
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
Subject: [PATCH net] can: sja1000: Always restart the Tx queue after an overrun
Date:   Fri, 22 Sep 2023 17:47:27 +0200
Message-Id: <20230922154727.591672-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

This patch was written and tested on a slightly older stable kernel as
this is the kernel that runs on the boards which shown the problem, but
there should be no difference with upstream kernels.

 drivers/net/can/sja1000/sja1000.c          | 13 ++++++++++++-
 drivers/net/can/sja1000/sja1000.h          |  1 +
 drivers/net/can/sja1000/sja1000_platform.c |  2 ++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index ae47fc72aa96..fe1d818f5d51 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -297,6 +297,8 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
 	if (can_dropped_invalid_skb(dev, skb))
 		return NETDEV_TX_OK;
 
+	spin_lock(&priv->tx_lock);
+
 	netif_stop_queue(dev);
 
 	fi = dlc = cf->can_dlc;
@@ -335,6 +337,8 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
 
 	sja1000_write_cmdreg(priv, cmd_reg_val);
 
+	spin_unlock(&priv->tx_lock);
+
 	return NETDEV_TX_OK;
 }
 
@@ -394,9 +398,16 @@ static void sja1000_rx(struct net_device *dev)
 static irqreturn_t sja1000_reset_interrupt(int irq, void *dev_id)
 {
 	struct net_device *dev = (struct net_device *)dev_id;
+	struct sja1000_priv *priv = netdev_priv(dev);
 
 	netdev_dbg(dev, "performing a soft reset upon overrun\n");
-	sja1000_start(dev);
+
+	spin_lock(&priv->tx_lock);
+
+	can_free_echo_skb(dev, 0);
+	sja1000_set_mode(dev, CAN_MODE_START);
+
+	spin_unlock(&priv->tx_lock);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/net/can/sja1000/sja1000.h b/drivers/net/can/sja1000/sja1000.h
index 9f041d027dcc..85def6329edb 100644
--- a/drivers/net/can/sja1000/sja1000.h
+++ b/drivers/net/can/sja1000/sja1000.h
@@ -166,6 +166,7 @@ struct sja1000_priv {
 	void __iomem *reg_base;	 /* ioremap'ed address to registers */
 	unsigned long irq_flags; /* for request_irq() */
 	spinlock_t cmdreg_lock;  /* lock for concurrent cmd register writes */
+	spinlock_t tx_lock;      /* lock for serializing transmissions and soft resets */
 
 	u16 flags;		/* custom mode flags */
 	u8 ocr;			/* output control register */
diff --git a/drivers/net/can/sja1000/sja1000_platform.c b/drivers/net/can/sja1000/sja1000_platform.c
index f33bad164813..ca3bcab461d8 100644
--- a/drivers/net/can/sja1000/sja1000_platform.c
+++ b/drivers/net/can/sja1000/sja1000_platform.c
@@ -305,6 +305,8 @@ static int sp_probe(struct platform_device *pdev)
 		priv->can.clock.freq = clk_get_rate(clk) / 2;
 	}
 
+	spin_lock_init(&priv->tx_lock);
+
 	platform_set_drvdata(pdev, dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
-- 
2.34.1

