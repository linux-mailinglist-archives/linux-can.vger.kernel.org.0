Return-Path: <linux-can+bounces-503-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D764D8B5FC0
	for <lists+linux-can@lfdr.de>; Mon, 29 Apr 2024 19:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619C51F21E47
	for <lists+linux-can@lfdr.de>; Mon, 29 Apr 2024 17:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AA51272A5;
	Mon, 29 Apr 2024 17:11:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A15486260
	for <linux-can@vger.kernel.org>; Mon, 29 Apr 2024 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410680; cv=none; b=WO5VZRzNTX9OrFu2EUF24iz0CD9YYVYvAPbbzNATq5yV0JZCcU6trRyEC660avoB12hUsPSLlabe7eqB1GcHZbUzj8U4F0p1+xUB1HTALcZHW2sM65dDHEiBmkNDqpsiZMGuNV5rEXmCqSq0sYnHE/0d2vziRpODGFPlplooe0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410680; c=relaxed/simple;
	bh=uqIhYQS/z54vnGq5iVJeal7CQfbwhOb7ZxfLpKBahPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FYBt/hPEiMLgg1FCfsJLUlIhPgNTnHspXzR23pvd58n3ltGFgfw98DQccdmT0yp+eP0GFQMlWxCMdd8jvQwTNU9yDwga9kUQa7tgbPNysJnp02TBe3Br1Y//FchTSkvVlcKIWUcR49jU6aPYO6EH0r1/Vnydf7QDt7btHaFpJjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1s1UX4-00016b-I1
	for linux-can@vger.kernel.org; Mon, 29 Apr 2024 19:11:14 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1s1UX4-00F1Hp-2C
	for linux-can@vger.kernel.org; Mon, 29 Apr 2024 19:11:14 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id BEE9F2C22F2
	for <linux-can@vger.kernel.org>; Mon, 29 Apr 2024 17:11:13 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 500762C22DB;
	Mon, 29 Apr 2024 17:11:12 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 430e5ab0;
	Mon, 29 Apr 2024 17:11:11 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 29 Apr 2024 19:10:58 +0200
Subject: [PATCH 2/3] can: mcp251xfd: move
 mcp251xfd_timestamp_start()/stop() into mcp251xfd_chip_start/stop()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240429-mcp251xfd-runtime_pm-v1-2-c26a93a66544@pengutronix.de>
References: <20240429-mcp251xfd-runtime_pm-v1-0-c26a93a66544@pengutronix.de>
In-Reply-To: <20240429-mcp251xfd-runtime_pm-v1-0-c26a93a66544@pengutronix.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4143; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=uqIhYQS/z54vnGq5iVJeal7CQfbwhOb7ZxfLpKBahPU=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmL9SoWHZYmjqq0lFdx2nbfFoiOmkN6eg8pRUSo
 o0t5nIPnFmJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZi/UqAAKCRAoOKI+ei28
 b+pPB/9STtCwHXrutk7X+vJmB2GITJy7DVuFxEx+YmvIdgLQZdwNdbfgVsjTCZ7dtuLoiaHyR8O
 g060MAE/9tfamcWuCQdVZaRCivGebLtvzcTCITpttK6AmQHSRklssN9Hctu7V3PLbBVXTpLrQPO
 4Wb5DyaVynNhEPkUjRiedLx4bKgKlB4qLOLvaFx1MNKH95uEiV4KfzlrEIs0ZlTYntH/weySRA3
 z2yzwed1tsa9I3r5dvFeIbg0BXWgqppl8pQjZ4eGTCM3/xGLQ9U/+fF/qBF1/JgEn7NFbIyrta6
 qFIBBINOL+bVmeGwbEOTYEgEdh4T6IrDlgNga93LjajJXIQ7
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

The mcp251xfd wakes up from Low Power or Sleep Mode when SPI activity
is detected. To avoid this, make sure that the timestamp worker is
stopped before shutting down the chip.

