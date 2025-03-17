Return-Path: <linux-can+bounces-3120-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BCDA64F09
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 13:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1F1317256D
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 12:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6881723AE96;
	Mon, 17 Mar 2025 12:36:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D094B22FF39;
	Mon, 17 Mar 2025 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215001; cv=none; b=rieCKh1ljMBidhOj0qwc7nb+k52FQcrhtFgDLehsd42dwRhs7TpoJR6f74egMcAmzqZ2Z8EB4Wg3KhL8pK2oK/b+SDNUtRc1NVb/FK5fpq2eLhBxb8vycyEqqzvIPpWjCCo1eqI9wbJVzZ6nBHFumt7UK1KBvr/yWmrQAHs2uys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215001; c=relaxed/simple;
	bh=ShkuocuP3Jh+1GQQp+1v1MMl3Tmyr3WE8yRa0ap6LD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6nX6SoQBKoMeM+5PunSCKpPwZetykBRuhhpZljb6nThoMePKhqZkynG+bILUGel4IgF/yAHk3Z/GV/nZdbMuduN0EUwYgndvYn8peQM11xgrIg7v3w+kPSK5CstAiQzeYztkFZqsDj+SzhE2+1yWlCUk+q32fOPrQwI6Ho3QN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: B+s6/vQpTtuVQ+rYcE/TXQ==
X-CSE-MsgGUID: SerOScHGS8ukUWBI9xs9vg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Mar 2025 21:36:33 +0900
Received: from localhost.localdomain (unknown [10.226.92.84])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E3A43400262C;
	Mon, 17 Mar 2025 21:36:28 +0900 (JST)
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
Subject: [PATCH v5 01/16] dt-bindings: can: renesas,rcar-canfd: Simplify the conditional schema
Date: Mon, 17 Mar 2025 12:35:55 +0000
Message-ID: <20250317123619.70988-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317123619.70988-1-biju.das.jz@bp.renesas.com>
References: <20250317123619.70988-1-biju.das.jz@bp.renesas.com>
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
This patch depend upon [1]
[1] https://lore.kernel.org/all/20250220094516.126598-2-biju.das.jz@bp.renesas.com/

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


