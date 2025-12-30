Return-Path: <linux-can+bounces-5967-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B28E2CE99AC
	for <lists+linux-can@lfdr.de>; Tue, 30 Dec 2025 12:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8140F3038998
	for <lists+linux-can@lfdr.de>; Tue, 30 Dec 2025 11:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556CB2EBB99;
	Tue, 30 Dec 2025 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/XtL65W"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8C52EAD0D
	for <linux-can@vger.kernel.org>; Tue, 30 Dec 2025 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767095903; cv=none; b=SrIsM9BcKU4bbFDtjc/K5ICNmcEj+Ba4x706eHdJpLTZNOaDSbxWKksdUgvvoveORLlpIC9WsH6y1wGhXnIkQYJw7gcKUQPqB32mDeEqRnZB4OVgFYeuwcsmc4TpaXSiC21lZiq5hZjwQa+s7jAx+FVTmv9wOf1lBI7Qxhj7Gdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767095903; c=relaxed/simple;
	bh=RInXvReQ5POy4FMimtb0C34m5vk5/lbK61lYfvbonc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AF7XQEz3haF8pVWW8QFFY02+ZNzlnz3zAzufRZJu37Ggi0102F/t5tUfon55xJao5PvFfj1weEGKd4AZEOpp6Rx+by8gLt6/aB8hvLFLvB2MgdDDMOaFQAYLnyiJtGfUoC7eOVp5QiENs8Wsq4zTcrTM7oSRZ2qMlT4BC1VxQjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/XtL65W; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-430f5ecaa08so4040578f8f.3
        for <linux-can@vger.kernel.org>; Tue, 30 Dec 2025 03:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767095899; x=1767700699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Md4LenoxLA0hBS+HLQnseJu4WXkBm6RSI6SGmptImzA=;
        b=g/XtL65Wrk1YyEy8FhOyDZuCLp9WEnIf9JQxsaN0aFdzPq6goH0Jys7EK4Ag1xMfX5
         8q39O5u8bZDL/eat0AFGHyGnIhBinSViDD4NGu8vT8YKQZbLE8LYgioA3KLHumg0pHao
         qZF99dBhIyVDxHVUFHeiOX63BDQ56D14I9N7S4nW7ledAo40b/BEPPquJkuvOEqbr0KT
         J7KWvQ2V1QkZPiSQCWjdByVhDHYUGceDGViTpD2e+xnvAn1u5nZAw9NQj8x7qPd9mprh
         VHaBVJZ4KCuYrisSHqgUHJuJLAerb8s13O5ev2gvhxjE9d2xCq3aJ5NV9k6ptCOpcb6Z
         YpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767095899; x=1767700699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Md4LenoxLA0hBS+HLQnseJu4WXkBm6RSI6SGmptImzA=;
        b=MZO5uyJtcN8KFeL4Z3XUA/kItVYzbNEnfl+w6zVQYN0C2yQ6KohX5NIpu3h+xGQ6KI
         zVdRN3Sc7oSdBMdMLYQKja3hfOarDrUhoXjekzsYAESVodrK8kJnKepUFcoZosCb85M3
         2N/iXbED90W0LqDoeFKP50eqIlbBSlLlGBJ6Pl8W2+rPVo+M/SvOl5K9soabiccoZ5CL
         CYvXM3QnsFMRw1GqXzMsFZwgAVLr5JUXeUHlnweNpZlxsKagJAE/rE9XXvQM9Tb93bLN
         kmA6GKlovPIBdal5Na6aBABtiYM1IvAKPKTIS7rUTqdMA8NLQM4IM0jgXcHqNAhFrBZD
         siNw==
X-Gm-Message-State: AOJu0Yxjs7qrUqlGrUZmEs4DxPnFovy5nkvNIeZmg90WtKb3SLwmF+Pv
	SBSv9d7RzDzcyIaYgPgXImUg5SCla13JUGlO60dwTtefsmhPhZxomAc5
X-Gm-Gg: AY/fxX4zo4Mjr++TbLWsc/HzEnAoyc68LdOj1K+sk47mouPF7h/WHOM3xK8sR4dQzkK
	bAkvsx3zsP0kfkRLlXVaeagishVleBc+vlcPapd/tX65V1zwlx9Z/nKf3ZnJW9ELd4oLA4LUmz9
	boDJh7z5SKIfFIje6Xa5HHN5FB3zyW0S7+e4oaqCsByQZgjkknh4PVQNQ8MwVaUn/Y8GE4ApsU+
	feYBzflgbvn4fIEN6K1xuWX+4Y1e0ivCRnznOVGup76/UDLogiOkaxqLTlvZ/NtOcxNJPw/CVBo
	9L47+8NtR/pA+n9U133xdss+9P9ggK1LEU2GEBGUFsK/eYRTjihWeOXrr4TKgzbTtQQEGWZnW1K
	5FlnHI6EP1fjUPar3wc7LPZBf1k44Vd9ErqTE6CpT0e9vFEmjFWqTqV2kCiJjI+Hddq7H7Hx/OS
	KjS6KPoAI9hjOCl7h9QxnUnGTqMl9e8ttVIlNvufgK1t8dL53JjSGeelEHcj6YzVm52WSPc+Kbm
	6xCgh//xXfAjYuOXvOjTfR0
X-Google-Smtp-Source: AGHT+IHtSz/WiusYFxkiAPspdPu38Bl3h2tcnJLHp2a1T6hYQPtR4Q1Zp/41Eow1xjcXx5s6xxYVCw==
X-Received: by 2002:a05:6000:22c3:b0:431:67d:53b3 with SMTP id ffacd0b85a97d-4324e50bb1dmr35616083f8f.43.1767095899416;
        Tue, 30 Dec 2025 03:58:19 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:efaa:981e:926e:8957])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa64cesm68337227f8f.35.2025.12.30.03.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 03:58:18 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 3/4] dt-bindings: can: renesas,rcar-canfd: Document RZ/T2H and RZ/N2H SoCs
Date: Tue, 30 Dec 2025 11:58:13 +0000
Message-ID: <20251230115814.53536-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230115814.53536-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251230115814.53536-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- No changes made.
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index fb709cfd26d7..4a83e9e34d67 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -50,6 +50,12 @@ properties:
               - renesas,r9a09g057-canfd     # RZ/V2H(P)
           - const: renesas,r9a09g047-canfd
 
+      - const: renesas,r9a09g077-canfd      # RZ/T2H
+
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
@@ -243,11 +248,30 @@ allOf:
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


