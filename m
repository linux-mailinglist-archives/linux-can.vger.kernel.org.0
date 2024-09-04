Return-Path: <linux-can+bounces-1365-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA8696B71A
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 11:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8857280F47
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 09:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6698C1CF5F0;
	Wed,  4 Sep 2024 09:42:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16F71CF5CF
	for <linux-can@vger.kernel.org>; Wed,  4 Sep 2024 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725442952; cv=none; b=Jrn72XorUfnigsHa0seRzSPzD6yjhRKExbYCw1tiYdZ1+4xKKpPrshsq4QE/wFr/a34ZV39+z6dUVepFagC6CgdY2+eqdDS8A0xpYOuGAh8Dl3DyVALhsNbYjyN2fnn1oKe4MpTH6QpmtDE1F99zBXauqGUPSVM/W2NymHimpwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725442952; c=relaxed/simple;
	bh=RcEQmeYX9mJE8lRaWoOpYsvbGLVdNBRWBr1gHv0viDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Swb+6B33fx2hwnvrwNfMQ30VYLkbm/Svv+pRQPt1+duYSkJLOPaBqZsV1BBVxYwwzWLNKNuESlNmDrkMnCSuGRvRGcBkqfuC+n4ecKrLLVqWFEEl2x+XzudZCmurXDw2mRcnkNs2H4C7DhBxYxzQdOc3wj1rHP+eDHrORjhjPu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slmWy-0004QR-Hh
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 11:42:28 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slmWv-005Q8A-Cm
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 11:42:25 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 0587D3323AD
	for <linux-can@vger.kernel.org>; Wed, 04 Sep 2024 09:42:24 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 60FA9332359;
	Wed, 04 Sep 2024 09:42:22 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c4c42aab;
	Wed, 4 Sep 2024 09:42:21 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Alibek Omarov <a1ba.omarov@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH net-next 05/20] can: rockchip_canfd: add quirks for errata workarounds
Date: Wed,  4 Sep 2024 11:38:40 +0200
Message-ID: <20240904094218.1925386-6-mkl@pengutronix.de>
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

Add a basic infrastructure for quirks for the 12 documented errata.

Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patch.msgid.link/20240904-rockchip-canfd-v5-5-8ae22bcb27cc@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/rockchip/rockchip_canfd-core.c    | 11 +++-
 drivers/net/can/rockchip/rockchip_canfd.h     | 55 +++++++++++++++++++
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index f1b2bad04bf4..18957769b3d3 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -26,6 +26,12 @@
 
 static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v2 = {
 	.model = RKCANFD_MODEL_RK3568V2,
+	.quirks = RKCANFD_QUIRK_RK3568_ERRATUM_1 | RKCANFD_QUIRK_RK3568_ERRATUM_2 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_3 | RKCANFD_QUIRK_RK3568_ERRATUM_4 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_5 | RKCANFD_QUIRK_RK3568_ERRATUM_6 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_7 | RKCANFD_QUIRK_RK3568_ERRATUM_8 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_9 | RKCANFD_QUIRK_RK3568_ERRATUM_10 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_11 | RKCANFD_QUIRK_RK3568_ERRATUM_12,
 };
 
 static const char *__rkcanfd_get_model_str(enum rkcanfd_model model)
@@ -709,10 +715,11 @@ static void rkcanfd_register_done(const struct rkcanfd_priv *priv)
 	dev_id = rkcanfd_read(priv, RKCANFD_REG_RTL_VERSION);
 
 	netdev_info(priv->ndev,
-		    "Rockchip-CANFD %s rev%lu.%lu found\n",
+		    "Rockchip-CANFD %s rev%lu.%lu (errata 0x%04x) found\n",
 		    rkcanfd_get_model_str(priv),
 		    FIELD_GET(RKCANFD_REG_RTL_VERSION_MAJOR, dev_id),
-		    FIELD_GET(RKCANFD_REG_RTL_VERSION_MINOR, dev_id));
+		    FIELD_GET(RKCANFD_REG_RTL_VERSION_MINOR, dev_id),
+		    priv->devtype_data.quirks);
 }
 
 static int rkcanfd_register(struct rkcanfd_priv *priv)
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 0848b1900baa..09626ca174a8 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -295,12 +295,67 @@
 #define RKCANFD_TIMESTAMP_WORK_MAX_DELAY_SEC 60
 #define RKCANFD_ERRATUM_5_SYSCLOCK_HZ_MIN (300 * MEGA)
 
+/* rk3568 CAN-FD Errata, as of Tue 07 Nov 2023 11:25:31 +08:00 */
+
+/* Erratum 1: The error frame sent by the CAN controller has an
+ * abnormal format.
+ */
+#define RKCANFD_QUIRK_RK3568_ERRATUM_1 BIT(0)
+
+/* Erratum 2: The error frame sent after detecting a CRC error has an
+ * abnormal position.
+ */
+#define RKCANFD_QUIRK_RK3568_ERRATUM_2 BIT(1)
+
+/* Erratum 3: Intermittent CRC calculation errors. */
+#define RKCANFD_QUIRK_RK3568_ERRATUM_3 BIT(2)
+
+/* Erratum 4: Intermittent occurrence of stuffing errors. */
+#define RKCANFD_QUIRK_RK3568_ERRATUM_4 BIT(3)
+
+/* Erratum 5: Counters related to the TXFIFO and RXFIFO exhibit
+ * abnormal counting behavior.
+ */
+#define RKCANFD_QUIRK_RK3568_ERRATUM_5 BIT(4)
+
+/* Erratum 6: The CAN controller's transmission of extended frames may
+ * intermittently change into standard frames
+ */
+#define RKCANFD_QUIRK_RK3568_ERRATUM_6 BIT(5)
+
+/* Erratum 7: In the passive error state, the CAN controller's
+ * interframe space segment counting is inaccurate.
+ */
+#define RKCANFD_QUIRK_RK3568_ERRATUM_7 BIT(6)
+
+/* Erratum 8: The Format-Error error flag is transmitted one bit
+ * later.
+ */
+#define RKCANFD_QUIRK_RK3568_ERRATUM_8 BIT(7)
+
+/* Erratum 9: In the arbitration segment, the CAN controller will
+ * identify stuffing errors as arbitration failures.
+ */
+#define RKCANFD_QUIRK_RK3568_ERRATUM_9 BIT(8)
+
+/* Erratum 10: Does not support the BUSOFF slow recovery mechanism. */
+#define RKCANFD_QUIRK_RK3568_ERRATUM_10 BIT(9)
+
+/* Erratum 11: Arbitration error. */
+#define RKCANFD_QUIRK_RK3568_ERRATUM_11 BIT(10)
+
+/* Erratum 12: A dominant bit at the third bit of the intermission may
+ * cause a transmission error.
+ */
+#define RKCANFD_QUIRK_RK3568_ERRATUM_12 BIT(11)
+
 enum rkcanfd_model {
 	RKCANFD_MODEL_RK3568V2 = 0x35682,
 };
 
 struct rkcanfd_devtype_data {
 	enum rkcanfd_model model;
+	u32 quirks;
 };
 
 struct rkcanfd_fifo_header {
-- 
2.45.2



