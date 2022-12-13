Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64B964B0BC
	for <lists+linux-can@lfdr.de>; Tue, 13 Dec 2022 09:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbiLMIEp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 13 Dec 2022 03:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbiLMIEm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 13 Dec 2022 03:04:42 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6319B1057F
        for <linux-can@vger.kernel.org>; Tue, 13 Dec 2022 00:04:40 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 1B458240026
        for <linux-can@vger.kernel.org>; Tue, 13 Dec 2022 09:04:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1670918679; bh=fTapH+pdUPmT7qAjid5cBZYCXIUO9HC8JnYJutHMbFQ=;
        h=From:To:Cc:Subject:Date:From;
        b=nAhchOjLpl7TSgilF8QKA5uyNy8HqfSGB0RqR8rFgxhSDo+Xb/whyUfd/IvuMkITi
         W4s6kYp2DNgl0AVMyEULaPG0JbUfzPX8Oa0ggf5xBiuFds7WefAlG0iGrk+hbLIpuR
         rkRvHwxqjGZb24npnb9So4gnB07GGHpyNGcf/cTjhS91LzrIOF2mSj7iowW5CmygRh
         Jo+7wg6mBxlVVuUGPm91o7MpAbcF/4FOj3x7MjG7bkhusE3f6vG9d84nMAm3Cu1PwZ
         Xx8qNQmZfBVCBZJMOteVihEnwMhiEatPqRGYQJQuxLUNV1YNOQhVn+P5ODj+ImUHRc
         Q2PwwYMlH4bhA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4NWWHV3Pdkz6tmX;
        Tue, 13 Dec 2022 09:04:38 +0100 (CET)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     linux-can@vger.kernel.org
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Lukas Magel <lukas.magel@posteo.net>
Subject: [PATCH v3 5/8] can: peak_usb: add ethtool interface to user-configurable CAN channel identifier
Date:   Tue, 13 Dec 2022 08:03:07 +0000
Message-Id: <20221213080309.9013-6-lukas.magel@posteo.net>
In-Reply-To: <20220801080446.36374-1-lukas.magel@posteo.net>
References: <20220801080446.36374-1-lukas.magel@posteo.net>
Reply-To: Lukas Magel <lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Stephane Grosjean <s.grosjean@peak-system.com>

This patch introduces 3 new functions implementing support for ethtool
access to the CAN channel ID of all USB CAN network interfaces managed by
the driver. With this patch, it is possible to read/write the CAN
channel ID from/to the EEPROM via the ethtool interface.

The CAN channel ID is a user-configurable device identifier that can be
set individually for each CAN interface of a PEAK USB device. Depending on
the device, the identifier has a length of 8 or 32 bit. The identifier
is stored in the non-volatile memory of the device.

The identifier of a CAN interface can be read/written as an 8 or 32 bit
byte string in native (little-endian) byte order, where the length depends
on the device type.

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
index 92472149cfba..5a712a2beb5a 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -984,9 +984,18 @@ static int pcan_usb_set_phys_id(struct net_device *netdev,
 	return err;
 }
 
+/* This device only handles 8-bit CAN channel id. */
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
index 4eff4b4706b9..d5ebcee7b7ed 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -808,6 +808,86 @@ static const struct net_device_ops peak_usb_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
+/* CAN-USB devices generally handle 32-bit CAN channel IDs.
+ * In case one doesn't, then it have to overload this function.
+ */
+int peak_usb_get_eeprom_len(struct net_device *netdev)
+{
+	return sizeof(u32);
+}
+
+/* Every CAN-USB device exports the dev_get_can_channel_id() operation. It is used
+ * here to fill the data buffer with the user defined CAN channel ID.
+ */
+int peak_usb_get_eeprom(struct net_device *netdev,
+			struct ethtool_eeprom *eeprom, u8 *data)
+{
+	struct peak_usb_device *dev = netdev_priv(netdev);
+	u32 ch_id;
+	__le32 ch_id_le;
+	int err;
+
+	err = dev->adapter->dev_get_can_channel_id(dev, &ch_id);
+	if (err)
+		return err;
+
+	/* ethtool operates on individual bytes. The byte order of the CAN
+	 * channel id in memory depends on the kernel architecture. We
+	 * convert the CAN channel id back to the native byte order of the PEAK
+	 * device itself to ensure that the order is consistent for all
+	 * host architectures.
+	 */
+	ch_id_le = cpu_to_le32(ch_id);
+	memcpy(data, (u8 *)&ch_id_le + eeprom->offset, eeprom->len);
+
+	/* update cached value */
+	dev->can_channel_id = ch_id;
+	return err;
+}
+
+/* Every CAN-USB device exports the dev_get_can_channel_id()/dev_set_can_channel_id()
+ * operations. They are used here to set the new user defined CAN channel ID.
+ */
+int peak_usb_set_eeprom(struct net_device *netdev,
+			struct ethtool_eeprom *eeprom, u8 *data)
+{
+	struct peak_usb_device *dev = netdev_priv(netdev);
+	u32 ch_id;
+	__le32 ch_id_le;
+	int err;
+
+	/* first, read the current user defined CAN channel ID */
+	err = dev->adapter->dev_get_can_channel_id(dev, &ch_id);
+	if (err) {
+		netdev_err(netdev, "Failed to init CAN channel id (err %d)\n", err);
+		return err;
+	}
+
+	/* do update the value with user given bytes.
+	 * ethtool operates on individual bytes. The byte order of the CAN
+	 * channel ID in memory depends on the kernel architecture. We
+	 * convert the CAN channel ID back to the native byte order of the PEAK
+	 * device itself to ensure that the order is consistent for all
+	 * host architectures.
+	 */
+	ch_id_le = cpu_to_le32(ch_id);
+	memcpy((u8 *)&ch_id_le + eeprom->offset, data, eeprom->len);
+	ch_id = le32_to_cpu(ch_id_le);
+
+	/* flash the new value now */
+	err = dev->adapter->dev_set_can_channel_id(dev, ch_id);
+	if (err) {
+		netdev_err(netdev, "Failed to write new CAN channel id (err %d)\n",
+			   err);
+		return err;
+	}
+
+	/* update cached value with the new one */
+	dev->can_channel_id = ch_id;
+
+	return 0;
+}
+
 int pcan_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info)
 {
 	info->so_timestamping =
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index 1e461aef0f2a..980e315186cf 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -149,4 +149,10 @@ void peak_usb_async_complete(struct urb *urb);
 void peak_usb_restart_complete(struct peak_usb_device *dev);
 int pcan_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info);
 
+/* common 32-bit CAN channel ID ethtool management */
+int peak_usb_get_eeprom_len(struct net_device *netdev);
+int peak_usb_get_eeprom(struct net_device *netdev,
+			struct ethtool_eeprom *eeprom, u8 *data);
+int peak_usb_set_eeprom(struct net_device *netdev,
+			struct ethtool_eeprom *eeprom, u8 *data);
 #endif
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 1ea4cfdfd640..fd925ae96331 100644
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
index 061f04c20f96..0c805d9672bf 100644
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
2.38.1

