Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5844D2F4A
	for <lists+linux-can@lfdr.de>; Wed,  9 Mar 2022 13:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbiCIMmk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Mar 2022 07:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbiCIMmj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Mar 2022 07:42:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AFB1768E9
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 04:41:41 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nRvdL-0002jq-HT
        for linux-can@vger.kernel.org; Wed, 09 Mar 2022 13:41:39 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id CCA9146BB1
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 12:41:37 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 91DB546BAE;
        Wed,  9 Mar 2022 12:41:37 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ab21488c;
        Wed, 9 Mar 2022 12:41:33 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 12/21] can: gs_usb: gs_usb_probe(): introduce udev and make use of it
Date:   Wed,  9 Mar 2022 13:41:23 +0100
Message-Id: <20220309124132.291861-13-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309124132.291861-1-mkl@pengutronix.de>
References: <20220309124132.291861-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
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

Introduce the variable udev in the gs_usb_probe() function to hold a
pointer to the struct usb_device. This avoids recalculating the value
several times in this function.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 52c84792361e..f56bfbeae3be 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -885,6 +885,7 @@ static void gs_destroy_candev(struct gs_can *dev)
 static int gs_usb_probe(struct usb_interface *intf,
 			const struct usb_device_id *id)
 {
+	struct usb_device *udev = interface_to_usbdev(intf);
 	struct gs_usb *dev;
 	int rc = -ENOMEM;
 	unsigned int icount, i;
@@ -898,8 +899,7 @@ static int gs_usb_probe(struct usb_interface *intf,
 	hconf->byte_order = cpu_to_le32(0x0000beef);
 
 	/* send host config */
-	rc = usb_control_msg(interface_to_usbdev(intf),
-			     usb_sndctrlpipe(interface_to_usbdev(intf), 0),
+	rc = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
 			     GS_USB_BREQ_HOST_FORMAT,
 			     USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
 			     1, intf->cur_altsetting->desc.bInterfaceNumber,
@@ -917,8 +917,7 @@ static int gs_usb_probe(struct usb_interface *intf,
 		return -ENOMEM;
 
 	/* read device config */
-	rc = usb_control_msg(interface_to_usbdev(intf),
-			     usb_rcvctrlpipe(interface_to_usbdev(intf), 0),
+	rc = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
 			     GS_USB_BREQ_DEVICE_CONFIG,
 			     USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
 			     1, intf->cur_altsetting->desc.bInterfaceNumber,
@@ -950,7 +949,7 @@ static int gs_usb_probe(struct usb_interface *intf,
 	init_usb_anchor(&dev->rx_submitted);
 
 	usb_set_intfdata(intf, dev);
-	dev->udev = interface_to_usbdev(intf);
+	dev->udev = udev;
 
 	for (i = 0; i < icount; i++) {
 		dev->canch[i] = gs_make_candev(i, intf, dconf);
-- 
2.34.1


