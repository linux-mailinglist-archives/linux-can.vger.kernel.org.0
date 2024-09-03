Return-Path: <linux-can+bounces-1329-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C18969F97
	for <lists+linux-can@lfdr.de>; Tue,  3 Sep 2024 15:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B726CB23ED1
	for <lists+linux-can@lfdr.de>; Tue,  3 Sep 2024 13:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36514A3E;
	Tue,  3 Sep 2024 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBUFHDXg"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A351D374CC;
	Tue,  3 Sep 2024 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371864; cv=none; b=ZgzefwKr2G6ZhmDCQh5E34uM2SNy4rlD1UvkP0q7Jx54RXpoh1sEx41AxL4Lgi6Tb8S6IcPX/COpbSgn5T+lrreloZ7hx3T1yQZTf/kNjAnr5rW7Zyp7iR1sIK1uZAgsZaAZ3Eb/hXAHiBIeefx/n7RWVNGVdpJM5PPyxkQjVto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371864; c=relaxed/simple;
	bh=Us9Uk6RlZQinvj57+eMv2v4WiPDtV/T9XZgyR9VSvIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D+qFjxOOp/RmVNbTa3I5uEVlEk/prIkv/PL4Eskvt/FDV3zpHRKlyAgQwG5uQAmaCfMbJc3YrhAzOzHYasm/DGA0rIsdqYRRWHixYdY4N+2oIu7tJ7kkLGW66DX5OSP2/QW7yeLLLgFTKjKc+wUQ080l2w6aW3NZl+u3rRwqm0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBUFHDXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B11C4CEC4;
	Tue,  3 Sep 2024 13:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725371864;
	bh=Us9Uk6RlZQinvj57+eMv2v4WiPDtV/T9XZgyR9VSvIY=;
	h=From:To:Cc:Subject:Date:From;
	b=DBUFHDXgolOljMXTTc2EL6+PKXOAJcDvOhqLdh9kkNFpzIaDy8B19YH+7Nt/0vi6c
	 /vdkJdhRvCbBU63N770+cYGrEpUfDFriaswV6+AnTgcoxoZuhpnRYV99cIBp4B9We1
	 1yLmaGdncJ2DqmrFgnHAZlCTfvqAjcyWr1SaX6kEomwTUTfRAIavJ5DWqivpvZCjRD
	 Ek+NzTEv1hlicuopE8V9ixWI7iy0JGixxoyrstdpbNm/uq0IziKan+WBIhfqEIXxxQ
	 xEzF5felvpQ3OztZdy78JRauyt2G3KXLMb87Tlie4DJqyGy5eyL2zkF36j1czHYJ3n
	 0i8D+NpVb3tPg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Simon Horman <horms@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: can: cc770: Simplify parsing DT properties
Date: Tue,  3 Sep 2024 08:57:30 -0500
Message-ID: <20240903135731.405635-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of the typed property accessors is preferred over of_get_property().
The existing code doesn't work on little endian systems either. Replace
the of_get_property() calls with of_property_read_bool() and
of_property_read_u32().

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
- Use reverse xmas tree order
- Fix slew unsigned comparison
---
 drivers/net/can/cc770/cc770_platform.c | 32 +++++++++-----------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/net/can/cc770/cc770_platform.c b/drivers/net/can/cc770/cc770_platform.c
index 13bcfba05f18..f2424fe58612 100644
--- a/drivers/net/can/cc770/cc770_platform.c
+++ b/drivers/net/can/cc770/cc770_platform.c
@@ -70,17 +70,10 @@ static void cc770_platform_write_reg(const struct cc770_priv *priv, int reg,
 static int cc770_get_of_node_data(struct platform_device *pdev,
 				  struct cc770_priv *priv)
 {
+	u32 clkext = CC770_PLATFORM_CAN_CLOCK, clkout = 0;
 	struct device_node *np = pdev->dev.of_node;
-	const u32 *prop;
-	int prop_size;
-	u32 clkext;
-
-	prop = of_get_property(np, "bosch,external-clock-frequency",
-			       &prop_size);
-	if (prop && (prop_size ==  sizeof(u32)))
-		clkext = *prop;
-	else
-		clkext = CC770_PLATFORM_CAN_CLOCK; /* default */
+
+	of_property_read_u32(np, "bosch,external-clock-frequency", &clkext);
 	priv->can.clock.freq = clkext;
 
 	/* The system clock may not exceed 10 MHz */
@@ -98,7 +91,7 @@ static int cc770_get_of_node_data(struct platform_device *pdev,
 	if (of_property_read_bool(np, "bosch,iso-low-speed-mux"))
 		priv->cpu_interface |= CPUIF_MUX;
 
-	if (!of_get_property(np, "bosch,no-comperator-bypass", NULL))
+	if (!of_property_read_bool(np, "bosch,no-comperator-bypass"))
 		priv->bus_config |= BUSCFG_CBY;
 	if (of_property_read_bool(np, "bosch,disconnect-rx0-input"))
 		priv->bus_config |= BUSCFG_DR0;
@@ -109,25 +102,22 @@ static int cc770_get_of_node_data(struct platform_device *pdev,
 	if (of_property_read_bool(np, "bosch,polarity-dominant"))
 		priv->bus_config |= BUSCFG_POL;
 
-	prop = of_get_property(np, "bosch,clock-out-frequency", &prop_size);
-	if (prop && (prop_size == sizeof(u32)) && *prop > 0) {
-		u32 cdv = clkext / *prop;
-		int slew;
+	of_property_read_u32(np, "bosch,clock-out-frequency", &clkout);
+	if (clkout > 0) {
+		u32 cdv = clkext / clkout;
 
 		if (cdv > 0 && cdv < 16) {
+			u32 slew;
+
 			priv->cpu_interface |= CPUIF_CEN;
 			priv->clkout |= (cdv - 1) & CLKOUT_CD_MASK;
 
-			prop = of_get_property(np, "bosch,slew-rate",
-					       &prop_size);
-			if (prop && (prop_size == sizeof(u32))) {
-				slew = *prop;
-			} else {
+			if (of_property_read_u32(np, "bosch,slew-rate", &slew)) {
 				/* Determine default slew rate */
 				slew = (CLKOUT_SL_MASK >>
 					CLKOUT_SL_SHIFT) -
 					((cdv * clkext - 1) / 8000000);
-				if (slew < 0)
+				if (slew > (CLKOUT_SL_MASK >> CLKOUT_SL_SHIFT))
 					slew = 0;
 			}
 			priv->clkout |= (slew << CLKOUT_SL_SHIFT) &
-- 
2.45.2


