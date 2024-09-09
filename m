Return-Path: <linux-can+bounces-1436-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7485A970DF4
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 08:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A19A1F21640
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 06:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D5A1AD3FE;
	Mon,  9 Sep 2024 06:37:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2171D1AC8B0
	for <linux-can@vger.kernel.org>; Mon,  9 Sep 2024 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725863825; cv=none; b=o7vGKPjwjsKx24SDfUNHDmBJF7wg5vEtlCuS81kL27iFrHP0BJ9jfmyNx4Rc54LDHK40wU/M0v/tbOstHrc5eZ0Bv9b9h+cxl9lvrjTuoup6Czu/euDhvws4uG87G9nPbZYckEoN/xDl2D55/9IpNPawMiimMVCaupEWl7SeDJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725863825; c=relaxed/simple;
	bh=A08C/9IMqoP0dQXOfqrdD1yWEXwhgu17+OLehaCLGd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JS/HWe1B67vaLHhvXKq4qO/vLU4YUB36xiI8Yo9CkzE/HGuEYZvuWT3AhGFslhx+jhEkgxA1WP/8gZhY3WJK2CTnlkehMPh9jKChA48gakGEwirA/8+cjcEp+KQxW+aEk0o3sxGCmOCbnE+aLqgtLKGYQ2kbFyTf23g09ecs1MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1snY1G-0005vV-7W
	for linux-can@vger.kernel.org; Mon, 09 Sep 2024 08:37:02 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1snY1F-006aXG-Oy
	for linux-can@vger.kernel.org; Mon, 09 Sep 2024 08:37:01 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 70A82336450
	for <linux-can@vger.kernel.org>; Mon, 09 Sep 2024 06:37:01 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 07C25336439;
	Mon, 09 Sep 2024 06:37:00 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f6428e02;
	Mon, 9 Sep 2024 06:36:59 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 1/3] net: can: cc770: Simplify parsing DT properties
Date: Mon,  9 Sep 2024 08:33:53 +0200
Message-ID: <20240909063657.2287493-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909063657.2287493-1-mkl@pengutronix.de>
References: <20240909063657.2287493-1-mkl@pengutronix.de>
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

From: "Rob Herring (Arm)" <robh@kernel.org>

Use of the typed property accessors is preferred over of_get_property().
The existing code doesn't work on little endian systems either. Replace
the of_get_property() calls with of_property_read_bool() and
of_property_read_u32().

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20240903135731.405635-1-robh@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/cc770/cc770_platform.c | 30 +++++++++-----------------
 1 file changed, 10 insertions(+), 20 deletions(-)

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
 
-	prop = of_get_property(np, "bosch,external-clock-frequency",
-			       &prop_size);
-	if (prop && (prop_size ==  sizeof(u32)))
-		clkext = *prop;
-	else
-		clkext = CC770_PLATFORM_CAN_CLOCK; /* default */
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

base-commit: c259acab839e57eab0318f32da4ae803a8d59397
-- 
2.45.2



