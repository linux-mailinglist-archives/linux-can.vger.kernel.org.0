Return-Path: <linux-can+bounces-1204-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B27595A729
	for <lists+linux-can@lfdr.de>; Wed, 21 Aug 2024 23:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8831F22CD2
	for <lists+linux-can@lfdr.de>; Wed, 21 Aug 2024 21:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479E217ADFE;
	Wed, 21 Aug 2024 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFJbOKsW"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FB9179957;
	Wed, 21 Aug 2024 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724277245; cv=none; b=md/280+goi7iRamJnWC7rRAx7ZgZWtCu4qYhDa/LD2ePamprHT8cZqcMEeSBe1E9bHvU1IHM9lM2YUF2ecNBFR7vm5cz/NLGNDbLcx4QMU0/K9Awf10VKzS3Ne5L1aH7VhRGjMvuRjkdGvNnF0Y+JBOUF0JdH0sCvx9mLmmmBgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724277245; c=relaxed/simple;
	bh=3zNERGB2LO4Ade+K5qoG6Wet/2QOoEDq/JHeM+ysJlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bz3Lm8CMBAtj2QQbes2jCTBMVBe72vl9zBJLKnrP0cgIQcUzlIYZgDCML3l+qexEDkpazVHLc+ta+G0QbXxGhzz+EmcsOHVgbV1ov6rlPUp2R+/xTOhUTZ/noAZup8/Lh4amyfxC4kuuXMmEUdntTgH/kt0Z7oCbSFkvkCOXJ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFJbOKsW; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52efef496ccso127981e87.1;
        Wed, 21 Aug 2024 14:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724277242; x=1724882042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzT7u9Va9+FkDuNLpLus7IzkjxONKq3lMA75TDxSd+s=;
        b=iFJbOKsWqM527ZGNczs/JVRwN2JxPdR+P/821RQMiZyzVHsnIkxmm9dJHnmpjwYHjn
         r3CdiKaBV5TOZiAa7bz+TETg96BbxZ1MRaI3P2KaSPh0tkVt2uJhKbe0i5RKWIfe2E3z
         YMppvCZkgDLdVgjl/pauGd6X8khgulgaK5oFI4sOc82APxDVY/RBDlHwYsjyDNBIE4jm
         naprrxkIgPxcoCgfWtRPe/Ia1pmrNNMHE/7Z+vQ487L8Gx0kd80Pz1da3Df34g7VXS40
         2wCKGa51Cc1MrfKxpsdXw8ZItnGJlNaXvUmKOTLPhEceAM+xu4GfQwa8szcgsOnZDjD+
         qxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724277242; x=1724882042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzT7u9Va9+FkDuNLpLus7IzkjxONKq3lMA75TDxSd+s=;
        b=oCsJX2u7yN07nYSccBE8FHOhTYrvp1fh4qvuiWjUGgPFiqDnGtdkZmCBhRlETsYY44
         7W1z6uQMeJb2JO4K7og7R+/7uw4wkxcwuIYjoUjALDOTRJJg14Y0SELy1QuPgz4tF5bB
         nuZFkMqh3IHe1dbiwqocjIxCzVEar1GUuIWIG1zXK8zPvH9hj8n85GGjvZdvnRLA6cyp
         dH9OI8pF5aOu3qKrwBwNGpfhlspVlg7fzBHX8K/67K/DyzVZ2kkJnJlztf6VtYCc13Jc
         UVzRxETaOPSsH2bPvCWxgMpy5Hjso6Td5yRPoNYHUX/qrMbfsRq5DMYeXiM7qTamlprn
         h5zw==
X-Forwarded-Encrypted: i=1; AJvYcCXLstNVu0OhS5wjPFl2XIThveBs4KoCBfHQBDSnWx3Vjdyqr2Fg7+AcbAwudIwb/8nibwPJgY80zCYj@vger.kernel.org
X-Gm-Message-State: AOJu0YwdNvAzOLwUHv3CUEJebtUhicajxUtwsV1lJLhcxeblGoAHGrC/
	oLIEbuxYGlzijtXwzvy8IlNZfMnFgaRTHxBj+Zvq6CO4TdhK/+4qTmObB8/R
X-Google-Smtp-Source: AGHT+IG6spftSttzdVaDbR+Cow/+aj2DlHU11b0mq8N6KLzTL/5MVfbFQ8AUb7MhGFrrQVxZxQC9Rg==
X-Received: by 2002:a05:6512:b03:b0:530:ad97:78ba with SMTP id 2adb3069b0e04-5334ca7d79dmr277195e87.9.1724277240906;
        Wed, 21 Aug 2024 14:54:00 -0700 (PDT)
Received: from ilordash-vm.mshome.net (95-26-8-211.broadband.corbina.ru. [95.26.8.211])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea89004sm15623e87.274.2024.08.21.14.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:54:00 -0700 (PDT)
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
	Ilya Orazov <ilordash02@gmail.com>
Subject: [PATCH v3 1/1] dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6561
Date: Thu, 22 Aug 2024 00:53:57 +0300
Message-Id: <20240821215357.20224-2-ilordash02@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821215357.20224-1-ilordash02@gmail.com>
References: <20240821215357.20224-1-ilordash02@gmail.com>
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


