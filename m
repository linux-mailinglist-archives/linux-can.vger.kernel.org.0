Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392EC608FC2
	for <lists+linux-can@lfdr.de>; Sat, 22 Oct 2022 23:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiJVVgb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 22 Oct 2022 17:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJVVg3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 22 Oct 2022 17:36:29 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48A5F709D
        for <linux-can@vger.kernel.org>; Sat, 22 Oct 2022 14:36:28 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 6A87C240101
        for <linux-can@vger.kernel.org>; Sat, 22 Oct 2022 23:36:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1666474587; bh=L177tQ0bnI6dmlpDk5lOMeKUURjb7pL9H8MmY9SoH1g=;
        h=From:To:Cc:Subject:Date:From;
        b=Wab6qs5TRdmLA0r95SZqRVg25d9ufgwMZ1f1p0ejS9EGV0PSGRsRHuxuSotrci/YP
         xU+6IRs2SS2kVHERyyt+Pg6DAkCbBXwlm6WLMsLGk6Vcp2pWwbZLu0meYGDMhPtxiE
         Oz17TCA8XU0KcUzhlipc6o7Zt+1viLXuyrfabDySD9jaY7p1RO/JcQKpoQ65/oLB15
         Dn8EvKh9rAM91hMSNNMt/Fd+4xyRhPCOP/ZrB7uePkqZ45iN7csFx7v8UUS3jkZkAA
         anfzNKhRe4QIKvSmxxnJIEcpjcuPqvtu7lWJbSANH+2bnLn2cXH17fKknvDoESjZJe
         jRJz2ozZyETjQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4MvvmB6JPDz9rxH;
        Sat, 22 Oct 2022 23:36:26 +0200 (CEST)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     linux-can@vger.kernel.org
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Lukas Magel <lukas.magel@posteo.net>
Subject: [PATCH 5/7] can: peak_usb: add ethtool interface to user defined flashed device number
Date:   Sat, 22 Oct 2022 21:35:33 +0000
Message-Id: <20221022213535.8495-6-lukas.magel@posteo.net>
In-Reply-To: <20221022213535.8495-1-lukas.magel@posteo.net>
References: <20220801080446.36374-1-lukas.magel@posteo.net>
 <20221022213535.8495-1-lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Stephane Grosjean <s.grosjean@peak-system.com>

This patch introduces 3 new functions implementing support for eeprom
access of USB - CAN network interfaces managed by the driver, through the
ethtool interface. All of them (except the PCAN-USB interface) interpret
the 4 data bytes as a 32-bit value to be read/write in the non-volatile
memory of the device. The PCAN-USB only manages a single byte value.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Lukas Magel <lukas.magel@posteo.net>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      |  9 +++
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 80 ++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  6 ++
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   |  3 +
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  |  3 +
 5 files changed, 101 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 6c01b2c6212b..d205da827016 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -984,9 +984,18 @@ static int pcan_usb_set_phys_id(struct net_device *netdev,
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
 	.get_ts_info = pcan_get_ts_info,
+	.get_eeprom_len	= pcan_usb_get_eeprom_len,
+	.get_eeprom = peak_usb_get_eeprom,
+	.set_eeprom = peak_usb_set_eeprom,
 };
 
 /*
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index b010b546f6d1..438788732c2c 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -808,6 +808,86 @@ static const struct net_device_ops peak_usb_netdev_ops = {
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
+	u32 devid_le;
+	int err;
+
+	err = dev->adapter->dev_get_user_devid(dev, &devid);
+	if (err)
+		return err;
+
+	/* ethtool operates on individual bytes. The byte order of the user
+	 * device id in memory depends on the kernel architecture. We
+	 * convert the user device id back to the native byte order of the PEAK
+	 * device itself to ensure that the order is consistent for all
+	 * host architectures.
+	 */
+	devid_le = cpu_to_le32(devid);
+	memcpy(data, (u8 *)&devid_le + eeprom->offset, eeprom->len);
+
+	/* update cached value */
+	dev->user_devid = devid;
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
+	u32 devid_le;
+	int err;
+
+	/* first, read the current user defined device value number */
+	err = dev->adapter->dev_get_user_devid(dev, &devid);
+	if (err) {
+		netdev_err(netdev, "Failed to init device id (err %d)\n", err);
+		return err;
+	}
+
+	/* do update the value with user given bytes.
+	 * ethtool operates on individual bytes. The byte order of the user
+	 * device id in memory depends on the kernel architecture. We
+	 * convert the user device id back to the native byte order of the PEAK
+	 * device itself to ensure that the order is consistent for all
+	 * host architectures.
+	 */
+	devid_le = cpu_to_le32(devid);
+	memcpy((u8 *)&devid_le + eeprom->offset, data, eeprom->len);
+	devid = le32_to_cpu(devid_le);
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
+	dev->user_devid = devid;
+
+	return 0;
+}
+
 int pcan_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info)
 {
 	info->so_timestamping =
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index d9c9e333c47a..a4a43edc0456 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -148,4 +148,10 @@ void peak_usb_async_complete(struct urb *urb);
 void peak_usb_restart_complete(struct peak_usb_device *dev);
 int pcan_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info);
 
+/* common 32-bit devid ethtool management */
+int peak_usb_get_eeprom_len(struct net_device *netdev);
+int peak_usb_get_eeprom(struct net_device *netdev,
+			struct ethtool_eeprom *eeprom, u8 *data);
+int peak_usb_set_eeprom(struct net_device *netdev,
+			struct ethtool_eeprom *eeprom, u8 *data);
 #endif
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 1f5ad0dc2b1c..5188915c4299 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -1124,6 +1124,9 @@ static int pcan_usb_fd_set_phys_id(struct net_device *netdev,
 static const struct ethtool_ops pcan_usb_fd_ethtool_ops = {
 	.set_phys_id = pcan_usb_fd_set_phys_id,
 	.get_ts_info = pcan_get_ts_info,
+	.get_eeprom_len	= peak_usb_get_eeprom_len,
+	.get_eeprom = peak_usb_get_eeprom,
+	.set_eeprom = peak_usb_set_eeprom,
 };
 
 /* describes the PCAN-USB FD adapter */
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index d3731c5aa4ed..d45e6562a4bb 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -1037,6 +1037,9 @@ static int pcan_usb_pro_set_phys_id(struct net_device *netdev,
 static const struct ethtool_ops pcan_usb_pro_ethtool_ops = {
 	.set_phys_id = pcan_usb_pro_set_phys_id,
 	.get_ts_info = pcan_get_ts_info,
+	.get_eeprom_len	= peak_usb_get_eeprom_len,
+	.get_eeprom = peak_usb_get_eeprom,
+	.set_eeprom = peak_usb_set_eeprom,
 };
 
 /*
-- 
2.37.2

