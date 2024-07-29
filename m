Return-Path: <linux-can+bounces-1037-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7862C93F62F
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 15:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3C3EB22D03
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 13:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C9F155306;
	Mon, 29 Jul 2024 13:06:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABD61527AC
	for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 13:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258416; cv=none; b=RRgcE9uCbnaCa69NRABjPdoD7sncBakSNs7FxGO7RxGzkZoWc2xcJK9Sf/gT0zXJnyapoU0nhCEIa5xaLnJFKk/Eoj2pSOJLK9oOKYqYRTtT4m70ejn5Lnq0SZS2FV8s7m6XIF2YbHHu62JLIfi6Y1MGlk52Fue6INJKPfCdO+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258416; c=relaxed/simple;
	bh=Ylk4E8mWgyeoiA2HWwD3MJ44Qbh7odVXIQZNZkvaPAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CFBpd+1f7BklYmm52CfY+05detw/u2YbJ6IlvEFh04JdqQwA6zR2uzMHYaaL51jTozbtSTiHJJHnS6qA0XAEHINyH8AEDDLI3+wUB7HyN3Ic7PjTgV1qz/9EgsqEYmIjo07zNPLXP8YtilsSopi/TobVV0f5jhU99DraEdp7DQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ5T-0008Sw-O9
	for linux-can@vger.kernel.org; Mon, 29 Jul 2024 15:06:51 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ5T-0032wT-AF
	for linux-can@vger.kernel.org; Mon, 29 Jul 2024 15:06:51 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id EF99B310D90
	for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 13:06:50 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 79070310D50;
	Mon, 29 Jul 2024 13:06:41 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id dabfbfe5;
	Mon, 29 Jul 2024 13:06:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 29 Jul 2024 15:05:33 +0200
Subject: [PATCH can-next 02/21] arm64: dts: rockchip: add CAN-FD controller
 nodes to rk3568
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-rockchip-canfd-v1-2-fa1250fd6be3@pengutronix.de>
References: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
In-Reply-To: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 David Jander <david.jander@protonic.nl>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, David Jander <david@protonic.nl>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=XWvrhlhwOQZD0wiXEfYS4fYeLnNF5MykEcA0bB9UIJM=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmp5O2g2OrIlmpRfYQY3bWUfPkaECgfR7gRcaXf
 EoUSRuKKf6JATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZqeTtgAKCRAoOKI+ei28
 bw0CB/wNMrNX+kyS6JMHtOlaMzU+PaGflZUOOSGIjl/MhkohflKCwUqyuvO6thjfDxY3V5Jvyp2
 ViybOT09LIr5nfMj1nhUZ0qbXTozcWJ1n6sN/k20pugIrrUpqxmFdQOQirTifFYxDjraIWyT/ON
 zBtNRy0VIyyy7/hZsgjzBcHXJN8mXIZ+0ZPMVVBsaNu0WzdH21G66wpUXRs0JpjFPk6XJhXUgPw
 elUJCOXdVAoTai6/+0T5jB/oNR5Ak1ZVAi9n2HDUT3KaVRlkcho2NjlpIE+JEkR8R7aJAlQTJp/
 5pTHlBUr7Pgf5F78YD4rKAKOSOAA5sPJ/7rsCciZyBZTvuM9
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: David Jander <david@protonic.nl>

Add nodes to the rk3568 devicetree to support the CAN-FD controllers.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm64/boot/dts/rockchip/rk3568.dtsi | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index f1be76a54ceb..26764d04f6ef 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -213,6 +213,45 @@ gmac0_mtl_tx_setup: tx-queues-config {
 		};
 	};
 
+	can0: can@fe570000 {
+		compatible = "rockchip,rk3568-canfd";
+		reg = <0x0 0xfe570000 0x0 0x1000>;
+		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru CLK_CAN0>, <&cru PCLK_CAN0>;
+		clock-names = "baudclk", "apb_pclk";
+		resets = <&cru SRST_CAN0>, <&cru SRST_P_CAN0>;
+		reset-names = "can", "can-apb";
+		pinctrl-names = "default";
+		pinctrl-0 = <&can0m0_pins>;
+		status = "disabled";
+	};
+
+	can1: can@fe580000 {
+		compatible = "rockchip,rk3568-canfd";
+		reg = <0x0 0xfe580000 0x0 0x1000>;
+		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru CLK_CAN1>, <&cru PCLK_CAN1>;
+		clock-names = "baudclk", "apb_pclk";
+		resets = <&cru SRST_CAN1>, <&cru SRST_P_CAN1>;
+		reset-names = "can", "can-apb";
+		pinctrl-names = "default";
+		pinctrl-0 = <&can1m0_pins>;
+		status = "disabled";
+	};
+
+	can2: can@fe590000 {
+		compatible = "rockchip,rk3568-canfd";
+		reg = <0x0 0xfe590000 0x0 0x1000>;
+		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru CLK_CAN2>, <&cru PCLK_CAN2>;
+		clock-names = "baudclk", "apb_pclk";
+		resets = <&cru SRST_CAN2>, <&cru SRST_P_CAN2>;
+		reset-names = "can", "can-apb";
+		pinctrl-names = "default";
+		pinctrl-0 = <&can2m0_pins>;
+		status = "disabled";
+	};
+
 	combphy0: phy@fe820000 {
 		compatible = "rockchip,rk3568-naneng-combphy";
 		reg = <0x0 0xfe820000 0x0 0x100>;

-- 
2.43.0



