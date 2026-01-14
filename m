Return-Path: <linux-can+bounces-6148-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DA8D1FECA
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 16:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF43E3022004
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 15:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C243A0B23;
	Wed, 14 Jan 2026 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQay9AKd"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEF03A0B35
	for <linux-can@vger.kernel.org>; Wed, 14 Jan 2026 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405534; cv=none; b=HXBr+fSZkhiS//nwqaC+1J1PwekGyF60q/HebsinTcM1w7g1dZLDdGlgWRhOXM7T9E5Lt+XdiVjZhbS6C/g54YY4f5x1tyRoeYKZXy9Zn0QypWXDlmDhW0OB/kocIsj8HaCagUaX6BAQjXR7+th6MGqifIjjIhpQ92T/qjRIMrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405534; c=relaxed/simple;
	bh=BeaGFvCEUNXGuH6KMXUttkAC8B37iG/MIp121wnhoII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOox0XVQkqLZT8gXrb6LMNuVnbx36Dv9N8GiAk6+CcZiHPv12U1ja/dKqkKmQrMOhSS1eFM2/ejvqHIG+opcqTTxUc7Z58PLGr3tijs1GtpZbf+C4vvgzc2Eh10BZLAVP8h1sXzCKxsXC64jPoMSLmzikMcCiG2Z8ZtL8JQb6lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQay9AKd; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-47d63594f7eso53652455e9.0
        for <linux-can@vger.kernel.org>; Wed, 14 Jan 2026 07:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768405530; x=1769010330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WgHhzWTacwK5LZn1+KNAfXyou7fks/IWFiJfss6To0=;
        b=eQay9AKdhwXIXEydvBrxGaonobdeMbxwRZYmpAIWtt6ObeZgJgRDZYkWJe2GPc41sV
         3Yg0xV5989ggKt/dREkt8bwQSw8vCAywbimIlaM/aqYNAYH6RQqyrFZBfzXFxVS51RDk
         qpPM2evWqrNt/Ur6cEuQR4971jJprfsKuQ8b3HcweZdGVnuzShfYKQQ2bDjZwqPadTpi
         hRiHLWC8U+Ah1mUtn71UzEcu53nxCBsS4E9whHjw/jOScUZDhVRYjWvBn/rsBJtTAIBj
         +o8h0ty9JrNpUammeCRLw9V8jhZRxoAthxL1YseNrFcCoZ3YjwnyTInLnbSsV/cEJbml
         knKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768405530; x=1769010330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3WgHhzWTacwK5LZn1+KNAfXyou7fks/IWFiJfss6To0=;
        b=jCuMss09MONKLO2sOYRY5FqfcZYO4NuAa0BkpXynglnAEKHtFbN5MwPZJAW5knvPHK
         FX0l5lv17wjlck1WPeQSiUPUlxX2lurWgWkmaLb2zx8+8zGgtvD8+hweo59/yw90kO14
         yLWkQoeigKJMpCe75/WsZj2Y55jhHVMClVAxgxth7GTPuAogU/LEkeaLHH4bEM5B/f7U
         WY0jkWHoGmJFEOnZL8AfUDKap+RnEGQBjLLAxG/v9B+BMHd3wNhVUIXgdqRpbpBt5eCI
         3Moj1IhoMsKdI8NxLHMlFoxVfSJaUixO6PX1Oz8dA5zJ1ib0XMozkMg9y95zcuLxcTmy
         4gSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDJyU/YpgMQCuVYXOzn4AoNFzkalN+d/EBtzB3u921W9hY4RAclp80nBQWUrhdB8EyJea+WMdESJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzBGVdGud791n+gAUR4+X0KjDgJon765BzwSWcthd+d2y7OfAT
	6OmK/8f0nHlyddVtX8GY9f/+z5foCwGU6rgMTx1ZhtBNXIcjxkkkRAZL
X-Gm-Gg: AY/fxX7x5v1PpQPKSVOvGa77d4y/nVnkZ6rjKfFvGW6qt06QU8t3Yzj8TAJzmA4fFZI
	SODoPuqtLY2wGo9ye4y1bXB2Npt7IssiYmQ5CoHacCnxIcFN9eGN3z5BRTcQ6nB7Q+QQEqFS643
	SMO4kIS7i6yjNQuaxukBw9MUgFahEquueFqSn2HMNT8PNCFaXzEONvhY5NBrUMUeQKxd8goUVEM
	EBFQJYN25msQIM7VvFI5sM5T4OwPYUHABeJDJES5uZ2dZEsKjXFYxY5HF+DemU0crWZWnJ2q4aq
	JrOTJ4d7etZp5tb24dXMUBHBJ39agAhkU94L55FJuOXb6BNmja2TqUJLe1zGu8nNtY4ifrdKVNL
	RvqEDRY3jch20WOpbNJLUFnNuKNjVsmXe8JESiV+oetlaHX3Orc9BhrGiDR7c2dA3wf/ATb5Neh
	6TWR2j2LAdxSdDvi61OtFXdrUVK3Rklc8e6p8KAub3t/RRZlCcxRVL1r/JbT3buYTc6EdL2nI9I
	8o0SE+G3lghE1zPKKYxKGff
X-Received: by 2002:a05:600c:3e8d:b0:47d:6c69:bf28 with SMTP id 5b1f17b1804b1-47ee481cf37mr30807625e9.24.1768405530249;
        Wed, 14 Jan 2026 07:45:30 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:7f20:df14:ac2b:3d74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee544387fsm33867105e9.0.2026.01.14.07.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:45:29 -0800 (PST)
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
Subject: [PATCH v4 2/4] dt-bindings: can: renesas,rcar-canfd: Document RZ/V2H(P) and RZ/V2N SoCs
Date: Wed, 14 Jan 2026 15:45:23 +0000
Message-ID: <20260114154525.3169992-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Document CANFD IP found on the Renesas RZ/V2H(P) (R9A09G057) and RZ/V2N
(R9A09G056) SoCs. The CANFD IP on these SoCs are identical to that found
on the RZ/G3E (R9A09G047) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3->v4:
- No changes made.

v2->v3:
- Added Acked-by and Reviewed-by tags.

v1->v2:
- No changes made.
---
 .../devicetree/bindings/net/can/renesas,rcar-canfd.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index 9bfd4f44e4d4..fb709cfd26d7 100644
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


