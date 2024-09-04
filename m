Return-Path: <linux-can+bounces-1388-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF1996BD9C
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 15:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AAC828599D
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 13:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F4E1DA114;
	Wed,  4 Sep 2024 13:03:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C541DA2FE
	for <linux-can@vger.kernel.org>; Wed,  4 Sep 2024 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454988; cv=none; b=OCAKTfFDRq2kk6fa4fxCBpYexx+L0nGSc+M+YsicFWF2IyjxjsPkrCC+DrPnaxj87NeLyWm1rlhTjchJ4n2p4yTdayWq5hXMnBEtBzuN2Ge8JpPZxuikmvK54XhSp00vxzQsbOJ/IMQnMRHN9Jgzn3g5jMWrAorxSPGusI2RscQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454988; c=relaxed/simple;
	bh=q4mKlw1pUVsf2xErz6XXt7kuFlfr/R6DaTH7NCxLnSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mh0A3LZY7t5Afw+UY5U0/6wn0o+V8OgMnlimrPk12bpOD5NdOi6MkRYczLvTprQWGMD7pW+o14nTJjTfOp6BnLMtUE0exovGl9A1ECzDdj+Oe7CrABksPYsEe/HqEyT6NJSHlhn0bAVZVqn3UHtsefZhFU3liv1V1OcBOUa733A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slpf6-0006wD-HY
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 15:03:04 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slpf4-005SSS-2p
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 15:03:02 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id C0E78332795
	for <linux-can@vger.kernel.org>; Wed, 04 Sep 2024 13:03:01 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 1227D332761;
	Wed, 04 Sep 2024 13:03:00 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 57aca681;
	Wed, 4 Sep 2024 13:02:59 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Alibek Omarov <a1ba.omarov@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH net-next 04/18] can: rockchip_canfd: add quirk for broken CAN-FD support
Date: Wed,  4 Sep 2024 14:55:20 +0200
Message-ID: <20240904130256.1965582-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904130256.1965582-1-mkl@pengutronix.de>
References: <20240904130256.1965582-1-mkl@pengutronix.de>
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

The errata sheets doesn't say anything about CAN-FD, but tests on the
rk3568v2 and rk3568v3 show that receiving certain CAN-FD frames
triggers an Error Interrupt.

Mark the CAN-FD support as broken.

Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patch.msgid.link/20240904-rockchip-canfd-v5-6-8ae22bcb27cc@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/rockchip/rockchip_canfd-core.c    |  5 ++++-
 drivers/net/can/rockchip/rockchip_canfd.h     | 21 +++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 18957769b3d3..61de6f89cf16 100644
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
@@ -817,6 +818,8 @@ static int rkcanfd_probe(struct platform_device *pdev)
 	priv->can.bittiming_const = &rkcanfd_bittiming_const;
 	priv->can.data_bittiming_const = &rkcanfd_data_bittiming_const;
 	priv->can.ctrlmode_supported = 0;
+	if (!(priv->devtype_data.quirks & RKCANFD_QUIRK_CANFD_BROKEN))
+		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
 	priv->can.do_set_mode = rkcanfd_set_mode;
 	priv->can.do_get_berr_counter = rkcanfd_get_berr_counter;
 	priv->ndev = ndev;
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 09626ca174a8..7321027534fb 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -349,6 +349,27 @@
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
2.45.2



