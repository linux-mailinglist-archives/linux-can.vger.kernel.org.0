Return-Path: <linux-can+bounces-3393-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEACCA866A5
	for <lists+linux-can@lfdr.de>; Fri, 11 Apr 2025 21:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343541B67B29
	for <lists+linux-can@lfdr.de>; Fri, 11 Apr 2025 19:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709DD13C3CD;
	Fri, 11 Apr 2025 19:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="md1/lGE2"
X-Original-To: linux-can@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6508F27F4CF
	for <linux-can@vger.kernel.org>; Fri, 11 Apr 2025 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744400939; cv=none; b=gqj2LGFG9KUDf2ooMO/QC3j5ORSrWfPFlxwJ3/j3tYNR4+aRNYR+v3dN7YPaKJwPuUCtspP6Li4povQy6vr7xeQu3Sp3cLHArCnEp5vTVRmPqhoHTUgPhO7bibmb2g0f7lrIQhVpY/JHlYPib/6Y3uOR1fS3JZh8G6fQ//usF9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744400939; c=relaxed/simple;
	bh=dwX7lrYmi9zzC7dMvDxV9tnKHwWc/98WqddHYdda8zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NBzhMj6bjizqFnGLK5unKfa+EbB5ala6UxDMRUPLRvyJZ4JQrSqb6DIjVExds/D9E4bXDWdrZDHMd2QJ284AWDyqbqxXO7GedF5S+bixPy1/vZm6boD2FMDIOJyn3bAEM64EfeQpBn0intwrX7eddNvaVgAAq3+IkbBkS8yQGGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=md1/lGE2; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=qOkEUf9VE+o8qt
	Kh7W5+vm+94aknEFFFwvSgu055GlE=; b=md1/lGE2BpJfcsswkeLB0hVBlBtTCM
	9bgc6Pn+ahKxf9qfOttx/9iLNAmldN0RkIFV3gx+qisB9ZOKJ8Q0a+8+s7HblUN/
	FpeT2rw1TVAdNSNNNDJQ2REkDKWwEbgDPxCW/r6jt+49w1xadaznC3XTaZ2Hv2Oa
	/VZaJdB3znVO8hGmctWQ7Po0+vFXbqrzO6tiaoyPimWkCdc7NDrg8kdAzSw3Ol74
	HGxqLckN4JFYsI1gINckzralP4Gsnbc/M0pmLsw0YRZgVRTYV1JTocmZ6KkdY9gO
	8Gs5ZFCZQkYVG4A4zDIATXf495fNrQRt2ij7xg7CWF+UbN32z+Gzh5Gg==
Received: (qmail 1407061 invoked from network); 11 Apr 2025 21:48:54 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Apr 2025 21:48:54 +0200
X-UD-Smtp-Session: l3s3148p1@F8UN/oUyCKwujnsS
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH] dt-bindings: remove RZ/N1S bindings
Date: Fri, 11 Apr 2025 21:47:57 +0200
Message-ID: <20250411194849.11067-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Except for these four quite random bindings, no further upstream
activity has been observed in the last 8 years. So, remove these
fragments to reduce maintenance burden.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

In the previous discussion [1], Rob offered to take this patch.

[1] https://lore.kernel.org/r/CAL_Jsq+DOp8YOcshTVqYcbmgbuc4etTQeeswmMUYjw1sws4mAA@mail.gmail.com

 .../devicetree/bindings/net/can/nxp,sja1000.yaml     |  4 +---
 .../bindings/pinctrl/renesas,rzn1-pinctrl.yaml       |  4 +---
 .../devicetree/bindings/serial/snps-dw-apb-uart.yaml | 12 +++---------
 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml     |  4 +---
 4 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/nxp,sja1000.yaml b/Documentation/devicetree/bindings/net/can/nxp,sja1000.yaml
index 144a3785132c..ec0c2168e4b9 100644
--- a/Documentation/devicetree/bindings/net/can/nxp,sja1000.yaml
+++ b/Documentation/devicetree/bindings/net/can/nxp,sja1000.yaml
@@ -16,9 +16,7 @@ properties:
           - nxp,sja1000
           - technologic,sja1000
       - items:
-          - enum:
-              - renesas,r9a06g032-sja1000 # RZ/N1D
-              - renesas,r9a06g033-sja1000 # RZ/N1S
+          - const: renesas,r9a06g032-sja1000 # RZ/N1D
           - const: renesas,rzn1-sja1000 # RZ/N1
 
   reg:
diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.yaml
index 816688580e33..aa882b5bfe97 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.yaml
@@ -13,9 +13,7 @@ maintainers:
 properties:
   compatible:
     items:
-      - enum:
-          - renesas,r9a06g032-pinctrl # RZ/N1D
-          - renesas,r9a06g033-pinctrl # RZ/N1S
+      - const: renesas,r9a06g032-pinctrl # RZ/N1D
       - const: renesas,rzn1-pinctrl   # Generic RZ/N1
 
   reg:
diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 1aa3480d8d81..1ee0aed5057d 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -17,9 +17,7 @@ allOf:
       properties:
         compatible:
           items:
-            - enum:
-                - renesas,r9a06g032-uart
-                - renesas,r9a06g033-uart
+            - const: renesas,r9a06g032-uart
             - const: renesas,rzn1-uart
             - const: snps,dw-apb-uart
     then:
@@ -45,15 +43,11 @@ properties:
   compatible:
     oneOf:
       - items:
-          - enum:
-              - renesas,r9a06g032-uart
-              - renesas,r9a06g033-uart
+          - const: renesas,r9a06g032-uart
           - const: renesas,rzn1-uart
           - const: snps,dw-apb-uart
       - items:
-          - enum:
-              - renesas,r9a06g032-uart
-              - renesas,r9a06g033-uart
+          - const: renesas,r9a06g032-uart
           - const: renesas,rzn1-uart
       - items:
           - enum:
diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index bccd00a1ddd0..ff77ad6d4d8c 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -84,9 +84,7 @@ properties:
         const: canaan,k210-spi
       - description: Renesas RZ/N1 SPI Controller
         items:
-          - enum:
-              - renesas,r9a06g032-spi # RZ/N1D
-              - renesas,r9a06g033-spi # RZ/N1S
+          - const: renesas,r9a06g032-spi # RZ/N1D
           - const: renesas,rzn1-spi   # RZ/N1
       - description: T-HEAD TH1520 SoC SPI Controller
         items:
-- 
2.47.2


