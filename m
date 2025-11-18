Return-Path: <linux-can+bounces-5478-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 567A5C687CF
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 10:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 4EEC32A5E4
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 09:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D42F314D00;
	Tue, 18 Nov 2025 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="CSfDiocX"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A6B262FC0;
	Tue, 18 Nov 2025 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457696; cv=none; b=aOvvXt0ee3N0Ir+KKqD7TjdtkKxr7xRlrR6/8WRZCq8dMsT7NkClgbtTel/L685ZDlxXE7VZdiOSeKx3/rcKQjePSCbKHKBsKn9+AZXvJeyGkV6kx0j69lFqDYp9htvT8zBDaxfkxCwRYA5FtdQCZnW+rT3HydIIEMzSAdNAPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457696; c=relaxed/simple;
	bh=qsq70m9aoOeIKPhV+zDdYMShngSTVeO/RN0J0OIkiZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9+ubQ44oFhO5F6GlFNee71+PN/mLULuKyv8iUt2zKG73XjvQg7bTRvodnXSeyogfqK2oxVYEHOmT3rDgKtTU6v+uyoxKI4wjIsHh4fPfA0C7bAAeI56sJciZiBEK+cv7zi2zOaZXsW1xtIb3UmUrP6Fli0jZy+puwKAhWlmbEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=CSfDiocX reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4d9fHs747bz1DDXm;
	Tue, 18 Nov 2025 10:21:29 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4d9fHs4gx7z1DHYP;
	Tue, 18 Nov 2025 10:21:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1763457689;
	bh=QIto6meMbgfhU+k/5Zes9dtjfsi03cPshAM6CMpt0ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CSfDiocXNSrBkQFgGLnL1lUUe7KMmmXYMQRWZlLGL01di4/IC6WMi11Nmwdx74mPV
	 Cn+DZzAmvaJP3q01YXtf5gH88ycMFvSHZOYQ+jfFBI/vES6TbVDxfRdcOuxxdqO1gG
	 sxemoadA9KpasLJ6bZqDO9grhXT+Axig1LsowhxUedRzWb/I1/NKSVFGHh1yQHt7Bf
	 jeXAVApTydeItUR4gjYZKc92GeMqaXrnQLbGQxhPRUWK9v9JJ3exi2eIO6wWm+mcla
	 rD9Qcdx/yn/WCb3NexniyBge6SObZVApbKUMCQ3sd1wqBgdk7lyqOdiUGusalGKJ25
	 YWT89CG9URrYw==
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
Subject: [PATCH 02/10] dt-bindings: net: can: grcan: Convert GRCAN CAN controllers binding from txt to YAML
Date: Tue, 18 Nov 2025 10:21:07 +0100
Message-ID: <20251118092115.3455-3-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
References: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate device tree bindings for Gaisler GRCAN, GRHCAN
and GRCANFD CAN controllers from a text format to YAML format.
    - Add properties such as `compatible`, `reg`, `interrupts`
    and `clocks` for the CAN controllers.
    - Removal of the old `grcan.txt` file as its contents have
    been fully migrated to the YAML file.
    - YAML file includes examples of device tree bindings for
    the CAN controllers

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 .../bindings/net/can/gaisler,grcan.yaml       | 85 +++++++++++++++++++
 .../devicetree/bindings/net/can/grcan.txt     | 28 ------
 2 files changed, 85 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/grcan.txt

diff --git a/Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml b/Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
new file mode 100644
index 000000000000..521bdd89f130
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/gaisler,grcan.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:
+  Aeroflex Gaisler GRCAN, GRHCAN and GRCANFD CAN controllers.
+
+description: |
+  GRCAN, GRCANFD, GRHCAN controllers are available in the GRLIB VHDL IP core
+  library.
+
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
+  name:
+    description: |
+      Fallback on node name matching for systems that don't provide compatible.
+    enum:
+      - GAISLER_GRCAN
+      - 01_03d
+      - GAISLER_GRHCAN
+      - "01_034"
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
+      amba bus in the ordinary case).
+      This property should be used by systems that utilize the common clock
+      framework is not supported.
+
+unevaluatedProperties: false
+
+required:
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    can@ff400000 {
+        compatible = "gaisler,grcanfd";
+        clocks = <&sysclock>;
+        reg = <0xff400000 0x400>;
+        interrupt-parent = <&plic0>;
+        interrupts = <6>;
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    can@ff400000 {
+        compatible = "gaisler,grcan";
+        clocks = <&sysclock>;
+        reg = <0xff400000 0x400>;
+        interrupt-parent = <&plic0>;
+        interrupts = <6>;
+    };
+  - |
+    GAISLER_GRCAN@ff840000 {
+        reg = <0xff840000 0x400>;
+        freq = <50000000>;
+        interrupts = <16>;
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


