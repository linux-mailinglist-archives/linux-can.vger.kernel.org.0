Return-Path: <linux-can+bounces-3511-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3EAAA5151
	for <lists+linux-can@lfdr.de>; Wed, 30 Apr 2025 18:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3516E1C04D30
	for <lists+linux-can@lfdr.de>; Wed, 30 Apr 2025 16:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10C227718;
	Wed, 30 Apr 2025 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vpprocess.com header.i=@vpprocess.com header.b="Jgm6DBrf"
X-Original-To: linux-can@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF70425E81F
	for <linux-can@vger.kernel.org>; Wed, 30 Apr 2025 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746029711; cv=none; b=F0DGGLj+DtdBpr+DYVM1ba/1v0Tki3pePYUoVB9nEFQV99i7viYvtZpvPSdLFG/dm/JiCgfwI9/yzqku6vPMDECS6Nv55+2Drr/c7sLWBvFc4iMLptzHuNa4wECHZ/x5WGVyK6YE/gFDFf/EHh69qTeKqaaMXyT9a9wykS4F6sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746029711; c=relaxed/simple;
	bh=mq15vDpFckG3leXg02phUYPtYirs5M00OWmPldAaq2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Spnm7rneqYYQC+13zjUYOGGDo0Eec6Q1YsOZyYl2Ln9Tu+Sk9rXUyYPhozcKqvmxUr/WPvryryh7KzrxwJZCc9oAyh6UN64OxV23mHO37WU8rEVCHVpOqwt4qz+WLYs4E6epJJvpcFKHjVaBEdxUQ/aobLxULYGy8Uuyw5856bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vpprocess.com; spf=pass smtp.mailfrom=vpprocess.com; dkim=pass (2048-bit key) header.d=vpprocess.com header.i=@vpprocess.com header.b=Jgm6DBrf; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vpprocess.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vpprocess.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vpprocess.com;
	s=key1; t=1746029705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZDmZva/esD2gIYYPPBcSTqk+xJflPdF9ogz2jAzpe0Q=;
	b=Jgm6DBrf7ofDjfwcenOF9gpB2Si0haUyklrGLF1ygh3izcoI32RdvCDRzGaHcmICIlulm/
	La3Osx3iE4Xa7FIyy/il0WHrrZHW9tSsXxb7lL5V1NiivZ/1VyjWTc4NrmN6p6LSaCKpgU
	67ZbGd8Od5RPSg/9oJMJkKyjIstkYXvS89a9B7yuCVaZ4uREbjrSi6nMruoE1iCjBef6V6
	O6eggIBBQz0GcZX5+NKEgKBPkI+1ERtAqfNP6orH8aamC2UkrQPEPkY1j9I74mCNAtOeR4
	DACsuG1NU0FTBVVFrxWpuqgKYECM3BjA0IIQD/MU4M9ecfUABRz0ZuxpsAPtwg==
From: Kelsey Maes <kelsey@vpprocess.com>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v5] can: mcp251xfd: fix TDC setting for low data bit rates
Date: Wed, 30 Apr 2025 09:15:01 -0700
Message-Id: <20250430161501.79370-1-kelsey@vpprocess.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The TDC is currently hardcoded enabled. This means that even for lower CAN-FD
data bitrates (with a DBRP (data bitrate prescaler) > 2) a TDC is configured.
This leads to a bus-off condition.

ISO 11898-1 section 11.3.3 says "Transmitter delay compensation" (TDC) is only
applicable if DBRP is 1 or 2.

To fix the problem, switch the driver to use the TDC calculation provided by the
CAN driver framework (which respects ISO 11898-1 section 11.3.3). This has the
positive side effect that userspace can control TDC as needed.

Demonstration of the feature in action:
  $ ip link set can0 up type can bitrate 125000 dbitrate 500000 fd on
  $ ip -details link show can0
  3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
      link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0
      can <FD> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
  	  bitrate 125000 sample-point 0.875
  	  tq 50 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 10 brp 2
  	  mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp_inc 1
  	  dbitrate 500000 dsample-point 0.875
  	  dtq 125 dprop-seg 6 dphase-seg1 7 dphase-seg2 2 dsjw 1 dbrp 5
  	  mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp_inc 1
  	  tdcv 0..63 tdco 0..63
  	  clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 parentbus spi parentdev spi0.0
  $ ip link set can0 up type can bitrate 1000000 dbitrate 4000000 fd on
  $ ip -details link show can0
  3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
      link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0
      can <FD,TDC-AUTO> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
  	  bitrate 1000000 sample-point 0.750
  	  tq 25 prop-seg 14 phase-seg1 15 phase-seg2 10 sjw 5 brp 1
  	  mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp_inc 1
  	  dbitrate 4000000 dsample-point 0.700
  	  dtq 25 dprop-seg 3 dphase-seg1 3 dphase-seg2 3 dsjw 1 dbrp 1
  	  tdco 7
  	  mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp_inc 1
  	  tdcv 0..63 tdco 0..63
  	  clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 parentbus spi parentdev spi0.0

There has been some confusion about the MCP2518FD using a relative or absolute
TDCO due to the datasheet specifying a range of [-64,63]. I have a custom board
with a 40 MHz clock and an estimated loop delay of 100 to 216 ns. During testing
at a data bit rate of 4 Mbit/s I found that using can_get_relative_tdco()
resulted in bus-off errors. The final TDCO value was 1 which corresponds to a
10% SSP in an absolute configuration. This behavior is expected if the TDCO
value is really absolute and not relative. Using priv->can.tdc.tdco instead
results in a final TDCO of 8, setting the SSP at exactly 80%. This configuration
works.

The automatic, manual, and off TDC modes were tested at speeds up to, and
including, 8 Mbit/s on real hardware and behave as expected.

Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
Reported-by: Kelsey Maes <kelsey@vpprocess.com>
Closes: https://lore.kernel.org/all/C2121586-C87F-4B23-A933-845362C29CA1@vpprocess.com
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Kelsey Maes <kelsey@vpprocess.com>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 31 ++++++++++++++-----
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 3bc56517f..34d5cbef6 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -75,6 +75,15 @@ static const struct can_bittiming_const mcp251xfd_data_bittiming_const = {
 	.brp_inc = 1,
 };
 
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
@@ -510,8 +519,7 @@ static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
 {
 	const struct can_bittiming *bt = &priv->can.bittiming;
 	const struct can_bittiming *dbt = &priv->can.data_bittiming;
-	u32 val = 0;
-	s8 tdco;
+	u32 tdcmod, val = 0;
 	int err;
 
 	/* CAN Control Register
@@ -575,11 +583,16 @@ static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
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
@@ -2083,10 +2096,12 @@ static int mcp251xfd_probe(struct spi_device *spi)
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
2.39.5 (Apple Git-154)


