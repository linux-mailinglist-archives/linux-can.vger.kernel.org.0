Return-Path: <linux-can+bounces-5338-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A25C50482
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 03:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5878F189B84C
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 02:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82BB29BD8E;
	Wed, 12 Nov 2025 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="SNh991fB"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m49223.qiye.163.com (mail-m49223.qiye.163.com [45.254.49.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ABE29994B;
	Wed, 12 Nov 2025 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912795; cv=none; b=PeSad0n9zQEn1LHLpqPRgJ4O2rCyspDB93MJoHSHQA+6Dp3WqfyV0e3nD6Qdohc94DowTSBa2UpNBzuvY3BCBmtreFPZfUGzEz+Yc6EiQyNwbXoEicmZ9NNAIFrc2DvoPd8a+B8q+8HGIFcNTlPq2jldWM2gE5+ZNDeB8bcDbwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912795; c=relaxed/simple;
	bh=zJO17dFWztKd52ye3rVlJnGNdN8EwFkk+B4EwPpOQNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PGVqTlnViuvAy/QLmFtKQpYQGxuJiDWK94112BIVqmLSPIo/39ianeGRlYvFo7LspASVhlpnDATccLBfLq3jUJ8ovwakvW8MhxZvXtHUenLsOdwtcdsYm6WO/9R1EEJWhGy82s19r2FIfzjEwsUDvrUMuP7+g3dmrIdkxVloovc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=SNh991fB; arc=none smtp.client-ip=45.254.49.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2941ca60b;
	Wed, 12 Nov 2025 09:59:42 +0800 (GMT+08:00)
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
Date: Wed, 12 Nov 2025 09:59:37 +0800
Message-Id: <20251112015940.3695638-2-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112015940.3695638-1-zhangqing@rock-chips.com>
References: <20251112015940.3695638-1-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a75ca4a2803a3kunm5e00f3261f0708
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkgfSVZKT0MdTUwYSR9PS0JWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=SNh991fBzKaGqM8MsVy8B0PE/YSM+BRhYc8Al6YvWYQn8cf0a3DO5a5cDFwZD2B4x1hesZ/H0zJsHsA9jfnmV4NDATUk9RfNwuHUhEPZlKZT9X/ZXM5oBe3jkoJa4zHiMHov/cdLIxyT0mnQxdJwZMFrsdlos+rRWPvhuh/KMCI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=5jlNOBZ/fcIvDq+MUV6cC4EWNKpgXZB+f3K4bCpTHTU=;
	h=date:mime-version:subject:message-id:from;

Add documentation for the rockchip rk3576 CAN controller.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 .../bindings/net/can/rockchip,rk3568v2-canfd.yaml  | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
index a077c0330013..22e10494e7d1 100644
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
@@ -43,6 +42,13 @@ properties:
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
-- 
2.34.1


