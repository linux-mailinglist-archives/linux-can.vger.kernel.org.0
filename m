Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F2566CFE3
	for <lists+linux-can@lfdr.de>; Mon, 16 Jan 2023 21:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjAPULx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 16 Jan 2023 15:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjAPULv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 16 Jan 2023 15:11:51 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DADA23D95
        for <linux-can@vger.kernel.org>; Mon, 16 Jan 2023 12:11:50 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 0B113240262
        for <linux-can@vger.kernel.org>; Mon, 16 Jan 2023 21:11:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1673899909; bh=v50O6ERQHyx0uRd4NcVa8RnNSqNKZI3KQQhAFEKWkAY=;
        h=From:To:Cc:Subject:Date:From;
        b=OH2G20Iqp+ifW2VH3O2W6naXZ+g+oKD8VKrqK3fOXfXr9uADONTtwDoQj2uNNm3SY
         4eVSdH/aD/ZTbYTHY9dTIZHtCbUGrJVF++t8pL40YB9R3pCkfd2sGqqF3XDYJVpfTA
         G+bLkk8iM61Xb/I6AaE9WL7rESQ/i3vgTTpHsAu8ayJgXWh4unhAewBOnGpUe7EzdB
         dG5iL5Qckpc+iqsKOuCYrO7145hEYNEJRjQ8KkgZh4JqBmpT0mvnVcytj4vj4JolyI
         W1r4P+zWKgI1VhCJOCugFFE1qlZIfuX9lRUWEyzeHNbYTDK8BU3yg67B+LUvJBucp1
         6LutxvtbKGr2Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Nwjpr2smzz9rxG;
        Mon, 16 Jan 2023 21:11:48 +0100 (CET)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     linux-can@vger.kernel.org
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Lukas Magel <lukas.magel@posteo.net>
Subject: [PATCH v3 1/8] can: peak_usb: rename device_id to CAN channel ID
Date:   Mon, 16 Jan 2023 20:09:25 +0000
Message-Id: <20230116200932.157769-2-lukas.magel@posteo.net>
In-Reply-To: <20230116200932.157769-1-lukas.magel@posteo.net>
References: <20220801080446.36374-1-lukas.magel@posteo.net>
 <20230116200932.157769-1-lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Stephane Grosjean <s.grosjean@peak-system.com>

The so-called "device id" is a user-defined identifier value that can be
set individually for each CAN interface of a PEAK USB device.
Contrary to a static serial number, the value can be changed by the
user. With this ID, each CAN interface can be uniquely identified even if
the USB device does not export a proper serial number or the USB device
exports multiple CAN interfaces. In order to not confuse it with the
device ID used by the USB core and emphasize the link to the CAN
interface, the functions and variables for reading this user-defined
value are renamed to CAN channel ID.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Lukas Magel <lukas.magel@posteo.net>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      | 10 +++++-----
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |  8 ++++----
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  5 +++--
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   |  2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  |  8 ++++----
 5 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 687dd542f7f6..7b3282e5c880 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -381,19 +381,19 @@ static int pcan_usb_get_serial(struct peak_usb_device *dev, u32 *serial_number)
 }
 
 /*
- * read device id from device
+ * read can channel id from device
  */
-static int pcan_usb_get_device_id(struct peak_usb_device *dev, u32 *device_id)
+static int pcan_usb_get_can_channel_id(struct peak_usb_device *dev, u32 *can_ch_id)
 {
 	u8 args[PCAN_USB_CMD_ARGS_LEN];
 	int err;
 
 	err = pcan_usb_wait_rsp(dev, PCAN_USB_CMD_DEVID, PCAN_USB_GET, args);
 	if (err)
-		netdev_err(dev->netdev, "getting device id failure: %d\n", err);
+		netdev_err(dev->netdev, "getting can channel id failure: %d\n", err);
 
 	else
-		*device_id = args[0];
+		*can_ch_id = args[0];
 
 	return err;
 }
