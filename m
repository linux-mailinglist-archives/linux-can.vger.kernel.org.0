Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F1B265386
	for <lists+linux-can@lfdr.de>; Thu, 10 Sep 2020 23:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgIJVg4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 10 Sep 2020 17:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730929AbgIJNjG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Sep 2020 09:39:06 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E7BC061786
        for <linux-can@vger.kernel.org>; Thu, 10 Sep 2020 06:38:34 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d19so932247pld.0
        for <linux-can@vger.kernel.org>; Thu, 10 Sep 2020 06:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iLHRBASNYEmkuiDuFe0SBkN4vlTm2qDSJERpRCtFbFA=;
        b=vEnJvArt/jV0tucYprJiUPmNwaW3jWlqQwEcsKSihRWgrM8pMPo1UEWkeD7wLyJ6B9
         BqZCp3BAD57mPSKl6tForgxMWdF4TWrEL/PplwAsPWRmqm+kUipqzcyzUoi0opDv261Y
         t+IgVsFA6a4onPVxt0ULMwUyVwm0ZpmLO77dcF/3juGtwdYUYWzLa3VgDl1msKV+/xuK
         Yv+ddumuoJjCRfAzM+tEtm+Ux6JBXCl/gATaROEnpSnXRfVyf1esldpCG9WNjnvwNU48
         srhGrK+ThsD48PMEom/iZ1ppJpptRtIP5GHMQIiwCXa33b6WX6sCWmWnP1MOK+gHFyEC
         rgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iLHRBASNYEmkuiDuFe0SBkN4vlTm2qDSJERpRCtFbFA=;
        b=eX2tJokB0+ifeDh/V6YfKlKGi9qsPaMe5HlCAaQoNSvEX8QVNMJ+k91uGJJb37Ewz+
         ZgtG7FqnrLlUMKe8IaoZJjKfqDf31UkKsA39T1hKKcRgnkkPP4Ww+BvieQ+z8W6TclPo
         3rz/x9lRsjilM6hUbvC2CVIVW/g1/j88oULdPN83mE+cBuJedh9MuwXKMZ1tW0QlD7cO
         Tf8CRgjdd82HgcfK3SG4blKGh2wr3ACWgmJ2fCt5JW8zYkxA1oayOJSIGg8/hbJDsVuE
         Oq3YiGXtyVQnkTxOzi8OtO5ZB+OPVWAhuGpwIEQFKl8yPjbnwSf6tMOqVws2rcgduBQt
         On4g==
X-Gm-Message-State: AOAM531a76eVt+uTeVnXS//uRAAkApv/alDxWp9YZzxXdMj7sZG/a7Q2
        6s1r4cYA8B9exg6PCOnX2BrZL6SUuKx8pxQ=
X-Google-Smtp-Source: ABdhPJzeWOZ1pKO1jcd2dS9St5qDG+fGn/Dm3FoTJSpj456ARhGUf0y/P2YtXpGsHxYBpIY+z3cXKg==
X-Received: by 2002:a17:90a:d3cd:: with SMTP id d13mr33821pjw.70.1599745105313;
        Thu, 10 Sep 2020 06:38:25 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id o30sm5603801pgc.45.2020.09.10.06.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 06:38:24 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org
Cc:     linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dev.kurt@vandijck-laurijssen.be,
        o.rempel@pengutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/6] dt-bindings: can: mcp25xxfd: document device tree bindings
Date:   Thu, 10 Sep 2020 19:08:02 +0530
Message-Id: <20200910133806.25077-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910133806.25077-1-manivannan.sadhasivam@linaro.org>
References: <20200910133806.25077-1-manivannan.sadhasivam@linaro.org>
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

This patch adds the device-tree binding documentation for the Microchip
MCP25xxFD SPI CAN controller family.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/net/can/microchip,mcp25xxfd.yaml | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
new file mode 100644
index 000000000000..aa2cad14d6d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/microchip,mcp25xxfd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:
+  Microchip MCP2517FD and MCP2518FD stand-alone CAN controller device tree
+  bindings
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
+  microchip,rx-int-gpios:
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
+            microchip,rx-int-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
+            vdd-supply = <&reg5v0>;
+            xceiver-supply = <&reg5v0>;
+        };
+    };
-- 
2.17.1

