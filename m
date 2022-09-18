Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C6D5BC003
	for <lists+linux-can@lfdr.de>; Sun, 18 Sep 2022 23:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIRVSO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 18 Sep 2022 17:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiIRVSK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 18 Sep 2022 17:18:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C9312757
        for <linux-can@vger.kernel.org>; Sun, 18 Sep 2022 14:18:08 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oa1fy-0002Mo-OH
        for linux-can@vger.kernel.org; Sun, 18 Sep 2022 23:18:06 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id D2D0CE570B
        for <linux-can@vger.kernel.org>; Sun, 18 Sep 2022 21:18:05 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 325B4E56FF;
        Sun, 18 Sep 2022 21:18:05 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 98799521;
        Sun, 18 Sep 2022 21:18:04 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Daniel Trevitz <daniel.trevitz@wika.com>,
        Ryan Edwards <ryan.edwards@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 1/3] can: gs_usb: gs_make_candev(): convert from usb_control_msg() to usb_control_msg_recv()
Date:   Sun, 18 Sep 2022 23:18:00 +0200
Message-Id: <20220918211802.692405-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220918211802.692405-1-mkl@pengutronix.de>
References: <20220918211802.692405-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Convert the gs_make_candev() function to use usb_control_msg_recv()
instead of usb_control_msg(). Which allows the received data to be
placed on the stack.

This makes error handling a lot easier as we don't have to deal with
freeing the allocated memory.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 82 +++++++++++++++---------------------
 1 file changed, 33 insertions(+), 49 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index cc363f1935ce..16e56394ef9b 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1124,26 +1124,21 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 	struct gs_can *dev;
 	struct net_device *netdev;
 	int rc;
-	struct gs_device_bt_const *bt_const;
-	struct gs_device_bt_const_extended *bt_const_extended;
+	struct gs_device_bt_const_extended bt_const_extended;
+	struct gs_device_bt_const bt_const;
 	u32 feature;
 
-	bt_const = kmalloc(sizeof(*bt_const), GFP_KERNEL);
-	if (!bt_const)
-		return ERR_PTR(-ENOMEM);
-
 	/* fetch bit timing constants */
-	rc = usb_control_msg(interface_to_usbdev(intf),
-			     usb_rcvctrlpipe(interface_to_usbdev(intf), 0),
-			     GS_USB_BREQ_BT_CONST,
-			     USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
-			     channel, 0, bt_const, sizeof(*bt_const), 1000);
+	rc = usb_control_msg_recv(interface_to_usbdev(intf), 0,
+				  GS_USB_BREQ_BT_CONST,
+				  USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
+				  channel, 0, &bt_const, sizeof(bt_const), 1000,
+				  GFP_KERNEL);
 
