Return-Path: <linux-can+bounces-1589-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071C598E943
	for <lists+linux-can@lfdr.de>; Thu,  3 Oct 2024 07:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8212CB20984
	for <lists+linux-can@lfdr.de>; Thu,  3 Oct 2024 05:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE12149627;
	Thu,  3 Oct 2024 05:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kggU+RnZ"
X-Original-To: linux-can@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C917A224EA;
	Thu,  3 Oct 2024 05:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727932063; cv=none; b=JJDweDGwmZMfplTE+W1UvAMscOjW7BlOvATUEA82paFaB+dEm3mtjN3134MGOHYOiaChUpKDCtqVQy4CznDMdMajcg5tf6uU0FDQ/Irwku3MoS6CFYGR+F63vzra2nYwYOyd5DDaR2CJeVX57WZANKLn93zo8xByEUBjvyd2edg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727932063; c=relaxed/simple;
	bh=dhA9dUnTQrlbjUojmNt+lPn+T0Gcazf90rUxsux0e4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=JI8Xa5xTeBmsoVZlz8M5GSwEWd6ec8pJmIXBU1VFAQIehdzvzDVevdgeBDoF378woG8DaFjyM0zMFpxsJHmabsRZzGEzVX8iCNqEqEVNir9DSgJgUGdO25RbKl+7O4U3voyxnPw3TthS0y9ArWIzLanlkw/qZguyjLLHPiZccWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kggU+RnZ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727932062; x=1759468062;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=dhA9dUnTQrlbjUojmNt+lPn+T0Gcazf90rUxsux0e4c=;
  b=kggU+RnZdAUHVnMHe5qRHta05Gtv5HZKDOn2If2mt7zq6UNHR6wkROx5
   nFZKwstv5hfDHQkY6UTLQIFPhEYUlUBnCTl1jzLme44PBdScuqc19i9LF
   ckcmZysUJPBx1FZ8sXAyVtD1FhLLOiSwQ8m8RMLcNVEOqhUPIBkgze+Bx
   iMF+R4xV27+3qG2MRyunFPK2hxPU4AAJxRJ+sJHdlQBQVFhXW6FFZw6/7
   cZzzHYc20PJJ9X3I0DdSG1kvU8rj5ndfCrdSBp5wbcV+N2jUU71B9zDVn
   CI5f/SSmxVdZmc+b44jHwDT7o8J/HoEKMvTi2ar31h2kcMScKwGQgNL1f
   w==;
X-CSE-ConnectionGUID: tSbnCTCURiuQebcaCydRvg==
X-CSE-MsgGUID: zdLMqo2iR/Szk5Hu91pizQ==
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="33144171"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2024 22:07:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 2 Oct 2024 22:07:18 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 2 Oct 2024 22:07:12 -0700
From: Charan Pedumuru <charan.pedumuru@microchip.com>
Date: Thu, 3 Oct 2024 10:37:03 +0530
Subject: [PATCH v2] dt-bindings: net: can: atmel: Convert to json schema
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241003-can-v2-1-85701d3296dd@microchip.com>
X-B4-Tracking: v=1; b=H4sIAHYm/mYC/1WMwQ7CIBAFf6XZsxggQqmn/ofpodCt7KHQgCGah
 n8Xe/M4L2/mgIyJMMO9OyBhoUwxNJCXDpyfwxMZLY1Bcnnjg5DMzYEZtP1qsFdaL9Cee8KV3mf
 lMTX2lF8xfc5oEb/13y+CCeaUVsIKwwdrx41cis7TfnVxg6nW+gVC6gWTmgAAAA==
To: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Charan Pedumuru
	<charan.pedumuru@microchip.com>
X-Mailer: b4 0.14.1

Convert atmel-can documentation to yaml format

Signed-off-by: Charan Pedumuru <charan.pedumuru@microchip.com>
---
Changes in v2:
- Renamed the title to "Microchip AT91 CAN controller"
- Removed the unnecessary labels and add clock properties to examples
- Removed if condition statements and made clock properties as default required properties
- Link to v1: https://lore.kernel.org/r/20240912-can-v1-1-c5651b1809bb@microchip.com
---
 .../bindings/net/can/atmel,at91sam9263-can.yaml    | 58 ++++++++++++++++++++++
 .../devicetree/bindings/net/can/atmel-can.txt      | 15 ------
 2 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/atmel,at91sam9263-can.yaml b/Documentation/devicetree/bindings/net/can/atmel,at91sam9263-can.yaml
new file mode 100644
index 000000000000..c818c01a718b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/atmel,at91sam9263-can.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/atmel,at91sam9263-can.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip AT91 CAN Controller
+
+maintainers:
+  - Nicolas Ferre <nicolas.ferre@microchip.com>
+
+allOf:
+  - $ref: can-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - atmel,at91sam9263-can
+          - atmel,at91sam9x5-can
+      - items:
+          - enum:
+              - microchip,sam9x60-can
+          - const: atmel,at91sam9x5-can
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: can_clk
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/at91.h>
+    can@f000c000 {
+          compatible = "atmel,at91sam9263-can";
+          reg = <0xf000c000 0x300>;
+          interrupts = <30 IRQ_TYPE_LEVEL_HIGH 3>;
+          clocks = <&pmc PMC_TYPE_PERIPHERAL 12>;
+          clock-names = "can_clk";
+    };
diff --git a/Documentation/devicetree/bindings/net/can/atmel-can.txt b/Documentation/devicetree/bindings/net/can/atmel-can.txt
deleted file mode 100644
index 218a3b3eb27e..000000000000
--- a/Documentation/devicetree/bindings/net/can/atmel-can.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-* AT91 CAN *
-
-Required properties:
-  - compatible: Should be "atmel,at91sam9263-can", "atmel,at91sam9x5-can" or
-    "microchip,sam9x60-can"
-  - reg: Should contain CAN controller registers location and length
-  - interrupts: Should contain IRQ line for the CAN controller
-
-Example:
-
-	can0: can@f000c000 {
-		compatible = "atmel,at91sam9x5-can";
-		reg = <0xf000c000 0x300>;
-		interrupts = <40 4 5>
-	};

---
base-commit: 62f92d634458a1e308bb699986b9147a6d670457
change-id: 20240912-can-8eb7f8e7566d

Best regards,
-- 
Charan Pedumuru <charan.pedumuru@microchip.com>


