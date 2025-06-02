Return-Path: <linux-can+bounces-3750-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5188BACADA2
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 13:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0D3189F332
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 11:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05F31F150A;
	Mon,  2 Jun 2025 11:54:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8655514F70;
	Mon,  2 Jun 2025 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748865298; cv=none; b=tYbLhU2jEqd4mIRueYVb+C8hb/DcDgQu7Ak8pylnIFj70nHGCZcPlBNyvv1eKrXVA1d59PtXzcZLyN0fjSpGU/V1WLX3JFy2+zIzayoI7duHD6FUuWRxgyazaQRCc/jKy6kB4qNhXn54yK39qhh85IPEK6PoSsNvuFrWRt+RJVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748865298; c=relaxed/simple;
	bh=keMbo/Y5uBm8FJUZP1h61ahxFaLO5e1SEDVngzgo9EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X17g/DSyzqhYGtqeCQxoQT5g5zlIhSxxvbAdlbz8J/ilSs06mkINj9Tjozm+cXTAaIH+QeqJ7M+npm5rENHvAwYsB4MCneznQuhLSCB7mAO2a1zSIQZINr5FKXVTY/ISeIyBgw8/at97OlUJ6EJq1JkHrSkEMu9kZLrvSzGczPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2559BC4CEEB;
	Mon,  2 Jun 2025 11:54:55 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Kazuhiro Takagi <kazuhiro.takagi.hh@hitachi-solutions.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 9/9] can: rcar_canfd: Add support for Transceiver Delay Compensation
Date: Mon,  2 Jun 2025 13:54:28 +0200
Message-ID: <c830bd8b65d5f96c8831a2967c5b4c0eeb30e0af.1748863848.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1748863848.git.geert+renesas@glider.be>
References: <cover.1748863848.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas CAN-FD hardware block supports configuring Transceiver Delay
Compensation, and reading back the Transceiver Delay Compensation
Result, which is needed to support high transfer rates like 8 Mbps.
The Secondary Sample Point is either the measured delay plus the
configured offset, or just the configured offset.

Fix the existing RCANFD_FDCFG_TDCO() macro for the intended use case
(writing instead of reading the field).  Add register definition bits
for the Channel n CAN-FD Status Register.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/can/rcar/rcar_canfd.c | 80 +++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 7b6bb67ed6f76f14..a9c5b4ac040bdc0a 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -191,9 +191,19 @@
 /* RSCFDnCFDCmFDCFG */
 #define RCANFD_GEN4_FDCFG_CLOE		BIT(30)
 #define RCANFD_GEN4_FDCFG_FDOE		BIT(28)
+#define RCANFD_FDCFG_TDCO		GENMASK(23, 16)
 #define RCANFD_FDCFG_TDCE		BIT(9)
 #define RCANFD_FDCFG_TDCOC		BIT(8)
-#define RCANFD_FDCFG_TDCO(x)		(((x) & 0x7f) >> 16)
+
+/* RSCFDnCFDCmFDSTS */
+#define RCANFD_FDSTS_SOC		GENMASK(31, 24)
+#define RCANFD_FDSTS_EOC		GENMASK(23, 16)
+#define RCANFD_GEN4_FDSTS_PNSTS		GENMASK(13, 12)
+#define RCANFD_FDSTS_SOCO		BIT(9)
+#define RCANFD_FDSTS_EOCO		BIT(8)
+#define RCANFD_FDSTS_TDCR(gpriv, x)	((x) & ((gpriv)->info->tdc_const->tdcv_max - 1))
+#define RCANFD_FDSTS_TDCVF(gpriv) \
+	((gpriv)->info->tdc_const->tdcv_max > 128 ? BIT(15) : BIT(7))
 
 /* RSCFDnCFDRFCCx */
 #define RCANFD_RFCC_RFIM		BIT(12)
