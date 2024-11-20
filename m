Return-Path: <linux-can+bounces-2122-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D78D9D3590
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 09:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276DB1F24144
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 08:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46C0189BB0;
	Wed, 20 Nov 2024 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="M5qlBRfS"
X-Original-To: linux-can@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE96187844;
	Wed, 20 Nov 2024 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091709; cv=none; b=ITBhtX6xKDbe9hVVpreyaHxnCyfiTeNyVuL0WYCJpFYst3uA6j7e48uileI9TRQqAT2PIlB4iJS3hTFFSe29eY7WnqExqQIUBRolRJkPkCl7QwA9m5mr5tseEJglsIQ5utdnyQlWRpnmH2bZejlgpwJ6st9MICOVRsZiLVZgtAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091709; c=relaxed/simple;
	bh=55A8FeZ2TpcWNVaw339qWDeg5tKpRPnQiXrnOOVibu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=dMc8Ouc0N5ZHZg+I7spy+bTbPAbx8FlRCOLH4gmH7IVtpnUVrE7jdoZI8Lyx8SAxcIBHPF4mBx5l9jClR6C0TkzUm2B24VwA6OPtGMFsufPvnBZwciAlkgh4QcC7xUrfiCJmmTx3ugyrB+Zx2grcoHxWuKsTfOoFLC+2yRaoHAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=M5qlBRfS; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732091708; x=1763627708;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=55A8FeZ2TpcWNVaw339qWDeg5tKpRPnQiXrnOOVibu4=;
  b=M5qlBRfSbZClO423hOUseBrSFJHfUBJpvZSesl6t6f0Jz1Tl7MLzpZKz
   ts0pqXbmv0vCYo1ZFYDw5F2E4FsUx9/K5gS+pIqdfZHhS6cnuqyd1TEwE
   4M3nizR7w29pWIx/K1R2xMHfACCuw+2LP2aAjMdFXjSC5D5YolMJEyAgh
   lB2P0v1ocDKUohA0mBcT0jHyudg3syx8wxU9HAms3fZ8+R9U18NwJV721
   LNykTKREHB6lAo3gqtElBU9dUyjyIPByc6/OvUgw0zVkO6jp+/FL2aQbs
   Y/ZKuTY2Ibtvo5Ls5QMDXBfE5EvOe4RHaeqW3pNb1162wLoTFhcboC9sC
   w==;
X-CSE-ConnectionGUID: 0G/ItBSvSQqPiV4u0hJ3jA==
X-CSE-MsgGUID: OuuoQFbsTC2KrX/X/n6znA==
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="34273278"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2024 01:35:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Nov 2024 01:34:36 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Nov 2024 01:34:30 -0700
From: Charan Pedumuru <charan.pedumuru@microchip.com>
Date: Wed, 20 Nov 2024 13:58:08 +0530
Subject: [PATCH v3] dt-bindings: net: can: atmel: Convert to json schema
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241120-can-v3-1-da5bb4f6128d@microchip.com>
X-B4-Tracking: v=1; b=H4sIAJedPWcC/12Myw6CMBBFf4XM2ppOsaW48j+MC/pAZgElrWk0h
 H+3YGKiy3Nzz1kg+Ug+wblaIPpMicJUoD5UYIduuntGrjAILk68RcFsNzHtTdNr30ilHJTnHH1
 Pz71yvRUeKD1CfO3RjNv662dkyKxUEg1q3hpzGcnGYAeajzaMsDWy+HrIef3xRPG0bDi6WrTKu
 X9vXdc3t5RQGtIAAAA=
To: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>
CC: <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Charan Pedumuru
	<charan.pedumuru@microchip.com>
X-Mailer: b4 0.14.1

Convert old text based binding to json schema.
Changes during conversion:
- Add a fallback for `microchip,sam9x60-can` as it is compatible with the
  CAN IP core on `atmel,at91sam9x5-can`.
- Add the required properties `clock` and `clock-names`, which were
  missing in the original binding.
- Update examples and include appropriate file directives to resolve
  errors identified by `dt_binding_check` and `dtbs_check`.

Signed-off-by: Charan Pedumuru <charan.pedumuru@microchip.com>
---
Changes in v3:
- Modified the commit message with reasons for each change
- Link to v2: https://lore.kernel.org/r/20241003-can-v2-1-85701d3296dd@microchip.com

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
base-commit: 414c97c966b69e4a6ea7b32970fa166b2f9b9ef0
change-id: 20240912-can-8eb7f8e7566d

Best regards,
-- 
Charan Pedumuru <charan.pedumuru@microchip.com>


