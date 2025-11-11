Return-Path: <linux-can+bounces-5331-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC24C4C700
	for <lists+linux-can@lfdr.de>; Tue, 11 Nov 2025 09:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 740F14F2E57
	for <lists+linux-can@lfdr.de>; Tue, 11 Nov 2025 08:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C87279787;
	Tue, 11 Nov 2025 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="VHrUP/C1"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m19731106.qiye.163.com (mail-m19731106.qiye.163.com [220.197.31.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F14135950;
	Tue, 11 Nov 2025 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762850445; cv=none; b=iGNShCLtxECPXonofn7v6BXZ9iQOq5cR+PD1/5f07VMjbqygTsNd4eJQcysjM7LZ9riGIbzucc7wisA+tmPmfITQM6tMR6r1rrt7u4S1h1wivddDmlwnXDEUfYaGTrp/XykVq+Wqkr0NWZ1r3n2LaAXnrdSfGvUm10Z9GqxykdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762850445; c=relaxed/simple;
	bh=ahWoNiPFiacsG3ByOWJ5VqRS3uOojLY2l0vxUzhSz24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jRkYabuMAE26Sc+GCyGPZU7WKVwmxEAv/Veq/vAAglHwLrLtkUJlW75NpitPD8Ip7IkT/6Uipv+bSqI3ngBah645CRi/IiOwaXyMUM/5Z+qzjqnyoB+Vqu04lBCpnLcUdfSA2RWpBnlSep83bYw/4qSZVG19AyMWziO/KDpmegs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=VHrUP/C1; arc=none smtp.client-ip=220.197.31.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 292aa4268;
	Tue, 11 Nov 2025 16:05:13 +0800 (GMT+08:00)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: zhangqing@rock-chips.com,
	mkl@pengutronix.de,
	kernel@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	cl@rock-chips.com
Cc: linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [RESEND PATCH v8 1/4] dt-bindings: can: rockchip_canfd: add rk3576 CAN controller
Date: Tue, 11 Nov 2025 16:05:11 +0800
Message-Id: <20251111080511.2923069-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a71f28fdc03a3kunmee592256114418
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0tJGlZMQ05CQxhLHR9LQh5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=VHrUP/C111FM7HuPElGhHEj2Gm15BC/PaE4hhAynibdjVRtkUQtBzCWkQtb7DfWCkHz0aOgKbq6DGJrz6aBZfyJ7WAxAPPVH+0ZbzoUHPniqW6ukp+yUMxaZqcvPcTQAk6WnnSKKWQ2Pn12J5r9JlpTXeJR5ipGjGLQXdG8EhbU=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=TzFB3ApKB9zrOotJbEs5MN7Ng0C5RnZ/+2zE1nfohi0=;
	h=date:mime-version:subject:message-id:from;

Add documentation for the rockchip rk3576 CAN controller.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 .../net/can/rockchip,rk3568v2-canfd.yaml      | 52 +++++++++++++++++--
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
index a077c0330013..30782218728e 100644
--- a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
@@ -10,13 +10,12 @@ title:
 maintainers:
   - Marc Kleine-Budde <mkl@pengutronix.de>
 
-allOf:
-  - $ref: can-controller.yaml#
-
 properties:
   compatible:
     oneOf:
-      - const: rockchip,rk3568v2-canfd
+      - enum:
+          - rockchip,rk3568v2-canfd
+          - rockchip,rk3576-can
       - items:
           - const: rockchip,rk3568v3-canfd
           - const: rockchip,rk3568v2-canfd
@@ -43,6 +42,33 @@ properties:
       - const: core
       - const: apb
 
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    items:
+      - const: rx
+
+allOf:
+  - $ref: can-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3576-can
+    then:
+      properties:
+        dmas:
+          minItems: 1
+          maxItems: 1
+        dma-names:
+          minItems: 1
+          maxItems: 1
+    else:
+      properties:
+        dmas: false
+        dma-names: false
+
 required:
   - compatible
   - reg
@@ -72,3 +98,21 @@ examples:
             reset-names = "core", "apb";
         };
     };
+
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        can@2ac00000 {
+            compatible = "rockchip,rk3576-can";
+            reg = <0x0 0x2ac00000 0x0 0x1000>;
+            interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cru CLK_CAN0>, <&cru PCLK_CAN0>;
+            clock-names = "baud", "pclk";
+            resets = <&cru SRST_CAN0>, <&cru SRST_P_CAN0>;
+            reset-names = "core", "apb";
+            dmas = <&dmac0 20>;
+            dma-names = "rx";
+        };
+    };
-- 
2.34.1


