Return-Path: <linux-can+bounces-653-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9378CAED7
	for <lists+linux-can@lfdr.de>; Tue, 21 May 2024 15:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8EB62837DF
	for <lists+linux-can@lfdr.de>; Tue, 21 May 2024 13:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5616178C6D;
	Tue, 21 May 2024 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="qTtlRxsm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="OBuziY5Y"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102F754277;
	Tue, 21 May 2024 13:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296719; cv=none; b=IIOr5kq96l6f6QS7ZcPpGmNJY24KRTBe0MD7iC+kKKoGzKT06IPGgKYkZSAkT9LUWNA58D4jxBQboQxRPM+Bu+NmwQ07C8n0TRNFf9+s1+2/BiZinQkxNKwZo3fYyiCdUjfgy3rwcl8XhtV5dAh3W06GVeu59+qiJaxfiVGWCi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296719; c=relaxed/simple;
	bh=aLTA4ay+lwC6FUMJsUdeR4qPDqdp71paaA5dyTkCJ+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NFPWgeeXwTixTn7f5yuAK+OYYjASL460Sy+1dFo1drgS1XumrFigBE4z2YizSqk/zorBNWiXtKSYWjr6WPDVg9l7JNVlAB+8nFj//4N+cwRBLfeDFUphPxCfCkE53MpTzqQ0Trp2EuyjNK6aMhQfyaFmFG/6zbhAOX42znamCkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=qTtlRxsm; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=OBuziY5Y reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1716296716; x=1747832716;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=+3zK8uhm5s/JQCNjCk//AERsHqBNZoNlmw0uFmlRq+U=;
  b=qTtlRxsmP98Cag5kKwH/aoOL+jKVKeWIEceJ9gt+3mKFxnPSmPU1wmHu
   Ce/Oyq3F5NIA6NpFL3VQwyKl1PNUomzDBc28XF35qCrseCbFHQjCyLSsM
   FJpcErOEng8DA+9FdxvHanGvMQmw2UKqN7IPWveei+9AgdyWB94AWbyCK
   e1/6vBYZB76nRHH4ZFFpTwbRze9spb+rbxh1CqyMKVpCzNWR55DQUWXy7
   owc7OgKBxfWn8BJmcPedOC4wgyUdvRgBhryiu8EdZeov5BD6QEiZ2K9AU
   W+/cNIdlg9UaPgPfLaGt143nKKsXGITwtuKTEyM8ZzcNFBRM2bEuOc/7C
   A==;
X-CSE-ConnectionGUID: kxue+91cQDuVJ5s14eUKig==
X-CSE-MsgGUID: B3NjacV5SQaRpwNK2Ft4jg==
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; 
   d="scan'208";a="36993953"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 21 May 2024 15:05:08 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 24233175C5A;
	Tue, 21 May 2024 15:05:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1716296704;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+3zK8uhm5s/JQCNjCk//AERsHqBNZoNlmw0uFmlRq+U=;
	b=OBuziY5Y70kcjweXwDiq005cXyk56MRDWixuR8AwKJSRIQPKtEoU5CwlylLN1wS3jQqZQf
	/HIjzLu87UWy3aUY+aqzbNGLpFvu/5W9rDxARm8ObIj3QlQreWWBwV+jsP/D3C9pV7Alm5
	ltM7D1MNZpUkzIGccj1pZOhYFNwn7bdVXcCGCTo/DeX+pA3Pb7gbnoUuB9umm0Yr5ggWFm
	tIwMaUkBYn4TYFXDy0jnLfzfBxiZYWd4XycFRnlfFHjzOJI07wVo7EBw61Y+abvBRzjnOD
	3UVz2mew3Z4LP3xaGDBsyqowXLBLma8sAeiCXdxu5f74vSV2nCQYhZIXPZI9GA==
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date: Tue, 21 May 2024 15:04:51 +0200
Subject: [PATCH v3 1/8] can: mcp251xfd: properly indent labels
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-mcp251xfd-gpio-feature-v3-1-7f829fefefc2@ew.tq-group.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716296697; l=5101;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=8t/l6uU+B0kSNv91hrE/iH+sKz5oludzH41/9u7eEeg=;
 b=o78Ez/Buu1/eUA81tFy4HKgJiXXUJ8x8BRkIOvOjKgASniaT2RKKv5qeUlEMQdV6xMh6QK3Nu
 qpRHq7SBe+9DjKyVeHeSGsuq+bGV7o1Pux4rV6591nRxMGgMIUWGhNT
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Last-TLS-Session-Version: TLSv1.3

From: Marc Kleine-Budde <mkl@pengutronix.de>

