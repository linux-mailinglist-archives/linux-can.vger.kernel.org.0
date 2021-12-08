Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308A746D3B5
	for <lists+linux-can@lfdr.de>; Wed,  8 Dec 2021 13:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbhLHMym (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Dec 2021 07:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbhLHMyk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Dec 2021 07:54:40 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04B6C061A32
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 04:51:08 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1muwPb-0003K8-3F
        for linux-can@vger.kernel.org; Wed, 08 Dec 2021 13:51:07 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 3450B6BFC0B
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 12:51:02 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id E08316BFBD6;
        Wed,  8 Dec 2021 12:50:58 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a25c78f7;
        Wed, 8 Dec 2021 12:50:57 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 7/8] can: hi311x: hi3110_can_probe(): make use of device property API
Date:   Wed,  8 Dec 2021 13:50:54 +0100
Message-Id: <20211208125055.223141-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211208125055.223141-1-mkl@pengutronix.de>
References: <20211208125055.223141-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Make use of device property API in this driver so that both OF based
system and ACPI based system can use this driver.

Link: https://lore.kernel.org/all/20211206165542.69887-3-andriy.shevchenko@linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/hi311x.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index c9efdd10d0f8..78044ec24575 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -25,11 +25,11 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
@@ -828,11 +828,10 @@ MODULE_DEVICE_TABLE(spi, hi3110_id_table);
 
 static int hi3110_can_probe(struct spi_device *spi)
 {
-	const struct of_device_id *of_id = of_match_device(hi3110_of_match,
-							   &spi->dev);
 	struct device *dev = &spi->dev;
 	struct net_device *net;
 	struct hi3110_priv *priv;
+	const void *match;
 	struct clk *clk;
 	u32 freq;
 	int ret;
@@ -877,8 +876,9 @@ static int hi3110_can_probe(struct spi_device *spi)
 		CAN_CTRLMODE_LISTENONLY |
 		CAN_CTRLMODE_BERR_REPORTING;
 
-	if (of_id)
-		priv->model = (enum hi3110_model)(uintptr_t)of_id->data;
+	match = device_get_match_data(dev);
+	if (match)
+		priv->model = (enum hi3110_model)(uintptr_t)match;
 	else
 		priv->model = spi_get_device_id(spi)->driver_data;
 	priv->net = net;
-- 
2.33.0


