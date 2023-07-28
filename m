Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF2D7665FF
	for <lists+linux-can@lfdr.de>; Fri, 28 Jul 2023 09:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbjG1H71 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 28 Jul 2023 03:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbjG1H7E (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 28 Jul 2023 03:59:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0207A449B
        for <linux-can@vger.kernel.org>; Fri, 28 Jul 2023 00:58:34 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qPIMq-0008Ej-BI
        for linux-can@vger.kernel.org; Fri, 28 Jul 2023 09:58:32 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 5A6BE1FD291
        for <linux-can@vger.kernel.org>; Fri, 28 Jul 2023 07:56:21 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 4AA441FD1F3;
        Fri, 28 Jul 2023 07:56:19 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 22583a0d;
        Fri, 28 Jul 2023 07:56:17 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 16/21] can: gs_usb: gs_can_close(): don't complain about failed device reset during ndo_stop
Date:   Fri, 28 Jul 2023 09:56:09 +0200
Message-Id: <20230728075614.1014117-17-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728075614.1014117-1-mkl@pengutronix.de>
References: <20230728075614.1014117-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
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

When the USB device is unplugged, gs_can_close() (which implements the
struct net_device_ops::ndo_stop callback) is called. In this function
an attempt is made to shut down the USB device with a USB control
message. For disconnected devices this will fail and a warning message
is printed.

Silence the driver by removing the printout of the error message if
the reset command fails.

Link: https://lore.kernel.org/all/20230718-gs_usb-cleanups-v1-9-c3b9154ec605@pengutronix.de
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


