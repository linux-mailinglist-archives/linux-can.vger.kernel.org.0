Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8BC76660D
	for <lists+linux-can@lfdr.de>; Fri, 28 Jul 2023 10:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbjG1IAE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 28 Jul 2023 04:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjG1H7d (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 28 Jul 2023 03:59:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1722444B2
        for <linux-can@vger.kernel.org>; Fri, 28 Jul 2023 00:59:01 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qPIMv-0008MX-SX
        for linux-can@vger.kernel.org; Fri, 28 Jul 2023 09:58:37 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id D7B631FD1D9
        for <linux-can@vger.kernel.org>; Fri, 28 Jul 2023 07:56:18 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 36DBA1FD19A;
        Fri, 28 Jul 2023 07:56:17 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a69b5724;
        Fri, 28 Jul 2023 07:56:16 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, John Watts <contact@jookia.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 02/21] riscv: dts: allwinner: d1: Add CAN controller nodes
Date:   Fri, 28 Jul 2023 09:55:55 +0200
Message-Id: <20230728075614.1014117-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728075614.1014117-1-mkl@pengutronix.de>
References: <20230728075614.1014117-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: John Watts <contact@jookia.org>

The Allwinner D1, T113 provide two CAN controllers that are variants
of the R40 controller.

I have tested support for these controllers on two boards:

- A Lichee Panel RV 86 Panel running a D1 chip
- A Mango Pi MQ Dual running a T113-s3 chip

Both of these fully support both CAN controllers.

Signed-off-by: John Watts <contact@jookia.org>
Link: https://lore.kernel.org/all/20230721221552.1973203-4-contact@jookia.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index 1bb1e5cae602..4086c0cc0f9d 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -131,6 +131,18 @@ uart3_pb_pins: uart3-pb-pins {
 				pins = "PB6", "PB7";
 				function = "uart3";
 			};
+
+			/omit-if-no-ref/
+			can0_pins: can0-pins {
+				pins = "PB2", "PB3";
+				function = "can0";
+			};
+
+			/omit-if-no-ref/
+			can1_pins: can1-pins {
+				pins = "PB4", "PB5";
+				function = "can1";
+			};
 		};
 
 		ccu: clock-controller@2001000 {
@@ -879,5 +891,23 @@ rtc: rtc@7090000 {
 			clock-names = "bus", "hosc", "ahb";
 			#clock-cells = <1>;
 		};
+
+		can0: can@2504000 {
+			compatible = "allwinner,sun20i-d1-can";
+			reg = <0x02504000 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(21) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CAN0>;
+			resets = <&ccu RST_BUS_CAN0>;
+			status = "disabled";
+		};
+
+		can1: can@2504400 {
+			compatible = "allwinner,sun20i-d1-can";
+			reg = <0x02504400 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(22) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CAN1>;
+			resets = <&ccu RST_BUS_CAN1>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.40.1


