Return-Path: <linux-can+bounces-4793-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10938B8FF07
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 12:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81306423012
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 10:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B913009EA;
	Mon, 22 Sep 2025 10:09:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BDF2FD7BA
	for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535766; cv=none; b=a61RzPPBj4pNZZBsbQPDSwOaTGzFP7NPyN6LOuQuyYXMS9jimhyi5LLBQF19zDBQhEpeFqZ8hqKJxOrM4fdho9vp+va3e39ksldu0awE6j9KHiXq/LoubX4Px2YRaD9MRkoGhiMUqkJczql8UKLGccB+q3nDwQ1ATC81T+5wGyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535766; c=relaxed/simple;
	bh=KYZYPBJ1UsmpW8iWfADUrZDsL4uhT6cbvMr1etkaXGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MeDkGSaj4EFTvY+qsCUws8Tw58CCRzdxDB5QIuFxzTU01gAwBAcbpeYwrhlYmBP1ZVslZx5nQMxlGw49liLe4rfuJdBYXij91/M66THIBTU2+OwJyhnGJXytg3mLmluc4FPBQtes4qrh5mmcXFijiXMRKyRZwswQfZb1FJrhSA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0dU1-0006yc-UG
	for linux-can@vger.kernel.org; Mon, 22 Sep 2025 12:09:21 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0dU0-002ZX9-2J
	for linux-can@vger.kernel.org;
	Mon, 22 Sep 2025 12:09:20 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 65CF8476D2C
	for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 10:09:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 9C296476CED;
	Mon, 22 Sep 2025 10:09:17 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 37d88636;
	Mon, 22 Sep 2025 10:09:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 08/10] can: esd_usb: Fix not detecting version reply in probe routine
Date: Mon, 22 Sep 2025 12:07:38 +0200
Message-ID: <20250922100913.392916-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922100913.392916-1-mkl@pengutronix.de>
References: <20250922100913.392916-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Stefan Mätje <stefan.maetje@esd.eu>

This patch fixes some problems in the esd_usb_probe() routine that render
the CAN interface unusable.

The probe routine sends a version request message to the USB device to
receive a version reply with the number of CAN ports and the hard-
& firmware versions. Then for each CAN port a CAN netdev is registered.

The previous code assumed that the version reply would be received
immediately. But if the driver was reloaded without power cycling the
USB device (i. e. on a reboot) there could already be other incoming
messages in the USB buffers. These would be in front of the version
reply and need to be skipped.

In the previous code these problems were present:
- Only one usb_bulk_msg() read was done into a buffer of
  sizeof(union esd_usb_msg) which is smaller than ESD_USB_RX_BUFFER_SIZE
  which could lead to an overflow error from the USB stack.
- The first bytes of the received data were taken without checking for
  the message type. This could lead to zero detected CAN interfaces.

To mitigate these problems:
- Move the code to send the version request message into a standalone
  function esd_usb_req_version().
- Add a function esd_usb_recv_version() using a transfer buffer
  with ESD_USB_RX_BUFFER_SIZE. It reads and skips incoming "esd_usb_msg"
  messages until a version reply message is found. This is evaluated to
  return the count of CAN ports and version information.
- The data drain loop is limited by a maximum # of bytes to read from
  the device based on its internal buffer sizes and a timeout
  ESD_USB_DRAIN_TIMEOUT_MS.

This version of the patch incorporates changes recommended on the
linux-can list for a very first version [1].

[1] https://lore.kernel.org/linux-can/20250203145810.1286331-1-stefan.maetje@esd.eu

Fixes: 80662d943075 ("can: esd_usb: Add support for esd CAN-USB/3")
Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
Link: https://patch.msgid.link/20250821143422.3567029-2-stefan.maetje@esd.eu
[mkl: minor change patch description to imperative language]
[mkl: squash error format changes from patch 4]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/esd_usb.c | 149 +++++++++++++++++++++++++---------
 1 file changed, 112 insertions(+), 37 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 27a3818885c2..ed1d6ba779dc 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -3,7 +3,7 @@
  * CAN driver for esd electronics gmbh CAN-USB/2, CAN-USB/3 and CAN-USB/Micro
  *
  * Copyright (C) 2010-2012 esd electronic system design gmbh, Matthias Fuchs <socketcan@esd.eu>
