Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0635A203612
	for <lists+linux-can@lfdr.de>; Mon, 22 Jun 2020 13:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgFVLqT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Jun 2020 07:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgFVLqT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Jun 2020 07:46:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4933AC061795
        for <linux-can@vger.kernel.org>; Mon, 22 Jun 2020 04:46:19 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1jnKu1-0001AV-IA; Mon, 22 Jun 2020 13:46:17 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     manivannan.sadhasivam@linaro.org, dev.kurt@vandijck-laurijssen.be,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v41 2/3] dt-binding: can: mcp25xxfd: document device tree bindings
Date:   Mon, 22 Jun 2020 13:46:02 +0200
Message-Id: <20200622114603.965371-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200622114603.965371-1-mkl@pengutronix.de>
References: <20200622114603.965371-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

This patch adds the device-tree binding documentation for the Microchip
MCP25xxFD SPI CAN controller family.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../bindings/net/can/microchip,mcp25xxfd.yaml | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
new file mode 100644
index 000000000000..4993dd49181c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/microchip,mcp25xxfd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP2517/18FD stand-alone CAN controller device tree bindings
+
+maintainers:
+  - Marc Kleine-Budde <mkl@pengutronix.de>
+
+properties:
+  compatible:
+    oneOf:
+      - const: microchip,mcp2517fd
+        description: for MCP2517FD
+      - const: microchip,mcp2518fd
+        description: for MCP2518FD
+      - const: microchip,mcp25xxfd
+        description: to autodetect chip variant
+
+  reg:
+    maxItems: 1
+
+  interrupts-extended:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that powers the CAN controller.
+    maxItems: 1
+
+  xceiver-supply:
+    description: Regulator that powers the CAN transceiver.
+    maxItems: 1
+
+  rx-int-gpios:
+    description:
+      GPIO phandle of GPIO connected to to INT1 pin of the MCP25XXFD, which
+      signals a pending RX interrupt.
+    maxItems: 1
+
+  spi-max-frequency:
+    description:
+      Must be half or less of "clocks" frequency.
+    maximum: 20000000
+
+required:
+  - compatible
+  - reg
+  - interrupts-extended
+  - clocks
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        can@0 {
+            compatible = "microchip,mcp25xxfd";
+            reg = <0>;
+            clocks = <&can0_osc>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&can0_pins>;
+            spi-max-frequency = <20000000>;
+            interrupts-extended = <&gpio 13 IRQ_TYPE_LEVEL_LOW>;
+            rx-int-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
+            vdd-supply = <&reg5v0>;
+            xceiver-supply = <&reg5v0>;
+        };
+    };
-- 
2.27.0

