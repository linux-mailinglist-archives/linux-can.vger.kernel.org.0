Return-Path: <linux-can+bounces-3667-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8F4AC0B87
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 14:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42E0D7AB9A3
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 12:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5840F28B3E2;
	Thu, 22 May 2025 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="bJOPrgzU"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m1973187.qiye.163.com (mail-m1973187.qiye.163.com [220.197.31.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916A728A723
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747916545; cv=none; b=OGQFo2YeoheKVBMGN6kb9aefDaG5cM6g5Dur35r7WkzexLXzEZRZtNSMu9kvmG0cGw/BU8Q6wmGtE05HVEAn5ycHEnYqKzVRFRx74l3BHcVOX/ER+Chbf8qMG+qJbIBoZrSmevDr7ps95H3RvJLoOme8qRgVLSI7UDT+55ZTDyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747916545; c=relaxed/simple;
	bh=T/SlOdAyLKmKnIzRMqiU/fysm84cu/CpPPQrT5F13U4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pZ4wnmC34Ys1wbXf5UNZYXnxXDcThynTMhvsFXeJ+23pPeFpBjVdbDaWJdBMZTB59sd5AaAQoogXWrKZJf76DQp5Lt0DcQnimtux4Po0JJrXx+y+t003mZIWjc3IOq81o4hjC8pgL05jxymQs7/g/Muly71bYvflYriEGdeO3YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=bJOPrgzU; arc=none smtp.client-ip=220.197.31.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1605e6629;
	Thu, 22 May 2025 15:46:22 +0800 (GMT+08:00)
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
Subject: [PATCH v4 3/3] arm64: dts: rockchip: rk3576: add can dts nodes
Date: Thu, 22 May 2025 15:46:16 +0800
Message-Id: <20250522074616.3115348-4-zhangqing@rock-chips.com>
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
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhlDT1ZOTE1ITR0aH0lLGB5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96f6f523e703a3kunm9938470210de8a5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nhg6Nyo4CTE6CBJRFDo4DhBJ
	FQtPCzlVSlVKTE9MQ0JCQkNPSE9NVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlJTkw3Bg++
DKIM-Signature:a=rsa-sha256;
	b=bJOPrgzURtsI3K771YR80ExrKFoikF1VgAqoMcjC2BwMbfUtCcSZgF4gyWfog4MO44V2m8h4B8upoXoZk8W3Mi3VXyvblF6mhE3Dj7SOhUm0IjdXXEQQwpQrJAyDRmM0b1x8V7SJmWwPQg403pr5GDzFuS+F7a7qf07W7eBTxmM=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=5IrppD+noS0OCQj8srA99WHmG3PCHUwAcMuiVB1ALqE=;
	h=date:mime-version:subject:message-id:from;

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 436232ffe4d1..ca665c29a72d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1195,6 +1195,28 @@ dmac2: dma-controller@2abd0000 {
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
+			status = "disabled";
+		};
+
 		i2c1: i2c@2ac40000 {
 			compatible = "rockchip,rk3576-i2c", "rockchip,rk3399-i2c";
 			reg = <0x0 0x2ac40000 0x0 0x1000>;
-- 
2.34.1


