Return-Path: <linux-can+bounces-654-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA548CAEDB
	for <lists+linux-can@lfdr.de>; Tue, 21 May 2024 15:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54E71F23467
	for <lists+linux-can@lfdr.de>; Tue, 21 May 2024 13:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278FA78C89;
	Tue, 21 May 2024 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="FSTBtDQr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="i7vkarm/"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1CE74E09;
	Tue, 21 May 2024 13:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296720; cv=none; b=L6L47kvNk7zViR0G4w7IhNxcEh8mbYg8MF87EevKpODw+HDYtaS7RO4KOPu+ZIk9eTu0iNCP/7kU0vBy8I20koA3jnb31NovgzMUli9s+4BNNL0Cf4gixt6CdAHB6Jc5rgD4fm0RsxAB1Bkdcy4wPI6QcQ9Q+VJCZhS6BWjXOnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296720; c=relaxed/simple;
	bh=NzMPYKXpTCqFoVng85NipKKUTY10wS1q1TVILzDVkP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q/V6JE5H8kM1MsPZqG8zUPcAPjyK2f6DLYF4DYrTjisQ9dOaTSsazicIrkkJ+M/lPidD0V6DEyvTJNFy9nizBbuFOmwwg2+AwFd90CDG/wT1GMD9LEpjA/al9l67USFe7mGtb2q4mO/dKMTUW8QyT+yU8gzny/Y8cGRWZ6c/xYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=FSTBtDQr; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=i7vkarm/ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1716296717; x=1747832717;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=wbT5qGCbQ3w8gzwJLUsRH+xmTZWMepfT4VHSrrwEvqs=;
  b=FSTBtDQrVf7xBKK0gJAYyMxo8WE1Zt9S0xXcpBulixCUtmGUkPjq7523
   0brlaRzcSdHWlp9xv1KwqsyYNkiEDHZxvTkkCNGhmxIXRJvU+5nPdr/q1
   upcHVpQbrNVFRvlP/JQogmbDt7mtLd0g2jnrhdYDSIRcjx5o+MwcTv88k
   00/SL3WszA4BTEFjFor7fDZ8gg0HItrzLqS3hBnefuT+POXTPlmCV44rg
   tHfuNwEsm49OhKF1eMOzUeqdQ0VnYK2TzXXwg4Nf7Kbg5yPSQlmKAde/G
   mI50CdTZ7jo7BB5bRVy54jspe9f2g3I6bOPYm3fao87c1VZibueCx9U5E
   A==;
X-CSE-ConnectionGUID: DhogtdyYQqqfaWst8OedGg==
X-CSE-MsgGUID: RzSFwDAQRBGeg3XrburrVg==
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; 
   d="scan'208";a="36993956"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 21 May 2024 15:05:13 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BA48417571D;
	Tue, 21 May 2024 15:05:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1716296709;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wbT5qGCbQ3w8gzwJLUsRH+xmTZWMepfT4VHSrrwEvqs=;
	b=i7vkarm/1GguVGHK9iBjp6ahnWmfgfetORVMu8ee5oBHqJ9lUo9eSnLZZ6BsUNPd4xGwPN
	ghAJgeYVHeczvzLT6h3aridlcfHTjHXYXoUeiGQ3SU36EPOyHSq3LcJyFylFpXiZHT2iXu
	92TKe12hRRbr2ue9VGQmnRS0zznMLBwx0Bfg9UzIzA2UeBqja2SbFSzjgUrlZ0mjggstmC
	ttVJBJdZeAC3g+j17aZ6k6ACFv0Ym99UWH8+uvwwugbI7hmGFhcxvjefvbGR7/s76ZBE0m
	LksU9nNOovSn3fScK3aPvs25MOVwaFwL+FD57vKb7lsq4VzNsY9Nwx/qavA9Ng==
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date: Tue, 21 May 2024 15:04:52 +0200
Subject: [PATCH v3 2/8] can: mcp251xfd: move
 mcp251xfd_timestamp_start()/stop() into mcp251xfd_chip_start/stop()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-mcp251xfd-gpio-feature-v3-2-7f829fefefc2@ew.tq-group.com>
References: <20240521-mcp251xfd-gpio-feature-v3-0-7f829fefefc2@ew.tq-group.com>
In-Reply-To: <20240521-mcp251xfd-gpio-feature-v3-0-7f829fefefc2@ew.tq-group.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux@ew.tq-group.com, gregor.herburger@ew.tq-group.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716296697; l=4211;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=6jCsan+AmNK3z1pPyB+Muv4Lzg8cC/bnZRRhEIGbMRw=;
 b=tdbi2iqFtgFjEUgrzh8pbhRwl3F9k4jb68vlTVIgaQ3ayTPLD9u7RyLcpifz4SyztIwFA0usF
 pMQUaq6pkHUCBql8l6z+Qyfo12yRzDaVSI3b6TYroTMbT2Zli6B010X
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Last-TLS-Session-Version: TLSv1.3

From: Marc Kleine-Budde <mkl@pengutronix.de>

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
Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
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
2.34.1


