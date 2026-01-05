Return-Path: <linux-can+bounces-5995-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8676BCF38D6
	for <lists+linux-can@lfdr.de>; Mon, 05 Jan 2026 13:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8535F3009135
	for <lists+linux-can@lfdr.de>; Mon,  5 Jan 2026 12:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26EA3191C8;
	Mon,  5 Jan 2026 12:36:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9680324B0C
	for <linux-can@vger.kernel.org>; Mon,  5 Jan 2026 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767616565; cv=none; b=o118axm4pqzaMppWt+trFjmA0zeY++XeMnMhVfWvei6SB7pVPR1wXxgIvdTP4+A27hQvtef48FSeo2zlYsCpFKJhAl+aEjcoREuP4PMduAvLgUK7SCbnnFkiL3j/NkvXaHFd8z0DgJ5iwbRJG8ckvfaSjn8j7TA/BvCxfwSztLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767616565; c=relaxed/simple;
	bh=3S6fQNA/wWHdvRZhbZbuHGkM+uaqMWeI6loF/BuCYCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WImZLvMOVcIiEm1ITSZc743npmBYf7rUDD7WWyMlI7/2cMqNJPnt9wfvsCj5YKjhNNDY2PWos9MsnqTEh2E86VUcJ76BXFx5NfozZ8kGgMmbcUEHLyXa0bYu4rn/GJ97mKxyFBWa54lF6HlAS7Eh/DZO7gjxBYt9wl8RlNM7FsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vcjoV-0006qP-5Y; Mon, 05 Jan 2026 13:35:59 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vcjoU-009Afx-38;
	Mon, 05 Jan 2026 13:35:58 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AD0BA4C6627;
	Mon, 05 Jan 2026 12:35:58 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 05 Jan 2026 13:35:54 +0100
Subject: [PATCH can v2] can: gs_usb: gs_usb_receive_bulk_callback(): fix
 URB memory leak
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-gs_usb-fix-memory-leak-v2-1-cc6ed6438034@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIACmwW2kC/4WNUQ6CMBBEr0L22zVtIwJ+eQ9DTGlXqEohXSAYw
 t0teAA/Z/LmzQJMwRHDJVkg0OTYdT4GdUjANNrXhM7GDEqoVCqVYs33kSt8uBlbarvwwTfpF4q
 zMuqUF7kxBcRxHygiu/gGRnsofyWP1ZPMsCk3rHE8RMd+P8kd/vc0SZSos0oUlAkrpL325OtxC
 J1389ESlOu6fgGRNkrT2AAAAA==
X-Change-ID: 20251225-gs_usb-fix-memory-leak-062c24898cc9
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1769; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=3S6fQNA/wWHdvRZhbZbuHGkM+uaqMWeI6loF/BuCYCA=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpW7ArP9SKnqUJwnmwFAHDJwUeqwTkIrTMuzKJ+
 rCEP4E4gfKJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaVuwKwAKCRAMdGXf+ZCR
 nLBwB/4vYuZO+uOkwme7QuiGATLdcX/FjLP8evzu44vzBWXYIndMPE6zMJOgvOjXc8Tamfc+e4K
 Oom2n0mUgzW85qkfilpQvu7AoNzeD11NWppWx2QjsqMgYaBGlcM7f3bdb9wtS/6YcyyphxDzeJX
 Ot10qJBO8yF2aJKOjY91H6F7tkna+AVY9+LGma+5M8fOwi5E1hNYQRrS4i5gAhU3Sd9LZJx2Kvn
 k4KIZSLBPBUFNX0a9qwYCoEmlOUs9qtk69SZqjDWPqcZknoNPfLHgg5h6MlDKY8yBkJSna+xKC7
 YmRa0yQaybY+ix+EH64skc1SoXK1DriTfA+TbJsQQyj992A4
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

In gs_can_open(), the URBs for USB-in transfers are allocated, added to the
parent->rx_submitted anchor and submitted. In the complete callback
gs_usb_receive_bulk_callback(), the URB is processed and resubmitted. In
gs_can_close() the URBs are freed by calling
usb_kill_anchored_urbs(parent->rx_submitted).

However, this does not take into account that the USB framework
unanchors the URB before the close function is called. This means that
once an in-URB has been completed, it is no longer anchored and is
ultimately not released in gs_can_close().

Fix the memory leak by anchoring the URB in the
gs_usb_receive_bulk_callback() to the parent->rx_submitted anchor.

Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v2:
- correct "Fixes" tag
- add stable@v.k.o on Cc
- Link to v1: https://patch.msgid.link/20251225-gs_usb-fix-memory-leak-v1-1-a7b09e70d01d@pengutronix.de
---
 drivers/net/can/usb/gs_usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index a0233e550a5a..d093babbc320 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -751,6 +751,8 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 			  hf, parent->hf_size_rx,
 			  gs_usb_receive_bulk_callback, parent);
 
+	usb_anchor_urb(urb, &parent->rx_submitted);
+
 	rc = usb_submit_urb(urb, GFP_ATOMIC);
 
 	/* USB failure take down all interfaces */

---
base-commit: 1806d210e5a8f431ad4711766ae4a333d407d972
change-id: 20251225-gs_usb-fix-memory-leak-062c24898cc9

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


