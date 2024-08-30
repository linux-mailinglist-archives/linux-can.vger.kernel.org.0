Return-Path: <linux-can+bounces-1259-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A796F9669C0
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 21:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FCFB2874E5
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 19:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A101C2319;
	Fri, 30 Aug 2024 19:27:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EAC1BF804
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725046036; cv=none; b=iZOwWWmVkhiUpJCElnJqWMOzzK4Dp1Z2nokxO7HwoPG6udOUpfxjGCaAq6zt5k1lJ4b5WWu6ACDlMnmsyjkE4T+gWHdUvsFPdA1UlLdF8TM7sFmHRib/lamjOR9IkYJo8QzF6ELEwLQQLFpqRbbXI4X8a6Lu0M+SQfEiodfPoz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725046036; c=relaxed/simple;
	bh=Qq58LRu4MZgbExO9gq+wk7eqvvt3AfhiJu8u44wVz9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E8PlwPq46zzqicmmUkx8lNqPX4DGIWfQAZGdVshbOSt2PHEhrkweooYpSV8yhLJfnynEnXbrQ9AC0orVACo2JBIGSpgTjOsAenNWYFy2mZDvdLunD0iFSTrLgt9IuFqu1YNABjYCegwfz4plOIkg5y6NyLAXIa9eR1j7NgGA5U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk7H2-0006QB-PY
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 21:27:08 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk7Gv-004Dui-0U
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 21:27:01 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id A466932E2AE
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 19:27:00 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 7B9CA32E116;
	Fri, 30 Aug 2024 19:26:47 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 60ce9336;
	Fri, 30 Aug 2024 19:26:45 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 30 Aug 2024 21:26:12 +0200
Subject: [PATCH can-next v3 15/20] can: rockchip_canfd: add stats support
 for errata workarounds
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-rockchip-canfd-v3-15-d426266453fa@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6702; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Qq58LRu4MZgbExO9gq+wk7eqvvt3AfhiJu8u44wVz9M=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm0hzs47gZRhzQm1197UhBA41DjgqvQmNvLpJ5m
 JkBHCb2YkqJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZtIc7AAKCRAoOKI+ei28
 bximB/4vumJG+dPsQDw4QJt8R2oLJ+CS8UIaPkkG1FUMBgt+TKgRYXon0Hy9AKDFkdrOr7TPYDZ
 iMm0ICWXZvEgd14HxZ4wectgzMzudShOB5RwKSduRNr41FNyRlv+M4lh1TqVwiqwTEf11EnRhWQ
 3eXofGuYtpZNXZa7sFpqcxBfuEa18OxZx8x26/M+YcmRG32JJ6V/3w/a3i49WsA+C/lHlClQaPa
 TMzedDJJsPMHkKE9r9wulDPv/OolzMwRcBP5p1SCVBkiVAYIgFzkBCfjV5CvbB/Kih+ZvaRMiMq
 2FgHoQ2o4/tyXDPQwe58mnjR2kenx5JydCqxtUYkyjJthB0h
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

The driver contains workarounds for some of the rk3568v2 errata. Add
ethtool-based statistics ("ethtool -S") to track how often an erratum
workaround was needed.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/Makefile                 |  1 +
 drivers/net/can/rockchip/rockchip_canfd-core.c    |  2 +
 drivers/net/can/rockchip/rockchip_canfd-ethtool.c | 73 +++++++++++++++++++++++
 drivers/net/can/rockchip/rockchip_canfd-rx.c      | 13 +++-
 drivers/net/can/rockchip/rockchip_canfd.h         | 14 +++++
 5 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rockchip/Makefile b/drivers/net/can/rockchip/Makefile
index 4eb7c50d8d5b..3760d3e1baa3 100644
--- a/drivers/net/can/rockchip/Makefile
+++ b/drivers/net/can/rockchip/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_CAN_ROCKCHIP_CANFD) += rockchip_canfd.o
 
 rockchip_canfd-objs :=
 rockchip_canfd-objs += rockchip_canfd-core.o
+rockchip_canfd-objs += rockchip_canfd-ethtool.o
 rockchip_canfd-objs += rockchip_canfd-rx.o
 rockchip_canfd-objs += rockchip_canfd-timestamp.o
 rockchip_canfd-objs += rockchip_canfd-tx.o
diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index cf176180a282..4db552bfc4db 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -800,6 +800,8 @@ static int rkcanfd_register(struct rkcanfd_priv *priv)
 	if (err)
 		goto out_pm_runtime_disable;
 
+	rkcanfd_ethtool_init(priv);
+
 	err = register_candev(ndev);
 	if (err)
 		goto out_pm_runtime_put_sync;
