Return-Path: <linux-can+bounces-1340-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BE296B412
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 10:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56B6AB2631F
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 08:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DF918952E;
	Wed,  4 Sep 2024 08:13:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D127518951B
	for <linux-can@vger.kernel.org>; Wed,  4 Sep 2024 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437624; cv=none; b=Sc5BrXbHt9Pn2LATgmsfizOtBwWGYmzTFY2MnzfhFBG+AECB7C++EPMPT1Sp61DHjy271/5qdmZjRy07l0BaitRID8AowHez4KXeyQ0JPcbYMpMVrFDxp4TuMgbOICRZvzeSX6bdm5GcXz10sGIJXlS+G5S1oXpeUjs6E3teYk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437624; c=relaxed/simple;
	bh=0XfIvBSHxbvsi8q2NBqn07n4EZRg55BSI/J7mfb49+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CrJQdkXZOnN8nrwW6yJcyye39n2OrtSCCata1Fg9imyHYqMWjRgfxKUhVZP55Ke3uIL0K6BiRrA2cJB8bVIedCm9wFTbSRDP8k8iTgf0qVWUyr8vQ0W5KDReYsbCYywmSZxz2tUh761UQgvKy1R+b0plAfW6CSu+4BOvBekoZdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sll8z-0007h5-Ej
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 10:13:37 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sll8u-005Ow5-EK
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 10:13:32 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 09150332087
	for <linux-can@vger.kernel.org>; Wed, 04 Sep 2024 08:13:31 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 20FD9331F54;
	Wed, 04 Sep 2024 08:13:22 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a71031cc;
	Wed, 4 Sep 2024 08:13:20 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 04 Sep 2024 10:12:49 +0200
Subject: [PATCH can-next v5 05/20] can: rockchip_canfd: add quirks for
 errata workarounds
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-rockchip-canfd-v5-5-8ae22bcb27cc@pengutronix.de>
References: <20240904-rockchip-canfd-v5-0-8ae22bcb27cc@pengutronix.de>
In-Reply-To: <20240904-rockchip-canfd-v5-0-8ae22bcb27cc@pengutronix.de>
To: kernel@pengutronix.de, Alibek Omarov <a1ba.omarov@gmail.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4251; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=0XfIvBSHxbvsi8q2NBqn07n4EZRg55BSI/J7mfb49+c=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm2BaJKjBKk2hxuLHF8VZFCrysyRuLWb+c0m8+E
 ElQ02LG+OSJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZtgWiQAKCRAoOKI+ei28
 b7OTB/0TldvmgaL0BvryPFUY0gXuZfsBbDfm//OBa6hhePDOXOBqlnsFEBd0lrEEmfyfDbh5jho
 kpSb7uv7/cwWdhYB+29eCgPATxblj1V/vPuyR9lpCC1jKAK0q87k1V2zexC1ApvpxMBtTiStDMy
 3TakFx608jxg8/0zIgW6MJN7JjHSP32Lnd4uWJnYuoxEPAGOCt4nLB1+Od5WWMnAdO6aQQ5uQaD
 Z5gnjXLj1JXn4ZpLgoUdnEKeHxD2xVJ25WySaV4mVIrZYUzAwQGRZrJm/42erEthppaAKL07aEz
 hbwBqqBkaF4v9Q9Pb6yVkzkCHSz8qvLWq0adf2IYWx3Fua4w
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Add a basic infrastructure for quirks for the 12 documented errata.

Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 11 +++++-
 drivers/net/can/rockchip/rockchip_canfd.h      | 55 ++++++++++++++++++++++++++
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



