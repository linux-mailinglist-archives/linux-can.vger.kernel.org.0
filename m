Return-Path: <linux-can+bounces-725-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4538B905522
	for <lists+linux-can@lfdr.de>; Wed, 12 Jun 2024 16:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190FB1C216E3
	for <lists+linux-can@lfdr.de>; Wed, 12 Jun 2024 14:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8447FB;
	Wed, 12 Jun 2024 14:29:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from qmail.kvaser.se (static-195-22-86-94.cust.tele2.se [195.22.86.94])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C04716F0CA
	for <linux-can@vger.kernel.org>; Wed, 12 Jun 2024 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.22.86.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718202573; cv=none; b=jVDC+H5y+UMhEfMiLWEZfbIy30+31aZkJZ3Xt8U0XCZRlXX9U5OOWzGh7tqMSBIEfZPd5pLdpZNKl6KOamVa6x+0fl4KuJcThQ6we5Oe13epepWcB/Zsv0WdOdfgS84S91Xqt6L7/tfDh3SBmWeBmqeHCDJIcIBYDxb8K2XhY2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718202573; c=relaxed/simple;
	bh=/qgAyyF36yHSgkoXIpRIo1kH9TXgQDXC5G3JOhMBwlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vBuntNnoZ2zNkcMRR3LOTTNv/4xnxUwjP8Xt4MITbUP664WVBDuEfr7Bw6amltdvWvrsmsGgJ90u/pxgcojIdC/lBdd3ZDoW25/+EhLbhHjBekiyoBPGkZYmff6o4Oz+NcfD0tA7eOy+KcpG6z4dRTJzieP44j9zu1SDV20xPIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; arc=none smtp.client-ip=195.22.86.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
Received: from localhost (balder.kvaser.se [10.0.6.1])
	by qmail.kvaser.se (Postfix) with ESMTP id AE8C0E00B1;
	Wed, 12 Jun 2024 16:19:49 +0200 (CEST)
From: Martin Jocic <martin.jocic@kvaser.com>
To: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: extja@kvaser.com
Subject: [PATCH 2/3] can: kvaser_usb: Add support for Kvaser USBcan Pro 5xCAN
Date: Wed, 12 Jun 2024 16:19:45 +0200
Message-Id: <20240612141946.3352364-3-martin.jocic@kvaser.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240612141946.3352364-1-martin.jocic@kvaser.com>
References: <20240612141946.3352364-1-martin.jocic@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Kvaser USBcan Pro 5xCAN, based on the hydra platform.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
---
 drivers/net/can/usb/Kconfig                      | 1 +
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index d01b46a8071a..641bbc24464a 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -111,6 +111,7 @@ config CAN_KVASER_USB
 	    - Kvaser USBcan Light 4xHS
 	    - Kvaser USBcan Pro 2xHS v2
 	    - Kvaser USBcan Pro 4xHS
+	    - Kvaser USBcan Pro 5xCAN
 	    - Kvaser USBcan Pro 5xHS
 	    - Kvaser U100
 	    - Kvaser U100P
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index b828fad123b2..1416619c94ef 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -90,6 +90,7 @@
 #define USB_HYBRID_PRO_CANLIN_PRODUCT_ID 0x0116
 #define USB_LEAF_V3_PRODUCT_ID 0x0117
 #define USB_VINING_800_PRODUCT_ID 0x0119
+#define USB_USBCAN_PRO_5XCAN_PRODUCT_ID 0x011A
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_hydra = {
 	.quirks = KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
@@ -241,6 +242,8 @@ static const struct usb_device_id kvaser_usb_table[] = {
 		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_VINING_800_PRODUCT_ID),
 		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_PRO_5XCAN_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, kvaser_usb_table);
-- 
2.40.1


