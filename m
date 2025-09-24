Return-Path: <linux-can+bounces-4924-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EB0B98CB4
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 10:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FFFD4C238D
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 08:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E18285CB5;
	Wed, 24 Sep 2025 08:21:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA42284890
	for <linux-can@vger.kernel.org>; Wed, 24 Sep 2025 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702106; cv=none; b=A4SZ5MSS98cDYGi0FXnJxFdGWZfPpucm5fHRLvd/uOW8kS8vMCeb2GDaREsLdgk/QMD9LtTERfumWkuh/rpcVaeOcTuUaQ4BqVvpGIWbGYaYq2UlerABd8p4XhvPlXs5Rm3yJG2OF52xacSEGLPRVyVvOZn3PjVkYMvyR4QPl9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702106; c=relaxed/simple;
	bh=foSucxU0ZIUkQh9HZLacyiiK+iID/JepO+Ic/78R16o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uom3eMLHdKkZJY7knAfdgq85z/6lP5yyJ6V2scE/Um5SNpEGOuhV62jkyOUgGB9zLt3L7cq++f9HZAQQnGDFNHd6lhPJEC/XpcQUv94rcfrlj4QEWYYJoRLHsEesJysq/2fFaroxwq4VC+pOjKl9MhOSRSiT3L7d3N12noELq+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkf-0001GT-B8; Wed, 24 Sep 2025 10:21:25 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-000DwX-21;
	Wed, 24 Sep 2025 10:21:23 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DCFFF47888C;
	Wed, 24 Sep 2025 08:21:08 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 20/48] can: esd_usb: Rework display of error messages
Date: Wed, 24 Sep 2025 10:06:37 +0200
Message-ID: <20250924082104.595459-21-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924082104.595459-1-mkl@pengutronix.de>
References: <20250924082104.595459-1-mkl@pengutronix.de>
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

- esd_usb_open(): Get rid of duplicate "couldn't start device: %d\n"
  message already printed from esd_usb_start().
- Fix duplicate printout of network device name when network device
  is registered. Add an unregister message for the network device
  as counterpart to the register message.
- Add the printout of error codes together with the error messages
  in esd_usb_close() and some in esd_usb_probe(). The additional error
  codes should lead to a better understanding what is really going
  wrong.
- Convert all occurrences of error status prints to use "ERR_PTR(err)"
  instead of printing the decimal value of "err".
- Rename retval to err in esd_usb_read_bulk_callback() to make the
  naming of error status variables consistent with all other functions.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
Link: https://patch.msgid.link/20250821143422.3567029-5-stefan.maetje@esd.eu
[mkl: minor change patch description to imperative language]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/esd_usb.c | 36 +++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 27a3818885c2..14b5df4d5543 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -9,6 +9,7 @@
 #include <linux/can.h>
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
+#include <linux/err.h>
 #include <linux/ethtool.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -480,7 +481,7 @@ static void esd_usb_tx_done_msg(struct esd_usb_net_priv *priv,
 static void esd_usb_read_bulk_callback(struct urb *urb)
 {
 	struct esd_usb *dev = urb->context;
-	int retval;
+	int err;
 	int pos = 0;
 	int i;
 
@@ -496,7 +497,7 @@ static void esd_usb_read_bulk_callback(struct urb *urb)
 
 	default:
 		dev_info(dev->udev->dev.parent,
-			 "Rx URB aborted (%d)\n", urb->status);
+			 "Rx URB aborted (%pe)\n", ERR_PTR(urb->status));
 		goto resubmit_urb;
 	}
 
@@ -539,15 +540,15 @@ static void esd_usb_read_bulk_callback(struct urb *urb)
 			  urb->transfer_buffer, ESD_USB_RX_BUFFER_SIZE,
 			  esd_usb_read_bulk_callback, dev);
 
-	retval = usb_submit_urb(urb, GFP_ATOMIC);
-	if (retval == -ENODEV) {
+	err = usb_submit_urb(urb, GFP_ATOMIC);
+	if (err == -ENODEV) {
 		for (i = 0; i < dev->net_count; i++) {
 			if (dev->nets[i])
 				netif_device_detach(dev->nets[i]->netdev);
 		}
-	} else if (retval) {
+	} else if (err) {
 		dev_err(dev->udev->dev.parent,
-			"failed resubmitting read bulk urb: %d\n", retval);
+			"failed resubmitting read bulk urb: %pe\n", ERR_PTR(err));
 	}
 }
 
