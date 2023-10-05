Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1916B7BA4E2
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 18:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjJEQMx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 12:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240205AbjJEQLh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 12:11:37 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDC27EC6
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 00:48:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ60-0000Zn-8F
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:48:32 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ5z-00BDIy-MV
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:48:31 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 68D1F22F761
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 07:48:31 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id BC95F22F752;
        Thu,  5 Oct 2023 07:48:30 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 292e647c;
        Thu, 5 Oct 2023 07:48:29 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Thu, 05 Oct 2023 09:48:20 +0200
Subject: [PATCH v2 3/5] can: dev: can_restart(): reverse logic to remove
 need for goto
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-can-dev-fix-can-restart-v2-3-91b5c1fd922c@pengutronix.de>
References: <20231005-can-dev-fix-can-restart-v2-0-91b5c1fd922c@pengutronix.de>
In-Reply-To: <20231005-can-dev-fix-can-restart-v2-0-91b5c1fd922c@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=853; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=nGQEpiksyuJeEdUcRtLUNhXcIwJiVwCzGVceJl1lCn4=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHmpJi5G47d/wZUhu4SmzxJN65LzF4yuXfuFWR
 EgFKRCoNeyJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR5qSQAKCRC+UBxKKooE
 6HdKB/9xhV5WviFfOCj+RQMEmEAZiJO0g+ACOzW+1hDW+qcxrWDpxuLiUEDIPVjSbYDtes6DART
 QGh6YQhwx8/XMt/75axYRLQKFVUaJ5R6sXSm4EpCmNE0hVoLweQHxRn43FXnbGsYBoHwQ2RUbQ5
 LhFuER6LiRfOCu4jLIl/TJmT7yWQIpcz9Ywpzpxjt6aEvyuJc7EQ4D1ZuJJl456xm4eZPwBhUMD
 4Xeu6gWHCbPyecWJ+QVlpxtbL58XAqoXHlUo5aIY073kXrc7Bxdtrztc1mHFBAJZFwV5Weswqzs
 YBL0WnHYUFLxyqpAkc86Qjm4W21ZC21+dpoajf1+I/s+ucYC
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Reverse the logic in the if statement and eliminate the need for a
goto to simplify code readability.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 735d5de3caa0..9014256c486a 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -142,14 +142,11 @@ static void can_restart(struct net_device *dev)
 
 	/* send restart message upstream */
 	skb = alloc_can_err_skb(dev, &cf);
-	if (!skb)
-		goto restart;
+	if (skb) {
+		cf->can_id |= CAN_ERR_RESTARTED;
+		netif_rx(skb);
+	}
 
-	cf->can_id |= CAN_ERR_RESTARTED;
-
-	netif_rx(skb);
-
-restart:
 	netdev_dbg(dev, "restarted\n");
 	priv->can_stats.restarts++;
 

-- 
2.40.1


