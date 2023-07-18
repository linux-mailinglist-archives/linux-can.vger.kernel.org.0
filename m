Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595F0757A2A
	for <lists+linux-can@lfdr.de>; Tue, 18 Jul 2023 13:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjGRLLj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Jul 2023 07:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjGRLLe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2023 07:11:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21C810F1
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 04:11:08 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLibi-0006YR-QJ
        for linux-can@vger.kernel.org; Tue, 18 Jul 2023 13:11:06 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id F40031F40DE
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 11:11:04 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 412AC1F40C9;
        Tue, 18 Jul 2023 11:11:04 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9291197b;
        Tue, 18 Jul 2023 11:11:03 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Tue, 18 Jul 2023 13:10:26 +0200
Subject: [PATCH 04/11] can: gs_usb: uniformly use "parent" as variable name
 for struct gs_usb
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-gs_usb-cleanups-v1-4-c3b9154ec605@pengutronix.de>
References: <20230718-gs_usb-cleanups-v1-0-c3b9154ec605@pengutronix.de>
In-Reply-To: <20230718-gs_usb-cleanups-v1-0-c3b9154ec605@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=5345; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=f8aGNuZ4sJDLTuJMXQehATrT0XhmtTYgbLukPKVOsF8=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBktnMsZHswa8+Zh8kSN0lhOA816JZj2JZtlrzo5
 GEVjxJswPuJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZLZzLAAKCRC+UBxKKooE
 6NZxB/9ywIs3OZP/ZoFtWG1RTKTvgsh/3RURdMoOvjAZbWiprKPkd+SkJOzv8eH1ASBmEd1ipuW
 pDquwgVexe8VAicwx9b8tTE2xeCdjDD08Hn/NHTwVrFCpjtSz/QVyUok5hdzyC4Z2eRQTX2ObpD
 S9nu400IekWpd8NnSNoz7Ki/J6pI3v4IyTHzZPvvY/r46PVNEaNwO9+b78dHruXzspaApkehqot
 wwZ+ND+utns/NrEtusY56A28SdK3N9p+E2O89f6gwXeWrgZfZLWSPRiDEi8UfIbezJ1nXYNPsM7
 05uzCJc9I5wd7o6JbldBAoTA4zJF2OJHGXvHI6T9ZhJsjNVr
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

