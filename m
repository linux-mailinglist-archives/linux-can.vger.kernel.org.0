Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E2A4D441C
	for <lists+linux-can@lfdr.de>; Thu, 10 Mar 2022 10:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiCJKAR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 10 Mar 2022 05:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240832AbiCJKAP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Mar 2022 05:00:15 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4525C1111BC
        for <linux-can@vger.kernel.org>; Thu, 10 Mar 2022 01:59:13 -0800 (PST)
Received: from localhost.localdomain (unknown [89.158.146.116])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id B0742200381;
        Thu, 10 Mar 2022 10:59:09 +0100 (CET)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 6/8 v3] can: peak_usb: add ethtool interface to user defined flashed device number
Date:   Thu, 10 Mar 2022 10:58:39 +0100
Message-Id: <20220310095841.9134-7-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310095841.9134-1-s.grosjean@peak-system.com>
References: <20220310095841.9134-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch introduces 3 new functions implementing support for eeprom
access of USB - CAN network interfaces managed by the driver, through the
ethtool interface. All of them (except the PCAN-USB interface) interpret
the 4 data bytes as a 32-bit (little-endian) value to be read/write in the
non-volatile memory of the device. The PCAN-USB only manages a single byte
value.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      | 10 ++++
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 63 ++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  6 ++
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   |  3 +
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  |  4 ++
 5 files changed, 86 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index af3a2dcb5abc..14cc37c641f6 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -982,8 +982,18 @@ static int pcan_usb_set_phys_id(struct net_device *netdev,
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
+
+	.get_eeprom_len	= pcan_usb_get_eeprom_len,
+	.get_eeprom = peak_usb_get_eeprom,
+	.set_eeprom = peak_usb_set_eeprom,
 };
 
 /*
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 2c5452f6328c..338a7eb3f8fc 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -782,6 +782,69 @@ static const struct net_device_ops peak_usb_netdev_ops = {
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
+	__le32 ledevid;
+	int err;
+
+	err = dev->adapter->dev_get_user_devid(dev, &ledevid);
+	if (err)
+		return err;
+
+	/* 32-bit device id is stored in little-endian format in non-volatile
+	 * memory. This is why it is presented in this way to ethtool.
+	 */
+	memcpy(data, (u8 *)&ledevid + eeprom->offset, eeprom->len);
+
+	return 0;
+}
+
+/* Every CAN-USB device exports the dev_get_user_devid()/dev_set_user_devid()
+ * operations. They are used here to set the new user defined device number.
+ */
+int peak_usb_set_eeprom(struct net_device *netdev,
+			struct ethtool_eeprom *eeprom, u8 *data)
+{
+	struct peak_usb_device *dev = netdev_priv(netdev);
+	__le32 ledevid;
+	int err;
+
+	/* first, read the current user defined device value number */
+	err = dev->adapter->dev_get_user_devid(dev, &ledevid);
+	if (err) {
+		netdev_err(netdev, "Failed to init device id (err %d)\n", err);
+		return err;
+	}
+
+	/* do update the value with user given bytes */
+	memcpy((u8 *)&ledevid + eeprom->offset, data, eeprom->len);
+
+	/* flash the new value now */
+	err = dev->adapter->dev_set_user_devid(dev, ledevid);
+	if (err) {
+		netdev_err(netdev, "Failed to write new device id (err %d)\n",
+			   err);
+		return err;
+	}
+
+	/* update cached value with the new one */
+	netdev->dev_port = le32_to_cpu(ledevid);
+	return 0;
+}
+
 /*
  * create one device which is attached to CAN controller #ctrl_idx of the
  * usb adapter.
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index 2d2f53edc6a2..a181684474fc 100644
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
index d0b9c9f5357f..61f0e5b3916f 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -1075,6 +1075,9 @@ static int pcan_usb_fd_set_phys_id(struct net_device *netdev,
 
 static const struct ethtool_ops pcan_usb_fd_ethtool_ops = {
 	.set_phys_id = pcan_usb_fd_set_phys_id,
+	.get_eeprom_len	= peak_usb_get_eeprom_len,
+	.get_eeprom = peak_usb_get_eeprom,
+	.set_eeprom = peak_usb_set_eeprom,
 };
 
 /* describes the PCAN-USB FD adapter */
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 9b394277ec2e..5c2177a677d6 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -1036,6 +1036,10 @@ static int pcan_usb_pro_set_phys_id(struct net_device *netdev,
 
 static const struct ethtool_ops pcan_usb_pro_ethtool_ops = {
 	.set_phys_id = pcan_usb_pro_set_phys_id,
+
+	.get_eeprom_len	= peak_usb_get_eeprom_len,
+	.get_eeprom = peak_usb_get_eeprom,
+	.set_eeprom = peak_usb_set_eeprom,
 };
 
 /*
-- 
2.25.1

