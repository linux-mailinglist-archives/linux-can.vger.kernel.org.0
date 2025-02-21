Return-Path: <linux-can+bounces-2920-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FFBA3ED79
	for <lists+linux-can@lfdr.de>; Fri, 21 Feb 2025 08:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBA2C7ABBB2
	for <lists+linux-can@lfdr.de>; Fri, 21 Feb 2025 07:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F471FFC51;
	Fri, 21 Feb 2025 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/pVkiLI"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11EA1FF7BE;
	Fri, 21 Feb 2025 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740123680; cv=none; b=iOciI42QDPnhoIqyAnPgc5YECVCIq1DLydpx+cBtkkui76doGGqtTk+UTZ9rsYWW+BW//Ig8HCos8TNeXNr1La6L4sKd1wR5RFrDvZFHABv2wmfY3fhMeeHf3vq0yt9cnWUy+hS6SNS3AhYhK88wUC4TOP8KqmWCUARKf05Or4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740123680; c=relaxed/simple;
	bh=BtOhGRVLO/4z5tXwtnomJn5XJEhbKXaC1bZE6yJRkys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y9gv/mICYh7/wud0tRzrW31DjvicTw/TLOs+SV3Opr+AbIiEPFlSs63ggLw0o0iQM1Zj1gwF0vLQSyJ8tbIs0m1Jtt5MinRM9K0fj0bScOaIoilR/3Bg221aPancDMu5f2xmiPbn1BeX43ZCD+4vUWKX48P9cZAPMwqvUwCuwfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/pVkiLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 868A9C4CEE6;
	Fri, 21 Feb 2025 07:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740123679;
	bh=BtOhGRVLO/4z5tXwtnomJn5XJEhbKXaC1bZE6yJRkys=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=k/pVkiLIzhnetvNhWEuHRosB2MS48gmV7+6rK/rT5Fw9HE8hY+IehxiW0R336cnN2
	 6fgedAwCdSO7ntbfRHZkvfgujhHyGk6LZGZ7cHuGz/g3lvMXLKy4aAWHQarFYp3dec
	 ucvnnUTkLG5xou2CLvx7rpPkA46LabzFQUbPGxUCLOOQ2N+RvQ99LtMVWyCyNPHWte
	 secePCvC2093uo3oQ5qyjVcE6lwz4dhkZa4IO3WSAr0BcY2ZwG/qyY88o3wSXGeJQO
	 Dktcwz9T3EK3CPn9SbnSuzVFASZUn2KGPl1zIwXOgmTepQdVtYFfH9YXumZOQJ9JaS
	 U16hfJzX6BGeg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BE2C021B6;
	Fri, 21 Feb 2025 07:41:19 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Fri, 21 Feb 2025 08:40:05 +0100
Subject: [PATCH v3 2/2] can: flexcan: add transceiver capabilities
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-flexcan-add-transceiver-caps-v3-2-a947bde55a62@liebherr.com>
References: <20250221-flexcan-add-transceiver-caps-v3-0-a947bde55a62@liebherr.com>
In-Reply-To: <20250221-flexcan-add-transceiver-caps-v3-0-a947bde55a62@liebherr.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740123678; l=3555;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=kSxxiQHxl//wCevFJfiq2EaHcqBYYuWBjHktSM+Fwds=;
 b=mJy8In3h47OksHpZVNhxcoZbKbvYREY2hVQNAOD6IR0AVGcLMT7+qrO1D+I/AuEH4QF0WU0GC
 R1lIfClAmmDCm+DvzitiAtXrqwDIoLOEkxCCtlHDN4h2hJYkcGh7bsR
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Currently the flexcan driver does only support adding PHYs by using the
"old" regulator bindings. Add support for CAN transceivers as a PHY. Add
the capability to ensure that the PHY is in operational state when the link
is set to an "up" state.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 27 +++++++++++++++++++++------
 drivers/net/can/flexcan/flexcan.h      |  1 +
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index b347a1c93536d54efaa5f7d3347bd47c20860b3e..7588cb54a909af065522ddbcb06cc3acb9669893 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -26,6 +26,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/can/platform/flexcan.h>
+#include <linux/phy/phy.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
@@ -644,18 +645,22 @@ static void flexcan_clks_disable(const struct flexcan_priv *priv)
 
 static inline int flexcan_transceiver_enable(const struct flexcan_priv *priv)
 {
-	if (!priv->reg_xceiver)
-		return 0;
+	if (priv->reg_xceiver)
+		return regulator_enable(priv->reg_xceiver);
+	else if (priv->transceiver)
+		return phy_power_on(priv->transceiver);
 
-	return regulator_enable(priv->reg_xceiver);
+	return 0;
 }
 
 static inline int flexcan_transceiver_disable(const struct flexcan_priv *priv)
 {
-	if (!priv->reg_xceiver)
-		return 0;
+	if (priv->reg_xceiver)
+		return regulator_disable(priv->reg_xceiver);
+	else if (priv->transceiver)
+		return phy_power_off(priv->transceiver);
 
-	return regulator_disable(priv->reg_xceiver);
+	return 0;
 }
 
 static int flexcan_chip_enable(struct flexcan_priv *priv)
@@ -2086,6 +2091,7 @@ static int flexcan_probe(struct platform_device *pdev)
 	struct net_device *dev;
 	struct flexcan_priv *priv;
 	struct regulator *reg_xceiver;
+	struct phy *transceiver;
 	struct clk *clk_ipg = NULL, *clk_per = NULL;
 	struct flexcan_regs __iomem *regs;
 	struct flexcan_platform_data *pdata;
@@ -2101,6 +2107,11 @@ static int flexcan_probe(struct platform_device *pdev)
 	else if (IS_ERR(reg_xceiver))
 		return PTR_ERR(reg_xceiver);
 
+	transceiver = devm_phy_optional_get(&pdev->dev, NULL);
+	if (IS_ERR(transceiver))
+		return dev_err_probe(&pdev->dev, PTR_ERR(transceiver),
+				     "failed to get phy\n");
+
 	if (pdev->dev.of_node) {
 		of_property_read_u32(pdev->dev.of_node,
 				     "clock-frequency", &clock_freq);
@@ -2198,6 +2209,10 @@ static int flexcan_probe(struct platform_device *pdev)
 	priv->clk_per = clk_per;
 	priv->clk_src = clk_src;
 	priv->reg_xceiver = reg_xceiver;
+	priv->transceiver = transceiver;
+
+	if (transceiver)
+		priv->can.bitrate_max = transceiver->attrs.max_link_rate;
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
 		priv->irq_boff = platform_get_irq(pdev, 1);
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 2cf886618c9621166173b865f266830b3f6c1fb0..16692a2502eba26575eeeec83dfffdf35f07b034 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -107,6 +107,7 @@ struct flexcan_priv {
 	struct clk *clk_per;
 	struct flexcan_devtype_data devtype_data;
 	struct regulator *reg_xceiver;
+	struct phy *transceiver;
 	struct flexcan_stop_mode stm;
 
 	int irq_boff;

-- 
2.39.5



