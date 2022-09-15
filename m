Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECE75B9863
	for <lists+linux-can@lfdr.de>; Thu, 15 Sep 2022 11:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiIOJ7x (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 15 Sep 2022 05:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiIOJ7S (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 15 Sep 2022 05:59:18 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C469C8EE
        for <linux-can@vger.kernel.org>; Thu, 15 Sep 2022 02:55:54 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 74C7A240047
        for <linux-can@vger.kernel.org>; Thu, 15 Sep 2022 11:55:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1663235750; bh=Hu/pY0EZa7Rv4kbZeJ8fhheZTN5pXGf0BswvSDE+Yxk=;
        h=From:To:Cc:Subject:Date:From;
        b=ry1A8lzGZPQKys11OWn7sEzB7A2wbIrnPuaPZfZ/kWdUELD7ldQ0gi1fc6RMWIZcD
         nrayFO6YahzCNQwpe6Jvh1lP0THFuJrvUcrsYXcMyoxy1hs+scjZOL+tscxovEDqLl
         9pvZOS5YxWAx7HP0PS9KLViIa0MY5Non7LJMJIB+Rf/xdlaLMwGQmP6GkdaULjYHAS
         o4Xvl03YM13cLYdeEcLDISvIAFf7Vz141iMdh6gAnIbG9rE0VTPhwbtDbO+IuTqVEw
         pnqzn57hbJX4jymPGsTgYUQTAU5MI1k06BUcqgIRLW9S0g/DRKc9/ExNiiKgoocak0
         RKtY7dC/ZmE/g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4MSsys5b28z9rxG;
        Thu, 15 Sep 2022 11:55:49 +0200 (CEST)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     linux-can@vger.kernel.org
Cc:     Lukas Magel <lukas.magel@posteo.net>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [RESEND PATCH v2] can: peak_usb: export PCAN device ID as sysfs device attribute
Date:   Thu, 15 Sep 2022 09:54:10 +0000
Message-Id: <20220915095410.31854-1-lukas.magel@posteo.net>
In-Reply-To: <20220801080446.36374-1-lukas.magel@posteo.net>
References: <20220801080446.36374-1-lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Signed-off-by: Lukas Magel <lukas.magel@posteo.net>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC: Stephane Grosjean <s.grosjean@peak-system.com>
---
V2: Update netdev_warn to output the mnemonic of the error value

Resubmission of the patch. Also added Stéphane as maintainer in CC.

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

