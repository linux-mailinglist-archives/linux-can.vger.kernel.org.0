Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D010C49FC5B
	for <lists+linux-can@lfdr.de>; Fri, 28 Jan 2022 16:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343959AbiA1PC3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 28 Jan 2022 10:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245734AbiA1PC3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 28 Jan 2022 10:02:29 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA5AC061714
        for <linux-can@vger.kernel.org>; Fri, 28 Jan 2022 07:02:29 -0800 (PST)
Received: from localhost.localdomain (unknown [89.158.146.116])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id BC917200414;
        Fri, 28 Jan 2022 16:02:25 +0100 (CET)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 6/6] can: peak_usb: add ethtool interface to user defined flashed device number
Date:   Fri, 28 Jan 2022 16:01:57 +0100
Message-Id: <20220128150157.1222850-7-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128150157.1222850-1-s.grosjean@peak-system.com>
References: <20220128150157.1222850-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch introduces 3 new functions implementing support for eeprom
access of USB - CAN network interfaces managed by the driver, through the
ethtool interface. All of them (except the PCAN-USB interface) interpret
the 4 data bytes as a 32-bit value to be read/write in the non-volatile
memory of the device. The PCAN-USB only manages a single byte value.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      |  9 +++
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 69 ++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  6 ++
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   |  3 +
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  |  3 +
 5 files changed, 90 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index b29daaab2e6e..60c9329701a5 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -981,8 +981,17 @@ static int pcan_usb_set_phys_id(struct net_device *netdev,
 	return err;
 }
 
+/* This device only handles 8-bit user device id. */
+static int pcan_usb_get_eeprom_len(struct net_device *netdev)
+{
+	return sizeof(u8);
+}
+
 static const struct ethtool_ops pcan_usb_ethtool_ops = {
 	.set_phys_id = pcan_usb_set_phys_id,
+	.get_eeprom_len	= pcan_usb_get_eeprom_len,
+	.get_eeprom = peak_usb_get_eeprom,
+	.set_eeprom = peak_usb_set_eeprom,
 };
 
 /*
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index aa8bcdcfa2fb..4e858d592e59 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -782,6 +782,75 @@ static const struct net_device_ops peak_usb_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
+/* CAN-USB devices generally handle 32-bit user device id.
+ * In case one doesn't, then it have to overload this function.
+ */
+int peak_usb_get_eeprom_len(struct net_device *netdev)
+{
+	return sizeof(u32);
+}
+
+/* Every CAN-USB device exports the dev_get_user_devid() operation. It is used
+ * here to fill the data buffer with the user defined device number.
+ */
+int peak_usb_get_eeprom(struct net_device *netdev,
+			struct ethtool_eeprom *eeprom, u8 *data)
+{
+	struct peak_usb_device *dev = netdev_priv(netdev);
+	u32 devid;
+	int err;
+
+	if (!eeprom->len)
+		return -EINVAL;
+
+	err = dev->adapter->dev_get_user_devid(dev, &devid);
+	if (!err) {
+		memcpy(data, (u8 *)&devid + eeprom->offset, eeprom->len);
+
+		/* update cached value */
+		dev->device_number = devid;
+	}
+
+	return err;
+}
+
+/* Every CAN-USB device exports the dev_get_user_devid()/dev_set_user_devid()
+ * operations. They are used here to set the new user defined device number.
+ */
+int peak_usb_set_eeprom(struct net_device *netdev,
+			struct ethtool_eeprom *eeprom, u8 *data)
+{
+	struct peak_usb_device *dev = netdev_priv(netdev);
+	u32 devid;
+	int err;
+
+	if (!eeprom->len)
+		return -EINVAL;
+
+	/* first, read the current user defined device value number */
+	err = dev->adapter->dev_get_user_devid(dev, &devid);
+	if (err) {
+		netdev_err(netdev, "Failed to init device id (err %d)\n", err);
+		return err;
+	}
+
+	/* do update the value with user given bytes */
+	memcpy((u8 *)&devid + eeprom->offset, data, eeprom->len);
+
+	/* flash the new value now */
+	err = dev->adapter->dev_set_user_devid(dev, devid);
+	if (err) {
+		netdev_err(netdev, "Failed to write new device id (err %d)\n",
+			   err);
+		return err;
+	}
+
+	/* update cached value with the new one */
+	dev->device_number = devid;
+
+	return 0;
+}
+
 /*
  * create one device which is attached to CAN controller #ctrl_idx of the
  * usb adapter.
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index 7fdc779986f0..4f4394733208 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -147,4 +147,10 @@ int peak_usb_netif_rx_64(struct sk_buff *skb, u32 ts_low, u32 ts_high);
 void peak_usb_async_complete(struct urb *urb);
 void peak_usb_restart_complete(struct peak_usb_device *dev);
 
+/* common 32-bit devid ethtool management */
+int peak_usb_get_eeprom_len(struct net_device *netdev);
+int peak_usb_get_eeprom(struct net_device *netdev,
+			struct ethtool_eeprom *eeprom, u8 *data);
+int peak_usb_set_eeprom(struct net_device *netdev,
+			struct ethtool_eeprom *eeprom, u8 *data);
 #endif
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 7440d5b145b5..cec09c7ffce2 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -1072,6 +1072,9 @@ static int pcan_usb_fd_set_phys_id(struct net_device *netdev,
 
 static const struct ethtool_ops pcan_usb_fd_ethtool_ops = {
 	.set_phys_id = pcan_usb_fd_set_phys_id,
+	.get_eeprom_len	= peak_usb_get_eeprom_len,
+	.get_eeprom = peak_usb_get_eeprom,
+	.set_eeprom = peak_usb_set_eeprom,
 };
 
 /* describes the PCAN-USB FD adapter */
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index e98b08746e04..35177a3d1eba 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -1036,6 +1036,9 @@ static int pcan_usb_pro_set_phys_id(struct net_device *netdev,
 
 static const struct ethtool_ops pcan_usb_pro_ethtool_ops = {
 	.set_phys_id = pcan_usb_pro_set_phys_id,
+	.get_eeprom_len	= peak_usb_get_eeprom_len,
+	.get_eeprom = peak_usb_get_eeprom,
+	.set_eeprom = peak_usb_set_eeprom,
 };
 
 /*
-- 
2.25.1

