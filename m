Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D70311546D
	for <lists+linux-can@lfdr.de>; Fri,  6 Dec 2019 16:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfLFPjH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Dec 2019 10:39:07 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:44094 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfLFPjH (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 6 Dec 2019 10:39:07 -0500
Received: from linux-dev.peak.localnet (unknown [185.109.201.203])
        (Authenticated sender: stephane.grosjean)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id AC68DB0055E;
        Fri,  6 Dec 2019 16:39:01 +0100 (CET)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 1/2] can/peak_usb/pcan_usb: Document the commands sent to the device
Date:   Fri,  6 Dec 2019 16:38:02 +0100
Message-Id: <20191206153803.17725-2-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191206153803.17725-1-s.grosjean@peak-system.com>
References: <20191206153803.17725-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch documents the functions and numbers of the commands sent by the
driver to the PCAN-USB CAN device from PEAK-System GmbH.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 33 +++++++++++++++++++------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index d2539c95adb6..fedfa6f7a5e8 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -34,6 +34,22 @@ MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB adapter");
 #define PCAN_USB_CMD_LEN		(PCAN_USB_CMD_ARGS + \
 					 PCAN_USB_CMD_ARGS_LEN)
 
+/* PCAN-USB commands */
+#define PCAN_USB_CMD_BITRATE	1
+#define PCAN_USB_CMD_SET_BUS	3
+#define PCAN_USB_CMD_DEVID	4
+#define PCAN_USB_CMD_SN		6
+#define PCAN_USB_CMD_REGISTER	9
+#define PCAN_USB_CMD_EXT_VCC	10
+
+/* PCAN_USB_CMD_SET_BUS number arg */
+#define PCAN_USB_BUS_XCVER		2
+#define PCAN_USB_BUS_SILENT_MODE	3
+
+/* PCAN_USB_CMD_xxx functions */
+#define PCAN_USB_GET		1
+#define PCAN_USB_SET		2
+
 /* PCAN-USB command timeout (ms.) */
 #define PCAN_USB_COMMAND_TIMEOUT	1000
 
@@ -172,7 +188,8 @@ static int pcan_usb_set_sja1000(struct peak_usb_device *dev, u8 mode)
 		[1] = mode,
 	};
 
-	return pcan_usb_send_cmd(dev, 9, 2, args);
+	return pcan_usb_send_cmd(dev, PCAN_USB_CMD_REGISTER, PCAN_USB_SET,
+				 args);
 }
 
 static int pcan_usb_set_bus(struct peak_usb_device *dev, u8 onoff)
@@ -181,7 +198,8 @@ static int pcan_usb_set_bus(struct peak_usb_device *dev, u8 onoff)
 		[0] = !!onoff,
 	};
 
-	return pcan_usb_send_cmd(dev, 3, 2, args);
+	return pcan_usb_send_cmd(dev, PCAN_USB_CMD_SET_BUS, PCAN_USB_BUS_XCVER,
+				 args);
 }
 
 static int pcan_usb_set_silent(struct peak_usb_device *dev, u8 onoff)
@@ -190,7 +208,8 @@ static int pcan_usb_set_silent(struct peak_usb_device *dev, u8 onoff)
 		[0] = !!onoff,
 	};
 
-	return pcan_usb_send_cmd(dev, 3, 3, args);
+	return pcan_usb_send_cmd(dev, PCAN_USB_CMD_SET_BUS,
+				 PCAN_USB_BUS_SILENT_MODE, args);
 }
 
 static int pcan_usb_set_ext_vcc(struct peak_usb_device *dev, u8 onoff)
@@ -199,7 +218,7 @@ static int pcan_usb_set_ext_vcc(struct peak_usb_device *dev, u8 onoff)
 		[0] = !!onoff,
 	};
 
-	return pcan_usb_send_cmd(dev, 10, 2, args);
+	return pcan_usb_send_cmd(dev, PCAN_USB_CMD_EXT_VCC, PCAN_USB_SET, args);
 }
 
 /*
@@ -223,7 +242,7 @@ static int pcan_usb_set_bittiming(struct peak_usb_device *dev,
 	args[0] = btr1;
 	args[1] = btr0;
 
-	return pcan_usb_send_cmd(dev, 1, 2, args);
+	return pcan_usb_send_cmd(dev, PCAN_USB_CMD_BITRATE, PCAN_USB_SET, args);
 }
 
 /*
@@ -307,7 +326,7 @@ static int pcan_usb_get_serial(struct peak_usb_device *dev, u32 *serial_number)
 	u8 args[PCAN_USB_CMD_ARGS_LEN];
 	int err;
 
-	err = pcan_usb_wait_rsp(dev, 6, 1, args);
+	err = pcan_usb_wait_rsp(dev, PCAN_USB_CMD_SN, PCAN_USB_GET, args);
 	if (err) {
 		netdev_err(dev->netdev, "getting serial failure: %d\n", err);
 	} else if (serial_number) {
@@ -328,7 +347,7 @@ static int pcan_usb_get_device_id(struct peak_usb_device *dev, u32 *device_id)
 	u8 args[PCAN_USB_CMD_ARGS_LEN];
 	int err;
 
-	err = pcan_usb_wait_rsp(dev, 4, 1, args);
+	err = pcan_usb_wait_rsp(dev, PCAN_USB_CMD_DEVID, PCAN_USB_GET, args);
 	if (err)
 		netdev_err(dev->netdev, "getting device id failure: %d\n", err);
 	else if (device_id)
-- 
2.20.1

