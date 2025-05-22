Return-Path: <linux-can+bounces-3640-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 202F1AC0759
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 10:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7E918869B5
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 08:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72805283147;
	Thu, 22 May 2025 08:41:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C224D2629D
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903298; cv=none; b=mmlM38P/xdrI7xAvs92yz5qI2iqPDYFZQyn+0ToHsKWp0eFTBh1kimvRiHHBE2bpD86I3efjcM3s9v7HzwuSY8sN9US5BNbIj9SFHdD8B9662bluSbeskOfZoV8p1SKX/YY/fiJnXT9w1+GTYnd7v823557Xag9gsERpoa+xw4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903298; c=relaxed/simple;
	bh=g8TUYGTWqHdgtTadw9zYYnsmUxz5Gxgy1DiJ16NN724=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJM3juu43kKj5xCc2GV3WTtWGT9pCLih4kcbMb/P+87MdeG2dtzLQeUpDcne4MOxA39WjpPVrdZAcDd4hbHkPYSU7pZHbiN2Wft1Y7gju7xQ2O5V1a/ZkxY1U8MzVQMclS59M6KXB7Rjq7BpshA6v/hH6cQMOvPTY+HK3XsLr1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1Ud-0005zh-03
	for linux-can@vger.kernel.org; Thu, 22 May 2025 10:41:35 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1Uc-000hiK-1n
	for linux-can@vger.kernel.org;
	Thu, 22 May 2025 10:41:34 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 3BBAD4172C3
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:41:34 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id D52B64172A2;
	Thu, 22 May 2025 08:41:31 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 51371b62;
	Thu, 22 May 2025 08:41:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Biju Das <biju.das.jz@bp.renesas.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 02/22] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3E support
Date: Thu, 22 May 2025 10:36:30 +0200
Message-ID: <20250522084128.501049-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522084128.501049-1-mkl@pengutronix.de>
References: <20250522084128.501049-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Biju Das <biju.das.jz@bp.renesas.com>

Document support for the CAN-FD Interface on the RZ/G3E (R9A09G047) SoC,
which supports up to six channels.

The CAN-FD module on RZ/G3E is very similar to the one on both R-Car V4H
and RZ/G2L, but differs in some hardware parameters:
 * No external clock, but instead has ram clock.
 * Support up to 6 channels.
 * 20 interrupts.

Reviewed-by: "Rob Herring (Arm)" <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250417054320.14100-3-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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
2.47.2



