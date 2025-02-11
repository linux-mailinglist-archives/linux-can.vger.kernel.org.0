Return-Path: <linux-can+bounces-2791-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5890DA30C96
	for <lists+linux-can@lfdr.de>; Tue, 11 Feb 2025 14:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1803A6969
	for <lists+linux-can@lfdr.de>; Tue, 11 Feb 2025 13:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA7E221DAE;
	Tue, 11 Feb 2025 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPigow7S"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27202206B8;
	Tue, 11 Feb 2025 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739279560; cv=none; b=OZFSTy1L2gUTuYrvWlKw3rKLdCAMhR2uiYpWDskcgpNoYotpZa+RflKvYdhF5/SwUte4sFSRFd4CiIH5ZHQXUR3wX0D8ZW4fDnczBaAk3x8BFBYiemjEWNTN/0541JLZczYmVlxCART5ibB9TTn+6iNTufRbjoVVq7f3gc1ivY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739279560; c=relaxed/simple;
	bh=yOn72q3rBX1Ok8bHjabDtYxA7XST1d2PNnze5+FAUu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LOn8ebxaLoXRm+fEeIvOfKEX+IyHTTELGdwzKf7Otoqq3dbewvxa/l7HUq2Hy6fm0l8OiHHPY3L629RO5ziCgeGKd4z2vLuuxIw59DkTTX5Lbgf7o7F/y+n1cvt+nLJkdjWgTo/VQzAXlSJyEgepizC2qe9JAybr7s1jDo8jYpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPigow7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DE66C4CEE9;
	Tue, 11 Feb 2025 13:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739279559;
	bh=yOn72q3rBX1Ok8bHjabDtYxA7XST1d2PNnze5+FAUu8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pPigow7SJv6KuyXeoIO/XG015RMepx8C4Z2kYwGKydj0YW1eWTUbo4aM1PX17auvk
	 pbgXpZK6hS79lFAbneXY2N+dfsmPnDQSdutX5AysI4sSoyu3+Z6zBs0A1TpnplVxdE
	 pHH4iCUSz9Lrfd2/Gz/68uYUZVCmJOCUSglBOrR31hVq26FkAx00N7rEumVWlyYafS
	 +6AzFVBUl8f3kdQicUF0EcxK3M9kfzFGc7jkbfOIfgDqQVxlr/NcOGoET2l/bwf9Vr
	 4s3f/BOygJDfBwQqrw6ucoAS3CwTtyXlJocpsevizM+m6JdXz5jIUqtECeTxeJmrSO
	 4CfUKgLRpuKuQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF52C0219B;
	Tue, 11 Feb 2025 13:12:39 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Tue, 11 Feb 2025 14:12:34 +0100
Subject: [PATCH 2/2] can: flexcan: add transceiver capabilities
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-flexcan-add-transceiver-caps-v1-2-c6abb7817b0f@liebherr.com>
References: <20250211-flexcan-add-transceiver-caps-v1-0-c6abb7817b0f@liebherr.com>
In-Reply-To: <20250211-flexcan-add-transceiver-caps-v1-0-c6abb7817b0f@liebherr.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739279554; l=3254;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=MkScmJzMrjljm6Z+2YxSN5mrAzjdFqPq9BBLNkTJm7A=;
 b=EVN92FjdbZyxvcxPsWF5CnLlaCFU1m14KMU9FIwvcmpGUQi6Bqr+CYG7egBuEi4MJyO4pSYNf
 c/ypVbTExMsBj5wY22xvGuY63W9B9bIVim+pryJVx+w7A2JSKfAIO2D
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Currently the flexcan driver does not support adding PHYs. Add the
capability to ensure that the PHY is in operational state when the link
is set to an "up" state.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 25 +++++++++++++++++++------
 drivers/net/can/flexcan/flexcan.h      |  1 +
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index ac1a860986df69a1dd64c25ff879490d5b21073b..a03dc8e3c80546a0e2fa9a85f0e0cc8159afa4f0 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -30,6 +30,7 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/phy/phy.h>
 
 #include "flexcan.h"
 
@@ -634,18 +635,22 @@ static void flexcan_clks_disable(const struct flexcan_priv *priv)
 
 static inline int flexcan_transceiver_enable(const struct flexcan_priv *priv)
 {
-	if (!priv->reg_xceiver)
-		return 0;
+	if (priv->reg_xceiver)
+		return regulator_enable(priv->reg_xceiver);
+	else if (priv->xceiver)
+		return phy_power_on(priv->xceiver);
 
-	return regulator_enable(priv->reg_xceiver);
+	return 0;
 }
 
 static inline int flexcan_transceiver_disable(const struct flexcan_priv *priv)
 {
-	if (!priv->reg_xceiver)
-		return 0;
+	if (priv->reg_xceiver)
+		return regulator_disable(priv->reg_xceiver);
+	else if (priv->xceiver)
+		return phy_power_off(priv->xceiver);
 
-	return regulator_disable(priv->reg_xceiver);
+	return 0;
 }
 
 static int flexcan_chip_enable(struct flexcan_priv *priv)
@@ -2061,6 +2066,7 @@ static int flexcan_probe(struct platform_device *pdev)
 	struct net_device *dev;
 	struct flexcan_priv *priv;
 	struct regulator *reg_xceiver;
+	struct phy *xceiver;
 	struct clk *clk_ipg = NULL, *clk_per = NULL;
 	struct flexcan_regs __iomem *regs;
 	struct flexcan_platform_data *pdata;
@@ -2076,6 +2082,12 @@ static int flexcan_probe(struct platform_device *pdev)
 	else if (IS_ERR(reg_xceiver))
 		return PTR_ERR(reg_xceiver);
 
+	xceiver = devm_phy_optional_get(&pdev->dev, NULL);
+	if (IS_ERR(xceiver)) {
+		dev_err(&pdev->dev, "failed to get phy\n");
+		return PTR_ERR(xceiver);
+	}
+
 	if (pdev->dev.of_node) {
 		of_property_read_u32(pdev->dev.of_node,
 				     "clock-frequency", &clock_freq);
@@ -2173,6 +2185,7 @@ static int flexcan_probe(struct platform_device *pdev)
 	priv->clk_per = clk_per;
 	priv->clk_src = clk_src;
 	priv->reg_xceiver = reg_xceiver;
+	priv->xceiver = xceiver;
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
 		priv->irq_boff = platform_get_irq(pdev, 1);
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 4933d8c7439e62b5d6fcc445d88c2b5ccbfa13bb..56be40875eee24aee9297c4bc7c2fc4380e682ff 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -103,6 +103,7 @@ struct flexcan_priv {
 	struct clk *clk_per;
 	struct flexcan_devtype_data devtype_data;
 	struct regulator *reg_xceiver;
+	struct phy *xceiver;
 	struct flexcan_stop_mode stm;
 
 	int irq_boff;

-- 
2.39.5



