Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56B6894895
	for <lists+linux-can@lfdr.de>; Mon, 19 Aug 2019 17:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfHSPiX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Aug 2019 11:38:23 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52321 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfHSPiX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Aug 2019 11:38:23 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1hzjji-0007p0-1A; Mon, 19 Aug 2019 17:38:22 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     t.schluessler@krause.de, shc_work@mail.ru,
        Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/9] can: mcp251x: remove unnecessary blank lines
Date:   Mon, 19 Aug 2019 17:38:11 +0200
Message-Id: <20190819153818.29293-3-mkl@pengutronix.de>
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

This patch removes unnecessary blank lines, so that checkpatch doesn't
complain anymore.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index e59b10525f46..3ec0907a0ee7 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -74,7 +74,6 @@
 #define RTS_TXB2		0x04
 #define INSTRUCTION_RTS(n)	(0x80 | ((n) & 0x07))
 
-
 /* MPC251x registers */
 #define CANSTAT	      0x0e
 #define CANCTRL	      0x0f
@@ -907,7 +906,6 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
 			}
 			netif_wake_queue(net);
 		}
-
 	}
 	mutex_unlock(&priv->mcp_lock);
 	return IRQ_HANDLED;
-- 
2.23.0.rc1

