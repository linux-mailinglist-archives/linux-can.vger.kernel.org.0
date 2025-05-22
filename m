Return-Path: <linux-can+bounces-3619-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FFEAC049B
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 08:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60B49189FBB1
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 06:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5934D1A5BA2;
	Thu, 22 May 2025 06:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="G5JkPvUu"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m3271.qiye.163.com (mail-m3271.qiye.163.com [220.197.32.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EBA29A0;
	Thu, 22 May 2025 06:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747895573; cv=none; b=tiPgtB7gccDiqm8EK0LVRddpv0Ri+wa+cEQyoduRU9QbxuATqhTOST5oeUmim8HF7n+oMTW1LTyr93H/rvU3KFR+cSRK5KX28PB0OXNjIfdWD6MvfepTJODYMX9awQkHOkRyzJTKDgDVKkh3Vj2IpIjk2rVU9iP5M9j+H4OjI5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747895573; c=relaxed/simple;
	bh=T/SlOdAyLKmKnIzRMqiU/fysm84cu/CpPPQrT5F13U4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MkPF/Vm9b72ZnweXBcbQeViSh4JBRCoaL8mhtOVLfRBM+YtNsU9ZnzOOM6v25AoD6xvmgCori9d7NfKRdUdHqe8QxI3+2QGY2KTJk0m+5AiXklIBR97EUM7MFUVngy+eUMjdqPhQa/iZRVJ6ldXNvr8G8w3mu7IBNw4RSix+3cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=G5JkPvUu; arc=none smtp.client-ip=220.197.32.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1602d1577;
	Thu, 22 May 2025 14:32:38 +0800 (GMT+08:00)
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
Subject: [PATCH v3 3/3] arm64: dts: rockchip: rk3576: add can dts nodes
Date: Thu, 22 May 2025 14:32:32 +0800
Message-Id: <20250522063232.2197432-4-zhangqing@rock-chips.com>
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
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRoaTVZDTh9PTkMeQkxIGBlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96f6b1a29703a3kunme211611210aab3f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MQw6Lzo6PTExCBIMKkMjEAsM
	DQ0wFDxVSlVKTE9MQ0JOTk1LSUpIVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlJTkw3Bg++
DKIM-Signature:a=rsa-sha256;
	b=G5JkPvUu6PwLVwBm8RzetK8sUJx0D2rodK40gP2ZxJe40N0MF/CFJCMAHCj6KI98D+2BVWvODGdeYYhw90TfS0U7JDZBV2nZW8PlL+sPtJZfK50jdXtPRYGoGy/n8i1sZOG5nOQIqteZ8x6peVM5Rhel9qxSdFPCMvSHPSdBHY0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
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


