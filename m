Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09731771B7E
	for <lists+linux-can@lfdr.de>; Mon,  7 Aug 2023 09:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjHGH3B (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 7 Aug 2023 03:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjHGH3A (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Aug 2023 03:29:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABE210F0
        for <linux-can@vger.kernel.org>; Mon,  7 Aug 2023 00:28:59 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qSufh-0001QS-LD
        for linux-can@vger.kernel.org; Mon, 07 Aug 2023 09:28:57 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 1172A2058BE
        for <linux-can@vger.kernel.org>; Mon,  7 Aug 2023 07:28:57 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id A5F8A2058B0;
        Mon,  7 Aug 2023 07:28:53 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3d094674;
        Mon, 7 Aug 2023 07:28:53 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Mon, 07 Aug 2023 09:28:50 +0200
Subject: [PATCH] Revert "riscv: dts: allwinner: d1: Add CAN controller
 nodes"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230807-riscv-allwinner-d1-revert-can-controller-nodes-v1-1-eb3f70b435d9@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIADGd0GQC/x2NSwrDMAwFrxK0rsB2U/dzldCFsZVWYOQihbQQc
 veYLofHvNnASJkMHsMGSisbN+ngTwPkd5IXIZfOEFw4u5u7orLlFVOtXxYhxeKxe6QL5iSYmyz
 aau2DtEKG8TLHQG6M/p6hn36UZv79g9Nz3w8LpufJgAAAAA==
To:     linux-can@vger.kernel.org
Cc:     John Watts <contact@jookia.org>, kernel@pengutronix.de,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1973; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=vUrCbLfFW1umHcNBDCaMWrYMwAzAml5hh8vVrEIpxqI=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBk0J0y9XBPOwXg5qAWbtBKng7vWOKNUjlkAjCeI
 vJv36L8zVqJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZNCdMgAKCRC+UBxKKooE
 6DjbCACSnMGWq408y1/hhxSc6hvJR74UJgy3cIH9AiaMYbHraNzsdIVLBu00wakHgYc7iMugmbI
 zzCRceBYG/1iRm1Ov7CWzuMdgdRYKMOj+QusBgq9gmoB7ENKdu2HyyYF/knvvz+s0L/lkF3Vz0W
 VAcD+cODbYjigMa0QlhJdI0eaXi9yssJ5mNtEMm0e+yZX8RISUPGddRAoeP56OnAUn0AWK8RA6w
 IFvKhrbXG+UIEPQE0q+l+A2GG5AoTvGsjBnZtwRA0R0BA+Q1UsTOuCY3e8le3SaQjo+Q+xqYAsk
 RaI8TeSg2EmgZI6iH3SBAdSZ0uNYVKubvRGm0jQhVZQ1mElI
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 30 -----------------------
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

---
base-commit: c35e927cbe09d38b2d72183bb215901183927c68
change-id: 20230807-riscv-allwinner-d1-revert-can-controller-nodes-65f62e04619c

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>


