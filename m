Return-Path: <linux-can+bounces-1089-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90372942AE1
	for <lists+linux-can@lfdr.de>; Wed, 31 Jul 2024 11:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E173CB24C3B
	for <lists+linux-can@lfdr.de>; Wed, 31 Jul 2024 09:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E1D1B1431;
	Wed, 31 Jul 2024 09:38:15 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402FD1B011D
	for <linux-can@vger.kernel.org>; Wed, 31 Jul 2024 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418694; cv=none; b=ZtM3TlwVpzlu/eicEYn0uZY9XVlC35MKKCVJPmUH49Qs3xVh0h+y1IbRQY4BiNlWxDOuL+expIY3h01BW5ANhZ62oSKFTYtRwSIjxtt22IESOQ9pPoFmHPJftYO2cf8sFutl9ErBt3nGG1bQ+Vpu6qsgTsqKUJsWuRs7eobEZow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418694; c=relaxed/simple;
	bh=s9NB4hlaT5cH4Gs795ZxVLYLLs0l4djl8nwPl0hWoC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GxMzaf4tWOpQdAp7zer07bRC7p51PXpGOymKiw7jCAMq6lkx6S5oKmxR1qwT9MchDLUzFtATtN4gac3IBYoomk3e/43d6uTCLv7P1QQYORnfttqwCZGZZDJFc2YjAudwxTvQJzWnK6qA3T6kgs4jwZ3kylUjSbWDF5r+e825CKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sZ5mb-0005mV-4E
	for linux-can@vger.kernel.org; Wed, 31 Jul 2024 11:38:09 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sZ5mS-003Uvu-LN
	for linux-can@vger.kernel.org; Wed, 31 Jul 2024 11:38:00 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 2875931293E
	for <linux-can@vger.kernel.org>; Wed, 31 Jul 2024 09:38:00 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 61383312862;
	Wed, 31 Jul 2024 09:37:54 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3394643a;
	Wed, 31 Jul 2024 09:37:42 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 31 Jul 2024 11:37:16 +0200
Subject: [PATCH can-next v2 14/20] can: rockchip_canfd:
 rkcanfd_get_berr_counter_corrected(): work around broken {RX,TX}ERRORCNT
 register
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-rockchip-canfd-v2-14-d9604c5b4be8@pengutronix.de>
References: <20240731-rockchip-canfd-v2-0-d9604c5b4be8@pengutronix.de>
In-Reply-To: <20240731-rockchip-canfd-v2-0-d9604c5b4be8@pengutronix.de>
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
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=6870; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=s9NB4hlaT5cH4Gs795ZxVLYLLs0l4djl8nwPl0hWoC4=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmqgXa8/Z7FbWxkGVEF71BVm2f8Tw6QLHuCbVv9
 Y+lTv1uDZuJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZqoF2gAKCRAoOKI+ei28
 b64gCACQuj8HkAGaLoCwazD/rDS7dMNXvnIBhBZEnyIoEilIgnOqxEyl3wG2v1XhiwbpfEsrQev
 CmoFJGj8K6gaxQrEBr27S0gaRHCW62AhT2ZMFSW/KmazhWlBfqTqcNXn1vzS9NQdDgKZy/Z6m9f
 le7Y3rHBKWWOSrihzcOK8j+/ZiVdySuTwcirHifyyIJLQTje8ejpHsmyU2G1G/jxeedu7iYclRK
 8AdFqFVKtBnO8zRMUXprdRiCPAcRBoo3j+fl+VAz2zs0uYBU3sFTNY59ob3z5+Atsr9rhpSkxrD
 mRO1Sslxtg6sI3oOIDRhtcPxQMO5FTxskvypUn59Gf2/zf6q
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Tests show that sometimes both CAN bus error counters read 0x0, even
if the controller is in warning mode
(RKCANFD_REG_STATE_ERROR_WARNING_STATE in RKCANFD_REG_STATE
set).

To work around this issue, if both error counters read from hardware
are 0x0, use the structure priv->bec, otherwise save the read value in
priv->bec.

In rkcanfd_handle_rx_int_one() decrement the priv->bec.rxerr for
successfully RX'ed CAN frames.

In rkcanfd_handle_tx_done_one() decrement the priv->bec.txerr for
successfully TX'ed CAN frames.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 50 ++++++++++++++++++++++----
 drivers/net/can/rockchip/rockchip_canfd-rx.c   | 15 ++++++++
 drivers/net/can/rockchip/rockchip_canfd-tx.c   |  8 +++++
 drivers/net/can/rockchip/rockchip_canfd.h      |  2 ++
 4 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 237b81c71dd8..5d78ec8dba7e 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -159,11 +159,47 @@ static int rkcanfd_set_bittiming(struct rkcanfd_priv *priv)
 	return 0;
 }
 
