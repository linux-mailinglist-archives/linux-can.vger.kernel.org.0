Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBF333206A
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 09:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhCIIW0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 03:22:26 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:8814 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230147AbhCIIWL (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 9 Mar 2021 03:22:11 -0500
Received: from localhost.localdomain (unknown [89.158.142.148])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 3CB345FF9D;
        Tue,  9 Mar 2021 09:22:06 +0100 (CET)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 1/3] can/peak_usb: add support of ethtool set_phys_id()
Date:   Tue,  9 Mar 2021 09:21:26 +0100
Message-Id: <20210309082128.23125-2-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210309082128.23125-1-s.grosjean@peak-system.com>
References: <20210309082128.23125-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch makes it possible to specifically flash the LED of a CAN port
of the CAN-USB interfaces of PEAK-System.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      | 47 ++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |  4 ++
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  2 +
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 33 ++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 34 +++++++++++++-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h  |  6 +++
 6 files changed, 125 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index e6c1e5d33924..aa89c1119e27 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -11,6 +11,7 @@
 #include <linux/netdevice.h>
 #include <linux/usb.h>
 #include <linux/module.h>
+#include <linux/ethtool.h>
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
@@ -42,6 +43,7 @@ MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB adapter");
 #define PCAN_USB_CMD_REGISTER	9
 #define PCAN_USB_CMD_EXT_VCC	10
 #define PCAN_USB_CMD_ERR_FR	11
+#define PCAN_USB_CMD_LED	12
 
 /* PCAN_USB_CMD_SET_BUS number arg */
 #define PCAN_USB_BUS_XCVER		2
@@ -250,6 +252,15 @@ static int pcan_usb_set_ext_vcc(struct peak_usb_device *dev, u8 onoff)
 	return pcan_usb_send_cmd(dev, PCAN_USB_CMD_EXT_VCC, PCAN_USB_SET, args);
 }
 
+static int pcan_usb_set_led(struct peak_usb_device *dev, u8 onoff)
+{
+	u8 args[PCAN_USB_CMD_ARGS_LEN] = {
+		[0] = !!onoff,
+	};
+
+	return pcan_usb_send_cmd(dev, PCAN_USB_CMD_LED, PCAN_USB_SET, args);
+}
+
 /*
  * set bittiming value to can
  */
@@ -973,6 +984,40 @@ static int pcan_usb_probe(struct usb_interface *intf)
 	return 0;
 }
 
+static int pcan_usb_set_phys_id(struct net_device *netdev,
+				enum ethtool_phys_id_state state)
+{
+	struct peak_usb_device *dev = netdev_priv(netdev);
+	int err = 0;
+
+	switch (state) {
+	case ETHTOOL_ID_ACTIVE:
+		/* call ON/OFF twice a second */
+		return 2;
+
+	case ETHTOOL_ID_OFF:
+		err = pcan_usb_set_led(dev, 0);
+		break;
+
+	case ETHTOOL_ID_ON:
+		fallthrough;
+
+	case ETHTOOL_ID_INACTIVE:
+		/* restore LED default */
+		err = pcan_usb_set_led(dev, 1);
+		break;
+
+	default:
+		break;
+	}
+
+	return err;
+}
+
+static const struct ethtool_ops pcan_usb_ethtool_ops = {
+	.set_phys_id = pcan_usb_set_phys_id,
+};
+
 /*
  * describe the PCAN-USB adapter
  */
@@ -1003,6 +1048,8 @@ const struct peak_usb_adapter pcan_usb = {
 	/* size of device private data */
 	.sizeof_dev_private = sizeof(struct pcan_usb),
 
+	.ethtool_ops = &pcan_usb_ethtool_ops,
+
 	/* timestamps usage */
 	.ts_used_bits = 16,
 	.ts_period = 24575, /* calibration period in ts. */
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 573b11559d73..685c59e2cfd3 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/usb.h>
+#include <linux/ethtool.h>
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
@@ -820,6 +821,9 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 
 	netdev->flags |= IFF_ECHO; /* we support local echo */
 
+	/* add ethtool support */
+	netdev->ethtool_ops = peak_usb_adapter->ethtool_ops;
+
 	init_usb_anchor(&dev->rx_submitted);
 
 	init_usb_anchor(&dev->tx_submitted);
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index 4b1528a42a7b..e15b4c78f309 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -46,6 +46,8 @@ struct peak_usb_adapter {
 	const struct can_bittiming_const * const data_bittiming_const;
 	unsigned int ctrl_count;
 
+	const struct ethtool_ops *ethtool_ops;
+
 	int (*intf_probe)(struct usb_interface *intf);
 
 	int (*dev_init)(struct peak_usb_device *dev);
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index f347ecc79aef..6183a42f6491 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -7,6 +7,7 @@
 #include <linux/netdevice.h>
 #include <linux/usb.h>
 #include <linux/module.h>
+#include <linux/ethtool.h>
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
@@ -1009,6 +1010,31 @@ static void pcan_usb_fd_free(struct peak_usb_device *dev)
 	}
 }
 