To ease readability and maintainability uniformly use the variable
name "parent" for the struct gs_usb in the gs_usb driver.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 62 ++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 1e08d38b0f96..441143ad740b 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -524,7 +524,7 @@ static void gs_usb_set_timestamp(struct gs_can *dev, struct sk_buff *skb,
 
 static void gs_usb_receive_bulk_callback(struct urb *urb)
 {
-	struct gs_usb *usbcan = urb->context;
+	struct gs_usb *parent = urb->context;
 	struct gs_can *dev;
 	struct net_device *netdev;
 	int rc;
@@ -535,7 +535,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	struct canfd_frame *cfd;
 	struct sk_buff *skb;
 
-	BUG_ON(!usbcan);
+	BUG_ON(!parent);
 
 	switch (urb->status) {
 	case 0: /* success */
@@ -552,7 +552,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	if (hf->channel >= GS_MAX_INTF)
 		goto device_detach;
 
-	dev = usbcan->canch[hf->channel];
+	dev = parent->canch[hf->channel];
 
 	netdev = dev->netdev;
 	stats = &netdev->stats;
@@ -644,10 +644,10 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	}
 
 resubmit_urb:
-	usb_fill_bulk_urb(urb, usbcan->udev,
-			  usb_rcvbulkpipe(usbcan->udev, GS_USB_ENDPOINT_IN),
+	usb_fill_bulk_urb(urb, parent->udev,
+			  usb_rcvbulkpipe(parent->udev, GS_USB_ENDPOINT_IN),
 			  hf, dev->parent->hf_size_rx,
-			  gs_usb_receive_bulk_callback, usbcan);
+			  gs_usb_receive_bulk_callback, parent);
 
 	rc = usb_submit_urb(urb, GFP_ATOMIC);
 
@@ -655,8 +655,8 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	if (rc == -ENODEV) {
 device_detach:
 		for (rc = 0; rc < GS_MAX_INTF; rc++) {
-			if (usbcan->canch[rc])
-				netif_device_detach(usbcan->canch[rc]->netdev);
+			if (parent->canch[rc])
+				netif_device_detach(parent->canch[rc]->netdev);
 		}
 	}
 }
@@ -1369,7 +1369,7 @@ static int gs_usb_probe(struct usb_interface *intf,
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct gs_host_frame *hf;
-	struct gs_usb *dev;
+	struct gs_usb *parent;
 	struct gs_host_config hconf = {
 		.byte_order = cpu_to_le32(0x0000beef),
 	};
@@ -1412,49 +1412,49 @@ static int gs_usb_probe(struct usb_interface *intf,
 		return -EINVAL;
 	}
 
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev)
+	parent = kzalloc(sizeof(*parent), GFP_KERNEL);
+	if (!parent)
 		return -ENOMEM;
 
-	init_usb_anchor(&dev->rx_submitted);
+	init_usb_anchor(&parent->rx_submitted);
 
-	usb_set_intfdata(intf, dev);
-	dev->udev = udev;
+	usb_set_intfdata(intf, parent);
+	parent->udev = udev;
 
 	for (i = 0; i < icount; i++) {
 		unsigned int hf_size_rx = 0;
 
-		dev->canch[i] = gs_make_candev(i, intf, &dconf);
-		if (IS_ERR_OR_NULL(dev->canch[i])) {
+		parent->canch[i] = gs_make_candev(i, intf, &dconf);
+		if (IS_ERR_OR_NULL(parent->canch[i])) {
 			/* save error code to return later */
-			rc = PTR_ERR(dev->canch[i]);
+			rc = PTR_ERR(parent->canch[i]);
 
 			/* on failure destroy previously created candevs */
 			icount = i;
 			for (i = 0; i < icount; i++)
-				gs_destroy_candev(dev->canch[i]);
+				gs_destroy_candev(parent->canch[i]);
 
-			usb_kill_anchored_urbs(&dev->rx_submitted);
-			kfree(dev);
+			usb_kill_anchored_urbs(&parent->rx_submitted);
+			kfree(parent);
 			return rc;
 		}
-		dev->canch[i]->parent = dev;
+		parent->canch[i]->parent = parent;
 
 		/* set RX packet size based on FD and if hardware
 		 * timestamps are supported.
 		 */
-		if (dev->canch[i]->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
-			if (dev->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+		if (parent->canch[i]->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
+			if (parent->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 				hf_size_rx = struct_size(hf, canfd_ts, 1);
 			else
 				hf_size_rx = struct_size(hf, canfd, 1);
 		} else {
-			if (dev->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+			if (parent->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 				hf_size_rx = struct_size(hf, classic_can_ts, 1);
 			else
 				hf_size_rx = struct_size(hf, classic_can, 1);
 		}
-		dev->hf_size_rx = max(dev->hf_size_rx, hf_size_rx);
+		parent->hf_size_rx = max(parent->hf_size_rx, hf_size_rx);
 	}
 
 	return 0;
@@ -1462,22 +1462,22 @@ static int gs_usb_probe(struct usb_interface *intf,
 
 static void gs_usb_disconnect(struct usb_interface *intf)
 {
-	struct gs_usb *dev = usb_get_intfdata(intf);
+	struct gs_usb *parent = usb_get_intfdata(intf);
 	unsigned int i;
 
 	usb_set_intfdata(intf, NULL);
 
-	if (!dev) {
+	if (!parent) {
 		dev_err(&intf->dev, "Disconnect (nodata)\n");
 		return;
 	}
 
 	for (i = 0; i < GS_MAX_INTF; i++)
-		if (dev->canch[i])
-			gs_destroy_candev(dev->canch[i]);
+		if (parent->canch[i])
+			gs_destroy_candev(parent->canch[i]);
 
-	usb_kill_anchored_urbs(&dev->rx_submitted);
-	kfree(dev);
+	usb_kill_anchored_urbs(&parent->rx_submitted);
+	kfree(parent);
 }
 
 static const struct usb_device_id gs_usb_table[] = {

-- 
2.40.1


