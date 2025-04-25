Return-Path: <linux-can+bounces-3493-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BE2A9D144
	for <lists+linux-can@lfdr.de>; Fri, 25 Apr 2025 21:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49EA03AEC9F
	for <lists+linux-can@lfdr.de>; Fri, 25 Apr 2025 19:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E18820E710;
	Fri, 25 Apr 2025 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vpprocess.com header.i=@vpprocess.com header.b="FOMbMbyu"
X-Original-To: linux-can@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C43012B73
	for <linux-can@vger.kernel.org>; Fri, 25 Apr 2025 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745608428; cv=none; b=mLujEDeIndYYGt12cJcTYcrnS1jhD3Bwu6VEXUjlE2LhbZxr2hyUjXKMzemCCGCOeWMnMSlE1GQwiSzteOopMJP8WWRk+92PwCK752nQFyo/ATGnkhC1bzKIXrdFhlmV6NmjXkE02/O1aVdT+q1dan8GTuHHynFINrBoSzkfv3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745608428; c=relaxed/simple;
	bh=enkWVEBl845Pw7cL7DuFBhNCweUv7qpqE052945Ate4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=M17vkxo1IoUNYhlGT02W+NxtjvGhpgivgg5H/PE0vvEmnDy0BDOtxZM5qvBbt73++hYcAGnBtcDlod8W4IyG2j0xQTbi018WeCCIAby1OVYhJq+2dTj9n8iQsmhg+RUVI1AfR2pqTgsJGdjSHTNKEBNmsenkJDKxiVN8ZHJ9Vd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vpprocess.com; spf=pass smtp.mailfrom=vpprocess.com; dkim=pass (2048-bit key) header.d=vpprocess.com header.i=@vpprocess.com header.b=FOMbMbyu; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vpprocess.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vpprocess.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vpprocess.com;
	s=key1; t=1745608422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DWwDsL5M4JhmU/2K3tYMWaGEHRqYK6UuXUFVAi9U8hE=;
	b=FOMbMbyu5vab0LQmU/XvjcNEca/W5f7U5qDDjsiZIKNfMqd30DxqUmGsrC8l44IisAYA0x
	mcQZAcfujg1KV1aIWPouhsiJetah6DPNz03IEOeiHMjt4Cw7SpB+UOnNJ0GXvwcz256huU
	u4IQigmTFHuI+qh4r79uAaNtjMB+OXsBn5t2A2BYNBKHPU6VWcksXF9PhFI2P9LXLkxfct
	cT2neUN8dHGFLwYJGLHXGu8F85fHvQ6p7gIZdEL2EC6vucWbfyOUarVWE8bAXCCq0Vad6V
	GUFlg9X2W2tML+zHtoOjrLEKI6leuF1Ia+nxX3j0371QLauQ5AsMXsLVukZVvA==
From: Kelsey Maes <kelsey@vpprocess.com>
To: linux-can@vger.kernel.org
Subject: [PATCH] can: mcp251xfd: make TDC controllable from userspace
Date: Fri, 25 Apr 2025 12:13:36 -0700
Message-Id: <20250425191336.45581-1-kelsey@vpprocess.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

TDC is currently hardcoded enabled so lower CAN FD data bitrates result in a
bus-off condition. This patch allows userspace to control TDC as needed.

Demonstration of the feature in action:
$ ip link set can0 down
$ ip link set can0 type can sample-point 0.875 bitrate 125000 dsample-point 0.875 dbitrate 500000 fd on berr-reporting on restart-ms 100
$ ip link set can0 up
$ ip -details link show can0
3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
    link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0
    can <BERR-REPORTING,FD> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 100
	  bitrate 125000 sample-point 0.875
	  tq 50 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 10 brp 2
	  mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp_inc 1
	  dbitrate 500000 dsample-point 0.875
	  dtq 125 dprop-seg 6 dphase-seg1 7 dphase-seg2 2 dsjw 1 dbrp 5
	  mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp_inc 1
	  tdco 0..63
	  clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 parentbus spi parentdev spi0.0
$ ip link set can0 down
$ ip link set can0 type can sample-point 0.875 bitrate 1000000 dsample-point 0.875 dbitrate 4000000 fd on berr-reporting on restart-ms 100
$ ip link set can0 up
$ ip -details link show can0
3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
    link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0
    can <BERR-REPORTING,FD,TDC-AUTO> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 100
	  bitrate 1000000 sample-point 0.875
	  tq 25 prop-seg 17 phase-seg1 17 phase-seg2 5 sjw 2 brp 1
	  mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp_inc 1
	  dbitrate 4000000 dsample-point 0.800
	  dtq 25 dprop-seg 3 dphase-seg1 4 dphase-seg2 2 dsjw 1 dbrp 1
	  tdco 8
	  mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp_inc 1
	  tdco 0..63
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

Signed-off-by: Kelsey Maes <kelsey@vpprocess.com>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 25 +++++++++++++------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 3bc56517f..025bfbaa7 100644
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
@@ -511,7 +520,6 @@ static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
 	const struct can_bittiming *bt = &priv->can.bittiming;
 	const struct can_bittiming *dbt = &priv->can.data_bittiming;
 	u32 val = 0;
-	s8 tdco;
 	int err;
 
 	/* CAN Control Register
@@ -575,11 +583,13 @@ static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
 		return err;
 
 	/* Transmitter Delay Compensation */
-	tdco = clamp_t(int, dbt->brp * (dbt->prop_seg + dbt->phase_seg1),
-		       -64, 63);
-	val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
-			 MCP251XFD_REG_TDC_TDCMOD_AUTO) |
-		FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, tdco);
+	if (can_tdc_is_enabled(&priv->can))
+		val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
+				 MCP251XFD_REG_TDC_TDCMOD_AUTO);
+	else
+		val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
+				 MCP251XFD_REG_TDC_TDCMOD_DISABLED);
+	val |= FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, priv->can.tdc.tdco);
 
 	return regmap_write(priv->map_reg, MCP251XFD_REG_TDC, val);
 }
@@ -2083,10 +2093,11 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	priv->can.do_get_berr_counter = mcp251xfd_get_berr_counter;
 	priv->can.bittiming_const = &mcp251xfd_bittiming_const;
 	priv->can.data_bittiming_const = &mcp251xfd_data_bittiming_const;
+	priv->can.tdc_const = &mcp251xfd_tdc_const;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_BERR_REPORTING |
 		CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_ISO |
-		CAN_CTRLMODE_CC_LEN8_DLC;
+		CAN_CTRLMODE_CC_LEN8_DLC | CAN_CTRLMODE_TDC_AUTO;
 	set_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
 	priv->ndev = ndev;
 	priv->spi = spi;
-- 
2.39.5 (Apple Git-154)


