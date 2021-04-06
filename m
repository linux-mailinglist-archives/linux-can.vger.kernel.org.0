Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACEC13551B6
	for <lists+linux-can@lfdr.de>; Tue,  6 Apr 2021 13:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbhDFLQg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Apr 2021 07:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236359AbhDFLQg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Apr 2021 07:16:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EB4C061756
        for <linux-can@vger.kernel.org>; Tue,  6 Apr 2021 04:16:28 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lTjh5-0000rx-1t
        for linux-can@vger.kernel.org; Tue, 06 Apr 2021 13:16:27 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 5B55560870A
        for <linux-can@vger.kernel.org>; Tue,  6 Apr 2021 11:16:24 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 9DF4D6086FC;
        Tue,  6 Apr 2021 11:16:23 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b2098864;
        Tue, 6 Apr 2021 11:16:23 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 01/10] can: peak_usb: fix checkpatch warnings
Date:   Tue,  6 Apr 2021 13:16:13 +0200
Message-Id: <20210406111622.1874957-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210406111622.1874957-1-mkl@pengutronix.de>
References: <20210406111622.1874957-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch cleans several checkpatch warnings in the peak_usb driver.

Cc: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      | 4 ++--
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 1 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.h | 2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index ba509aed7b4c..e23049c81159 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -401,7 +401,7 @@ static int pcan_usb_update_ts(struct pcan_usb_msg_context *mc)
 {
 	__le16 tmp16;
 
-	if ((mc->ptr+2) > mc->end)
+	if ((mc->ptr + 2) > mc->end)
 		return -EINVAL;
 
 	memcpy(&tmp16, mc->ptr, 2);
@@ -1039,7 +1039,7 @@ const struct peak_usb_adapter pcan_usb = {
 			      CAN_CTRLMODE_BERR_REPORTING |
 			      CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
-		.freq = PCAN_USB_CRYSTAL_HZ / 2 ,
+		.freq = PCAN_USB_CRYSTAL_HZ / 2,
 	},
 	.bittiming_const = &pcan_usb_const,
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index ad006edf474d..eccaf7fb3310 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -624,6 +624,7 @@ static int peak_usb_ndo_stop(struct net_device *netdev)
 	/* can set bus off now */
 	if (dev->adapter->dev_set_bus) {
 		int err = dev->adapter->dev_set_bus(dev, 0);
+
 		if (err)
 			return err;
 	}
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index e15b4c78f309..59afe880a481 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -31,7 +31,7 @@
 /* usb adapters maximum channels per usb interface */
 #define PCAN_USB_MAX_CHANNEL		2
 
-/* maximum length of the usb commands sent to/received from  the devices */
+/* maximum length of the usb commands sent to/received from the devices */
 #define PCAN_USB_MAX_CMD_LEN		32
 
 struct peak_usb_device;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 2d1b645af76c..ecb08359f719 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -290,7 +290,7 @@ static int pcan_usb_pro_wait_rsp(struct peak_usb_device *dev,
 					   pr->data_type);
 
 			/* check if channel in response corresponds too */
-			else if ((req_channel != 0xff) && \
+			else if ((req_channel != 0xff) &&
 				(pr->bus_act.channel != req_channel))
 				netdev_err(dev->netdev,
 					"got rsp %xh but on chan%u: ignored\n",

base-commit: cc0626c2aaed8e475efdd85fa374b497a7192e35
-- 
2.30.2


