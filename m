Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413C766CFE8
	for <lists+linux-can@lfdr.de>; Mon, 16 Jan 2023 21:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjAPUMD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 16 Jan 2023 15:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjAPUMC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 16 Jan 2023 15:12:02 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265FB23DB9
        for <linux-can@vger.kernel.org>; Mon, 16 Jan 2023 12:12:00 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id D2DDF2401AC
        for <linux-can@vger.kernel.org>; Mon, 16 Jan 2023 21:11:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1673899918; bh=BFF7kO0IoI38nqI5M4EZqyYJwfk/vy4W/awD/s27f4o=;
        h=From:To:Cc:Subject:Date:From;
        b=Ba5H4fZ+Zaoyv4KoF1h3mxPn8zgMwBn9A7HdBPvoIQVn8uyrGzNX2toE+H8NUP2he
         WZNh5YRFemLzsqWmhPT3o9A6KPsTV3zV5SHgavaugHrlYbh472sxIkcxSHmhwucNEx
         4AJZwAdQNMlU6VgzxWJRhruDiMFVB2tIRawn75S5X5iDQyaLfCVHjL76pyNiIz7Tg+
         1fWntIoCy5jm7BVxJYdG5XMMt2Ma0ExBhekaRFtxvhhpbKXV1BQegqV0kA1DSPURhH
         oJGWkiEDTJVqwR2D35q2cquGpVT5PajE8Tw9jmp+IMTtSjTMTbutwspWQrACwvjM4E
         c4AavCCbiBYhg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Nwjq21TWpz9rxB;
        Mon, 16 Jan 2023 21:11:58 +0100 (CET)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     linux-can@vger.kernel.org
Cc:     Lukas Magel <lukas.magel@posteo.net>,
        Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH v3 6/8] can: peak_usb: export PCAN CAN channel ID as sysfs device attribute
Date:   Mon, 16 Jan 2023 20:09:30 +0000
Message-Id: <20230116200932.157769-7-lukas.magel@posteo.net>
In-Reply-To: <20230116200932.157769-1-lukas.magel@posteo.net>
References: <20220801080446.36374-1-lukas.magel@posteo.net>
 <20230116200932.157769-1-lukas.magel@posteo.net>
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

This patch exports the CAN channel ID as a sysfs attribute. The CAN
channel ID is a user-configurable u8/u32 identifier that can be set
individually for each CAN interface of a PEAK USB device.

Exporting the channel ID as a sysfs attribute allows users to easily read
the ID and to write udev rules that can match against the ID. This is
especially useful for PEAK USB devices that do not export a serial
number at SUB level.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Lukas Magel <lukas.magel@posteo.net>
---
 .../ABI/testing/sysfs-class-net-peak_usb      | 19 ++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_core.c  | 25 +++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-net-peak_usb

diff --git a/Documentation/ABI/testing/sysfs-class-net-peak_usb b/Documentation/ABI/testing/sysfs-class-net-peak_usb
new file mode 100644
index 000000000000..9e3d0bf4d4b2
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-net-peak_usb
@@ -0,0 +1,19 @@
+
+What:		/sys/class/net/<iface>/peak_usb/can_channel_id
+Date:		November 2022
+KernelVersion:	6.2
+Contact:	Stephane Grosjean <s.grosjean@peak-system.com>
+Description:
+		PEAK PCAN-USB devices support user-configurable CAN channel
+		identifiers. Contrary to a USB serial number, these identifiers
+		are writable and can be set per CAN interface. This means that
+		if a USB device exports multiple CAN interfaces, each of them
+		can be assigned a unique channel ID.
+		This attribute provides read-only access to the currently
+		configured value of the channel identifier. Depending on the
+		device type, the identifier has a length of 8 or 32 bit. The
+		value read from this attribute is always an 8 digit 32 bit
+		hexadecimal value in big endian format. If the device only
+		supports an 8 bit identifier, the upper 24 bit of the value are
+		set to zero.
+
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index d5ebcee7b7ed..89ad5fda19c6 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -15,6 +15,8 @@
 #include <linux/netdevice.h>
 #include <linux/usb.h>
 #include <linux/ethtool.h>
+#include <linux/sysfs.h>
+#include <linux/device.h>
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
@@ -53,6 +55,26 @@ static const struct usb_device_id peak_usb_table[] = {
 
 MODULE_DEVICE_TABLE(usb, peak_usb_table);
 
+static ssize_t can_channel_id_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct net_device *netdev = to_net_dev(dev);
+	struct peak_usb_device *peak_dev = netdev_priv(netdev);
+
+	return sysfs_emit(buf, "%08X\n", peak_dev->can_channel_id);
+}
+static DEVICE_ATTR_RO(can_channel_id);
+
+/* mutable to avoid cast in attribute_group */
+static struct attribute *peak_usb_sysfs_attrs[] = {
+	&dev_attr_can_channel_id.attr,
+	NULL,
+};
+
+static const struct attribute_group peak_usb_sysfs_group = {
+	.name	= "peak_usb",
+	.attrs	= peak_usb_sysfs_attrs,
+};
+
 /*
  * dump memory
  */
@@ -961,6 +983,9 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	/* add ethtool support */
 	netdev->ethtool_ops = peak_usb_adapter->ethtool_ops;
 
+	/* register peak_usb sysfs files */
+	netdev->sysfs_groups[0] = &peak_usb_sysfs_group;
+
 	init_usb_anchor(&dev->rx_submitted);
 
 	init_usb_anchor(&dev->tx_submitted);
-- 
2.38.1

