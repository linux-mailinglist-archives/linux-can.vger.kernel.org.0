Return-Path: <linux-can+bounces-2421-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F899F4108
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2024 03:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1DB41688C8
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2024 02:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21FF15B0EC;
	Tue, 17 Dec 2024 02:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="WRSzkUcL"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m11879.qiye.163.com (mail-m11879.qiye.163.com [115.236.118.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D620A15A85A;
	Tue, 17 Dec 2024 02:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.118.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734403482; cv=none; b=Og1wsaE3j3RrYoD0LKei37MWMBieedLLSRGeTO0l7ExQZJkrS2nAE2S9XZ/vgb5tDx2Lt6eMPGx3Z4BGkxi1tnQVUGpqO0pj4zDPK3B5zu0/PSoo5fUwYmJO9mvxZuSPItvsbULzmmDjc3AQ0evI3V+8iwCQ0XN+bldOO6simKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734403482; c=relaxed/simple;
	bh=9n/zI/O7haEMeDpiOaVz2plrsy4gpJ2Kt2kHVN/A0qc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tEXwy8k3/rIiSplxpIXLix1hvyl0i+c3AJBQJPVUGgCxk7BTM5bhmJUAmIx7PTj5t6kjIxHrOuaCd/0bfKprRvkU7E5/tUSnGCS9qh3OZ8zGOHjJBDfGXpmv6jhkPzoZBEV5X1AkNlwMW3piGyTC7MkW6biT3ePhNWAq4qZ5vGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=WRSzkUcL; arc=none smtp.client-ip=115.236.118.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5ec156bf;
	Tue, 17 Dec 2024 10:39:22 +0800 (GMT+08:00)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: zhangqing@rock-chips.com,
	mkl@pengutronix.de,
	kernel@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	heiko@sntech.de,
	cl@rock-chips.com,
	kever.yang@rock-chips.com
Cc: linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: rockchip: rk3576: add can dts nodes
Date: Tue, 17 Dec 2024 10:39:08 +0800
Message-Id: <20241217023908.1292999-3-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217023908.1292999-1-zhangqing@rock-chips.com>
References: <20241217023908.1292999-1-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh9JTFYfSkJLTEsfGkpOTUtWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a93d27c02cf03a3kunm5ec156bf
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ny46Dio5LTILTR84IwoSUT0N
	DDNPCwFVSlVKTEhPT0tISk1IQklIVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpPQko3Bg++
DKIM-Signature:a=rsa-sha256;
	b=WRSzkUcLFHUQwjHZ9FgA80+ljrbvUmQfByWfj/cQfxVhXpURm/hQJeGmnGypOut36OH8y8qHTwwEjeLSvTU+CTNOKRmb0jl/cvYNDFZrNHQLgbLkj/dx8SY3bsndragufi3Nr1KyrcOxLCSuVKdBzM4vjLxNjGVwzaC0/WtgM8c=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=mbc4XvnMPoqYWmjqlM+MGD27w/PMpYBtQHdgk1ZuX98=;
	h=date:mime-version:subject:message-id:from;

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 436232ffe4d1..82fdfd4720ec 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1195,6 +1195,32 @@ dmac2: dma-controller@2abd0000 {
 			#dma-cells = <1>;
 		};
 
+		can0: can@2ac00000 {
+			compatible = "rockchip,rk3576-canfd";
+			reg = <0x0 0x2ac00000 0x0 0x1000>;
+			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru CLK_CAN0>, <&cru HCLK_CAN0>;
+			clock-names = "baudclk", "apb_pclk";
+			resets = <&cru SRST_CAN0>, <&cru SRST_H_CAN0>;
+			reset-names = "can", "can-apb";
+			dmas = <&dmac0 20>;
+			dma-names = "rx";
+			status = "disabled";
+		};
+	
+		can1: can@2ac10000 {
+			compatible = "rockchip,rk3576-canfd";
+			reg = <0x0 0x2ac10000 0x0 0x1000>;
+			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru CLK_CAN1>, <&cru HCLK_CAN1>;
+			clock-names = "baudclk", "apb_pclk";
+			resets = <&cru SRST_CAN1>, <&cru SRST_H_CAN1>;
+			reset-names = "can", "can-apb";
+			dmas = <&dmac1 21>;
+			dma-names = "rx";
+			status = "disabled";
+		};
+
 		i2c1: i2c@2ac40000 {
 			compatible = "rockchip,rk3576-i2c", "rockchip,rk3399-i2c";
 			reg = <0x0 0x2ac40000 0x0 0x1000>;
-- 
2.34.1


