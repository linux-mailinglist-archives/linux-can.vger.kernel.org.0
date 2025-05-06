Return-Path: <linux-can+bounces-3545-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B88EAAC730
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 15:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4751BA49BC
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 14:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E186281374;
	Tue,  6 May 2025 13:59:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8795A280008
	for <linux-can@vger.kernel.org>; Tue,  6 May 2025 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539987; cv=none; b=TO1cKbMYNG6jIGNSaS+C+Cex2fsxRcUcepOzurHBNLAK4iGTut+h9eKng5/bgJDNS7WOzClpjra108Nb7yqmm7BPbi9AiVI2qnlRVoNL6CVGc7ELLc+xzOgKR8H/9AKQmatDqHo5kRcnBYx7zc9qXp0Wmh5M0a++a7W5I9QVgNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539987; c=relaxed/simple;
	bh=EgwDTmoxAcWDrMGQj1WZkaNkSd2Dz3bwYxmKA5ICoC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7evYjMUoNQSfaZLiLYUC5afMZ2fOL5ziJLZbdSCEyEPepbMOhs+Elj1rwY8SP0q1IfE9smgR495mwfIFvvRgRkiTA85E+dLqNMmuzKlbJpr+Qohi8hXdhZEQmqYh+RgXJkUPZ6tHje0B+NF63qLd+Y5ryeGuwyI5zv7rmVDuIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uCIpj-0007oQ-PE
	for linux-can@vger.kernel.org; Tue, 06 May 2025 15:59:43 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uCIpj-001P83-1a
	for linux-can@vger.kernel.org;
	Tue, 06 May 2025 15:59:43 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 30FC0408F50
	for <linux-can@vger.kernel.org>; Tue, 06 May 2025 13:59:43 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id ECD7A408F35;
	Tue, 06 May 2025 13:59:41 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 80c055d2;
	Tue, 6 May 2025 13:59:41 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Kelsey Maes <kelsey@vpprocess.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 2/6] can: mcp251xfd: fix TDC setting for low data bit rates
Date: Tue,  6 May 2025 15:56:18 +0200
Message-ID: <20250506135939.652543-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250506135939.652543-1-mkl@pengutronix.de>
References: <20250506135939.652543-1-mkl@pengutronix.de>
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

From: Kelsey Maes <kelsey@vpprocess.com>

The TDC is currently hardcoded enabled. This means that even for lower
CAN-FD data bitrates (with a DBRP (data bitrate prescaler) > 2) a TDC
is configured. This leads to a bus-off condition.

ISO 11898-1 section 11.3.3 says "Transmitter delay compensation" (TDC)
is only applicable if DBRP is 1 or 2.

To fix the problem, switch the driver to use the TDC calculation
provided by the CAN driver framework (which respects ISO 11898-1
section 11.3.3). This has the positive side effect that userspace can
control TDC as needed.

Demonstration of the feature in action:
| $ ip link set can0 up type can bitrate 125000 dbitrate 500000 fd on
| $ ip -details link show can0
| 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
|     link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0
|     can <FD> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
| 	  bitrate 125000 sample-point 0.875
| 	  tq 50 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 10 brp 2
| 	  mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp_inc 1
| 	  dbitrate 500000 dsample-point 0.875
| 	  dtq 125 dprop-seg 6 dphase-seg1 7 dphase-seg2 2 dsjw 1 dbrp 5
| 	  mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp_inc 1
| 	  tdcv 0..63 tdco 0..63
| 	  clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 parentbus spi parentdev spi0.0
| $ ip link set can0 up type can bitrate 1000000 dbitrate 4000000 fd on
| $ ip -details link show can0
| 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
|     link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0
|     can <FD,TDC-AUTO> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
| 	  bitrate 1000000 sample-point 0.750
| 	  tq 25 prop-seg 14 phase-seg1 15 phase-seg2 10 sjw 5 brp 1
| 	  mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp_inc 1
| 	  dbitrate 4000000 dsample-point 0.700
| 	  dtq 25 dprop-seg 3 dphase-seg1 3 dphase-seg2 3 dsjw 1 dbrp 1
| 	  tdco 7
| 	  mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp_inc 1
| 	  tdcv 0..63 tdco 0..63
| 	  clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 parentbus spi parentdev spi0.0

