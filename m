Return-Path: <linux-can+bounces-3215-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0A1A71669
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 13:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F543A76B6
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 12:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E791E1C2B;
	Wed, 26 Mar 2025 12:20:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42281CB9E2;
	Wed, 26 Mar 2025 12:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991626; cv=none; b=EOzGugqy/05lMSO+nTZtLw6b4CZ0mYpYRwQAUSe4tYujZXVRHE7pLPMGEvM/wT7gS85/ohee92yXx6bwxiKKJdAr9c2U2ndVRvj36x12Rm5ns+61rcITvUOUpgwMONYvvieJtoq4rvCYCCRxTCUHoXSUFJreOvbNdXtWm6LpIGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991626; c=relaxed/simple;
	bh=uB96c8FVSanIDqgW9dypHZSlVs4aD9u/ihR0qGBBQts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ufCsV9wxI/KNGruz5huFSD/BZV2GA85BmcYlIr647sQJwh7GKpHby/68hyA7wjBfe8xLQh9R3XYN35YUFGXopLWdQ3Xl985ZV19A2ym7BsF0OcVIWq+/dt7S2eKGAlpA3X+xUTr03WZsf1fu+sZNwP2pQTNPeyDJDUw0xMCc5l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: vu1Ti2sOTSu+FQqdpGlo4g==
X-CSE-MsgGUID: /uOEKz12TKaHkHhCTgD6cA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 26 Mar 2025 21:20:22 +0900
Received: from localhost.localdomain (unknown [10.226.92.116])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B163440104FA;
	Wed, 26 Mar 2025 21:20:17 +0900 (JST)
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
Subject: [PATCH v7 02/18] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3E support
Date: Wed, 26 Mar 2025 12:19:37 +0000
Message-ID: <20250326122003.122976-3-biju.das.jz@bp.renesas.com>
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

Document support for the CAN-FD Interface on the RZ/G3E (R9A09G047) SoC,
which supports up to six channels.

The CAN-FD module on RZ/G3E is very similar to the one on both R-Car V4H
and RZ/G2L, but differs in some hardware parameters:
 * No external clock, but instead has ram clock.
 * Support up to 6 channels.
 * 20 interrupts.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v6->v7:
 * No change.
v5->v6:
 * No change.
v4->v5:
 * Keeping interrupts and resets together allows to keep a clear
   separation between RZ/G2L and RZ/G3E, at the expense of only
   a single line.
 * Retained the tags as it is trivial change.
v3->v4:
 * Added Rb tag from Rob.
v2->v3:
 * Replaced maxItems->minItems: 20 for RZ/G3E interrupt,s as the list has 20
   elements and for existing platforms dropped minItems and keep maxItems: 8.
v1->v2:
 * No change.
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 76 +++++++++++++++++--
 1 file changed, 70 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index 4a83498b2a8b..f4ac21c68427 100644
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
 
         resets:
@@ -183,6 +214,30 @@ allOf:
         resets:
           maxItems: 1
 
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
+        resets:
+          minItems: 2
+          maxItems: 2
+
+        reset-names:
+          minItems: 2
+          maxItems: 2
+
+      required:
+        - reset-names
+
   - if:
       properties:
         compatible:
@@ -203,6 +258,15 @@ allOf:
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


