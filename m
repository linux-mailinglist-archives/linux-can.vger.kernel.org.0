Return-Path: <linux-can+bounces-5730-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F7FC8AAFE
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 16:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 27559345E30
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 15:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D86233A02F;
	Wed, 26 Nov 2025 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvklJMK7"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4477D2FF169
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764171370; cv=none; b=T7Go++9Jz4oAaz5E6FXNQPf/ZMNMoZlyQ504NIuBzwl6i+oxJcXdlQDUuP75tfeqvdXvJG8ns4d0lP9Dn0JwUmYJ/dJvz5uHknV8gh7UBmXbJN+tIVh27kKATDUlY/4/uLI86C7IScp9+bBqCYzCRAb0iTETZT45AsdD3zUncA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764171370; c=relaxed/simple;
	bh=LlzzsLiv/t3fNeaCdKhq3FPYopoxNZ0lmuHTClS6u54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+EczNjd8EfFJTNjPvfEDF4jT4xMuLWXMhSrzTNCJYM2SbLxKNwMytU5EgE1OOouuR7wAt4RVXfFNrqTFHYcv1a+KO7nsUkO5KHyrBiODdaWTiPrvqoDrdKBXRcPGAT1v8oaYAVOaVflyUkWXRsE8TAebI6/L0GWzYCbzabR/tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvklJMK7; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429c48e05aeso595018f8f.1
        for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 07:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764171366; x=1764776166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEW5IUsnqhZHbo7o0lYoYpk+rA/ZSKOVlb3MFwI2MDY=;
        b=fvklJMK7d2kvzfwzUsfhCo+0nHZS+uyrjDWWu2qtyUo4jO5+8Vfx1XQhYlgVN0FOf7
         Ksq7SVvfmlm46VZnjpjgT3QN14OT194P8SsSoQW8kR1ETmqzDmTpz76W4tSk6fudBFQ2
         /3i9BrsXPWOH+urxQtR9oe9ThrY2AjjSHJ52x/8r/a27WEVFuESfH2/OulS27Ff9PBKR
         UXhp8l65RvRZT6pGd91J0CitUblu0FuK4ecBxOKwHlqt4jTpLpOlj87m4JpNDZVK7GaM
         G6hH7mVD/XYfnvbYNsp8wzwdrYidX85PE+PYuffXIg4TFPRpSYW7FAMxu6gpS6wRb5yZ
         vIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764171366; x=1764776166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qEW5IUsnqhZHbo7o0lYoYpk+rA/ZSKOVlb3MFwI2MDY=;
        b=gcye86oT0iW/fe9K6J/yL5x5wkrUj+Tw1iuKr4Y234MDV5xpENYNWN9wGDJ1J91vq1
         K7QCvtlepsVObv7Gf3R821X+Y/v0fRPtbSUEx2LJ1mN9l+IaFWKvIrDDSMaGjiNEoJpL
         t2kksRTz4j74I/3ss0aL3jtJJwzGNnV0oT2NDJbZrV7MkHuZbvwwhbXEji0DP2Kc3a2c
         lsgClloJUWmKGGsdjAk+u0FKW+Xvr4VqBc5wqGE576FKpUqvNaTc9wI2uyK0Di7zbSDV
         Z7kvL+LiL+b4o0SXBvfyB77yKgCxxhZ3eDOCuodobNVWeaTZlzsZJfv+a+C08Dxud9se
         uHmg==
X-Forwarded-Encrypted: i=1; AJvYcCWIhyTe1IJUmoVuZb+XxBjK5u3z7828ea6wPmPyPysEjGS74YlCDMqsgaNSNE1ZjvC4Q+v5t1hbMps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuUb0SSe0yLUDo+HvkLWf2ylGE0AtcL55ZuvfIdCI1BgfbawCM
	bGfsJQCOrc8OZL2n9F3GA+v083U1harba7Yht1qU7PEujlbOCNuCKJip
X-Gm-Gg: ASbGncvAsaCivndKA4eMI7itoCSXU8LI803483aco2TDsDbzn334rP48GlAUcwvw2Vb
	ZN7q7/FZ5aGOSgfA4M7WI5Opdu03g6eFRgMjCj+1XcT10y3FtYPfWUCbNpe7Wvxmh5W2vapu6DQ
	DIdb38Gp/njISJnHe60E62kz+VBmAHdq5sBDKDiSnD2Jsjcmvq85e8Cn1VSkYRqWSQVDM9taV0E
	VuVKMhxXyEm+VbcrAUO2OOZfaeVNW/0VlDbZJZ+xHVvgYFBQFwhGrDjMsVnFrcC1QH+aajUNScI
	Rs7UC6Uprc5ZbbYw/GkYLxvSi8eji/PWME2kbjNyPqY3me2HR+Yw/WqyA782XO+i9txJslah8x8
	yOdKC9SGnJWGylLOc4VYX081PapA83rSDSZ+Ck2kC3wh3GZhKNzUPb/lPamB6G22HEBUwr7XFhL
	Xk8bNywJJyO6Eh4vOUuKnAzsb5cpTAzCJEkbQMw9MBvkvZqQrijV8qFKuBuHAW673wlhGNL1Y=
