Return-Path: <linux-can+bounces-1100-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95645944D95
	for <lists+linux-can@lfdr.de>; Thu,  1 Aug 2024 16:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4313E282A89
	for <lists+linux-can@lfdr.de>; Thu,  1 Aug 2024 14:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9721A255A;
	Thu,  1 Aug 2024 14:03:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3907516DECD
	for <linux-can@vger.kernel.org>; Thu,  1 Aug 2024 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722521008; cv=none; b=pW7ZK6o3d38zCrM2WGu2nNqmv9hlW3ajyolbJGf0HsVHkY4qC5ePhFH413352POsw7v9oweHrBhw+9HhhjD0zzC4w+dYkzhkPK0FlKY51hOLJ7xYA9AshJ5fzwhT600Qx0HFrFFuRLOayBugNLrlQIn2JqlJLe6rBWKMf78Fbq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722521008; c=relaxed/simple;
	bh=4B5qeLnXbkiU9/+d8ETfOpEIsw0uhhnpcY7UwqgINbU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u++bWcX1oGYiF+ICAoWYE3+qSL8qvudSz6gexzrsVGIjmowIHesX+R9Tm8XFNbMpmJ4Wd1sbraphqgsQHt540xtcZqCMqlWA1iL4Yb8ICY8M46iYra2m3VjjYHSWxT/si1vJZyC4OUh1ISz6JSkTDBwvQYl+fyHyXTuJMI04pPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:fff7:d11a:41d8:a195])
	by michel.telenet-ops.be with bizsmtp
	id ue3J2C00d5XJrhx06e3KpT; Thu, 01 Aug 2024 16:03:25 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sZWOM-004SD5-LV;
	Thu, 01 Aug 2024 16:03:18 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sZWOk-00HOMB-Q8;
	Thu, 01 Aug 2024 16:03:18 +0200
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
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3] dt-bindings: can: renesas,rcar-canfd: Document R-Car V4M support
Date: Thu,  1 Aug 2024 16:03:17 +0200
Message-Id: <68b5f910bef89508e3455c768844ebe859d6ff1d.1722520779.git.geert+renesas@glider.be>
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

The CAN-FD module on R-Car V4M is very similar to the one on R-Car V4H,
but differs in some hardware parameters, as reflected by the Parameter
Status Information part of the Global IP Version Register.  However,
none of this parameterization should have any impact on the driver, as
the driver does not access any register that is impacted by the
parameterization (except for the number of channels).

Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
[geert: Clarify R-Car V4M differences]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Add more clarification,

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


