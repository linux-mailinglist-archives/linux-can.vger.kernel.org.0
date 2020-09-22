Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61EE274481
	for <lists+linux-can@lfdr.de>; Tue, 22 Sep 2020 16:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgIVOog (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Sep 2020 10:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgIVOof (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Sep 2020 10:44:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE453C061755
        for <linux-can@vger.kernel.org>; Tue, 22 Sep 2020 07:44:35 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kKjWz-0001FU-Pi; Tue, 22 Sep 2020 16:44:33 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, michael@walle.cc, qiangqing.zhang@nxp.com,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 01/20] can: flexcan: sort include files alphabetically
Date:   Tue, 22 Sep 2020 16:44:10 +0200
Message-Id: <20200922144429.2613631-2-mkl@pengutronix.de>
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

This patch sorts the include files alphabetically.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 19403e88daa3..6198319d8fac 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -9,7 +9,6 @@
 //
 // Based on code originally by Andrey Volkov <avolkov@varma-el.com>
 
-#include <linux/netdevice.h>
 #include <linux/can.h>
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
@@ -21,12 +20,13 @@
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/netdevice.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-#include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 
 #define DRV_NAME			"flexcan"
 
-- 
2.28.0

