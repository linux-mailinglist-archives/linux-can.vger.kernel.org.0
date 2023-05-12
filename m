Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3A2701123
	for <lists+linux-can@lfdr.de>; Fri, 12 May 2023 23:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240317AbjELV2E (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 12 May 2023 17:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbjELV16 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 12 May 2023 17:27:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA1E30D3
        for <linux-can@vger.kernel.org>; Fri, 12 May 2023 14:27:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxaIW-0005HR-W1; Fri, 12 May 2023 23:27:33 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxaIV-0033Vp-87; Fri, 12 May 2023 23:27:31 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxaIU-003qha-HB; Fri, 12 May 2023 23:27:30 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 01/19] can: at91_can: Convert to platform remove callback returning void
Date:   Fri, 12 May 2023 23:27:07 +0200
Message-Id: <20230512212725.143824-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512212725.143824-1-u.kleine-koenig@pengutronix.de>
References: <20230512212725.143824-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1884; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Xo6ZZ0/yRkp7AJ6Vfos/ivbzgeR3hs6pPmGGMdrpj/s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkXq8kJHbaUAtyktL3uvTRJWFcVO88r/ofmS9LM SH43XKJA6mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZF6vJAAKCRCPgPtYfRL+ TgPhB/0TMXNQ7FCn4GuJMQQ58qLzmMQ7P/ALQKdWXabH1BNK3gtEzpSVj0IjOartXCejQHxlyU/ s2T2Ufn3Je1i/4y6z1TBu4RoVcGDRM72T2ZDGTuVtiNEZOQjILU+31eJavlqDfK+J7vQiy+oYkG 1UC8YcMP4f8LjxU4O5Wu+UwTWf5WnYs9/cggrmAo/docFhRC/ff4BoR+uejfSVjyfzK3/DfVyWq bA1NnqJZyAC2KIiHvbEW1Ui1LiblzwCqV99caWhawDn2uR3pfVZaCfxt6EdvJzb60OqbjFcA1py eCl75ZRp7iT+WoOZAh3pRLryxRAtn/BcfdvGR5AlEpLqqZsK
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
 drivers/net/can/at91_can.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 199cb200f2bd..4621266851ed 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -1346,7 +1346,7 @@ static int at91_can_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int at91_can_remove(struct platform_device *pdev)
+static void at91_can_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
 	struct at91_priv *priv = netdev_priv(dev);
@@ -1362,8 +1362,6 @@ static int at91_can_remove(struct platform_device *pdev)
 	clk_put(priv->clk);
 
 	free_candev(dev);
-
-	return 0;
 }
 
 static const struct platform_device_id at91_can_id_table[] = {
@@ -1381,7 +1379,7 @@ MODULE_DEVICE_TABLE(platform, at91_can_id_table);
 
 static struct platform_driver at91_can_driver = {
 	.probe = at91_can_probe,
-	.remove = at91_can_remove,
+	.remove_new = at91_can_remove,
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = of_match_ptr(at91_can_dt_ids),
-- 
2.39.2

