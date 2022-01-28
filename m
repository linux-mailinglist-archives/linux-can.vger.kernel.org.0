Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB39F49FC56
	for <lists+linux-can@lfdr.de>; Fri, 28 Jan 2022 16:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238507AbiA1PCS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 28 Jan 2022 10:02:18 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:20432 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233512AbiA1PCS (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 28 Jan 2022 10:02:18 -0500
Received: from localhost.localdomain (unknown [89.158.146.116])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 931D52003D0;
        Fri, 28 Jan 2022 16:02:14 +0100 (CET)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 1/6] can: peak_usb: rename a callback to a more explicit name
Date:   Fri, 28 Jan 2022 16:01:52 +0100
Message-Id: <20220128150157.1222850-2-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128150157.1222850-1-s.grosjean@peak-system.com>
References: <20220128150157.1222850-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The so-called "device id" is in fact a value defined by the user.
Therefore, in order not to confuse it with the device id used by the USB,
the functions for reading this user-defined value are renamed.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      | 6 +++---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 4 ++--
 drivers/net/can/usb/peak_usb/pcan_usb_core.h | 2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 17dc178f555b..954abf43d552 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -381,9 +381,9 @@ static int pcan_usb_get_serial(struct peak_usb_device *dev, u32 *serial_number)
 }
 
 /*
- * read device id from device
+ * read user device id from device
  */
-static int pcan_usb_get_device_id(struct peak_usb_device *dev, u32 *device_id)
+static int pcan_usb_get_user_devid(struct peak_usb_device *dev, u32 *device_id)
 {
 	u8 args[PCAN_USB_CMD_ARGS_LEN];
 	int err;
@@ -1015,7 +1015,7 @@ const struct peak_usb_adapter pcan_usb = {
 	.dev_init = pcan_usb_init,
 	.dev_set_bus = pcan_usb_write_mode,
 	.dev_set_bittiming = pcan_usb_set_bittiming,
-	.dev_get_device_id = pcan_usb_get_device_id,
+	.dev_get_user_devid = pcan_usb_get_user_devid,
 	.dev_decode_buf = pcan_usb_decode_buf,
 	.dev_encode_msg = pcan_usb_encode_msg,
 	.dev_start = pcan_usb_start,
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index b850ff8fe4bd..871a01e158bc 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -881,8 +881,8 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	}
 
 	/* get device number early */
-	if (dev->adapter->dev_get_device_id)
-		dev->adapter->dev_get_device_id(dev, &dev->device_number);
+	if (dev->adapter->dev_get_user_devid)
+		dev->adapter->dev_get_user_devid(dev, &dev->device_number);
 
 	netdev_info(netdev, "attached to %s channel %u (device %u)\n",
 			peak_usb_adapter->name, ctrl_idx, dev->device_number);
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index f60af573a2e0..52bea954f2a7 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -60,7 +60,7 @@ struct peak_usb_adapter {
 	int (*dev_set_data_bittiming)(struct peak_usb_device *dev,
 				      struct can_bittiming *bt);
 	int (*dev_set_bus)(struct peak_usb_device *dev, u8 onoff);
-	int (*dev_get_device_id)(struct peak_usb_device *dev, u32 *device_id);
+	int (*dev_get_user_devid)(struct peak_usb_device *dev, u32 *device_id);
 	int (*dev_decode_buf)(struct peak_usb_device *dev, struct urb *urb);
 	int (*dev_encode_msg)(struct peak_usb_device *dev, struct sk_buff *skb,
 					u8 *obuf, size_t *size);
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index ebe087f258e3..4a62cf34acb0 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -419,8 +419,8 @@ static int pcan_usb_pro_set_led(struct peak_usb_device *dev, u8 mode,
 	return pcan_usb_pro_send_cmd(dev, &um);
 }
 
-static int pcan_usb_pro_get_device_id(struct peak_usb_device *dev,
-				      u32 *device_id)
+static int pcan_usb_pro_get_user_devid(struct peak_usb_device *dev,
+				       u32 *device_id)
 {
 	struct pcan_usb_pro_devid *pdn;
 	struct pcan_usb_pro_msg um;
@@ -1075,7 +1075,7 @@ const struct peak_usb_adapter pcan_usb_pro = {
 	.dev_free = pcan_usb_pro_free,
 	.dev_set_bus = pcan_usb_pro_set_bus,
 	.dev_set_bittiming = pcan_usb_pro_set_bittiming,
-	.dev_get_device_id = pcan_usb_pro_get_device_id,
+	.dev_get_user_devid = pcan_usb_pro_get_user_devid,
 	.dev_decode_buf = pcan_usb_pro_decode_buf,
 	.dev_encode_msg = pcan_usb_pro_encode_msg,
 	.dev_start = pcan_usb_pro_start,
-- 
2.25.1

