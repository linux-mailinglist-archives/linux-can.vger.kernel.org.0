Return-Path: <linux-can+bounces-5475-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07641C66E50
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 02:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC4284E1B83
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 01:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF2330DD2A;
	Tue, 18 Nov 2025 01:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="kD9D+0G3"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m19731120.qiye.163.com (mail-m19731120.qiye.163.com [220.197.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB76A2652A2;
	Tue, 18 Nov 2025 01:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763430897; cv=none; b=aZt3rR/IBiRH5LVa5EnJWITLLn6jCcJkvD+OP0YyJ+r+wVvdRKizLWgATKvjyN1qWynlkhFXKxtVtlhsIdkxGLVY5rrK6IqKEz2lartI862ME9eBzu+f29vNZI1/Nz0pCL3NuOYbjIr+A6uCB5cN2Pyzrx4HqCH5WABRtF4oii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763430897; c=relaxed/simple;
	bh=+kVnqaB0lrpd7D3FvJPlRq9Q7RQhh7yXcdQUyRguk8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JWo6drjBrXx1eQHdYWPTzYHZTKN6Cu08+aC8S25uMxR8BwGIS5NusWhdXJdpsjfuTTGuUDuNJwyadE0HJwwEsG40nXKJzaTt9TfwvZMNy7+eUZWpp/Fw3aI4eLkvZJvRuax47Ct15Fpn22PMs/aIY+ai5DNISToUe03J4Mz27+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=kD9D+0G3; arc=none smtp.client-ip=220.197.31.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 29e9c374b;
	Tue, 18 Nov 2025 09:39:32 +0800 (GMT+08:00)
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
	devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v10 1/3] dt-bindings: can: rockchip_canfd: add rk3576 CAN controller
Date: Tue, 18 Nov 2025 09:39:27 +0800
Message-Id: <20251118013929.2697132-2-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118013929.2697132-1-zhangqing@rock-chips.com>
References: <20251118013929.2697132-1-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a949df9ae03a3kunm07a8ba9e476b5
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU1NH1ZJHk5DSUNOS0IeSE1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=kD9D+0G31JBldVFzx/KZq6CFF8hCL6FQ6eZO85HYB5Z1XhOv1ciMKh9GyEa75QQFjJ9bYuJnPrnanI0YYhqDgfKQ+ZlI6GKb1CjiDGp1ons5h8s8JofTbzzG92Ok6QsBymIrp6U6rb2DFd1rij+sGkxElFTBBjSxHJRXFnVT+r0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=n0nXALYficq2cYLdsPhzBWeGzcheK/HRmbHGFZXXVBQ=;
	h=date:mime-version:subject:message-id:from;

Add documentation for the rockchip rk3576 CAN controller.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml  | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
index a077c0330013..d63c8c8e3f45 100644
--- a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
@@ -16,7 +16,9 @@ allOf:
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
-- 
2.34.1


