Return-Path: <linux-can+bounces-1041-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE20C93F63D
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 15:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505951F231BE
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 13:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFCE1553AF;
	Mon, 29 Jul 2024 13:07:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F253156243
	for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258425; cv=none; b=SfUEjae46vE4YzgQatio9ozxq+IyaIR3xpoK5bn+r/iKX6IybkAewirJDHOy2G5mjcWuPR2pQKuZvoftzJg40fIcXIkHiNBElfBomRJ10OdFJJJzW28ezeRXKoYc5j8HBJ2vNw19gbGJr8lKDAP7vIlNb4AYmQu04K4A6Mf19pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258425; c=relaxed/simple;
	bh=/MtM0je10WNxJII/ewFIlB26WobcBOKxbC8/UfAf7Xk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CajT8BrPY9LUPXjh/IjXruCk0O/0jXVP3JWT3AbsVwxNj1VokZcMYN8R86WBHp6pjdX7Sz5o2a5z9bz9sObQGe2aqgC6a8hKGsWBYSkRhLA1SIdxMeZMYx/7qoej3OTkUF+KhuTNpnjnVRqbhWgdwgpvyilG9eT1DPD71S7ZClg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ5d-0000Jv-Ux
	for linux-can@vger.kernel.org; Mon, 29 Jul 2024 15:07:01 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ5d-00332N-AC
	for linux-can@vger.kernel.org; Mon, 29 Jul 2024 15:07:01 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 0140C310DF3
	for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 13:07:00 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 4C13B310D88;
	Mon, 29 Jul 2024 13:06:48 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7bbb0a14;
	Mon, 29 Jul 2024 13:06:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 29 Jul 2024 15:05:37 +0200
Subject: [PATCH can-next 06/21] can: rockchip_canfd: add quirk for broken
 CAN-FD support
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-rockchip-canfd-v1-6-fa1250fd6be3@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2840; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=/MtM0je10WNxJII/ewFIlB26WobcBOKxbC8/UfAf7Xk=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmp5O9olYnYNcuHP6PcRL671LwYlFLUwNkB3HaE
 e72XVBzka2JATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZqeTvQAKCRAoOKI+ei28
 b67XB/98V054nQ57OqPVCBfXXm8hmPGgXECYfC0fkbIzLGM19qWobJbA03K+XMHGlgitoeeav1L
 kmLufFWV6ty6BS2rnG+qWCMiayr1tuFuClo7DC1wYmke/kNAxFFObPsj99L7vDtyudMmScBWjcf
 NZAhllHuxxy2o4asIUPoG3GUs6vJpTCshebn2tqB3KkGOBE7TfGTmM/aASAlyJyMxP2GuCPwooO
 0uqh2JKOvIiFHwhenVciU2e8W8Izw6eXePGQVCCA0O2n8yD9JSLYVlmw6g923kYCXOobzdPRPGz
 rGzy7oEsr4Es99vHV4hj7LSOE3p0wLpkAYSi74EjpqodXiBQ
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

The errata sheets doesn't say anything about CAN-FD, but tests on the
rk3568v2 and rk3568v3 show that receiving certain CAN-FD frames
triggers an Error Interrupt.

Mark the CAN-FD support as broken.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c |  5 ++++-
 drivers/net/can/rockchip/rockchip_canfd.h      | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 961eae352ae4..cc529d5a3028 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -31,7 +31,8 @@ static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v2 = {
 		RKCANFD_QUIRK_RK3568_ERRATUM_5 | RKCANFD_QUIRK_RK3568_ERRATUM_6 |
 		RKCANFD_QUIRK_RK3568_ERRATUM_7 | RKCANFD_QUIRK_RK3568_ERRATUM_8 |
 		RKCANFD_QUIRK_RK3568_ERRATUM_9 | RKCANFD_QUIRK_RK3568_ERRATUM_10 |
-		RKCANFD_QUIRK_RK3568_ERRATUM_11 | RKCANFD_QUIRK_RK3568_ERRATUM_12,
+		RKCANFD_QUIRK_RK3568_ERRATUM_11 | RKCANFD_QUIRK_RK3568_ERRATUM_12 |
+		RKCANFD_QUIRK_CANFD_BROKEN,
 };
 
 static const char *__rkcanfd_get_model_str(enum rkcanfd_model model)
@@ -823,6 +824,8 @@ static int rkcanfd_probe(struct platform_device *pdev)
 	priv->can.bittiming_const = &rkcanfd_bittiming_const;
 	priv->can.data_bittiming_const = &rkcanfd_data_bittiming_const;
 	priv->can.ctrlmode_supported = 0;
+	if (!(priv->devtype_data.quirks & RKCANFD_QUIRK_CANFD_BROKEN))
+		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
 	priv->can.do_set_mode = rkcanfd_set_mode;
 	priv->can.do_get_berr_counter = rkcanfd_get_berr_counter;
 	priv->ndev = ndev;
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index b267df438a82..43a6682f3651 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -348,6 +348,27 @@
  */
 #define RKCANFD_QUIRK_RK3568_ERRATUM_12 BIT(11)
 
+/* Tests on the rk3568v2 and rk3568v3 show that receiving certain
+ * CAN-FD frames trigger an Error Interrupt.
+ *
+ * - Form Error in RX Arbitration Phase: TX_IDLE RX_STUFF_COUNT (0x0a010100) CMD=0 RX=0 TX=0
+ *   Error-Warning=1 Bus-Off=0
+ *   To reproduce:
+ *   host:
+ *     cansend can0 002##01f
+ *   DUT:
+ *     candump any,0:0,#FFFFFFFF -cexdHtA
+ *
+ * - Form Error in RX Arbitration Phase: TX_IDLE RX_CRC (0x0a010200) CMD=0 RX=0 TX=0
+ *   Error-Warning=1 Bus-Off=0
+ *   To reproduce:
+ *   host:
+ *     cansend can0 002##07217010000000000
+ *   DUT:
+ *     candump any,0:0,#FFFFFFFF -cexdHtA
+ */
+#define RKCANFD_QUIRK_CANFD_BROKEN BIT(12)
+
 enum rkcanfd_model {
 	RKCANFD_MODEL_RK3568V2 = 0x35682,
 };

-- 
2.43.0



