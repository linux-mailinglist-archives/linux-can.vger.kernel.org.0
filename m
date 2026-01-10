Return-Path: <linux-can+bounces-6097-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D2FD0D9DC
	for <lists+linux-can@lfdr.de>; Sat, 10 Jan 2026 18:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92266301B676
	for <lists+linux-can@lfdr.de>; Sat, 10 Jan 2026 17:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32564296BD4;
	Sat, 10 Jan 2026 17:29:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBBA296BBB
	for <linux-can@vger.kernel.org>; Sat, 10 Jan 2026 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768066193; cv=none; b=lum4O9VbvQwuk9Rp74C9KRiDnzlM2ccitfr90voos5Jp3ei2yb51h2cCVYH5GlXOXFgJyK9KlMieRhBnqtfS+Gl7LA78MKoN4DLjgrMJCbFvhLXKr3UL+DKNAyAkXK8XMkO+fhSUAUyCq61zg9X2QLZObn/iu2xbkNEVc50pfbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768066193; c=relaxed/simple;
	bh=KbzRlV+NZsQXG10eptueM6fP9/Gf2kPzyb3mAiMVPeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XvKth6UPuEp9hNeS3kPoiwItP2XwGevezMoxO3h6SboJ6tHKEqi1p9qRl+MIdMU4iGFDoTIyWgpIR8T8lsDf63EjnuAv39hwNbinXR1txvYwkyUs1SAtdh2TUckfH7/NBXOJEyQ8+YP7dWwK0MEYAg2+lC3pGVV+nXESI3Reetk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vecm6-0004JW-9L; Sat, 10 Jan 2026 18:29:18 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vecm5-00AEGO-31;
	Sat, 10 Jan 2026 18:29:17 +0100
Received: from hardanger.blackshift.org (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 128764CA206;
	Sat, 10 Jan 2026 17:29:17 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 10 Jan 2026 18:28:54 +0100
Subject: [PATCH can 3/5] can: kvaser_usb: kvaser_usb_read_bulk_callback():
 fix URB memory leak
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-can_usb-fix-memory-leak-v1-3-4a7c082a7081@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1771; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=KbzRlV+NZsQXG10eptueM6fP9/Gf2kPzyb3mAiMVPeY=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpYoxkPmj2p7xDEcKLIXSFNo3NoTqD7t4Ka1fkV
 kj1HNwxVPKJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaWKMZAAKCRAMdGXf+ZCR
 nFspB/4jOevCIMsXPvoc7mWdriuMVjx3ZoMLSU47FFRxiDDrVPLMygIqtjYh/xCU7l6CJjibEfT
 RL7AN42Yh1P2qHIIPf5hpqEQnqw0err5PA3UCKb5QkhlEyQum3ocSoNxfQ/fe69qPq7X3cqQpK4
 sofPm5P9f3kZpg+JRn4/AiVcziLv8OSL4Q74n0iWIi0gcHQIhlFSDvosm/Y66YMEjeSyA824LuU
 WISNbclJx6uwEmFUBlNLTsK1WJ0Gyh592YWGzeekshUowAcnUPo8dtMR/i1n3ERmN0I5/0Nivb8
 BZMYrqMwX1AISz1AhFccKnYffX8h8oPsqHqOQyemnA7zas2m
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Fix similar memory leak as in commit 7352e1d5932a ("can: gs_usb:
gs_usb_receive_bulk_callback(): fix URB memory leak").

In kvaser_usb_set_{,data_}bittiming() -> kvaser_usb_setup_rx_urbs(), the
URBs for USB-in transfers are allocated, added to the dev->rx_submitted
anchor and submitted. In the complete callback
kvaser_usb_read_bulk_callback(), the URBs are processed and resubmitted. In
kvaser_usb_remove_interfaces() the URBs are freed by calling
usb_kill_anchored_urbs(&dev->rx_submitted).

However, this does not take into account that the USB framework unanchors
the URB before the complete function is called. This means that once an
in-URB has been completed, it is no longer anchored and is ultimately not
released in usb_kill_anchored_urbs().

Fix the memory leak by anchoring the URB in the
kvaser_usb_read_bulk_callback() to the dev->rx_submitted anchor.

Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 62701ec34272..0da0abb0bebe 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -361,6 +361,8 @@ static void kvaser_usb_read_bulk_callback(struct urb *urb)
 			  urb->transfer_buffer, KVASER_USB_RX_BUFFER_SIZE,
 			  kvaser_usb_read_bulk_callback, dev);
 
+	usb_anchor_urb(urb, &dev->rx_submitted);
+
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err == -ENODEV) {
 		for (i = 0; i < dev->nchannels; i++) {

-- 
2.51.0


