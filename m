Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA216447061
	for <lists+linux-can@lfdr.de>; Sat,  6 Nov 2021 21:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbhKFUSS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 6 Nov 2021 16:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbhKFUSP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 6 Nov 2021 16:18:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15346C061570
        for <linux-can@vger.kernel.org>; Sat,  6 Nov 2021 13:15:33 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mjS67-0001SZ-HN
        for linux-can@vger.kernel.org; Sat, 06 Nov 2021 21:15:31 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 77F8E6A5F0C
        for <linux-can@vger.kernel.org>; Sat,  6 Nov 2021 20:15:30 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 8B2CE6A5F07;
        Sat,  6 Nov 2021 20:15:29 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id bb9c248b;
        Sat, 6 Nov 2021 20:15:27 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/2] can: mcp251xfd: mcp251xfd_irq(): add missing can_rx_offload_threaded_irq_finish() in case of bus off
Date:   Sat,  6 Nov 2021 21:15:25 +0100
Message-Id: <20211106201526.44292-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.33.0
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

Fixes: 30bfec4fec59 ("can: rx-offload: can_rx_offload_threaded_irq_finish(): add new function to be called from threaded interrupt")
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


