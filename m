Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC743AE92C
	for <lists+linux-can@lfdr.de>; Mon, 21 Jun 2021 14:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhFUMhL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Jun 2021 08:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhFUMhB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Jun 2021 08:37:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4D8C061767
        for <linux-can@vger.kernel.org>; Mon, 21 Jun 2021 05:34:46 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lvJ8X-0007G7-BH
        for linux-can@vger.kernel.org; Mon, 21 Jun 2021 14:34:45 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id C0448640604
        for <linux-can@vger.kernel.org>; Mon, 21 Jun 2021 12:34:43 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 8FBCB6405E3;
        Mon, 21 Jun 2021 12:34:39 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id bb33ade4;
        Mon, 21 Jun 2021 12:34:38 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 8/8] imx6dl-riotboard-can: added
Date:   Mon, 21 Jun 2021 14:34:36 +0200
Message-Id: <20210621123436.2897023-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621123436.2897023-1-mkl@pengutronix.de>
References: <20210621123436.2897023-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/imx6dl-riotboard-can.dts | 187 +++++++++++++++++++++
 2 files changed, 188 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-riotboard-can.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f8f09c5066e7..e77c91d4aa27 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -469,6 +469,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-prtvt7.dtb \
 	imx6dl-rex-basic.dtb \
 	imx6dl-riotboard.dtb \
+	imx6dl-riotboard-can.dtb \
 	imx6dl-sabreauto.dtb \
 	imx6dl-sabrelite.dtb \
 	imx6dl-sabresd.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-riotboard-can.dts b/arch/arm/boot/dts/imx6dl-riotboard-can.dts
new file mode 100644
index 000000000000..5b995496f554
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-riotboard-can.dts
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/dts-v1/;
+
+#include "imx6dl-riotboard.dts"
+
+/ {
+	clocks {
+		mcp251xfd1_osc: mcp251xfd1-osc {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <40000000>;
+		};
+
+		mcp251xfd2_osc: mcp251xfd2-osc {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <40000000>;
+		};
+
+		tcan4x5x_osc: tcan4x5x-osc {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <40000000>;
+		};
+	};
+
+	reg_mcp251xfd1_xceiver: regulator-mcp251xfd1-xceiver {
+		compatible = "regulator-fixed";
+		regulator-name = "mcp251xfd1-xceiver";
+		gpio = <&gpio4 30 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_mcp251xfd1_xceiver>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_mcp251xfd1_vdd: regulator-mcp251xfd-vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "mcp251xfd1-vdd";
+		gpio = <&gpio4 19 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_mcp251xfd1_vdd>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+	};
+
+#if 0
+	reg_tcan4x5x_vsup: regulator-tcan4x5x-vsup {
+		compatible = "regulator-fixed";
+		regulator-name = "tcan4x5x-vsup";
+		gpio = <&gpio5 6 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tcan4x5x_vsup>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		startup-delay-us = <600>;
+	};
+#endif
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+
+	imx6-riotboard {
+		pinctrl_flexcan1: flexcan1_grp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_7__FLEXCAN1_TX		0x1b0b0
+				MX6QDL_PAD_GPIO_8__FLEXCAN1_RX		0x1b0b0
+			>;
+		};
+
+		pinctrl_mcp251xfd1_mikrobus: mcp251xfd1_mikrobus_grp {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT12__GPIO5_IO06	0x1b0b0		// GPIO5_06	-> IRQ
+			>;
+		};
+
+		pinctrl_mcp251xfd1_shield: mcp251xfd1_shield_grp {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT13__GPIO5_IO07	0x1b0b0		// GPIO5_07	-> IRQ
+			>;
+		};
+
+		pinctrl_mcp251xfd1_xceiver: mcp251xfd1_xceiver_grp {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT9__GPIO4_IO30	0x1b0b0		// PWM2		-> xceiver
+			>;
+		};
+
+		pinctrl_mcp251xfd1_vdd: mcp251xfd1_vdd_grp {
+			fsl,pins = <
+				MX6QDL_PAD_DI0_PIN3__GPIO4_IO19		0x1b0b0		// GPIO4_19	-> VDD
+			>;
+		};
+
+		pinctrl_mcp251xfd2_shield: mcp251xfd2_shield_grp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D25__GPIO3_IO25		0x1b0b0		// UART3_RXD	-> IRQ
+			>;
+
+		};
+#if 0
+		pinctrl_tcan4x5x: tcan4x5xgrp {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT10__GPIO4_IO31	0x1b0b0		// IRQ
+				MX6QDL_PAD_DISP0_DAT11__GPIO5_IO05	0x1b0b0		// wake
+			>;
+		};
+
+		pinctrl_tcan4x5x_vsup: tcan4x5x_vsup_grp {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT12__GPIO5_IO06	0x1b0b0
+			>;
+		};
+#endif
+	};
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	status = "okay";
+};
+
+&i2c4 {
+	status = "disabled";
+};
+
+&pwm2 {
+	status = "disabled";
+};
+
+&uart3 {
+	status = "disabled";
+};
+
+&ecspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	cs-gpios = <&gpio5 12 GPIO_ACTIVE_LOW>, <&gpio5 9 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	mcp251xfd1: mcp251xfd@0 {
+		reg = <0>;
+		compatible = "microchip,mcp251xfd";
+		xceiver-supply = <&reg_mcp251xfd1_xceiver>;
+		vdd-supply = <&reg_mcp251xfd1_vdd>;
+		pinctrl-names = "default";
+#if 1
+		pinctrl-0 = <&pinctrl_mcp251xfd1_mikrobus>;
+		interrupts-extended = <&gpio5 6 IRQ_TYPE_LEVEL_LOW>;	// mikrobus
+#else
+		pinctrl-0 = <&pinctrl_mcp251xfd1_shield>;
+		interrupts-extended = <&gpio5 7 IRQ_TYPE_LEVEL_LOW>;	// shield
+#endif
+		clocks = <&mcp251xfd1_osc>;
+		spi-max-frequency = <20000000>;
+	};
+
+	mcp251xfd2: mcp251xfd@1 {
+		reg = <1>;
+		compatible = "microchip,mcp251xfd";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_mcp251xfd2_shield>;
+		interrupts-extended = <&gpio3 25 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&mcp251xfd2_osc>;
+		spi-max-frequency = <20000000>;
+	};
+
+#if 0
+	tcan4x5x: tcan4x5x@1 {
+		reg = <1>;
+		compatible = "ti,tcan4x5x";
+		vsup-supply = <&reg_tcan4x5x_vsup>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tcan4x5x>;
+		spi-max-frequency = <10000000>;
+		bosch,mram-cfg = <0x0 0 0 16 0 0 1 1>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
+		clock-names = "cclk";
+		clocks = <&tcan4x5x_osc>;
+		device-wake-gpios = <&gpio5 5 GPIO_ACTIVE_HIGH>;
+	};
+#endif
+};
-- 
2.30.2


