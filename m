Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A417B9F6A
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 16:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjJEOXr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 10:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjJEOWM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 10:22:12 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E87D7EC4
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 00:48:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ60-0000ZQ-0m
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:48:32 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ5z-00BDIn-Hz
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:48:31 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 44AFF22F75E
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 07:48:31 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 8330B22F74F;
        Thu,  5 Oct 2023 07:48:30 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 741f5778;
        Thu, 5 Oct 2023 07:48:29 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Thu, 05 Oct 2023 09:48:18 +0200
Subject: [PATCH v2 1/5] can: dev: can_restart(): don't crash kernel if
 carrier is OK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-can-dev-fix-can-restart-v2-1-91b5c1fd922c@pengutronix.de>
References: <20231005-can-dev-fix-can-restart-v2-0-91b5c1fd922c@pengutronix.de>
In-Reply-To: <20231005-can-dev-fix-can-restart-v2-0-91b5c1fd922c@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=HtEBMCFEoiUqSIy/quU3FUBjWZjQuuoZEXqdX2FYCNU=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHmpGoM26QVdhi1hqHE98DBim6jtBuGhM1eypD
 fqd6Q7FBaaJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR5qRgAKCRC+UBxKKooE
 6MpdB/9SNP6CBuchfu7MWTBVzQF/RqDhZUGd2pU8oiy23l/1YCPadnBlfho0ozxyUL3KuIyVhgj
 /LiA4UyNnxc4E9YoJn+uCK2+SQhhcbLObQ81PhIeoJweFttgzLwDbeI67xd/jTaXGVqObsCUyJD
 mVoiYQ+oVWDZoNaVOsi7teN8A2UtYDRUIJOEEewcEWkmZNdmTv0nhQN8AP5a6D24eM1IjMhC0yw
 9NvhqDW+x98GJ8FDu8xTrrWCozpO+JKEef5c4bvcaWgy3vomnvxNuSfJcDLkgT7ADXL+WQz+QtD
 oEmfLuSnD0F/TYP0yvf2ILml99/JEBAkG/KegjwM6AjyLdF1
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


