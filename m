Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D6E75510D
	for <lists+linux-can@lfdr.de>; Sun, 16 Jul 2023 21:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjGPTeM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 16 Jul 2023 15:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjGPTeL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 16 Jul 2023 15:34:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF83109
        for <linux-can@vger.kernel.org>; Sun, 16 Jul 2023 12:34:08 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qL7VP-0002to-76
        for linux-can@vger.kernel.org; Sun, 16 Jul 2023 21:34:07 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id B74D51F1ED6
        for <linux-can@vger.kernel.org>; Sun, 16 Jul 2023 19:34:05 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id BBB9F1F1ECA;
        Sun, 16 Jul 2023 19:34:04 +0000 (UTC)
Received: from [172.20.34.65] (ip6-loopback [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 39982a29;
        Sun, 16 Jul 2023 19:34:04 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Sun, 16 Jul 2023 21:33:49 +0200
Subject: [PATCH 1/2] can: gs_usb: gs_can_open(): improve error handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-gs_usb-fix-time-stamp-counter-v1-1-9017cefcd9d5@pengutronix.de>
References: <20230716-gs_usb-fix-time-stamp-counter-v1-0-9017cefcd9d5@pengutronix.de>
In-Reply-To: <20230716-gs_usb-fix-time-stamp-counter-v1-0-9017cefcd9d5@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, John Whittington <git@jbrengineering.co.uk>,
        Marc Kleine-Budde <mkl@pengutronix.de>, stable@vger.kernel.org
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3326; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=zItgKrUsBwRbi6aEz7pVsPLxQF2p/PjtpOmzaFK1zR4=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBktEYmDaKq8AuXm2tm4UiN8R2nXkt0oZQHcDrP8
 XEoB0hu6iGJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZLRGJgAKCRC+UBxKKooE
 6DAkB/0SwH1RAP5omn6H+7eTMwcyXRg4krBvTkwNexLSfyRCydUYH6StK9TUxN1hKNo/Ox4+xnE
 +UeixiJhh7LpX8UmzBnzAtkHfwMlQWk/KirplXLaHu2MYwNXpUiwfWWpFlEGy5Q2T3UlWlCRX71
 z0dksRHtU26GK5SX4DfZ4lNalz1VBq71hF6aqX0lgTpP6owDCCU8N68UMGapAK/nJlIHXL0NkAQ
 O8g6p4tj7eIUrcKq6MaWAGvB60w0urGOPpKNsR8vhrmLw0rkpziNEIVx63NXe/DfmsFB9QbKXXw
 Kg3jegrGhlI6NMx+1JswiapsF+ZcHRoH78YqSvmTmcZR7Ty9
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

The gs_usb driver handles USB devices with more than 1 CAN channel.
The RX path for all channels share the same bulk endpoint (the
transmitted bulk data encodes the channel number). These per-device
resources are allocated and submitted by the first opened channel.

During this allocation, the resources are either released immediately
in case of a failure or the URBs are anchored. All anchored URBs are
finally killed with gs_usb_disconnect().

Currently, gs_can_open() returns with an error if the allocation of a
URB or a buffer fails. However, if usb_submit_urb() fails, the driver
continues with the URBs submitted so far, even if no URBs were
successfully submitted.

Treat every error as fatal and free all allocated resources
immediately.

Switch to goto-style error handling, to prepare the driver for more
per-device resource allocation.

Cc: stable@vger.kernel.org
Cc: John Whittington <git@jbrengineering.co.uk>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index d476c2884008..85b7b59c8426 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -833,6 +833,7 @@ static int gs_can_open(struct net_device *netdev)
 		.mode = cpu_to_le32(GS_CAN_MODE_START),
 	};
 	struct gs_host_frame *hf;
+	struct urb *urb = NULL;
 	u32 ctrlmode;
 	u32 flags = 0;
 	int rc, i;
@@ -856,13 +857,14 @@ static int gs_can_open(struct net_device *netdev)
 
 	if (!parent->active_channels) {
 		for (i = 0; i < GS_MAX_RX_URBS; i++) {
-			struct urb *urb;
 			u8 *buf;
 
 			/* alloc rx urb */
 			urb = usb_alloc_urb(0, GFP_KERNEL);
-			if (!urb)
-				return -ENOMEM;
+			if (!urb) {
+				rc = -ENOMEM;
+				goto out_usb_kill_anchored_urbs;
+			}
 
 			/* alloc rx buffer */
 			buf = kmalloc(dev->parent->hf_size_rx,
@@ -870,8 +872,8 @@ static int gs_can_open(struct net_device *netdev)
 			if (!buf) {
 				netdev_err(netdev,
 					   "No memory left for USB buffer\n");
-				usb_free_urb(urb);
-				return -ENOMEM;
+				rc = -ENOMEM;
+				goto out_usb_free_urb;
 			}
 
 			/* fill, anchor, and submit rx urb */
@@ -894,9 +896,7 @@ static int gs_can_open(struct net_device *netdev)
 				netdev_err(netdev,
 					   "usb_submit failed (err=%d)\n", rc);
 
-				usb_unanchor_urb(urb);
-				usb_free_urb(urb);
-				break;
+				goto out_usb_unanchor_urb;
 			}
 
 			/* Drop reference,
@@ -945,7 +945,8 @@ static int gs_can_open(struct net_device *netdev)
 		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 			gs_usb_timestamp_stop(dev);
 		dev->can.state = CAN_STATE_STOPPED;
-		return rc;
+
+		goto out_usb_kill_anchored_urbs;
 	}
 
 	parent->active_channels++;
@@ -953,6 +954,18 @@ static int gs_can_open(struct net_device *netdev)
 		netif_start_queue(netdev);
 
 	return 0;
+
+out_usb_unanchor_urb:
+	usb_unanchor_urb(urb);
+out_usb_free_urb:
+	usb_free_urb(urb);
+out_usb_kill_anchored_urbs:
+	if (!parent->active_channels)
+		usb_kill_anchored_urbs(&dev->tx_submitted);
+
+	close_candev(netdev);
+
+	return rc;
 }
 
 static int gs_usb_get_state(const struct net_device *netdev,

-- 
2.40.1


