Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90765274493
	for <lists+linux-can@lfdr.de>; Tue, 22 Sep 2020 16:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgIVOoq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Sep 2020 10:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbgIVOon (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Sep 2020 10:44:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B84C0613D0
        for <linux-can@vger.kernel.org>; Tue, 22 Sep 2020 07:44:42 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kKjX6-0001FU-GQ; Tue, 22 Sep 2020 16:44:40 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, michael@walle.cc, qiangqing.zhang@nxp.com,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 19/20] can: flexcan: add imx8qm support
Date:   Tue, 22 Sep 2020 16:44:28 +0200
Message-Id: <20200922144429.2613631-20-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922144429.2613631-1-mkl@pengutronix.de>
References: <20200922144429.2613631-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Joakim Zhang <qiangqing.zhang@nxp.com>

The Flexcan on i.MX8QM supports CAN FD protocol.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Link: https://lore.kernel.org/r/20190712075926.7357-8-qiangqing.zhang@nxp.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index fc98b5d521f2..5f778c961a0c 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -206,15 +206,16 @@
 /* FLEXCAN hardware feature flags
  *
  * Below is some version info we got:
- *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT IRQ Err Memory err RTR re-
- *                                Filter? connected?  Passive detection  ception in MB
- *   MX25  FlexCAN2  03.00.00.00     no        no        no       no        no
- *   MX28  FlexCAN2  03.00.04.00    yes       yes        no       no        no
- *   MX35  FlexCAN2  03.00.00.00     no        no        no       no        no
- *   MX53  FlexCAN2  03.00.00.00    yes        no        no       no        no
- *   MX6s  FlexCAN3  10.00.12.00    yes       yes        no       no       yes
- *   VF610 FlexCAN3  ?               no       yes        no      yes       yes?
- * LS1021A FlexCAN2  03.00.04.00     no       yes        no       no       yes
+ *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT IRQ Err Memory err RTR rece-   FD Mode
+ *                                Filter? connected?  Passive detection  ption in MB Supported?
+ *   MX25  FlexCAN2  03.00.00.00     no        no        no       no        no           no
+ *   MX28  FlexCAN2  03.00.04.00    yes       yes        no       no        no           no
+ *   MX35  FlexCAN2  03.00.00.00     no        no        no       no        no           no
+ *   MX53  FlexCAN2  03.00.00.00    yes        no        no       no        no           no
+ *   MX6s  FlexCAN3  10.00.12.00    yes       yes        no       no       yes           no
+ *   MX8QM FlexCAN3  03.00.23.00    yes       yes        no       no       yes          yes
+ *   VF610 FlexCAN3  ?               no       yes        no      yes       yes?          no
+ * LS1021A FlexCAN2  03.00.04.00     no       yes        no       no       yes           no
  *
  * Some SOCs do not have the RX_WARN & TX_WARN interrupt line connected.
  */
@@ -368,6 +369,12 @@ static const struct flexcan_devtype_data fsl_imx6q_devtype_data = {
 		FLEXCAN_QUIRK_SETUP_STOP_MODE,
 };
 
+static const struct flexcan_devtype_data fsl_imx8qm_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_SUPPORT_FD,
+};
+
 static const struct flexcan_devtype_data fsl_vf610_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_OFF_TIMESTAMP |
@@ -1830,6 +1837,7 @@ static int flexcan_setup_stop_mode(struct platform_device *pdev)
 }
 
 static const struct of_device_id flexcan_of_match[] = {
+	{ .compatible = "fsl,imx8qm-flexcan", .data = &fsl_imx8qm_devtype_data, },
 	{ .compatible = "fsl,imx6q-flexcan", .data = &fsl_imx6q_devtype_data, },
 	{ .compatible = "fsl,imx28-flexcan", .data = &fsl_imx28_devtype_data, },
 	{ .compatible = "fsl,imx53-flexcan", .data = &fsl_imx25_devtype_data, },
-- 
2.28.0

