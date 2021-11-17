Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA031454988
	for <lists+linux-can@lfdr.de>; Wed, 17 Nov 2021 16:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhKQPFL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 17 Nov 2021 10:05:11 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:7596 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232632AbhKQPFK (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 17 Nov 2021 10:05:10 -0500
Received: from localhost.localdomain (unknown [89.158.146.116])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 268B32003C3;
        Wed, 17 Nov 2021 16:02:07 +0100 (CET)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 6/6] can: peak_usb: add sysfs interface to internal device user value
Date:   Wed, 17 Nov 2021 16:01:32 +0100
Message-Id: <20211117150132.37056-7-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211117150132.37056-1-s.grosjean@peak-system.com>
References: <20211117150132.37056-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch adds under /sys/class/net/canX a new group named "peak_usb"
which contains a "dev_num" entry accessible for reading (display in
decimal of the numerical value stored in non-volatile memory of the USB
device) and also for writing (modification by the user of this value).

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 76 ++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index ad9f435fc57e..08d1db988d81 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -53,6 +53,17 @@ static const struct usb_device_id peak_usb_table[] = {
 
 MODULE_DEVICE_TABLE(usb, peak_usb_table);
 
+/* sysfs shortcuts */
+#define PEAK_USB_DEVICE_ATTR_RW(_name) \
+	struct device_attribute peak_usb_attr_##_name = \
+		__ATTR(_name, 0644, \
+		       peak_usb_##_name##_show, peak_usb_##_name##_store)
+
+#define PEAK_USB_DEVICE_ATTR_RO(_name) \
+	struct device_attribute peak_usb_attr_##_name = \
+		__ATTR(_name, 0444, \
+		       peak_usb_##_name##_show, NULL)
+
 /*
  * dump memory
  */
@@ -784,6 +795,61 @@ static const struct net_device_ops peak_usb_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static inline struct peak_usb_device *to_peak_usb_device(struct device *dev)
+{
+	return netdev_priv(to_net_dev(dev));
+}
+
+static ssize_t peak_usb_dev_num_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct peak_usb_device *pdev = to_peak_usb_device(dev);
+
+	if (!pdev->adapter->dev_get_user_devid)
+		return -EOPNOTSUPP;
+
+	pdev->adapter->dev_get_user_devid(pdev, &pdev->device_number);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", pdev->device_number);
+}
+
+static ssize_t peak_usb_dev_num_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct peak_usb_device *pdev = to_peak_usb_device(dev);
+	unsigned long devid;
+	int err;
+
+	if (!pdev->adapter->dev_set_user_devid)
+		return -EOPNOTSUPP;
+
+	err = kstrtoul(buf, 0, &devid);
+	if (err)
+		return err;
+
+	err = pdev->adapter->dev_set_user_devid(pdev, devid);
+	if (err)
+		return err;
+
+	/* on success, update cached value */
+	pdev->device_number = devid;
+
+	return count;
+}
+
+static PEAK_USB_DEVICE_ATTR_RW(dev_num);
+
+static const struct attribute *const peak_usb_net_attrs[] = {
+	&peak_usb_attr_dev_num.attr,
+	NULL,
+};
+
+static const struct attribute_group peak_usb_net_attrs_group = {
+	.name = PCAN_USB_DRIVER_NAME,
+	.attrs = (struct attribute **)peak_usb_net_attrs,
+};
+
 /*
  * create one device which is attached to CAN controller #ctrl_idx of the
  * usb adapter.
@@ -886,6 +952,12 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	if (dev->adapter->dev_get_user_devid)
 		dev->adapter->dev_get_user_devid(dev, &dev->device_number);
 
+	/* add our own attrs to /sys/class/net/canX node */
+	err = sysfs_create_group(&netdev->dev.kobj, &peak_usb_net_attrs_group);
+	if (err)
+		netdev_warn(netdev,
+			    "can't add sysfs features (err %d)\n", err);
+
 	netdev_info(netdev, "attached to %s channel %u (device %u)\n",
 			peak_usb_adapter->name, ctrl_idx, dev->device_number);
 
@@ -925,6 +997,9 @@ static void peak_usb_disconnect(struct usb_interface *intf)
 		dev->state &= ~PCAN_USB_STATE_CONNECTED;
 		strlcpy(name, netdev->name, IFNAMSIZ);
 
+		sysfs_remove_group(&netdev->dev.kobj,
+				   &peak_usb_net_attrs_group);
+
 		unregister_candev(netdev);
 
 		kfree(dev->cmd_buf);
@@ -958,6 +1033,7 @@ static int peak_usb_probe(struct usb_interface *intf,
 			return err;
 	}
 
+	/* create one CAN device for each CAN controller */
 	for (i = 0; i < peak_usb_adapter->ctrl_count; i++) {
 		err = peak_usb_create_dev(peak_usb_adapter, intf, i);
 		if (err) {
-- 
2.25.1

