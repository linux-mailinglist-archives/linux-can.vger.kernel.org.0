Return-Path: <linux-can+bounces-3214-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 608D8A71686
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 13:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1AF617A7C6
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 12:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061071E00A0;
	Wed, 26 Mar 2025 12:20:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE151DF72C;
	Wed, 26 Mar 2025 12:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991619; cv=none; b=TVD7Uf1Ccr7/rfl7//3L7EhSwPZzGP3h5IJkKixdUQ2uSucx8qwQXMUBsJP94WT6eZ6W70nq6VR80O/AAyeDM0vA+/ksU/VujOFOc9Cn8AMaiM+Mmfiojnq+IrwEWk8d45iSnutwF3FQeo/6OMzKp6rBUWhViHXLzx66gZG7w9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991619; c=relaxed/simple;
	bh=A6JpH/98dDThSHnV9RRCfbwnEY1eT9OWBNi+CRv7WI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GW8WqVlsmdUumC9YNr0UrfA63RFGyRZFPEvFuzTEUTZwu1mq4UzqOlLviPe9Xvjgjq89+DUF6dkHZ5yO/zZxgEnlne8aFhRit3h9+ln8MFyWs4Hlg9Qju84yFJrj9J2fCWZvTlv+ZkWw2CxnhYGh9SjXSWnbikmPP9JcMvTOiFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: yPzQ169bSXu2kJMsMlxL2A==
X-CSE-MsgGUID: KGCG/m9CQwe85Ikt5d5reQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 26 Mar 2025 21:20:17 +0900
Received: from localhost.localdomain (unknown [10.226.92.116])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 67AD240104CB;
	Wed, 26 Mar 2025 21:20:11 +0900 (JST)
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
Subject: [PATCH v7 01/18] dt-bindings: can: renesas,rcar-canfd: Simplify the conditional schema
Date: Wed, 26 Mar 2025 12:19:36 +0000
Message-ID: <20250326122003.122976-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v6->v7:
 * No change.
v5->v6:
 * No change.
v4->v5:
 * The rules for R-Car Gen3/4 could be kept together, reducing the number
   of lines. Done the similar change for rzg2l-canfd.
 * Retained the tags as it is trivial change.
v3->v4:
 * No change.
v2->v3:
 * Collected tags.
v1->v2:
 * No change
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 99 +++++++++++--------
 1 file changed, 60 insertions(+), 39 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index f6884f6e59e7..4a83498b2a8b 100644
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
@@ -117,52 +145,55 @@ allOf:
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
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rcar-gen3-canfd
+              - renesas,rcar-gen4-canfd
+    then:
       properties:
         interrupts:
-          items:
-            - description: Channel interrupt
-            - description: Global interrupt
+          minItems: 2
+          maxItems: 2
 
         interrupt-names:
-          items:
-            - const: ch_int
-            - const: g_int
+          minItems: 2
+          maxItems: 2
 
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
@@ -171,16 +202,6 @@ allOf:
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


