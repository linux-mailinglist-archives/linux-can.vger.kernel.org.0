Return-Path: <linux-can+bounces-1905-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5B39BCF2F
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 15:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1311C24414
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 14:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE9C1D86F1;
	Tue,  5 Nov 2024 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="fAbbvoRm"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BE71D5AB2;
	Tue,  5 Nov 2024 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816690; cv=none; b=YYM74nDMhjk0ivrAnaDv/IUBT9IDuNTXQCDsCSoy/9RLXrrkSzFp0FFym3V56h8Qz2XOJ2HDreaP/8Ace9SCsq3v84onKwYvIM1IzH6ooUr4C3UiR+QhFTNOVmnWpzzNseTcfH3QbcfP2dZf5+GXxyNfTagyFfyzgpYwHaSIkso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816690; c=relaxed/simple;
	bh=jloAkXqe5JFmFhB0Zv7JTbb7qpuv14n45ikCXl9nlLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KuDupvfevSm0amaIjOT4/7Bk6EwzwKf/fCv0zdSxmhZz9AsgTo1Mzo3QHLtKrxm5EU7nlchr5jAA5l25Nq2utSJMQ04fQ1jD5v7/S5u/1S8smpG/mJ9TlESm58nhPo6TtPzQy9YU4PHFJywL8nNFcLxLIGQ4dmy4WqzZYAGTB9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=fAbbvoRm; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=B2TbzasSipWhR1FdJvRQDldtLvGcjQd4ZD8ioLxtzsE=; b=fA
	bbvoRmjaP4bmZlqD4aTmR0w/MeJz6Lu5k6iZBAWKUzdDbyUgLAaJ/9i/87CDuFqIRMJ89IS0L7GI2
	TtvIIN7Wiv1i/8voY4lL2Beh8FEevw0vyoiOjxRMMCSj/nZCxsTLMYRyc/Q7gebIUVNuJX4JmrDwW
	JXrgxYHeUBLXpoMt/CYhQWGnu4tAGJ/bNox/NTSxj386aeIJbMx6eG3w63jPCFuVxJw1Pb6pqsIR8
	s85Unsr4f2PHOkqKhbF3DUHMvtOMdQfGR0R3xm7FI9Okfb4zf6QK761xPxn0TT7BdAckv8yyEFtK+
	JzjsKuO/YpoeTMNhXBPDM7HGqj4GtMjA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1t8KU7-000JBp-PN; Tue, 05 Nov 2024 15:24:43 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1t8KU7-0002FW-08;
	Tue, 05 Nov 2024 15:24:43 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Tue, 05 Nov 2024 15:24:34 +0100
Subject: [PATCH v2] dt-bindings: can: convert tcan4x5x.txt to DT schema
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-convert-tcan-v2-1-4b320f3fcf99@geanix.com>
X-B4-Tracking: v=1; b=H4sIAKIqKmcC/zXMwQrCMAzG8VcZOdux1LSgJ99Ddqg123KwlbaUy
 di7WwdeAv/A99sgcxLOcO02SFwlSwwt9KkDv7gws5Jna9CDJsTBKB9D5VRU8S4oehi0pIn9ZKF
 N3oknWQ/uPrZeJJeYPode8ff9Q4TanEn3aC/YDIUqswu3uR1Zex9fMO77/gXTirQdnwAAAA==
X-Change-ID: 20241105-convert-tcan-4b516424ecf6
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27449/Tue Nov  5 10:36:43 2024)

Convert binding doc tcan4x5x.txt to yaml.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes since rfc:
- Tried to re-add ti,tcan4x5x wildcard
- Removed xceiver and vdd supplies (copy paste error)
- Corrected max SPI frequency
- Copy pasted bosch,mram-cfg from bosch,m_can.yaml
- device-state-gpios and device-wake-gpios only available for tcan4x5x

Changes in v2:
- Removed unneeded "|"
- Reworked properties, compatible
- Removed additionalProperties: false
- Added unevaluatedProperties: false
- Added missing space in examples
- Link to v1: https://lore.kernel.org/r/20241104125342.1691516-1-sean@geanix.com
---
 .../devicetree/bindings/net/can/tcan4x5x.txt       |  48 ------
 .../devicetree/bindings/net/can/ti,tcan4x5x.yaml   | 184 +++++++++++++++++++++
 2 files changed, 184 insertions(+), 48 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
deleted file mode 100644
index 20c0572c9853424e1d104cbf75d02094a54836c3..0000000000000000000000000000000000000000
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
index 0000000000000000000000000000000000000000..f1d18a5461e05296998ae9bf09bdfa1226580131
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
@@ -0,0 +1,184 @@
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

---
base-commit: 2b2a9a08f8f0b904ea2bc61db3374421b0f944a6
change-id: 20241105-convert-tcan-4b516424ecf6

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


