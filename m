Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B49608FC3
	for <lists+linux-can@lfdr.de>; Sat, 22 Oct 2022 23:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJVVgd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 22 Oct 2022 17:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJVVgb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 22 Oct 2022 17:36:31 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808ABF88DE
        for <linux-can@vger.kernel.org>; Sat, 22 Oct 2022 14:36:30 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 34A81240027
        for <linux-can@vger.kernel.org>; Sat, 22 Oct 2022 23:36:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1666474589; bh=/fMWu1oPJfWnhMGu1g2qHWt8lkkBVzPtIQhBhkQctwg=;
        h=From:To:Cc:Subject:Date:From;
        b=oq9+cjwKJFZ8N9FWUgS7t/j0jOFR8fdYCgowxLON2+L4mbIS7zU1hgYq9tpg7sIoO
         XUyvBU0ASjtC78HcuObZ3LN9DmdR/8KVV3UGSefu/lyVpM+/xHzyZK4A7Wsnhrm8NY
         vNKn4cI1KVqVDolDnRu1QKtMm3IkukiXMXiUCoasjvpeDQ94NXzO0CvnQDw6uhjN/d
         91yPBm3j/EiXHcdvS6sFPGmNhp4/Xob+J98NEKgwAdUEhq4AOZnr44sRf2qQEwTeUw
         bAhiJpaoicfhw2rBuUGnLP2wzYAAT1O0RrNrIYJu/k6kkuVxM7+uF2IfmMBarS+X55
         nXkVxINDSICQQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4MvvmD3xfkz9rxH;
        Sat, 22 Oct 2022 23:36:28 +0200 (CEST)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     linux-can@vger.kernel.org
Cc:     Lukas Magel <lukas.magel@posteo.net>,
        Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 6/7] can: peak_usb: export PCAN user device ID as sysfs device attribute
Date:   Sat, 22 Oct 2022 21:35:34 +0000
Message-Id: <20221022213535.8495-7-lukas.magel@posteo.net>
In-Reply-To: <20221022213535.8495-1-lukas.magel@posteo.net>
References: <20220801080446.36374-1-lukas.magel@posteo.net>
 <20221022213535.8495-1-lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch exports the user device ID as a sysfs attribute. This allows
users to easily read the ID and to write udev rules that can match against
the ID.

Signed-off-by: Lukas Magel <lukas.magel@posteo.net>
Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 .../ABI/testing/sysfs-class-net-peak_usb      | 15 ++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_core.c  | 30 +++++++++++++++++--
 2 files changed, 42 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-net-peak_usb

diff --git a/Documentation/ABI/testing/sysfs-class-net-peak_usb b/Documentation/ABI/testing/sysfs-class-net-peak_usb
new file mode 100644
index 000000000000..f7f23f9bdfde
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-net-peak_usb
@@ -0,0 +1,15 @@
+
+What:		/sys/class/net/<iface>/peak_usb/user_devid
+Date:		October 2022
+KernelVersion:	6.1
+Contact:	Stephane Grosjean <s.grosjean@peak-system.com>
+Description:
+		PEAK PCAN-USB devices support a user-configurable device
+		identifier. This attribute provides read-only access to the
+		currently configured value of the device identifier. Depending
+		on the device type, the identifier has a length of 8 or 32 bit.
+		The value read from this attribute is always an 8 digit 32 bit
+		hexadecimal value in big endian format. If the device only
+		supports an 8 bit identifier, the upper 24 bit of the value are
+		set to zero.
+
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 438788732c2c..fbefd4f05e08 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -8,13 +8,15 @@
  *
  * Many thanks to Klaus Hitschler <klaus.hitschler@gmx.de>
  */
+#include <linux/device.h>
+#include <linux/ethtool.h>
 #include <linux/init.h>
-#include <linux/signal.h>
-#include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/signal.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/usb.h>
-#include <linux/ethtool.h>
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
@@ -53,6 +55,25 @@ static const struct usb_device_id peak_usb_table[] = {
 
 MODULE_DEVICE_TABLE(usb, peak_usb_table);
 
+static ssize_t user_devid_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct net_device *netdev = to_net_dev(dev);
+	struct peak_usb_device *peak_dev = netdev_priv(netdev);
+
+	return sysfs_emit(buf, "%08X\n", peak_dev->user_devid);
+}
+static DEVICE_ATTR_RO(user_devid);
+
+static const struct attribute *peak_usb_sysfs_attrs[] = {
+	&dev_attr_user_devid.attr,
+	NULL,
+};
+
+static const struct attribute_group peak_usb_sysfs_group = {
+	.name	= "peak_usb",
+	.attrs	= (struct attribute **)peak_usb_sysfs_attrs,
+};
+
 /*
  * dump memory
  */
@@ -961,6 +982,9 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	/* add ethtool support */
 	netdev->ethtool_ops = peak_usb_adapter->ethtool_ops;
 
+	/* register peak_usb sysfs files */
+	netdev->sysfs_groups[0] = &peak_usb_sysfs_group;
+
 	init_usb_anchor(&dev->rx_submitted);
 
 	init_usb_anchor(&dev->tx_submitted);
-- 
2.37.2

