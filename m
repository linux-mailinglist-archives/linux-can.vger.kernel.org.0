Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8D8F05AB
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2019 20:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390927AbfKETIq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 5 Nov 2019 14:08:46 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37381 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390926AbfKETIp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Nov 2019 14:08:45 -0500
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iS4C3-0001dw-Ef; Tue, 05 Nov 2019 20:08:43 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     =?UTF-8?q?Timo=20Schl=C3=BC=C3=9Fler?= <schluessler@krause.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v4 1/4] can: mcp251x: mcp251x_restart_work_handler(): Fix potential force_quit race condition
Date:   Tue,  5 Nov 2019 20:08:37 +0100
Message-Id: <20191105190840.20410-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191105190840.20410-1-mkl@pengutronix.de>
References: <20191105190840.20410-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Timo Schlüßler <schluessler@krause.de>

In mcp251x_restart_work_handler() the variable to stop the interrupt
handler (priv->force_quit) is reset after the chip is restarted and thus
a interrupt might occur.

This patch fixes the potential race condition by resetting force_quit
before enabling interrupts.

Signed-off-by: Timo Schlüßler <schluessler@krause.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 12358f06d194..8f39a7b707c1 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -750,6 +750,7 @@ static void mcp251x_restart_work_handler(struct work_struct *ws)
 	if (priv->after_suspend) {
 		mcp251x_hw_reset(spi);
 		mcp251x_setup(net, spi);
+		priv->force_quit = 0;
 		if (priv->after_suspend & AFTER_SUSPEND_RESTART) {
 			mcp251x_set_normal_mode(spi);
 		} else if (priv->after_suspend & AFTER_SUSPEND_UP) {
@@ -761,7 +762,6 @@ static void mcp251x_restart_work_handler(struct work_struct *ws)
 			mcp251x_hw_sleep(spi);
 		}
 		priv->after_suspend = 0;
-		priv->force_quit = 0;
 	}
 
 	if (priv->restart_tx) {
-- 
2.24.0.rc1

