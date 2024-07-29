Return-Path: <linux-can+bounces-1042-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1531593F642
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 15:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D2B283706
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 13:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8169A158875;
	Mon, 29 Jul 2024 13:07:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D816B156257
	for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258427; cv=none; b=i45+IWNsH4S2VYMV3GHw5+levajbmL2+Ubqa61oAksPzehxLYkSCuojt6Avr/RWLqTRZhiqUA6MqkfhsCD9lvktCepHtl3Gf8kqWPRSUYI6PRMvvmQ3Sb1VfKgvryn00eRaI3A8r/fevsQtY3F1sW08dX1W/T0a6gxuYgeyWkeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258427; c=relaxed/simple;
	bh=z2yadjNJymPA5maKfSyGODDppKc2k/TC+sJTrzWq96Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PBdaavkdnVNBNUsOwymftT/hN7UTjFNSLrjF78KnwicDk1WkPerQ0p5JbUIfuciCZj1A7gYq3GUgy2879uEVHVoRMKdLO8PuruZe1PQVv0QortZVtghKB2ydMECaWAJb6IOQN1dqNdtg9Dj4A9uthUY+dM3CsqeuU7aH+ML3yEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ5g-0000OM-8e
	for linux-can@vger.kernel.org; Mon, 29 Jul 2024 15:07:04 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ5f-00334F-Fh
	for linux-can@vger.kernel.org; Mon, 29 Jul 2024 15:07:03 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 2A574310E11
	for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 13:07:03 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 3A13B310D93;
	Mon, 29 Jul 2024 13:06:51 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3d3deb7a;
	Mon, 29 Jul 2024 13:06:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 29 Jul 2024 15:05:38 +0200
Subject: [PATCH can-next 07/21] can: rockchip_canfd: add support for
 rk3568v3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-rockchip-canfd-v1-7-fa1250fd6be3@pengutronix.de>
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
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2433; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=z2yadjNJymPA5maKfSyGODDppKc2k/TC+sJTrzWq96Y=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmp5O+ws7SAJLyIe4Go+2uulJCZo5pAvtFSyXxk
 QEIGesemzWJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZqeTvgAKCRAoOKI+ei28
 b6ULCACTY7pLPKvGmxRhG/GPfALCmf+L46Yi8gSLIttRPhtRKvi1GzurmTFfk9Nch2iuqfyEujo
 KuAn/dqYBecr+nqlVZuL+KVUPEPZnqb0kRT4C+aKsUvvE4S5qbuS03NGj78JU60TCsHAnAYd5f8
 Me5B4At25KRUf8qHhQkwfCNxq773tGxybXTvwtPIeOI+A1RLn2ynrNpl8NUDbsvz+g2e/K4tnAn
 EsNHXf99lixc7zj/C0lUxOfgIGc9yCWFpcq7rzhe9vXqw7vaAqi/PFhmxyeSHNs2PfaElP/iQU3
 1vKrKXuXcNdc/5bkq3OHBpi4zbaif9VFlScySqKVokb+P9Jt
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
index cc529d5a3028..cd4e951f56d6 100644
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
@@ -770,6 +787,9 @@ static const struct of_device_id rkcanfd_of_match[] = {
 	}, {
 		.compatible = "rockchip,rk3568v2-canfd",
 		.data = &rkcanfd_devtype_data_rk3568v2,
+	}, {
+		.compatible = "rockchip,rk3568v3-canfd",
+		.data = &rkcanfd_devtype_data_rk3568v3,
 	}, {
 		/* sentinel */
 	},
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 43a6682f3651..c008953ccfc8 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -371,6 +371,7 @@
 
 enum rkcanfd_model {
 	RKCANFD_MODEL_RK3568V2 = 0x35682,
+	RKCANFD_MODEL_RK3568V3 = 0x35683,
 };
 
 struct rkcanfd_devtype_data {

-- 
2.43.0



