Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C79BDD417A
	for <lists+linux-can@lfdr.de>; Fri, 11 Oct 2019 15:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfJKNir (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 11 Oct 2019 09:38:47 -0400
Received: from mx.krause.de ([88.79.216.98]:37419 "EHLO mx.krause.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728034AbfJKNir (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 11 Oct 2019 09:38:47 -0400
Received: from [172.20.10.125] (port=46355 helo=mail.horstmanngroup.de)
        by mx.krause.de with esmtps (TLSv1:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <t.schluessler@krause.de>)
        id 1iIv7z-0002zV-04; Fri, 11 Oct 2019 15:38:43 +0200
Received: from HG-SRV-053.HG.local (172.20.10.125) by HG-SRV-053.HG.local
 (172.20.10.125) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 11 Oct
 2019 15:38:42 +0200
Received: from kb-ctp-power.localdomain (172.20.35.17) by HG-SRV-053.HG.local
 (172.20.10.125) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 11 Oct 2019 15:38:42 +0200
X-CTCH-RefID: str=0001.0A0C0201.5DA085E3.0013,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   =?UTF-8?q?Timo=20Schl=C3=BC=C3=9Fler?= <schluessler@krause.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, <linux-can@vger.kernel.org>
CC:     =?UTF-8?q?Timo=20Schl=C3=BC=C3=9Fler?= <schluessler@krause.de>
Subject: [PATCH v3 1/3] can: mcp251x: Correctly handle restart-ms
Date:   Fri, 11 Oct 2019 15:38:19 +0200
Message-ID: <1570801101-27864-1-git-send-email-schluessler@krause.de>
X-Mailer: git-send-email 2.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Always stop device when CAN_STATE_BUS_OFF is entered because the restart is
issued automatically through can.do_set_mode depending on restart-ms. Otherwise
the device re-enters CAN_STATE_ERROR_ACTIVE automatically after "128 occurences
of 11 consecutive recessive bits". Also fixes potential race condition by
resetting force_quit before enabling interrupts.

Signed-off-by: Timo Schlüßler <schluessler@krause.de>
---
 drivers/net/can/spi/mcp251x.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index f569fd4..6f359df 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -485,10 +485,10 @@ static int mcp251x_do_set_mode(struct net_device *net, enum can_mode mode)
 	case CAN_MODE_START:
 		mcp251x_clean(net);
 		/* We have to delay work since SPI I/O may sleep */
+		if (priv->can.state == CAN_STATE_BUS_OFF)
+			priv->after_suspend = AFTER_SUSPEND_RESTART;
 		priv->can.state = CAN_STATE_ERROR_ACTIVE;
 		priv->restart_tx = 1;
-		if (priv->can.restart_ms == 0)
-			priv->after_suspend = AFTER_SUSPEND_RESTART;
 		queue_work(priv->wq, &priv->restart_work);
 		break;
 	default:
@@ -716,6 +716,7 @@ static void mcp251x_restart_work_handler(struct work_struct *ws)
 	if (priv->after_suspend) {
 		mcp251x_hw_reset(spi);
 		mcp251x_setup(net, spi);
+		priv->force_quit = 0;
 		if (priv->after_suspend & AFTER_SUSPEND_RESTART) {
 			mcp251x_set_normal_mode(spi);
 		} else if (priv->after_suspend & AFTER_SUSPEND_UP) {
@@ -727,7 +728,6 @@ static void mcp251x_restart_work_handler(struct work_struct *ws)
 			mcp251x_hw_sleep(spi);
 		}
 		priv->after_suspend = 0;
-		priv->force_quit = 0;
 	}
 
 	if (priv->restart_tx) {
@@ -845,13 +845,11 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
 		}
 
 		if (priv->can.state == CAN_STATE_BUS_OFF) {
-			if (priv->can.restart_ms == 0) {
-				priv->force_quit = 1;
-				priv->can.can_stats.bus_off++;
-				can_bus_off(net);
-				mcp251x_hw_sleep(spi);
-				break;
-			}
+			priv->force_quit = 1;
+			priv->can.can_stats.bus_off++;
+			can_bus_off(net);
+			mcp251x_hw_sleep(spi);
+			break;
 		}
 
 		if (intf == 0)
-- 
2.7.2

