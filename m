Return-Path: <linux-can+bounces-1182-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F14F494C51C
	for <lists+linux-can@lfdr.de>; Thu,  8 Aug 2024 21:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5CF1F2325C
	for <lists+linux-can@lfdr.de>; Thu,  8 Aug 2024 19:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03883146D68;
	Thu,  8 Aug 2024 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1/mbq15"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43942144D27;
	Thu,  8 Aug 2024 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723144738; cv=none; b=L2e7MhnVPf69N+pyIT/cxY7/D7W2GCdALNA2U7MgLurpxGqarMRoJybaRYxNBUjcg5rvKJQD9RtqrTapFYhYCNV+L1XtJTny5vu3SOt5dbpeJRRZ4vEB1o7/jZfGx5msZh/RQcuNVpjsOWViByVUpoRhGWBvuPqjmhPI2Uq52yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723144738; c=relaxed/simple;
	bh=oOuMmcQpPx+z5/BvfEvYLps1G150yztaxNOL37SHRH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P4Pddy7o2We437Z1FXLi9GP1dL2EkpjRm4ffV8cIBZ1yCcmqEWXffa4J/H5TW1fTLHYlfc0jZSo0I+MujAbDC2xec3L6d0/rPE5eCR+llGpj1+v0h1ZIjQW3UkrDg2le/qPoXeseldkv+ZMidzeqhXDc+8bhDglX8ZP/LMMNU0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1/mbq15; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f1870c355cso12666331fa.1;
        Thu, 08 Aug 2024 12:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723144735; x=1723749535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AN/z600dILInAQ2RuZIwZlxGxr3ycWJG+/le4ofqv/g=;
        b=a1/mbq15tcqGlnJ6vX4gtcIcPfF18GHjMCrgCN/tTDFmIvCD+L5rtgUWInF62Hx02+
         /4WwqEzCyEXj7Ea2Nk+M7cfn8PjNul3sHJRkhk39x9Er5SF6jhGb6GCNoVaPwYvNPEQ1
         GvMD73TgMm6oXIha7zN4kDliMnEPCiceqxVvDDe/CnVYjbbK4XFk7rcFNmZWW1IpMV+k
         gqGroFaWNoR+zjlzlNd3X22FbW9ZH4pr7i0Z0w+oeIjrFeeMKNvKMHsHOZ5wTLo06iF5
         DzX3D4a8CSu9GrCRNdZ6CAZhoSfhMtAEm0j34OKdOA3lM740zHyOdNz0r09xf5FCkGvL
         1muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723144735; x=1723749535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AN/z600dILInAQ2RuZIwZlxGxr3ycWJG+/le4ofqv/g=;
        b=CD7PbmWc6/juTHTwHxxaYaIkF7li+3GZ8BIWVPNHYZkxGrnOFjgeIXYtIC84bZZyLD
         UaXgeGTm5Ioxy9aNlMQLzsavfS+f2OL5B/5aBDPpoESaI33rlxRmx9Y3OljtBNCDB5qM
         1RdvA1CxfUF02sXa9pr9w6usnWjyuY8axhPxrSezgFNQzEKQ4bGLs2bq/wJHzudIaFmX
         IxJ1+BtrEm7whBbdmkvs2AWVO30iogTzI6N3Oxl9uss6lxuB3OwxWTBEjIwkhVF1Sc2y
         HBbBRbfH/qZjjfIqiEPqcJfWyvbLvUEmJAs/lo2H/9i9QSLIY0rohRoin8bkEKoNUFXU
         4YMw==
X-Forwarded-Encrypted: i=1; AJvYcCV6zagaUxosZPKrTO76FmqezRG6ckumV2n8Ivy2awf+aJDMp6gz9D9ytqkFsXxjV47VU//xzdpbu1vRMTBaohb+ny9AA7vOJvo2GA==
X-Gm-Message-State: AOJu0YyHrPhTvyPAx3CkHOJiu1H6YnSxnvKTyou7zbeM1moYTHS4FQfi
	9Oeezt/KtbWeYbXPfo7bIH4PfJIUAb92bLCmxk/zQJR6mwSNmIE/
X-Google-Smtp-Source: AGHT+IED3adyQmO8mvsEjFHmXzwBJwrydp7BD8mx9Rbd9ZV4+aFXzkyOoCZJOrTzVc+v+EeroHx2Qw==
X-Received: by 2002:a05:651c:154a:b0:2ef:265e:bb93 with SMTP id 38308e7fff4ca-2f19de203e4mr18849711fa.3.1723144734809;
        Thu, 08 Aug 2024 12:18:54 -0700 (PDT)
Received: from ilordash-vm.mshome.net (broadband-109-173-124-203.ip.moscow.rt.ru. [109.173.124.203])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e1ade2fsm22877181fa.32.2024.08.08.12.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:18:54 -0700 (PDT)
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
Subject: [PATCH v3 1/1] dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6561
Date: Thu,  8 Aug 2024 22:17:35 +0300
Message-Id: <20240808191735.1483572-1-ilordash02@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <56a52c81-68de-438d-94ae-9decc799d824@kernel.org>
References: <56a52c81-68de-438d-94ae-9decc799d824@kernel.org>
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

base-commit: 6a0e38264012809afa24113ee2162dc07f4ed22b
-- 
2.34.1


