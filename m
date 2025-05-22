Return-Path: <linux-can+bounces-3623-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F6CAC053F
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 09:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CDE59E1854
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 07:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721F3221FCC;
	Thu, 22 May 2025 07:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Bd4QCM0t"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m3279.qiye.163.com (mail-m3279.qiye.163.com [220.197.32.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5BF221D8F;
	Thu, 22 May 2025 07:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897694; cv=none; b=q4WUyuwwSe+9OA55YNIVZf+2laEX5S/zxjvrcS9hP1lWgDHDZed75htyveL90aCpeJOv9a9OUzs7E3fYHGpUoYpsnwe8F92p1Whhy5MmDVpYg8MBDKsCnGh6h0KqNolzltgWtDJdiPdQJpphbYq1PFx6abCyp9Q1tsKgK2ErD4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897694; c=relaxed/simple;
	bh=k89P5n3vG1Bm60U8ry2B6uMqPmDuDbKuMvquhY1bQ+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jjkJHs0vrd9AnwILaS+JjWKXSvbv9GuKXB+y877zVcsMwqv0wxscHltmCgWmgEwuRV4+n0TVOn/mczxqg2CFwHzlU4CglqRqcgTeGQueVlHSHAk5VYuG+izL0F+0+CSC5NVZjFDrnhuy3AmrsvmyKm9cioEa5666mwZyTI2zOIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Bd4QCM0t; arc=none smtp.client-ip=220.197.32.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1602d1566;
	Thu, 22 May 2025 14:32:35 +0800 (GMT+08:00)
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
Subject: [PATCH v3 1/3] dt-bindings: can: rockchip_canfd: add rk3576 CAN-FD controller
Date: Thu, 22 May 2025 14:32:30 +0800
Message-Id: <20250522063232.2197432-2-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250522063232.2197432-1-zhangqing@rock-chips.com>
References: <20250522063232.2197432-1-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0sYTFZIT0lIS0odQhkeHkNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96f6b1957f03a3kunme211611210aaa93
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OAw6Agw5FDE3LhIRDEMiEA42
	PzhPCwJVSlVKTE9MQ0JOTk5NQkNNVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhJSkk3Bg++
DKIM-Signature:a=rsa-sha256;
	b=Bd4QCM0tbtFm/iaCR7PjOLmCNQ33/qZch0gsrcXS3HtGqur50gDoSrvbtUwjXXY+tJB4WraKl5tRU/AI28lrCt6FpukbMn2n8S075AyswZgA3eDE+WZdmg3Rbo6camrfta3sujShGHb+tHNxTNSRHc9YhtcgyonOb9Fba9OPQMc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=YrD/3cMaELrj0WxecR8TGpVQ/1vDEVc4Rj278Y6+gmg=;
	h=date:mime-version:subject:message-id:from;

Add documentation for the rockchip rk3576 CAN-FD controller.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 .../net/can/rockchip,rk3576-canfd.yaml        | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/rockchip,rk3576-canfd.yaml

diff --git a/Documentation/devicetree/bindings/net/can/rockchip,rk3576-canfd.yaml b/Documentation/devicetree/bindings/net/can/rockchip,rk3576-canfd.yaml
new file mode 100644
index 000000000000..85caf6d19607
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/rockchip,rk3576-canfd.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/rockchip,rk3568v2-canfd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:
+  Rk3576 CAN-FD controller
+
+maintainers:
+  - Elaine Zhang <zhangqing@rock-chips.com>
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
+        can0: can@2ac00000 {
+            compatible = "rockchip,rk3576-canfd";
+	    reg = <0x0 0x2ac00000 0x0 0x1000>;
+	    interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+	    clocks = <&cru CLK_CAN0>, <&cru HCLK_CAN0>;
+	    clock-names = "baud", "pclk";
+	    resets = <&cru SRST_CAN0>, <&cru SRST_H_CAN0>;
+	    reset-names = "can", "can-apb";
+	    dmas = <&dmac0 20>;
+	    dma-names = "rx";
+	    status = "disabled";
+	};
+    };
-- 
2.34.1


