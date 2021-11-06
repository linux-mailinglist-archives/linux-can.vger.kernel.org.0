Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0327A4470CA
	for <lists+linux-can@lfdr.de>; Sat,  6 Nov 2021 22:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbhKFV5s (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 6 Nov 2021 17:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbhKFV5p (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 6 Nov 2021 17:57:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A2CC06120C
        for <linux-can@vger.kernel.org>; Sat,  6 Nov 2021 14:55:03 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mjTeQ-0000wp-8R
        for linux-can@vger.kernel.org; Sat, 06 Nov 2021 22:55:02 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 11AFA6A5F9F
        for <linux-can@vger.kernel.org>; Sat,  6 Nov 2021 21:55:00 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id E177A6A5F86;
        Sat,  6 Nov 2021 21:54:58 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5993089c;
        Sat, 6 Nov 2021 21:54:50 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        stable@vger.kernel.org
Subject: [PATCH net 7/8] can: mcp251xfd: mcp251xfd_irq(): add missing can_rx_offload_threaded_irq_finish() in case of bus off
Date:   Sat,  6 Nov 2021 22:54:48 +0100
Message-Id: <20211106215449.57946-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211106215449.57946-1-mkl@pengutronix.de>
References: <20211106215449.57946-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The function can_rx_offload_threaded_irq_finish() is needed to trigger
the NAPI thread to deliver read CAN frames to the networking stack.

This patch adds the missing call to can_rx_offload_threaded_irq_finish()
in case of a bus off, before leaving the interrupt handler to avoid
packet starvation.

Link: https://lore.kernel.org/all/20211106201526.44292-1-mkl@pengutronix.de
Fixes: 30bfec4fec59 ("can: rx-offload: can_rx_offload_threaded_irq_finish(): add new function to be called from threaded interrupt")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 673861ab665a..212fcd1554e4 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -2290,8 +2290,10 @@ static irqreturn_t mcp251xfd_irq(int irq, void *dev_id)
 			 * check will fail, too. So leave IRQ handler
 			 * directly.
 			 */
-			if (priv->can.state == CAN_STATE_BUS_OFF)
+			if (priv->can.state == CAN_STATE_BUS_OFF) {
+				can_rx_offload_threaded_irq_finish(&priv->offload);
 				return IRQ_HANDLED;
+			}
 		}
 
 		handled = IRQ_HANDLED;
-- 
2.33.0


