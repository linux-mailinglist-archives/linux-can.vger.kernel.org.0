Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCCFECF453
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2019 09:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbfJHHwc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Oct 2019 03:52:32 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35207 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730177AbfJHHwc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Oct 2019 03:52:32 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iHkII-0005p5-Lw; Tue, 08 Oct 2019 09:52:30 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        Joe Burmeister <joe.burmeister@devtank.co.uk>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 3/4] can: c_can: register_c_can_dev(): convert to goto style error handling
Date:   Tue,  8 Oct 2019 09:52:25 +0200
Message-Id: <20191008075226.12544-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191008075226.12544-1-mkl@pengutronix.de>
References: <20191008075226.12544-1-mkl@pengutronix.de>
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

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 606b7d8ffe13..537a2f1febdf 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -1294,9 +1294,14 @@ int register_c_can_dev(struct net_device *dev)
 
 	err = register_candev(dev);
 	if (err)
-		c_can_pm_runtime_disable(priv);
-	else
-		devm_can_led_init(dev);
+		goto register_exit_runtime_disable;
+
+	devm_can_led_init(dev);
+
+	return 0;
+
+ register_exit_runtime_disable:
+	c_can_pm_runtime_disable(priv);
 
 	return err;
 }
-- 
2.23.0

