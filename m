Return-Path: <linux-can+bounces-6189-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75501D385FD
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 20:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 134A53035A82
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 19:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8EA3A1E63;
	Fri, 16 Jan 2026 19:35:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9AC34AB1E
	for <linux-can@vger.kernel.org>; Fri, 16 Jan 2026 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768592159; cv=none; b=UUxqREyRvVSGc13SI/kyeaYgZLt28v4CWpbJg+t3gurwjo4SvhHEf9DuqQF4dYYUUEXW9dKpzqu2NOel/NMYWrDck439944FtBiZkM5Z4mSg3BrvxIJxt41MTIeIyJqy0m1CdI8lHNke5PtUr6WGBLW26mOAU821mI2Snw2PJ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768592159; c=relaxed/simple;
	bh=zHH4+sI9VkLKWmaHTffypGgqFMLyrd7a8GCEonrR1go=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cEHS6hiUubttvvKk4Z1xZS1S5z8jUxVNnFOv+Mm2OTOaBRBa028VZumR1EYwyRtY+CAJ69Bi6ZfkYKsdY+aMU3l5uXHUdP6WawEmqglf55bElEtVegDUM9DkXD3RX2+EGNge6+U2f/xizHLosOrAOOTXD25OZ0ANwdxqLCk2Iy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgpbi-000803-HH; Fri, 16 Jan 2026 20:35:42 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgpbg-000yK5-1N;
	Fri, 16 Jan 2026 20:35:39 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 73F974CEEE1;
	Fri, 16 Jan 2026 19:35:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 16 Jan 2026 20:35:16 +0100
Subject: [PATCH can v2 3/5] can: kvaser_usb:
 kvaser_usb_read_bulk_callback(): fix URB memory leak
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-can_usb-fix-memory-leak-v2-3-4b8cb2915571@pengutronix.de>
References: <20260116-can_usb-fix-memory-leak-v2-0-4b8cb2915571@pengutronix.de>
In-Reply-To: <20260116-can_usb-fix-memory-leak-v2-0-4b8cb2915571@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2140; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=zHH4+sI9VkLKWmaHTffypGgqFMLyrd7a8GCEonrR1go=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpapMFKRzgtYb63gusilRUJ8jurXP8rjPUl7+Ym
 EWzeBUEoS+JATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaWqTBQAKCRAMdGXf+ZCR
 nBtqB/wNjsAlp+j/1htaTot/qQ2n1TLAvOIQ4ix+hE71uFz1X4gxh7GyO8J6nuMEJ4u0VDzELp+
 JR/G+jMMa60y57VH0b3IVOHBAiXyD0V5oZhqpsuVN96DCrMMvBJhee/Tyfbj0YD7FILnNNuXKkw
 TLmYD7z8FEixM9Jsp+odvLaH1LUnmI9nFifprN5fDXJZwi1QewbJPJqxogzZmRrB2GUuaSjEFkm
 eAF5dnzLB1YkGW21gK8NppHf8FCLU6a7FCvNHv/f0Jc+kAQZYhXKZSdMR/8SJLlPxqRR7yJF+X9
 utHyAnjRRl+q5Q2jU8KMDF1hcBW1u6Oa05SJTJogGShF8cn+
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
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 62701ec34272..d0a2a2a33c1c 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -361,7 +361,14 @@ static void kvaser_usb_read_bulk_callback(struct urb *urb)
 			  urb->transfer_buffer, KVASER_USB_RX_BUFFER_SIZE,
 			  kvaser_usb_read_bulk_callback, dev);
 
+	usb_anchor_urb(urb, &dev->rx_submitted);
+
 	err = usb_submit_urb(urb, GFP_ATOMIC);
+	if (!err)
+		return;
+
+	usb_unanchor_urb(urb);
+
 	if (err == -ENODEV) {
 		for (i = 0; i < dev->nchannels; i++) {
 			struct kvaser_usb_net_priv *priv;
@@ -372,7 +379,7 @@ static void kvaser_usb_read_bulk_callback(struct urb *urb)
 
 			netif_device_detach(priv->netdev);
 		}
-	} else if (err) {
+	} else {
 		dev_err(&dev->intf->dev,
 			"Failed resubmitting read bulk urb: %d\n", err);
 	}

-- 
2.51.0


