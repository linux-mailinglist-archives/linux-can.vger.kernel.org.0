Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB2C274490
	for <lists+linux-can@lfdr.de>; Tue, 22 Sep 2020 16:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgIVOop (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Sep 2020 10:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgIVOoh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Sep 2020 10:44:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FA4C061755
        for <linux-can@vger.kernel.org>; Tue, 22 Sep 2020 07:44:37 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kKjX1-0001FU-3x; Tue, 22 Sep 2020 16:44:35 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, michael@walle.cc, qiangqing.zhang@nxp.com,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 05/20] can: flexcan: quirks: get rid of long lines
Date:   Tue, 22 Sep 2020 16:44:14 +0200
Message-Id: <20200922144429.2613631-6-mkl@pengutronix.de>
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

This patch reformats the quirks to get rid of long lines.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 224000f53a88..b180dd1ba763 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -184,14 +184,23 @@
  *
  * Some SOCs do not have the RX_WARN & TX_WARN interrupt line connected.
  */
-#define FLEXCAN_QUIRK_BROKEN_WERR_STATE	BIT(1) /* [TR]WRN_INT not connected */
-#define FLEXCAN_QUIRK_DISABLE_RXFG	BIT(2) /* Disable RX FIFO Global mask */
-#define FLEXCAN_QUIRK_ENABLE_EACEN_RRS	BIT(3) /* Enable EACEN and RRS bit in ctrl2 */
-#define FLEXCAN_QUIRK_DISABLE_MECR	BIT(4) /* Disable Memory error detection */
-#define FLEXCAN_QUIRK_USE_OFF_TIMESTAMP	BIT(5) /* Use timestamp based offloading */
-#define FLEXCAN_QUIRK_BROKEN_PERR_STATE	BIT(6) /* No interrupt for error passive */
-#define FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN	BIT(7) /* default to BE register access */
-#define FLEXCAN_QUIRK_SETUP_STOP_MODE		BIT(8) /* Setup stop mode to support wakeup */
+
+/* [TR]WRN_INT not connected */
+#define FLEXCAN_QUIRK_BROKEN_WERR_STATE BIT(1)
+ /* Disable RX FIFO Global mask */
+#define FLEXCAN_QUIRK_DISABLE_RXFG BIT(2)
+/* Enable EACEN and RRS bit in ctrl2 */
+#define FLEXCAN_QUIRK_ENABLE_EACEN_RRS  BIT(3)
+/* Disable Memory error detection */
+#define FLEXCAN_QUIRK_DISABLE_MECR BIT(4)
+/* Use timestamp based offloading */
+#define FLEXCAN_QUIRK_USE_OFF_TIMESTAMP BIT(5)
+/* No interrupt for error passive */
+#define FLEXCAN_QUIRK_BROKEN_PERR_STATE BIT(6)
+/* default to BE register access */
+#define FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN BIT(7)
+/* Setup stop mode to support wakeup */
+#define FLEXCAN_QUIRK_SETUP_STOP_MODE BIT(8)
 
 /* Structure of the message buffer */
 struct flexcan_mb {
-- 
2.28.0

