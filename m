Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB02703F0F
	for <lists+linux-can@lfdr.de>; Mon, 15 May 2023 22:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244765AbjEOU6t (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 15 May 2023 16:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245224AbjEOU6o (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 15 May 2023 16:58:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2579A27C
        for <linux-can@vger.kernel.org>; Mon, 15 May 2023 13:58:29 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pyfGl-0006n9-Eh
        for linux-can@vger.kernel.org; Mon, 15 May 2023 22:58:11 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 106981C5D33
        for <linux-can@vger.kernel.org>; Mon, 15 May 2023 20:58:06 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 6EF841C5CCD;
        Mon, 15 May 2023 20:58:03 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id bc0407f1;
        Mon, 15 May 2023 20:58:02 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pavel Pisa <pisa@cmp.felk.cvut.cz>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 09/22] can: ctucanfd: Convert to platform remove callback returning void
Date:   Mon, 15 May 2023 22:57:46 +0200
Message-Id: <20230515205759.1003118-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515205759.1003118-1-mkl@pengutronix.de>
References: <20230515205759.1003118-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart from
emitting a warning) and this typically results in resource leaks. To improve
here there is a quest to make the remove callback return void. In the first
step of this quest all drivers are converted to .remove_new() which already
returns void. Eventually after all drivers are converted, .remove_new() is
renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Link: https://lore.kernel.org/r/20230512212725.143824-7-u.kleine-koenig@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/ctucanfd/ctucanfd_platform.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_platform.c b/drivers/net/can/ctucanfd/ctucanfd_platform.c
index a17561d97192..55bb10b157b4 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_platform.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_platform.c
@@ -86,7 +86,7 @@ static int ctucan_platform_probe(struct platform_device *pdev)
  * This function frees all the resources allocated to the device.
  * Return: 0 always
  */
-static int ctucan_platform_remove(struct platform_device *pdev)
+static void ctucan_platform_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct ctucan_priv *priv = netdev_priv(ndev);
@@ -97,8 +97,6 @@ static int ctucan_platform_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	netif_napi_del(&priv->napi);
 	free_candev(ndev);
-
-	return 0;
 }
 
 static SIMPLE_DEV_PM_OPS(ctucan_platform_pm_ops, ctucan_suspend, ctucan_resume);
@@ -113,7 +111,7 @@ MODULE_DEVICE_TABLE(of, ctucan_of_match);
 
 static struct platform_driver ctucanfd_driver = {
 	.probe	= ctucan_platform_probe,
-	.remove	= ctucan_platform_remove,
+	.remove_new = ctucan_platform_remove,
 	.driver	= {
 		.name = DRV_NAME,
 		.pm = &ctucan_platform_pm_ops,
-- 
2.39.2


