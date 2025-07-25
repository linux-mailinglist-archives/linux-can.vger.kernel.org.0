Return-Path: <linux-can+bounces-4165-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 587E7B121A2
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 18:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840E51CE58EB
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 16:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EEB2F0C44;
	Fri, 25 Jul 2025 16:13:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0032F0026
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460024; cv=none; b=FQXnRpxub4ADFIfGEehADwscAZo+80RhYyJmje4Tam7lDAXxWHYCE3MsmrDLWVYUXnU8y2NS2hmOHeNcaEb0dg6/SHo82JWo8c5v1s18QZCrRD4s2xScYq49DlbWvURi4y3nub+LhuCnHnA/ATAyD5VQml8naN/DuaFhzZeJzCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460024; c=relaxed/simple;
	bh=2hOSGqnufASPWZYnpMrQxxuXxR/+aQBVqmhGkacV1v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1ASSA/ZUSDWOghwmk1QR/DPmm3kH0vvmsUx1Ff4MHJBukoomk1cl7nkYc0BOjRgWKHwgUxHh/p3C2GT9xAqperKzKCaYEb+P14f1yo9K0U1yKxgz8Iw3GZ1A1lDRtXq2I29kbsvuR6K12DksMQhSGKidPLEKhFp6UGfTXrqePs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3E-0006jp-JO
	for linux-can@vger.kernel.org; Fri, 25 Jul 2025 18:13:40 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3A-00AFcH-1z
	for linux-can@vger.kernel.org;
	Fri, 25 Jul 2025 18:13:36 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 2A0C34498DB
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:35 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 216CA449832;
	Fri, 25 Jul 2025 16:13:31 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8100638b;
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
Subject: [PATCH net-next 20/27] can: kvaser_usb: Add intermediate variables
Date: Fri, 25 Jul 2025 18:05:30 +0200
Message-ID: <20250725161327.4165174-21-mkl@pengutronix.de>
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

Add intermediate variables, for readability and to simplify future patches.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20250725123452.41-5-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 7be8604bf760..46e6cda0bf8d 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -364,10 +364,13 @@ static void kvaser_usb_read_bulk_callback(struct urb *urb)
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err == -ENODEV) {
 		for (i = 0; i < dev->nchannels; i++) {
-			if (!dev->nets[i])
+			struct kvaser_usb_net_priv *priv;
+
+			priv = dev->nets[i];
+			if (!priv)
 				continue;
 
-			netif_device_detach(dev->nets[i]->netdev);
+			netif_device_detach(priv->netdev);
 		}
 	} else if (err) {
 		dev_err(&dev->intf->dev,
@@ -795,24 +798,27 @@ static void kvaser_usb_remove_interfaces(struct kvaser_usb *dev)
 {
 	const struct kvaser_usb_dev_ops *ops = dev->driver_info->ops;
 	int i;
+	struct kvaser_usb_net_priv *priv;
 
 	for (i = 0; i < dev->nchannels; i++) {
-		if (!dev->nets[i])
+		priv = dev->nets[i];
+		if (!priv)
 			continue;
 
-		unregister_candev(dev->nets[i]->netdev);
+		unregister_candev(priv->netdev);
 	}
 
 	kvaser_usb_unlink_all_urbs(dev);
 
 	for (i = 0; i < dev->nchannels; i++) {
-		if (!dev->nets[i])
+		priv = dev->nets[i];
+		if (!priv)
 			continue;
 
 		if (ops->dev_remove_channel)
-			ops->dev_remove_channel(dev->nets[i]);
+			ops->dev_remove_channel(priv);
 
-		free_candev(dev->nets[i]->netdev);
+		free_candev(priv->netdev);
 	}
 }
 
-- 
2.47.2



