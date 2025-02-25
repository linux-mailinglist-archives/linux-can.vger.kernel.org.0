Return-Path: <linux-can+bounces-2953-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BF1A444A5
	for <lists+linux-can@lfdr.de>; Tue, 25 Feb 2025 16:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1E7860175
	for <lists+linux-can@lfdr.de>; Tue, 25 Feb 2025 15:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C451632F2;
	Tue, 25 Feb 2025 15:41:18 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE69155757;
	Tue, 25 Feb 2025 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498078; cv=none; b=pXBsaGqdMR/37mxN8XZYFVFoJR8q0oqmTnBm0dDXcEoKEyZmPIM02nQd0BBJMkM4lnBsrIkqO+MvPcB4HGmy0+Kj92IYjETK9hrxrsc5a0arirx6uYs3xwp+KgYlRfC83YXf4jY6qrNPUR0fRZNPrt155XKqb3q9O1wQwvRwR54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498078; c=relaxed/simple;
	bh=dL0lG5OWjf9Y5/VM6W7Dof25KjyKM+6edTgV5qDq2gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgAhIIpXyZbcnLXQBeClXBv2eYe6CGAcCOsFba5MID1HlJnALfyP+E7sjkCGLVLybfWnODmaPOz9s+MMhjXm8TWNGjA6JcLxtRJKJe2dCYeN4PrVWlb0PrSbMmEJ6rF5M5dQM6Lak5Rocju3tqgc9OZbqUIOSci2zdH3faLi0I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: KJCICU0KQ6ufXiUy8zBvQw==
X-CSE-MsgGUID: BTcL/S1AQ+KurJd89lhdxA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 26 Feb 2025 00:41:10 +0900
Received: from localhost.localdomain (unknown [10.226.92.81])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 02155400FC34;
	Wed, 26 Feb 2025 00:41:05 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Simon Horman <horms@kernel.org>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 01/11] dt-bindings: can: renesas,rcar-canfd: Simplify the conditional schema
Date: Tue, 25 Feb 2025 15:40:40 +0000
Message-ID: <20250225154058.59116-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225154058.59116-1-biju.das.jz@bp.renesas.com>
References: <20250225154058.59116-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RZ/G3E SoC has 20 interrupts, 2 resets and 6 channels that need more
branching with conditional schema. Simplify the conditional schema with
if statements rather than the complex if-else statements to prepare for
supporting RZ/G3E SoC.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
This patch depend upon [1]
[1] https://lore.kernel.org/all/20250220094516.126598-2-biju.das.jz@bp.renesas.com/
v2->v3:
 * Collected tags.
v1->v2:
 * No change
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 123 ++++++++++++------
 1 file changed, 80 insertions(+), 43 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index f6884f6e59e7..f87f90f431e5 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -45,7 +45,35 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    oneOf:
+      - items:
+          - description: Channel interrupt
+          - description: Global interrupt
+      - items:
+          - description: CAN global error interrupt
+          - description: CAN receive FIFO interrupt
+          - description: CAN0 error interrupt
+          - description: CAN0 transmit interrupt
+          - description: CAN0 transmit/receive FIFO receive completion interrupt
+          - description: CAN1 error interrupt
+          - description: CAN1 transmit interrupt
+          - description: CAN1 transmit/receive FIFO receive completion interrupt
+
+  interrupt-names:
+    oneOf:
+      - items:
+          - const: ch_int
+          - const: g_int
+      - items:
+          - const: g_err
+          - const: g_recc
+          - const: ch0_err
+          - const: ch0_rec
+          - const: ch0_trx
+          - const: ch1_err
+          - const: ch1_rec
+          - const: ch1_trx
 
   clocks:
     maxItems: 3
@@ -117,52 +145,71 @@ allOf:
     then:
       properties:
         interrupts:
-          items:
-            - description: CAN global error interrupt
-            - description: CAN receive FIFO interrupt
-            - description: CAN0 error interrupt
-            - description: CAN0 transmit interrupt
-            - description: CAN0 transmit/receive FIFO receive completion interrupt
-            - description: CAN1 error interrupt
-            - description: CAN1 transmit interrupt
-            - description: CAN1 transmit/receive FIFO receive completion interrupt
+          minItems: 8
+          maxItems: 8
 
         interrupt-names:
-          items:
-            - const: g_err
-            - const: g_recc
-            - const: ch0_err
-            - const: ch0_rec
-            - const: ch0_trx
-            - const: ch1_err
-            - const: ch1_rec
-            - const: ch1_trx
+          minItems: 8
+          maxItems: 8
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rcar-gen3-canfd
+              - renesas,rcar-gen4-canfd
+    then:
+      properties:
+        interrupts:
+          minItems: 2
+          maxItems: 2
+
+        interrupt-names:
+          minItems: 2
+          maxItems: 2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,rzg2l-canfd
+    then:
+      properties:
         resets:
+          minItems: 2
           maxItems: 2
 
         reset-names:
-          items:
-            - const: rstp_n
-            - const: rstc_n
+          minItems: 2
+          maxItems: 2
 
       required:
         - reset-names
-    else:
-      properties:
-        interrupts:
-          items:
-            - description: Channel interrupt
-            - description: Global interrupt
-
-        interrupt-names:
-          items:
-            - const: ch_int
-            - const: g_int
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rcar-gen3-canfd
+              - renesas,rcar-gen4-canfd
+    then:
+      properties:
         resets:
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rcar-gen3-canfd
+              - renesas,rzg2l-canfd
+    then:
+      patternProperties:
+        "^channel[2-7]$": false
+
   - if:
       properties:
         compatible:
@@ -171,16 +218,6 @@ allOf:
     then:
       patternProperties:
         "^channel[4-7]$": false
-    else:
-      if:
-        not:
-          properties:
-            compatible:
-              contains:
-                const: renesas,rcar-gen4-canfd
-      then:
-        patternProperties:
-          "^channel[2-7]$": false
 
 unevaluatedProperties: false
 
-- 
2.43.0