To fix the coding style, remove the whitespace in front of labels.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c   | 32 ++++++++++++------------
 drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c   |  2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c |  2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c    |  2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c     |  2 +-
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 1d9057dc44f2..e3c791f562d2 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -791,7 +791,7 @@ static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
 
 	return 0;
 
- out_chip_stop:
+out_chip_stop:
 	mcp251xfd_dump(priv);
 	mcp251xfd_chip_stop(priv, CAN_STATE_STOPPED);
 
@@ -1576,7 +1576,7 @@ static irqreturn_t mcp251xfd_irq(int irq, void *dev_id)
 		handled = IRQ_HANDLED;
 	} while (1);
 
- out_fail:
+out_fail:
 	can_rx_offload_threaded_irq_finish(&priv->offload);
 
 	netdev_err(priv->ndev, "IRQ handler returned %d (intf=0x%08x).\n",
@@ -1632,20 +1632,20 @@ static int mcp251xfd_open(struct net_device *ndev)
 
 	return 0;
 
- out_free_irq:
+out_free_irq:
 	free_irq(spi->irq, priv);
- out_can_rx_offload_disable:
+out_can_rx_offload_disable:
 	can_rx_offload_disable(&priv->offload);
 	set_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
 	mcp251xfd_timestamp_stop(priv);
- out_transceiver_disable:
+out_transceiver_disable:
 	mcp251xfd_transceiver_disable(priv);
- out_mcp251xfd_ring_free:
+out_mcp251xfd_ring_free:
 	mcp251xfd_ring_free(priv);
- out_pm_runtime_put:
+out_pm_runtime_put:
 	mcp251xfd_chip_stop(priv, CAN_STATE_STOPPED);
 	pm_runtime_put(ndev->dev.parent);
- out_close_candev:
+out_close_candev:
 	close_candev(ndev);
 
 	return err;
@@ -1808,9 +1808,9 @@ mcp251xfd_register_get_dev_id(const struct mcp251xfd_priv *priv, u32 *dev_id,
 	*effective_speed_hz_slow = xfer[0].effective_speed_hz;
 	*effective_speed_hz_fast = xfer[1].effective_speed_hz;
 
- out_kfree_buf_tx:
+out_kfree_buf_tx:
 	kfree(buf_tx);
- out_kfree_buf_rx:
+out_kfree_buf_rx:
 	kfree(buf_rx);
 
 	return err;
@@ -1924,13 +1924,13 @@ static int mcp251xfd_register(struct mcp251xfd_priv *priv)
 
 	return 0;
 
- out_unregister_candev:
+out_unregister_candev:
 	unregister_candev(ndev);
- out_chip_sleep:
+out_chip_sleep:
 	mcp251xfd_chip_sleep(priv);
- out_runtime_disable:
+out_runtime_disable:
 	pm_runtime_disable(ndev->dev.parent);
- out_runtime_put_noidle:
+out_runtime_put_noidle:
 	pm_runtime_put_noidle(ndev->dev.parent);
 	mcp251xfd_clks_and_vdd_disable(priv);
 
@@ -2150,9 +2150,9 @@ static int mcp251xfd_probe(struct spi_device *spi)
 
 	return 0;
 
- out_can_rx_offload_del:
+out_can_rx_offload_del:
 	can_rx_offload_del(&priv->offload);
- out_free_candev:
+out_free_candev:
 	spi->max_speed_hz = priv->spi_max_speed_hz_orig;
 
 	free_candev(ndev);
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c
index 004eaf96262b..050321345304 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c
@@ -94,7 +94,7 @@ static void mcp251xfd_dump_registers(const struct mcp251xfd_priv *priv,
 		kfree(buf);
 	}
 
- out:
+out:
 	mcp251xfd_dump_header(iter, MCP251XFD_DUMP_OBJECT_TYPE_REG, reg);
 }
 
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
index 92b7bc7f14b9..65150e762007 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
@@ -397,7 +397,7 @@ mcp251xfd_regmap_crc_read(void *context,
 
 		return err;
 	}
- out:
+out:
 	memcpy(val_buf, buf_rx->data, val_len);
 
 	return 0;
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
index e5bd57b65aaf..ee7028c027b5 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
@@ -216,7 +216,7 @@ int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
 		total_frame_len += frame_len;
 	}
 
- out_netif_wake_queue:
+out_netif_wake_queue:
 	len = i;	/* number of handled goods TEFs */
 	if (len) {
 		struct mcp251xfd_tef_ring *ring = priv->tef;
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
index 160528d3cc26..9d81eeb98432 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
@@ -198,7 +198,7 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 
 	return NETDEV_TX_OK;
 
- out_err:
+out_err:
 	netdev_err(priv->ndev, "ERROR in %s: %d\n", __func__, err);
 
 	return NETDEV_TX_OK;

-- 
2.34.1


