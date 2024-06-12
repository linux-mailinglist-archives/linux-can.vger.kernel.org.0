Return-Path: <linux-can+bounces-726-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F890905524
	for <lists+linux-can@lfdr.de>; Wed, 12 Jun 2024 16:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2561F23248
	for <lists+linux-can@lfdr.de>; Wed, 12 Jun 2024 14:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA1416F0CA;
	Wed, 12 Jun 2024 14:29:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from qmail.kvaser.se (static-195-22-86-94.cust.tele2.se [195.22.86.94])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C08B17DE0F
	for <linux-can@vger.kernel.org>; Wed, 12 Jun 2024 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.22.86.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718202574; cv=none; b=qvSDvk4a8IIHSQaCCPtOLmWsSF+w0wXYyfNTLorR8IpLnbmRjFAI5HO45NC9aB3VTWjP7KV1VQ/ZZ5v/TksBvdrHDjWRy9HHibHhgtgmdIZsXaihOTozTiDLIdUaAeQXkQPOUkqtHCkEayFa8rP218uzDO+j5W8OiXRyMn1fQOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718202574; c=relaxed/simple;
	bh=NZWlOAJBGK8W8KKHmYru1V7Y5hTgBsQywykRexH+Fyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nqkhv1BD9rZ1UuIqbLc20qEPlqbVHalLJf3nou18FHFft4CSr/sdF4NBcNYszZna9MOXdKZ7jvBVCuRhYG2KZrDdlCMV6IrJqi85kc8gByTq+2mBNB6+auKDgmlFrPzIJUCf32cRgb7+UIWhIRmaJ/84xTyXIzeFX8P+qQ+2MSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; arc=none smtp.client-ip=195.22.86.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
Received: from localhost (balder.kvaser.se [10.0.6.1])
	by qmail.kvaser.se (Postfix) with ESMTP id B2799E00F8;
	Wed, 12 Jun 2024 16:19:49 +0200 (CEST)
From: Martin Jocic <martin.jocic@kvaser.com>
To: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: extja@kvaser.com
Subject: [PATCH 3/3] can: kvaser_usb: Add support for Kvaser Mini PCIe 1xCAN
Date: Wed, 12 Jun 2024 16:19:46 +0200
Message-Id: <20240612141946.3352364-4-martin.jocic@kvaser.com>
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

Add support for Kvaser Mini PCIe 1xCAN, based on the hydra platform.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
---
 drivers/net/can/usb/Kconfig                      | 1 +
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index 641bbc24464a..3e1fba12c0c3 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -91,6 +91,7 @@ config CAN_KVASER_USB
 	    - Kvaser Leaf Light R v2
 	    - Kvaser Mini PCI Express HS
 	    - Kvaser Mini PCI Express 2xHS
+	    - Kvaser Mini PCIe 1xCAN
 	    - Kvaser USBcan Light 2xHS
 	    - Kvaser USBcan II HS/HS
 	    - Kvaser USBcan II HS/LS
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 1416619c94ef..6c70eb1ceb8b 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -91,6 +91,7 @@
 #define USB_LEAF_V3_PRODUCT_ID 0x0117
 #define USB_VINING_800_PRODUCT_ID 0x0119
 #define USB_USBCAN_PRO_5XCAN_PRODUCT_ID 0x011A
+#define USB_MINI_PCIE_1XCAN_PRODUCT_ID 0x011B
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_hydra = {
 	.quirks = KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
@@ -244,6 +245,8 @@ static const struct usb_device_id kvaser_usb_table[] = {
 		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_PRO_5XCAN_PRODUCT_ID),
 		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MINI_PCIE_1XCAN_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, kvaser_usb_table);
-- 
2.40.1


