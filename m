Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC822B8FE9
	for <lists+linux-can@lfdr.de>; Thu, 19 Nov 2020 11:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgKSKJW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Nov 2020 05:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgKSKJV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Nov 2020 05:09:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FE9C061A48
        for <linux-can@vger.kernel.org>; Thu, 19 Nov 2020 02:09:21 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kfgsR-00063P-P7; Thu, 19 Nov 2020 11:09:19 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>, kernel@pengutronix.de,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next v2 5/5] can: flexcan: flexcan_close(): change order if commands to properly shut down the controller
Date:   Thu, 19 Nov 2020 11:09:17 +0100
Message-Id: <20201119100917.3013281-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119100917.3013281-1-mkl@pengutronix.de>
References: <20201119100917.3013281-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

There haven been reports, that the flexcan_close() soradically hangs during
simultanious ifdown, sending of CAN messages and probably open CAN bus:

| (__schedule) from [<808bbd34>] (schedule+0x90/0xb8)
| (schedule) from [<808bf274>] (schedule_timeout+0x1f8/0x24c)
| (schedule_timeout) from [<8016be44>] (msleep+0x18/0x1c)
| (msleep) from [<80746a64>] (napi_disable+0x60/0x70)
| (napi_disable) from [<8052fdd0>] (flexcan_close+0x2c/0x140)
| (flexcan_close) from [<80744930>] (__dev_close_many+0xb8/0xd8)
| (__dev_close_many) from [<8074db9c>] (__dev_change_flags+0xd0/0x1a0)
| (__dev_change_flags) from [<8074dc84>] (dev_change_flags+0x18/0x48)
| (dev_change_flags) from [<80760c24>] (do_setlink+0x44c/0x7b4)
| (do_setlink) from [<80761560>] (rtnl_newlink+0x374/0x68c)

I was unable to reproduce the issue, but a cleanup of the flexcan close
sequence has probably fixed the problem at the reporting user.

This patch changes the sequence in flexcan_close() to:
- stop the TX queue
- disable the interrupts on the chip level and wait via free_irq()
  synchronously for the interrupt handler to finish
- disable RX offload, which disables synchronously NAPI
- disable the flexcan on the chip level
- free RX offload
- disable the transceiver
- close the CAN device
- disable the clocks

Link: https://lore.kernel.org/r/20201119085251.2949181-6-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 0fb768dee99f..60808d048ef6 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1789,15 +1789,15 @@ static int flexcan_close(struct net_device *dev)
 	struct flexcan_priv *priv = netdev_priv(dev);
 
 	netif_stop_queue(dev);
+	flexcan_chip_interrupts_disable(dev);
+	free_irq(dev->irq, dev);
 	can_rx_offload_disable(&priv->offload);
 	flexcan_chip_stop_disable_on_error(dev);
-	flexcan_chip_interrupts_disable(dev);
 
 	can_rx_offload_del(&priv->offload);
-	free_irq(dev->irq, dev);
 	flexcan_transceiver_disable(priv);
-
 	close_candev(dev);
+
 	pm_runtime_put(priv->dev);
 
 	can_led_event(dev, CAN_LED_EVENT_STOP);
-- 
2.29.2

