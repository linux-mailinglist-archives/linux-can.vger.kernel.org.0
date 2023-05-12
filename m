Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A9470111B
	for <lists+linux-can@lfdr.de>; Fri, 12 May 2023 23:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239726AbjELV2A (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 12 May 2023 17:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239832AbjELV1x (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 12 May 2023 17:27:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B3593D2
        for <linux-can@vger.kernel.org>; Fri, 12 May 2023 14:27:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxaIY-0005Hy-Ks; Fri, 12 May 2023 23:27:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxaIX-0033WQ-7A; Fri, 12 May 2023 23:27:33 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxaIV-003qhv-P9; Fri, 12 May 2023 23:27:31 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Haibo Chen <haibo.chen@nxp.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 07/19] can: flexcan: Convert to platform remove callback returning void
Date:   Fri, 12 May 2023 23:27:13 +0200
Message-Id: <20230512212725.143824-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512212725.143824-1-u.kleine-koenig@pengutronix.de>
References: <20230512212725.143824-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1871; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=MQT4kJ36UuW3mYkSNpHCsyc32oG7M5CoiQlCXxD1Csc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkXq8rWZApo1/ouTqq7LPTYnlktUGSUwAdMWisf xK4lAmlwbmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZF6vKwAKCRCPgPtYfRL+ TpsQB/4vpxatO4H95MvczZkpPyMF1uCFyWRjReU/svcHd72tFs/SemysTNiFyEZAmW2D4znd82S rtBn3ZG9XBmXlcTjRp/3W1wyyRYrBQGev4v0UdeODS2RAqnz7ibZ9/I/eJnpibDPSeSijfrS5MN d163M/J/AtiYBVyayZRzImzjlOvWlnCljJnKYb0pGq13IAwd3F1jTahEX4BUCEHuVL5pqBCv8Le nQSpMb702QjkFr0VKXb0N3PF8dUhu75xoi/zZhsr4nsyfeMxdTnWGEQ5KIiYUYds8OA3XzcnsSA fwZI+8YqHZ8mkCGs6CoxQOAouTeVlKv8/C6GxI/SB/lDxcKa
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
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
---
 drivers/net/can/flexcan/flexcan-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 6d638c93977b..ff0fc18baf13 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2218,7 +2218,7 @@ static int flexcan_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int flexcan_remove(struct platform_device *pdev)
+static void flexcan_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
 
@@ -2227,8 +2227,6 @@ static int flexcan_remove(struct platform_device *pdev)
 	unregister_flexcandev(dev);
 	pm_runtime_disable(&pdev->dev);
 	free_candev(dev);
-
-	return 0;
 }
 
 static int __maybe_unused flexcan_suspend(struct device *device)
@@ -2379,7 +2377,7 @@ static struct platform_driver flexcan_driver = {
 		.of_match_table = flexcan_of_match,
 	},
 	.probe = flexcan_probe,
-	.remove = flexcan_remove,
+	.remove_new = flexcan_remove,
 	.id_table = flexcan_id_table,
 };
 
-- 
2.39.2

