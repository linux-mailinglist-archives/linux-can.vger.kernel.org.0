Return-Path: <linux-can+bounces-4178-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA702B121D6
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 18:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0E11CE24FC
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 16:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BEB2EF293;
	Fri, 25 Jul 2025 16:21:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE39C2E5B2B
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460479; cv=none; b=psFsboBOQ1l0CySKnaLxCMrvRe+jnJAPaTDgQCckcPZd7CXDZppVRrzKPbK1FWoXLe2eEh1FHHu5VMkP4/8cmIQuFXl35lk9UN/DDb9ElNwNFySXkPUykwBunZAMMc6ctSvJ9G1f+jmKEaPmBbkcWiyCbyCdHnT4yS5V89Ke1q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460479; c=relaxed/simple;
	bh=/KQX1/AhAsPubYUpPgr9z8RtjuX/g6YVm4qiVW8Drus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NU6UCYzwwRY36wkT4dTz6LZ4DKj6YUpOL4LhJ8LJwyMUc7bC5Kvwc4JbkuzUzmznTOflA/sVYb6K2GmRVB5mnpK6zf0kYahzIU22oQM5Wilam2AHSUR0J9lriLagWXt1RLhaDcLow3HZHGBAsVCgbR22mWtJarDGsETo8w+HknI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufLAa-0000oU-8i
	for linux-can@vger.kernel.org; Fri, 25 Jul 2025 18:21:16 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufLAa-00AFhI-09
	for linux-can@vger.kernel.org;
	Fri, 25 Jul 2025 18:21:16 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 489404498DD
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:35 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 98CC5449841;
	Fri, 25 Jul 2025 16:13:31 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d544a966;
	Fri, 25 Jul 2025 16:13:30 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 24/27] can: kvaser_usb: Add devlink support
Date: Fri, 25 Jul 2025 18:05:34 +0200
Message-ID: <20250725161327.4165174-25-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725161327.4165174-1-mkl@pengutronix.de>
References: <20250725161327.4165174-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Add devlink support at device level.

Example output:
  $ devlink dev
  usb/1-1.3:1.0

  $ devlink dev info
  usb/1-1.3:1.0:
    driver kvaser_usb

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20250725123452.41-9-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/Kconfig                   |  1 +
 drivers/net/can/usb/kvaser_usb/Makefile       |  2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  3 +
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 72 ++++++++++++-------
 .../can/usb/kvaser_usb/kvaser_usb_devlink.c   | 11 +++
 5 files changed, 63 insertions(+), 26 deletions(-)
 create mode 100644 drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index 9dae0c71a2e1..a7547a83120e 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -66,6 +66,7 @@ config CAN_GS_USB
 
 config CAN_KVASER_USB
 	tristate "Kvaser CAN/USB interface"
+	select NET_DEVLINK
 	help
 	  This driver adds support for Kvaser CAN/USB devices like Kvaser
 	  Leaf Light, Kvaser USBcan II and Kvaser Memorator Pro 5xHS.
