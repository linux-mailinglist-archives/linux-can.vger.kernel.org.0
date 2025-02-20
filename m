Return-Path: <linux-can+bounces-2898-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43182A3DAC8
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 14:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00182179A72
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 13:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045B41F76B9;
	Thu, 20 Feb 2025 13:04:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3781F76B5;
	Thu, 20 Feb 2025 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056688; cv=none; b=UWCbYnD1keghIAzQqGaVJTIeEKQCJbeGsV1ZzQVfUaotyESSoVWxpvcZK1rkFQGt9Lt/cwa1wHyiLXLjKuRistxjmcaaK+auaCkxknwkejhNz179hdk2eYkzCKPjYWVdUyb+vDyb6+koabLA2DtmgzIWVLtXn3MfVSAhXDyj+Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056688; c=relaxed/simple;
	bh=MJDckZ0T+HwzpSqe4utVaHsghh+7mIeyiZRErV9rYdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIACfwb53fqyJYDov4G3L3aFBSTsgs3oDWEUQ/nqtgwn17ezl7zZguNyu/coaAtY+Fnxy3syYUrzssIwGrVxpzFt/w+dDf0/OIDxKDGLK9HhwgCnNO5U6Oz9/RLHOUcrE2c857P82Sb21+jAjAPQa4ZF1ttK3F1lwoBxDW/ZwQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: aUXqi2ZZQay0RlVTPlzRMA==
X-CSE-MsgGUID: IC36kelaTqSMmuPFBUDFLA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Feb 2025 22:04:45 +0900
Received: from localhost.localdomain (unknown [10.226.92.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 089B042B36D6;
	Thu, 20 Feb 2025 22:04:40 +0900 (JST)
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
Subject: [PATCH v2 2/7] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3E support
Date: Thu, 20 Feb 2025 13:04:18 +0000
Message-ID: <20250220130427.217342-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220130427.217342-1-biju.das.jz@bp.renesas.com>
References: <20250220130427.217342-1-biju.das.jz@bp.renesas.com>
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
v1->v2:
 * No change.
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 67 +++++++++++++++++--
 1 file changed, 62 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index f87f90f431e5..189d5303ad75 100644
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
@@ -173,7 +206,9 @@ allOf:
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
@@ -187,6 +222,19 @@ allOf:
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
+          maxItems: 20
+
+        interrupt-names:
+          maxItems: 20
+
   - if:
       properties:
         compatible:
@@ -219,6 +267,15 @@ allOf:
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