- * Copyright (C) 2022-2024 esd electronics gmbh, Frank Jungclaus <frank.jungclaus@esd.eu>
+ * Copyright (C) 2022-2025 esd electronics gmbh, Frank Jungclaus <frank.jungclaus@esd.eu>
  */
 
 #include <linux/can.h>
@@ -44,6 +44,9 @@ MODULE_LICENSE("GPL v2");
 #define ESD_USB_CMD_TS			5 /* also used for TS_REPLY */
 #define ESD_USB_CMD_IDADD		6 /* also used for IDADD_REPLY */
 
+/* esd version message name size */
+#define ESD_USB_FW_NAME_SZ 16
+
 /* esd CAN message flags - dlc field */
 #define ESD_USB_RTR	BIT(4)
 #define ESD_USB_NO_BRS	BIT(4)
@@ -95,6 +98,7 @@ MODULE_LICENSE("GPL v2");
 #define ESD_USB_RX_BUFFER_SIZE		1024
 #define ESD_USB_MAX_RX_URBS		4
 #define ESD_USB_MAX_TX_URBS		16 /* must be power of 2 */
+#define ESD_USB_DRAIN_TIMEOUT_MS	100
 
 /* Modes for CAN-USB/3, to be used for esd_usb_3_set_baudrate_msg_x.mode */
 #define ESD_USB_3_BAUDRATE_MODE_DISABLE		0 /* remove from bus */
@@ -131,7 +135,7 @@ struct esd_usb_version_reply_msg {
 	u8 nets;
 	u8 features;
 	__le32 version;
-	u8 name[16];
+	u8 name[ESD_USB_FW_NAME_SZ];
 	__le32 rsvd;
 	__le32 ts;
 };
@@ -625,17 +629,106 @@ static int esd_usb_send_msg(struct esd_usb *dev, union esd_usb_msg *msg)
 			    1000);
 }
 
-static int esd_usb_wait_msg(struct esd_usb *dev,
-			    union esd_usb_msg *msg)
+static int esd_usb_req_version(struct esd_usb *dev)
 {
-	int actual_length;
+	union esd_usb_msg *msg;
+	int err;
 
-	return usb_bulk_msg(dev->udev,
-			    usb_rcvbulkpipe(dev->udev, 1),
-			    msg,
-			    sizeof(*msg),
-			    &actual_length,
-			    1000);
+	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->hdr.cmd = ESD_USB_CMD_VERSION;
+	msg->hdr.len = sizeof(struct esd_usb_version_msg) / sizeof(u32); /* # of 32bit words */
+	msg->version.rsvd = 0;
+	msg->version.flags = 0;
+	msg->version.drv_version = 0;
+
+	err = esd_usb_send_msg(dev, msg);
+	kfree(msg);
+	return err;
+}
+
+static int esd_usb_recv_version(struct esd_usb *dev)
+{
+	/* Device hardware has 2 RX buffers with ESD_USB_RX_BUFFER_SIZE, * 4 to give some slack. */
+	const int max_drain_bytes = (4 * ESD_USB_RX_BUFFER_SIZE);
+	unsigned long end_jiffies;
+	void *rx_buf;
+	int cnt_other = 0;
+	int cnt_ts = 0;
+	int cnt_vs = 0;
+	int len_sum = 0;
+	int attempt = 0;
+	int err;
+
+	rx_buf = kmalloc(ESD_USB_RX_BUFFER_SIZE, GFP_KERNEL);
+	if (!rx_buf)
+		return -ENOMEM;
+
+	end_jiffies = jiffies + msecs_to_jiffies(ESD_USB_DRAIN_TIMEOUT_MS);
+	do {
+		int actual_length;
+		int pos;
+
+		err = usb_bulk_msg(dev->udev,
+				   usb_rcvbulkpipe(dev->udev, 1),
+				   rx_buf,
+				   ESD_USB_RX_BUFFER_SIZE,
+				   &actual_length,
+				   ESD_USB_DRAIN_TIMEOUT_MS);
+		dev_dbg(&dev->udev->dev, "AT %d, LEN %d, ERR %d\n", attempt, actual_length, err);
+		++attempt;
+		if (err)
+			goto bail;
+		if (actual_length == 0)
+			continue;
+
+		err = -ENOENT;
+		len_sum += actual_length;
+		pos = 0;
+		while (pos < actual_length - sizeof(struct esd_usb_header_msg)) {
+			union esd_usb_msg *p_msg;
+
+			p_msg = (union esd_usb_msg *)(rx_buf + pos);
+
+			pos += p_msg->hdr.len * sizeof(u32); /* convert to # of bytes */
+			if (pos > actual_length) {
+				dev_err(&dev->udev->dev, "format error\n");
+				err = -EPROTO;
+				goto bail;
+			}
+
+			switch (p_msg->hdr.cmd) {
+			case ESD_USB_CMD_VERSION:
+				++cnt_vs;
+				dev->net_count = min(p_msg->version_reply.nets, ESD_USB_MAX_NETS);
+				dev->version = le32_to_cpu(p_msg->version_reply.version);
+				err = 0;
+				dev_dbg(&dev->udev->dev, "TS 0x%08x, V 0x%08x, N %u, F 0x%02x, %.*s\n",
+					le32_to_cpu(p_msg->version_reply.ts),
+					le32_to_cpu(p_msg->version_reply.version),
+					p_msg->version_reply.nets,
+					p_msg->version_reply.features,
+					ESD_USB_FW_NAME_SZ, p_msg->version_reply.name);
+				break;
+			case ESD_USB_CMD_TS:
+				++cnt_ts;
+				dev_dbg(&dev->udev->dev, "TS 0x%08x\n",
+					le32_to_cpu(p_msg->rx.ts));
+				break;
+			default:
+				++cnt_other;
+				dev_dbg(&dev->udev->dev, "HDR %d\n", p_msg->hdr.cmd);
+				break;
+			}
+		}
+	} while (cnt_vs == 0 && len_sum < max_drain_bytes && time_before(jiffies, end_jiffies));
+bail:
+	dev_dbg(&dev->udev->dev, "RC=%d; ATT=%d, TS=%d, VS=%d, O=%d, B=%d\n",
+		err, attempt, cnt_ts, cnt_vs, cnt_other, len_sum);
+	kfree(rx_buf);
+	return err;
 }
 
 static int esd_usb_setup_rx_urbs(struct esd_usb *dev)
