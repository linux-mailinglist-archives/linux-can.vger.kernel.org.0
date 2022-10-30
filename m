Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ACB612A3F
	for <lists+linux-can@lfdr.de>; Sun, 30 Oct 2022 12:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJ3LBU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 30 Oct 2022 07:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiJ3LBR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 30 Oct 2022 07:01:17 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8246BF2
        for <linux-can@vger.kernel.org>; Sun, 30 Oct 2022 04:01:15 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 7E44C240027
        for <linux-can@vger.kernel.org>; Sun, 30 Oct 2022 12:01:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1667127674; bh=YsvCL8yHGXp/WfaYRVGiM4Yttrj8Y8Qryv4RKcQiQsE=;
        h=From:To:Cc:Subject:Date:From;
        b=QuINTdtMku1IPlPQaHHBT0DBWy6S/gQSg0rDxf4FannGTiG1yGVpe0gKDreJytT1o
         tSX4LEjVfiLJ73YRnyRVgHaRUOa9nAUsZqtalq+WE1WzCPJv0JdLHl6BxtJisIk17K
         NWY76XAJnSeWXjBWv2nwEAL5boFoCUpa+Z5xNqVEWG8MW+KnI2zvkosv2ZAx2wBUFp
         opX+lQmNqdRl7oGpfKywdRqcGPo1aZqbzGuZAjCBL4S8qgchIv1S5aMDpKj76AX7a7
         yGC53aLAZKANdVdQAMe2nyA/VCwQIHb82hk8s7Vvv42LBPLYApKDzC9mTE0N115ZFV
         A7aQXUCSlCzHg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4N0YHY6TXqz9rxW;
        Sun, 30 Oct 2022 12:01:13 +0100 (CET)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     linux-can@vger.kernel.org
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Lukas Magel <lukas.magel@posteo.net>
Subject: [PATCH v2 1/7] can: peak_usb: rename device_id to a more explicit name
Date:   Sun, 30 Oct 2022 10:59:33 +0000
Message-Id: <20221030105939.87658-2-lukas.magel@posteo.net>
In-Reply-To: <20221030105939.87658-1-lukas.magel@posteo.net>
References: <20220801080446.36374-1-lukas.magel@posteo.net>
 <20221030105939.87658-1-lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Stephane Grosjean <s.grosjean@peak-system.com>

The so-called "device id" is in fact a value defined by the user.
Therefore, in order not to confuse it with the device id used by the USB,
the functions and variables for reading this user-defined value are
renamed.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Lukas Magel <lukas.magel@posteo.net>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      | 8 ++++----
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 6 +++---
 drivers/net/can/usb/peak_usb/pcan_usb_core.h | 4 ++--
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 8 ++++----
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 687dd542f7f6..11fd033b57f3 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -381,9 +381,9 @@ static int pcan_usb_get_serial(struct peak_usb_device *dev, u32 *serial_number)
 }
 
 /*
- * read device id from device
+ * read user device id from device
  */
-static int pcan_usb_get_device_id(struct peak_usb_device *dev, u32 *device_id)
+static int pcan_usb_get_user_devid(struct peak_usb_device *dev, u32 *user_devid)
 {
 	u8 args[PCAN_USB_CMD_ARGS_LEN];
 	int err;
@@ -393,7 +393,7 @@ static int pcan_usb_get_device_id(struct peak_usb_device *dev, u32 *device_id)
 		netdev_err(dev->netdev, "getting device id failure: %d\n", err);
 
 	else
-		*device_id = args[0];
+		*user_devid = args[0];
 
 	return err;
 }
@@ -1017,7 +1017,7 @@ const struct peak_usb_adapter pcan_usb = {
 	.dev_init = pcan_usb_init,
 	.dev_set_bus = pcan_usb_write_mode,
 	.dev_set_bittiming = pcan_usb_set_bittiming,
-	.dev_get_device_id = pcan_usb_get_device_id,
+	.dev_get_user_devid = pcan_usb_get_user_devid,
 	.dev_decode_buf = pcan_usb_decode_buf,
 	.dev_encode_msg = pcan_usb_encode_msg,
 	.dev_start = pcan_usb_start,
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 225697d70a9a..8e1b3c19f92f 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -922,11 +922,11 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	}
 
 	/* get device number early */
