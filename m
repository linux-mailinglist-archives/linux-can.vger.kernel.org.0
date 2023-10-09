Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666047BD746
	for <lists+linux-can@lfdr.de>; Mon,  9 Oct 2023 11:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345964AbjJIJjZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Oct 2023 05:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345969AbjJIJjX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Oct 2023 05:39:23 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17634DE
        for <linux-can@vger.kernel.org>; Mon,  9 Oct 2023 02:39:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qpmjP-0000dr-Fl
        for linux-can@vger.kernel.org; Mon, 09 Oct 2023 11:39:19 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qpmjO-000Nfb-6n
        for linux-can@vger.kernel.org; Mon, 09 Oct 2023 11:39:18 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id E9CB723263F
        for <linux-can@vger.kernel.org>; Mon,  9 Oct 2023 08:52:59 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 751B6232600;
        Mon,  9 Oct 2023 08:52:58 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 30032079;
        Mon, 9 Oct 2023 08:52:57 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Haibo Chen <haibo.chen@nxp.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 3/6] arm64: dts: imx93: add the Flex-CAN stop mode by GPR
Date:   Mon,  9 Oct 2023 10:50:05 +0200
Message-ID: <20231009085256.693378-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009085256.693378-1-mkl@pengutronix.de>
References: <20231009085256.693378-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

imx93 A0 chip use the internal q-channel handshake signal in LPCG
and CCM to automatically handle the Flex-CAN stop mode. But this
method meet issue when do the system PM stress test. IC can't fix
it easily. So in the new imx93 A1 chip, IC drop this method, and
involve back the old way，use the GPR method to trigger the Flex-CAN
stop mode signal. Now NXP claim to drop imx93 A0, and only support
imx93 A1. So here add the stop mode through GPR.

This patch also fix a typo for aonmix_ns_gpr.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Link: https://lore.kernel.org/all/20230726112458.3524165-1-haibo.chen@nxp.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 6f85a05ee7e1..dcf6e4846ac9 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -185,7 +185,7 @@ aips1: bus@44000000 {
 			#size-cells = <1>;
 			ranges;
 
-			anomix_ns_gpr: syscon@44210000 {
+			aonmix_ns_gpr: syscon@44210000 {
 				compatible = "fsl,imx93-aonmix-ns-syscfg", "syscon";
 				reg = <0x44210000 0x1000>;
 			};
@@ -319,6 +319,7 @@ flexcan1: can@443a0000 {
 				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
 				assigned-clock-rates = <40000000>;
 				fsl,clk-source = /bits/ 8 <0>;
+				fsl,stop-mode = <&aonmix_ns_gpr 0x14 0>;
 				status = "disabled";
 			};
 
@@ -591,6 +592,7 @@ flexcan2: can@425b0000 {
 				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
 				assigned-clock-rates = <40000000>;
 				fsl,clk-source = /bits/ 8 <0>;
+				fsl,stop-mode = <&wakeupmix_gpr 0x0c 2>;
 				status = "disabled";
 			};
 
-- 
2.42.0


