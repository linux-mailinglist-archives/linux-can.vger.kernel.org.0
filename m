Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4A6701114
	for <lists+linux-can@lfdr.de>; Fri, 12 May 2023 23:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240409AbjELV14 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 12 May 2023 17:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240169AbjELV1w (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 12 May 2023 17:27:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F4830DD
        for <linux-can@vger.kernel.org>; Fri, 12 May 2023 14:27:45 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxaIY-0005HT-If; Fri, 12 May 2023 23:27:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxaIV-0033W0-OS; Fri, 12 May 2023 23:27:31 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxaIU-003qhg-Td; Fri, 12 May 2023 23:27:30 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Minghao Chi <chi.minghao@zte.com.cn>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 03/19] can: c_can: Convert to platform remove callback returning void
Date:   Fri, 12 May 2023 23:27:09 +0200
Message-Id: <20230512212725.143824-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512212725.143824-1-u.kleine-koenig@pengutronix.de>
References: <20230512212725.143824-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1933; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=7Eoyxk/i89YjcMsvEOeKIS9afXLS/fEaygvTu2STqhs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkXq8nc4K6De1ioaDEl5zQul13pbeY2vrZLiNFj M6h7Z1wDBCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZF6vJwAKCRCPgPtYfRL+ TlWPB/4gZFPYfIqtkeTIhLJNZ7Szqr+wCtBktD+263zZnQpzBjq9iH19/kibc0ukQwAp7ns6xON xYyDV4QDZnNE5BQOGvmBxeCBctdNCUOUZfH6nauDlFoBtcNEDF3RBYsRRT5ZeuGplhT88SDnM8Z Dp5rTLSHfBKlEBORwXqEZvyavHkL0W8/TC/0I8Dp5kNJXGcYLiuqGb1JlppQR8br6wQ8taA/3my je2ZwWei2dmDK2REeCiswO+/eSXWlayWR2WbSUzWyMsKLgc3/s8yXPEi4gYwWsBOFThNgePhuBB 2WivxpzXUkNdBOsDK2Cktc+7edWOhyryh1ktGnaTpqb2TnBK
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
 drivers/net/can/c_can/c_can_platform.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 03ccb7cfacaf..925930b6c4ca 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -410,7 +410,7 @@ static int c_can_plat_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int c_can_plat_remove(struct platform_device *pdev)
+static void c_can_plat_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
 	struct c_can_priv *priv = netdev_priv(dev);
@@ -418,8 +418,6 @@ static int c_can_plat_remove(struct platform_device *pdev)
 	unregister_c_can_dev(dev);
 	pm_runtime_disable(priv->device);
 	free_c_can_dev(dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -487,7 +485,7 @@ static struct platform_driver c_can_plat_driver = {
 		.of_match_table = c_can_of_table,
 	},
 	.probe = c_can_plat_probe,
-	.remove = c_can_plat_remove,
+	.remove_new = c_can_plat_remove,
 	.suspend = c_can_suspend,
 	.resume = c_can_resume,
 	.id_table = c_can_id_table,
-- 
2.39.2

