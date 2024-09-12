Return-Path: <linux-can+bounces-1478-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAC9976099
	for <lists+linux-can@lfdr.de>; Thu, 12 Sep 2024 07:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8920FB21E57
	for <lists+linux-can@lfdr.de>; Thu, 12 Sep 2024 05:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF66188907;
	Thu, 12 Sep 2024 05:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gxZfs8K7"
X-Original-To: linux-can@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6232119;
	Thu, 12 Sep 2024 05:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726120316; cv=none; b=IhcPeBSGfop7BOdyb1U4Uf8ADbS10gKLjRBsC16t3ECC/KNkS3g9wKnqda552NF07OdTp4d1ubv9QrZ80PkmRKeBNW5SuHIXUgVWKQs89WU8eeJU2rkFSaQKbALSpGTQhgm7ZZLChVbGdhP+Wn97Eb6zHykxequGhwUWckbF0UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726120316; c=relaxed/simple;
	bh=5nBw3jed5q3gOSsyd6ygguuJZHN5dfBDVK9fb2f+3nM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=E5ax4fsHP4fr1ldB2pdsd+fLvob4QsN00xbyfQfs7z+y8XVgTDQlYGCAS+TR5CcjOa1V9JHtE6X2Y31siqWcFBFky+BZ7MJV5ifBlNMSvY9rw/eeH4g1MA6UKSX98jAdwwW998PKkGHEXW/FJhaAarAuyEkxBPUX89l0P9u24tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gxZfs8K7; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726120313; x=1757656313;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=5nBw3jed5q3gOSsyd6ygguuJZHN5dfBDVK9fb2f+3nM=;
  b=gxZfs8K7Cdw7omjQmW3vdzWoB30LLjd1H9br2j51F0TG8HsW8H2VU5IH
   NdzXa+1tsaPPnBZ3dDwGTgLfq1QUpJ+Ch0uCVkZoePnFGAfiMeBYbiHac
   6IjLShvh0JU4UnBcfmmVv0KawP1RwzJnB5qKAG9TwDWExCgxRob5gkTm3
   b2CadhgA42UiFopilY+jgLAWhSiKeXpwe9vTvXHqFhLnVjaQNxQQGomzN
   LCD9ENbluVqSxoAPjHR+VpYyo1KY5hYmiLhudZJabkj4FhNTCAdjXNUi/
   2/imZrydwX/6Zn6uYcRWCcM/h51amq4R0M+9TfRu/guYUrgyo5stk/IKj
   A==;
X-CSE-ConnectionGUID: yO5+uw3DTJiRuB0mNxV1RA==
X-CSE-MsgGUID: Uktahx2VTCiHDFDkJDH4kw==
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="199112816"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2024 22:51:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 11 Sep 2024 22:50:51 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 11 Sep 2024 22:50:45 -0700
From: Charan Pedumuru <charan.pedumuru@microchip.com>
Date: Thu, 12 Sep 2024 11:19:16 +0530
Subject: [PATCH] dt-bindings: net: can: atmel: Convert to json schema
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240912-can-v1-1-c5651b1809bb@microchip.com>
X-B4-Tracking: v=1; b=H4sIANuA4mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0Mj3eTEPF2L1CTzNItUc1MzsxQloMqCotS0zAqwKdGxtbUAg1Hdc1U
 AAAA=
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
 .../bindings/net/can/atmel,at91sam9263-can.yaml    | 67 ++++++++++++++++++++++
 .../devicetree/bindings/net/can/atmel-can.txt      | 15 -----
 2 files changed, 67 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/atmel,at91sam9263-can.yaml b/Documentation/devicetree/bindings/net/can/atmel,at91sam9263-can.yaml
new file mode 100644
index 000000000000..269af4c993a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/atmel,at91sam9263-can.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/atmel,at91sam9263-can.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel CAN Controller
+
+maintainers:
+  - Nicolas Ferre <nicolas.ferre@microchip.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - atmel,at91sam9263-can
+          - atmel,at91sam9x5-can
+          - microchip,sam9x60-can
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
+
+allOf:
+  - $ref: can-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,sam9x60-can
+    then:
+      required:
+        - compatible
+        - reg
+        - interrupts
+        - clocks
+        - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    can0: can@f000c000 {
+          compatible = "atmel,at91sam9x5-can";
+          reg = <0xf000c000 0x300>;
+          interrupts = <30 IRQ_TYPE_LEVEL_HIGH 3>;
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
base-commit: 32ffa5373540a8d1c06619f52d019c6cdc948bb4
change-id: 20240912-can-8eb7f8e7566d

Best regards,
-- 
Charan Pedumuru <charan.pedumuru@microchip.com>


