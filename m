Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3025B588283
	for <lists+linux-can@lfdr.de>; Tue,  2 Aug 2022 21:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbiHBT3M (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 2 Aug 2022 15:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiHBT3L (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 2 Aug 2022 15:29:11 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F1A52DE5
        for <linux-can@vger.kernel.org>; Tue,  2 Aug 2022 12:29:09 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 10DBC240027
        for <linux-can@vger.kernel.org>; Tue,  2 Aug 2022 21:29:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1659468547; bh=jM07ySW23mf3GJ60dHBZTfUbRzcuCwf/YbjtHCHEXYk=;
        h=From:To:Cc:Subject:Date:From;
        b=rDGrnDBAONCh+rAAhOiafNBeONIxyJOSIEL3+4dGikKqQFOTB9NiA0Exeu0RDWs1f
         Z3eGARe5ym320/tq8m5cjc4lMHOWJ8Ux6Y7FSxBhyTfqm4n4KCxw9oNRPMVwu+xr1E
         frdE0Z3D8ZG2pW4zKmh+MdVDqGhTNlUd/lYNvIG4OpeaELciLvui/lhcPs4n1THdq4
         TlQxHfQPQVfeXV30jCPWXrXDhkxj8Q8jam6pU8ZUYOgIYxJpttMQZIokcXTH8ATlS7
         LY8ddeiLOfCuvUhlp03shQq6myD2GEQdpOfamHhzpKtbbL80oynb8O875ShGnP/Fsy
         AVeAu9SAVCFYg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Ly4mf1Pv3z9rxd;
        Tue,  2 Aug 2022 21:29:06 +0200 (CEST)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     linux-can@vger.kernel.org
Cc:     Lukas Magel <lukas.magel@posteo.net>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2] can: peak_usb: export PCAN device ID as sysfs device attribute
Date:   Tue,  2 Aug 2022 19:26:10 +0000
Message-Id: <20220802192608.42908-1-lukas.magel@posteo.net>
In-Reply-To: <CAMZ6RqJD4w_vpaSABdW26aySviVC9ECN4fsP2F+k3vP8GXg9pw@mail.gmail.com>
References: <CAMZ6RqJD4w_vpaSABdW26aySviVC9ECN4fsP2F+k3vP8GXg9pw@mail.gmail.com>
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

V2: Update netdev_warn to output the mnemonic of the error value

Signed-off-by: Lukas Magel <lukas.magel@posteo.net>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Thank you Vincent for the feedback. I updated the netdev_warn
accordingly.

 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 27b0a72fd885..7af3dd0a1b35 100644
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
+		netdev_warn(netdev, "unable to expose device_id via sysfs: %pe\n", ERR_PTR(err));
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

