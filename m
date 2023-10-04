Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B963D7B7BB4
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 11:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242003AbjJDJR7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 05:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjJDJR4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 05:17:56 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576C7BB
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 02:17:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny0t-0004B8-Re
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:17:51 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny0t-00Azgg-7N
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:17:51 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id E6D4B22EAF0
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 09:17:50 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 3C10922EAE1;
        Wed,  4 Oct 2023 09:17:50 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 812c3ba1;
        Wed, 4 Oct 2023 09:17:49 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Wed, 04 Oct 2023 11:17:31 +0200
Subject: [PATCH 4/5] can: dev: can_restart(): update debug and error
 messages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-can-dev-fix-can-restart-v1-4-2e52899eaaf5@pengutronix.de>
References: <20231004-can-dev-fix-can-restart-v1-0-2e52899eaaf5@pengutronix.de>
In-Reply-To: <20231004-can-dev-fix-can-restart-v1-0-2e52899eaaf5@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1087; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=jWigydfkKtpmvPtSd0HtGckkaFXomg0ieiYjoGOORBw=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHS24gV23xjV5wfuNXR+SqIoojpkkqKI8IMUUb
 W1J22hjYumJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR0tuAAKCRC+UBxKKooE
 6E5CCACTaaL8pkhesdjGMMBWjj5AoV40isyx2+gMX7byzu5jUnn4AmKROy0sXEg8odp3c4fI3oV
 CwvnX1uPx5PJmqJEL++ALn3nceELBcmeB5UN8oGkujxiM+Pld694cJ8trqCV64gRS19r5aGiZLA
 sw/bae5dIkEuirvKlT+nt/TC6cWor9FP7i1c8ElXUkojxJCdPZJiC5/wXUEKO4WtI0g+hzhmqPr
 WHPw2QmuCfK3BXdHMLgKGzlb/gIsAEOy3rCf//DFDJ+07Nt3XGHdOeyzJSkEyt58Bp+qUVJmVnp
 7VuvBG06fKHLyRzC2xHDAZcNqT8pEsSVPBWkFYiLW369xrSG
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

Update the debug message from "restarted" to "Attempting restart", as
it is actually printed _before_ restarting the CAN device, and that
restart may fail.

Also update the error message from printing the error number to
printing symbolic error names.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 9014256c486a..8e4054e2abcc 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -147,14 +147,14 @@ static void can_restart(struct net_device *dev)
 		netif_rx(skb);
 	}
 
-	netdev_dbg(dev, "restarted\n");
+	netdev_dbg(dev, "Attempting restart\n");
 	priv->can_stats.restarts++;
 
 	/* Now restart the device */
 	netif_carrier_on(dev);
 	err = priv->do_set_mode(dev, CAN_MODE_START);
 	if (err) {
-		netdev_err(dev, "Error %d during restart", err);
+		netdev_err(dev, "Restart failed, error %pe\n", ERR_PTR(err));
 		netif_carrier_off(dev);
 	}
 }

-- 
2.40.1


