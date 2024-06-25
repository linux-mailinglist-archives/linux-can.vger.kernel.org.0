Return-Path: <linux-can+bounces-860-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6EB9169DF
	for <lists+linux-can@lfdr.de>; Tue, 25 Jun 2024 16:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FCEA1F21B14
	for <lists+linux-can@lfdr.de>; Tue, 25 Jun 2024 14:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCE715FA74;
	Tue, 25 Jun 2024 14:09:01 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84521B7F7
	for <linux-can@vger.kernel.org>; Tue, 25 Jun 2024 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324541; cv=none; b=gLlsbMDZcyD447ukN8dVtO3Xd5eJ+mFEHg36yLE3cLMo9ZcZ5tyIYi5DFFCFQDlxxmdh8q5eyhPMtqLdDWKUfTKZiJ2k7QckEI/ektQrica+j5G4vCFl56VTDJg3lQZLUc/1I1OsRT883rTOKPz6pFfL6xFrxBNZmC2BJWgL6yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324541; c=relaxed/simple;
	bh=MuRcUy0s1GlhQULGWIHUnrGk6bSB/LNJD8SsYi42p5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fq+TJxGO1Oj6TB73/KRFbPF6RWlwhIQmazWII231UYr2a77RkAYYLmC9gjtLUlcCNpnpV6XzbPe8a3dBaxnqDMz4kTqBki97b7R59c7WmonLhh93EGiae2CtPdtMEcPQsvB+xkyt2OaBZMq0rdM+EVxs6eD/7dvXF8XKo9oI0qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sM6qt-0007OE-U6
	for linux-can@vger.kernel.org; Tue, 25 Jun 2024 16:08:55 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sM6qt-004uCo-H5
	for linux-can@vger.kernel.org; Tue, 25 Jun 2024 16:08:55 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 2C76D2F26AF
	for <linux-can@vger.kernel.org>; Tue, 25 Jun 2024 14:08:55 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 8C3B82F26AC;
	Tue, 25 Jun 2024 14:08:54 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 16584517;
	Tue, 25 Jun 2024 14:08:53 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Andy Jackson <andy@xylanta.com>,
	Ken Aitchison <ken@xylanta.com>
Subject: [PATCH] can: gs_usb: add VID/PID for Xylanta SAINT3 product family
Date: Tue, 25 Jun 2024 16:03:52 +0200
Message-ID: <20240625140353.769373-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
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

Add support for the Xylanta SAINT3 product family.

Cc: Andy Jackson <andy@xylanta.com>
Cc: Ken Aitchison <ken@xylanta.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 65c962f76898..340297e3bec7 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -40,6 +40,9 @@
 #define USB_ABE_CANDEBUGGER_FD_VENDOR_ID 0x16d0
 #define USB_ABE_CANDEBUGGER_FD_PRODUCT_ID 0x10b8
 
+#define USB_XYLANTA_SAINT3_VENDOR_ID 0x16d0
+#define USB_XYLANTA_SAINT3_PRODUCT_ID 0x0f30
+
 #define GS_USB_ENDPOINT_IN 1
 #define GS_USB_ENDPOINT_OUT 2
 
@@ -1530,6 +1533,8 @@ static const struct usb_device_id gs_usb_table[] = {
 				      USB_CES_CANEXT_FD_PRODUCT_ID, 0) },
 	{ USB_DEVICE_INTERFACE_NUMBER(USB_ABE_CANDEBUGGER_FD_VENDOR_ID,
 				      USB_ABE_CANDEBUGGER_FD_PRODUCT_ID, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(USB_XYLANTA_SAINT3_VENDOR_ID,
+				      USB_XYLANTA_SAINT3_PRODUCT_ID, 0) },
 	{} /* Terminating entry */
 };
 
-- 
2.43.0



