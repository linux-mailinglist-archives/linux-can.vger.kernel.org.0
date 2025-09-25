Return-Path: <linux-can+bounces-4987-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52865B9F1B6
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 14:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96AC5326331
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 12:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959C12FD1AD;
	Thu, 25 Sep 2025 12:14:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5EA2FB629
	for <linux-can@vger.kernel.org>; Thu, 25 Sep 2025 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802439; cv=none; b=d82wTdxnA6DOPH1Z7+GAE4xz0Blg1c7Fxa9UtJ0NDUHrt4ZEWZMuSoP48+YqRnRybQR7MG06wqrCYMd8xyIJBgtUNqpiPC6akANHqFyMaTysmzhjG0JYIZ6ByWsbqooz0lDaSU2EqIo7DjFbEaWJg3WoXpZscT0OLS9+GPj7+ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802439; c=relaxed/simple;
	bh=4c27n/M/JZ8+J0ZnSCfyPa3zGd4IvMa1U9HhMx82r3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nnmjGHuxPxPryazxzDfsuTIqmXwNIICr0lRHOG3K06Zmbg9PXUzboew0b7AFU6hX3jeA/bppoYEt+BZdXKBK5DR4g4jNN2Ab/5Z85jPWyZFvcfU4e3s6xe+yNwyPHENjnpVb+D1+or5zlA8jS1fjB9Wg6muB6SvC3GAVEB9GY4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqv-0000WK-BK; Thu, 25 Sep 2025 14:13:37 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqu-000Pw1-1N;
	Thu, 25 Sep 2025 14:13:36 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2FB37479981;
	Thu, 25 Sep 2025 12:13:36 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 21/48] can: esd_usb: Avoid errors triggered from USB disconnect
Date: Thu, 25 Sep 2025 14:07:58 +0200
Message-ID: <20250925121332.848157-22-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925121332.848157-1-mkl@pengutronix.de>
References: <20250925121332.848157-1-mkl@pengutronix.de>
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

The USB stack calls during disconnect the esd_usb_disconnect() callback.
esd_usb_disconnect() calls netdev_unregister() for each network which
in turn calls the net_device_ops::ndo_stop callback esd_usb_close() if
the net device is up.

The esd_usb_close() callback tries to disable all CAN Ids and to reset
the CAN controller of the device sending appropriate control messages.

Sending these messages in .disconnect() is moot and always fails because
either the device is gone or the USB communication is already torn down
by the USB stack in the course of a rmmod operation.

Move the code that sends these control messages to a new function
esd_usb_stop() which is approximately the counterpart of
esd_usb_start() to make code structure less convoluted.

Then change esd_usb_close() not to send the control messages at all if
the ndo_stop() callback is executed from the USB .disconnect()
callback. Add a new flag in_usb_disconnect to the struct esd_usb
device structure to mark this condition which is checked by
esd_usb_close() whether to skip the send operations in esd_usb_start().

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
Link: https://patch.msgid.link/20250821143422.3567029-6-stefan.maetje@esd.eu
[mkl: minor change patch description to imperative language]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/esd_usb.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 14b5df4d5543..9bc1824d7be6 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -275,6 +275,7 @@ struct esd_usb {
 	int net_count;
 	u32 version;
 	int rxinitdone;
+	int in_usb_disconnect;
 	void *rxbuf[ESD_USB_MAX_RX_URBS];
 	dma_addr_t rxbuf_dma[ESD_USB_MAX_RX_URBS];
 };
@@ -947,9 +948,9 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 	return ret;
 }
 
-static int esd_usb_close(struct net_device *netdev)
+/* Stop interface */
+static int esd_usb_stop(struct esd_usb_net_priv *priv)
 {
-	struct esd_usb_net_priv *priv = netdev_priv(netdev);
 	union esd_usb_msg *msg;
 	int err;
 	int i;
@@ -966,8 +967,10 @@ static int esd_usb_close(struct net_device *netdev)
 	for (i = 0; i <= ESD_USB_MAX_ID_SEGMENT; i++)
 		msg->filter.mask[i] = 0;
 	err = esd_usb_send_msg(priv->usb, msg);
-	if (err < 0)
-		netdev_err(netdev, "sending idadd message failed: %pe\n", ERR_PTR(err));
+	if (err < 0) {
+		netdev_err(priv->netdev, "sending idadd message failed: %pe\n", ERR_PTR(err));
+		goto bail;
+	}
 
 	/* set CAN controller to reset mode */
 	msg->hdr.len = sizeof(struct esd_usb_set_baudrate_msg) / sizeof(u32); /* # of 32bit words */
@@ -977,7 +980,23 @@ static int esd_usb_close(struct net_device *netdev)
 	msg->setbaud.baud = cpu_to_le32(ESD_USB_NO_BAUDRATE);
 	err = esd_usb_send_msg(priv->usb, msg);
 	if (err < 0)
-		netdev_err(netdev, "sending setbaud message failed: %pe\n", ERR_PTR(err));
+		netdev_err(priv->netdev, "sending setbaud message failed: %pe\n", ERR_PTR(err));
+
+bail:
+	kfree(msg);
+
+	return err;
+}
+
+static int esd_usb_close(struct net_device *netdev)
+{
+	struct esd_usb_net_priv *priv = netdev_priv(netdev);
+	int err = 0;
+
+	if (!priv->usb->in_usb_disconnect) {
+		/* It's moot to try this in usb_disconnect()! */
+		err = esd_usb_stop(priv);
+	}
 
 	priv->can.state = CAN_STATE_STOPPED;
 
@@ -985,9 +1004,7 @@ static int esd_usb_close(struct net_device *netdev)
 
 	close_candev(netdev);
 
-	kfree(msg);
-
-	return 0;
+	return err;
 }
 
 static const struct net_device_ops esd_usb_netdev_ops = {
@@ -1357,6 +1374,7 @@ static void esd_usb_disconnect(struct usb_interface *intf)
 	usb_set_intfdata(intf, NULL);
 
 	if (dev) {
+		dev->in_usb_disconnect = 1;
 		for (i = 0; i < dev->net_count; i++) {
 			if (dev->nets[i]) {
 				netdev = dev->nets[i]->netdev;
-- 
2.51.0


