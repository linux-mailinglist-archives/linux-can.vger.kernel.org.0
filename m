Return-Path: <linux-can+bounces-6096-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 628CBD0D9D9
	for <lists+linux-can@lfdr.de>; Sat, 10 Jan 2026 18:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8E2D301F3F2
	for <lists+linux-can@lfdr.de>; Sat, 10 Jan 2026 17:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E012BD033;
	Sat, 10 Jan 2026 17:29:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA43292B54
	for <linux-can@vger.kernel.org>; Sat, 10 Jan 2026 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768066192; cv=none; b=impBzyJYXTdMkmpGMwxVC8JUbkH/JsLeu3gpGj5qQgzQzDwwo/92A+72/3IkGfu7fHr8IxbJGJ0cimfjpHZF+V0WFMeyfJRkvg3r6jAeKI2ooarTXoH9kduP6yWJDeBRWEMtxdeF1RQy6UQdf34ufkOlvCO9DQA0BF/rUbynTRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768066192; c=relaxed/simple;
	bh=3EgaE++Z5C+HH/5AV78kZyWIMoDtSGh5zMd6nygDiwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LkOTAFW2mVH5hkM3WXyl8E7Z1sF5mBIuch/vSeDCIIHf7fjfyLbqWk5gRQOdnkoAGvmuaGoue8gfuEmvYsmtuyfKbfUux8gkOjvA/K5xyiNeZQntz918+Ase/q6a3Kns/fkZVlEnNsI9LgQ9z2ksOThIiNOO/Fvxwvas4OQ/Qd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vecm7-0004Jo-T9; Sat, 10 Jan 2026 18:29:19 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vecm7-00AEGZ-1l;
	Sat, 10 Jan 2026 18:29:19 +0100
Received: from hardanger.blackshift.org (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A2DF94CA208;
	Sat, 10 Jan 2026 17:29:18 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 10 Jan 2026 18:28:56 +0100
Subject: [PATCH can 5/5] can: usb_8dev: usb_8dev_read_bulk_callback(): fix
 URB memory leak
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-can_usb-fix-memory-leak-v1-5-4a7c082a7081@pengutronix.de>
References: <20260110-can_usb-fix-memory-leak-v1-0-4a7c082a7081@pengutronix.de>
In-Reply-To: <20260110-can_usb-fix-memory-leak-v1-0-4a7c082a7081@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 Sebastian Haas <haas@ems-wuensche.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Frank Jungclaus <frank.jungclaus@esd.eu>, socketcan@esd.eu, 
 Yasushi SHOJI <yashi@spacecubics.com>, Daniel Berglund <db@kvaser.com>, 
 Olivier Sobrie <olivier@sobrie.be>, 
 =?utf-8?q?Remigiusz_Ko=C5=82=C5=82=C4=85taj?= <remigiusz.kollataj@mobica.com>, 
 Bernd Krumboeck <b.krumboeck@gmail.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1616; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=3EgaE++Z5C+HH/5AV78kZyWIMoDtSGh5zMd6nygDiwA=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpYoxofF/0iTljBo2zuI1zmf1QmmIcb3NblJSYh
 QGTjjzPBvmJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaWKMaAAKCRAMdGXf+ZCR
 nGyiB/9iQYl3aFkXGZFpD8mLB91RMysUul7kkUVWmet55TrGF//icbvtI63JZeMZbm1zUyy3WNg
 x+Vu7C5w9djvy/7BvqS+HBSJ8B0SXTp6SH+7zkwI8oofW22IfyLm/TTbZJAchELWNi82i7bGd7/
 72WLOHAbnDYoXaoLRQ2429PsS9+ML8lslKlqdJVyTu3BVtNTTSQ3JVO/fFWy339E/nkEFYaSGRr
 iEOWogruhszdYOgMbQOi9K635lRljCcbwuANDWadAnnsjrLgZwW2XYcwTKCcUa5ckDS0rL3mCu9
 z3Bzoencq2EE3M+b9uHu/W66rcCK5Y45c7tqigtNy5ZhZhkj
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Fix similar memory leak as in commit 7352e1d5932a ("can: gs_usb:
gs_usb_receive_bulk_callback(): fix URB memory leak").

In usb_8dev_open() -> usb_8dev_start(), the URBs for USB-in transfers are
allocated, added to the priv->rx_submitted anchor and submitted. In the
complete callback usb_8dev_read_bulk_callback(), the URBs are processed and
resubmitted. In usb_8dev_close() -> unlink_all_urbs() the URBs are freed by
calling usb_kill_anchored_urbs(&priv->rx_submitted).

However, this does not take into account that the USB framework unanchors
the URB before the complete function is called. This means that once an
in-URB has been completed, it is no longer anchored and is ultimately not
released in usb_kill_anchored_urbs().

Fix the memory leak by anchoring the URB in the
usb_8dev_read_bulk_callback() to the priv->rx_submitted anchor.

Fixes: 0024d8ad1639 ("can: usb_8dev: Add support for USB2CAN interface from 8 devices")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/usb_8dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
index 7449328f7cd7..f5896416a780 100644
--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -541,6 +541,8 @@ static void usb_8dev_read_bulk_callback(struct urb *urb)
 			  urb->transfer_buffer, RX_BUFFER_SIZE,
 			  usb_8dev_read_bulk_callback, priv);
 
+	usb_anchor_urb(urb, &priv->rx_submitted);
+
 	retval = usb_submit_urb(urb, GFP_ATOMIC);
 
 	if (retval == -ENODEV)

-- 
2.51.0


