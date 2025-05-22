Return-Path: <linux-can+bounces-3625-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3DAAC0623
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 09:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337464A2B53
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 07:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994C424EA8F;
	Thu, 22 May 2025 07:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="FK15/UGO"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m1973187.qiye.163.com (mail-m1973187.qiye.163.com [220.197.31.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B10A24E018;
	Thu, 22 May 2025 07:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747900301; cv=none; b=OfuvbIHd/z4glf3/V3t6VReRmvBaJt/c0rTrO1VE0pfdDXjKLalX02bB37Y5SmkzKO+z1s91XLApjqmQvmz1CNUxStdJsX3OK6DxYfbVLGq71C7mfRiR7MLhIlgiSMbqv4f0ObX+ebj+emOp1QGpSIOYpeR4LM5latbMwmXmODo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747900301; c=relaxed/simple;
	bh=KSE/13L21jv542igjXTJaR/srnd4XDhRnn+5wrBwLds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kA4DnRfLpcGVaZMVZIFuRUA2qW0SdXfVPdW47eZZHFzwagm3v2AWyy/2AfrY1/K0IQEwzlCX+VsXwbl3wBzN0bDuhdu2eJemvV+TM9amxNaLj7DNGdi4CIDWDcT4NuDGs3Vi19I3iP1m/VY8EB09gIgxdpXH5rzyS6+MS19mlhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=FK15/UGO; arc=none smtp.client-ip=220.197.31.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1605e6616;
	Thu, 22 May 2025 15:46:19 +0800 (GMT+08:00)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: zhangqing@rock-chips.com,
	mkl@pengutronix.de,
	kernel@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	cl@rock-chips.com,
	kever.yang@rock-chips.com
Cc: linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: can: rockchip_canfd: add rk3576 CAN-FD controller
Date: Thu, 22 May 2025 15:46:14 +0800
Message-Id: <20250522074616.3115348-2-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250522074616.3115348-1-zhangqing@rock-chips.com>
References: <20250522074616.3115348-1-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxhKGFZKT08ZTkpJSkJDH0xWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96f6f5159403a3kunm9938470210de7df
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MQw6DRw4EDErSRIdFDkIDioR
	Sk0aCg1VSlVKTE9MQ0JCQkNLTE1NVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhNT0w3Bg++
DKIM-Signature:a=rsa-sha256;
	b=FK15/UGOrM1d3ijQsGPHOP+kfPIGzLjpaJ3Cy7BZp44G70Jxtk1kJn8JZU7dNcEQl6zRNByLFT1r/PuuA4LbYoAXM8ogBb+DqdwJ7hNUvG28VWYMOL77J9rcn6XKXu6lkzR32R8HJLojpd+9+cQzLYsXDXe65JidE1s9o91Bh/8=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=4al1jfV+gfDcE24VQEE5ZPdX0f6fZQNGeI5FgpmdT0c=;
	h=date:mime-version:subject:message-id:from;

Add documentation for the rockchip rk3576 CAN-FD controller.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 .../net/can/rockchip,rk3576-canfd.yaml        | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/rockchip,rk3576-canfd.yaml

diff --git a/Documentation/devicetree/bindings/net/can/rockchip,rk3576-canfd.yaml b/Documentation/devicetree/bindings/net/can/rockchip,rk3576-canfd.yaml
new file mode 100644
index 000000000000..c4526bfe2073
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/rockchip,rk3576-canfd.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/rockchip,rk3576-canfd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rk3576 CAN-FD controller
+
+maintainers:
+  - Marc Kleine-Budde <mkl@pengutronix.de>
+
+allOf:
+  - $ref: can-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: rockchip,rk3576-canfd
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: baud
+      - const: pclk
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: core
+      - const: apb
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    items:
+      - const: rx
+
+  rockchip,auto-retx-cnt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: After TX fails, it attempts to automatically retransmit the number of times. If it is not configured, it will keep trying to retransmit.
+
+  rockchip,rx-max-data:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: CAN Rx data size(unit word). CAN frames can be configured as 4, and CANFD frames can be configured as 18.If not configured, it defaults to 18.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - dmas
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rockchip,rk3576-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        can@2ac00000 {
+            compatible = "rockchip,rk3576-canfd";
+            reg = <0x0 0x2ac00000 0x0 0x1000>;
+            interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cru CLK_CAN0>, <&cru PCLK_CAN0>;
+            clock-names = "baud", "pclk";
+            resets = <&cru SRST_CAN0>, <&cru SRST_P_CAN0>;
+            reset-names = "core", "apb";
+        };
+    };
-- 
2.34.1