There has been some confusion about the MCP2518FD using a relative or
absolute TDCO due to the datasheet specifying a range of [-64,63]. I
have a custom board with a 40 MHz clock and an estimated loop delay of
100 to 216 ns. During testing at a data bit rate of 4 Mbit/s I found
that using can_get_relative_tdco() resulted in bus-off errors. The
final TDCO value was 1 which corresponds to a 10% SSP in an absolute
configuration. This behavior is expected if the TDCO value is really
absolute and not relative. Using priv->can.tdc.tdco instead results in
a final TDCO of 8, setting the SSP at exactly 80%. This configuration
works.

The automatic, manual, and off TDC modes were tested at speeds up to,
and including, 8 Mbit/s on real hardware and behave as expected.

Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
Reported-by: Kelsey Maes <kelsey@vpprocess.com>
Closes: https://lore.kernel.org/all/C2121586-C87F-4B23-A933-845362C29CA1@vpprocess.com
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Kelsey Maes <kelsey@vpprocess.com>
Link: https://patch.msgid.link/20250430161501.79370-1-kelsey@vpprocess.com
[mkl: add comment]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 40 +++++++++++++++----
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 3bc56517fe7a..064d81c724f4 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -75,6 +75,24 @@ static const struct can_bittiming_const mcp251xfd_data_bittiming_const = {
 	.brp_inc = 1,
 };
 
+/* The datasheet of the mcp2518fd (DS20006027B) specifies a range of
+ * [-64,63] for TDCO, indicating a relative TDCO.
+ *
+ * Manual tests have shown, that using a relative TDCO configuration
+ * results in bus off, while an absolute configuration works.
+ *
+ * For TDCO use the max value (63) from the data sheet, but 0 as the
+ * minimum.
+ */
+static const struct can_tdc_const mcp251xfd_tdc_const = {
+	.tdcv_min = 0,
+	.tdcv_max = 63,
+	.tdco_min = 0,
+	.tdco_max = 63,
+	.tdcf_min = 0,
+	.tdcf_max = 0,
+};
+
 static const char *__mcp251xfd_get_model_str(enum mcp251xfd_model model)
 {
 	switch (model) {
@@ -510,8 +528,7 @@ static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
 {
 	const struct can_bittiming *bt = &priv->can.bittiming;
 	const struct can_bittiming *dbt = &priv->can.data_bittiming;
-	u32 val = 0;
-	s8 tdco;
+	u32 tdcmod, val = 0;
 	int err;
 
 	/* CAN Control Register
@@ -575,11 +592,16 @@ static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
 		return err;
 
 	/* Transmitter Delay Compensation */
-	tdco = clamp_t(int, dbt->brp * (dbt->prop_seg + dbt->phase_seg1),
-		       -64, 63);
-	val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
-			 MCP251XFD_REG_TDC_TDCMOD_AUTO) |
-		FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, tdco);
+	if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_AUTO)
+		tdcmod = MCP251XFD_REG_TDC_TDCMOD_AUTO;
+	else if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_MANUAL)
+		tdcmod = MCP251XFD_REG_TDC_TDCMOD_MANUAL;
+	else
+		tdcmod = MCP251XFD_REG_TDC_TDCMOD_DISABLED;
+
+	val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK, tdcmod) |
+		FIELD_PREP(MCP251XFD_REG_TDC_TDCV_MASK, priv->can.tdc.tdcv) |
+		FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, priv->can.tdc.tdco);
 
 	return regmap_write(priv->map_reg, MCP251XFD_REG_TDC, val);
 }
@@ -2083,10 +2105,12 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	priv->can.do_get_berr_counter = mcp251xfd_get_berr_counter;
 	priv->can.bittiming_const = &mcp251xfd_bittiming_const;
 	priv->can.data_bittiming_const = &mcp251xfd_data_bittiming_const;
+	priv->can.tdc_const = &mcp251xfd_tdc_const;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_BERR_REPORTING |
 		CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_ISO |
-		CAN_CTRLMODE_CC_LEN8_DLC;
+		CAN_CTRLMODE_CC_LEN8_DLC | CAN_CTRLMODE_TDC_AUTO |
+		CAN_CTRLMODE_TDC_MANUAL;
 	set_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
 	priv->ndev = ndev;
 	priv->spi = spi;
-- 
2.47.2



