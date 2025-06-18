Return-Path: <linux-can+bounces-3862-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2536ADE6C5
	for <lists+linux-can@lfdr.de>; Wed, 18 Jun 2025 11:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1639017D3C8
	for <lists+linux-can@lfdr.de>; Wed, 18 Jun 2025 09:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5642728541B;
	Wed, 18 Jun 2025 09:23:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4E7285059
	for <linux-can@vger.kernel.org>; Wed, 18 Jun 2025 09:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238629; cv=none; b=slzN8O+G3dGlTFZv6/S1Roxu+Es6yNXQN8/twCAk+j2I1bXxgSBlNbR5G59loK0aT2KSb5TI+V489O5L/VB4zzkPLSyZS8Uib34kmjZdxGplcWBeFtilIMf8S7uXhaCTNrycYAb87jeEDyNq07Nq7NP8/ea6zuzFXw/8F95Y4+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238629; c=relaxed/simple;
	bh=pT0/lqkZiAKydNR73vgEFiXszFWZQBjVmqPWkVWCwPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJQthzBYHYeLW+je1Xj/5HoENfz9DE5yiYsAj69auJluolIaCjLXqPJr05WwouroOhvdTwyTD1CwPW3SgOW59dbqH4EoGosDKwzOpZDRX6je6KUNTDU/iEVyXWTTWMBcvgRoQY7LwCi92FIu/TQPkAJBVq7FCgcUIE72NUS81JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRp1E-0006eA-D7
	for linux-can@vger.kernel.org; Wed, 18 Jun 2025 11:23:44 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRp1C-00479q-2V
	for linux-can@vger.kernel.org;
	Wed, 18 Jun 2025 11:23:42 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 7055742B2C8
	for <linux-can@vger.kernel.org>; Wed, 18 Jun 2025 09:23:42 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id A422042B286;
	Wed, 18 Jun 2025 09:23:39 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ce70aeb6;
	Wed, 18 Jun 2025 09:23:38 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 10/10] can: rcar_canfd: Add support for Transceiver Delay Compensation
Date: Wed, 18 Jun 2025 11:20:04 +0200
Message-ID: <20250618092336.2175168-11-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250618092336.2175168-1-mkl@pengutronix.de>
References: <20250618092336.2175168-1-mkl@pengutronix.de>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

The Renesas CAN-FD hardware block supports configuring Transceiver Delay
Compensation, and reading back the Transceiver Delay Compensation
Result, which is needed to support high transfer rates like 8 Mbps.
The Secondary Sample Point is either the measured delay plus the
configured offset, or just the configured offset.

Fix the existing RCANFD_FDCFG_TDCO() macro for the intended use case
(writing instead of reading the field).  Add register definition bits
for the Channel n CAN-FD Status Register.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/69db727d5f728d679ba691d20854e7d963d0f323.1749655315.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 85 +++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 3340ae75bbec..1e559c0ff038 100644
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
+#define RCANFD_GEN4_FDSTS_TDCVF		BIT(15)
+#define RCANFD_GEN4_FDSTS_PNSTS		GENMASK(13, 12)
+#define RCANFD_FDSTS_SOCO		BIT(9)
+#define RCANFD_FDSTS_EOCO		BIT(8)
+#define RCANFD_FDSTS_TDCVF		BIT(7)
+#define RCANFD_FDSTS_TDCR		GENMASK(7, 0)
 
 /* RSCFDnCFDRFCCx */
 #define RCANFD_RFCC_RFIM		BIT(12)
@@ -520,6 +530,7 @@ struct rcar_canfd_shift_data {
 struct rcar_canfd_hw_info {
 	const struct can_bittiming_const *nom_bittiming;
 	const struct can_bittiming_const *data_bittiming;
+	const struct can_tdc_const *tdc_const;
 	const struct rcar_canfd_regs *regs;
 	const struct rcar_canfd_shift_data *sh;
 	u8 rnc_field_width;
@@ -627,6 +638,25 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
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
@@ -672,6 +702,7 @@ static const struct rcar_canfd_shift_data rcar_gen4_shift_data = {
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
+	.tdc_const = &rcar_canfd_gen3_tdc_const,
 	.regs = &rcar_gen3_regs,
 	.sh = &rcar_gen3_shift_data,
 	.rnc_field_width = 8,
@@ -688,6 +719,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
+	.tdc_const = &rcar_canfd_gen4_tdc_const,
 	.regs = &rcar_gen4_regs,
 	.sh = &rcar_gen4_shift_data,
 	.rnc_field_width = 16,
@@ -704,6 +736,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
+	.tdc_const = &rcar_canfd_gen3_tdc_const,
 	.regs = &rcar_gen3_regs,
 	.sh = &rcar_gen3_shift_data,
 	.rnc_field_width = 8,
@@ -720,6 +753,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
+	.tdc_const = &rcar_canfd_gen4_tdc_const,
 	.regs = &rcar_gen4_regs,
 	.sh = &rcar_gen4_shift_data,
 	.rnc_field_width = 16,
@@ -1460,12 +1494,15 @@ static irqreturn_t rcar_canfd_channel_interrupt(int irq, void *dev_id)
 
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
@@ -1497,6 +1534,20 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 	       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
 
 	rcar_canfd_write(priv->base, rcar_canfd_f_dcfg(gpriv, ch), cfg);
+
+	/* Transceiver Delay Compensation */
+	if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_AUTO) {
+		/* TDC enabled, measured + offset */
+		tdcmode = RCANFD_FDCFG_TDCE;
+		tdco = tdc->tdco - 1;
+	} else if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_MANUAL) {
+		/* TDC enabled, offset only */
+		tdcmode = RCANFD_FDCFG_TDCE | RCANFD_FDCFG_TDCOC;
+		tdco = min(tdc->tdcv + tdc->tdco, tdc_const->tdco_max) - 1;
+	}
+
+	rcar_canfd_update_bit(gpriv->base, rcar_canfd_f_cfdcfg(gpriv, ch), mask,
+			      tdcmode | FIELD_PREP(RCANFD_FDCFG_TDCO, tdco));
 }
 
 static int rcar_canfd_start(struct net_device *ndev)
@@ -1807,6 +1858,29 @@ static int rcar_canfd_rx_poll(struct napi_struct *napi, int quota)
 	return num_pkts;
 }
 
+static unsigned int rcar_canfd_get_tdcr(struct rcar_canfd_global *gpriv,
+					unsigned int ch)
+{
+	u32 sts = rcar_canfd_read(gpriv->base, rcar_canfd_f_cfdsts(gpriv, ch));
+	u32 tdcr = FIELD_GET(RCANFD_FDSTS_TDCR, sts);
+
+	return tdcr & (gpriv->info->tdc_const->tdcv_max - 1);
+}
+
+static int rcar_canfd_get_auto_tdcv(const struct net_device *ndev, u32 *tdcv)
+{
+	struct rcar_canfd_channel *priv = netdev_priv(ndev);
+	u32 tdco = priv->can.fd.tdc.tdco;
+	u32 tdcr;
+
+	/* Transceiver Delay Compensation Result */
+	tdcr = rcar_canfd_get_tdcr(priv->gpriv, priv->channel) + 1;
+
+	*tdcv = tdcr < tdco ? 0 : tdcr - tdco;
+
+	return 0;
+}
+
 static int rcar_canfd_do_set_mode(struct net_device *ndev, enum can_mode mode)
 {
 	int err;
@@ -1929,12 +2003,17 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
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
2.47.2



