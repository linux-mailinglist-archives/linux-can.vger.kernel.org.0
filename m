Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82FC39489B
	for <lists+linux-can@lfdr.de>; Mon, 19 Aug 2019 17:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfHSPi0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Aug 2019 11:38:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60007 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbfHSPi0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Aug 2019 11:38:26 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1hzjjj-0007p0-RK; Mon, 19 Aug 2019 17:38:23 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     t.schluessler@krause.de, shc_work@mail.ru,
        Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 7/9] can: mcp251x: Use dev_name() during request_threaded_irq()
Date:   Mon, 19 Aug 2019 17:38:16 +0200
Message-Id: <20190819153818.29293-8-mkl@pengutronix.de>
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

From: Alexander Shiyan <shc_work@mail.ru>

Passing driver name as name during request_threaded_irq() results in all
CAN IRQs have same name. This does not help much to easily identify which
IRQ belongs to which CAN instance. Therefore pass dev_name() during
request_threaded_irq() so that better identifiable name is listed for
CAN devices in cat /proc/interrupts output.

Output of cat /proc/interrupts
Before this patch:
  253:          2  gpio-mxc  13 Edge      mcp251x
  259:          2  gpio-mxc  19 Edge      mcp251x
After this patch:
  253:          2  gpio-mxc  13 Edge      spi1.1
  259:          2  gpio-mxc  19 Edge      spi1.2

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index db69c04bac2d..19756fb3921a 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -940,7 +940,8 @@ static int mcp251x_open(struct net_device *net)
 	priv->tx_len = 0;
 
 	ret = request_threaded_irq(spi->irq, NULL, mcp251x_can_ist,
-				   flags | IRQF_ONESHOT, DEVICE_NAME, priv);
+				   flags | IRQF_ONESHOT, dev_name(&spi->dev),
+				   priv);
 	if (ret) {
 		dev_err(&spi->dev, "failed to acquire irq %d\n", spi->irq);
 		mcp251x_power_enable(priv->transceiver, 0);
-- 
2.23.0.rc1

