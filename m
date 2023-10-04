Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7837B7BB1
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 11:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242153AbjJDJR5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 05:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241879AbjJDJR4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 05:17:56 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E45AD
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 02:17:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny0t-0004AZ-Fo
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:17:51 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny0s-00AzgJ-UF
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:17:50 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id A283422EAEB
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 09:17:50 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id E545522EADC;
        Wed,  4 Oct 2023 09:17:49 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d5334575;
        Wed, 4 Oct 2023 09:17:49 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Wed, 04 Oct 2023 11:17:28 +0200
Subject: [PATCH 1/5] can: dev: can_restart(): don't crash kernel if carrier
 is OK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-can-dev-fix-can-restart-v1-1-2e52899eaaf5@pengutronix.de>
References: <20231004-can-dev-fix-can-restart-v1-0-2e52899eaaf5@pengutronix.de>
In-Reply-To: <20231004-can-dev-fix-can-restart-v1-0-2e52899eaaf5@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=HtEBMCFEoiUqSIy/quU3FUBjWZjQuuoZEXqdX2FYCNU=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHS2w7zcS+mdFhdDyO2wAUisUX+H8k1jntTHnt
 qTt1gWBHbKJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR0tsAAKCRC+UBxKKooE
 6CXYB/9P40OhOxNmSPfgc2aIxC1nkQmssOZVfHfBQx0gKl0bYE4h8HjZ2nbSFj1BWW+K1pOEDJn
 RRS6Ekn4mX5+l6vDBHpxcTvc3zuf6S4c3jCLW5t0PKIl0sXzxReoYPewDFBX0H38/fb3WDFxXig
 AljCFPmSEYhrg5afiCyGwSR2HUISWfTDSZjvMWQtteFVE/Lt35LUIcoGR7yOOfBV+K4nI+IYOIf
 eGU+aAPWjesZT/deFJU+e/DcM9dk4TgYHhmU8dSclf71Mr62LY447CLZW9U3aYqksCv6DaN5k5x
 gwuo6UT2fU2aT0WIsOiypVGrL2J17dzoZVw8JC8b8AAfqL+L
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

During testing, I triggered a can_restart() with the netif carrier
being OK [1]. The BUG_ON, which checks if the carrier is OK, results
in a fatal kernel crash. This is neither helpful for debugging nor for
a production system.

[1] The root cause is a race condition in can_restart() which will be
fixed in the next patch.

Do not crash the kernel, issue an error message instead, and continue
restarting the CAN device anyway.

Fixes: 39549eef3587 ("can: CAN Network device driver and Netlink interface")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 7f9334a8af50..a5bbdfa9a269 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -132,7 +132,8 @@ static void can_restart(struct net_device *dev)
 	struct can_frame *cf;
 	int err;
 
-	BUG_ON(netif_carrier_ok(dev));
+	if (netif_carrier_ok(dev))
+		netdev_err(dev, "Attempt to restart for bus-off recovery, but carrier is OK?\n");
 
 	/* No synchronization needed because the device is bus-off and
 	 * no messages can come in or go out.

-- 
2.40.1


