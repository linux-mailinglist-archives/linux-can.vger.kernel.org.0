Return-Path: <linux-can+bounces-2504-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C9C9FDB06
	for <lists+linux-can@lfdr.de>; Sat, 28 Dec 2024 16:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8783A1338
	for <lists+linux-can@lfdr.de>; Sat, 28 Dec 2024 15:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D430615A86B;
	Sat, 28 Dec 2024 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cFBfZGGx"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FB2524F
	for <linux-can@vger.kernel.org>; Sat, 28 Dec 2024 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735398050; cv=none; b=ejT4+2+WRUba9eISlXQA89dcm203FY3pO1o9+JoayKgTTXRm3bP6q5M78iU/Rol3P8a8Vq/FTrzb8Bh+/9VxIcDmpaX03Dw4eYlR0nA2aH1UjY2Zac9LnmWBptZfC8PVXsHKEu0drXyHoINTMrBYpvJ2yw30Uj/UOBciu7l0qTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735398050; c=relaxed/simple;
	bh=HZrKwGABFp+Ogm7GxQAoxAVc1kEUcbISp+LEihPxfA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oG0kWuQraD0faLdx8Gal0e33vDlrzTfX+cX4inI/FjjJMyIobPJVKpdaiiJxcVS5WAGYGGKfN6xseW409BlN99gp6xRK08Yvjf0PvOBxvcM9t/2jRa2EpecFEW4z3q6NcycoJ0zXe4s0A5NK0f7gaMAX0aR7ho3Y1G7myr8pZ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=cFBfZGGx; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa66e4d1d5aso1284053466b.2
        for <linux-can@vger.kernel.org>; Sat, 28 Dec 2024 07:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1735398047; x=1736002847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zGjy0+pcVkOcyNsRikjnUlsDE+kBpL3hB1hR4GAE8IQ=;
        b=cFBfZGGxihfMqlXsouwHtLnHtMxmLrJVUW17TQL60AWH1hgjWmp+GEtvozFBJ92zFV
         3bZANHW/dHX497kdYmQzSTa4JdipKSrsw4t8OZEz8d1cq/ZNoOPgWpcTSXiQwWqOcPn/
         16BMnZID3thXKyrV4sgyNsuQ8jiAPrv4AOcIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735398047; x=1736002847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGjy0+pcVkOcyNsRikjnUlsDE+kBpL3hB1hR4GAE8IQ=;
        b=KQhh0915OIRczRuCKLskUqH+0T8F0SZ83sD3ThC2+R37po8bGdgI1YH6s93YYCwv3Z
         tu5nPRPpwcLoJyQumiVj1IfDx274/891Gfy1UtZuoc98eEmBnZIN3GPfYS06b5Ixf3G0
         O8afuuU8ZVPsroMHehar8rSNg7hx3ZNLgi9WPK/Py0CYPIA6ATNQioWrpjK6DPfD816X
         ywUcyLJ5IjOKfx6tQSamacsOvZiPyyQ1KT1nVwVYbCURhEmyQtDh1qJEkHWY0A/SynY9
         9/uEYxR3wosaP8Fr/xMqa3hzf6E7q7yYtOLJDEMLCh6n+W69sreolnW1GF7G1WTri6By
         Ymag==
X-Forwarded-Encrypted: i=1; AJvYcCWXmFuFCXeR0rgPenljqBoAQcvRQFBiTYFB/110LaKu3IrfeE6Mq0j1foth67OMUZq1EBqBxsuE9OY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdwLwtxzMlgdjJBdkINrl6huhyAvyj845qYnXxdQwKJpJVm15+
	RknS8kGixEMrv7j9SkJ3ZkqTJEszhlFz8ETyEtYBZ/AbHgvsrlP1//5qmAIi3gQ=
X-Gm-Gg: ASbGncvb+jMFXIjI1AmOzShhvo36M9xnZy6GH1nGVaZxj9xciHC6eEUUtoQUZTx5PPm
	8rh/DUc2F2Bx/SZXk7POw/0dVLpMl2pHLfOIpve4X2qksDfGANX+pYVpdZ5dJaqM19zJhvhaXLK
	6An+qWNQlP1eBSKLXt9E8gcx31eL/hZhYcB67XDVengyQiU6R+VckM7dohUr6IWKdpb6iznCvqA
	ifCE5QamHeA+JVQc9ioVgbXMCDXy30EMsiHgmo0prop3KbYNKMFWkA4ImgcvhaAsN6vc9/8hWxK
	81zWNomjwuzmCTGKprAYZQ==
X-Google-Smtp-Source: AGHT+IGn+STomeh91UKdY7nI+qTGSbWPadCuY71lDdmY/fsFuuR1EUm5XjU/DazYxX+1lVKGryxiiw==
X-Received: by 2002:a17:907:9621:b0:aa6:6f92:74b1 with SMTP id a640c23a62f3a-aac2ad7fa01mr2850887066b.13.1735398046567;
        Sat, 28 Dec 2024 07:00:46 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.43.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e89514esm1258974666b.74.2024.12.28.07.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 07:00:46 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-can@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] dt-bindings: can: st,stm32-bxcan: fix st,gcan property type
Date: Sat, 28 Dec 2024 16:00:30 +0100
Message-ID: <20241228150043.3926696-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SRAM memory shared pointed to by the st,gcan property is unique, so
we don't need an array of phandles.

Fixes: e43250c0ac81 ("dt-bindings: net: can: add STM32 bxcan DT bindings")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 Documentation/devicetree/bindings/net/can/st,stm32-bxcan.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/st,stm32-bxcan.yaml b/Documentation/devicetree/bindings/net/can/st,stm32-bxcan.yaml
index de1d4298893b..c7510b00954a 100644
--- a/Documentation/devicetree/bindings/net/can/st,stm32-bxcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/st,stm32-bxcan.yaml
@@ -63,7 +63,7 @@ properties:
     maxItems: 1
 
   st,gcan:
-    $ref: /schemas/types.yaml#/definitions/phandle-array
+    $ref: /schemas/types.yaml#/definitions/phandle
     description:
       The phandle to the gcan node which allows to access the 512-bytes
       SRAM memory shared by the two bxCAN cells (CAN1 primary and CAN2
-- 
2.43.0