@@ -527,6 +537,7 @@ struct rcar_canfd_shift_data {
 struct rcar_canfd_hw_info {
 	const struct can_bittiming_const *nom_bittiming;
 	const struct can_bittiming_const *data_bittiming;
+	const struct can_tdc_const *tdc_const;
 	const struct rcar_canfd_regs *regs;
 	const struct rcar_canfd_shift_data *sh;
 	u8 rnc_field_width;
@@ -634,6 +645,25 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
 	.brp_inc = 1,
 };
 
+/* CAN FD Transmission Delay Compensation constants */
+static const struct can_tdc_const rcar_canfd_gen3_tdc_const = {
+	.tdcv_min = 1,
+	.tdcv_max = 128,
+	.tdco_min = 1,
+	.tdco_max = 128,
+	.tdcf_min = 0,	/* Filter window not supported */
+	.tdcf_max = 0,
+};
+
+static const struct can_tdc_const rcar_canfd_gen4_tdc_const = {
+	.tdcv_min = 1,
+	.tdcv_max = 256,
+	.tdco_min = 1,
+	.tdco_max = 256,
+	.tdcf_min = 0,	/* Filter window not supported */
+	.tdcf_max = 0,
+};
+
 static const struct rcar_canfd_regs rcar_gen3_regs = {
 	.rfcc = 0x00b8,
 	.cfcc = 0x0118,
@@ -679,6 +709,7 @@ static const struct rcar_canfd_shift_data rcar_gen4_shift_data = {
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
+	.tdc_const = &rcar_canfd_gen3_tdc_const,
 	.regs = &rcar_gen3_regs,
 	.sh = &rcar_gen3_shift_data,
 	.rnc_field_width = 8,
@@ -695,6 +726,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
+	.tdc_const = &rcar_canfd_gen4_tdc_const,
 	.regs = &rcar_gen4_regs,
 	.sh = &rcar_gen4_shift_data,
 	.rnc_field_width = 16,
@@ -711,6 +743,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
+	.tdc_const = &rcar_canfd_gen3_tdc_const,
 	.regs = &rcar_gen3_regs,
 	.sh = &rcar_gen3_shift_data,
 	.rnc_field_width = 8,
@@ -727,6 +760,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
+	.tdc_const = &rcar_canfd_gen4_tdc_const,
 	.regs = &rcar_gen4_regs,
 	.sh = &rcar_gen4_shift_data,
 	.rnc_field_width = 16,
@@ -1436,12 +1470,15 @@ static irqreturn_t rcar_canfd_channel_interrupt(int irq, void *dev_id)
 
 static void rcar_canfd_set_bittiming(struct net_device *ndev)
 {
+	u32 mask = RCANFD_FDCFG_TDCO | RCANFD_FDCFG_TDCE | RCANFD_FDCFG_TDCOC;
 	struct rcar_canfd_channel *priv = netdev_priv(ndev);
 	struct rcar_canfd_global *gpriv = priv->gpriv;
 	const struct can_bittiming *bt = &priv->can.bittiming;
 	const struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
+	const struct can_tdc_const *tdc_const = priv->can.fd.tdc_const;
+	const struct can_tdc *tdc = &priv->can.fd.tdc;
+	u32 cfg, tdcmode = 0, tdco = 0;
 	u16 brp, sjw, tseg1, tseg2;
-	u32 cfg;
 	u32 ch = priv->channel;
 
 	/* Nominal bit timing settings */
@@ -1477,6 +1514,22 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 	rcar_canfd_write(priv->base, RCANFD_F_DCFG(gpriv, ch), cfg);
 	netdev_dbg(ndev, "drate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
 		   brp, sjw, tseg1, tseg2);
+
+	/* Transceiver Delay Compensation */
+	if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_AUTO) {
+		/* TDC enabled, measured + offset */
+		tdcmode = RCANFD_FDCFG_TDCE;
+		tdco = tdc->tdco - 1;
+		netdev_dbg(ndev, "tdc: auto %u\n", tdco);
+	} else if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_MANUAL) {
+		/* TDC enabled, offset only */
+		tdcmode = RCANFD_FDCFG_TDCE | RCANFD_FDCFG_TDCOC;
+		tdco = min(tdc->tdcv + tdc->tdco, tdc_const->tdco_max) - 1;
+		netdev_dbg(ndev, "tdc: manual %u\n", tdco);
+	}
+
+	rcar_canfd_update_bit(gpriv->base, RCANFD_F_CFDCFG(gpriv, ch), mask,
+			      tdcmode | FIELD_PREP(RCANFD_FDCFG_TDCO, tdco));
 }
 
 static int rcar_canfd_start(struct net_device *ndev)
@@ -1787,6 +1840,22 @@ static int rcar_canfd_rx_poll(struct napi_struct *napi, int quota)
 	return num_pkts;
 }
 
+static int rcar_canfd_get_auto_tdcv(const struct net_device *ndev, u32 *tdcv)
+{
+	struct rcar_canfd_channel *priv = netdev_priv(ndev);
+	struct rcar_canfd_global *gpriv = priv->gpriv;
+	u32 sts = rcar_canfd_read(priv->base, RCANFD_F_CFDSTS(gpriv, priv->channel));
+	u32 tdco = priv->can.fd.tdc.tdco;
+	u32 tdcr;
+
+	/* Transceiver Delay Compensation Result */
+	tdcr = RCANFD_FDSTS_TDCR(gpriv, sts) + 1;
+
+	*tdcv = tdcr < tdco ? 0 : tdcr - tdco;
+
+	return 0;
+}
+
 static int rcar_canfd_do_set_mode(struct net_device *ndev, enum can_mode mode)
 {
 	int err;
@@ -1909,12 +1978,17 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 	if (gpriv->fdmode) {
 		priv->can.bittiming_const = gpriv->info->nom_bittiming;
 		priv->can.fd.data_bittiming_const = gpriv->info->data_bittiming;
+		priv->can.fd.tdc_const = gpriv->info->tdc_const;
 
 		/* Controller starts in CAN FD only mode */
 		err = can_set_static_ctrlmode(ndev, CAN_CTRLMODE_FD);
 		if (err)
 			goto fail;
-		priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING;
+
+		priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING |
+					       CAN_CTRLMODE_TDC_AUTO |
+					       CAN_CTRLMODE_TDC_MANUAL;
+		priv->can.fd.do_get_auto_tdcv = rcar_canfd_get_auto_tdcv;
 	} else {
 		/* Controller starts in Classical CAN only mode */
 		priv->can.bittiming_const = &rcar_canfd_bittiming_const;
-- 
2.43.0


