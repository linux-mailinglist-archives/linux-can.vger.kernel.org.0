Return-Path: <linux-can+bounces-1362-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 590D896B715
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 11:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8A11F22EFB
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 09:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D081B1CF29F;
	Wed,  4 Sep 2024 09:42:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD6A1CCEF6
	for <linux-can@vger.kernel.org>; Wed,  4 Sep 2024 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725442949; cv=none; b=UGpnXgZ6EsxspqhOSy0N2T3CPtw3ER5MNA9FVyrMSSRvRGFcRI3ArWefcMUmwYXDjTJ7N0Sv7hIaB4dcqLkVV2Uu4PgN3XEje+o1wKwEMowH9nPA1Ht8BB9Ih+Lekud8z9BCCuuHEZ8tf+4n0N3bQLLBeF0krs0Dzr6btuqN7NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725442949; c=relaxed/simple;
	bh=uugG1vxKzWTpyyIfZNVk4+m8/QbXpPRSMLKMQqdcGDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1O/McK/V/psEyagB6W5sj4wiFOMXYuK4RfG4AQOWd2BbI3UgfruVuM6tzEi9rN/g0snNzineKaVm5Yzx6ejh+u+X2ANj3ahQtjOn0To7lz/RDTWZL/X93nN8sZLqZXv4zMm13kerBUFtvYr2dmGyQf3NXOMA16OHtDTQUr0AFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slmWw-0004OV-59
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 11:42:26 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slmWu-005Q6o-Ej
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 11:42:24 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 21AE9332390
	for <linux-can@vger.kernel.org>; Wed, 04 Sep 2024 09:42:24 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 41F20332356;
	Wed, 04 Sep 2024 09:42:22 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ce00e875;
	Wed, 4 Sep 2024 09:42:21 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	David Jander <david@protonic.nl>,
	Alibek Omarov <a1ba.omarov@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 03/20] arm64: dts: rockchip: mecsbc: add CAN0 and CAN1 interfaces
Date: Wed,  4 Sep 2024 11:38:38 +0200
Message-ID: <20240904094218.1925386-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904094218.1925386-1-mkl@pengutronix.de>
References: <20240904094218.1925386-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: David Jander <david@protonic.nl>

This patch adds support for the CAN0 and CAN1 interfaces to the board.

Signed-off-by: David Jander <david@protonic.nl>
Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
Link: https://patch.msgid.link/20240904-rockchip-canfd-v5-3-8ae22bcb27cc@pengutronix.de
[mkl: fixed order of phandles]
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts b/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts
index c2dfffc638d1..c491dc4d4947 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts
@@ -89,6 +89,20 @@ vdd_npu: regulator-vdd-npu {
 	};
 };
 
+&can0 {
+	compatible = "rockchip,rk3568v3-canfd", "rockchip,rk3568v2-canfd";
+	pinctrl-names = "default";
+	pinctrl-0 = <&can0m0_pins>;
+	status = "okay";
+};
+
+&can1 {
+	compatible = "rockchip,rk3568v3-canfd", "rockchip,rk3568v2-canfd";
+	pinctrl-names = "default";
+	pinctrl-0 = <&can1m1_pins>;
+	status = "okay";
+};
+
 &combphy0 {
 	status = "okay";
 };
-- 
2.45.2



