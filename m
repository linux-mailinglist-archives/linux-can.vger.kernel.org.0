Return-Path: <linux-can+bounces-1170-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 179E194AF63
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 20:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2869283D78
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 18:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3584B13E02E;
	Wed,  7 Aug 2024 18:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4RlcGlO"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC8912BEBB;
	Wed,  7 Aug 2024 18:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054203; cv=none; b=FPQ/PS/XLGD6gurNlSAGqI9nccUBTfRAsZ842duJeaCEye0E+Bg7Ji5MtzfErI2+ci/10sfA4MIHPaTio8dnVQqAV6ECkGXjowERQereQR5/cQ3GuJF/SoGv/+D67pLGTlkJND4VHvzIU4AA19JnezbgM9YwSRBODhmIQi6HEEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054203; c=relaxed/simple;
	bh=B+oQ/WordNto0dzV1eaoJCasCSR6PvX5WTGkl3k+HSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CKa9r2oC8bVQvf84khncWLLwT33p7zIAPeRj5T4ZbUViT7qmbap8D/FoPBQZKFlvngv1/gKGpCXwyGRlpf+zr8KIjvDifTcpANytyHui6bmUcD3RGMmxUiMnEmlsc1nb4QoM5vc5uDdLDg83EYE//XSoeG4QUwpRyEX9xgS+354=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4RlcGlO; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-530e062217eso132501e87.1;
        Wed, 07 Aug 2024 11:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723054200; x=1723659000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuxEM8VZYz3rwPd3prNufQEQgMIp4xSelxjonO07Zgs=;
        b=V4RlcGlOwqD87/ZY8tTgHq1E5qrARRFGnrvlJPK3YbHeBqW2H2xfubsUJbwz8XJTTH
         VvFbyNbrxA50YPAuo09wP3+jge+50IBLvi4V/K/wiWndBXXfa+96UVqQlZKBSGQLHhlA
         ZUlGbgivUYUella3Lrgp5qgrL7VK+bIytmAQoZtFTKirEHveXsrMoUZC00EQagTcxez4
         /qvcUPl5PysQdNQ02xjScCAcCgdAoxoSxLjFOKR6wVAnZ/ctvIhLAbRZGYfXZijtuQZO
         PClQNidlW2cxtBmXqZG3AYASAZZ5vPuXsrilmwqvv/rkN5EIi+y3JXzrgixvjoNBL3c8
         wwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723054200; x=1723659000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuxEM8VZYz3rwPd3prNufQEQgMIp4xSelxjonO07Zgs=;
        b=rCXPNAug3k/VBHgTw1cTA6pYLRQImcLdOXxhiHmvCad3tpF3DHKPaMbpt+w0UqI7qX
         aBV/A6bFUoqbANdyi5uodRP9FLlDKTKeaQRfiyxNcZxgvXs2E8EHsj6NCY8Jj4qkMzAK
         5tUv+KMlmOJXnORf6KQ7I3ibMxjY/iAAWpTEZes/mSRal+q/Fqz9idXLFugHU4TrxsSf
         dX0pFUTAtUeAJDREKBdc6L18+DNurtXFFpgEP9QjknYXxaAHLwws/VkkAeN76IiA8qPx
         m8b9IoF13I7EkET3iCuaIXDqnqhWTPe4tr0dCWuSnYyRrq2B+Kk2MvuawCei7qDDSgMm
         76Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUzuHNG94XBU5BV1it5ssPL1qt2l//mMJ8Z4z8kuQLFwBO5knQK2Ev8CxffSYnJJIWr4GwCfgliAPXd8fyyjkJBxKbOasdVLGnYWw==
X-Gm-Message-State: AOJu0YyQMoGrGUr2V4SBfY9yojDT71PWMzSPFAYWJ9Jkf3j2zc9T8/aA
	Qsy3SjB6njt9TT0tIoAif1ZoSwxoZxcP9nyAxYVykhhLXtDmJlFh
X-Google-Smtp-Source: AGHT+IFQgMxCfTZ78J29Czohjtb4jQxi5+4UtE9O5Ch4U1w96P4Zt3x/nQ8fMNytR5RwLIOhgha6zA==
X-Received: by 2002:a05:6512:130c:b0:52e:8141:1b27 with SMTP id 2adb3069b0e04-530bb39b079mr14003421e87.43.1723054199279;
        Wed, 07 Aug 2024 11:09:59 -0700 (PDT)
Received: from ilordash-vm.mshome.net (broadband-109-173-124-203.ip.moscow.rt.ru. [109.173.124.203])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530de3e2ea2sm328995e87.36.2024.08.07.11.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:09:58 -0700 (PDT)
From: Ilya Orazov <ilordash02@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	Ilya Orazov <ilordash02@gmail.com>
Subject: [PATCH v2 1/1] dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6561
Date: Wed,  7 Aug 2024 21:09:56 +0300
Message-Id: <20240807180956.1341332-2-ilordash02@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807180956.1341332-1-ilordash02@gmail.com>
References: <20240807180210.1334724-2-ilordash02@gmail.com>
 <20240807180956.1341332-1-ilordash02@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Microchip ATA6561 is High-Speed CAN Transceiver with Standby Mode.
It is pin-compatible with TI TCAN1042 and has a compatible programming
model, therefore use ti,tcan1042 as fallback compatible.

Signed-off-by: Ilya Orazov <ilordash02@gmail.com>
---
 .../devicetree/bindings/phy/ti,tcan104x-can.yaml    | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 79dad3e89aa6..f6f1fd843874 100644
--- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
@@ -14,10 +14,15 @@ properties:
     pattern: "^can-phy"
 
   compatible:
-    enum:
-      - nxp,tjr1443
-      - ti,tcan1042
-      - ti,tcan1043
+    oneOf:
+      - items:
+        - enum:
+          - microchip,ata6561
+        - const: ti,tcan1042
+      - enum:
+          const: ti,tcan1042
+          const: ti,tcan1043
+          const: nxp,tjr1443
 
   '#phy-cells':
     const: 0
-- 
2.34.1


