Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC33D5865FA
	for <lists+linux-can@lfdr.de>; Mon,  1 Aug 2022 10:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiHAIFf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 1 Aug 2022 04:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiHAIFd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 1 Aug 2022 04:05:33 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B08DE1
        for <linux-can@vger.kernel.org>; Mon,  1 Aug 2022 01:05:32 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 7730E240104
        for <linux-can@vger.kernel.org>; Mon,  1 Aug 2022 10:05:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1659341129; bh=VcN7O1YaJMbD7d9hK3A+3wrI3Lxi8b3nHGG7rFoEss0=;
        h=From:To:Cc:Subject:Date:From;
        b=m7w9JiUNet76AHNqTB0HskifLR3o3EmivwNkGMHeB5ynAF8zhGvW59YYSqkjWKqi0
         ar1ne7WfXftHcR/q8+cV81CoAMvlrCGYZaSfxpMEt9pfEi4f9XqMZa3ROXx/rK9Vln
         y8rbrg7Bmzsk7pfjswrryxwkZiEAnStsmWqDlJvXlQyfjbP3q4VK+eb3nl7bewzOmf
         UMGtIWkMzY1urfYxBU+rGpSigo7TIfBJv9DKBUoC/Kzi2PJV3v6yDmpt6oizT+mZze
         RJbhQ5W8K+5mJapf9SPLvQJePwXIgWqSI7ouiJ2xeO3E/kX4qy+6lH5IFRwyVyA3j7
         JZSiDuhJzYNsw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Lx9fJ3sXRz9rxP;
        Mon,  1 Aug 2022 10:05:28 +0200 (CEST)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     linux-can@vger.kernel.org
Cc:     Lukas Magel <lukas.magel@posteo.net>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1] can: peak_usb: export PCAN device ID as sysfs device attribute
Date:   Mon,  1 Aug 2022 08:04:46 +0000
Message-Id: <20220801080446.36374-1-lukas.magel@posteo.net>
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

Peak USB devices support a configurable u8 / u32 device ID. In
multi-device setups, this device ID can be configured and used to
identify individual CAN interfaces independent of the order in which
they are plugged into the system. At the current time, the device ID
is already queried from the device and stored in the peak_usb_device
struct.

This patch exports the device ID (called device_number in the struct)
as a sysfs attribute. The attribute name was chosen to be device_id
instead of device_number because the latter has been deprecated by Peak
in their API.

Signed-off-by: Lukas Magel <lukas.magel@posteo.net>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
For the moment, the patch only implements read support for the device
ID. My next goal is to also implement write access. However, this
will require a more significant modification of the driver since the
corresponding commands for ID retrieval and configuration are not
implemented for all device types.

 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 27b0a72fd885..43df178e9473 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -15,6 +15,8 @@
 #include <linux/netdevice.h>
 #include <linux/usb.h>
 #include <linux/ethtool.h>
+#include <linux/device.h>
+#include <linux/sysfs.h>
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
@@ -53,6 +55,15 @@ static const struct usb_device_id peak_usb_table[] = {
 
 MODULE_DEVICE_TABLE(usb, peak_usb_table);
 
+static ssize_t device_id_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct net_device *netdev = to_net_dev(dev);
+	struct peak_usb_device *peak_dev = netdev_priv(netdev);
+
+	return sysfs_emit(buf, "%08X\n", peak_dev->device_number);
+}
+static DEVICE_ATTR_RO(device_id);
+
 /*
  * dump memory
  */
@@ -887,6 +898,11 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	netdev_info(netdev, "attached to %s channel %u (device %u)\n",
 			peak_usb_adapter->name, ctrl_idx, dev->device_number);
 
+	err = device_create_file(&netdev->dev, &dev_attr_device_id);
+	/* Do not error out since device was configured successfully */
+	if (err)
+		netdev_warn(netdev, "unable to expose device_id via sysfs %d\n", err);
+
 	return 0;
 
 adap_dev_free:
@@ -923,6 +939,8 @@ static void peak_usb_disconnect(struct usb_interface *intf)
 		dev->state &= ~PCAN_USB_STATE_CONNECTED;
 		strlcpy(name, netdev->name, IFNAMSIZ);
 
+		device_remove_file(&netdev->dev, &dev_attr_device_id);
+
 		unregister_netdev(netdev);
 
 		kfree(dev->cmd_buf);
-- 
2.37.1

