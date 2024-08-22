Return-Path: <linux-can+bounces-1210-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B94F495B338
	for <lists+linux-can@lfdr.de>; Thu, 22 Aug 2024 12:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717322828B3
	for <lists+linux-can@lfdr.de>; Thu, 22 Aug 2024 10:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25595183CAB;
	Thu, 22 Aug 2024 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYdI1HZy"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D15414A4F1;
	Thu, 22 Aug 2024 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724323965; cv=none; b=r92AbKln9SkoElJH/aJy6/VbQct2jPEXhzgPhIX7bSp1Ozt7J0PFopiIdlxV0fSqHBwz7+cEPlSwRiEzMqqBECweGHh0t8CXLeolUdqtqBypTJi36Jb10lD1JIYj/P5Lt/iduWu1gf/HkesySWP/dpgoJQqnTBgN3sBNnmmUU8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724323965; c=relaxed/simple;
	bh=sPXpD92T+hvJ3Xq4Y2miBjvbDMl5XcT1vqRWKRi48uw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FgGsWhpJV7vqxcOEPEJhyjVgqaboEYaXTTadHnVDrWr0G3LA9zdZh74m/5e1Ak19xxFcn/A0xZH/PegAgeO7VLLkI2Pb4oiN5vVVosQ2GZfYA+DCUk5sn1H0F308w8xIt+tAEd/jSB5sBnE7shYnpN1ZB4RuEnIM7pTPhmlGX7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYdI1HZy; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso7676581fa.2;
        Thu, 22 Aug 2024 03:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724323961; x=1724928761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=731RcZeHTEALfaVb7fhfHI1er4oVn7kj9vmasIgzTaE=;
        b=lYdI1HZyGqA4BOSMyNlqHDpb/SsqTILsMHHR8iGnXVhBYX3ghZtSD2510LaA480+/I
         npmWQmSDZ6rA0eDhF8EzFtbD9zN1AJ/qKyMgo5Nc+tFb/Au8tW8bPh3o89l9kNtM0PZY
         tZA+yB6bvb4QtkWiyoCKN603S5T0CGY9eyLjikDYV97hBsyTAdL1Fb8zGaYX9Qi4k4B/
         Jll3BYXvaQUQQLliLr0we+koKmUoEcs+2U3ptELbTYqSW20yRzCKcWszhFFcxiFsoG5d
         SDLeaUzDZprE/9k7TM5f9WJEbsrGnq+Vw6pmkIXp1SzRgw0WWaezyI3xEeEgV2L8Oxs+
         8Dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724323961; x=1724928761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=731RcZeHTEALfaVb7fhfHI1er4oVn7kj9vmasIgzTaE=;
        b=J6tBfji1IUsMzzE3HWco76uuU7IE7m1FWimkHgNVeTKRsPB/bvSwwobbjM2meO/3lN
         nehzWnSR9qfGNDuR0YiaxUJJgt86yaAMdTmsjuvMoXNfBXvpYWZi6MNan53G7mavdc2B
         VVS/GbAvh9KQSXV/ZmHipRnHQVItmYX+ct+DzZ/8bhA8xnBSwb7vibvof8x4yXMpxmIW
         jYP147rcL3pLAjSk0wM8xuYsamBBiR8a+A/20HXUvQ3nU9iQYyiyMLTnn+Q+MDYBG0C2
         QVjwvp0AUNoyjzA71J92PmxW8QX4msmAecLBGQZ2XSshMfrretjVNf6R8RNioGmRdLJy
         b2Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUGm4qaxYIPGFw/pebrc+eO4ljoLQNDiHqGg3SX+3/li3aNKaOvwS7sZz5hSXVNtIBZgwPD6tXTen7s@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb4QeFCHoqtiwQ/mCp7qn+joiJhSAsZSlsDYJNtKy/D+0kWYrr
	6gEuyFjs5684hZGFkZuSSf67mITcwAGouX0W7b123w5UWDmvlfHQ
X-Google-Smtp-Source: AGHT+IHDaN/6OMm9DmGNsNVe6VPZ1q8odEbtMigR7nu2Jgm+IpGLa5NIzCQFVQF2ZAT4sXqVvJ6drg==
X-Received: by 2002:a2e:9b02:0:b0:2f3:bdca:3e2 with SMTP id 38308e7fff4ca-2f405e9ef3bmr10474781fa.27.1724323960795;
        Thu, 22 Aug 2024 03:52:40 -0700 (PDT)
Received: from ilordash-vm.mshome.net (95-26-8-211.broadband.corbina.ru. [95.26.8.211])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f4047a4f59sm1886261fa.13.2024.08.22.03.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 03:52:40 -0700 (PDT)
From: Ilya Orazov <ilordash02@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>
Cc: linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	Ilya Orazov <ilordash02@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/1] dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6561
Date: Thu, 22 Aug 2024 13:52:38 +0300
Message-Id: <20240822105238.213019-2-ilordash02@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822105238.213019-1-ilordash02@gmail.com>
References: <20240822105238.213019-1-ilordash02@gmail.com>
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

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Ilya Orazov <ilordash02@gmail.com>
---
 .../devicetree/bindings/phy/ti,tcan104x-can.yaml    | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 79dad3e89aa6..4a8c3829d85d 100644
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
+          - enum:
+              - microchip,ata6561
+          - const: ti,tcan1042
+      - enum:
+          - ti,tcan1042
+          - ti,tcan1043
+          - nxp,tjr1443
 
   '#phy-cells':
     const: 0
-- 
2.34.1


