Return-Path: <linux-can+bounces-2863-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9B1A3BCEC
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 12:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C471737EC
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 11:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533561DFE14;
	Wed, 19 Feb 2025 11:34:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764051DEFE6
	for <linux-can@vger.kernel.org>; Wed, 19 Feb 2025 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964846; cv=none; b=JUIxFM7FJLWW0nj8fZQLZgMpScDNYF82hgwHZbApNUzPl7vEBpeDeKvwoViQbOmIDzrjbTIqcX7PX3AitJCy4jpPl4NGQY1zDbteYI9IoMrvuDx+fbiUFi1fX5KKz2qlqPnyMH1LSpgQixnylusABBDRFb5R7ZsAEdzzhxLK1bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964846; c=relaxed/simple;
	bh=HT6CsS8luzjPnt1nhjiuXGHfhXcg6eq3KYVgkI9K0pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYhfKLOlIQcBBCMDa9h6w2ZpLn851rI9nj7ugaZTdiZRa4ncpX+umzMv++WtIsKllQD4AFBYDGU8FGoBGnwn2QT/XH4VErh+AL9kkH80YF+y/pCy5MbXvf7CylkkzjcuNUvqzyKH4qU4jNHpW7qqKBvufm8B5y/FcH6PGP+tKUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkiL4-0001Z7-Es
	for linux-can@vger.kernel.org; Wed, 19 Feb 2025 12:34:02 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkiL2-001l18-22
	for linux-can@vger.kernel.org;
	Wed, 19 Feb 2025 12:34:00 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 475023C692A
	for <linux-can@vger.kernel.org>; Wed, 19 Feb 2025 11:34:00 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 5CA723C68DD;
	Wed, 19 Feb 2025 11:33:57 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1c916773;
	Wed, 19 Feb 2025 11:33:56 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 05/12] dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC support
Date: Wed, 19 Feb 2025 12:21:10 +0100
Message-ID: <20250219113354.529611-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250219113354.529611-1-mkl@pengutronix.de>
References: <20250219113354.529611-1-mkl@pengutronix.de>
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

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add S32G2/S32G3 SoCs compatible strings.

A particularity for these SoCs is the presence of separate interrupts for
state change, bus errors, MBs 0-7 and MBs 8-127 respectively.

Increase maxItems of 'interrupts' to 4 for S32G based SoCs and keep the
same restriction for other SoCs.

Also, as part of this commit, move the 'allOf' after the required
properties to make the documentation easier to read.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20250113120704.522307-2-ciprianmarian.costea@oss.nxp.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../bindings/net/can/fsl,flexcan.yaml         | 44 +++++++++++++++++--
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index 97dd1a7c5ed2..73252fe56fe6 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -10,9 +10,6 @@ title:
 maintainers:
   - Marc Kleine-Budde <mkl@pengutronix.de>
 
-allOf:
-  - $ref: can-controller.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -28,6 +25,7 @@ properties:
           - fsl,vf610-flexcan
           - fsl,ls1021ar2-flexcan
           - fsl,lx2160ar1-flexcan
+          - nxp,s32g2-flexcan
       - items:
           - enum:
               - fsl,imx53-flexcan
@@ -43,12 +41,21 @@ properties:
           - enum:
               - fsl,ls1028ar1-flexcan
           - const: fsl,lx2160ar1-flexcan
+      - items:
+          - enum:
+              - nxp,s32g3-flexcan
+          - const: nxp,s32g2-flexcan
 
   reg:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 4
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 4
 
   clocks:
     maxItems: 2
@@ -136,6 +143,35 @@ required:
   - reg
   - interrupts
 
+allOf:
+  - $ref: can-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,s32g2-flexcan
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: Message Buffer interrupt for mailboxes 0-7 and Enhanced RX FIFO
+            - description: Device state change
+            - description: Bus Error detection
+            - description: Message Buffer interrupt for mailboxes 8-127
+        interrupt-names:
+          items:
+            - const: mb-0
+            - const: state
+            - const: berr
+            - const: mb-1
+      required:
+        - interrupt-names
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+        interrupt-names: false
+
 additionalProperties: false
 
 examples:
-- 
2.47.2