-	if (dev->adapter->dev_get_device_id)
-		dev->adapter->dev_get_device_id(dev, &dev->device_number);
+	if (dev->adapter->dev_get_user_devid)
+		dev->adapter->dev_get_user_devid(dev, &dev->user_devid);
 
 	netdev_info(netdev, "attached to %s channel %u (device %u)\n",
-			peak_usb_adapter->name, ctrl_idx, dev->device_number);
+			peak_usb_adapter->name, ctrl_idx, dev->user_devid);
 
 	return 0;
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index f6bdd8b3f290..6ff32673a256 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -60,7 +60,7 @@ struct peak_usb_adapter {
 	int (*dev_set_data_bittiming)(struct peak_usb_device *dev,
 				      struct can_bittiming *bt);
 	int (*dev_set_bus)(struct peak_usb_device *dev, u8 onoff);
-	int (*dev_get_device_id)(struct peak_usb_device *dev, u32 *device_id);
+	int (*dev_get_user_devid)(struct peak_usb_device *dev, u32 *user_devid);
 	int (*dev_decode_buf)(struct peak_usb_device *dev, struct urb *urb);
 	int (*dev_encode_msg)(struct peak_usb_device *dev, struct sk_buff *skb,
 					u8 *obuf, size_t *size);
@@ -122,7 +122,7 @@ struct peak_usb_device {
 	u8 *cmd_buf;
 	struct usb_anchor rx_submitted;
 
-	u32 device_number;
+	u32 user_devid;
 	u8 device_rev;
 
 	u8 ep_msg_in;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 2ea1500df393..b8053e697261 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -972,7 +972,7 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 	}
 
 	pdev->usb_if->dev[dev->ctrl_idx] = dev;
-	dev->device_number =
+	dev->user_devid =
 		le32_to_cpu(pdev->usb_if->fw_info.dev_id[dev->ctrl_idx]);
 
 	/* if vendor rsp is of type 2, then it contains EP numbers to
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 5d8f6a40bb2c..15410d60cdf7 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -419,8 +419,8 @@ static int pcan_usb_pro_set_led(struct peak_usb_device *dev, u8 mode,
 	return pcan_usb_pro_send_cmd(dev, &um);
 }
 
-static int pcan_usb_pro_get_device_id(struct peak_usb_device *dev,
-				      u32 *device_id)
+static int pcan_usb_pro_get_user_devid(struct peak_usb_device *dev,
+				       u32 *user_devid)
 {
 	struct pcan_usb_pro_devid *pdn;
 	struct pcan_usb_pro_msg um;
@@ -439,7 +439,7 @@ static int pcan_usb_pro_get_device_id(struct peak_usb_device *dev,
 		return err;
 
 	pdn = (struct pcan_usb_pro_devid *)pc;
-	*device_id = le32_to_cpu(pdn->dev_num);
+	*user_devid = le32_to_cpu(pdn->dev_num);
 
 	return err;
 }
@@ -1076,7 +1076,7 @@ const struct peak_usb_adapter pcan_usb_pro = {
 	.dev_free = pcan_usb_pro_free,
 	.dev_set_bus = pcan_usb_pro_set_bus,
 	.dev_set_bittiming = pcan_usb_pro_set_bittiming,
-	.dev_get_device_id = pcan_usb_pro_get_device_id,
+	.dev_get_user_devid = pcan_usb_pro_get_user_devid,
 	.dev_decode_buf = pcan_usb_pro_decode_buf,
 	.dev_encode_msg = pcan_usb_pro_encode_msg,
 	.dev_start = pcan_usb_pro_start,
-- 
2.37.2

