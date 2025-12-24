Return-Path: <linux-can+bounces-5932-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA18FCDCF08
	for <lists+linux-can@lfdr.de>; Wed, 24 Dec 2025 18:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60CD03033710
	for <lists+linux-can@lfdr.de>; Wed, 24 Dec 2025 17:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9D03242DD;
	Wed, 24 Dec 2025 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AH5eAVkQ"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8410D30E0C8
	for <linux-can@vger.kernel.org>; Wed, 24 Dec 2025 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766597614; cv=none; b=u3gPxHM+FUg2FTSphxDTG/dkWebFPQjmIkae5Q6JDDdrE1iMRhbaKgMTCCZCyqa/VD1eFdhBqr4fFKHTTXYepf6pdhO/fKIJofB6oNynByM3Ml7/8ysqBj12RWWtYXFmvq0oJQKJEj1nwHV59Ij/SfzkWEwgEXOMpeUL6Xshxzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766597614; c=relaxed/simple;
	bh=biwc+waTczafG61aaaV8/vWNdTrADi/Xff+npzKS4DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7Xiu2MTDebqVJYnNeTjIRTWGHVVy70DzDSZBou83XhZA+NKKF1eZO85CaoEJythe8EHZudj9+2Xk7SmDs9dMdPHHpKH+PTi8ZLh1fKeVDKKNVWSFuckkGNTHkLavztk6lZp1xvg6yo4ScOBWR+4xxh6jqFRF9p+pz+vARA7/WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AH5eAVkQ; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-477632b0621so38626905e9.2
        for <linux-can@vger.kernel.org>; Wed, 24 Dec 2025 09:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766597611; x=1767202411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rO1DWQbDcCKw25L+IPKi/eW3gvZHQ6BcPZc0m3O8u5M=;
        b=AH5eAVkQSgJf2yKPIdT+EtEWJOqzBhYQCuH2QhhVAiZiUCJ0LFTdpV2muVBbq98bHs
         fGyKBaDFAp8ZEvh6uSvyW4PoU+Wz4wJRv5l1CM9NlGrwuqJnk7t5U1WqEQ/g0UeokJr2
         YSakxSajKwnfuEWiX5PngjDKJ3ZKfJCH1TLRG5V9iolgZxhCYRJFiIiz1Oypm/xnx1H3
         i8iX0kr3tDc9rJp2L4I6VdauyR17ltKGlqBtldAWBRGpQofmvft6JuzfjqWGgFr60vLg
         1N2iYKg/ZeoEyL9gGkO4Yxh0TmSwxk3aNk1J+CheHn1+4e9JJj7WCB4+pQkwVk50aSJy
         //xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766597611; x=1767202411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rO1DWQbDcCKw25L+IPKi/eW3gvZHQ6BcPZc0m3O8u5M=;
        b=ZekVQmcgHIz4SlH/CQfx7+0gvBrU5T+Ah/Boab7/pf355j3mS0bnbj4QsQEeAxG9w6
         Gtnt93xvU+MUBN5M/TZatZM3l/ZuWgh3QqjDcHetssFkjKCMtRQwkalTfySvA0+P24xq
         KBOzj1rXesf5sJ+713fcYK2cec0jhfwLuKi/DRrVR3hQTTYC9BaOzmc+JOXdayyLt/ay
         iewt83PlkcAjnajBWuKL/0B2SmOwAwc3nv4NZNfeon629+5zUbHTsERI/l7lWJI0nJ68
         3Hb6lQ6HRPOoM0uy8EAVawcA1UHFPxwDUsLreI3hmneSjNTUAqY/S9Uw14r51YCf97k4
         G/zw==
X-Gm-Message-State: AOJu0YxPnNryZu309yC8qTANO+ZjekfnZC+hrhzW+Iyqz3h/dPmCK4kO
	KXVP0wxxloy0/baU6BI2Q/Vi2D1M58Gi2a6xdJSjuvzah3Oe2qJB2ewz
X-Gm-Gg: AY/fxX7I8sFZXxMiaRPss1An5vsouyaNL/p5WdL/rMQD5fLHBWOTagcMCuxasMuQEVY
	eTDuGUWW4Cm+SkrZl54HH2Tg5xZXpKqtEdkdvQHl2l9zivOIwiGaCqxrDvDe3A4Bz/kqYccdHhC
	zZHylcU0eareloJw2rgCrNGpMbbJlEONFaiNpA2dwkXm4b3aKToFbplFbrKW7nqnbDbIAwwqfi4
	Y9zrFRIFBShO1MVw629yIDViMp8aQbF5lvULF4lCbZRozAUs1JUXPD9+Mm+/W3hEK1c3Yz3fZqa
	8Q6KHNJdMNNEzP+b4XPkCE9jxTHQad55WKyuXS9Gv+rfdWFMOQzeEkUDae+izDDzqFJLEyCV8kt
	XJvzGHHqmb17bJ8DSDXukHH0lWSwFGxQhYO2uIJpek8w3wzeuL35j/p8FUFIRnoH+psPdPZKP6S
	R8Q1+BHEw7CFTi470dRJcq7h/RvDKXZ5OykA2gn9NjiwkcVt1Xc2EQbXi7+MRPR5Kz0RnYE2bX2
	e+TDkFI36IUvryZbz+6z9qX
X-Google-Smtp-Source: AGHT+IFQYICYTEeiM1pVNXlzsYjx1yAlvPgwTWBQmCxByGu2qRELn6JVsKCopH1giSEOGeVSvRkIag==
X-Received: by 2002:a05:6000:22c8:b0:431:104:6db2 with SMTP id ffacd0b85a97d-4324e4c7440mr19728193f8f.3.1766597610741;
        Wed, 24 Dec 2025 09:33:30 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:3371:7b65:aaf4:d2e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1af20sm33237553f8f.2.2025.12.24.09.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 09:33:30 -0800 (PST)
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
Subject: [PATCH 2/4] dt-bindings: can: renesas,rcar-canfd: Document RZ/V2H(P) and RZ/V2N SoCs
Date: Wed, 24 Dec 2025 17:33:22 +0000
Message-ID: <20251224173324.3393675-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224173324.3393675-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251224173324.3393675-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document CANFD IP found on the Renesas RZ/V2H(P) (R9A09G057) and RZ/V2N
(R9A09G056) SoCs. The CANFD IP on these SoCs are identical to that found
on the RZ/G3E (R9A09G047) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/net/can/renesas,rcar-canfd.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index dab79dffef4b..393b0a15c7b3 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -44,6 +44,12 @@ properties:
 
       - const: renesas,r9a09g047-canfd     # RZ/G3E
 
+      - items:
+          - enum:
+              - renesas,r9a09g056-canfd     # RZ/V2N
+              - renesas,r9a09g057-canfd     # RZ/V2H(P)
+          - const: renesas,r9a09g047-canfd
+
   reg:
     maxItems: 1
 
-- 
2.52.0