-	if (rc < 0) {
+	if (rc) {
 		dev_err(&intf->dev,
 			"Couldn't get bit timing const for channel (err=%d)\n",
 			rc);
-		kfree(bt_const);
 		return ERR_PTR(rc);
 	}
 
@@ -1151,7 +1146,6 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 	netdev = alloc_candev(sizeof(struct gs_can), GS_MAX_TX_URBS);
 	if (!netdev) {
 		dev_err(&intf->dev, "Couldn't allocate candev\n");
-		kfree(bt_const);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1164,14 +1158,14 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 
 	/* dev setup */
 	strcpy(dev->bt_const.name, KBUILD_MODNAME);
-	dev->bt_const.tseg1_min = le32_to_cpu(bt_const->tseg1_min);
-	dev->bt_const.tseg1_max = le32_to_cpu(bt_const->tseg1_max);
-	dev->bt_const.tseg2_min = le32_to_cpu(bt_const->tseg2_min);
-	dev->bt_const.tseg2_max = le32_to_cpu(bt_const->tseg2_max);
-	dev->bt_const.sjw_max = le32_to_cpu(bt_const->sjw_max);
-	dev->bt_const.brp_min = le32_to_cpu(bt_const->brp_min);
-	dev->bt_const.brp_max = le32_to_cpu(bt_const->brp_max);
-	dev->bt_const.brp_inc = le32_to_cpu(bt_const->brp_inc);
+	dev->bt_const.tseg1_min = le32_to_cpu(bt_const.tseg1_min);
+	dev->bt_const.tseg1_max = le32_to_cpu(bt_const.tseg1_max);
+	dev->bt_const.tseg2_min = le32_to_cpu(bt_const.tseg2_min);
+	dev->bt_const.tseg2_max = le32_to_cpu(bt_const.tseg2_max);
+	dev->bt_const.sjw_max = le32_to_cpu(bt_const.sjw_max);
+	dev->bt_const.brp_min = le32_to_cpu(bt_const.brp_min);
+	dev->bt_const.brp_max = le32_to_cpu(bt_const.brp_max);
+	dev->bt_const.brp_inc = le32_to_cpu(bt_const.brp_inc);
 
 	dev->udev = interface_to_usbdev(intf);
 	dev->iface = intf;
@@ -1188,13 +1182,13 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 
 	/* can setup */
 	dev->can.state = CAN_STATE_STOPPED;
-	dev->can.clock.freq = le32_to_cpu(bt_const->fclk_can);
+	dev->can.clock.freq = le32_to_cpu(bt_const.fclk_can);
 	dev->can.bittiming_const = &dev->bt_const;
 	dev->can.do_set_bittiming = gs_usb_set_bittiming;
 
 	dev->can.ctrlmode_supported = CAN_CTRLMODE_CC_LEN8_DLC;
 
-	feature = le32_to_cpu(bt_const->feature);
+	feature = le32_to_cpu(bt_const.feature);
 	dev->feature = FIELD_GET(GS_CAN_FEATURE_MASK, feature);
 	if (feature & GS_CAN_FEATURE_LISTEN_ONLY)
 		dev->can.ctrlmode_supported |= CAN_CTRLMODE_LISTENONLY;
@@ -1244,45 +1238,35 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		if (feature & GS_CAN_FEATURE_IDENTIFY)
 			netdev->ethtool_ops = &gs_usb_ethtool_ops;
 
-	kfree(bt_const);
-
 	/* fetch extended bit timing constants if device has feature
 	 * GS_CAN_FEATURE_FD and GS_CAN_FEATURE_BT_CONST_EXT
 	 */
 	if (feature & GS_CAN_FEATURE_FD &&
 	    feature & GS_CAN_FEATURE_BT_CONST_EXT) {
-		bt_const_extended = kmalloc(sizeof(*bt_const_extended), GFP_KERNEL);
-		if (!bt_const_extended)
-			return ERR_PTR(-ENOMEM);
-
-		rc = usb_control_msg(interface_to_usbdev(intf),
-				     usb_rcvctrlpipe(interface_to_usbdev(intf), 0),
-				     GS_USB_BREQ_BT_CONST_EXT,
-				     USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
-				     channel, 0, bt_const_extended,
-				     sizeof(*bt_const_extended),
-				     1000);
-		if (rc < 0) {
+		rc = usb_control_msg_recv(interface_to_usbdev(intf), 0,
+					  GS_USB_BREQ_BT_CONST_EXT,
+					  USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
+					  channel, 0, &bt_const_extended,
+					  sizeof(bt_const_extended),
+					  1000, GFP_KERNEL);
+		if (rc) {
 			dev_err(&intf->dev,
 				"Couldn't get extended bit timing const for channel (err=%d)\n",
 				rc);
-			kfree(bt_const_extended);
 			return ERR_PTR(rc);
 		}
 
 		strcpy(dev->data_bt_const.name, KBUILD_MODNAME);
-		dev->data_bt_const.tseg1_min = le32_to_cpu(bt_const_extended->dtseg1_min);
-		dev->data_bt_const.tseg1_max = le32_to_cpu(bt_const_extended->dtseg1_max);
-		dev->data_bt_const.tseg2_min = le32_to_cpu(bt_const_extended->dtseg2_min);
-		dev->data_bt_const.tseg2_max = le32_to_cpu(bt_const_extended->dtseg2_max);
-		dev->data_bt_const.sjw_max = le32_to_cpu(bt_const_extended->dsjw_max);
-		dev->data_bt_const.brp_min = le32_to_cpu(bt_const_extended->dbrp_min);
-		dev->data_bt_const.brp_max = le32_to_cpu(bt_const_extended->dbrp_max);
-		dev->data_bt_const.brp_inc = le32_to_cpu(bt_const_extended->dbrp_inc);
+		dev->data_bt_const.tseg1_min = le32_to_cpu(bt_const_extended.dtseg1_min);
+		dev->data_bt_const.tseg1_max = le32_to_cpu(bt_const_extended.dtseg1_max);
+		dev->data_bt_const.tseg2_min = le32_to_cpu(bt_const_extended.dtseg2_min);
+		dev->data_bt_const.tseg2_max = le32_to_cpu(bt_const_extended.dtseg2_max);
+		dev->data_bt_const.sjw_max = le32_to_cpu(bt_const_extended.dsjw_max);
+		dev->data_bt_const.brp_min = le32_to_cpu(bt_const_extended.dbrp_min);
+		dev->data_bt_const.brp_max = le32_to_cpu(bt_const_extended.dbrp_max);
+		dev->data_bt_const.brp_inc = le32_to_cpu(bt_const_extended.dbrp_inc);
 
 		dev->can.data_bittiming_const = &dev->data_bt_const;
-
-		kfree(bt_const_extended);
 	}
 
 	SET_NETDEV_DEV(netdev, &intf->dev);
-- 
2.35.1


