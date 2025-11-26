Return-Path: <linux-can+bounces-5714-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EF8C89A58
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 13:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7CA74E7B60
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 12:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E37A328252;
	Wed, 26 Nov 2025 12:01:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06A7326D77
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764158491; cv=none; b=EG1Auu7JTYGe9Z9uOPYEqcRTHlUbK7ZPgamCiA0QYuXfiUh6xk5mP7B0rsWYH/UukR/QvMEW7hd2ae+gKNw9TEk08iNsBMWAs5tsxQFjX9gwsaF9nbrAeIxF29QkVIySEjSP/xwHVzGPfD+5/r1z5GNgPJfzDAtuxiNoN8isdsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764158491; c=relaxed/simple;
	bh=AhjR1cEo1gE0trlX3twvkLMByno0fGOIVuMG2lixDR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOvdsiZ7gqAHeV0Th6cdm1Sfh1YQioqwUd/JycqqCHeEREwIglT8B4OJO5MvtNsYO5gH/YnbX3MGYvMWSwIZvUeayEn4h8yWseimHNzfE6WJ2PxQ2JzfOxfGB5nbFOL6vewnoKio7aeqbMlmFybsgAo1OevX2ev5XPA42RY8hUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOECu-0004VB-Vo; Wed, 26 Nov 2025 13:01:12 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOECt-002bFX-1B;
	Wed, 26 Nov 2025 13:01:11 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 24B894A8AA6;
	Wed, 26 Nov 2025 12:01:11 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 27/27] dt-bindings: can: mpfs: document resets
Date: Wed, 26 Nov 2025 12:57:16 +0100
Message-ID: <20251126120106.154635-28-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126120106.154635-1-mkl@pengutronix.de>
References: <20251126120106.154635-1-mkl@pengutronix.de>
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

From: Conor Dooley <conor.dooley@microchip.com>

The CAN cores on Polarfire SoC both have a reset. The platform firmware
brings both cores out of reset, but the linux driver must use them
during normal operation. The resets should have been made required, but
this is one of the things that can happen when the binding is written
without driver support.

Fixes: c878d518d7b6 ("dt-bindings: can: mpfs: document the mpfs CAN controller")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Link: https://patch.msgid.link/20251121-sample-footsore-743d81772efc@spud
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../devicetree/bindings/net/can/microchip,mpfs-can.yaml      | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
index 1219c5cb601f..519a11fbe972 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
+++ b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
@@ -32,11 +32,15 @@ properties:
       - description: AHB peripheral clock
       - description: CAN bus clock
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
   - interrupts
   - clocks
+  - resets
 
 additionalProperties: false
 
@@ -46,6 +50,7 @@ examples:
         compatible = "microchip,mpfs-can";
         reg = <0x2010c000 0x1000>;
         clocks = <&clkcfg 17>, <&clkcfg 37>;
+        resets = <&clkcfg 17>;
         interrupt-parent = <&plic>;
         interrupts = <56>;
     };
-- 
2.51.0


