Return-Path: <linux-can+bounces-5319-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE93CC429E2
	for <lists+linux-can@lfdr.de>; Sat, 08 Nov 2025 10:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C40254E31BB
	for <lists+linux-can@lfdr.de>; Sat,  8 Nov 2025 09:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD75288C22;
	Sat,  8 Nov 2025 09:01:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958A01F3FE2
	for <linux-can@vger.kernel.org>; Sat,  8 Nov 2025 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762592481; cv=none; b=tapeNau0MtzGTujuNnFP0SoHghJYtQZAgEacN85AFou16J2pWm+7StU8AwscGDUYncNqP5o24ANHhiqLZKKNCvWkWkpPiLBZBloD2yO4X9H7lSx+DWp7X5Ngg3/56DmY6V1Oe/+0XKd9sSH/3vQWQpuW0UVRmFlUhSSK+AQe6WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762592481; c=relaxed/simple;
	bh=WDo4TwHFuj3APKAWzS/6lAjFmaMs6k2odG1LKzll5U8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uqFuMLAHZ7ZUicnwlSocQ+SPwCvXzuOajNEJ/WtQV9swV+pWac/dutk5TtIHNa0KerMDy3hBkS2jshUZ50JAmVid4nADXMjeYrSrlGbuZe+g+J7hkr8vuWs46GR7qyZmyazHHgtQzVDLr2zoibI1+8JjR/ihy6LKnp/KOnHVrhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vHeor-0004vh-Sr; Sat, 08 Nov 2025 10:01:13 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vHeor-007fMA-0i;
	Sat, 08 Nov 2025 10:01:13 +0100
Received: from hardanger.blackshift.org (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 80F5349A89C;
	Sat, 08 Nov 2025 09:01:12 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 08 Nov 2025 10:01:01 +0100
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
Message-Id: <20251108-gs_usb-fix-usb-callbacks-v1-1-8a2534a7ea05@pengutronix.de>
References: <20251108-gs_usb-fix-usb-callbacks-v1-0-8a2534a7ea05@pengutronix.de>
In-Reply-To: <20251108-gs_usb-fix-usb-callbacks-v1-0-8a2534a7ea05@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-509f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1610; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=WDo4TwHFuj3APKAWzS/6lAjFmaMs6k2odG1LKzll5U8=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpDwbSYL15v69rk/i42dmmgvx/06CTSKRb+jPM6
 Z55z5KEg86JATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaQ8G0gAKCRAMdGXf+ZCR
 nHL3B/9JnmNiWxX6AoSYPL2qw6EZQVr9cJOhgr41dv1w5V4cIeVOwaWPhdQB6MpsVPAO634W9Vg
 XkD8IBOQaiXh7e610/z+LqLiz+K2GI1jAc4CaIsmGWZQbocwYkhyJ67B22qpceT6Xfe/bMB60aL
 dpEsRw9QFx2szOnnBQAgYD2AYVgwPcL1SKICCwsk6ACSC5xstjZLBTSZWglyWGJwxeLBjDriG6b
 2A9b5Uf3RTcufwIJBSDI7iEGAEplLx5CviOuEHKAe2Js2WPC5zUZmizJpuwB6bqmE8kleDlyJ9n
 UmzDki+2AQtpO3ivJ/r37lEB8E8TVj21b3d3gkmcObY2QyJy
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