@@ -572,7 +573,7 @@ static void esd_usb_write_bulk_callback(struct urb *urb)
 		return;
 
 	if (urb->status)
-		netdev_info(netdev, "Tx URB aborted (%d)\n", urb->status);
+		netdev_info(netdev, "Tx URB aborted (%pe)\n", ERR_PTR(urb->status));
 
 	netif_trans_update(netdev);
 }
@@ -758,7 +759,7 @@ static int esd_usb_start(struct esd_usb_net_priv *priv)
 	if (err == -ENODEV)
 		netif_device_detach(netdev);
 	if (err)
-		netdev_err(netdev, "couldn't start device: %d\n", err);
+		netdev_err(netdev, "couldn't start device: %pe\n", ERR_PTR(err));
 
 	kfree(msg);
 	return err;
@@ -800,7 +801,6 @@ static int esd_usb_open(struct net_device *netdev)
 	/* finally start device */
 	err = esd_usb_start(priv);
 	if (err) {
-		netdev_warn(netdev, "couldn't start device: %d\n", err);
 		close_candev(netdev);
 		return err;
 	}
@@ -923,7 +923,7 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 		if (err == -ENODEV)
 			netif_device_detach(netdev);
 		else
-			netdev_warn(netdev, "failed tx_urb %d\n", err);
+			netdev_warn(netdev, "failed tx_urb %pe\n", ERR_PTR(err));
 
 		goto releasebuf;
 	}
@@ -951,6 +951,7 @@ static int esd_usb_close(struct net_device *netdev)
 {
 	struct esd_usb_net_priv *priv = netdev_priv(netdev);
 	union esd_usb_msg *msg;
+	int err;
 	int i;
 
 	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
@@ -964,8 +965,9 @@ static int esd_usb_close(struct net_device *netdev)
 	msg->filter.option = ESD_USB_ID_ENABLE; /* start with segment 0 */
 	for (i = 0; i <= ESD_USB_MAX_ID_SEGMENT; i++)
 		msg->filter.mask[i] = 0;
-	if (esd_usb_send_msg(priv->usb, msg) < 0)
-		netdev_err(netdev, "sending idadd message failed\n");
+	err = esd_usb_send_msg(priv->usb, msg);
+	if (err < 0)
+		netdev_err(netdev, "sending idadd message failed: %pe\n", ERR_PTR(err));
 
 	/* set CAN controller to reset mode */
 	msg->hdr.len = sizeof(struct esd_usb_set_baudrate_msg) / sizeof(u32); /* # of 32bit words */
@@ -973,8 +975,9 @@ static int esd_usb_close(struct net_device *netdev)
 	msg->setbaud.net = priv->index;
 	msg->setbaud.rsvd = 0;
 	msg->setbaud.baud = cpu_to_le32(ESD_USB_NO_BAUDRATE);
-	if (esd_usb_send_msg(priv->usb, msg) < 0)
-		netdev_err(netdev, "sending setbaud message failed\n");
+	err = esd_usb_send_msg(priv->usb, msg);
+	if (err < 0)
+		netdev_err(netdev, "sending setbaud message failed: %pe\n", ERR_PTR(err));
 
 	priv->can.state = CAN_STATE_STOPPED;
 
@@ -1251,14 +1254,14 @@ static int esd_usb_probe_one_net(struct usb_interface *intf, int index)
 
 	err = register_candev(netdev);
 	if (err) {
-		dev_err(&intf->dev, "couldn't register CAN device: %d\n", err);
+		dev_err(&intf->dev, "couldn't register CAN device: %pe\n", ERR_PTR(err));
 		free_candev(netdev);
 		err = -ENOMEM;
 		goto done;
 	}
 
 	dev->nets[index] = priv;
-	netdev_info(netdev, "device %s registered\n", netdev->name);
+	netdev_info(netdev, "registered\n");
 
 done:
 	return err;
@@ -1357,6 +1360,7 @@ static void esd_usb_disconnect(struct usb_interface *intf)
 		for (i = 0; i < dev->net_count; i++) {
 			if (dev->nets[i]) {
 				netdev = dev->nets[i]->netdev;
+				netdev_info(netdev, "unregister\n");
 				unregister_netdev(netdev);
 				free_candev(netdev);
 			}
-- 
2.51.0


