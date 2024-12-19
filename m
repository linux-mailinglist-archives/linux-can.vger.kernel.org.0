Return-Path: <linux-can+bounces-2452-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 577079F719B
	for <lists+linux-can@lfdr.de>; Thu, 19 Dec 2024 02:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6065B7A2FFA
	for <lists+linux-can@lfdr.de>; Thu, 19 Dec 2024 01:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E045B2AE96;
	Thu, 19 Dec 2024 01:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZPCOb3Aw"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m60103.netease.com (mail-m60103.netease.com [210.79.60.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA24AD5A;
	Thu, 19 Dec 2024 01:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.79.60.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734571045; cv=none; b=okcM+X5KiHQKG7Jro7toHz5EXHDYNXLP/D6o30Os5gU28qdHaddCA5KRjpBBS1LrWhqiAeURg5eWoB5ejFpYMFEKCasPVNicOKSfJS/MjHEW9g0Q2bEOiUZpCuX2YluYiN3VJpYEFE8oBGKZcNsjGjwYdI6inTLOP0sMplo3X+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734571045; c=relaxed/simple;
	bh=e7jMw5nuQprl7AvcvKzUZSM092iEsTyrE8UmwNrHPS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mLUAlcitGa7z6YdUBKZr+d9QMjTqFGb7IJTbBEkTvrumVJDAHzdHcJomMsFXV53r9L0rBW5HgxD3XiAYmku4YURIKag0eM0IT1mtClhhVFvO2OKJ5Su3mNi3Jrh4TAcP/fmKlDasQWB+7V0uhtr4Fs/A0pJywsFIg68ygimKWnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ZPCOb3Aw; arc=none smtp.client-ip=210.79.60.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 626be1a6;
	Thu, 19 Dec 2024 09:12:03 +0800 (GMT+08:00)
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
Subject: [PATCH v2 2/2] arm64: dts: rockchip: rk3576: add can dts nodes
Date: Thu, 19 Dec 2024 09:11:59 +0800
Message-Id: <20241219011159.3357530-3-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219011159.3357530-1-zhangqing@rock-chips.com>
References: <20241219011159.3357530-1-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk0aTlZDGklKGkNCHR9DS05WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCS0
	NVSktLVUpCWQY+
X-HM-Tid: 0a93dc78c72003a3kunm626be1a6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OVE6Ngw6NjIKPhcDIh8IMEIt
	LgkaFE5VSlVKTEhPTkxLTElPSk1MVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpPQks3Bg++
DKIM-Signature:a=rsa-sha256;
	b=ZPCOb3AwfxvQsOncQo5jgZGTjSUcCXRF6cHwKJSQv42xCl8KKCNjHXTY8HAmCNao2nydA+BIMDnMd4rfSW14Fp6yM/ho+UOabXTJ9gi6nkTIS4SBjysNpmJOCgvjAlwRl0ZDt0uHWQCBrteIIEnUWyWSrS1GAWVFg8hgjzhcI04=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=NF4rStkw0AAJ3+AgUeRof/dz2uW1bUTsT5f/s3AyNRY=;
	h=date:mime-version:subject:message-id:from;

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 436232ffe4d1..eefae2b5e6e4 100644
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


