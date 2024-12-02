Return-Path: <linux-can+bounces-2305-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 835ED9DFC9A
	for <lists+linux-can@lfdr.de>; Mon,  2 Dec 2024 10:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B20281D35
	for <lists+linux-can@lfdr.de>; Mon,  2 Dec 2024 09:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069BC1FAC59;
	Mon,  2 Dec 2024 09:00:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1421F9ECD
	for <linux-can@vger.kernel.org>; Mon,  2 Dec 2024 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733130055; cv=none; b=sFJ3HzwSHLujM27+upoN476U6ydU4ygm4/UybTTShb4tEYXahcWOE93dSX0i9/rzL71S4pCew7t3MChSu1obqotrTivSbq3PKxzMtk6XVmJIQjXeLiYurDgiwK4GR46lhpyBEihjCJV5orv/0sFkjrTQMRKOiCqYJhBchDIMz54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733130055; c=relaxed/simple;
	bh=vCaRM3dJJWxIrxCNSOy28UpqmLqEZk+IENGtsIy6qDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dACAlXHKzqST1yEUSWAe1ngHZsHwbI5CQI6lzj9ve7t6BSJF93dCxCox2LlMfuRqOb8hRLU2rkU053F2ZuVDSQVUusnVxCRQIP+okkOdhau+Z41j7c0tpNLKCnyLUwSrI10+PzW/woxqWeWIjsbqautyvyWlbAFzn/jYWg/ZVto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tI2IV-0007gY-Fy
	for linux-can@vger.kernel.org; Mon, 02 Dec 2024 10:00:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tI2IS-001GbE-06
	for linux-can@vger.kernel.org;
	Mon, 02 Dec 2024 10:00:48 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 67ADE38338A
	for <linux-can@vger.kernel.org>; Mon, 02 Dec 2024 09:00:48 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id A03BD383332;
	Mon, 02 Dec 2024 09:00:45 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f6d2fa87;
	Mon, 2 Dec 2024 09:00:44 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 11/15] can: sun4i_can: sun4i_can_err(): fix {rx,tx}_errors statistics
Date: Mon,  2 Dec 2024 09:55:45 +0100
Message-ID: <20241202090040.1110280-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241202090040.1110280-1-mkl@pengutronix.de>
References: <20241202090040.1110280-1-mkl@pengutronix.de>
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

From: Dario Binacchi <dario.binacchi@amarulasolutions.com>

The sun4i_can_err() function only incremented the receive error counter
and never the transmit error counter, even if the STA_ERR_DIR flag
reported that an error had occurred during transmission.

Increment the receive/transmit error counter based on the value of the
STA_ERR_DIR flag.

Fixes: 0738eff14d81 ("can: Allwinner A10/A20 CAN Controller support - Kernel module")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://patch.msgid.link/20241122221650.633981-11-dario.binacchi@amarulasolutions.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sun4i_can.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 17f94cca93fb..4311c1f0eafd 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -579,11 +579,9 @@ static int sun4i_can_err(struct net_device *dev, u8 isrc, u8 status)
 		/* bus error interrupt */
 		netdev_dbg(dev, "bus error interrupt\n");
 		priv->can.can_stats.bus_error++;
-		stats->rx_errors++;
+		ecc = readl(priv->base + SUN4I_REG_STA_ADDR);
 
 		if (likely(skb)) {
-			ecc = readl(priv->base + SUN4I_REG_STA_ADDR);
-
 			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
 			switch (ecc & SUN4I_STA_MASK_ERR) {
@@ -601,9 +599,15 @@ static int sun4i_can_err(struct net_device *dev, u8 isrc, u8 status)
 					       >> 16;
 				break;
 			}
-			/* error occurred during transmission? */
-			if ((ecc & SUN4I_STA_ERR_DIR) == 0)
+		}
+
+		/* error occurred during transmission? */
+		if ((ecc & SUN4I_STA_ERR_DIR) == 0) {
+			if (likely(skb))
 				cf->data[2] |= CAN_ERR_PROT_TX;
+			stats->tx_errors++;
+		} else {
+			stats->rx_errors++;
 		}
 	}
 	if (isrc & SUN4I_INT_ERR_PASSIVE) {
-- 
2.45.2



