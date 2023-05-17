Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8BA707099
	for <lists+linux-can@lfdr.de>; Wed, 17 May 2023 20:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjEQSUI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 17 May 2023 14:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjEQSUF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 May 2023 14:20:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CBE7EDC
        for <linux-can@vger.kernel.org>; Wed, 17 May 2023 11:20:04 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pzLko-0007UA-Ie
        for linux-can@vger.kernel.org; Wed, 17 May 2023 20:20:02 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id EF0FA1C74E9
        for <linux-can@vger.kernel.org>; Wed, 17 May 2023 18:20:01 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 489EF1C74E1;
        Wed, 17 May 2023 18:20:00 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ff52fbe0;
        Wed, 17 May 2023 18:19:59 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        kernel test robot <lkp@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] Revert "ARM: dts: stm32: add CAN support on stm32f746"
Date:   Wed, 17 May 2023 20:19:50 +0200
Message-Id: <20230517181950.1106697-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This reverts commit 0920ccdf41e3078a4dd2567eb905ea154bc826e6.

The commit 0920ccdf41e3 ("ARM: dts: stm32: add CAN support on
stm32f746") depends on the patch "dt-bindings: mfd: stm32f7: add
binding definition for CAN3" [1], which is not in net/main, yet. This
results in a parsing error of "stm32f746.dtsi".

So revert this commit.

[1] https://lore.kernel.org/all/20230423172528.1398158-2-dario.binacchi@amarulasolutions.com

Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Alexandre TORGUE <alexandre.torgue@foss.st.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305172108.x5acbaQG-lkp@intel.com
Closes: https://lore.kernel.org/oe-kbuild-all/202305172130.eGGEUhpi-lkp@intel.com
Fixes: 0920ccdf41e3 ("ARM: dts: stm32: add CAN support on stm32f746")
Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/boot/dts/stm32f746.dtsi | 47 --------------------------------
 1 file changed, 47 deletions(-)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index 973698bc9ef4..dc868e6da40e 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -257,23 +257,6 @@ rtc: rtc@40002800 {
 			status = "disabled";
 		};
 
-		can3: can@40003400 {
-			compatible = "st,stm32f4-bxcan";
-			reg = <0x40003400 0x200>;
-			interrupts = <104>, <105>, <106>, <107>;
-			interrupt-names = "tx", "rx0", "rx1", "sce";
-			resets = <&rcc STM32F7_APB1_RESET(CAN3)>;
-			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN3)>;
-			st,gcan = <&gcan3>;
-			status = "disabled";
-		};
-
-		gcan3: gcan@40003600 {
-			compatible = "st,stm32f4-gcan", "syscon";
-			reg = <0x40003600 0x200>;
-			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN3)>;
-		};
-
 		usart2: serial@40004400 {
 			compatible = "st,stm32f7-uart";
 			reg = <0x40004400 0x400>;
@@ -354,36 +337,6 @@ i2c4: i2c@40006000 {
 			status = "disabled";
 		};
 
-		can1: can@40006400 {
-			compatible = "st,stm32f4-bxcan";
-			reg = <0x40006400 0x200>;
-			interrupts = <19>, <20>, <21>, <22>;
-			interrupt-names = "tx", "rx0", "rx1", "sce";
-			resets = <&rcc STM32F7_APB1_RESET(CAN1)>;
-			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN1)>;
-			st,can-primary;
-			st,gcan = <&gcan1>;
-			status = "disabled";
-		};
-
-		gcan1: gcan@40006600 {
-			compatible = "st,stm32f4-gcan", "syscon";
-			reg = <0x40006600 0x200>;
-			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN1)>;
-		};
-
-		can2: can@40006800 {
-			compatible = "st,stm32f4-bxcan";
-			reg = <0x40006800 0x200>;
-			interrupts = <63>, <64>, <65>, <66>;
-			interrupt-names = "tx", "rx0", "rx1", "sce";
-			resets = <&rcc STM32F7_APB1_RESET(CAN2)>;
-			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN2)>;
-			st,can-secondary;
-			st,gcan = <&gcan1>;
-			status = "disabled";
-		};
-
 		cec: cec@40006c00 {
 			compatible = "st,stm32-cec";
 			reg = <0x40006C00 0x400>;
-- 
2.39.2