@@ -1273,13 +1366,12 @@ static int esd_usb_probe(struct usb_interface *intf,
 			 const struct usb_device_id *id)
 {
 	struct esd_usb *dev;
-	union esd_usb_msg *msg;
 	int i, err;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev) {
 		err = -ENOMEM;
-		goto done;
+		goto bail;
 	}
 
 	dev->udev = interface_to_usbdev(intf);
@@ -1288,34 +1380,19 @@ static int esd_usb_probe(struct usb_interface *intf,
 
 	usb_set_intfdata(intf, dev);
 
-	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
-	if (!msg) {
-		err = -ENOMEM;
-		goto free_msg;
-	}
-
 	/* query number of CAN interfaces (nets) */
-	msg->hdr.cmd = ESD_USB_CMD_VERSION;
-	msg->hdr.len = sizeof(struct esd_usb_version_msg) / sizeof(u32); /* # of 32bit words */
-	msg->version.rsvd = 0;
-	msg->version.flags = 0;
-	msg->version.drv_version = 0;
-
-	err = esd_usb_send_msg(dev, msg);
+	err = esd_usb_req_version(dev);
 	if (err < 0) {
-		dev_err(&intf->dev, "sending version message failed\n");
-		goto free_msg;
+		dev_err(&intf->dev, "sending version message failed: %pe\n", ERR_PTR(err));
+		goto bail;
 	}
 
-	err = esd_usb_wait_msg(dev, msg);
+	err = esd_usb_recv_version(dev);
 	if (err < 0) {
-		dev_err(&intf->dev, "no version message answer\n");
-		goto free_msg;
+		dev_err(&intf->dev, "no version message answer: %pe\n", ERR_PTR(err));
+		goto bail;
 	}
 
-	dev->net_count = (int)msg->version_reply.nets;
-	dev->version = le32_to_cpu(msg->version_reply.version);
-
 	if (device_create_file(&intf->dev, &dev_attr_firmware))
 		dev_err(&intf->dev,
 			"Couldn't create device file for firmware\n");
@@ -1332,11 +1409,9 @@ static int esd_usb_probe(struct usb_interface *intf,
 	for (i = 0; i < dev->net_count; i++)
 		esd_usb_probe_one_net(intf, i);
 
-free_msg:
-	kfree(msg);
+bail:
 	if (err)
 		kfree(dev);
-done:
 	return err;
 }
 
-- 
2.51.0



