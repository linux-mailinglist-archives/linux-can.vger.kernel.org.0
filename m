Return-Path: <linux-can+bounces-6147-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 309DED1FE9D
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 16:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9115D305442B
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 15:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5458B3A0E87;
	Wed, 14 Jan 2026 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnyuGnhc"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2399C3A0B23
	for <linux-can@vger.kernel.org>; Wed, 14 Jan 2026 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405533; cv=none; b=W0bLfceVuuj+JXGcJIDEQp3DGnQrXMwtdValY3hfG41uGUShBEcU9ot2766YOkGCPWQ5jugGjdqeJdgOvW9EzO3GVPo2Nx3OW4r+ZUqSUH44SxWLR+CSrWHedHxhsxrFDQH5q1wihUH1BtKJd+sQdiHN84Cek06yRhANvXpxVUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405533; c=relaxed/simple;
	bh=qSCl/eFcYORT2xOr9C9aVf5NIUqIXDn3ZLWt6rVQW6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cetr5jUUTCkg8+Ew5N8Dt99wWhY19tYmK3XfTiN87ColpQOwIB4PdNMQXHKp5gU63gaI8e/IUZfphA4ko6jutY/yI8HTwaMigtwZUp1gdJIaoBew3U3qtpYdOH3X7j+16NZlJ3aVWTeyU25vcDy19UlGOP/zbNC1rn3DbozZfyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnyuGnhc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ee974e230so2054505e9.2
        for <linux-can@vger.kernel.org>; Wed, 14 Jan 2026 07:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768405529; x=1769010329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omQbD76IKfBCNHbl78X1AUCJmtxXa2tDPyRYxCm9lbY=;
        b=JnyuGnhcSed2xRu1S3JeNU1nRgEMKTPvZDoUo2nV8qO6U9dioZD6IiBg9MB4o6NteT
         ekhZIhyeDyr7neBgPE+xnXH7rVZw8AO7JO2dUYFeHhn63VqM+MAGIa+z/0LXI3VWc+C+
         3cO0Eo705kyFrhaWdMfmLJsB/p6TZiHSn7QXNZGDv71p6nU8734TjG4I4CgnKP5DiYwM
         6UcsXaNyU+IMXeijlqW+rKPMapdfdyjgE2sVuYp0KXzPl8avHD+WxKxUR0QPZN5QL0y7
         XcmjHWQF9gtWqXEvW1lljcarvVZSh3QWfJcST+jXVe5UzU3E9ZxNioX+RpyrhYutKdfL
         u5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768405529; x=1769010329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=omQbD76IKfBCNHbl78X1AUCJmtxXa2tDPyRYxCm9lbY=;
        b=IAE/EaIduKvpW9F10Ua2REk+0hEHU30v4jXqeBf/lmniC/z/XPNVofiWA3C/9cPw6Q
         HwtCUtOTjYnukK6053PkOLXL2+6PT+FdjcwsuL+qwhLfQHeOpq3C+601EBLmj6laTEBr
         FXe9jTuYVdKtDJvW33SW5nzKBbxRugWhZ7Q58/VOCitFb2xam7OzE6l5PyXP+tNGgiGs
         2kZN12Bd/5gP4Z0bblb5N0vdQzMVqVgexdJ3JC2rdSXEJmMhCdPbO0CgHJrVQqVEmXRG
         X3Hi4n8yGOBYlh9zaTdKA1Dvy6q7ao1rH8XbY1e4OI/8OscxoOGQ5wMUbJGKlGW4pxOV
         KHGg==
X-Forwarded-Encrypted: i=1; AJvYcCX+ZjpOYdtR3gfOo853E32xO97fkHF5pWMWxm96kiWETpI4Z5MHA6UnA2vKLuzTXsi5LYSrLzUeQKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5SuN0iTcSPrIl1TrXixuSvSy4/m6ikC16a/rjAkTrf+AstlIm
	mYdliY2yElqnxfRXfPdo21i1JiYJS4WsGylR5yR0M7Hxsh2jAnnZKdtB
