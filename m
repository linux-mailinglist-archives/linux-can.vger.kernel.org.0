Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC88D4AF709
	for <lists+linux-can@lfdr.de>; Wed,  9 Feb 2022 17:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbiBIQlT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Feb 2022 11:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237377AbiBIQlS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Feb 2022 11:41:18 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C79C0613C9;
        Wed,  9 Feb 2022 08:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1644424697;
    s=strato-dkim-0002; d=fpond.eu;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=stHKA2j00UjsJ+MpaQDa9N4JHEpkoQdTDEnFChK7mFg=;
    b=chbyyTMLkaVn9cqPh59uulWqDDRH2k2DAiT/I277422DDoa5o4VO/wDYfwivj8gZN3
    TUF4HFjDkMif/bBco0Cm7vR0BOwrObD6v6qg0cl3XeRVKOi3wNTnRYM2BYAOKr2209YK
    XGdoVS4MEC24mLQIicjbOtpt1VRgMUUCLLy03zJYHK4CvXDq4J5vLfiIxp2JuwSfMpTO
    GKAgItBwS2F/6bBEoNbJhf6zA3cYrh4Suy+JsViX1eRxqQ/LjkmErvWMUBJd2g0DBT5d
    9bU9s3huQZ9tM4eUrX0bp7uRXALZ6tKVQX46QL72QUV6rJ8HCXHbHK8RuxWsIXWJGFsj
    XVTA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73dmm4I5W0/AvA67Ot4fvR82dfdzLc5sE="
X-RZG-CLASS-ID: mo00
Received: from gummo.fritz.box
    by smtp.strato.de (RZmta 47.39.0 DYNA|AUTH)
    with ESMTPSA id ufcb0fy19GcH7bv
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 9 Feb 2022 17:38:17 +0100 (CET)
From:   Ulrich Hecht <uli+renesas@fpond.eu>
To:     linux-renesas-soc@vger.kernel.org
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        linux-can@vger.kernel.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, wsa@kernel.org,
        yoshihiro.shimoda.uh@renesas.com, wg@grandegger.com,
        mkl@pengutronix.de, kuba@kernel.org, mailhol.vincent@wanadoo.fr,
        socketcan@hartkopp.net, geert@linux-m68k.org,
        kieran.bingham@ideasonboard.com,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 2/4] arm64: dts: renesas: r8a779a0: Add CANFD device node
Date:   Wed,  9 Feb 2022 17:38:04 +0100
Message-Id: <20220209163806.18618-3-uli+renesas@fpond.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220209163806.18618-1-uli+renesas@fpond.eu>
References: <20220209163806.18618-1-uli+renesas@fpond.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch adds a CANFD device node for r8a779a0.

Based on patch by Kazuya Mizuguchi.

Signed-off-by: Ulrich Hecht <uli+renesas@fpond.eu>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a779a0.dtsi | 56 +++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
index 9ad1b23ad2ec..65d0ddb42f61 100644
--- a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
@@ -24,6 +24,13 @@
 		i2c6 = &i2c6;
 	};
 
+	/* External CAN clock - to be overridden by boards that provide it */
+	can_clk: can {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -596,6 +603,55 @@
 			status = "disabled";
 		};
 
+		canfd: can@e6660000 {
+			compatible = "renesas,r8a779a0-canfd";
+			reg = <0 0xe6660000 0 0x8000>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch_int", "g_int";
+			clocks = <&cpg CPG_MOD 328>,
+				 <&cpg CPG_CORE R8A779A0_CLK_CANFD>,
+				 <&can_clk>;
+			clock-names = "fck", "canfd", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A779A0_CLK_CANFD>;
+			assigned-clock-rates = <80000000>;
+			power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
+			resets = <&cpg 328>;
+			status = "disabled";
+
+			channel0 {
+				status = "disabled";
+			};
+
+			channel1 {
+				status = "disabled";
+			};
+
+			channel2 {
+				status = "disabled";
+			};
+
+			channel3 {
+				status = "disabled";
+			};
+
+			channel4 {
+				status = "disabled";
+			};
+
+			channel5 {
+				status = "disabled";
+			};
+
+			channel6 {
+				status = "disabled";
+			};
+
+			channel7 {
+				status = "disabled";
+			};
+		};
+
 		avb0: ethernet@e6800000 {
 			compatible = "renesas,etheravb-r8a779a0",
 				     "renesas,etheravb-rcar-gen3";
-- 
2.20.1

