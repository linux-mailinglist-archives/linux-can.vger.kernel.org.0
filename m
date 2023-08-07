Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CD1771BB3
	for <lists+linux-can@lfdr.de>; Mon,  7 Aug 2023 09:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjHGHma (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 7 Aug 2023 03:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjHGHm3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Aug 2023 03:42:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C122B1708
        for <linux-can@vger.kernel.org>; Mon,  7 Aug 2023 00:42:27 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qSusk-00036V-3j
        for linux-can@vger.kernel.org; Mon, 07 Aug 2023 09:42:26 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 895932058F4
        for <linux-can@vger.kernel.org>; Mon,  7 Aug 2023 07:42:25 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 169FA2058E9;
        Mon,  7 Aug 2023 07:42:24 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 81546b7e;
        Mon, 7 Aug 2023 07:42:23 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        =?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@gmail.com>
Subject: [PATCH net-next] Revert "riscv: dts: allwinner: d1: Add CAN controller nodes"
Date:   Mon,  7 Aug 2023 09:42:22 +0200
Message-Id: <20230807074222.1576119-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807074222.1576119-1-mkl@pengutronix.de>
References: <20230807074222.1576119-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

It turned out the dtsi changes were not quite ready, revert them for
now.

This reverts commit 6ea1ad888f5900953a21853e709fa499fdfcb317.

Link: https://lore.kernel.org/all/2690764.mvXUDI8C0e@jernej-laptop
Suggested-by: Jernej Škrabec <jernej.skrabec@gmail.com>
Link: https://lore.kernel.org/all/20230807-riscv-allwinner-d1-revert-can-controller-nodes-v1-1-eb3f70b435d9@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 30 -------------------
 1 file changed, 30 deletions(-)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index 4086c0cc0f9d..1bb1e5cae602 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -131,18 +131,6 @@ uart3_pb_pins: uart3-pb-pins {
 				pins = "PB6", "PB7";
 				function = "uart3";
 			};
-
-			/omit-if-no-ref/
-			can0_pins: can0-pins {
-				pins = "PB2", "PB3";
-				function = "can0";
-			};
-
-			/omit-if-no-ref/
-			can1_pins: can1-pins {
-				pins = "PB4", "PB5";
-				function = "can1";
-			};
 		};
 
 		ccu: clock-controller@2001000 {
@@ -891,23 +879,5 @@ rtc: rtc@7090000 {
 			clock-names = "bus", "hosc", "ahb";
 			#clock-cells = <1>;
 		};
-
-		can0: can@2504000 {
-			compatible = "allwinner,sun20i-d1-can";
-			reg = <0x02504000 0x400>;
-			interrupts = <SOC_PERIPHERAL_IRQ(21) IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_CAN0>;
-			resets = <&ccu RST_BUS_CAN0>;
-			status = "disabled";
-		};
-
-		can1: can@2504400 {
-			compatible = "allwinner,sun20i-d1-can";
-			reg = <0x02504400 0x400>;
-			interrupts = <SOC_PERIPHERAL_IRQ(22) IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_CAN1>;
-			resets = <&ccu RST_BUS_CAN1>;
-			status = "disabled";
-		};
 	};
 };

base-commit: c35e927cbe09d38b2d72183bb215901183927c68
-- 
2.40.1


