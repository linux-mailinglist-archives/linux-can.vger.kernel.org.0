Return-Path: <linux-can+bounces-6149-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F00D7D1FEF7
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 16:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A73323079EFF
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 15:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE43121ABD7;
	Wed, 14 Jan 2026 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJRSYN38"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593EC3A0E89
	for <linux-can@vger.kernel.org>; Wed, 14 Jan 2026 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405535; cv=none; b=aPpUBcttuVf9qGdm0Y0VmbsF5q0s0mi6p+SXDcSNiB13DzJ7O4V0uq3jvY22HbfljwyFZuVReZ1bJrIOJT0osY0KuS2Rir9fVK5AQJErFEBbdd6h32kxtKFHjeA1b21vFDau61Ho7En/wSZJUMHLc4046TG7k/uHcbzk/A9LNok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405535; c=relaxed/simple;
	bh=NcSIh13nkfl2o/fHyJPuPnsmYgeObjMEWYBabqP7Z/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmQHuBSEqtxzObsRFtX6++JcMoOdUUuT179rOycoCNJC9vigblcZ2fiWfRAbgWoVlOYohaDFe2nvgaPj/MXzwxmXhQUG/1t8ToYrLlZaBXtBxHAAWym+72rBoOsYfKOG+dwlNmr3rHDo4HX7GdSydRRr00qSp02Mzer99OyDNiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJRSYN38; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47796a837c7so60506535e9.0
        for <linux-can@vger.kernel.org>; Wed, 14 Jan 2026 07:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768405531; x=1769010331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGNBX9HKq6etY9Yk1wwPNkxG5bUhI9J7ur5YibrY+sU=;
        b=DJRSYN38Z0H0u0K5L3fUbxwSxOLlJjMFJBcgRsQFOxZf2TLgBWgM4m86vkR+W+Jd9/
         YVgFiwg1VxbUWtSdGEuwktI8CUU+pKwwNGtyeMXvL1jc+ffodlrA4vcHqFKPEkp+xdZ0
         PzW348DAGzLpi8Mrc3nWLQjgtRGHhOAnp3GwgZWljPZYRQjvDEIDA25l3ilwbgJGzh8b
         uqy4Vr7dca0DSKoi77GeODxkSyMBU4yHFZhhdmnmToAp3YjsivuEv4a6uYPajZjGLzE4
         rprKPVE3FCguk9aFNsFU9KLtcrdtls+OhKl8SeDmx6F/eBDxVEroN65V1oUhhFbw5JIS
         zQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768405531; x=1769010331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JGNBX9HKq6etY9Yk1wwPNkxG5bUhI9J7ur5YibrY+sU=;
        b=QgugHLsNPZj4McjixhZBbxE9l5Bfbr7pG/Mt/kASJa7cbBHKo5hiSzT0DtA60d/b0t
         YncTU0rUZ0LVaG6JwKhW23Mbbte10IcvLuzlm3AiiLsIhT4iNj8mkOpcdeagwGLBHJxR
         p7j4ZzfQriu4Vo0x0YZlgW/njdkiUT6rNtkOabHRP1DgbDAxX20LnTdRT6e5y2n7VzyN
         vHhtdY6AitlOgDemhRxuK/jglUVMW+yeg5uBkoEW0oqmNpmNkj629mlcsYWh+O8mJWzA
         kciKabIIYFXx5IvP2oeSL+rk9JLAt6tDcRAt+xcA3UTO8NYT2nM4zgWHDwvZMXYl8dTd
         hrvg==
X-Forwarded-Encrypted: i=1; AJvYcCWKyz7JIMHxHqyR8ef8TtgPNIsWG2peZ75LnU1waRl3mwoak2fWykTuvBIF0EqFsHpOhA6iewdQfLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze6JDxbgQtN3C6KghawUSQW7fXRXtKjlK6G0Qzqo6pt2d4BBae
	1BcpNDiDhc2NbrDuEW6indJVft51agQm4oXIl3pFwp0uj99CwkRUT/Oo
