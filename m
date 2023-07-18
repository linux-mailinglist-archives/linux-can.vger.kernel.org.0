Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38A3757A28
	for <lists+linux-can@lfdr.de>; Tue, 18 Jul 2023 13:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjGRLLh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Jul 2023 07:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjGRLLe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2023 07:11:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAC91BC9
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 04:11:09 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLibj-0006ZW-A5
        for linux-can@vger.kernel.org; Tue, 18 Jul 2023 13:11:07 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 8C5721F40EF
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 11:11:05 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id A6BB51F40D5;
        Tue, 18 Jul 2023 11:11:04 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3828dcdd;
        Tue, 18 Jul 2023 11:11:03 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Tue, 18 Jul 2023 13:10:30 +0200
Subject: [PATCH 08/11] can: gs_usb: gs_can_start_xmit(), gs_can_open():
 clean up printouts in error path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-gs_usb-cleanups-v1-8-c3b9154ec605@pengutronix.de>
References: <20230718-gs_usb-cleanups-v1-0-c3b9154ec605@pengutronix.de>
In-Reply-To: <20230718-gs_usb-cleanups-v1-0-c3b9154ec605@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1467; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=zmji5Uu0RPh8RWRKKA3OPk4x4UgoUvkdZoJMmWJbLxU=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBktnM5L9GcG3FCMEoh5G3yCpGeVdJVf0C12sRx4
 xDxN9shOH2JATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZLZzOQAKCRC+UBxKKooE
 6Ko3CACoJvq6D/qyD3mO+Z8R+xhYcXkjgbsWTzZu5BPsmxvKn0FBQyjbjFcY+OdPmps1+itx4/M
 k6AJDdp5b3mwnQn7W3qVjA3t4EOveUMWs2Uob9/0HSEVeMeN9G3I6mLYIA6b/Y6kLNqdVoiQ6o1
 sywHR5hBlKOKdcbpIpZmn90mYNyUJS5IDoxxv62rHOwXxF5yvdpjuiDwAHwhcV510hT8cXX3dsn
 0misCVGLR5d7H/RsRUHjHZbW3UrS7vOlvSvGueXuRUSNAhoheJo1YdYXsubRkDw1ncS5+bB9HeL
 2vigwdr5/3bFq4qOVIpS5ES5/gPJ7xos0MoPR7LqdKPYIUv5
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

Remove unnecessary "out of memory" message from the error path of
gs_can_start_xmit() and gs_can_open().

Convert the printout in case of a failing usb_submit_urb() in
gs_can_open() from numbers to human readable error codes.

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