diff --git a/drivers/net/can/usb/kvaser_usb/Makefile b/drivers/net/can/usb/kvaser_usb/Makefile
index cf260044f0b9..41b4a11555aa 100644
--- a/drivers/net/can/usb/kvaser_usb/Makefile
+++ b/drivers/net/can/usb/kvaser_usb/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_CAN_KVASER_USB) += kvaser_usb.o
-kvaser_usb-y = kvaser_usb_core.o kvaser_usb_leaf.o kvaser_usb_hydra.o
+kvaser_usb-y = kvaser_usb_core.o kvaser_usb_devlink.o kvaser_usb_leaf.o kvaser_usb_hydra.o
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index 35c2cf3d4486..d5f913ac9b44 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -27,6 +27,7 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/usb.h>
+#include <net/devlink.h>
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
@@ -226,6 +227,8 @@ struct kvaser_usb_dev_cfg {
 extern const struct kvaser_usb_dev_ops kvaser_usb_hydra_dev_ops;
 extern const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops;
 
+extern const struct devlink_ops kvaser_usb_devlink_ops;
+
 void kvaser_usb_unlink_tx_urbs(struct kvaser_usb_net_priv *priv);
 
 int kvaser_usb_recv_cmd(const struct kvaser_usb *dev, void *cmd, int len,
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 2313fbc1a2c3..b9b2e120a5cd 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -914,6 +914,7 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 			    const struct usb_device_id *id)
 {
 	struct kvaser_usb *dev;
+	struct devlink *devlink;
 	int err;
 	int i;
 	const struct kvaser_usb_driver_info *driver_info;
@@ -923,17 +924,20 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 	if (!driver_info)
 		return -ENODEV;
 
-	dev = devm_kzalloc(&intf->dev, sizeof(*dev), GFP_KERNEL);
-	if (!dev)
+	devlink = devlink_alloc(&kvaser_usb_devlink_ops, sizeof(*dev), &intf->dev);
+	if (!devlink)
 		return -ENOMEM;
 
+	dev = devlink_priv(devlink);
 	dev->intf = intf;
 	dev->driver_info = driver_info;
 	ops = driver_info->ops;
 
 	err = ops->dev_setup_endpoints(dev);
-	if (err)
-		return dev_err_probe(&intf->dev, err, "Cannot get usb endpoint(s)");
+	if (err) {
+		dev_err_probe(&intf->dev, err, "Cannot get usb endpoint(s)");
+		goto free_devlink;
+	}
 
 	dev->udev = interface_to_usbdev(intf);
 
@@ -944,50 +948,66 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 	dev->card_data.ctrlmode_supported = 0;
 	dev->card_data.capabilities = 0;
 	err = ops->dev_init_card(dev);
-	if (err)
-		return dev_err_probe(&intf->dev, err,
-				     "Failed to initialize card\n");
+	if (err) {
+		dev_err_probe(&intf->dev, err,
+			      "Failed to initialize card\n");
+		goto free_devlink;
+	}
 
 	err = ops->dev_get_software_info(dev);
-	if (err)
-		return dev_err_probe(&intf->dev, err,
-				     "Cannot get software info\n");
+	if (err) {
+		dev_err_probe(&intf->dev, err,
+			      "Cannot get software info\n");
+		goto free_devlink;
+	}
 
 	if (ops->dev_get_software_details) {
 		err = ops->dev_get_software_details(dev);
-		if (err)
-			return dev_err_probe(&intf->dev, err,
-					     "Cannot get software details\n");
+		if (err) {
+			dev_err_probe(&intf->dev, err,
+				      "Cannot get software details\n");
+			goto free_devlink;
+		}
 	}
 
-	if (WARN_ON(!dev->cfg))
-		return -ENODEV;
+	if (WARN_ON(!dev->cfg)) {
+		err = -ENODEV;
+		goto free_devlink;
+	}
 
 	dev_dbg(&intf->dev, "Max outstanding tx = %d URBs\n", dev->max_tx_urbs);
 
 	err = ops->dev_get_card_info(dev);
-	if (err)
-		return dev_err_probe(&intf->dev, err,
-				     "Cannot get card info\n");
+	if (err) {
+		dev_err_probe(&intf->dev, err,
+			      "Cannot get card info\n");
+		goto free_devlink;
+	}
 
 	if (ops->dev_get_capabilities) {
 		err = ops->dev_get_capabilities(dev);
 		if (err) {
-			kvaser_usb_remove_interfaces(dev);
-			return dev_err_probe(&intf->dev, err,
-					     "Cannot get capabilities\n");
+			dev_err_probe(&intf->dev, err,
+				      "Cannot get capabilities\n");
+			goto remove_interfaces;
 		}
 	}
 
 	for (i = 0; i < dev->nchannels; i++) {
 		err = kvaser_usb_init_one(dev, i);
-		if (err) {
-			kvaser_usb_remove_interfaces(dev);
-			return err;
-		}
+		if (err)
+			goto remove_interfaces;
 	}
+	devlink_register(devlink);
 
 	return 0;
+
+remove_interfaces:
+	kvaser_usb_remove_interfaces(dev);
+free_devlink:
+	devlink_free(devlink);
+
+	return err;
 }
 
 static void kvaser_usb_disconnect(struct usb_interface *intf)
@@ -1000,6 +1020,8 @@ static void kvaser_usb_disconnect(struct usb_interface *intf)
 		return;
 
 	kvaser_usb_remove_interfaces(dev);
+	devlink_unregister(priv_to_devlink(dev));
+	devlink_free(priv_to_devlink(dev));
 }
 
 static struct usb_driver kvaser_usb_driver = {
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
new file mode 100644
index 000000000000..dbe7fa64558a
--- /dev/null
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/* kvaser_usb devlink functions
+ *
+ * Copyright (C) 2025 KVASER AB, Sweden. All rights reserved.
+ */
+#include "kvaser_usb.h"
+
+#include <net/devlink.h>
+
+const struct devlink_ops kvaser_usb_devlink_ops = {
+};
-- 
2.47.2



