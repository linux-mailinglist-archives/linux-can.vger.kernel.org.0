Return-Path: <linux-can+bounces-1099-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE404944D58
	for <lists+linux-can@lfdr.de>; Thu,  1 Aug 2024 15:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1045E1C22CDB
	for <lists+linux-can@lfdr.de>; Thu,  1 Aug 2024 13:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091441A255A;
	Thu,  1 Aug 2024 13:41:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0DE1A38C1
	for <linux-can@vger.kernel.org>; Thu,  1 Aug 2024 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722519712; cv=none; b=LoYtPUXo5Sfg40Iqi9K1pAzdhqzX+hsxzZ1wAfCJ/e3E2QODxLPTN/WYBjZZHf7fxDJ5jRkgOd84+I9S3zyOxieIB5MuYdhTJri58nqWX3SJFeImqYPyEtQ85Kgtal4WtkLnZqmGNOdOVu2/VRGxVIimtvC7F+SS3ngiV2iok90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722519712; c=relaxed/simple;
	bh=2pBooiMpVZcLBbSFYVW0Xm0PsJcpq1lqLkpVUrdr49Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XjCqDT9EgpW4/2+Y4tFnvLNDir7Becr6iHQdiaS+/OE9wrvrr5vSuwCEwJI76TnlH1Wo7wdQlsTt/x7YhX3tDx9NLR14Fy/sKtaYzjH5hO8Q+W6y5wEwcedDHXIyFtldaoihbL9mkA8Opbd4uDXNRFYCRz7lm4WIivw3NZLtOMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:fff7:d11a:41d8:a195])
	by andre.telenet-ops.be with bizsmtp
	id udhb2C00W5XJrhx01dhbHr; Thu, 01 Aug 2024 15:41:42 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sZW3L-004S6w-Jn;
	Thu, 01 Aug 2024 15:41:35 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sZW3j-00HO83-OF;
	Thu, 01 Aug 2024 15:41:35 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] dt-bindings: can: renesas,rcar-canfd: Document R-Car V4M support
Date: Thu,  1 Aug 2024 15:41:34 +0200
Message-Id: <2c40290b3948ef1b9a5fa2e38794dc95ed3b2fd4.1722519580.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Duy Nguyen <duy.nguyen.rh@renesas.com>

Document support for the CAN-FD Interface on the Renesas R-Car V4M
(R8A779H0) SoC, which supports up to four channels.

Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Drop RFC state now it works.

Changes compared to the BSP:
  - Restrict number of channels to four.
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index d3f45d29fa0a550a..7c5ac5d2e880bbb8 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -32,6 +32,7 @@ properties:
           - enum:
               - renesas,r8a779a0-canfd     # R-Car V3U
               - renesas,r8a779g0-canfd     # R-Car V4H
+              - renesas,r8a779h0-canfd     # R-Car V4M
           - const: renesas,rcar-gen4-canfd # R-Car Gen4
 
       - items:
@@ -163,14 +164,23 @@ allOf:
           maxItems: 1
 
   - if:
-      not:
-        properties:
-          compatible:
-            contains:
-              const: renesas,rcar-gen4-canfd
+      properties:
+        compatible:
+          contains:
+            const: renesas,r8a779h0-canfd
     then:
       patternProperties:
-        "^channel[2-7]$": false
+        "^channel[5-7]$": false
+    else:
+      if:
+        not:
+          properties:
+            compatible:
+              contains:
+                const: renesas,rcar-gen4-canfd
+      then:
+        patternProperties:
+          "^channel[2-7]$": false
 
 unevaluatedProperties: false
 
-- 
2.34.1


