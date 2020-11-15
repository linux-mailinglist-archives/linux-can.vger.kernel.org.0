Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE292B3751
	for <lists+linux-can@lfdr.de>; Sun, 15 Nov 2020 18:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgKORlu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 15 Nov 2020 12:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbgKORlt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 15 Nov 2020 12:41:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D4EC0613D2
        for <linux-can@vger.kernel.org>; Sun, 15 Nov 2020 09:41:49 -0800 (PST)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1keM24-0005uQ-Bd; Sun, 15 Nov 2020 18:41:44 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Faiz Abbas <faiz_abbas@ti.com>,
        Dan Murphy <dmurphy@ti.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net 15/15] can: m_can: m_can_stop(): set device to software init mode before closing
Date:   Sun, 15 Nov 2020 18:41:31 +0100
Message-Id: <20201115174131.2089251-16-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115174131.2089251-1-mkl@pengutronix.de>
References: <20201115174131.2089251-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Faiz Abbas <faiz_abbas@ti.com>

There might be some requests pending in the buffer when the interface close
sequence occurs. In some devices, these pending requests might lead to the
module not shutting down properly when m_can_clk_stop() is called.

Therefore, move the device to init state before potentially powering it down.

Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Acked-by: Dan Murphy <dmurphy@ti.com>
Link: https://lore.kernel.org/r/20200825055442.16994-1-faiz_abbas@ti.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 645101d19989..e7264043f79a 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1414,6 +1414,9 @@ static void m_can_stop(struct net_device *dev)
 	/* disable all interrupts */
 	m_can_disable_all_interrupts(cdev);
 
+	/* Set init mode to disengage from the network */
+	m_can_config_endisable(cdev, true);
+
 	/* set the state as STOPPED */
 	cdev->can.state = CAN_STATE_STOPPED;
 }
-- 
2.29.2

