Return-Path: <linux-can+bounces-1262-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A83E89669C3
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 21:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B384B1C24A23
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 19:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9F91C2DA9;
	Fri, 30 Aug 2024 19:27:17 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E291BD517
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725046037; cv=none; b=rIdkXgPp/OvjpW8OdvtAjEqjUr5lrGnvzKPlNqTJ6rRU3IK3DypOc8baXaOSICYuqXUJ5c9C4UwBBJRaThPQ0l7RlOHASZp0NoeLgCfqfX1iIAxruHZ0PCvAYzPtP3fvlMjztbPJ+/agFhFDLMd+XB5b7k8eMqTxIeXpM9f0zSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725046037; c=relaxed/simple;
	bh=+meZphvzteAtCOrac7FHKFFj9qclAUNi1NRCRVPJi7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=age/Qzf89Cod58wnXJRttSR+yu66sGNluBCuknnoqqyUGdpqxgHcJLaSEpnH2P0OfDZ8tKQzOBi+y92/ZRUUfWUS7fHyA4RdWA9muzY81INyLY0nwbxziXkmrP5MesQxjuswIYjz+q+2cAaSLUQkR5OSM/eKgEENkR3nDPFdG4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk7H2-0006QD-BE
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 21:27:08 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk7Gv-004Dus-4n
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 21:27:01 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id BF69232E2B0
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 19:27:00 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id BEAFA32E11E;
	Fri, 30 Aug 2024 19:26:47 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b414e826;
	Fri, 30 Aug 2024 19:26:45 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 30 Aug 2024 21:26:15 +0200
Subject: [PATCH can-next v3 18/20] can: rockchip_canfd: add hardware
 timestamping support
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-rockchip-canfd-v3-18-d426266453fa@pengutronix.de>
References: <20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de>
In-Reply-To: <20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de>
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 David Jander <david.jander@protonic.nl>
Cc: Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=9046; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=+meZphvzteAtCOrac7FHKFFj9qclAUNi1NRCRVPJi7o=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm0hzwt9XTCs6r4giJ51rJkf9K/y78leH7taUVl
 horu80UG5yJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZtIc8AAKCRAoOKI+ei28
 bwp3B/99Oc+Mx4HN5L+gteN/9Te0h4sXFH+SBdw+/7LIeTIyazLMbKChZklDL1hQN1Aiw1YHyus
 FundkpSjphcVhcsxofyD9iGpxk3BB53NHvcXERKxl8ZabyLY7WgKMKl7Bj6hoK9+rMs6gyhHqNb
 +ZBbkV35FWe7iuHbKECyD9nstZqr3PYSAbVoB9fQav2K+kQSmUkW6piAWyy212Yip8gGAU0xxVc
 p/G6ybCV1Fo18ckwNxpJcRBAYWLMC46PytkaGZPVkTFdz8Gqw0dKQPuHwoGcvt8XzrZXk97g2D3
 jUa+KQ7BCGYG1RRZEs+XhZODwjLQkv7wmMSbvWmDhvrzU7Mx
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Add support for hardware based timestamping.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c     |  6 ++
 drivers/net/can/rockchip/rockchip_canfd-ethtool.c  |  2 +-
 drivers/net/can/rockchip/rockchip_canfd-rx.c       |  1 +
 .../net/can/rockchip/rockchip_canfd-timestamp.c    | 94 +++++++++++++++++++++-
 drivers/net/can/rockchip/rockchip_canfd-tx.c       |  4 +
 drivers/net/can/rockchip/rockchip_canfd.h          | 11 +++
 6 files changed, 115 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 4db552bfc4db..015623314e88 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -292,6 +292,8 @@ static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
 
 	rkcanfd_chip_fifo_setup(priv);
 	rkcanfd_timestamp_init(priv);
+	rkcanfd_timestamp_start(priv);
+
 	rkcanfd_set_bittiming(priv);
 
 	rkcanfd_chip_interrupts_disable(priv);
