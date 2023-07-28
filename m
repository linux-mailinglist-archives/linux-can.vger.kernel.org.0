Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12A97665FD
	for <lists+linux-can@lfdr.de>; Fri, 28 Jul 2023 09:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbjG1H7Z (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 28 Jul 2023 03:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbjG1H7D (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 28 Jul 2023 03:59:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3BD4490
        for <linux-can@vger.kernel.org>; Fri, 28 Jul 2023 00:58:33 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qPIMp-0008EQ-OB
        for linux-can@vger.kernel.org; Fri, 28 Jul 2023 09:58:31 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 54BB61FD28F
        for <linux-can@vger.kernel.org>; Fri, 28 Jul 2023 07:56:21 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 2B6D91FD1ED;
        Fri, 28 Jul 2023 07:56:19 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 91d2fa1b;
        Fri, 28 Jul 2023 07:56:17 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 15/21] can: gs_usb: gs_can_start_xmit(), gs_can_open(): clean up printouts in error path
Date:   Fri, 28 Jul 2023 09:56:08 +0200
Message-Id: <20230728075614.1014117-16-mkl@pengutronix.de>
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

Remove unnecessary "out of memory" message from the error path of
gs_can_start_xmit() and gs_can_open().

Convert the printout in case of a failing usb_submit_urb() in
gs_can_open() from numbers to human readable error codes.

Link: https://lore.kernel.org/all/20230718-gs_usb-cleanups-v1-8-c3b9154ec605@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index e302d7d568aa..a5cab6a07002 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -741,10 +741,8 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 		goto nomem_urb;
 
 	hf = kmalloc(dev->hf_size_tx, GFP_ATOMIC);
-	if (!hf) {
-		netdev_err(netdev, "No memory left for USB buffer\n");
+	if (!hf)
 		goto nomem_hf;
-	}
 
 	idx = txc->echo_id;
 
@@ -877,8 +875,6 @@ static int gs_can_open(struct net_device *netdev)
 			buf = kmalloc(dev->parent->hf_size_rx,
 				      GFP_KERNEL);
 			if (!buf) {
-				netdev_err(netdev,
-					   "No memory left for USB buffer\n");
 				rc = -ENOMEM;
 				goto out_usb_free_urb;
 			}
@@ -901,7 +897,8 @@ static int gs_can_open(struct net_device *netdev)
 					netif_device_detach(dev->netdev);
 
 				netdev_err(netdev,
-					   "usb_submit failed (err=%d)\n", rc);
+					   "usb_submit_urb() failed, error %pe\n",
+					   ERR_PTR(rc));
 
 				goto out_usb_unanchor_urb;
 			}
-- 
2.40.1