@@ -1017,7 +1017,7 @@ const struct peak_usb_adapter pcan_usb = {
 	.dev_init = pcan_usb_init,
 	.dev_set_bus = pcan_usb_write_mode,
 	.dev_set_bittiming = pcan_usb_set_bittiming,
-	.dev_get_device_id = pcan_usb_get_device_id,
+	.dev_get_can_channel_id = pcan_usb_get_can_channel_id,
 	.dev_decode_buf = pcan_usb_decode_buf,
 	.dev_encode_msg = pcan_usb_encode_msg,
 	.dev_start = pcan_usb_start,
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 225697d70a9a..a3a25a2e8d41 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -921,12 +921,12 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 			goto adap_dev_free;
 	}
 
-	/* get device number early */
-	if (dev->adapter->dev_get_device_id)
-		dev->adapter->dev_get_device_id(dev, &dev->device_number);
+	/* get CAN channel id early */
+	if (dev->adapter->dev_get_can_channel_id)
+		dev->adapter->dev_get_can_channel_id(dev, &dev->can_channel_id);
 
 	netdev_info(netdev, "attached to %s channel %u (device %u)\n",
-			peak_usb_adapter->name, ctrl_idx, dev->device_number);
+			peak_usb_adapter->name, ctrl_idx, dev->can_channel_id);
 
 	return 0;
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index f6bdd8b3f290..6de0429c268f 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -60,7 +60,7 @@ struct peak_usb_adapter {
 	int (*dev_set_data_bittiming)(struct peak_usb_device *dev,
 				      struct can_bittiming *bt);
 	int (*dev_set_bus)(struct peak_usb_device *dev, u8 onoff);
-	int (*dev_get_device_id)(struct peak_usb_device *dev, u32 *device_id);
+	int (*dev_get_can_channel_id)(struct peak_usb_device *dev, u32 *can_ch_id);
 	int (*dev_decode_buf)(struct peak_usb_device *dev, struct urb *urb);
 	int (*dev_encode_msg)(struct peak_usb_device *dev, struct sk_buff *skb,
 					u8 *obuf, size_t *size);
@@ -122,7 +122,8 @@ struct peak_usb_device {
 	u8 *cmd_buf;
 	struct usb_anchor rx_submitted;
 
-	u32 device_number;
+	/* equivalent to the device ID in the Windows API */
+	u32 can_channel_id;
 	u8 device_rev;
 
 	u8 ep_msg_in;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 2ea1500df393..2e0955900ebe 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -972,7 +972,7 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 	}
 
 	pdev->usb_if->dev[dev->ctrl_idx] = dev;
-	dev->device_number =
+	dev->can_channel_id =
 		le32_to_cpu(pdev->usb_if->fw_info.dev_id[dev->ctrl_idx]);
 
 	/* if vendor rsp is of type 2, then it contains EP numbers to
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 5d8f6a40bb2c..3a13cfef47bb 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -419,8 +419,8 @@ static int pcan_usb_pro_set_led(struct peak_usb_device *dev, u8 mode,
 	return pcan_usb_pro_send_cmd(dev, &um);
 }
 
-static int pcan_usb_pro_get_device_id(struct peak_usb_device *dev,
-				      u32 *device_id)
+static int pcan_usb_pro_get_can_channel_id(struct peak_usb_device *dev,
+					   u32 *can_ch_id)
 {
 	struct pcan_usb_pro_devid *pdn;
 	struct pcan_usb_pro_msg um;
@@ -439,7 +439,7 @@ static int pcan_usb_pro_get_device_id(struct peak_usb_device *dev,
 		return err;
 
 	pdn = (struct pcan_usb_pro_devid *)pc;
-	*device_id = le32_to_cpu(pdn->dev_num);
+	*can_ch_id = le32_to_cpu(pdn->dev_num);
 
 	return err;
 }
@@ -1076,7 +1076,7 @@ const struct peak_usb_adapter pcan_usb_pro = {
 	.dev_free = pcan_usb_pro_free,
 	.dev_set_bus = pcan_usb_pro_set_bus,
 	.dev_set_bittiming = pcan_usb_pro_set_bittiming,
-	.dev_get_device_id = pcan_usb_pro_get_device_id,
+	.dev_get_can_channel_id = pcan_usb_pro_get_can_channel_id,
 	.dev_decode_buf = pcan_usb_pro_decode_buf,
 	.dev_encode_msg = pcan_usb_pro_encode_msg,
 	.dev_start = pcan_usb_pro_start,
-- 
2.38.1

