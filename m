Return-Path: <linux-can+bounces-1871-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D51B9BB523
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 13:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72949B24F21
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 12:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3B71B6D04;
	Mon,  4 Nov 2024 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Gyq7+p9O"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28444188700;
	Mon,  4 Nov 2024 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724838; cv=none; b=qRkopaEyVBMFFz4ZspqYrV+z2iwGAWb4iiMOrxIcg4Ah8ZFSUNnnqzHEVFDYVXy87EaGJkiT630pZf8wvZFSD9m+hJ3W75TgqZChEE5FOrxUf3/ip8Gu5QtVThLAfxU4GoOItMt81hG4fEs5u/Z+OxIPBPLh8B/Bq4VD3rblEws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724838; c=relaxed/simple;
	bh=QsB96WLlxyBkpPCDkrGTOdZUuEGM40LRH8fdJ8ClFp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UD7DitAwOWjJXbj7o17lG2Hk5aPJwPZQ0b2+zXogPemfUKrMVu0FxX+k6SAE4Y5u6iE8HBTCL4oxO0ntfqrN6MY1Jdf7tN24wHQ9MV/WTFzEtARGNwzcuS/t+cI7snDB8GRh90czmZEM32YvUjgaRCdE3J7MaKrc9yGMFDJ1EFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Gyq7+p9O; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=MmlxgEqKziTj1q+YPuL8kTTJi9CETcM/dQgzPCIXOxw=; b=Gyq7+p9OGNS0B9EWxJwutI9NrA
	QynE3nAus4PUmrU6t1pvIpEsXRKk+6GmCprvpmeswKfcQnq8xpujZ0cmt6O9DRhcjCUw46YTCl0Yt
	MgwzRvsp80qNYOOfMgKkFg/AMybIMykfav3rWzWoxzX0D+cbwIpWbcCe/mfCWPW1kmPPvzCJ9Vd9S
	nfPWFpFjEGpDnJvaQGlgrlqu9/Ue9lJY62MoHNe4lrwcgWT2qvHR0/KVb+eGjogMGlaaY9Lq/8SDF
	qmz9XyZ6AONlGAvnrOFDKuN/ysBXN7g9z5FvtPmHESLruZdux2h0HxP0RBWXVL8gNEMZukb8Mrr0b
	psVpp58g==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1t7wad-000P8L-Mo; Mon, 04 Nov 2024 13:53:51 +0100
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1t7wac-000OtJ-33;
	Mon, 04 Nov 2024 13:53:50 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Sean Nyekjaer <sean@geanix.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: can: convert tcan4x5x.txt to DT schema
Date: Mon,  4 Nov 2024 13:53:40 +0100
Message-ID: <20241104125342.1691516-1-sean@geanix.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27448/Mon Nov  4 10:33:38 2024)

Convert binding doc tcan4x5x.txt to yaml.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes since rfc:
  - Tried to re-add ti,tcan4x5x wildcard
  - Removed xceiver and vdd supplies (copy paste error)
  - Corrected max SPI frequency
  - Copy pasted bosch,mram-cfg from bosch,m_can.yaml
  - device-state-gpios and device-wake-gpios only available for tcan4x5x

 .../devicetree/bindings/net/can/tcan4x5x.txt  |  48 -----
 .../bindings/net/can/ti,tcan4x5x.yaml         | 189 ++++++++++++++++++
 2 files changed, 189 insertions(+), 48 deletions(-)
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
index 000000000000..0351e5c04230
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
@@ -0,0 +1,189 @@
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
+          - const: ti,tcan4x5x
+      - items:
+          - enum:
+              - ti,tcan4553
+          - const: ti,tcan4x5x
+      - items:
+          - enum:
+              - ti,tcan4x5x
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
+    description: |
+      Input GPIO that indicates if the device is in a sleep state or if the
+      device is active. Not available with tcan4552/4553.
+    maxItems: 1
+
+  device-wake-gpios:
+    description: |
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
+    description: |
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
+additionalProperties: false
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
+            compatible = "ti,tcan4552","ti,tcan4x5x";
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
-- 
2.46.2


