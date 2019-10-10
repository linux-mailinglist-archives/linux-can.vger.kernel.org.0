Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCDB1D2C73
	for <lists+linux-can@lfdr.de>; Thu, 10 Oct 2019 16:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfJJO0V (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 10 Oct 2019 10:26:21 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:43208 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726359AbfJJO0V (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Oct 2019 10:26:21 -0400
X-IronPort-AV: E=Sophos;i="5.67,280,1566831600"; 
   d="scan'208";a="28794139"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Oct 2019 23:26:19 +0900
Received: from fabrizio-dev.ree.adwin.renesas.com (unknown [10.226.36.196])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 80BF94288734;
        Thu, 10 Oct 2019 23:26:15 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "David S. Miller" <davem@davemloft.net>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH v2 3/3] arm64: dts: renesas: r8a774b1: Add CAN and CAN FD support
Date:   Thu, 10 Oct 2019 15:26:00 +0100
Message-Id: <1570717560-7431-4-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570717560-7431-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1570717560-7431-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add CAN and CAN FD support to the RZ/G2N SoC specific dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
v1->v2:
* No change

 arch/arm64/boot/dts/renesas/r8a774b1.dtsi | 48 +++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
index 80b8b2e..bfea6df 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
@@ -994,18 +994,60 @@
 		};
 
 		can0: can@e6c30000 {
+			compatible = "renesas,can-r8a774b1",
+				     "renesas,rcar-gen3-can";
 			reg = <0 0xe6c30000 0 0x1000>;
-			/* placeholder */
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 916>,
+				 <&cpg CPG_CORE R8A774B1_CLK_CANFD>,
+				 <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A774B1_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 916>;
+			status = "disabled";
 		};
 
 		can1: can@e6c38000 {
+			compatible = "renesas,can-r8a774b1",
+				     "renesas,rcar-gen3-can";
 			reg = <0 0xe6c38000 0 0x1000>;
-			/* placeholder */
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 915>,
+				 <&cpg CPG_CORE R8A774B1_CLK_CANFD>,
+				 <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A774B1_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 915>;
+			status = "disabled";
 		};
 
 		canfd: can@e66c0000 {
+			compatible = "renesas,r8a774b1-canfd",
+				     "renesas,rcar-gen3-canfd";
 			reg = <0 0xe66c0000 0 0x8000>;
-			/* placeholder */
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				   <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 914>,
+				 <&cpg CPG_CORE R8A774B1_CLK_CANFD>,
+				 <&can_clk>;
+			clock-names = "fck", "canfd", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A774B1_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 914>;
+			status = "disabled";
+
+			channel0 {
+				status = "disabled";
+			};
+
+			channel1 {
+				status = "disabled";
+			};
 		};
 
 		pwm0: pwm@e6e30000 {
-- 
2.7.4

