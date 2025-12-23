Return-Path: <linux-can+bounces-5909-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E63CD8FDE
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 11:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABCDB300D49D
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 10:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608EA32E6A9;
	Tue, 23 Dec 2025 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="TKiU4KlE"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB7132548A;
	Tue, 23 Dec 2025 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766487395; cv=none; b=Yimzx1EDM7K82nMszzcinQgwOwfgsasDN0tkqWrsl30R4C4OvS+BbWt3xJAVfO0gpF1pGP2PohKhiFCMPTLEA4h2mRo7XyD5gXDrSH9TRYS3Z78co7OOPMX+CbNUhGVASIQK6ghaizCOLZNfTuBmlSTkx2IVmE8HmEhEqOwQuPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766487395; c=relaxed/simple;
	bh=rQyHNApVOoEpxecyH2FFCfV+d552z/jncbJWppKJHGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=misud48Uf4qS/629UkqiKRxoAl4ElTzT2yaQAhE7dofY5VS1qFlbhTASXFlPveM3c6Lec0I75x2CnkJwfDtB99L7pFVsCV5NcnEJFIIwk15NMscU2M8+4czgNJ5GYEMeE3psrQHUnBifqLX8wc8PdArid5bzLIMF2B+i7zzDnig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=TKiU4KlE reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dbBlC5kylz1DDMp;
	Tue, 23 Dec 2025 11:56:23 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dbBlC3n1Bz1DDXT;
	Tue, 23 Dec 2025 11:56:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1766487383;
	bh=ovpAxXhMB8R22TCL6fvJYIX2qFtp6RStyBFYmYn5Fbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TKiU4KlExh0lcOTsbPBL2013mHdLyxwXJbh7+cSB3xnPTB58mQdLWxmJxL4OwR/S6
	 REzL1U0y8MJIaJ+YX6zuozM7PnlDXu8Y3xpMPX+Q2DH9K3/6qqS8YCfIxD7Dbyzcvk
	 kHz49O7a4V1laZ/MmbUUKgX3uWMrDcZDvF1n0SFv6ITWPg8l0WSGrxEdtaBqFyedk4
	 n3iFeV7nfsZv9TUUwC3At2FSjPITH5k3tnXmavUVNFsGRz+9toPD8qCCDooCecMDzm
	 xT8qiEPcCwRBehBsFB1Qib8uy9xY9J4wQQ9yKx9XxX8kfALVyq6jqEQUk5xL3U2HFK
	 reg9OIPh0Sd/Q==
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH v2 02/10] dt-bindings: net: can: grcan: Convert GRCAN CAN controllers binding from txt to YAML
Date: Tue, 23 Dec 2025 11:55:56 +0100
Message-ID: <20251223105604.12675-3-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223105604.12675-1-arun.muthusamy@gaisler.com>
References: <20251223105604.12675-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate device tree bindings for Gaisler GRCAN, GRHCAN
and GRCANFD CAN controllers from a text format to YAML format.

Additional changes:
  - Remove stale systemid property
    removed in commit 1e93ed26acf0 ("can: grcan: grcan_probe():
    fix broken system id check for errata workaround needs")
  - Make freq optional
  - Add clocks
  - Add compatible
  - Add example

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 .../bindings/net/can/gaisler,grcan.yaml       | 62 +++++++++++++++++++
 .../devicetree/bindings/net/can/grcan.txt     | 28 ---------
 2 files changed, 62 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/grcan.txt

diff --git a/Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml b/Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
new file mode 100644
index 000000000000..8fea97c7319a
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/gaisler,grcan.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aeroflex Gaisler GRCAN, GRHCAN and GRCANFD CAN controllers.
+
+description: |
+  GRCAN, GRCANFD, GRHCAN controllers are available in the GRLIB VHDL
+  IP core library.
+  For further information look in the documentation for the GRLIB IP library:
+  https://download.gaisler.com/products/GRLIB/doc/grip.pdf
+
+maintainers:
+  - Arun Muthusamy <arun.muthusamy@gaisler.com>
+  - Andreas Larsson <andreas@gaisler.com>
+
+allOf:
+  - $ref: can-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - gaisler,grcan
+      - gaisler,grcanfd
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
+  freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Frequency of the external oscillator clock in Hz (the frequency of the
+      AMBA bus in the ordinary case).
+      This property should be used by systems where the common clock
+      framework is not supported.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    can@ff400000 {
+        compatible = "gaisler,grcanfd";
+        clocks = <&sysclock>;
+        reg = <0xff400000 0x400>;
+        interrupt-parent = <&plic0>;
+        interrupts = <6>;
+    };
diff --git a/Documentation/devicetree/bindings/net/can/grcan.txt b/Documentation/devicetree/bindings/net/can/grcan.txt
deleted file mode 100644
index 34ef3498f887..000000000000
--- a/Documentation/devicetree/bindings/net/can/grcan.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-Aeroflex Gaisler GRCAN and GRHCAN CAN controllers.
-
-The GRCAN and CRHCAN CAN controllers are available in the GRLIB VHDL IP core
-library.
-
-Note: These properties are built from the AMBA plug&play in a Leon SPARC system
-(the ordinary environment for GRCAN and GRHCAN). There are no dts files for
-sparc.
-
-Required properties:
-
-- name : Should be "GAISLER_GRCAN", "01_03d", "GAISLER_GRHCAN" or "01_034"
-
-- reg : Address and length of the register set for the device
-
-- freq : Frequency of the external oscillator clock in Hz (the frequency of
-	the amba bus in the ordinary case)
-
-- interrupts : Interrupt number for this device
-
-Optional properties:
-
-- systemid : If not present or if the value of the least significant 16 bits
-	of this 32-bit property is smaller than GRCAN_TXBUG_SAFE_GRLIB_VERSION
-	a bug workaround is activated.
-
-For further information look in the documentation for the GLIB IP core library:
-http://www.gaisler.com/products/grlib/grip.pdf
-- 
2.51.0


