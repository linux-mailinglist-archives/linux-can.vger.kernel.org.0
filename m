Return-Path: <linux-can+bounces-1861-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 198319BAEC6
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 09:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4D8BB2262E
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 08:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24531AF0AA;
	Mon,  4 Nov 2024 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Nb9buJXz"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6546E1ABEA5;
	Mon,  4 Nov 2024 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710609; cv=none; b=JTI2fM02C9Ox+Hwj+Q4rMKM1BFHj9SWt56i1SIwus4Igx7ae/JuA4/8IUK9OJuYr9YbQ6rZykOKjQvX/b73BR6e3ljW1kB0IhVabiTGOnm4G42zjNmNjVtgQF5BIHV1GCWd4GVlekPVvbgXf948+OZx8/5uBUwBRt/3sYX2/UeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710609; c=relaxed/simple;
	bh=DbA2AEzCZovDIsw1ZlFZ8GDzT6MXyd0MnqvqEW2ykrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZV0dxqH2OLlCeuTNqrVpt7W+2bsh8Gy7emDPDrmJqIapnoebMvLsRw0OqtjAZzWkV8SCMNJGgxjQYCARKB3/E4d1bCfwvA2PsfElwmLcoPebKCsHjfvGOKWVEuVm5kYPHfsAukQCRt2aO2FU+oEfuQBYTrpy7Xn2OwfF0Z+CtTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Nb9buJXz; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=l/EQKtXU0ivrCC+MIz2pary8R5/8USRLvyKAY9Yy/mI=; b=Nb9buJXzFJqBghSp8frhQOW6LC
	1B5luLCs+8k/Dd2IAHihMYKoZPHK5Z9UlGPondaumnKJU0oJc9src2K35KpZRMYzFFvSxUcI4mwHj
	SIMfdKbV5e6L0Bp+y40mAh5a9euQocXuaXfcmfnokgNkV06SUhrvniAXoCOPJrxpckqssGos2Z/um
	jycHo1tIvc8OjK9xR6dmJUkr2Fc9kKpztfxNdgQfXsZh1KECycDIrMF/aObLU8d+Jjhgpto3UzX0B
	Lo5LALHqy5+bsC8GynrztyIZmIXmoni/tYTKJ4RXYxOn10inAJfJ/ogjeU3ztRhiEslxVvde8Z6zG
	EimE9TwA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1t7st2-0005XE-99; Mon, 04 Nov 2024 09:56:36 +0100
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1t7st1-000Gvx-1d;
	Mon, 04 Nov 2024 09:56:35 +0100
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
Subject: [RFC PATCH] dt-bindings: can: convert tcan4x5x.txt to DT schema
Date: Mon,  4 Nov 2024 09:56:15 +0100
Message-ID: <20241104085616.469862-1-sean@geanix.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27447/Sun Nov  3 10:33:29 2024)

Convert binding doc tcan4x5x.txt to yaml.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---

Can we somehow reference bosch,mram-cfg from the bosch,m_can.yaml?
I have searched for yaml files that tries the same, but it's usually
includes a whole node.

I have also tried:
$ref: /schema/bosch,m_can.yaml#/properties/bosch,mram-cfg

Any hints to share a property?

 .../devicetree/bindings/net/can/tcan4x5x.txt  | 48 ---------
 .../bindings/net/can/ti,tcan4x5x.yaml         | 97 +++++++++++++++++++
 2 files changed, 97 insertions(+), 48 deletions(-)
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
index 000000000000..62c108fac6b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
@@ -0,0 +1,97 @@
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
+allOf:
+  - $ref: can-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - ti,tcan4552
+          - ti,tcan4553
+          - ti,tcan4x5x
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that powers the CAN controller.
+
+  xceiver-supply:
+    description: Regulator that powers the CAN transceiver.
+
+  reset-gpios:
+    description: Hardwired output GPIO. If not defined then software reset.
+    maxItems: 1
+
+  device-state-gpios:
+    description: Input GPIO that indicates if the device is in a sleep state or if the device is active.
+      Not available with tcan4552/4553.
+    maxItems: 1
+
+  device-wake-gpios:
+    description: Wake up GPIO to wake up the TCAN device. Not available with tcan4552/4553.
+    maxItems: 1
+
+  bosch,mram-cfg:
+    $ref: bosch,m_can.yaml#
+
+  spi-max-frequency:
+    description:
+      Must be half or less of "clocks" frequency.
+    maximum: 10000000
+
+  wakeup-source:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enable CAN remote wakeup.
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
-- 
2.46.2


