Return-Path: <linux-can+bounces-3671-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFBEAC1E54
	for <lists+linux-can@lfdr.de>; Fri, 23 May 2025 10:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91EC51B66501
	for <lists+linux-can@lfdr.de>; Fri, 23 May 2025 08:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5392882A6;
	Fri, 23 May 2025 08:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fhxsDPqD"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m49236.qiye.163.com (mail-m49236.qiye.163.com [45.254.49.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4D9286D45;
	Fri, 23 May 2025 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747987790; cv=none; b=AOeum++Lc5AOUy63uUznT44FRw1Af9xa7h5PSe0IpT5RfO5acdjiM8pFbRWPC50cdQnf8lYh9Q5TphFFb+Kq5eLssSkONLaLi76nQQf1x9gWulzcDHVGVh+BNbJ8NSBanh1tPDmDLSAwHUsfuqVI9NiKrGzEC6g3Px/s6zA4vsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747987790; c=relaxed/simple;
	bh=RThPFsAaD2E0xzlCf7d/TjbxGHfXhIj29Z6UO+WQm2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r8yeRa5EAyr0egZyVIr7DEojIQVQGxVJCSAJH9mFSTcVCddBjQ1RrDprf3w1nePYPRHm6AzslWX1B5bIY3Ffk/lAgIoBL+eiTG1iINE2YYIRfOXXJttWxKEIuU5L92589yNnf89MlJbWHpz1cNztLw8M5lGJHwG3zqb+lMaLUhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fhxsDPqD; arc=none smtp.client-ip=45.254.49.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1628045cb;
	Fri, 23 May 2025 15:54:25 +0800 (GMT+08:00)
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
Subject: [PATCH v5 1/4] dt-bindings: can: rockchip_canfd: add rk3576 CAN-FD controller
Date: Fri, 23 May 2025 15:54:19 +0800
Message-Id: <20250523075422.4010083-2-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250523075422.4010083-1-zhangqing@rock-chips.com>
References: <20250523075422.4010083-1-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR5NSlZKSEhJTB1CQx5CSUNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96fc22df3003a3kunm893a9d4d11dad6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OiI6Nio6OjE3KhUVEh9LDihC
	TQ5PC05VSlVKTE9MQkNNQ01MTUhPVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlOSUI3Bg++
DKIM-Signature:a=rsa-sha256;
	b=fhxsDPqDmyusPeEvA2QgLAU3lNNOfwIHpFA2l7M3CowNzau62ci9E+z4ZnE3Y4eYvC/9uvHXk8vDS12xFTP3R9ggakF8GPpARpsTj57ID/eTRZ+bdU+oZu7u7zj3yuJvgF35fzpe97vQBeotN4bEaMhMUDncd0eNnm121v008D0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=+khz/o7a5PPghtgkY2ZXtUUFn068QElniJYEgmUtOrI=;
	h=date:mime-version:subject:message-id:from;

Add documentation for the rockchip rk3576 CAN-FD controller.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 .../net/can/rockchip,rk3568v2-canfd.yaml      | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
index a077c0330013..e5dfce382061 100644
--- a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     oneOf:
       - const: rockchip,rk3568v2-canfd
+      - const: rockchip,rk3576-canfd
       - items:
           - const: rockchip,rk3568v3-canfd
           - const: rockchip,rk3568v2-canfd
@@ -43,6 +44,13 @@ properties:
       - const: core
       - const: apb
 
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    items:
+      - const: rx
+
 required:
   - compatible
   - reg
@@ -72,3 +80,19 @@ examples:
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


