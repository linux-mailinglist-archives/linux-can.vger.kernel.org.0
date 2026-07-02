Return-Path: <linux-can+bounces-7962-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o5H9AgtyRmrGVAsAu9opvQ
	(envelope-from <linux-can+bounces-7962-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 16:13:31 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F256F8C02
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 16:13:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=TULst1VV;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7962-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7962-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 806A631387FD
	for <lists+linux-can@lfdr.de>; Thu,  2 Jul 2026 14:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA564C6EF1;
	Thu,  2 Jul 2026 14:07:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3659220F49
	for <linux-can@vger.kernel.org>; Thu,  2 Jul 2026 14:07:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001270; cv=none; b=ay4g2lMwZsW7GrNBQNohcvhsrtEg4dipHylxTYjjWIget5qV33ngJPilUAWDRGqT/lJghau5kBr5S8J9h1gmTOQwSXCox9NDzxG/8PsCgI7GGLUruKFMMjrCwpCymRFHcmmppvnFkqNVYcI0IYOCvUYTnKEKYI+sVizN3cRt2VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001270; c=relaxed/simple;
	bh=K65A6WWOsGeQ9Yjjv2jM0cY3JrMqJQrkRwf/SEANmAE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=YNI20ZT5ixiLaVvFrHoyZGtJf/BWJHQxql4kWrG5/pWmqlxF/n9G7pjFtK5cVIUfEZJHEjRgckaiWXQQFZ5+NUcd65EmrA4Ac3O3UOR2YNrPUy0MuKIJwJqRqfQA7Ue2mB13kiPwYWUaayrFOESB5maGzbg4IaVUy/5DLTamgIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=TULst1VV; arc=none smtp.client-ip=162.62.57.137
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783001256; bh=Ci9sassTPfQ4PtBaB6pgiyOjRjA2h48iSLiBED/KLZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TULst1VVL/Oj7cnvwQI5hi5DNvpZr2O23rM3sbiC6PeM0T8giJpjjD0AEkbeHWC4U
	 iB0AkM2pL73Zo9tD/mU0DMjoS0U81kPUHtNuvQuErISvDfu3u0O6cWQGXaIA/65Ajr
	 WgfvUN1QJkrnWP1njyTckYNppUxWaT6U0XnuLBTY=
Received: from localhost.localdomain ([218.4.149.66])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 1D09A800; Thu, 02 Jul 2026 22:07:16 +0800
X-QQ-mid: xmsmtpt1783001251tc1d8skwl
Message-ID: <tencent_DA47F002A610FBFDE89B9A697C649412FA09@qq.com>
X-QQ-XMAILINFO: NxKoLLhE22aTY3XiOTE2Ayq58Gh91BDu+xF8078Gr/pT+k2leB027ggheKjgiJ
	 CNlopjmoTvBxjZJe7FiyoyUCvkUTJ3/s/s/bhgJaM37GO3T/E2i/MOia+mG5Zdc0EdlMq716CYci
	 2kMFOycwxS164PGSFDch+e2vY+JVJHEv8TJ1Z2CAmBtqU8/l1CYtwSVteLCpV9BUvoxmy1thsOvE
	 6ETxuMtnXXjy7RhChwTrq7IIIrkhM5aKU5ei1FB8brOr6S+NUMdzGe1jCdF0wWfuBPE5qwTjZr9a
	 gXdygGLpgbfv3IDVJvCZUnc3O87gPgfyJoJVEBcyZ6u2ghefmBY/r0bEVkJ9W7I5jo3Qb6kD9ZIc
	 VWrXhAkvxZUa100GaZX9JNIr/HJLj5ifpbwmDzQaEUcrS6MhoDBTbK/2IVMmj/JnlvOr7I9XWA6d
	 Ux3ZkMKMdubINv/kU8+irvmCbwtCpILxwJEcZElknKe89/IFwDt4NL5tR0FYTDbb41ngVHh4T6fV
	 4dD+qghZC52lFBEIsS/rbabpYCLbpdCmtqc37isLCXeHuYUTJymwT9VEk90pNawZ5RpriR1a6Dxy
	 7SvFf6lmgbUiK3S47KZV8S5IFmF46rjYmu47HkbYUHZ2kv5Gabbie0v6wy61/kOOabUUYO9q9bkM
	 It9B1IVXhWjUW/lu3zQ0cegLZJvipMPTKdhgohB5Vq7DYT5wmsOsIznbu8KCd9WOK6C5tj9xPnTF
	 JR0qrw8pO+kdODv5LJrBhokVRJ+166f/GWVjW+78lYV7LZPwJh5LDrOW5QMkhNSEWC9Z7feQEQI/
	 +PN9Xmk4rIKV+BywShumFRgP0YptxWm+DOUXt6Ot3imA23K5DxgeL4hYxPRy0Aby3JBXYymfnfCC
	 38yDGSetH2nlsHdWzvHrQofKA7LM7DNpZj6YZ23yXqLnb4kBhTyZkxp5s40amD671LZTec+M0gui
	 LtItThrcbaqA3T3uYh9RyNDxjxbiH7yE4joSEeE75dDRChLF1QFOww0y+Hix8praalHU3vQFRu5d
	 jR6AFgsmFg/pcMqEXC
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: 1579567540@qq.com
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can <linux-can@vger.kernel.org>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	kernel <kernel@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Eric Biggers <ebiggers@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Yixun Lan <dlan@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-rockchip <linux-rockchip@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Cunhao Lu <1579567540@qq.com>
Subject: [PATCH v2 3/4] arm64: dts: rockchip: add CAN-FD nodes for RK3588
Date: Thu,  2 Jul 2026 22:06:53 +0800
X-OQ-MSGID: <20260702140654.2961561-4-1579567540@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702140654.2961561-1-1579567540@qq.com>
References: <20260702140654.2961561-1-1579567540@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-7962-lists,linux-can=lfdr.de];
	FORGED_SENDER(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:kernel@pengutronix.de,m:conor+dt@kernel.org,m:heiko@sntech.de,m:dmitry.torokhov@gmail.com,m:shengjiu.wang@nxp.com,m:pengpeng@iscas.ac.cn,m:rmk+kernel@armlinux.org.uk,m:ebiggers@kernel.org,m:mario.limonciello@amd.com,m:kmehltretter@gmail.com,m:dlan@kernel.org,m:sboyd@kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:1579567540@qq.com,m:krzk@kernel.org,m:conor@kernel.org,m:dmitrytorokhov@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qq.com:+];
	FREEMAIL_FROM(0.00)[qq.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,sntech.de,gmail.com,nxp.com,iscas.ac.cn,armlinux.org.uk,amd.com,vger.kernel.org,lists.infradead.org,qq.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,qq.com:dkim,qq.com:email,qq.com:mid,qq.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77F256F8C02

From: Cunhao Lu <1579567540@qq.com>

Describe the three CAN-FD controllers integrated in RK3588 in the base
SoC .dtsi.

Add CAN0, CAN1 and CAN2 nodes with their register ranges, interrupts,
clocks and resets, and keep them disabled by default so board DTS files
can enable them as needed.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index fc1fdbfd3162..b340973775c5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -2648,6 +2648,45 @@ dmac1: dma-controller@fea30000 {
 		#dma-cells = <1>;
 	};
 
+	can0: can@fea50000 {
+		compatible = "rockchip,rk3588-canfd";
+		reg = <0x0 0xfea50000 0x0 0x1000>;
+		interrupts = <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru CLK_CAN0>, <&cru PCLK_CAN0>;
+		clock-names = "baud", "pclk";
+		resets = <&cru SRST_CAN0>, <&cru SRST_P_CAN0>;
+		reset-names = "core", "apb";
+		pinctrl-names = "default";
+		pinctrl-0 = <&can0m0_pins>;
+		status = "disabled";
+	};
+
+	can1: can@fea60000 {
+		compatible = "rockchip,rk3588-canfd";
+		reg = <0x0 0xfea60000 0x0 0x1000>;
+		interrupts = <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru CLK_CAN1>, <&cru PCLK_CAN1>;
+		clock-names = "baud", "pclk";
+		resets = <&cru SRST_CAN1>, <&cru SRST_P_CAN1>;
+		reset-names = "core", "apb";
+		pinctrl-names = "default";
+		pinctrl-0 = <&can1m0_pins>;
+		status = "disabled";
+	};
+
+	can2: can@fea70000 {
+		compatible = "rockchip,rk3588-canfd";
+		reg = <0x0 0xfea70000 0x0 0x1000>;
+		interrupts = <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru CLK_CAN2>, <&cru PCLK_CAN2>;
+		clock-names = "baud", "pclk";
+		resets = <&cru SRST_CAN2>, <&cru SRST_P_CAN2>;
+		reset-names = "core", "apb";
+		pinctrl-names = "default";
+		pinctrl-0 = <&can2m0_pins>;
+		status = "disabled";
+	};
+
 	i2c1: i2c@fea90000 {
 		compatible = "rockchip,rk3588-i2c", "rockchip,rk3399-i2c";
 		reg = <0x0 0xfea90000 0x0 0x1000>;
-- 
2.34.1