-static void rkcanfd_get_berr_counter_raw(struct rkcanfd_priv *priv,
-					 struct can_berr_counter *bec)
+static void rkcanfd_get_berr_counter_corrected(struct rkcanfd_priv *priv,
+					       struct can_berr_counter *bec)
 {
+	struct can_berr_counter bec_raw;
+	u32 reg_state;
+
 	bec->rxerr = rkcanfd_read(priv, RKCANFD_REG_RXERRORCNT);
 	bec->txerr = rkcanfd_read(priv, RKCANFD_REG_TXERRORCNT);
+	bec_raw = *bec;
+
+	/* Tests show that sometimes both CAN bus error counters read
+	 * 0x0, even if the controller is in warning mode
+	 * (RKCANFD_REG_STATE_ERROR_WARNING_STATE in RKCANFD_REG_STATE
+	 * set).
+	 *
+	 * In case both error counters read 0x0, use the struct
+	 * priv->bec, otherwise save the read value to priv->bec.
+	 *
+	 * rkcanfd_handle_rx_int_one() handles the decrementing of
+	 * priv->bec.rxerr for successfully RX'ed CAN frames.
+	 *
+	 * Luckily the controller doesn't decrement the RX CAN bus
+	 * error counter in hardware for self received TX'ed CAN
+	 * frames (RKCANFD_REG_MODE_RXSTX_MODE), so RXSTX doesn't
+	 * interfere with proper RX CAN bus error counters.
+	 *
+	 * rkcanfd_handle_tx_done_one() handles the decrementing of
+	 * priv->bec.txerr for successfully TX'ed CAN frames.
+	 */
+	if (!bec->rxerr && !bec->txerr)
+		*bec = priv->bec;
+	else
+		priv->bec = *bec;
+
+	reg_state = rkcanfd_read(priv, RKCANFD_REG_STATE);
+	netdev_vdbg(priv->ndev,
+		    "%s: Raw/Cor: txerr=%3u/%3u rxerr=%3u/%3u Bus Off=%u Warning=%u\n",
+		    __func__,
+		    bec_raw.txerr, bec->txerr, bec_raw.rxerr, bec->rxerr,
+		    !!(reg_state & RKCANFD_REG_STATE_BUS_OFF_STATE),
+		    !!(reg_state & RKCANFD_REG_STATE_ERROR_WARNING_STATE));
 }
 
 static int rkcanfd_get_berr_counter(const struct net_device *ndev,
@@ -176,7 +212,7 @@ static int rkcanfd_get_berr_counter(const struct net_device *ndev,
 	if (err)
 		return err;
 
-	rkcanfd_get_berr_counter_raw(priv, bec);
+	rkcanfd_get_berr_counter_corrected(priv, bec);
 
 	pm_runtime_put(ndev->dev.parent);
 
@@ -252,6 +288,8 @@ static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
 		RKCANFD_REG_INT_OVERLOAD_INT |
 		RKCANFD_REG_INT_TX_FINISH_INT;
 
+	memset(&priv->bec, 0x0, sizeof(priv->bec));
+
 	rkcanfd_chip_fifo_setup(priv);
 	rkcanfd_timestamp_init(priv);
 	rkcanfd_set_bittiming(priv);
@@ -488,7 +526,7 @@ static int rkcanfd_handle_error_int(struct rkcanfd_priv *priv)
 	if (cf) {
 		struct can_berr_counter bec;
 
-		rkcanfd_get_berr_counter_raw(priv, &bec);
+		rkcanfd_get_berr_counter_corrected(priv, &bec);
 		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR | CAN_ERR_CNT;
 		cf->data[6] = bec.txerr;
 		cf->data[7] = bec.rxerr;
@@ -517,7 +555,7 @@ static int rkcanfd_handle_state_error_int(struct rkcanfd_priv *priv)
 	u32 timestamp;
 	int err;
 
-	rkcanfd_get_berr_counter_raw(priv, &bec);
+	rkcanfd_get_berr_counter_corrected(priv, &bec);
 	can_state_get_by_berr_counter(ndev, &bec, &tx_state, &rx_state);
 
 	new_state = max(tx_state, rx_state);
@@ -570,7 +608,7 @@ rkcanfd_handle_rx_fifo_overflow_int(struct rkcanfd_priv *priv)
 	if (skb)
 		return 0;
 
-	rkcanfd_get_berr_counter_raw(priv, &bec);
+	rkcanfd_get_berr_counter_corrected(priv, &bec);
 
 	cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
 	cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index 31cee3362f1e..eff08948840c 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
@@ -167,6 +167,13 @@ static int rkcanfd_rxstx_filter(struct rkcanfd_priv *priv,
 
 	/* Affected by Erratum 6 */
 
+	/* Manual handling of CAN Bus Error counters. See
+	 * rkcanfd_get_corrected_berr_counter() for detailed
+	 * explanation.
+	 */
+	if (priv->bec.txerr)
+		priv->bec.txerr--;
+
 	*tx_done = true;
 
 	stats->tx_packets++;
@@ -229,6 +236,14 @@ static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
 			return 0;
 	}
 
+	/* Manual handling of CAN Bus Error counters. See
+	 * rkcanfd_get_corrected_berr_counter() for detailed
+	 * explanation.
+	 */
+	if (priv->bec.rxerr)
+		priv->bec.rxerr = min(CAN_ERROR_PASSIVE_THRESHOLD,
+				      priv->bec.rxerr) - 1;
+
 	if (header->frameinfo & RKCANFD_REG_FD_FRAMEINFO_FDF)
 		skb = alloc_canfd_skb(priv->ndev, &skb_cfd);
 	else
diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
index 9db6d90a4e7f..f8e74e814b3b 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -113,6 +113,14 @@ void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 ts,
 	unsigned int tx_tail;
 
 	tx_tail = rkcanfd_get_tx_tail(priv);
+
+	/* Manual handling of CAN Bus Error counters. See
+	 * rkcanfd_get_corrected_berr_counter() for detailed
+	 * explanation.
+	 */
+	if (priv->bec.txerr)
+		priv->bec.txerr--;
+
 	stats->tx_bytes +=
 		can_rx_offload_get_echo_skb_queue_timestamp(&priv->offload,
 							    tx_tail, ts,
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 3fe6ddcdd8ac..67f135fbcfb9 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -459,6 +459,8 @@ struct rkcanfd_priv {
 	u32 reg_int_mask_default;
 	struct rkcanfd_devtype_data devtype_data;
 
+	struct can_berr_counter bec;
+
 	struct reset_control *reset;
 	struct clk_bulk_data *clks;
 	int clks_num;

-- 
2.43.0



