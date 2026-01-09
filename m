Return-Path: <linux-can+bounces-6071-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BF4D0A476
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 14:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01F8031D00AD
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 12:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6941235BDD8;
	Fri,  9 Jan 2026 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCw4zvaG"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D39032BF21
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963096; cv=none; b=tm6v9lgQtaCAOR0gQxNyC3ZRO1idqEOJisWu1yOuLAIEIpGlI1ygp/p3QRMIfjfPN1nRA8KggmW4fKVUfieCRZNAhHaK0HBMrfi3mHFfU0U0Aqqk0oWqcS0E4OIQHHNJMDPhLNc/yBZRqxrO/OZbdupxkjiZcQBZFaK92B9puoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963096; c=relaxed/simple;
	bh=KXGqBVeDfc1rXLcLWdZTBpprFkeVcHDqelBR5sw6cAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5R6cLQCcymjKi1BouumHd6QDTAeVDH5WRGoi24v8Wdx9Vc3XICv4nO9hquIoRH3uPQLh7foyl+bQV8xYUGwxSfKX5m5cJIFOW9OXwzxb35NkVumcksm/F14gLPTQyzXbj/sUzHfUsjDe4bcAcorWs+PZfrP8BqK752IcUy6Dns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCw4zvaG; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-432755545fcso2455025f8f.1
        for <linux-can@vger.kernel.org>; Fri, 09 Jan 2026 04:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767963092; x=1768567892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZ8ldHFgmUWO4zWY+hyfBGsPb9cEVp/RZUQSRdJaZeM=;
        b=eCw4zvaGzXfjy1cSd/NCADteh9Xz89VD4GFSTLUBFOWPzymm/46VFe9sYp+IOud/A4
         Hhe/7/QyV+LfCYxwZl9pD6mlHgbpYBq20NnJtLffrIgofSQceMBATwl5a8Gq3yf5r7Bb
         hZY2NwqFEqJLMTqLz5ZnXQXM7aCMIBHCKqQlIzrezxSRVZThXeyBZzLR0hyoyklcsIn5
         SFWXiMmiJkAEM3JNX6qussOMDFc6rllj/b16zrUiF2hmI1QUXjSeh0h2oelaRbCK0Acu
         S8aEka1gWphGl4ASB9N1SxMT4zXbOxHQlqE8KQp+bN/3tWGBksIVuC8Gi1U5nIZReqn2
         5K7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963092; x=1768567892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HZ8ldHFgmUWO4zWY+hyfBGsPb9cEVp/RZUQSRdJaZeM=;
        b=EQGyjXsKqfr4c9lckkxSlcNZNN+2b5LlAJP+xbDRk8SrUIENElmPvsrGS54/LxI2X7
         gko+hGFXBMlbNY+7kcFmRccG8fqRfRy2qZKtFwmrqc3NZ7EJIXYZQH0Dtvx+H5ZY1GES
         WeydzyMnA/6cHkBrIbIdq+W6dDoJnXYfTxRO7EUKuGCI1mz18PADV7h0OGFTkweMd12R
         xBJy+I/VVckz9J4givh+DGdnZ2Iwfx6V7r9Pp74vwU1WXIx744RbJH+RzN4Vc0LbGp4k
         wn2HOf7/wCmV8nD/z/czdr3I+XOojZ6JH3Mgj1S8KFmhZHzeJrPYGxALvmFJbRgGZXNI
         zV8A==
X-Forwarded-Encrypted: i=1; AJvYcCV7usbo+wGTB27HLnCOH22Blu7O1kMHgmzzdxjeJRMKq1O6MVPsV4/68S/DMnTHueK9akNNfnl2Q6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU3/A8Pa3ivUdqc+yCbFUkYi0gkNtENJDC5pb1HJIwECom+bg6
	cvwhyk9/8uWpiPs+HHc/82rs8DAMz2ipQGwQM8I5ck8uBDY0yRXQUuGA
X-Gm-Gg: AY/fxX5WW43kTMr6yFcqEMlMmoq7wy8ot+KPbhroOI50+jk2bGOktghpTXzQKbGQwLm
	RPxCGEA2aiFanqie0sd+zCG60jcGtSal2gpxHLhti/Nimr8rPSGdVez7aHZwadX9oD/oA/1Q5Kj
	TubjFrC+/dkUMNBFs+hxWmYMZcqOScF7xM0hcvJU7p8jJfM6wbgTvelQz1NoyR9KOIsWfzrMdv5
	l1gBQiLfBVWanr4k5vOCzq/1EXIse41V+gSrDd5ncipHAeHNO7SJV6s+rGvGkNFe22zLvZPeuH6
	28Y+oabUNhqyPrq39hMuFgNuiKw4YL3p0Y9W5dlw7osMjJVvOi8iVUEm4+sVzR3L2Na72wx9JOm
	I0xeC+6ZnQTfkUwg6qXtV9665H/STQKI2NcG9Wl/CJQR+ZQLP+68Y0aCAeoBtWwPIDWac1MCHIg
	1wihNyx7HWX+H5uMgZHXBHlHb4kSfHHB4GihTWG1dAmkAlmIXgOTxI2BvAAYYL1ZGrJ0cJ8l0Sw
	IbpOF3rXLvERyxX5NkdUvI=
X-Google-Smtp-Source: AGHT+IF1YU8GQfwrL09JpkEGOkpzEtbYDZ/ByC9OxXozQGdu82LVM+4Te983M5es4cydtywpH83ryw==
X-Received: by 2002:a05:6000:26d3:b0:431:701:4a22 with SMTP id ffacd0b85a97d-432c36436b0mr11887198f8f.27.1767963092453;
        Fri, 09 Jan 2026 04:51:32 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:3d06:ce2:401e:8cb8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dad8bsm22837291f8f.8.2026.01.09.04.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 04:51:31 -0800 (PST)
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
Subject: [PATCH v3 1/4] dt-bindings: can: renesas,rcar-canfd: Specify reset-names
Date: Fri,  9 Jan 2026 12:51:25 +0000
Message-ID: <20260109125128.2474156-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
---
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


