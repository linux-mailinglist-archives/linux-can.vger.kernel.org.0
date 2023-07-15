Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06486754874
	for <lists+linux-can@lfdr.de>; Sat, 15 Jul 2023 13:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjGOLdT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 15 Jul 2023 07:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjGOLdS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 15 Jul 2023 07:33:18 -0400
Received: from out-61.mta0.migadu.com (out-61.mta0.migadu.com [91.218.175.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB6B35B7
        for <linux-can@vger.kernel.org>; Sat, 15 Jul 2023 04:33:16 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1689420356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Je1IK6lfysTXxuDNeexeifoUO9/0LoHKaSsEoi0nLA=;
        b=qjycuv7C8MM478tu7GZ1iqbtbkEH02oqYIe20ph/cC2vFNuIxx52ibutHnTswTA4rQLA8I
        SsFzX6UX0QW6GYj8F2KcCuLrIaAUjvEEEyy9okx6KhDymZuFjSaJUyYXN7KGvt7qAFLT3q
        oyjtrZ6w7jXwzXWmG2cIghULR3qyVuFa7G46ocL0A2F3teNFe83XRvCaYt//6g/JOHq27y
        SnItJKe0g0v0tcURmWZLayi7iiK1q00R5S9otEUbzcQtKm1IFZIA6uoywdccEfu8lzFawV
        g1lTX62UuAZ1Z/WMNXDDZJKNSoEbHohkPD2kQDqby6emGFu7c2UJv6XxSXtW3w==
From:   Jookia <contact@jookia.org>
To:     linux-sunxi@lists.linux.dev
Cc:     John Watts <contact@jookia.org>, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, linux-riscv@lists.infradead.org,
        Fabien Poussin <fabien.poussin@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 2/4] riscv: dts: allwinner: d1: Add CAN controller nodes
Date:   Sat, 15 Jul 2023 21:25:20 +1000
Message-ID: <20230715112523.2533742-3-contact@jookia.org>
In-Reply-To: <20230715112523.2533742-1-contact@jookia.org>
References: <20230715112523.2533742-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
---
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index 1bb1e5cae602..b185398334be 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -131,6 +131,18 @@ uart3_pb_pins: uart3-pb-pins {
 				pins = "PB6", "PB7";
 				function = "uart3";
 			};
+
+			/omit-if-no-ref/
+			can0_pins: can0_pins {
+				pins = "PB2", "PB3";
+				function = "can0";
+			};
+
+			/omit-if-no-ref/
+			can1_pins: can1_pins {
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
2.41.0

