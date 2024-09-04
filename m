Return-Path: <linux-can+bounces-1376-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA9696B72E
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 11:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E741C21D06
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 09:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7666E1D0484;
	Wed,  4 Sep 2024 09:42:37 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C841CF5F8
	for <linux-can@vger.kernel.org>; Wed,  4 Sep 2024 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725442957; cv=none; b=r/gtwbyNf9+K2skaiBePbwzkUkTYSfRQRNlcF8gMdE1Tr6LRlBtNOC3/vbssypKzG15gy8NAs9IifpsKQAzhkO5nnwCzlyeAI26p9W7WfAJRMATI39813PiZwvRf2Y45bprmvXtJ41khTGteQmn41rHoYRyniWJu6QXZJI1Cd5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725442957; c=relaxed/simple;
	bh=VRrFfGX/SuACSFQCeQPHiZz6lAC3zWx31VYKorpbhIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCCEazDBkpfocG1G3P4mCQzO4ce3cqykTwsbFnfw62g1yZyPbiP1CsNCF7gupwfo0pdmuAkb+CsWmGKDFryxkiXlyXQyBb+wfEsToaqPdYvynIfnC+o0w8JPxY16HPC5HeqrwqSFzucoFeviKSqZkkh1L2h96E/MBKHFv9PeEz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slmX0-0004T4-Ke
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 11:42:30 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slmWw-005QAm-RJ
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 11:42:26 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 44E313323E3
	for <linux-can@vger.kernel.org>; Wed, 04 Sep 2024 09:42:26 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 2BFAE332373;
	Wed, 04 Sep 2024 09:42:23 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 910f0b0d;
	Wed, 4 Sep 2024 09:42:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Alibek Omarov <a1ba.omarov@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH net-next 14/20] can: rockchip_canfd: rkcanfd_get_berr_counter_corrected(): work around broken {RX,TX}ERRORCNT register
Date: Wed,  4 Sep 2024 11:38:49 +0200
Message-ID: <20240904094218.1925386-15-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904094218.1925386-1-mkl@pengutronix.de>
References: <20240904094218.1925386-1-mkl@pengutronix.de>
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

Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patch.msgid.link/20240904-rockchip-canfd-v5-14-8ae22bcb27cc@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/rockchip/rockchip_canfd-core.c    | 50 ++++++++++++++++---
 drivers/net/can/rockchip/rockchip_canfd-rx.c  | 15 ++++++
 drivers/net/can/rockchip/rockchip_canfd-tx.c  |  8 +++
 drivers/net/can/rockchip/rockchip_canfd.h     |  2 +
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



