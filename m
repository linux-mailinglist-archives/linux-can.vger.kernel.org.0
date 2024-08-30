Return-Path: <linux-can+bounces-1253-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2527F96699C
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 21:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9AD41F25771
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 19:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A85F1BFDFE;
	Fri, 30 Aug 2024 19:27:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9191BF7FA
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725046030; cv=none; b=I31f8LgSpDwqaYZlsbcUKNQlFIBTakfqmrsTsV0UXUgCDxDWZvNyJa1jrSy6PelmqRc7mFpxdZqv41IOTWyyGJHbrOqvPKY8o0sCTJq2b4dzIL0EvhdQ8Pe0mk4rdtUZY00+GiDayxoQVaWMiOHfnngooKqhiEwoj+Tb8OPgTUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725046030; c=relaxed/simple;
	bh=DJ+fhm2Yj2TmsuGIAwwI2LYdWTC/F0r0cDuJqYQdeZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OhIEcg9TMhV/XenMlzmnPO2ld0uyQ7B9SrIiYjpH2RcgW8iUxVi6v9otsLQ63WYPPk+OHOQzoCi1yEdTF0Tt3mrVVoQ5mu5W+uzcHB9R3t7jH4UkFynCmJACRXMnUeM8I/KfY5LBYLAbWxGV7ZBkZpj6KCbuaIhYN6IfG6OD1PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk7Gy-0006KA-Qr
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 21:27:04 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk7Gq-004Doq-Ll
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 21:26:56 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 2435132E230
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 19:26:56 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 66FC832E113;
	Fri, 30 Aug 2024 19:26:47 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 4a7dea85;
	Fri, 30 Aug 2024 19:26:45 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 30 Aug 2024 21:26:11 +0200
Subject: [PATCH can-next v3 14/20] can: rockchip_canfd:
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
Message-Id: <20240830-rockchip-canfd-v3-14-d426266453fa@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6870; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=DJ+fhm2Yj2TmsuGIAwwI2LYdWTC/F0r0cDuJqYQdeZk=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm0hzqYIJEK7iHbPJ+hnw1BQMI1jU1YdhsAlVxi
 0fnn0tmrb6JATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZtIc6gAKCRAoOKI+ei28
 b28gCACJ2SKUL8GptaakLs71H5Pd/rF0QUJjljnAwEhstL9Juua7uBc3dDxBc+ac4Sl/thXJ7h0
 rZe1uSVhujtY/Buv1VUBj3l375wsLpNwes0wUeFlQaiCQueiGS2UVpA8279OhOKqIBPRuXIYH/l
 0/HDl0qh+rv14SHAhgDs8J7y87NmGHZFmg8tYluQU3UrFUFbHUc3fVaS/DuAL3ZrAb8b+e/HyKp
 L9vfGO/JhPTo0VcereXA+bUrPAm+KUvAoHojUl0g5WM81cZnXgdPz92QP+pL4qp9sxgRLn6x/2+
 4ZEPyHDrMOYBjqbspmrQ/PPaY919TsX7yTha7fRDWmmlQVXw
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
index 700702e4d2ed..cf176180a282 100644
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
2.45.2



