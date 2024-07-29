Return-Path: <linux-can+bounces-1055-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F57593F674
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 15:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0AC28463A
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 13:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ACC15383A;
	Mon, 29 Jul 2024 13:07:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD662188CD1
	for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258449; cv=none; b=tq6epnPlnbdcx83cd6geUWv+L/1exNebncv4hw/f4vsFWY3zjqSkBgr9d5Y4wTYozhz0eeWtmoLFMk9BVE4lHqoWnzPj0G7XXZwplhiaGNp1Z9nrzz6Jy9WlDuEWl7zMafcFWMSrMN322xFAcsvD9R0zKDIl8BOfBedD15rB3sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258449; c=relaxed/simple;
	bh=rhcGW3kiEYmIQim/qgs5GLioJ0mU2ZsLeziqXxXvi5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YNA4ivkCjRx9+6RW/WYN1f4quh/9rhvgXLg+gY4sZe7kJHL9E1M/9Qlf0+g9t5CJdR2pNR70BEILNStt6Ts6majC6fFQbJC/nT93FEsAguTDaBO37sPQCii+Qf+4mfVd9lGVj8JiZrHTrbQ5+1fKqknA9MfYhEU6iPGRxKHVrRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ62-00019I-7Q
	for linux-can@vger.kernel.org; Mon, 29 Jul 2024 15:07:26 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ61-0033O9-8P
	for linux-can@vger.kernel.org; Mon, 29 Jul 2024 15:07:25 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id E8DEA310F53
	for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 13:07:24 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 82E33310E8F;
	Mon, 29 Jul 2024 13:07:13 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 49c4f439;
	Mon, 29 Jul 2024 13:06:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 29 Jul 2024 15:05:50 +0200
Subject: [PATCH can-next 19/21] can: rockchip_canfd: add hardware
 timestamping support
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-rockchip-canfd-v1-19-fa1250fd6be3@pengutronix.de>
References: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
In-Reply-To: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 David Jander <david.jander@protonic.nl>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=8421; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=rhcGW3kiEYmIQim/qgs5GLioJ0mU2ZsLeziqXxXvi5M=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmp5PSctHYza2/MQiDPR8Ji09hmnMOCxNJ++KQ9
 USp4TvW+16JATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZqeT0gAKCRAoOKI+ei28
 b7wPB/94RK2SrpPIni+z7Nz6vQ1IaIxGQy7sovijGiOnaCLCssD632ogFTKRUCDcF4/CqGMWnd6
 2UR5d4GC4CEWI6LoTD7OmCE+kRIhx0oUMlGSJTO4xVIJEWJyQygD4BhaRwcpTB3JepckYmm7+bs
 nNYzZ8z8l6Fxyn43Wz1e1DwGEFNpFX6iwyxv9/ypl16dMKB8Qg5Kd/WQ3ySVYx1oaQdemVFPgyT
 xavdIq37hhZ+lMUdudFrmCoYcCYK9jj9snbshUSzGiHQbp+hLPuA2u5UllijU4LSX1oRuLK5T2F
 b2tx/xxPCCq7y8YotgMiwdAwC0oe7DoIXbslr20yq8NbgOtm
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
 drivers/net/can/rockchip/rockchip_canfd-tx.c       |  2 +
 drivers/net/can/rockchip/rockchip_canfd.h          | 10 +++
 6 files changed, 112 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 9c762b59e310..acbbfdd4cb69 100644
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
index fa7913ef415d..411b0cf5487a 100644
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
index d719a52258e3..f954f38b955f 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -157,6 +157,8 @@ void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 ts,
 	if (priv->bec.txerr)
 		priv->bec.txerr--;
 
+	if (skb)
+		rkcanfd_skb_set_timestamp(priv, skb, ts);
 	stats->tx_bytes +=
 		can_rx_offload_get_echo_skb_queue_timestamp(&priv->offload,
 							    tx_tail, ts,
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index f06f6a83b77f..aa3064101721 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -468,6 +468,11 @@ struct rkcanfd_priv {
 	u32 reg_int_mask_default;
 	struct rkcanfd_devtype_data devtype_data;
 
+	struct cyclecounter cc;
+	struct timecounter tc;
+	struct delayed_work timestamp;
+	unsigned long work_delay_jiffies;
+
 	struct can_berr_counter bec;
 
 	struct rkcanfd_stats stats;
@@ -530,7 +535,12 @@ void rkcanfd_ethtool_init(struct rkcanfd_priv *priv);
 
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
2.43.0



