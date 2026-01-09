Return-Path: <linux-can+bounces-6073-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 57198D0A2C2
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 14:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C84930FF810
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 12:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C85635CB61;
	Fri,  9 Jan 2026 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ht7w8WeB"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CC835BDCC
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963100; cv=none; b=LHiaKolK/jx6QPXcoqC6W4wmuclizM/d8/J6Gs7OMzZ+XdiRWee0Z+6wKnUbsCLNu3/QBFAgUorTXNnf2YbTljKXA5VrRDzgc9P/xMxyVuktlm3zA4khipVZ74lfs/sb6JscLIllceo2HYEPzwgUD+GCKb4rYFu8sS6WfPx+pEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963100; c=relaxed/simple;
	bh=mdno2Ya3sQZeoP+RW7phTV1gRDXjpniBxUAGE8Uwflo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TpcX/U7yu84qWrwU6WqkJd6VBhdqMIQFHNGTiJGnNr/7w/8zzgcZ08DGHrwPFzKE5ouYLQRISZu2jEXRUVuk6Axu+nYBql8MIAt+0muUY6qj3oLsTDy+dsvO+wCpg/baWfHLkBRf5/8/v0smGptWS5u0XcSOsK8wF0PNPh8gQ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ht7w8WeB; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-42fbad1fa90so3562673f8f.0
        for <linux-can@vger.kernel.org>; Fri, 09 Jan 2026 04:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767963094; x=1768567894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lI8vt7JQePdkONS+d96oec76ZepkNLDIDJmPL38SyBk=;
        b=Ht7w8WeBuXDOTOQTKX1H3f9nviOAzXao1AqE4e54RIMHyvroxeQC4sHjG1R6pE09ED
         QAEIhn9us7ArVL6AzFEBs6z3RmuEiz7MzjdRBaJ1iMISYjNiTenA075Uxf/SDnt28pa8
         Z57q/i6aIwAAV5vuXq1rb1RkHBInXNOsN01Lqqnpk5U1LsnJqdXA8mnT/DkptlqKVXAo
         pQmgb7GvmdHOnBOyn5gqu47KTezCshTbbzAA6QbGmtIQCB15TGlyav/aHmQj2N88rafX
         yRKJk/8F5eM/p3cDWrp3W6BxCrkFyULXMANEpYbXLErIS7ja7HjQo96qkvosC7JUYHHL
         9zag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963094; x=1768567894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lI8vt7JQePdkONS+d96oec76ZepkNLDIDJmPL38SyBk=;
        b=GBlfWLsYy619V4sOsPyg8XardMfByWFRtuCgv7HdsMfZC/T2VSIAaWUbEnCtdUpIqK
         nMgiyxk+aSlhiAUXFDfG7guYnBN40eLoqFT8wBLcWZGs6KXD3m64f61XG59zO1ed9IeN
         /UxFoB6CeB3JVcEm8LrQxJRA7mm7YYUhkp1Fg7PatVH72OWt2Cyltn0WIyTfCqgc/Y2D
         7R+BMxnVR2Dbbw3Ln5NPMwvCC4Vw0XeFqUzB1iRb27TvmM81byS7mYqtYSX6CHbn23YL
         KVG9O67pVvd0cmPVDOQq/522EyTMjl+11wtfuQankpA+ejyY/0JCY5F/FUgsyJuPZyoG
         tsQA==
X-Forwarded-Encrypted: i=1; AJvYcCU5d1bdGHUDh052+JWt6/JUT+LFpvXma6Vcurop+ZIBzVozG2goUr0lIl+8TrPNhpf/aZp252r+LDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YywW69QR968dMU/K9nqAkKL1LTGjRldN1wxwGdVYdLz9mTH2DII
	eZwwcejrtUvrHLXmXMSowqhQUZldCbKYL6U5XX1bYwKJTo7v/+uMndeI
X-Gm-Gg: AY/fxX4UX7iTwLJY3R6NxRuHhnxweeuLWLXwSxqICnUGls/hKlFlQ9pSs4r12JjJzjZ
	reY5giXhpT5fkdHfNg7ecEWoIldVdfDM3SBCgCXURizZJ340Han+Bt2KFn96V/LdY3zHMF887aC
	6hLLXZwSQZtmdDxQ/45KNyAmT1Vkrvb0BJ9GFR2ZbCKdDZcXF4zA582AamwT6QgKLpzNzLZuUOH
	jDFHgj5/KgFbOyquZSsWY+H1GuMRFr0FVj3G3Z/RhQ3aSeZFBXuzZtQnNKq/pbz/Qw5cUHAPdWO
	3fZvez+NDcxD+Tz9GCfprey35pY78gia+lDxvKTLmJWr+WeVLJekWjRPgbsavKX5RoorDjAFAlf
	p+WheTgIAjsBj5bwEuBRMUhGkRzCCOcxI7+EhNqrBAIoQLjODZwf8amcxg1wLktUDCKYwu3S+Mk
	DZiFL1EvEWjls4NhV3pnkBEeFE3g9YSwSF1of60KYe1nqPzst8XY8NTos4SpdO4NbJqgWbNuAKC
	OYfas0LwHMmnbJgEBjNzcc=
X-Google-Smtp-Source: AGHT+IF/7O5Iq7m4d5dep0sK3aoe67xeYJTSa6/XcblkLgnoej6Sz9hCZGU8qUaHUfLbI7DU/KTyeg==
X-Received: by 2002:a5d:64e7:0:b0:432:86f5:18a1 with SMTP id ffacd0b85a97d-432c363510fmr9939620f8f.0.1767963094406;
        Fri, 09 Jan 2026 04:51:34 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:3d06:ce2:401e:8cb8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dad8bsm22837291f8f.8.2026.01.09.04.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 04:51:33 -0800 (PST)
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
Subject: [PATCH v3 3/4] dt-bindings: can: renesas,rcar-canfd: Document RZ/T2H and RZ/N2H SoCs
Date: Fri,  9 Jan 2026 12:51:27 +0000
Message-ID: <20260109125128.2474156-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109125128.2474156-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260109125128.2474156-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

The schema already enforces reset-names only for RZ/G2L and RZ/G3E and
disallows it for all other SoCs, so only the resets property is explicitly
marked as unsupported for RZ/T2H and RZ/N2H.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2->v3:
- Grouped single compatible entries into an enum.
- Updated commit message about disallowing reset-names property.
- Added Reviewed-by tag.

v1->v2:
- No changes made.
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 29 +++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index fb709cfd26d7..ceb072e0a304 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -42,7 +42,10 @@ properties:
               - renesas,r9a07g054-canfd    # RZ/V2L
           - const: renesas,rzg2l-canfd     # RZ/G2L family
 
-      - const: renesas,r9a09g047-canfd     # RZ/G3E
+      - items:
+          - enum:
+              - renesas,r9a09g047-canfd    # RZ/G3E
+              - renesas,r9a09g077-canfd    # RZ/T2H
 
       - items:
           - enum:
@@ -50,6 +53,10 @@ properties:
               - renesas,r9a09g057-canfd     # RZ/V2H(P)
           - const: renesas,r9a09g047-canfd
 
+      - items:
+          - const: renesas,r9a09g087-canfd  # RZ/N2H
+          - const: renesas,r9a09g077-canfd
+
   reg:
     maxItems: 1
 
@@ -179,7 +186,6 @@ required:
   - clocks
   - clock-names
   - power-domains
-  - resets
   - assigned-clocks
   - assigned-clock-rates
   - channel0
@@ -243,11 +249,30 @@ allOf:
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
+        resets: false
+    else:
+      required:
+        - resets
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
-- 
2.52.0