diff --git a/drivers/net/can/rockchip/rockchip_canfd-ethtool.c b/drivers/net/can/rockchip/rockchip_canfd-ethtool.c
new file mode 100644
index 000000000000..0084f37b2b9f
--- /dev/null
+++ b/drivers/net/can/rockchip/rockchip_canfd-ethtool.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2023, 2024 Pengutronix,
+//               Marc Kleine-Budde <kernel@pengutronix.de>
+//
+
+#include <linux/ethtool.h>
+
+#include "rockchip_canfd.h"
+
+enum rkcanfd_stats_type {
+	RKCANFD_STATS_TYPE_RX_FIFO_EMPTY_ERRORS,
+	RKCANFD_STATS_TYPE_TX_EXTENDED_AS_STANDARD_ERRORS,
+};
+
+static const char rkcanfd_stats_strings[][ETH_GSTRING_LEN] = {
+	[RKCANFD_STATS_TYPE_RX_FIFO_EMPTY_ERRORS] = "rx_fifo_empty_errors",
+	[RKCANFD_STATS_TYPE_TX_EXTENDED_AS_STANDARD_ERRORS] = "tx_extended_as_standard_errors",
+};
+
+static void
+rkcanfd_ethtool_get_strings(struct net_device *ndev, u32 stringset, u8 *buf)
+{
+	switch (stringset) {
+	case ETH_SS_STATS:
+		memcpy(buf, rkcanfd_stats_strings,
+		       sizeof(rkcanfd_stats_strings));
+	}
+}
+
+static int rkcanfd_ethtool_get_sset_count(struct net_device *netdev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_STATS:
+		return ARRAY_SIZE(rkcanfd_stats_strings);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void
+rkcanfd_ethtool_get_ethtool_stats(struct net_device *ndev,
+				  struct ethtool_stats *stats, u64 *data)
+{
+	struct rkcanfd_priv *priv = netdev_priv(ndev);
+	struct rkcanfd_stats *rkcanfd_stats;
+	unsigned int start;
+
+	rkcanfd_stats = &priv->stats;
+
+	do {
+		start = u64_stats_fetch_begin(&rkcanfd_stats->syncp);
+
+		data[RKCANFD_STATS_TYPE_RX_FIFO_EMPTY_ERRORS] =
+			u64_stats_read(&rkcanfd_stats->rx_fifo_empty_errors);
+		data[RKCANFD_STATS_TYPE_TX_EXTENDED_AS_STANDARD_ERRORS] =
+			u64_stats_read(&rkcanfd_stats->tx_extended_as_standard_errors);
+	} while (u64_stats_fetch_retry(&rkcanfd_stats->syncp, start));
+}
+
+static const struct ethtool_ops rkcanfd_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+	.get_strings = rkcanfd_ethtool_get_strings,
+	.get_sset_count = rkcanfd_ethtool_get_sset_count,
+	.get_ethtool_stats = rkcanfd_ethtool_get_ethtool_stats,
+};
+
+void rkcanfd_ethtool_init(struct rkcanfd_priv *priv)
+{
+	priv->ndev->ethtool_ops = &rkcanfd_ethtool_ops;
+
+	u64_stats_init(&priv->stats.syncp);
+}
diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index eff08948840c..9f72483dab18 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
@@ -96,6 +96,7 @@ static int rkcanfd_rxstx_filter(struct rkcanfd_priv *priv,
 				bool *tx_done)
 {
 	struct net_device_stats *stats = &priv->ndev->stats;
+	struct rkcanfd_stats *rkcanfd_stats = &priv->stats;
 	const struct canfd_frame *cfd_nominal;
 	const struct sk_buff *skb;
 	unsigned int tx_tail;
@@ -166,6 +167,9 @@ static int rkcanfd_rxstx_filter(struct rkcanfd_priv *priv,
 		return 0;
 
 	/* Affected by Erratum 6 */
+	u64_stats_update_begin(&rkcanfd_stats->syncp);
+	u64_stats_inc(&rkcanfd_stats->tx_extended_as_standard_errors);
+	u64_stats_update_end(&rkcanfd_stats->syncp);
 
 	/* Manual handling of CAN Bus Error counters. See
 	 * rkcanfd_get_corrected_berr_counter() for detailed
@@ -211,8 +215,15 @@ static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
 			 cfd->data, sizeof(cfd->data));
 
 	/* Erratum 5: Counters for TXEFIFO and RXFIFO may be wrong */
-	if (rkcanfd_fifo_header_empty(header))
+	if (rkcanfd_fifo_header_empty(header)) {
+		struct rkcanfd_stats *rkcanfd_stats = &priv->stats;
+
+		u64_stats_update_begin(&rkcanfd_stats->syncp);
+		u64_stats_inc(&rkcanfd_stats->rx_fifo_empty_errors);
+		u64_stats_update_end(&rkcanfd_stats->syncp);
+
 		return 0;
+	}
 
 	len = rkcanfd_fifo_header_to_cfd_header(priv, header, cfd);
 
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 67f135fbcfb9..f24a1d18be66 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -446,6 +446,16 @@ struct rkcanfd_fifo_header {
 	u32 ts;
 };
 
+struct rkcanfd_stats {
+	struct u64_stats_sync syncp;
+
+	/* Erratum 5 */
+	u64_stats_t rx_fifo_empty_errors;
+
+	/* Erratum 6 */
+	u64_stats_t tx_extended_as_standard_errors;
+};
+
 struct rkcanfd_priv {
 	struct can_priv can;
 	struct can_rx_offload offload;
@@ -461,6 +471,8 @@ struct rkcanfd_priv {
 
 	struct can_berr_counter bec;
 
+	struct rkcanfd_stats stats;
+
 	struct reset_control *reset;
 	struct clk_bulk_data *clks;
 	int clks_num;
@@ -515,6 +527,8 @@ rkcanfd_get_tx_free(const struct rkcanfd_priv *priv)
 	return RKCANFD_TXFIFO_DEPTH - rkcanfd_get_tx_pending(priv);
 }
 
+void rkcanfd_ethtool_init(struct rkcanfd_priv *priv);
+
 int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv);
 
 void rkcanfd_timestamp_init(struct rkcanfd_priv *priv);

-- 
2.45.2



