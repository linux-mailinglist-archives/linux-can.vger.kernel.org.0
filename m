Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A698637312A
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 22:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhEDUGV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 16:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbhEDUGV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 16:06:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8207C06174A
        for <linux-can@vger.kernel.org>; Tue,  4 May 2021 13:05:25 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1le1IK-00022L-Eq
        for linux-can@vger.kernel.org; Tue, 04 May 2021 22:05:24 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id E366D61BF97
        for <linux-can@vger.kernel.org>; Tue,  4 May 2021 20:05:22 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 593B661BF8E;
        Tue,  4 May 2021 20:05:22 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 0a6ecc2c;
        Tue, 4 May 2021 20:05:21 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        kernel test robot <lkp@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [can-nextc 1/2] can: mcp251x: mcp251x_can_probe(): silence clang warning
Date:   Tue,  4 May 2021 22:05:19 +0200
Message-Id: <20210504200520.1179635-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504200520.1179635-1-mkl@pengutronix.de>
References: <20210504200520.1179635-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch silences the following clang warning:

| drivers/net/can/spi/mcp251x.c:1333:17: warning: cast to smaller integer type
| 'enum mcp251x_model' from 'const void *' [-Wvoid-pointer-to-enum-cast]
|                 priv->model = (enum mcp251x_model)match;
|                               ^~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 8de29a5c34a5 ("can: mcp251x: Make use of device property API")
Reported-by: kernel test robot <lkp@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 492f1bcb0516..275b2ddab143 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1343,7 +1343,7 @@ static int mcp251x_can_probe(struct spi_device *spi)
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES |
 		CAN_CTRLMODE_LOOPBACK | CAN_CTRLMODE_LISTENONLY;
 	if (match)
-		priv->model = (enum mcp251x_model)match;
+		priv->model = (enum mcp251x_model)(kernel_ulong_t)match;
 	else
 		priv->model = spi_get_device_id(spi)->driver_data;
 	priv->net = net;

base-commit: 9d31d2338950293ec19d9b095fbaa9030899dcb4
prerequisite-patch-id: 2d99a92f9c04a76341ba84b5f4924c2ba03bdd88
prerequisite-patch-id: 6dbb40c8b889604bf57aa2374f34290b247b7d28
prerequisite-patch-id: 24ff9c746552e4a8e100200f13bb1732990392a3
-- 
2.30.2


