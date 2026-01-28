Return-Path: <linux-can+bounces-6352-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPihL4siemmv2wEAu9opvQ
	(envelope-from <linux-can+bounces-6352-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:51:55 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C689AA33A6
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC9B93019139
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 14:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DB5363C79;
	Wed, 28 Jan 2026 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="ZNd9ZPke"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0FC29C351;
	Wed, 28 Jan 2026 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611772; cv=none; b=hzpX8OeZMK1R2W8eSadvQLL8bwMs4BmBqMr7TRk1+xTsrzsw619tIfLxLAYDF3DIP4MvxAo13YjGmdqRnL6/4W2u5HsUAhstEzEdEEQ3PTYMlV3C7TuAlJZiXV/LioNiVpxO13gafwuJ7SLx5lXGz9kpr1PsdG5adqJm/hg6zC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611772; c=relaxed/simple;
	bh=uH8Pe/J7AVvgFk9GqJLL0H34VTUppg+JpzhlnZrGObA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdQw09SEbT/5vtEZBCEnQQbjaCKDTN7FWVzBbNJHGFkNyGsx4Dx+/wUYn+bbHXMJ1uxMFlaKFYWBquoJ217MQ5zt12D5uYWnOEgj9vbOXUzE/xS/18MlJot7/Ex3POQiOIR8eWcYzxBNtlZNtWUFUXRN19zmp6m7kvlhx58nOd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=ZNd9ZPke reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f1QCW3FCGz1FDY7;
	Wed, 28 Jan 2026 15:49:27 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4f1QCW1Hbcz1DR2b;
	Wed, 28 Jan 2026 15:49:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769611767;
	bh=YB2t286nraRNB5mAmjhOvxJnKyocZr4eSz/qausgjto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZNd9ZPkev3ttYRPfGxomxqvO/DD7VdiQjW3u/5FVU8PievEAU3tvPsX6j97LeBJDt
	 R/80fkUGSFz9bxpTHrA0bOjN95a/i7Ko4x6EO1gJn2mDJtsWULNOp6VrVh1g9iuXcG
	 hk8pAV10ZXYC2F5n8vwlbUgZKxxNUd1QeBNCrLZzK288TiWsWtAWpJzmULrGYVHrRe
	 rn71B4T89V+iSzRnTa2T7C79J8crg+HwG9ngk4CjNtdvV58vq2+jbFsFS1jLmj8WrA
	 p4VHkDK3ZPDqEpt15n6bMq2+5n9p02fiWt/R5O12AooU6oMo3GYi1xOCB0x2kVj2KN
	 Vn75NtkcSfggA==
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
Subject: [PATCH v4 02/15] net: can: Convert gaisler,grcan to DT schema
Date: Wed, 28 Jan 2026 15:49:08 +0100
Message-ID: <20260128144921.5458-3-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128144921.5458-1-arun.muthusamy@gaisler.com>
References: <20260128144921.5458-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6352-lists,linux-can=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:~];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ff400000:email,gaisler.com:email,gaisler.com:url,gaisler.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,devicetree.org:url]
X-Rspamd-Queue-Id: C689AA33A6
X-Rspamd-Action: no action

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

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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


