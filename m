Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BBA76E2B0
	for <lists+linux-can@lfdr.de>; Thu,  3 Aug 2023 10:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbjHCIQH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 3 Aug 2023 04:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjHCIPj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 3 Aug 2023 04:15:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567BF5FE8
        for <linux-can@vger.kernel.org>; Thu,  3 Aug 2023 01:08:37 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qRTNr-0000Sb-Ne
        for linux-can@vger.kernel.org; Thu, 03 Aug 2023 10:08:35 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 6B3E3202251
        for <linux-can@vger.kernel.org>; Thu,  3 Aug 2023 08:08:34 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id E6CF120222E;
        Thu,  3 Aug 2023 08:08:32 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a947b230;
        Thu, 3 Aug 2023 08:08:32 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Ruan Jinjie <ruanjinjie@huawei.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 1/9] can: flexcan: fix the return value handle for platform_get_irq()
Date:   Thu,  3 Aug 2023 10:08:22 +0200
Message-Id: <20230803080830.1386442-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230803080830.1386442-1-mkl@pengutronix.de>
References: <20230803080830.1386442-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Ruan Jinjie <ruanjinjie@huawei.com>

There is no possible for platform_get_irq() to return 0
and the return value of platform_get_irq() is more sensible
to show the error reason.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Link: https://lore.kernel.org/all/20230731075252.359965-1-ruanjinjie@huawei.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan/flexcan-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 48273d51f271..add39e922b89 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2089,8 +2089,8 @@ static int flexcan_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return -ENODEV;
+	if (irq < 0)
+		return irq;
 
 	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
@@ -2167,13 +2167,13 @@ static int flexcan_probe(struct platform_device *pdev)
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
 		priv->irq_boff = platform_get_irq(pdev, 1);
-		if (priv->irq_boff <= 0) {
-			err = -ENODEV;
+		if (priv->irq_boff < 0) {
+			err = priv->irq_boff;
 			goto failed_platform_get_irq;
 		}
 		priv->irq_err = platform_get_irq(pdev, 2);
-		if (priv->irq_err <= 0) {
-			err = -ENODEV;
+		if (priv->irq_err < 0) {
+			err = priv->irq_err;
 			goto failed_platform_get_irq;
 		}
 	}

base-commit: 2b3082c6ef3b0104d822f6f18d2afbe5fc9a5c2c
-- 
2.40.1


