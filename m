Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 031989489C
	for <lists+linux-can@lfdr.de>; Mon, 19 Aug 2019 17:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfHSPi0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Aug 2019 11:38:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53139 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfHSPi0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Aug 2019 11:38:26 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1hzjjl-0007p0-6n; Mon, 19 Aug 2019 17:38:25 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     t.schluessler@krause.de, shc_work@mail.ru,
        Sean Nyekjaer <sean@geanix.com>,
        Phil Elwell <phil@raspberrypi.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 8/9] can: mcp251x: Use DT-supplied interrupt flags
Date:   Mon, 19 Aug 2019 17:38:17 +0200
Message-Id: <20190819153818.29293-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190819153818.29293-1-mkl@pengutronix.de>
References: <20190819153818.29293-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Phil Elwell <phil@raspberrypi.org>

The MCP2515 datasheet clearly describes a level-triggered interrupt pin.
Therefore the receiving interrupt controller must also be configured for
level-triggered operation otherwise there is a danger of a missed
interrupt condition blocking all subsequent interrupts. The ONESHOT
flag ensures that the interrupt is masked until the threaded interrupt
handler exits.

Rather than change the flags globally (they must have worked for at
least one user), keep the old behavior for for non DT devices. DT based
devices specify the flags in their corresonding DT node.

See: https://github.com/raspberrypi/linux/issues/2175
     https://github.com/raspberrypi/linux/issues/2263

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 19756fb3921a..0cdb88a9525f 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -923,7 +923,7 @@ static int mcp251x_open(struct net_device *net)
 {
 	struct mcp251x_priv *priv = netdev_priv(net);
 	struct spi_device *spi = priv->spi;
-	unsigned long flags = IRQF_ONESHOT | IRQF_TRIGGER_FALLING;
+	unsigned long flags = 0;
 	int ret;
 
 	ret = open_candev(net);
@@ -939,6 +939,9 @@ static int mcp251x_open(struct net_device *net)
 	priv->tx_skb = NULL;
 	priv->tx_len = 0;
 
+	if (!spi->dev.of_node)
+		flags = IRQF_TRIGGER_FALLING;
+
 	ret = request_threaded_irq(spi->irq, NULL, mcp251x_can_ist,
 				   flags | IRQF_ONESHOT, dev_name(&spi->dev),
 				   priv);
-- 
2.23.0.rc1