@@ -315,6 +317,7 @@ static void rkcanfd_chip_stop(struct rkcanfd_priv *priv, const enum can_state st
 {
 	priv->can.state = state;
 
+	rkcanfd_timestamp_stop(priv);
 	__rkcanfd_chip_stop(priv, state);
 }
 
@@ -322,6 +325,7 @@ static void rkcanfd_chip_stop_sync(struct rkcanfd_priv *priv, const enum can_sta
 {
 	priv->can.state = state;
 
+	rkcanfd_timestamp_stop_sync(priv);
 	__rkcanfd_chip_stop(priv, state);
 }
 
@@ -353,6 +357,8 @@ rkcanfd_alloc_can_err_skb(struct rkcanfd_priv *priv,
 	*timestamp = rkcanfd_get_timestamp(priv);
 
 	skb = alloc_can_err_skb(priv->ndev, cf);
+	if (skb)
+		rkcanfd_skb_set_timestamp(priv, skb, *timestamp);
 
 	return skb;
 }
diff --git a/drivers/net/can/rockchip/rockchip_canfd-ethtool.c b/drivers/net/can/rockchip/rockchip_canfd-ethtool.c
index 0084f37b2b9f..5aeeef64a67a 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-ethtool.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-ethtool.c
@@ -59,7 +59,7 @@ rkcanfd_ethtool_get_ethtool_stats(struct net_device *ndev,
 }
 
 static const struct ethtool_ops rkcanfd_ethtool_ops = {
-	.get_ts_info = ethtool_op_get_ts_info,
+	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
 	.get_strings = rkcanfd_ethtool_get_strings,
 	.get_sset_count = rkcanfd_ethtool_get_sset_count,
 	.get_ethtool_stats = rkcanfd_ethtool_get_ethtool_stats,
diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index bacef5e5dc39..d862116840eb 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
@@ -267,6 +267,7 @@ static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
 	}
 
 	memcpy(skb_cfd, cfd, len);
+	rkcanfd_skb_set_timestamp(priv, skb, header->ts);
 
 	err = can_rx_offload_queue_timestamp(&priv->offload, skb, header->ts);
 	if (err)
diff --git a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
index 9301b3ceceb0..81cccc5fd838 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
@@ -4,12 +4,102 @@
 //               Marc Kleine-Budde <kernel@pengutronix.de>
 //
 
+#include <linux/clocksource.h>
+
 #include "rockchip_canfd.h"
 
+static u64 rkcanfd_timestamp_read(const struct cyclecounter *cc)
+{
+	const struct rkcanfd_priv *priv = container_of(cc, struct rkcanfd_priv, cc);
+
+	return rkcanfd_get_timestamp(priv);
+}
+
+void rkcanfd_skb_set_timestamp(const struct rkcanfd_priv *priv,
+			       struct sk_buff *skb, const u32 timestamp)
+{
+	struct skb_shared_hwtstamps *hwtstamps = skb_hwtstamps(skb);
+	u64 ns;
+
+	ns = timecounter_cyc2time(&priv->tc, timestamp);
+
+	hwtstamps->hwtstamp = ns_to_ktime(ns);
+}
+
+static void rkcanfd_timestamp_work(struct work_struct *work)
+{
+	const struct delayed_work *delayed_work = to_delayed_work(work);
+	struct rkcanfd_priv *priv;
+
+	priv = container_of(delayed_work, struct rkcanfd_priv, timestamp);
+	timecounter_read(&priv->tc);
+
+	schedule_delayed_work(&priv->timestamp, priv->work_delay_jiffies);
+}
+
 void rkcanfd_timestamp_init(struct rkcanfd_priv *priv)
 {
-	u32 reg;
+	const struct can_bittiming *dbt = &priv->can.data_bittiming;
+	const struct can_bittiming *bt = &priv->can.bittiming;
+	struct cyclecounter *cc = &priv->cc;
+	u32 bitrate, div, reg, rate;
+	u64 work_delay_ns;
+	u64 max_cycles;
 
-	reg = RKCANFD_REG_TIMESTAMP_CTRL_TIME_BASE_COUNTER_ENABLE;
+	/* At the standard clock rate of 300Mhz on the rk3658, the 32
+	 * bit timer overflows every 14s. This means that we have to
+	 * poll it quite often to avoid missing a wrap around.
+	 *
+	 * Divide it down to a reasonable rate, at least twice the bit
+	 * rate.
+	 */
+	bitrate = max(bt->bitrate, dbt->bitrate);
+	div = min(DIV_ROUND_UP(priv->can.clock.freq, bitrate * 2),
+		  FIELD_MAX(RKCANFD_REG_TIMESTAMP_CTRL_TIME_BASE_COUNTER_PRESCALE) + 1);
+
+	reg = FIELD_PREP(RKCANFD_REG_TIMESTAMP_CTRL_TIME_BASE_COUNTER_PRESCALE,
+			 div - 1) |
+		RKCANFD_REG_TIMESTAMP_CTRL_TIME_BASE_COUNTER_ENABLE;
 	rkcanfd_write(priv, RKCANFD_REG_TIMESTAMP_CTRL, reg);
+
+	cc->read = rkcanfd_timestamp_read;
+	cc->mask = CYCLECOUNTER_MASK(32);
+
+	rate = priv->can.clock.freq / div;
+	clocks_calc_mult_shift(&cc->mult, &cc->shift, rate, NSEC_PER_SEC,
+			       RKCANFD_TIMESTAMP_WORK_MAX_DELAY_SEC);
+
+	max_cycles = div_u64(ULLONG_MAX, cc->mult);
+	max_cycles = min(max_cycles, cc->mask);
+	work_delay_ns = clocksource_cyc2ns(max_cycles, cc->mult, cc->shift) / 3;
+	priv->work_delay_jiffies = nsecs_to_jiffies(work_delay_ns);
+	INIT_DELAYED_WORK(&priv->timestamp, rkcanfd_timestamp_work);
+
+	netdev_dbg(priv->ndev, "clock=%lu.%02luMHz bitrate=%lu.%02luMBit/s div=%u rate=%lu.%02luMHz mult=%u shift=%u delay=%lus\n",
+		   priv->can.clock.freq / MEGA,
+		   priv->can.clock.freq % MEGA / KILO / 10,
+		   bitrate / MEGA,
+		   bitrate % MEGA / KILO / 100,
+		   div,
+		   rate / MEGA,
+		   rate % MEGA / KILO / 10,
+		   cc->mult, cc->shift,
+		   priv->work_delay_jiffies / HZ);
+}
+
+void rkcanfd_timestamp_start(struct rkcanfd_priv *priv)
+{
+	timecounter_init(&priv->tc, &priv->cc, ktime_get_real_ns());
+
+	schedule_delayed_work(&priv->timestamp, priv->work_delay_jiffies);
+}
+
+void rkcanfd_timestamp_stop(struct rkcanfd_priv *priv)
+{
+	cancel_delayed_work(&priv->timestamp);
+}
+
+void rkcanfd_timestamp_stop_sync(struct rkcanfd_priv *priv)
+{
+	cancel_delayed_work_sync(&priv->timestamp);
 }
diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
index d10da548ba71..f954f38b955f 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -145,8 +145,10 @@ void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 ts,
 {
 	struct net_device_stats *stats = &priv->ndev->stats;
 	unsigned int tx_tail;
+	struct sk_buff *skb;
 
 	tx_tail = rkcanfd_get_tx_tail(priv);
+	skb = priv->can.echo_skb[tx_tail];
 
 	/* Manual handling of CAN Bus Error counters. See
 	 * rkcanfd_get_corrected_berr_counter() for detailed
@@ -155,6 +157,8 @@ void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 ts,
 	if (priv->bec.txerr)
 		priv->bec.txerr--;
 
+	if (skb)
+		rkcanfd_skb_set_timestamp(priv, skb, ts);
 	stats->tx_bytes +=
 		can_rx_offload_get_echo_skb_queue_timestamp(&priv->offload,
 							    tx_tail, ts,
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 6be2865ec95a..3efd7f174e14 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -15,6 +15,7 @@
 #include <linux/netdevice.h>
 #include <linux/reset.h>
 #include <linux/skbuff.h>
+#include <linux/timecounter.h>
 #include <linux/types.h>
 #include <linux/u64_stats_sync.h>
 #include <linux/units.h>
@@ -469,6 +470,11 @@ struct rkcanfd_priv {
 	u32 reg_int_mask_default;
 	struct rkcanfd_devtype_data devtype_data;
 
+	struct cyclecounter cc;
+	struct timecounter tc;
+	struct delayed_work timestamp;
+	unsigned long work_delay_jiffies;
+
 	struct can_berr_counter bec;
 
 	struct rkcanfd_stats stats;
@@ -531,7 +537,12 @@ void rkcanfd_ethtool_init(struct rkcanfd_priv *priv);
 
 int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv);
 
+void rkcanfd_skb_set_timestamp(const struct rkcanfd_priv *priv,
+			       struct sk_buff *skb, const u32 timestamp);
 void rkcanfd_timestamp_init(struct rkcanfd_priv *priv);
+void rkcanfd_timestamp_start(struct rkcanfd_priv *priv);
+void rkcanfd_timestamp_stop(struct rkcanfd_priv *priv);
+void rkcanfd_timestamp_stop_sync(struct rkcanfd_priv *priv);
 
 unsigned int rkcanfd_get_effective_tx_free(const struct rkcanfd_priv *priv);
 void rkcanfd_xmit_retry(struct rkcanfd_priv *priv);

-- 
2.45.2



