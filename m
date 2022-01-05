Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E26A4854D5
	for <lists+linux-can@lfdr.de>; Wed,  5 Jan 2022 15:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiAEOoO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Jan 2022 09:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236305AbiAEOoN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Jan 2022 09:44:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3477C061761
        for <linux-can@vger.kernel.org>; Wed,  5 Jan 2022 06:44:12 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n57WN-0003ze-DY
        for linux-can@vger.kernel.org; Wed, 05 Jan 2022 15:44:11 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 0E9046D1ADF
        for <linux-can@vger.kernel.org>; Wed,  5 Jan 2022 14:44:07 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id CF8ED6D1ABC;
        Wed,  5 Jan 2022 14:44:04 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8121ef42;
        Wed, 5 Jan 2022 14:44:04 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 02/15] can: mcp251x: mcp251x_gpio_setup(): Get rid of duplicate of_node assignment
Date:   Wed,  5 Jan 2022 15:43:49 +0100
Message-Id: <20220105144402.1174191-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220105144402.1174191-1-mkl@pengutronix.de>
References: <20220105144402.1174191-1-mkl@pengutronix.de>
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

GPIO library does copy the of_node from the parent device of the GPIO
chip, there is no need to repeat this in the individual drivers.
Remove assignment here.

For the details one may look into the of_gpio_dev_init()
implementation.

Link: https://lore.kernel.org/all/20211202205855.76946-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251x.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 0579ab74f728..0cec808e8727 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -600,9 +600,6 @@ static int mcp251x_gpio_setup(struct mcp251x_priv *priv)
 	gpio->ngpio = ARRAY_SIZE(mcp251x_gpio_names);
 	gpio->names = mcp251x_gpio_names;
 	gpio->can_sleep = true;
-#ifdef CONFIG_OF_GPIO
-	gpio->of_node = priv->spi->dev.of_node;
-#endif
 
 	return devm_gpiochip_add_data(&priv->spi->dev, gpio, priv);
 }
-- 
2.34.1


