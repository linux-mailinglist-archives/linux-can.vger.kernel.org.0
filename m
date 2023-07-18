Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D26C757A27
	for <lists+linux-can@lfdr.de>; Tue, 18 Jul 2023 13:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjGRLLi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Jul 2023 07:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjGRLLe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2023 07:11:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0271C1984
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 04:11:09 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLibj-0006ZZ-1Q
        for linux-can@vger.kernel.org; Tue, 18 Jul 2023 13:11:07 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 924491F40F0
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 11:11:05 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id C68BA1F40D9;
        Tue, 18 Jul 2023 11:11:04 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3bd37676;
        Tue, 18 Jul 2023 11:11:03 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Tue, 18 Jul 2023 13:10:31 +0200
Subject: [PATCH 09/11] cam: gs_usb: gs_can_close(): don't complain about
 failed device reset during ndo_stop
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-gs_usb-cleanups-v1-9-c3b9154ec605@pengutronix.de>
References: <20230718-gs_usb-cleanups-v1-0-c3b9154ec605@pengutronix.de>
In-Reply-To: <20230718-gs_usb-cleanups-v1-0-c3b9154ec605@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1094; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=ogSJ1CNFawZymit/cuTDEW7zFGdJaB0gC0CHr5xaLg8=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBktnM9yjoWZ8T63OYT58iRaiFgtuHd40VE2yIuh
 9Jd6P8PlQ6JATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZLZzPQAKCRC+UBxKKooE
 6MywB/9qlcdzN2gtukizePm4q9M8jw73p2I88ELxwHkvvpjjP/t6FYYBVW63KOO9iTDCudiGIZH
 07KggiXRVa82Ttc2tqYM/Y97LG3jQpILP8qcqsZgBvLCBzUgyYzSWaxcxzKo3pJJ2Ha8xbo/c1d
 W+IoTmEOgkrO9BYV0osjLOIL3AzOQ9FXQt4TLvbxcWcqsuUMZNOEPuCVEffGrA4w2a55P8cOLaK
 xsSFZKQnu/P/T/msxxJXJjf1KCS14lLvOHcAKBFCDImcLI8Mh7lRAO5ArISbeg8c+yVithpAppP
 WfnqAlE5uqPPJLxV3L047bCXrFLWfGdhtOEa9mEu9LLvTFas
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
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

When the USB device is unplugged, gs_can_close() (which implements the
struct net_device_ops::ndo_stop callback) is called. In this function
an attempt is made to shut down the USB device with a USB control
message. For disconnected devices this will fail and a warning message
is printed.

Silence the driver by removing the printout of the error message if
the reset command fails.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index a5cab6a07002..7718f6a4367e 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1029,9 +1029,7 @@ static int gs_can_close(struct net_device *netdev)
 	dev->can.state = CAN_STATE_STOPPED;
 
 	/* reset the device */
-	rc = gs_cmd_reset(dev);
-	if (rc < 0)
-		netdev_warn(netdev, "Couldn't shutdown device (err=%d)", rc);
+	gs_cmd_reset(dev);
 
 	/* reset tx contexts */
 	for (rc = 0; rc < GS_MAX_TX_URBS; rc++) {

-- 
2.40.1


