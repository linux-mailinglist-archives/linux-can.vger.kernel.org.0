Return-Path: <linux-can+bounces-2886-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ABFA3D310
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 09:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A91E17A9995
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 08:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849221EB195;
	Thu, 20 Feb 2025 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVAW/OiC"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537DD1EA7D7;
	Thu, 20 Feb 2025 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039738; cv=none; b=Ira11KbsIEf7MD/2ZW7uZjAhQedcHJnFyN7u7kiiZDuE+FhaSmUEWdJtmZKynfed5gcsjyNy48D+wUg8553n/O8DKbi5IXi3gkBd2xJsPDMjFzfPix/px8z/9MHY2lNvM6RdP2njuhkmStvPVyn1/bUpU5OPe9rW5vjTj13VqnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039738; c=relaxed/simple;
	bh=7F7sQq/0m8zPbnz8Ivr8G6w/qsoALtSz8q8BZHon9FQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C+ueV+91Xz0ymtHuMrAfGl4iCIQOQa4SBexyRofflfnLlJM2IiF70cQ1gZ2npgfl/f95Fse0ztVFiXiO85rYakvMndfceTRtrCLHdp+jARDpAzMXNBcb/qB78mGBTFWObMNp9/EEBGR8O73VGdxMieSfdWn6Dz0Hsq057cgnFsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVAW/OiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFB07C4CEE4;
	Thu, 20 Feb 2025 08:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740039737;
	bh=7F7sQq/0m8zPbnz8Ivr8G6w/qsoALtSz8q8BZHon9FQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XVAW/OiCL2OZcqMnhNppbqGssLIvN0XBvHEyjkBst/Lg0ErRx6Udd2Xy7e+0PQ21z
	 cz8gGnYiClXQQJqalUuXkqUmOUoIAC/6D8iuCUbgo4jLjR5655wK8a/C2sd0HdRhi2
	 GiLeuFNi7oVTxTBd9e6i4eq0CrNzUSAurK2nx4E7PETC/QAuFIcSJcpV4zN5rgX4DP
	 34jiVUDJ2JDDFbNnsycVikkeyvNo4IjI858gVKFjeTmZGYyRNzQxQyZwUi8z3ytvUg
	 afVfp52JnFnhkSyxWvC3bcSoVPaewu20EjOy6mN2CynJVhXv0NAKVdCb5FAmn0eADm
	 5tmnJ9qgUtc6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE644C021B4;
	Thu, 20 Feb 2025 08:22:17 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Thu, 20 Feb 2025 09:22:11 +0100
Subject: [PATCH v2 2/2] can: flexcan: add transceiver capabilities
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-flexcan-add-transceiver-caps-v2-2-a81970f11846@liebherr.com>
References: <20250220-flexcan-add-transceiver-caps-v2-0-a81970f11846@liebherr.com>
In-Reply-To: <20250220-flexcan-add-transceiver-caps-v2-0-a81970f11846@liebherr.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740039736; l=3553;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=f8wDtbBWhus6CF2XVFXMOTBwX1LOfB9aOJZ29pdlyPo=;
 b=KAivBnF5zPSH30Mj67FkakzqX5s1r5WVPqiTqjmCpacvj9n9tzdGarouQAWwyu+HGSqaF+QqJ
 UypJUj41D73Aii3H79QYLeqcq8wuKB4GYtGlx0VKHldR2Z4HyWsPUCJ
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
 drivers/net/can/flexcan/flexcan-core.c | 30 ++++++++++++++++++++++++------
 drivers/net/can/flexcan/flexcan.h      |  1 +
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index b347a1c93536d54efaa5f7d3347bd47c20860b3e..45d9a6957d9a806ed80d810a6a5f7eb99fcc702c 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -30,6 +30,7 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/phy/phy.h>
 
 #include "flexcan.h"
 
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
@@ -2101,6 +2107,14 @@ static int flexcan_probe(struct platform_device *pdev)
 	else if (IS_ERR(reg_xceiver))
 		return PTR_ERR(reg_xceiver);
 
+	transceiver = devm_phy_optional_get(&pdev->dev, NULL);
+	if (PTR_ERR(transceiver) == -EPROBE_DEFER) {
+		return -EPROBE_DEFER;
+	} else if (IS_ERR(transceiver)) {
+		dev_err(&pdev->dev, "failed to get phy\n");
+		return PTR_ERR(transceiver);
+	}
+
 	if (pdev->dev.of_node) {
 		of_property_read_u32(pdev->dev.of_node,
 				     "clock-frequency", &clock_freq);
@@ -2198,6 +2212,10 @@ static int flexcan_probe(struct platform_device *pdev)
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



