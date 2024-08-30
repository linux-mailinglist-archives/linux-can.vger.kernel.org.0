Return-Path: <linux-can+bounces-1274-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 649FE966B69
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 23:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2101A28144B
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 21:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979221C1750;
	Fri, 30 Aug 2024 21:44:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6881BE24B
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725054259; cv=none; b=VSKWy3CtjyI/si0JtzGZ+H/8Xnp3xkCfCDc2T+g20hDPY8oI8NXS5lFWiNFp73kUE5wx3qekbNIczqN7cX2i/G+vjMTKyukErXFQaT049XbM2Hly+YUWCXEGUPlFDynqLi506PZNUN+Lrp/fDpgRiJ+rS1MsR/Gb6e9fA+HVt64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725054259; c=relaxed/simple;
	bh=2KAs1n7aDF1a0Hggbk63MXj+EmjVekkX/yHNs/0xnHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crBNfSNShY8NI9nRq3+W91DbfpsnnPTl77CNygg/6P8cwdh/1Izq5N/rz2Ea6KC7K+P+mAUcX4WjkmbS+cYPznhcP5Z+Ha4np0I+LuIbtzWwta7sCYUaW1NSGxdNpvkxRMKlsA7sivYuqkbap3F2o0Yoql4Sf284G/8DZchLYDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9Pj-0002iG-Qe
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 23:44:15 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9Pi-004FNz-J6
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 23:44:14 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 44AB632E483
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 21:44:14 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 49D1E32E459;
	Fri, 30 Aug 2024 21:44:12 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 59e0d153;
	Fri, 30 Aug 2024 21:44:11 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Yan Zhen <yanzhen@vivo.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 6/6] can: kvaser_usb: Simplify with dev_err_probe()
Date: Fri, 30 Aug 2024 23:34:39 +0200
Message-ID: <20240830214406.1605786-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240830214406.1605786-1-mkl@pengutronix.de>
References: <20240830214406.1605786-1-mkl@pengutronix.de>
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

From: Yan Zhen <yanzhen@vivo.com>

dev_err_probe() is used to log an error message during the probe process
of a device.

It can simplify the error path and unify a message template.

Using this helper is totally fine even if err is known to never
be -EPROBE_DEFER.

The benefit compared to a normal dev_err() is the standardized format
of the error code, it being emitted symbolically and the fact that
the error code is returned which allows more compact error paths.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
Link: https://patch.msgid.link/20240830110651.519119-1-yanzhen@vivo.com
mkl: fix indention
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 42 +++++++------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 35b4132b0639..7d12776ab63e 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -898,10 +898,8 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 	ops = driver_info->ops;
 
 	err = ops->dev_setup_endpoints(dev);
-	if (err) {
-		dev_err(&intf->dev, "Cannot get usb endpoint(s)");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(&intf->dev, err, "Cannot get usb endpoint(s)");
 
 	dev->udev = interface_to_usbdev(intf);
 
@@ -912,26 +910,20 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 	dev->card_data.ctrlmode_supported = 0;
 	dev->card_data.capabilities = 0;
 	err = ops->dev_init_card(dev);
-	if (err) {
-		dev_err(&intf->dev,
-			"Failed to initialize card, error %d\n", err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(&intf->dev, err,
+				     "Failed to initialize card\n");
 
 	err = ops->dev_get_software_info(dev);
-	if (err) {
-		dev_err(&intf->dev,
-			"Cannot get software info, error %d\n", err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(&intf->dev, err,
+				     "Cannot get software info\n");
 
 	if (ops->dev_get_software_details) {
 		err = ops->dev_get_software_details(dev);
-		if (err) {
-			dev_err(&intf->dev,
-				"Cannot get software details, error %d\n", err);
-			return err;
-		}
+		if (err)
+			return dev_err_probe(&intf->dev, err,
+					     "Cannot get software details\n");
 	}
 
 	if (WARN_ON(!dev->cfg))
@@ -945,18 +937,16 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 	dev_dbg(&intf->dev, "Max outstanding tx = %d URBs\n", dev->max_tx_urbs);
 
 	err = ops->dev_get_card_info(dev);
-	if (err) {
-		dev_err(&intf->dev, "Cannot get card info, error %d\n", err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(&intf->dev, err,
+				     "Cannot get card info\n");
 
 	if (ops->dev_get_capabilities) {
 		err = ops->dev_get_capabilities(dev);
 		if (err) {
-			dev_err(&intf->dev,
-				"Cannot get capabilities, error %d\n", err);
 			kvaser_usb_remove_interfaces(dev);
-			return err;
+			return dev_err_probe(&intf->dev, err,
+					     "Cannot get capabilities\n");
 		}
 	}
 
-- 
2.45.2



