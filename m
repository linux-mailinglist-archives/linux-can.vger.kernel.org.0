Return-Path: <linux-can+bounces-2866-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7B2A3BCF3
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 12:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C94F7A2EF3
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 11:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AC51E0E01;
	Wed, 19 Feb 2025 11:34:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558FC1DFE02
	for <linux-can@vger.kernel.org>; Wed, 19 Feb 2025 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964848; cv=none; b=pys+xgOSwCkk5ERnjttd9jDud727cyhm/H4IcjhCxQ/qdwWDnTeLR7Oh1JNklb768kxyqV57CSallMxSB84sZCQOKcyP00ma/tCbDXZ7F8TCZTv8BCWYYiOLZutYNqQNmT0MqbPkfSuvaF6klnCuooY8/q9LKdx2kpFXE2UtCl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964848; c=relaxed/simple;
	bh=A4V05bCo3VpoIet0i3HmhC4m1+4hsJ2F1uidDOMGebk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fayTRYxgkDHt7f8jyOathXVap3EnCHGC+NZVsARa+xLFkqDCX8dIOBL7SRzA2gI0H/BK1/266qDgTGlsczlRkUnFHlmlVEnet4DzqL19RImBDZGMEeAsuMEKKLrwUaO/p0Mp4bcNrEauuX09aujctButqqxnSKOsUczvLbWZRPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkiL5-0001bX-Mt
	for linux-can@vger.kernel.org; Wed, 19 Feb 2025 12:34:03 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkiL3-001l2f-2b
	for linux-can@vger.kernel.org;
	Wed, 19 Feb 2025 12:34:01 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 6F4B63C6942
	for <linux-can@vger.kernel.org>; Wed, 19 Feb 2025 11:34:01 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 17BAC3C68EE;
	Wed, 19 Feb 2025 11:33:58 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id bc1ee5fb;
	Wed, 19 Feb 2025 11:33:56 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Henrik Brix Andersen <henrik@brixandersen.dk>,
	Sean Nyekjaer <sean@geanix.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 11/12] can: gs_usb: add VID/PID for the CANnectivity firmware
Date: Wed, 19 Feb 2025 12:21:16 +0100
Message-ID: <20250219113354.529611-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250219113354.529611-1-mkl@pengutronix.de>
References: <20250219113354.529611-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Henrik Brix Andersen <henrik@brixandersen.dk>

Add USB VID/PID for the CANnectivity USB to CAN adapter firmware.

Signed-off-by: Henrik Brix Andersen <henrik@brixandersen.dk>
Tested-by: Sean Nyekjaer <sean@geanix.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20250120133827.668977-1-henrik@brixandersen.dk
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index b6f4de375df7..3ccac6781b98 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -43,6 +43,9 @@
 #define USB_XYLANTA_SAINT3_VENDOR_ID 0x16d0
 #define USB_XYLANTA_SAINT3_PRODUCT_ID 0x0f30
 
+#define USB_CANNECTIVITY_VENDOR_ID 0x1209
+#define USB_CANNECTIVITY_PRODUCT_ID 0xca01
+
 /* Timestamp 32 bit timer runs at 1 MHz (1 µs tick). Worker accounts
  * for timer overflow (will be after ~71 minutes)
  */
@@ -1546,6 +1549,8 @@ static const struct usb_device_id gs_usb_table[] = {
 				      USB_ABE_CANDEBUGGER_FD_PRODUCT_ID, 0) },
 	{ USB_DEVICE_INTERFACE_NUMBER(USB_XYLANTA_SAINT3_VENDOR_ID,
 				      USB_XYLANTA_SAINT3_PRODUCT_ID, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(USB_CANNECTIVITY_VENDOR_ID,
+				      USB_CANNECTIVITY_PRODUCT_ID, 0) },
 	{} /* Terminating entry */
 };
 
-- 
2.47.2