X-Gm-Gg: AY/fxX7NAEDeYUvVGIlRKbERKCFNn/jt7cznXUWHKUb7nmXg2gVrDxsGjgy7pXjxgrL
	OIM2njVGVnCphx+4rtOiYqp02H3mhJ8VYH5C60dQ6yLrjFVyxSiIQztPkCghPPhTXGivKynfrWk
	B7lY4cEpsRqqO+ZLdhrLrId2i+nokdU4iupSZ35rQJW6IHUJuMhndckvXVBO+p8ANX8wl+BOvjF
	OcUDKzXNyNZFqXJSeICaPW1MDQ8lx0tIYMSpLDvOh6u5Szw2ptak1YfIl2PD8cG6DDUIRR/0EEb
	1gKHSulkvcrdc0lVIC1hFrRdQYhkAl3UJmsfcvrDWMyvfxTfLobWY1qLW1VfpftIruG4opa5BMu
	vreoki/NdRS7fHKLahoMrHLD3iA1Mch4N5JeMuUKnchpr6VogeC/MRd98gfFPvJ8awJ3AoEazab
	XIQIKb7htMArvQFRXi8EOUe62T51PB1sDB3vMCcef176Bra9tZT8Dgwoe53LZELAaQC9QdfxiQM
	FnhLz3tanNr3ajL2v3jddbK
X-Received: by 2002:a05:600c:3586:b0:470:fe3c:a3b7 with SMTP id 5b1f17b1804b1-47ee32e0d5amr39228465e9.5.1768405529026;
        Wed, 14 Jan 2026 07:45:29 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:7f20:df14:ac2b:3d74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee544387fsm33867105e9.0.2026.01.14.07.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:45:28 -0800 (PST)
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
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 1/4] dt-bindings: can: renesas,rcar-canfd: Specify reset-names
Date: Wed, 14 Jan 2026 15:45:22 +0000
Message-ID: <20260114154525.3169992-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Specify the expected reset-names for the Renesas CAN-FD controller on
RZ/G2L and RZ/G3E SoCs.

The reset names rstp_n and rstc_n are defined in the SoC hardware manual
and are already used by the driver since commit 76e9353a80e9 ("can:
rcar_canfd: Add support for RZ/G2L family"). The reset-names property
existed previously but was dropped by commit 466c8ef7b66b ("dt-bindings:
can: renesas,rcar-canfd: Simplify the conditional schema").

Restore and constrain reset-names in the binding so DT schema checks
match the actual hardware requirements and driver expectations.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
v3->v4:
- Added Reviewed-by tag.

v2->v3:
- Updated commit message to clarify that reset-names existed previously
  but was dropped.

v1->v2:
- Moved reset-names to top-level properties.
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 33 +++++++++++--------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index e129bdceef84..9bfd4f44e4d4 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -122,6 +122,11 @@ properties:
 
   resets: true
 
+  reset-names:
+    items:
+      - const: rstp_n
+      - const: rstc_n
+
   renesas,no-can-fd:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
@@ -195,13 +200,6 @@ allOf:
           minItems: 2
           maxItems: 2
 
-        reset-names:
-          minItems: 2
-          maxItems: 2
-
-      required:
-        - reset-names
-
   - if:
       properties:
         compatible:
@@ -239,13 +237,6 @@ allOf:
           minItems: 2
           maxItems: 2
 
-        reset-names:
-          minItems: 2
-          maxItems: 2
-
-      required:
-        - reset-names
-
   - if:
       properties:
         compatible:
@@ -299,6 +290,20 @@ allOf:
       properties:
         renesas,no-can-fd: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a09g047-canfd
+              - renesas,rzg2l-canfd
+    then:
+      required:
+        - reset-names
+    else:
+      properties:
+        reset-names: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.52.0


