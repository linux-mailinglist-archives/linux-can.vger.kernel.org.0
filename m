Return-Path: <linux-can+bounces-2955-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F19A444A8
	for <lists+linux-can@lfdr.de>; Tue, 25 Feb 2025 16:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1890219C44B5
	for <lists+linux-can@lfdr.de>; Tue, 25 Feb 2025 15:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587EE1624D4;
	Tue, 25 Feb 2025 15:41:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B2021ABA8;
	Tue, 25 Feb 2025 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498085; cv=none; b=SBS/ocx7iFnm8ZAwN7928fpkSGiuCiwmke7NZgjZTZvHCYEbF7NZRCnnSJ1wzctkzAyZvd90RUQGkEpOXXA/9uy1Oo8fOn4FHRlHiKp1q45bEEKVuejfZ6Cr0inyNZPnj1mZZYbfkq8HUS/GymnepaYFJw5KErvtg3l83ZaQbTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498085; c=relaxed/simple;
	bh=LW0Rhq4PUETFJEN7AbXiab6GKyf7a35ifjnGRCKKCDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9EYv+q87DMBAK3qezACMrMp9gOKb7OnIhELXAK3dZqVCmX47414YiaAOQRiWBCiAcHMxtTXeIRNb16g4cG+3PUK+pg6g7MMkw+JkRFZ3rYygR2Z2g1MmziK7YTIgoFvv3DGiC5nskjEoEMaNAaKOdTEOFFZxxjWTWcNOi4Nnpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: afUaY0A/SOK/wW7K0/oDjA==
X-CSE-MsgGUID: vhl/wG0yRByHqekWtbMXkA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 26 Feb 2025 00:41:15 +0900
Received: from localhost.localdomain (unknown [10.226.92.81])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4D844400FD08;
	Wed, 26 Feb 2025 00:41:11 +0900 (JST)
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
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 02/11] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3E support
Date: Tue, 25 Feb 2025 15:40:41 +0000
Message-ID: <20250225154058.59116-3-biju.das.jz@bp.renesas.com>
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

Document support for the CAN-FD Interface on the RZ/G3E (R9A09G047) SoC,
which supports up to six channels.

The CAN-FD module on RZ/G3E is very similar to the one on both R-Car V4H
and RZ/G2L, but differs in some hardware parameters:
 * No external clock, but instead has ram clock.
 * Support up to 6 channels.
 * 20 interrupts.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Replaced maxItems->minItems: 20 for RZ/G3E interrupt,s as the list has 20
   elements and for existing platforms dropped minItems and keep maxItems: 8.
v1->v2:
 * No change.
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 69 +++++++++++++++++--
 1 file changed, 62 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index f87f90f431e5..47967e944710 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -42,6 +42,8 @@ properties:
               - renesas,r9a07g054-canfd    # RZ/V2L
           - const: renesas,rzg2l-canfd     # RZ/G2L family
 
+      - const: renesas,r9a09g047-canfd     # RZ/G3E
+
   reg:
     maxItems: 1
 
@@ -59,6 +61,19 @@ properties:
           - description: CAN1 error interrupt
           - description: CAN1 transmit interrupt
           - description: CAN1 transmit/receive FIFO receive completion interrupt
+          - description: CAN2 error interrupt
+          - description: CAN2 transmit interrupt
+          - description: CAN2 transmit/receive FIFO receive completion interrupt
+          - description: CAN3 error interrupt
+          - description: CAN3 transmit interrupt
+          - description: CAN3 transmit/receive FIFO receive completion interrupt
+          - description: CAN4 error interrupt
+          - description: CAN4 transmit interrupt
+          - description: CAN4 transmit/receive FIFO receive completion interrupt
+          - description: CAN5 error interrupt
+          - description: CAN5 transmit interrupt
+          - description: CAN5 transmit/receive FIFO receive completion interrupt
+        minItems: 8
 
   interrupt-names:
     oneOf:
@@ -74,15 +89,33 @@ properties:
           - const: ch1_err
           - const: ch1_rec
           - const: ch1_trx
+          - const: ch2_err
+          - const: ch2_rec
+          - const: ch2_trx
+          - const: ch3_err
+          - const: ch3_rec
+          - const: ch3_trx
+          - const: ch4_err
+          - const: ch4_rec
+          - const: ch4_trx
+          - const: ch5_err
+          - const: ch5_rec
+          - const: ch5_trx
+        minItems: 8
 
   clocks:
     maxItems: 3
 
   clock-names:
-    items:
-      - const: fck
-      - const: canfd
-      - const: can_clk
+    oneOf:
+      - items:
+          - const: fck
+          - const: canfd
+          - const: can_clk
+      - items:
+          - const: fck
+          - const: ram_clk
+          - const: can_clk
 
   power-domains:
     maxItems: 1
@@ -145,11 +178,9 @@ allOf:
     then:
       properties:
         interrupts:
-          minItems: 8
           maxItems: 8
 
         interrupt-names:
-          minItems: 8
           maxItems: 8
 
   - if:
@@ -173,7 +204,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,rzg2l-canfd
+            enum:
+              - renesas,r9a09g047-canfd
+              - renesas,rzg2l-canfd
     then:
       properties:
         resets:
@@ -187,6 +220,19 @@ allOf:
       required:
         - reset-names
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g047-canfd
+    then:
+      properties:
+        interrupts:
+          minItems: 20
+
+        interrupt-names:
+          minItems: 20
+
   - if:
       properties:
         compatible:
@@ -219,6 +265,15 @@ allOf:
       patternProperties:
         "^channel[4-7]$": false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g047-canfd
+    then:
+      patternProperties:
+        "^channel[6-7]$": false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.0


