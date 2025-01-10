Return-Path: <linux-can+bounces-2574-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2483DA08F3C
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 12:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F860168A05
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 11:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D64205AC5;
	Fri, 10 Jan 2025 11:27:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61C21ACEB2
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508441; cv=none; b=lLx8pmBXt+b4iq0UoBJcCPu/k96cSUUnLHR44tPNKknf5RXgzXDwTbfpsK9bK7jKdwPkKKulpBN5LYSkI1ktkCJY6qiNfY4OC3Fj8Ox7Usp7kO5twsnmlOzsdAaJ/zhsZOGwBBKTLSw4qx8/s2qlKYbIelu1LAzkKGBswZYB33A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508441; c=relaxed/simple;
	bh=z8gLc3YY9D6V2yT11fdJvpQ4/9w/ebn3yB2Df8QX568=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbwDlot8piqOOYW+AthQCLYzjkDmOCxpayQi4pEh3NmadYx2kzE/Y95TMx5yf1rcD1Lf3MQRXkyMGK14keQTOfuwmaRL4oDjtbPJR6kq33WTtR0XUP9zlvXdhS3SGMFk7FZkZVS/ZQqFMrrJVolFUNK+vmdCoY724PwPOLFShRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAb-0004xI-SA
	for linux-can@vger.kernel.org; Fri, 10 Jan 2025 12:27:17 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAa-0009dj-2S
	for linux-can@vger.kernel.org;
	Fri, 10 Jan 2025 12:27:16 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 6D8D33A45C6
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 11:27:16 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 692123A458D;
	Fri, 10 Jan 2025 11:27:14 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9975d539;
	Fri, 10 Jan 2025 11:27:13 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Sean Nyekjaer <sean@geanix.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 02/18] dt-bindings: can: convert tcan4x5x.txt to DT schema
Date: Fri, 10 Jan 2025 12:04:10 +0100
Message-ID: <20250110112712.3214173-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250110112712.3214173-1-mkl@pengutronix.de>
References: <20250110112712.3214173-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Sean Nyekjaer <sean@geanix.com>

Convert binding doc tcan4x5x.txt to yaml.

Added during conversion, required clock-names cclk.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://patch.msgid.link/20241128-convert-tcan-v3-1-bf2d8005bab5@geanix.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../devicetree/bindings/net/can/tcan4x5x.txt  |  48 -----
 .../bindings/net/can/ti,tcan4x5x.yaml         | 191 ++++++++++++++++++
 2 files changed, 191 insertions(+), 48 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt
 create mode 100644 Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml

diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
deleted file mode 100644
index 20c0572c9853..000000000000
--- a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-Texas Instruments TCAN4x5x CAN Controller
-================================================
-
-This file provides device node information for the TCAN4x5x interface contains.
-
-Required properties:
-	- compatible:
-		"ti,tcan4552", "ti,tcan4x5x"
-		"ti,tcan4553", "ti,tcan4x5x" or
-		"ti,tcan4x5x"
-	- reg: 0
-	- #address-cells: 1
-	- #size-cells: 0
-	- spi-max-frequency: Maximum frequency of the SPI bus the chip can
-			     operate at should be less than or equal to 18 MHz.
-	- interrupt-parent: the phandle to the interrupt controller which provides
-                    the interrupt.
-	- interrupts: interrupt specification for data-ready.
-
-See Documentation/devicetree/bindings/net/can/bosch,m_can.yaml for additional
-required property details.
-
-Optional properties:
-	- reset-gpios: Hardwired output GPIO. If not defined then software
-		       reset.
-	- device-state-gpios: Input GPIO that indicates if the device is in
-			      a sleep state or if the device is active. Not
-			      available with tcan4552/4553.
-	- device-wake-gpios: Wake up GPIO to wake up the TCAN device. Not
-			     available with tcan4552/4553.
-	- wakeup-source: Leave the chip running when suspended, and configure
-			 the RX interrupt to wake up the device.
-
-Example:
-tcan4x5x: tcan4x5x@0 {
-		compatible = "ti,tcan4x5x";
-		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		spi-max-frequency = <10000000>;
-		bosch,mram-cfg = <0x0 0 0 16 0 0 1 1>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
-		device-state-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
-		device-wake-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
-		reset-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
-		wakeup-source;
-};
diff --git a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
new file mode 100644
index 000000000000..afd9d315dea2
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
@@ -0,0 +1,191 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/ti,tcan4x5x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TCAN4x5x CAN Controller
+
+maintainers:
+  - Marc Kleine-Budde <mkl@pengutronix.de>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - ti,tcan4552
+              - ti,tcan4553
+          - const: ti,tcan4x5x
+      - const: ti,tcan4x5x
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: The GPIO parent interrupt.
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: cclk
+
+  reset-gpios:
+    description: Hardwired output GPIO. If not defined then software reset.
+    maxItems: 1
+
+  device-state-gpios:
+    description:
+      Input GPIO that indicates if the device is in a sleep state or if the
+      device is active. Not available with tcan4552/4553.
+    maxItems: 1
+
+  device-wake-gpios:
+    description:
+      Wake up GPIO to wake up the TCAN device.
+      Not available with tcan4552/4553.
+    maxItems: 1
+
+  bosch,mram-cfg:
+    description: |
+      Message RAM configuration data.
+      Multiple M_CAN instances can share the same Message RAM
+      and each element(e.g Rx FIFO or Tx Buffer and etc) number
+      in Message RAM is also configurable, so this property is
+      telling driver how the shared or private Message RAM are
+      used by this M_CAN controller.
+
+      The format should be as follows:
+      <offset sidf_elems xidf_elems rxf0_elems rxf1_elems rxb_elems txe_elems txb_elems>
+      The 'offset' is an address offset of the Message RAM where
+      the following elements start from. This is usually set to
+      0x0 if you're using a private Message RAM. The remain cells
+      are used to specify how many elements are used for each FIFO/Buffer.
+
+      M_CAN includes the following elements according to user manual:
+      11-bit Filter	0-128 elements / 0-128 words
+      29-bit Filter	0-64 elements / 0-128 words
+      Rx FIFO 0		0-64 elements / 0-1152 words
+      Rx FIFO 1		0-64 elements / 0-1152 words
+      Rx Buffers	0-64 elements / 0-1152 words
+      Tx Event FIFO	0-32 elements / 0-64 words
+      Tx Buffers	0-32 elements / 0-576 words
+
+      Please refer to 2.4.1 Message RAM Configuration in Bosch
+      M_CAN user manual for details.
+    $ref: /schemas/types.yaml#/definitions/int32-array
+    items:
+      - description: The 'offset' is an address offset of the Message RAM where
+          the following elements start from. This is usually set to 0x0 if
+          you're using a private Message RAM.
+        default: 0
+      - description: 11-bit Filter 0-128 elements / 0-128 words
+        minimum: 0
+        maximum: 128
+      - description: 29-bit Filter 0-64 elements / 0-128 words
+        minimum: 0
+        maximum: 64
+      - description: Rx FIFO 0 0-64 elements / 0-1152 words
+        minimum: 0
+        maximum: 64
+      - description: Rx FIFO 1 0-64 elements / 0-1152 words
+        minimum: 0
+        maximum: 64
+      - description: Rx Buffers 0-64 elements / 0-1152 words
+        minimum: 0
+        maximum: 64
+      - description: Tx Event FIFO 0-32 elements / 0-64 words
+        minimum: 0
+        maximum: 32
+      - description: Tx Buffers 0-32 elements / 0-576 words
+        minimum: 0
+        maximum: 32
+    minItems: 1
+
+  spi-max-frequency:
+    description:
+      Must be half or less of "clocks" frequency.
+    maximum: 18000000
+
+  wakeup-source:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enable CAN remote wakeup.
+
+allOf:
+  - $ref: can-controller.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,tcan4552
+              - ti,tcan4553
+    then:
+      properties:
+        device-state-gpios: false
+        device-wake-gpios: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - bosch,mram-cfg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        can@0 {
+            compatible = "ti,tcan4x5x";
+            reg = <0>;
+            clocks = <&can0_osc>;
+            clock-names = "cclk";
+            pinctrl-names = "default";
+            pinctrl-0 = <&can0_pins>;
+            spi-max-frequency = <10000000>;
+            bosch,mram-cfg = <0x0 0 0 16 0 0 1 1>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
+            device-state-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
+            device-wake-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
+            wakeup-source;
+        };
+    };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        can@0 {
+            compatible = "ti,tcan4552", "ti,tcan4x5x";
+            reg = <0>;
+            clocks = <&can0_osc>;
+            clock-names = "cclk";
+            pinctrl-names = "default";
+            pinctrl-0 = <&can0_pins>;
+            spi-max-frequency = <10000000>;
+            bosch,mram-cfg = <0x0 0 0 16 0 0 1 1>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
+            reset-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
+            wakeup-source;
+        };
+    };
-- 
2.45.2



