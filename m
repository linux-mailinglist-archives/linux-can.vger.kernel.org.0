Return-Path: <linux-can+bounces-5390-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B32FBC5C03C
	for <lists+linux-can@lfdr.de>; Fri, 14 Nov 2025 09:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83908347761
	for <lists+linux-can@lfdr.de>; Fri, 14 Nov 2025 08:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9C62FDC44;
	Fri, 14 Nov 2025 08:37:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D1A2FFF8D
	for <linux-can@vger.kernel.org>; Fri, 14 Nov 2025 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763109426; cv=none; b=HZ5xv7D87M5Ep/TlzvogL1m4bjW/q4rmq9S3wtoUN+vP82caW/pNVvA0hkKZd7qE/Pjmai0FOdcvfs7oWchBc0ZAno24jfIvkS8Vrx89FNYvcRqXQ+qEEL/cRNzJG+DLqeQ0ZrYeOmVI8K/b+A8Iu0yXR01Zb43vauikO3S3Mlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763109426; c=relaxed/simple;
	bh=WDo4TwHFuj3APKAWzS/6lAjFmaMs6k2odG1LKzll5U8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a1eyWuE/muiV5CoYfg+5op0qn2UOsKN046YBIjhNO0gfCbvyL1FZ1xNawEYNhU4Bt5uIY5x1TVnP0va01rED09C7VrWlDGrdNhxOjfRSfgUo1frGyBRtncl8Mh9Qr3qbYR2yze3EBr/YFMx/oJiqgBs8IwyFWD3vibQGLfFBeU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJpIe-0007Pm-NX; Fri, 14 Nov 2025 09:36:56 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJpIe-000OMX-07;
	Fri, 14 Nov 2025 09:36:56 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AB99349F2FD;
	Fri, 14 Nov 2025 08:36:55 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 14 Nov 2025 09:36:43 +0100
Subject: [PATCH can 1/3] can: gs_usb: gs_usb_xmit_callback(): fix handling
 of failed transmitted URBs
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-gs_usb-fix-usb-callbacks-v1-1-a29b42eacada@pengutronix.de>
References: <20251114-gs_usb-fix-usb-callbacks-v1-0-a29b42eacada@pengutronix.de>
In-Reply-To: <20251114-gs_usb-fix-usb-callbacks-v1-0-a29b42eacada@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 Maximilian Schneider <max@schneidersoft.net>
Cc: Henrik Brix Andersen <henrik@brixandersen.dk>, kernel@pengutronix.de, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-509f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1610; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=WDo4TwHFuj3APKAWzS/6lAjFmaMs6k2odG1LKzll5U8=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpFuohpoD1RvMAPy6vIV7vxmCGvJDFnjNBNXiqr
 xq3qQ/NPJmJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaRbqIQAKCRAMdGXf+ZCR
 nN0CB/wLnzyW0/lZNRH27FBYODZYZiY5cIaVU3f1UfQhnSOAhUdnHDBod59aN930V7QF3YSukMv
 SAg2lebJrQzHa6OVCj/YAeT8XpZv8rGbDpnk7eaEbNlUwp2EKMP887s1Kv2vI4sUMWm3WDYuCpF
 tItYWjf3Rce9RciJ7bmpeIbtdtVAMFQak5wpxvyyGaFvSvGyjkElSxK51Dp0ad2A9dWYNH91HiA
 CJmhuJBv7XlXT7r1lZAUgeF4CypiQ3X0CdRmWNk7XxWErX2OoGcUX6YrWF2cECfxGCcaBXsjAt4
 5kUtF4KI9f/BKMUBGUYh4a0xAFBj9qMzjsL3n+nJBJjitNBh
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

The driver lacks the cleanup of failed transfers of URBs. This reduces the
number of available URBs per error by 1. This leads to reduced performance
and ultimately to a complete stop of the transmission.

If the sending of a bulk URB fails do proper cleanup:
- increase netdev stats
- mark the echo_sbk as free
- free the driver's context and do accounting
- wake the send queue

Closes: https://github.com/candle-usb/candleLight_fw/issues/187
Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 69b8d6da651b..fa9bab8c89ae 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -750,8 +750,21 @@ static void gs_usb_xmit_callback(struct urb *urb)
 	struct gs_can *dev = txc->dev;
 	struct net_device *netdev = dev->netdev;
 
-	if (urb->status)
-		netdev_info(netdev, "usb xmit fail %u\n", txc->echo_id);
+	if (!urb->status)
+		return;
+
+	if (urb->status != -ESHUTDOWN && net_ratelimit())
+		netdev_info(netdev, "failed to xmit URB %u: %pe\n",
+			    txc->echo_id, ERR_PTR(urb->status));
+
+	netdev->stats.tx_dropped++;
+	netdev->stats.tx_errors++;
+
+	can_free_echo_skb(netdev, txc->echo_id, NULL);
+	gs_free_tx_context(txc);
+	atomic_dec(&dev->active_tx_urbs);
+
+	netif_wake_queue(netdev);
 }
 
 static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,

-- 
2.51.0