X-Gm-Gg: AY/fxX4/0xlP0RH080fuau2vhWpsRdThioYifpA/eyaD68MVULWtJ0SLrFy//+IhaRA
	bGupSoS/p2BylaeHHSWj2KME3II+LwVDZyH4fPlmDOKYsOXh6puxuWZJsycsxJwFroNqbIy8MSW
	skv5lQrXMtnt2FozMBCHRoGbYgOxPE9IVqNyMxhoBMqE6ucuW+5Ngsw7WFIw0JIZ/gIhStNbLoW
	SaU3khwRbsEFFQwoB3UN77NVfG3OLJOV5JB1TU6jTFpYGL/sTbiZ3x9IJ14klakJqR/kFpeFWaI
	med66CMpqTUCwHGZjG2k/Y5FLKDjKeP8DVPG+J2kj8np3bzPWbntaVeCXHIQVJI/NCz2i9G7NL4
	3fS6HOwppE3jgHK1oJI1+nsbvOLy6rwhevWQ8YZGLzdo+vOJRgfueFb/tJ+oCrd7xq/7kFXHxOm
	927pKtQ8vdasSijOYH36cS3DX92Xv/yTf4BXmIdZB2eZrj7CIB9zjDmGsWqYZbjtQzO6nAmAtpH
	1Q9evYgP6x5LIa28lOuLGaR
X-Received: by 2002:a05:600c:5490:b0:479:3876:22a8 with SMTP id 5b1f17b1804b1-47ee3356d5dmr45061685e9.16.1768405531444;
        Wed, 14 Jan 2026 07:45:31 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:7f20:df14:ac2b:3d74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee544387fsm33867105e9.0.2026.01.14.07.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:45:30 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 3/4] dt-bindings: can: renesas,rcar-canfd: Document RZ/T2H and RZ/N2H SoCs
Date: Wed, 14 Jan 2026 15:45:24 +0000
Message-ID: <20260114154525.3169992-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114154525.3169992-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260114154525.3169992-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document the CAN-FD controller used on the RZ/T2H and RZ/N2H SoCs. The
CAN-FD IP is largely compatible with the R-Car Gen4 block, but differs
in that AFLPN and CFTML are different, there is no reset line for the IP,
and it only supports two channels.

Sync the resets and reset-names schema handling with other CAN-FD SoCs so
DT validation stays consistent and maintainable.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4:
- Dropped Reviewed-by from Geert due to below changes.
- Updated commit message.
- Moved single compatible entries into an enum and to below oneOf.
- Synced the resets/reset-names handling with other similar SoCs.

v2->v3:
- Grouped single compatible entries into an enum.
- Updated commit message about disallowing reset-names property.
- Added Reviewed-by tag.

v1->v2:
- No changes made.
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 48 +++++++++++++++++--
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index fb709cfd26d7..b9d9dd7a7967 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -12,6 +12,10 @@ maintainers:
 properties:
   compatible:
     oneOf:
+      - enum:
+          - renesas,r9a09g047-canfd        # RZ/G3E
+          - renesas,r9a09g077-canfd        # RZ/T2H
+
       - items:
           - enum:
               - renesas,r8a774a1-canfd     # RZ/G2M
@@ -42,14 +46,16 @@ properties:
               - renesas,r9a07g054-canfd    # RZ/V2L
           - const: renesas,rzg2l-canfd     # RZ/G2L family
 
-      - const: renesas,r9a09g047-canfd     # RZ/G3E
-
       - items:
           - enum:
               - renesas,r9a09g056-canfd     # RZ/V2N
               - renesas,r9a09g057-canfd     # RZ/V2H(P)
           - const: renesas,r9a09g047-canfd
 
+      - items:
+          - const: renesas,r9a09g087-canfd  # RZ/N2H
+          - const: renesas,r9a09g077-canfd
+
   reg:
     maxItems: 1
 
@@ -179,7 +185,6 @@ required:
   - clocks
   - clock-names
   - power-domains
-  - resets
   - assigned-clocks
   - assigned-clock-rates
   - channel0
@@ -243,11 +248,25 @@ allOf:
           minItems: 2
           maxItems: 2
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g077-canfd
+    then:
+      properties:
+        interrupts:
+          maxItems: 8
+
+        interrupt-names:
+          maxItems: 8
+
   - if:
       properties:
         compatible:
           contains:
             enum:
+              - renesas,r9a09g077-canfd
               - renesas,rcar-gen3-canfd
               - renesas,rzg2l-canfd
     then:
@@ -296,6 +315,16 @@ allOf:
       properties:
         renesas,no-can-fd: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g077-canfd
+    then:
+      properties:
+        resets: false
+        reset-names: false
+
   - if:
       properties:
         compatible:
@@ -305,8 +334,19 @@ allOf:
               - renesas,rzg2l-canfd
     then:
       required:
+        - resets
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
+      required:
+        - resets
       properties:
         reset-names: false
 
-- 
2.52.0


