Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA08560DC93
	for <lists+linux-can@lfdr.de>; Wed, 26 Oct 2022 09:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiJZHza (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Oct 2022 03:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbiJZHz2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Oct 2022 03:55:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F2A13D1F
        for <linux-can@vger.kernel.org>; Wed, 26 Oct 2022 00:55:27 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1onbG1-0000aV-Tn
        for linux-can@vger.kernel.org; Wed, 26 Oct 2022 09:55:25 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 656DF109FEB
        for <linux-can@vger.kernel.org>; Wed, 26 Oct 2022 07:55:25 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id B66B1109FDA;
        Wed, 26 Oct 2022 07:55:23 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2ce55021;
        Wed, 26 Oct 2022 07:55:22 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Dongliang Mu <dzm91@hust.edu.cn>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 2/2] can: mcp251x: mcp251x_can_probe(): add missing unregister_candev() in error path
Date:   Wed, 26 Oct 2022 09:55:20 +0200
Message-Id: <20221026075520.1502520-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221026075520.1502520-1-mkl@pengutronix.de>
References: <20221026075520.1502520-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Dongliang Mu <dzm91@hust.edu.cn>

In mcp251x_can_probe(), if mcp251x_gpio_setup() fails, it forgets to
unregister the CAN device.

Fix this by unregistering can device in mcp251x_can_probe().

Fixes: 2d52dabbef60 ("can: mcp251x: add GPIO support")
Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
Link: https://lore.kernel.org/all/20221024090256.717236-1-dzm91@hust.edu.cn
[mkl: adjust label]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index c320de474f40..24883a65ca66 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1415,11 +1415,14 @@ static int mcp251x_can_probe(struct spi_device *spi)
 
 	ret = mcp251x_gpio_setup(priv);
 	if (ret)
-		goto error_probe;
+		goto out_unregister_candev;
 
 	netdev_info(net, "MCP%x successfully initialized.\n", priv->model);
 	return 0;
 
+out_unregister_candev:
+	unregister_candev(net);
+
 error_probe:
 	destroy_workqueue(priv->wq);
 	priv->wq = NULL;
-- 
2.35.1