X-Google-Smtp-Source: AGHT+IFXrjvffoT84+Zg18zteqdmNwbEWGyGZaxLoTKSfUQyOFdxLB2yLiTn24yxmWfgapFkO6mJsw==
X-Received: by 2002:a05:6000:1a8a:b0:42b:47ef:1d59 with SMTP id ffacd0b85a97d-42cba63b5b2mr28330678f8f.4.1764171366237;
        Wed, 26 Nov 2025 07:36:06 -0800 (PST)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e454sm41223775f8f.2.2025.11.26.07.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 07:36:06 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: can: renesas,rcar-canfd: Document renesas,fd-only property
Date: Wed, 26 Nov 2025 15:35:57 +0000
Message-ID: <20251126153603.312265-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251126153603.312265-1-biju.das.jz@bp.renesas.com>
References: <20251126153603.312265-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The CANFD on RZ/{G2L,G3E} and R-Car Gen4 support 3 modes FD-Only mode,
Classical CAN mode and CAN-FD mode. In FD-Only mode, communication in
Classical CAN frame format is disabled. Document renesas,fd-only to handle
this mode. As these SoCs support 3 modes, update the description of
renesas,no-can-fd property and disallow it for R-Car Gen3.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Added check to disallow the usage of both fd-only and no-can-fd.
v1->v2:
 * Added conditional check to disallow fd-only mode for R-Car Gen3.
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 74 ++++++++++++++++++-
 1 file changed, 71 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index f4ac21c68427..a504f94d0a20 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -125,9 +125,17 @@ properties:
   renesas,no-can-fd:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-      The controller can operate in either CAN FD only mode (default) or
-      Classical CAN only mode.  The mode is global to all channels.
-      Specify this property to put the controller in Classical CAN only mode.
+      The controller can operate in either CAN-FD mode (default) or FD-Only
+      mode (RZ/{G2L,G3E} and R-Car Gen4) or Classical CAN mode. Specify this
+      property to put the controller in Classical CAN mode.
+
+  renesas,fd-only:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The CANFD on RZ/{G2L,G3E} and R-Car Gen4 SoCs support 3 modes FD-Only
+      mode, Classical CAN mode and CAN-FD mode (default). In FD-Only mode,
+      communication in Classical CAN frame format is disabled. Specify this
+      property to put the controller in FD-Only mode.
 
   assigned-clocks:
     description:
@@ -267,6 +275,30 @@ allOf:
       patternProperties:
         "^channel[6-7]$": false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rcar-gen3-canfd
+    then:
+      properties:
+        renesas,fd-only: false
+
+  - if:
+      required:
+        - renesas,no-can-fd
+    then:
+      properties:
+        renesas,fd-only: false
+
+  - if:
+      required:
+        - renesas,fd-only
+    then:
+      properties:
+        renesas,no-can-fd: false
+
 unevaluatedProperties: false
 
 examples:
@@ -297,3 +329,39 @@ examples:
             channel1 {
             };
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/r9a07g044-cpg.h>
+
+    canfd1: can@10050000 {
+            compatible = "renesas,r9a07g044-canfd", "renesas,rzg2l-canfd";
+            reg = <0x10050000 0x8000>;
+            interrupts = <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "g_err", "g_recc",
+                              "ch0_err", "ch0_rec", "ch0_trx",
+                              "ch1_err", "ch1_rec", "ch1_trx";
+            clocks = <&cpg CPG_MOD R9A07G044_CANFD_PCLK>, <&cpg CPG_CORE R9A07G044_CLK_P0_DIV2>, <&can_clk>;
+            clock-names = "fck", "canfd", "can_clk";
+            assigned-clocks = <&cpg CPG_CORE R9A07G044_CLK_P0_DIV2>;
+            assigned-clock-rates = <50000000>;
+            resets = <&cpg R9A07G044_CANFD_RSTP_N>, <&cpg R9A07G044_CANFD_RSTC_N>;
+            reset-names = "rstp_n", "rstc_n";
+            power-domains = <&cpg>;
+            renesas,no-can-fd;
+            renesas,fd-only;
+
+            channel0 {
+            };
+
+            channel1 {
+            };
+    };
+
-- 
2.43.0


