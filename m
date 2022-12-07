Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBD3646218
	for <lists+linux-can@lfdr.de>; Wed,  7 Dec 2022 21:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLGUHR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 7 Dec 2022 15:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiLGUHQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Dec 2022 15:07:16 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29BD686BC
        for <linux-can@vger.kernel.org>; Wed,  7 Dec 2022 12:07:14 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:947e:1fc0:ebbb:447b])
        by xavier.telenet-ops.be with bizsmtp
        id tY792800J4BwbnS01Y79el; Wed, 07 Dec 2022 21:07:11 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1p30Qd-002rg7-HJ; Wed, 07 Dec 2022 20:50:03 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1p2xcj-002Xs4-Ri; Wed, 07 Dec 2022 17:50:21 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Ulrich Hecht <uli+renesas@fpond.eu>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] dt-bindings: can: renesas,rcar-canfd: Fix number of channels for R-Car V3U
Date:   Wed,  7 Dec 2022 17:50:21 +0100
Message-Id: <7d41d72cd7db2e90bae069ce57dbb672f17500ae.1670431681.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

According to the bindings, only two channels are supported.
However, R-Car V3U supports eight, leading to "make dtbs" failures:

        arch/arm64/boot/dts/renesas/r8a779a0-falcon.dtb: can@e6660000: Unevaluated properties are not allowed ('channel2', 'channel3', 'channel4', 'channel5', 'channel6', 'channel7' were unexpected)

Update the number of channels to 8 on R-Car V3U.
While at it, prevent adding more properties to the channel nodes, as
they must contain no other properties than a status property.

Fixes: d6254d52d70de530 ("dt-bindings: can: renesas,rcar-canfd: Document r8a779a0 support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - s/unevaluatedProperties/additionalProperties/.
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 133 ++++++++++--------
 1 file changed, 72 insertions(+), 61 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index 6f71fc96bc4e3156..5228fd513ca89a3c 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -9,9 +9,6 @@ title: Renesas R-Car CAN FD Controller
 maintainers:
   - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
 
-allOf:
-  - $ref: can-controller.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -77,12 +74,13 @@ properties:
     description: Maximum frequency of the CANFD clock.
 
 patternProperties:
-  "^channel[01]$":
+  "^channel[0-7]$":
     type: object
     description:
-      The controller supports two channels and each is represented as a child
-      node.  Each child node supports the "status" property only, which
-      is used to enable/disable the respective channel.
+      The controller supports multiple channels and each is represented as a
+      child node.  Each channel can be enabled/disabled individually.
+
+    additionalProperties: false
 
 required:
   - compatible
@@ -98,60 +96,73 @@ required:
   - channel0
   - channel1
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - renesas,rzg2l-canfd
-then:
-  properties:
-    interrupts:
-      items:
-        - description: CAN global error interrupt
-        - description: CAN receive FIFO interrupt
-        - description: CAN0 error interrupt
-        - description: CAN0 transmit interrupt
-        - description: CAN0 transmit/receive FIFO receive completion interrupt
-        - description: CAN1 error interrupt
-        - description: CAN1 transmit interrupt
-        - description: CAN1 transmit/receive FIFO receive completion interrupt
-
-    interrupt-names:
-      items:
-        - const: g_err
-        - const: g_recc
-        - const: ch0_err
-        - const: ch0_rec
-        - const: ch0_trx
-        - const: ch1_err
-        - const: ch1_rec
-        - const: ch1_trx
-
-    resets:
-      maxItems: 2
-
-    reset-names:
-      items:
-        - const: rstp_n
-        - const: rstc_n
-
-  required:
-    - reset-names
-else:
-  properties:
-    interrupts:
-      items:
-        - description: Channel interrupt
-        - description: Global interrupt
-
-    interrupt-names:
-      items:
-        - const: ch_int
-        - const: g_int
-
-    resets:
-      maxItems: 1
+allOf:
+  - $ref: can-controller.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rzg2l-canfd
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: CAN global error interrupt
+            - description: CAN receive FIFO interrupt
+            - description: CAN0 error interrupt
+            - description: CAN0 transmit interrupt
+            - description: CAN0 transmit/receive FIFO receive completion interrupt
+            - description: CAN1 error interrupt
+            - description: CAN1 transmit interrupt
+            - description: CAN1 transmit/receive FIFO receive completion interrupt
+
+        interrupt-names:
+          items:
+            - const: g_err
+            - const: g_recc
+            - const: ch0_err
+            - const: ch0_rec
+            - const: ch0_trx
+            - const: ch1_err
+            - const: ch1_rec
+            - const: ch1_trx
+
+        resets:
+          maxItems: 2
+
+        reset-names:
+          items:
+            - const: rstp_n
+            - const: rstc_n
+
+      required:
+        - reset-names
+    else:
+      properties:
+        interrupts:
+          items:
+            - description: Channel interrupt
+            - description: Global interrupt
+
+        interrupt-names:
+          items:
+            - const: ch_int
+            - const: g_int
+
+        resets:
+          maxItems: 1
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: renesas,r8a779a0-canfd
+    then:
+      patternProperties:
+        "^channel[2-7]$": false
 
 unevaluatedProperties: false
 
-- 
2.25.1