Split the starting of the timestamp worker out of
mcp251xfd_timestamp_init() into the separate function
mcp251xfd_timestamp_start().

Call mcp251xfd_timestamp_init() before mcp251xfd_chip_start(), move
mcp251xfd_timestamp_start() to mcp251xfd_chip_start(). In this way,
mcp251xfd_timestamp_stop() can be called unconditionally by
mcp251xfd_chip_stop().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c      | 8 +++++---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c | 7 +++++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h           | 1 +
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index e3c791f562d2..4ae201426a46 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -744,6 +744,7 @@ static void mcp251xfd_chip_stop(struct mcp251xfd_priv *priv,
 
 	mcp251xfd_chip_interrupts_disable(priv);
 	mcp251xfd_chip_rx_int_disable(priv);
+	mcp251xfd_timestamp_stop(priv);
 	mcp251xfd_chip_sleep(priv);
 }
 
@@ -763,6 +764,8 @@ static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
 	if (err)
 		goto out_chip_stop;
 
+	mcp251xfd_timestamp_start(priv);
+
 	err = mcp251xfd_set_bittiming(priv);
 	if (err)
 		goto out_chip_stop;
@@ -1610,11 +1613,12 @@ static int mcp251xfd_open(struct net_device *ndev)
 	if (err)
 		goto out_mcp251xfd_ring_free;
 
+	mcp251xfd_timestamp_init(priv);
+
 	err = mcp251xfd_chip_start(priv);
 	if (err)
 		goto out_transceiver_disable;
 
-	mcp251xfd_timestamp_init(priv);
 	clear_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
 	can_rx_offload_enable(&priv->offload);
 
@@ -1637,7 +1641,6 @@ static int mcp251xfd_open(struct net_device *ndev)
 out_can_rx_offload_disable:
 	can_rx_offload_disable(&priv->offload);
 	set_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
-	mcp251xfd_timestamp_stop(priv);
 out_transceiver_disable:
 	mcp251xfd_transceiver_disable(priv);
 out_mcp251xfd_ring_free:
@@ -1662,7 +1665,6 @@ static int mcp251xfd_stop(struct net_device *ndev)
 	mcp251xfd_chip_interrupts_disable(priv);
 	free_irq(ndev->irq, priv);
 	can_rx_offload_disable(&priv->offload);
-	mcp251xfd_timestamp_stop(priv);
 	mcp251xfd_chip_stop(priv, CAN_STATE_STOPPED);
 	mcp251xfd_transceiver_disable(priv);
 	mcp251xfd_ring_free(priv);
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
index 712e09186987..7bbf4603038b 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
@@ -58,9 +58,12 @@ void mcp251xfd_timestamp_init(struct mcp251xfd_priv *priv)
 	cc->shift = 1;
 	cc->mult = clocksource_hz2mult(priv->can.clock.freq, cc->shift);
 
-	timecounter_init(&priv->tc, &priv->cc, ktime_get_real_ns());
-
 	INIT_DELAYED_WORK(&priv->timestamp, mcp251xfd_timestamp_work);
+}
+
+void mcp251xfd_timestamp_start(struct mcp251xfd_priv *priv)
+{
+	timecounter_init(&priv->tc, &priv->cc, ktime_get_real_ns());
 	schedule_delayed_work(&priv->timestamp,
 			      MCP251XFD_TIMESTAMP_WORK_DELAY_SEC * HZ);
 }
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 24510b3b8020..75d5a8a25415 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -950,6 +950,7 @@ int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv);
 void mcp251xfd_skb_set_timestamp(const struct mcp251xfd_priv *priv,
 				 struct sk_buff *skb, u32 timestamp);
 void mcp251xfd_timestamp_init(struct mcp251xfd_priv *priv);
+void mcp251xfd_timestamp_start(struct mcp251xfd_priv *priv);
 void mcp251xfd_timestamp_stop(struct mcp251xfd_priv *priv);
 
 netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,

-- 
2.43.0



