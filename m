Return-Path: <linux-can+bounces-1168-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3019294AF55
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 20:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBCFF1F23B8A
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 18:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4CD13D8A2;
	Wed,  7 Aug 2024 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTrDBR8a"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B5112FB0A;
	Wed,  7 Aug 2024 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723053736; cv=none; b=ZitVSg9wpuCacpFVnul7lg3xG1UEyGu70AZaENfddKhz/HpH9fFP20zuCd3lnI38x/NgJjIrRJ7XMU61MHvUyd8AdyDM4VUQORYiNiUu+W6JcWmg4+3eH23roKIKj7uE2rNa8hcdkQ4DFOq4XAaPziUzNSh3NVIipA6wHxqL/Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723053736; c=relaxed/simple;
	bh=bvPStC/Yb+X/fMd9rFKPb2jgFs1cUxSGy6fu+4ET3q0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b4eOce0ySIL85mC9Ca2lBmKuTZgE0DeKRNGw+0m0PKdou45WGzs8eGscozvEzdHTYL7ts2H/gog39xxnoKRszzJeIIeUwPRy9jAs1nHJvu82EPzvdCrrc6IO/psGu8XdDmZ++viQhnXOVxtyXM7wF5YsYjofwso0RbXI7O9mV4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTrDBR8a; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-530ae4ef29dso149361e87.3;
        Wed, 07 Aug 2024 11:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723053733; x=1723658533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwE9+aTmzE/L4eY1Ly8aatDyxXhgT1yoAT1n8F/TGSI=;
        b=GTrDBR8arTVeodSdb/QPXH5f8sSqTo4fSDrf7krsVQEerjct8qDKCRd807jf+HvGcv
         dtSGzvo5UwtRnwre1egGUOJymNf9kaKksrDh/B2FfrA5kJvkdsd18gCd040khoL/B5gJ
         no7RSomR0xnGhyhGqQ9z5Z9psTbWMeACFxGlRAsT5Q508JCibmQ311Lg8CW9oZqqQE0B
         fWb0KHZRZwGlbDc0nOVjj7wir6mIJns9ty8cyved7X+fsZHBIS1gwpk894Gdam35pMHA
         iLmk63PFbrdyTr5jIh6tXYJ5YtkawHcxSKi2nq63iQgubbUG4bszyLql0BC+xzYteWws
         f3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723053733; x=1723658533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwE9+aTmzE/L4eY1Ly8aatDyxXhgT1yoAT1n8F/TGSI=;
        b=GW8INGUlUDDYQ06dCr5pvk1CytHb/NqIWvnHFMkF32MjW3kckZPulgS5XKdrFt9oZa
         SHIsTFruftFqw7kiwjhHdzMr+/QNsIEK+c6vdI5/fABtkkusg03hJG57/MqE2lxKh1ai
         kY2B2a8tW2Co6kPOeYcXPTAD1I1EoSXHJXyaHmDInSDJFo34jTsBCuGfT7SNQZdmZiMg
         jLISZO7Tctf/TAiLM+W755rWRhpoCfqdHZZMatDkrmzM1YnZIUbM0Zh4kHlJazuvEaC2
         8zRj6snsGez9I92tNZaBhZOL+mcvW/MBJVMQ7D34Tuvq5fHC5rFrKGBI1wbT6SXXa1Ha
         9aYw==
X-Forwarded-Encrypted: i=1; AJvYcCWVLEsoiqzykQGC9YLBdhRBWE2mZ3qeqEH2wk3H1jcowZHtA3CGAd2VdZ/GWqxXgnecRfiV0LKi17jBjn8BaOHTDO+gO54KExmOcA==
X-Gm-Message-State: AOJu0Ywxx0O3wruaE5AuuQYaL9xHl5WiHVcMPCqsUp5aZpDtwzDWGp7S
	J9P91jIQdgbpEsLlvd2UPKjm0tbd400eKZ04Ixo7ewM6QBmS+1A/
X-Google-Smtp-Source: AGHT+IFAFz4dVLM+vZEi9pZsqtcnRSt/zqO+GPnpIZGyj3KakZJXvTw6178wvD2HqJDuTv8eJa/fLQ==
X-Received: by 2002:a05:6512:2387:b0:52c:d5ac:d42 with SMTP id 2adb3069b0e04-530bb373067mr16820971e87.9.1723053733003;
        Wed, 07 Aug 2024 11:02:13 -0700 (PDT)
Received: from ilordash-vm.mshome.net (broadband-109-173-124-203.ip.moscow.rt.ru. [109.173.124.203])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530de3e2e18sm332454e87.34.2024.08.07.11.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:02:12 -0700 (PDT)
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
Date: Wed,  7 Aug 2024 21:02:10 +0300
Message-Id: <20240807180210.1334724-2-ilordash02@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807180210.1334724-1-ilordash02@gmail.com>
References: <20240805-fruit-chip-cf08a0e166a3@spud>
 <20240807180210.1334724-1-ilordash02@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Microchip ATA6561 is High-Speed CAN Transceiver with Standby Mode.
It is pin-compatible with TI TCAN1042 and has a compatible programming
model, therefore use ATA6561 as fallback device for TCAN1042.

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


