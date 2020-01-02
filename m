Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C50D12E877
	for <lists+linux-can@lfdr.de>; Thu,  2 Jan 2020 17:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgABQJo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Jan 2020 11:09:44 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35763 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbgABQJn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Jan 2020 11:09:43 -0500
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1in32Y-0000mM-7m; Thu, 02 Jan 2020 17:09:38 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4/9] can: tcan4x5x: tcan4x5x_parse_config(): Disable the INH pin device-state GPIO is unavailable
Date:   Thu,  2 Jan 2020 17:09:29 +0100
Message-Id: <20200102160934.1524-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102160934.1524-1-mkl@pengutronix.de>
References: <20200102160934.1524-1-mkl@pengutronix.de>
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

From: Dan Murphy <dmurphy@ti.com>

If the device state GPIO is not connected to the host then disable the
INH output from the TCAN device per section 8.3.5 of the data sheet.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index ee22e39f131b..a413e7548546 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -102,6 +102,7 @@
 #define TCAN4X5X_MODE_NORMAL BIT(7)
 
 #define TCAN4X5X_DISABLE_WAKE_MSK	(BIT(31) | BIT(30))
+#define TCAN4X5X_DISABLE_INH_MSK	BIT(9)
 
 #define TCAN4X5X_SW_RESET BIT(2)
 
@@ -370,6 +371,14 @@ static int tcan4x5x_disable_wake(struct m_can_classdev *cdev)
 				  TCAN4X5X_DISABLE_WAKE_MSK, 0x00);
 }
 
+static int tcan4x5x_disable_state(struct m_can_classdev *cdev)
+{
+	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
+
+	return regmap_update_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
+				  TCAN4X5X_DISABLE_INH_MSK, 0x01);
+}
+
 static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 {
 	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
@@ -396,8 +405,10 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 	tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
 							      "device-state",
 							      GPIOD_IN);
-	if (IS_ERR(tcan4x5x->device_state_gpio))
+	if (IS_ERR(tcan4x5x->device_state_gpio)) {
 		tcan4x5x->device_state_gpio = NULL;
+		tcan4x5x_disable_state(cdev);
+	}
 
 	return 0;
 }
-- 
2.24.1

