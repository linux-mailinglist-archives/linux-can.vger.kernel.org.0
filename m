Return-Path: <linux-can+bounces-665-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2E98CC2F1
	for <lists+linux-can@lfdr.de>; Wed, 22 May 2024 16:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188021C223D5
	for <lists+linux-can@lfdr.de>; Wed, 22 May 2024 14:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBBB1422D1;
	Wed, 22 May 2024 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="lzObuZqJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ZezbdcxI"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC4F1420C9;
	Wed, 22 May 2024 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387377; cv=none; b=ruDdbnJiQxyKf9My0l1heDxhOS/FnjTHskkUHN30hcLP5QLXRMlqh5QmcA1tYT/9vv0UkcNizbJQhljvgsccXMYMpQfi2AI4EkN3Tk9ZHZOmEM/zipXmheJj8vK1eoz/918XTfERLpWUo8s7MQB2WDsYfezpUtEZItaW8Q0FMtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387377; c=relaxed/simple;
	bh=NzMPYKXpTCqFoVng85NipKKUTY10wS1q1TVILzDVkP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZF9kiXFAA8pE/4VZfN8gw9ZrgUsOBcWP3GhBKeZYko6Y/zkZMMSUgkC1lgmPiY67IKBNZvFm6fAYORApfPp6UGKBNTgJREt6Txg2yT4FBrlTNsTjndKwmCZNgqt/P/EatQTkKDmkUXLpDUgUDuO4CF/yUaSVO546O7pttuKQR58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=lzObuZqJ; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ZezbdcxI reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1716387375; x=1747923375;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=wbT5qGCbQ3w8gzwJLUsRH+xmTZWMepfT4VHSrrwEvqs=;
  b=lzObuZqJ2nvxYUBov6xo9JOJwNLOTOlxuhPfviiR2XGc9Yp0DTsWz+NX
   AE8yR5kZbfx4C5YgmX4wp1XMyIRwr9Gm+0NpvK32U8h7+Iguis1i2oHuU
   0Jipom6Ste7uECg2gRZ4hEktmDfd1PSUB3gIA/wSAUvrphSWuJMA54XB8
   b7qm2/cSKstfR7TPrCO4/M/lbQaZRzpllfB1C9RXbvAqGDn7FpPwyTAmc
   E/ulR73D4lBNkivoDg7cmCNHJLBUNx6tkavYfsuGb0sANeipm1008QbCH
   +ax6ws6g70s2gPSffJBCKH0KE1GmtoQ5GnUfCAV0IWiR38Za8UBC/KrIJ
   A==;
X-CSE-ConnectionGUID: uvCL948qQSOE9mEJWFxNrA==
X-CSE-MsgGUID: LA+2zRgqRBiL65s6w03yOA==
X-IronPort-AV: E=Sophos;i="6.08,179,1712613600"; 
   d="scan'208";a="37017662"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 22 May 2024 16:16:11 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF7A5161329;
	Wed, 22 May 2024 16:16:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1716387367;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wbT5qGCbQ3w8gzwJLUsRH+xmTZWMepfT4VHSrrwEvqs=;
	b=ZezbdcxICf8QGitEhwwvC9gejwjYMJEfd2Pdu6FMeSOkJzuGNlTnmpIk1vjzuIlBX8LMH2
	6JvD86S2/BisuJjekEWFJFr0wSiJTsOl15+CWnrBWM32at5GktAXSmGqoYz2IZvQkeCqff
	HP+NFRjxTrKN3bJCkMcapfMPTlwwjpJs4IRuVKZlucKbXSWxTqF4wWvr8nT/Uryb3MevSh
	6Vj52Akqq1d7wkg+oiKCZYNnwNtwkfQec443UN+6O0tSAhyfu4y3VO3zcf4GB/UzRbpRVd
	Xk4v1VF6WGZo4bS8Cf1Lzb3sut2C/Z8zgZOAi9W6VD+LtGJHnfmXDxMkEo5GZw==
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date: Wed, 22 May 2024 16:15:19 +0200
Subject: [PATCH RESEND v3 2/8] can: mcp251xfd: move
 mcp251xfd_timestamp_start()/stop() into mcp251xfd_chip_start/stop()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-mcp251xfd-gpio-feature-v3-2-8829970269c5@ew.tq-group.com>
References: <20240522-mcp251xfd-gpio-feature-v3-0-8829970269c5@ew.tq-group.com>
In-Reply-To: <20240522-mcp251xfd-gpio-feature-v3-0-8829970269c5@ew.tq-group.com>
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
 linux@ew.tq-group.com, gregor.herburger@ew.tq-group.com, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716387339; l=4211;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=6jCsan+AmNK3z1pPyB+Muv4Lzg8cC/bnZRRhEIGbMRw=;
 b=brbCIcuk23DtybmxpGabAvgNpCg7EHOi6CTMds7INhlkrpQeevXaO094j3sxNPvTnm9Y97leW
 spUZT7wnRkZAB31uwrjofcfU+IekbBC+TtFwvvIPlLofpr4fg8VVOOW
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


