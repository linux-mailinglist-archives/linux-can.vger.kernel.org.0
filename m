Return-Path: <linux-can+bounces-1251-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5A496699B
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 21:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2041C23B10
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 19:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BED1BFDF9;
	Fri, 30 Aug 2024 19:27:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80361BF804
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725046030; cv=none; b=dvSknBTmCJeb212dDKgVAb7tyefpkJWf4WPDdafqAHlnuLmOlabCxw72lN2hemmujLs7gqiRoCkzq5frHnasdlGEK853ASLKrVQCj/ryOr2Qnq2PBTomgVF2qZzNahtWk4vHWq6HubbiqAW2Sht0PPJAOHRpXfxznYpDAQFFOYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725046030; c=relaxed/simple;
	bh=gHcn4OZDSX+A/OQCPXVw5Njr3d5BhPC3JSMfqT4fihA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WgERiLtbQsUHZwkJMey+aCSFmV9ymBDJBI5WW0sFkruvLmrhg/PLRkc50mk6k8AvM6aN8LlWUisNySwxqkox98vz+0QOxfCVxnajCJXOJTgC4Av33oFkJUb56aq4etPb739lPey5cGr70PcwsOI7DSpo2iJsOUXfaJDMjsVSZ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk7Gy-0006JC-Kd
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 21:27:04 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk7Gq-004DoB-Ei
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 21:26:56 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id A5AD932E21C
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 19:26:55 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id AA29232E0FD;
	Fri, 30 Aug 2024 19:26:46 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ec69a17b;
	Fri, 30 Aug 2024 19:26:45 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 30 Aug 2024 21:26:04 +0200
Subject: [PATCH can-next v3 07/20] can: rockchip_canfd: add support for
 rk3568v3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-rockchip-canfd-v3-7-d426266453fa@pengutronix.de>
References: <20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de>
In-Reply-To: <20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de>
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 David Jander <david.jander@protonic.nl>
Cc: Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=2430; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=gHcn4OZDSX+A/OQCPXVw5Njr3d5BhPC3JSMfqT4fihA=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm0hzgTN/nn4L8IxlLVyeswobJnPMW7kpp2fMql
 IMKxHzbLnSJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZtIc4AAKCRAoOKI+ei28
 b2mVB/4se9H/tExfU14wiMJK1hvhyPR7kwXQF9faq8pnDmbr4CVsq5FSeUAjtmDTftqgLh6DWpt
 M8lgpAR5Ui3g2a+jR+iWEpvPbKlS4tjumk6y6Tiyw25pcnDUx4pDrqF1VIO6syYsZpD+09wuCP9
 pyEygU9Fezl3KhWI6LvK8FPB1E+5Qdf8e9E5u1YKuZVsE94sNUTA5jUGCAAymS9v1vUl5gojABE
 bUVcn00AHkShAUtfX+73UMRLd+Cmo0RbeagCyd/6mVU5hm9wK5HXosd0ut2MynVRZR8SLAJD1ep
 /xJuTlUSBfNWztAo5ycPeSmlwzXFC0HxwkSkvxDN85YdDGpx
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Add the support for the rk3568v3 SoC, the CAN-FD IP core has 7
documented errata.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 20 ++++++++++++++++++++
 drivers/net/can/rockchip/rockchip_canfd.h      |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 61de6f89cf16..40911bb63623 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -35,11 +35,28 @@ static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v2 = {
 		RKCANFD_QUIRK_CANFD_BROKEN,
 };
 
+/* The rk3568 CAN-FD errata sheet as of Tue 07 Nov 2023 11:25:31 +08:00
+ * states that only the rk3568v2 is affected by erratum 5, but tests
+ * with the rk3568v2 and rk3568v3 show that the RX_FIFO_CNT is
+ * sometimes too high. In contrast to the errata sheet mark rk3568v3
+ * as effected by erratum 5, too.
+ */
+static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v3 = {
+	.model = RKCANFD_MODEL_RK3568V3,
+	.quirks = RKCANFD_QUIRK_RK3568_ERRATUM_1 | RKCANFD_QUIRK_RK3568_ERRATUM_2 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_5 | RKCANFD_QUIRK_RK3568_ERRATUM_7 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_8 | RKCANFD_QUIRK_RK3568_ERRATUM_10 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_11 | RKCANFD_QUIRK_RK3568_ERRATUM_12 |
+		RKCANFD_QUIRK_CANFD_BROKEN,
+};
+
 static const char *__rkcanfd_get_model_str(enum rkcanfd_model model)
 {
 	switch (model) {
 	case RKCANFD_MODEL_RK3568V2:
 		return "rk3568v2";
+	case RKCANFD_MODEL_RK3568V3:
+		return "rk3568v3";
 	}
 
 	return "<unknown>";
@@ -764,6 +781,9 @@ static const struct of_device_id rkcanfd_of_match[] = {
 	{
 		.compatible = "rockchip,rk3568v2-canfd",
 		.data = &rkcanfd_devtype_data_rk3568v2,
+	}, {
+		.compatible = "rockchip,rk3568v3-canfd",
+		.data = &rkcanfd_devtype_data_rk3568v3,
 	}, {
 		/* sentinel */
 	},
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 7321027534fb..9b446331fbd0 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -372,6 +372,7 @@
 
 enum rkcanfd_model {
 	RKCANFD_MODEL_RK3568V2 = 0x35682,
+	RKCANFD_MODEL_RK3568V3 = 0x35683,
 };
 
 struct rkcanfd_devtype_data {

-- 
2.45.2



