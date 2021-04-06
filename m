Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0C43551BB
	for <lists+linux-can@lfdr.de>; Tue,  6 Apr 2021 13:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238378AbhDFLQo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Apr 2021 07:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238419AbhDFLQl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Apr 2021 07:16:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDB4C06174A
        for <linux-can@vger.kernel.org>; Tue,  6 Apr 2021 04:16:31 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lTjh8-0000x4-Aw
        for linux-can@vger.kernel.org; Tue, 06 Apr 2021 13:16:30 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 7672D608726
        for <linux-can@vger.kernel.org>; Tue,  6 Apr 2021 11:16:26 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 0E3FC608704;
        Tue,  6 Apr 2021 11:16:24 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 50c1608f;
        Tue, 6 Apr 2021 11:16:23 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 05/10] can: peak_usb: peak_usb_probe(): make use of driver_info
Date:   Tue,  6 Apr 2021 13:16:17 +0200
Message-Id: <20210406111622.1874957-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210406111622.1874957-1-mkl@pengutronix.de>
References: <20210406111622.1874957-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

There's no need to iterate over all supported adapters to find the
struct peak_usb_adapter that describes the currently probed devices's
capabilities. The driver core gives us the information for free, if we
assign it to the struct usb_device_id::driver_info.

This patch assigns the usb_device_id::driver_info and converts
peak_usb_probe() to make use of it. This reduces the driver size by
100 bytes on ARCH=arm.

| add/remove: 0/1 grow/shrink: 0/1 up/down: 0/-124 (-124)
| Function                                     old     new   delta
| peak_usb_adapters_list                        24       -     -24
| peak_usb_probe                               236     136    -100
| Total: Before=25263, After=25139, chg -0.49%

Cc: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 57 +++++++++-----------
 1 file changed, 24 insertions(+), 33 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index eccaf7fb3310..4eea65aced8f 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -27,28 +27,32 @@ MODULE_DESCRIPTION("CAN driver for PEAK-System USB adapters");
 MODULE_LICENSE("GPL v2");
 
 /* Table of devices that work with this driver */
-static struct usb_device_id peak_usb_table[] = {
-	{USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USB_PRODUCT_ID)},
-	{USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USBPRO_PRODUCT_ID)},
-	{USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USBFD_PRODUCT_ID)},
-	{USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USBPROFD_PRODUCT_ID)},
-	{USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USBCHIP_PRODUCT_ID)},
-	{USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USBX6_PRODUCT_ID)},
-	{} /* Terminating entry */
+static const struct usb_device_id peak_usb_table[] = {
+	{
+		USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USB_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&pcan_usb,
+	}, {
+		USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USBPRO_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&pcan_usb_pro,
+	}, {
+		USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USBFD_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&pcan_usb_fd,
+	}, {
+		USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USBPROFD_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&pcan_usb_pro_fd,
+	}, {
+		USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USBCHIP_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&pcan_usb_chip,
+	}, {
+		USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USBX6_PRODUCT_ID),
+		.driver_info = (kernel_ulong_t)&pcan_usb_x6,
+	}, {
+		/* Terminating entry */
+	}
 };
 
 MODULE_DEVICE_TABLE(usb, peak_usb_table);
 
-/* List of supported PCAN-USB adapters (NULL terminated list) */
-static const struct peak_usb_adapter *const peak_usb_adapters_list[] = {
-	&pcan_usb,
-	&pcan_usb_pro,
-	&pcan_usb_fd,
-	&pcan_usb_pro_fd,
-	&pcan_usb_chip,
-	&pcan_usb_x6,
-};
-
 /*
  * dump memory
  */
@@ -924,24 +928,11 @@ static void peak_usb_disconnect(struct usb_interface *intf)
 static int peak_usb_probe(struct usb_interface *intf,
 			  const struct usb_device_id *id)
 {
-	struct usb_device *usb_dev = interface_to_usbdev(intf);
-	const u16 usb_id_product = le16_to_cpu(usb_dev->descriptor.idProduct);
-	const struct peak_usb_adapter *peak_usb_adapter = NULL;
+	const struct peak_usb_adapter *peak_usb_adapter;
 	int i, err = -ENOMEM;
 
 	/* get corresponding PCAN-USB adapter */
-	for (i = 0; i < ARRAY_SIZE(peak_usb_adapters_list); i++)
-		if (peak_usb_adapters_list[i]->device_id == usb_id_product) {
-			peak_usb_adapter = peak_usb_adapters_list[i];
-			break;
-		}
-
-	if (!peak_usb_adapter) {
-		/* should never come except device_id bad usage in this file */
-		pr_err("%s: didn't find device id. 0x%x in devices list\n",
-			PCAN_USB_DRIVER_NAME, usb_id_product);
-		return -ENODEV;
-	}
+	peak_usb_adapter = (const struct peak_usb_adapter *)id->driver_info;
 
 	/* got corresponding adapter: check if it handles current interface */
 	if (peak_usb_adapter->intf_probe) {
-- 
2.30.2