+/* blink LED's */
+static int pcan_usb_fd_set_phys_id(struct net_device *netdev,
+				   enum ethtool_phys_id_state state)
+{
+	struct peak_usb_device *dev = netdev_priv(netdev);
+	int err = 0;
+
+	switch (state) {
+	case ETHTOOL_ID_ACTIVE:
+		err = pcan_usb_fd_set_can_led(dev, PCAN_UFD_LED_FAST);
+		break;
+	case ETHTOOL_ID_INACTIVE:
+		err = pcan_usb_fd_set_can_led(dev, PCAN_UFD_LED_DEF);
+		break;
+	default:
+		break;
+	}
+
+	return err;
+}
+
+static const struct ethtool_ops pcan_usb_fd_ethtool_ops = {
+	.set_phys_id = pcan_usb_fd_set_phys_id,
+};
+
 /* describes the PCAN-USB FD adapter */
 static const struct can_bittiming_const pcan_usb_fd_const = {
 	.name = "pcan_usb_fd",
@@ -1050,6 +1076,8 @@ const struct peak_usb_adapter pcan_usb_fd = {
 	/* size of device private data */
 	.sizeof_dev_private = sizeof(struct pcan_usb_fd_device),
 
+	.ethtool_ops = &pcan_usb_fd_ethtool_ops,
+
 	/* timestamps usage */
 	.ts_used_bits = 32,
 	.ts_period = 1000000, /* calibration period in ts. */
@@ -1122,6 +1150,7 @@ const struct peak_usb_adapter pcan_usb_chip = {
 
 	/* size of device private data */
 	.sizeof_dev_private = sizeof(struct pcan_usb_fd_device),
+	.ethtool_ops = &pcan_usb_fd_ethtool_ops,
 
 	/* timestamps usage */
 	.ts_used_bits = 32,
@@ -1196,6 +1225,8 @@ const struct peak_usb_adapter pcan_usb_pro_fd = {
 	/* size of device private data */
 	.sizeof_dev_private = sizeof(struct pcan_usb_fd_device),
 
+	.ethtool_ops = &pcan_usb_fd_ethtool_ops,
+
 	/* timestamps usage */
 	.ts_used_bits = 32,
 	.ts_period = 1000000, /* calibration period in ts. */
@@ -1269,6 +1300,8 @@ const struct peak_usb_adapter pcan_usb_x6 = {
 	/* size of device private data */
 	.sizeof_dev_private = sizeof(struct pcan_usb_fd_device),
 
+	.ethtool_ops = &pcan_usb_fd_ethtool_ops,
+
 	/* timestamps usage */
 	.ts_used_bits = 32,
 	.ts_period = 1000000, /* calibration period in ts. */
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 275087c39602..ff740b4203fa 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -9,6 +9,7 @@
 #include <linux/netdevice.h>
 #include <linux/usb.h>
 #include <linux/module.h>
+#include <linux/ethtool.h>
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
@@ -908,7 +909,7 @@ static int pcan_usb_pro_init(struct peak_usb_device *dev)
 	usb_if->dev[dev->ctrl_idx] = dev;
 
 	/* set LED in default state (end of init phase) */
-	pcan_usb_pro_set_led(dev, 0, 1);
+	pcan_usb_pro_set_led(dev, FW_USBPRO_LED_DEVICE, 1);
 
 	kfree(bi);
 	kfree(fi);
@@ -992,6 +993,35 @@ int pcan_usb_pro_probe(struct usb_interface *intf)
 	return 0;
 }
 
+static int pcan_usb_pro_set_phys_id(struct net_device *netdev,
+				    enum ethtool_phys_id_state state)
+{
+	struct peak_usb_device *dev = netdev_priv(netdev);
+	int err = 0;
+
+	switch (state) {
+	case ETHTOOL_ID_ACTIVE:
+		/* fast blinking forever */
+		err = pcan_usb_pro_set_led(dev, FW_USBPRO_LED_BLINK_FAST,
+					   0xffffffff);
+		break;
+
+	case ETHTOOL_ID_INACTIVE:
+		/* restore LED default */
+		err = pcan_usb_pro_set_led(dev, FW_USBPRO_LED_DEVICE, 1);
+		break;
+
+	default:
+		break;
+	}
+
+	return err;
+}
+
+static const struct ethtool_ops pcan_usb_pro_ethtool_ops = {
+	.set_phys_id = pcan_usb_pro_set_phys_id,
+};
+
 /*
  * describe the PCAN-USB Pro adapter
  */
@@ -1020,6 +1050,8 @@ const struct peak_usb_adapter pcan_usb_pro = {
 	/* size of device private data */
 	.sizeof_dev_private = sizeof(struct pcan_usb_pro_device),
 
+	.ethtool_ops = &pcan_usb_pro_ethtool_ops,
+
 	/* timestamps usage */
 	.ts_used_bits = 32,
 	.ts_period = 1000000, /* calibration period in ts. */
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
index 6bb12357d078..421104ee29f4 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
@@ -115,6 +115,12 @@ struct __packed pcan_usb_pro_devid {
 	__le32 serial_num;
 };
 
+#define FW_USBPRO_LED_DEVICE		0x00
+#define FW_USBPRO_LED_BLINK_FAST	0x01
+#define FW_USBPRO_LED_BLINK_SLOW	0x02
+#define FW_USBPRO_LED_ON		0x03
+#define FW_USBPRO_LED_OFF		0x04
+
 struct __packed pcan_usb_pro_setled {
 	u8  data_type;
 	u8  channel;
-- 
2.25.1

