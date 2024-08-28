Return-Path: <linux-can+bounces-1214-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78E8962878
	for <lists+linux-can@lfdr.de>; Wed, 28 Aug 2024 15:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5678DB210B0
	for <lists+linux-can@lfdr.de>; Wed, 28 Aug 2024 13:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919B4175D48;
	Wed, 28 Aug 2024 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISeqKly0"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6496B18030;
	Wed, 28 Aug 2024 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851159; cv=none; b=Ax+AUZmDay8cKiUNXGdSytmvrIGkbNEe0R83OqJ7aKcpx0jyM7pP+RxBeKEZxvm72PVYHGQKmidVQX1ynhFNvUQ24OdlceZSJqzf1bVuNLab8Bmte6OoyTNWxM6L+3p9nB2/QZukp1eZzT3XX5WY6556Gx5MeK087/+8KVummmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851159; c=relaxed/simple;
	bh=0ZGM9TEfLLrvYWSvk1RD9xfacRxUgkLNXI42n7WFus8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JCrC8BoMos6wT5aVIDTdAQ5CtEKTbfW0AgbaMSjdOTRf1FLyutGtDAPKwnbLjHWW1QPuKGVQE+pYbkoJRleVGwQvUVQPlB1wrwUeqHaucV72CGn1qD7cJUUzM+25lCh+lTNzJ11e5zzzp21Aam8M3vaeyWLSo2g3RnvzbKxWjhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISeqKly0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E49C98EEE;
	Wed, 28 Aug 2024 13:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724851158;
	bh=0ZGM9TEfLLrvYWSvk1RD9xfacRxUgkLNXI42n7WFus8=;
	h=From:To:Cc:Subject:Date:From;
	b=ISeqKly0Sd1Pkg9cjPRLCmx+P82zaWGq+KBZrBW67fATr8H/H7VNMn2pqI40S4KYL
	 IZzT9otEmxxwjNcp0p0GBoEitLXR1Us5OYDbdyhD0ESetDju1S5giuU7bfYmEHbttT
	 PhJonSNqmq3a+k1wTY2/HtMrBg3VcqqjEzSzn7bmaQ4dPNXjuiCopBYFI+gcMs7D1T
	 JBOtv5vwfCDGhWFUGpqwjXO/TtMjYpahAAunu1xLpE+Dnwnx9HZk11HX97oIajm0Fx
	 2iyDWv8+0maVW+q+/CzUAgJnwL2fcjB7NYv8lkntmw28foQDj/Lnp7CaGr3fdnCxMl
	 oaVQcyEjKyeuw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: can: cc770: Simplify parsing DT properties
Date: Wed, 28 Aug 2024 08:19:02 -0500
Message-ID: <20240828131902.3632167-1-robh@kernel.org>
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
 drivers/net/can/cc770/cc770_platform.c | 29 ++++++++------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/cc770/cc770_platform.c b/drivers/net/can/cc770/cc770_platform.c
index 13bcfba05f18..9993568154f8 100644
--- a/drivers/net/can/cc770/cc770_platform.c
+++ b/drivers/net/can/cc770/cc770_platform.c
@@ -71,16 +71,9 @@ static int cc770_get_of_node_data(struct platform_device *pdev,
 				  struct cc770_priv *priv)
 {
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
+	u32 clkext = CC770_PLATFORM_CAN_CLOCK, clkout = 0;
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
@@ -109,20 +102,16 @@ static int cc770_get_of_node_data(struct platform_device *pdev,
 	if (of_property_read_bool(np, "bosch,polarity-dominant"))
 		priv->bus_config |= BUSCFG_POL;
 
-	prop = of_get_property(np, "bosch,clock-out-frequency", &prop_size);
-	if (prop && (prop_size == sizeof(u32)) && *prop > 0) {
-		u32 cdv = clkext / *prop;
-		int slew;
+	of_property_read_u32(np, "bosch,clock-out-frequency", &clkout);
+	if (clkout > 0) {
+		u32 cdv = clkext / clkout;
+		u32 slew;
 
 		if (cdv > 0 && cdv < 16) {
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
-- 
2.45.2


