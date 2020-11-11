Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634342AF338
	for <lists+linux-can@lfdr.de>; Wed, 11 Nov 2020 15:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgKKOMx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Nov 2020 09:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgKKOMX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Nov 2020 09:12:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F07C0613D1
        for <linux-can@vger.kernel.org>; Wed, 11 Nov 2020 06:12:22 -0800 (PST)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kcqrB-0003AI-Em; Wed, 11 Nov 2020 15:12:17 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@pengutronix.de
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Subject: [PATCH] ARM: dts: dra76x: m_can: fix order of clocks
Date:   Wed, 11 Nov 2020 15:12:11 +0100
Message-Id: <20201111141211.1577871-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

According to the bosch,m_can.yaml bindings the first clock shall be the "hclk",
while the second clock "cclk".

This patch fixes the order accordingly.

Fixes: 0adbe832f21a ("ARM: dts: dra76x: Add MCAN node")
Cc: Faiz Abbas <faiz_abbas@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/boot/dts/dra76x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
index b69c7d40f5d8..2f326151116b 100644
--- a/arch/arm/boot/dts/dra76x.dtsi
+++ b/arch/arm/boot/dts/dra76x.dtsi
@@ -32,8 +32,8 @@ m_can0: mcan@1a00 {
 				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "int0", "int1";
-				clocks = <&mcan_clk>, <&l3_iclk_div>;
-				clock-names = "cclk", "hclk";
+				clocks = <&l3_iclk_div>, <&mcan_clk>;
+				clock-names = "hclk", "cclk";
 				bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
 			};
 		};
-- 
2.28.0

