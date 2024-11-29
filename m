Return-Path: <linux-can+bounces-2262-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4B99DE665
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 13:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D6F2828A9
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 12:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B2119E826;
	Fri, 29 Nov 2024 12:27:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D578719D093
	for <linux-can@vger.kernel.org>; Fri, 29 Nov 2024 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732883258; cv=none; b=SNch8TYKDj7bW4v/TU0hEYJvwFJU3ilVCh4Yj6Yx1AVFoMxqxqptpTweKI69Ag4dcHSRF8XmJ5ZD8IrdqCyPiJS/mgLoqjpjPLDG6A/woSOjlUzWJf3mPqMHT7ZbG7MCNRQds2ayTNYj2NZ0+3bckoj58zNC9iMSA4k6W4Aaa5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732883258; c=relaxed/simple;
	bh=e1BqDHyEluDtifCwNbEXpWBrYmUn/q0cxNXM8YIVI5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rx4SVUsMhzRXQ/kVR3dlpoZkhX/nKs2SjHmo9F+ZxiLNZPf4MNald3xoVppIcSJGHPSv7n7EtMPpQ+0rokAFVeX125dEm88wmI4pC6PhBC58Nb9v/Ek7PP5jZesPKmEMaD3f86xwuo2ZgN/PiSIcmVCUV8HA1sbfYiL1uh3Ot64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tH05u-0007nh-OP
	for linux-can@vger.kernel.org; Fri, 29 Nov 2024 13:27:34 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tH05s-000miQ-0j
	for linux-can@vger.kernel.org;
	Fri, 29 Nov 2024 13:27:33 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id A9E1638114C
	for <linux-can@vger.kernel.org>; Fri, 29 Nov 2024 12:27:32 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 59FBA381109;
	Fri, 29 Nov 2024 12:27:30 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 72495642;
	Fri, 29 Nov 2024 12:27:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 06/14] can: hi311x: hi3110_can_ist(): update state error statistics if skb allocation fails
Date: Fri, 29 Nov 2024 13:16:53 +0100
Message-ID: <20241129122722.1046050-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241129122722.1046050-1-mkl@pengutronix.de>
References: <20241129122722.1046050-1-mkl@pengutronix.de>
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

Ensure that the statistics related to state error counters
(i. e. warning, passive, and bus-off) are updated even in case the skb
allocation fails. Additionally, also handle bus-off state is now.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://patch.msgid.link/20241122221650.633981-6-dario.binacchi@amarulasolutions.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/hi311x.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index b67464df25ff..25d9b32f5701 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -663,8 +663,6 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 			u8 rxerr, txerr;
 
 			skb = alloc_can_err_skb(net, &cf);
-			if (!skb)
-				break;
 
 			txerr = hi3110_read(spi, HI3110_READ_TEC);
 			rxerr = hi3110_read(spi, HI3110_READ_REC);
@@ -673,14 +671,15 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 			can_change_state(net, cf, tx_state, rx_state);
 
 			if (new_state == CAN_STATE_BUS_OFF) {
-				netif_rx(skb);
+				if (skb)
+					netif_rx(skb);
 				can_bus_off(net);
 				if (priv->can.restart_ms == 0) {
 					priv->force_quit = 1;
 					hi3110_hw_sleep(spi);
 					break;
 				}
-			} else {
+			} else if (skb) {
 				cf->can_id |= CAN_ERR_CNT;
 				cf->data[6] = txerr;
 				cf->data[7] = rxerr;
-- 
2.45.2



