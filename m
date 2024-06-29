Return-Path: <linux-can+bounces-907-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9C191CC7E
	for <lists+linux-can@lfdr.de>; Sat, 29 Jun 2024 13:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C543B2830C2
	for <lists+linux-can@lfdr.de>; Sat, 29 Jun 2024 11:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F5374BF0;
	Sat, 29 Jun 2024 11:40:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5915A117
	for <linux-can@vger.kernel.org>; Sat, 29 Jun 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719661229; cv=none; b=pGY30EeXANO0J6FWycEly9NrjzVf8e1tA/V2kU9YhuyceLRukwrP3nU5DZohpyaUzoXrBSyYwX5jM5A9w69B3oZkJYTdw2I27ibqvSBxjHTCxqnCMpzeUHl0/9Bm+kJydulcPkVgaPUFONCrQeHzxXhpN8Ts6syLArBixFdXc0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719661229; c=relaxed/simple;
	bh=zr1D6nmtPLOAak2sfYlgyv8Yhg+RfIurmKWJhHc5df0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NiVlgZYsyFmVEROify5J1pRG84heeWhWrFjDhtCpW7ygA+24hOBbT1OSBLVJUc/Jc13j5eFgi1NSRDNmupHUxnlotLThYb/6cmNuZPICTSh7iSl/+xQv8zM0ncvxCY3+Fnfz87zqeD7xqXYMXPryasgH+nNtL71I0TWVNvrfHfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNWRN-00038G-Jp
	for linux-can@vger.kernel.org; Sat, 29 Jun 2024 13:40:25 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNWRL-005paJ-CB
	for linux-can@vger.kernel.org; Sat, 29 Jun 2024 13:40:23 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id E323D2F648B
	for <linux-can@vger.kernel.org>; Sat, 29 Jun 2024 11:40:22 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 0CF5A2F644F;
	Sat, 29 Jun 2024 11:40:21 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 6d2711a2;
	Sat, 29 Jun 2024 11:40:18 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 08/14] can: mcp251xfd: move mcp251xfd_timestamp_start()/stop() into mcp251xfd_chip_start/stop()
Date: Sat, 29 Jun 2024 13:36:22 +0200
Message-ID: <20240629114017.1080160-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240629114017.1080160-1-mkl@pengutronix.de>
References: <20240629114017.1080160-1-mkl@pengutronix.de>
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
index ce1610f240a4..e8e11c32cfda 100644
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
@@ -1611,11 +1614,12 @@ static int mcp251xfd_open(struct net_device *ndev)
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
 
@@ -1649,7 +1653,6 @@ static int mcp251xfd_open(struct net_device *ndev)
 out_can_rx_offload_disable:
 	can_rx_offload_disable(&priv->offload);
 	set_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
-	mcp251xfd_timestamp_stop(priv);
 out_transceiver_disable:
 	mcp251xfd_transceiver_disable(priv);
 out_mcp251xfd_ring_free:
@@ -1675,7 +1678,6 @@ static int mcp251xfd_stop(struct net_device *ndev)
 	free_irq(ndev->irq, priv);
 	destroy_workqueue(priv->wq);
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
index b35bfebd23f2..d6f6b3182e6a 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -954,6 +954,7 @@ int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv);
 void mcp251xfd_skb_set_timestamp(const struct mcp251xfd_priv *priv,
 				 struct sk_buff *skb, u32 timestamp);
 void mcp251xfd_timestamp_init(struct mcp251xfd_priv *priv);
+void mcp251xfd_timestamp_start(struct mcp251xfd_priv *priv);
 void mcp251xfd_timestamp_stop(struct mcp251xfd_priv *priv);
 
 void mcp251xfd_tx_obj_write_sync(struct work_struct *work);
-- 
2.43.0



