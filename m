Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CFF701112
	for <lists+linux-can@lfdr.de>; Fri, 12 May 2023 23:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbjELV14 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 12 May 2023 17:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239726AbjELV1w (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 12 May 2023 17:27:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014CC49DB
        for <linux-can@vger.kernel.org>; Fri, 12 May 2023 14:27:45 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxaIY-0005Hv-3Z; Fri, 12 May 2023 23:27:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxaIX-0033WJ-1S; Fri, 12 May 2023 23:27:33 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxaIW-003qi3-92; Fri, 12 May 2023 23:27:32 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 09/19] can: ifi_canfd: Convert to platform remove callback returning void
Date:   Fri, 12 May 2023 23:27:15 +0200
Message-Id: <20230512212725.143824-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512212725.143824-1-u.kleine-koenig@pengutronix.de>
References: <20230512212725.143824-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=kdShLIQpUJrsSsIKPrtvNQgwPNAoOiS9nLTHDJhPnTM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkXq8upoPvTVZYzKtJf9L2erHNdM0HUJzHVPUtU NejiHyrnq2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZF6vLgAKCRCPgPtYfRL+ TuS/CACLR4yzN+fk+DljwH6JOQJbOw7RWp9MPvwzbN7EmfBS47lqX+mSl3d65B22NsLJDd6Q0Gy bKqaIRTLhqdjtCZYsj8FiUkJsUf5nFBFW8pYEHO2lZTAV49QGmlrp3D6f3TA/SGpL3jyWouYX4y 3r/LcdrnDXTXBdzwpmwCv3c4AMeJxMM6bqohva2oa810JgjbJRbLxjosaq8vLUJOWproXOFSYXf CP8Hd+DGvl8I3r4Bt35w/s0Fzdh0cS7ZIBOUR0rGP7YUywJUFidaMM/3WGwfk2IWCF5nEyoUpKk yeaoCeSq9g/gPpGoMzFE1856WzBqso5P2mueJeKzxKQoHMIm
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
 drivers/net/can/ifi_canfd/ifi_canfd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 07eaf724a572..1d6642c94f2f 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -1013,15 +1013,13 @@ static int ifi_canfd_plat_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ifi_canfd_plat_remove(struct platform_device *pdev)
+static void ifi_canfd_plat_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 
 	unregister_candev(ndev);
 	platform_set_drvdata(pdev, NULL);
 	free_candev(ndev);
-
-	return 0;
 }
 
 static const struct of_device_id ifi_canfd_of_table[] = {
@@ -1036,7 +1034,7 @@ static struct platform_driver ifi_canfd_plat_driver = {
 		.of_match_table	= ifi_canfd_of_table,
 	},
 	.probe	= ifi_canfd_plat_probe,
-	.remove	= ifi_canfd_plat_remove,
+	.remove_new = ifi_canfd_plat_remove,
 };
 
 module_platform_driver(ifi_canfd_plat_driver);
-- 
2.39.2

