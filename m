Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB574D441D
	for <lists+linux-can@lfdr.de>; Thu, 10 Mar 2022 10:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbiCJKAO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 10 Mar 2022 05:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240866AbiCJKAN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Mar 2022 05:00:13 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D8810E56A
        for <linux-can@vger.kernel.org>; Thu, 10 Mar 2022 01:59:08 -0800 (PST)
Received: from localhost.localdomain (unknown [89.158.146.116])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 5FED52003AE;
        Thu, 10 Mar 2022 10:59:05 +0100 (CET)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 4/8 v3] can: peak_usb: switch function parameter to native format
Date:   Thu, 10 Mar 2022 10:58:37 +0100
Message-Id: <20220310095841.9134-5-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310095841.9134-1-s.grosjean@peak-system.com>
References: <20220310095841.9134-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_FAIL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The user defined device number is stored in the little-endian format
in flash memory. The reading functions of this number are modified
to take this into account.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      |  4 ++--
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |  7 +++++--
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 12 ++++++++----
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  |  4 ++--
 5 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 954abf43d552..313db844ee52 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -383,7 +383,7 @@ static int pcan_usb_get_serial(struct peak_usb_device *dev, u32 *serial_number)
 /*
  * read user device id from device
  */
-static int pcan_usb_get_user_devid(struct peak_usb_device *dev, u32 *device_id)
+static int pcan_usb_get_user_devid(struct peak_usb_device *dev, __le32 *ledevid)
 {
 	u8 args[PCAN_USB_CMD_ARGS_LEN];
 	int err;
@@ -393,7 +393,7 @@ static int pcan_usb_get_user_devid(struct peak_usb_device *dev, u32 *device_id)
 		netdev_err(dev->netdev, "getting device id failure: %d\n", err);
 
 	else
-		*device_id = args[0];
+		*ledevid = (__le32)args[0];
 
 	return err;
 }
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 871a01e158bc..2c5452f6328c 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -881,8 +881,12 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	}
 
 	/* get device number early */
-	if (dev->adapter->dev_get_user_devid)
-		dev->adapter->dev_get_user_devid(dev, &dev->device_number);
+	if (dev->adapter->dev_get_user_devid) {
+		__le32 ledevid;
+
+		if (!dev->adapter->dev_get_user_devid(dev, &ledevid))
+			dev->device_number = le32_to_cpu(ledevid);
+	}
 
 	netdev_info(netdev, "attached to %s channel %u (device %u)\n",
 			peak_usb_adapter->name, ctrl_idx, dev->device_number);
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index 52bea954f2a7..03c8f942d684 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -60,7 +60,7 @@ struct peak_usb_adapter {
 	int (*dev_set_data_bittiming)(struct peak_usb_device *dev,
 				      struct can_bittiming *bt);
 	int (*dev_set_bus)(struct peak_usb_device *dev, u8 onoff);
-	int (*dev_get_user_devid)(struct peak_usb_device *dev, u32 *device_id);
+	int (*dev_get_user_devid)(struct peak_usb_device *dev, __le32 *ledevid);
 	int (*dev_decode_buf)(struct peak_usb_device *dev, struct urb *urb);
 	int (*dev_encode_msg)(struct peak_usb_device *dev, struct sk_buff *skb,
 					u8 *obuf, size_t *size);
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index ab1a8b797ece..533277b41a02 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -422,7 +422,7 @@ static int pcan_usb_fd_set_bittiming_fast(struct peak_usb_device *dev,
 
 /* read user device id from device */
 static int pcan_usb_fd_get_user_devid(struct peak_usb_device *dev,
-				      u32 *device_id)
+				      __le32 *ledevid)
 {
 	struct pcan_usb_fd_device *pdev =
 		container_of(dev, struct pcan_usb_fd_device, dev);
@@ -432,10 +432,14 @@ static int pcan_usb_fd_get_user_devid(struct peak_usb_device *dev,
 	err = pcan_usb_pro_send_req(dev, PCAN_USBPRO_REQ_INFO,
 				    PCAN_USBPRO_INFO_FW,
 				    fw_info, sizeof(*fw_info));
-	if (!err)
-		*device_id = le32_to_cpu(fw_info->dev_id[dev->ctrl_idx]);
+	if (err)
+		return err;
+
+	*ledevid = fw_info->dev_id[dev->ctrl_idx];
+
+	return 0;
+}
 
-	return err;
 }
 
 /* handle restart but in asynchronously way
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 6c1f7f8c8f45..4fda5bb509f0 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -420,7 +420,7 @@ static int pcan_usb_pro_set_led(struct peak_usb_device *dev, u8 mode,
 }
 
 static int pcan_usb_pro_get_user_devid(struct peak_usb_device *dev,
-				       u32 *device_id)
+				       __le32 *ledevid)
 {
 	struct pcan_usb_pro_devid *pdn;
 	struct pcan_usb_pro_msg um;
@@ -439,7 +439,7 @@ static int pcan_usb_pro_get_user_devid(struct peak_usb_device *dev,
 		return err;
 
 	pdn = (struct pcan_usb_pro_devid *)pc;
-	*device_id = le32_to_cpu(pdn->dev_num);
+	*ledevid = pdn->dev_num;
 
 	return err;
 }
-- 
2.25.1

