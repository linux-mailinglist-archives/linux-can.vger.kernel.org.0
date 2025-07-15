Return-Path: <linux-can+bounces-3993-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B597DB05797
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 12:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEAB31C21FDA
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 10:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590AF2D5C8E;
	Tue, 15 Jul 2025 10:16:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383F924167B
	for <linux-can@vger.kernel.org>; Tue, 15 Jul 2025 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752574593; cv=none; b=pQc2dDF9MtKiU/EKKMUCoeMQL1r2XTFKlgEuWUccTK1bQ50UJBmarEYePVeNB7UlObh2TlE75t0TWgGRcNKzHYWoHvASqhLtv8m2P1S/BTHX1wkSvEwu6tTxzkBLDDDa/7yOkslcalTVb/i3Fmi/zKi8bXspIL+B23+ydqBkJNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752574593; c=relaxed/simple;
	bh=gD+GeB+lf8v2O5O56DTadj/7H5+Tvqc7ZbMei6Dhv5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z80XLaU1PYMJzLQ7xMe+QK8A69+B3moRYdifihNbyhSdBBWZLtvGwF6iV+81QBrv3xld97gc/zdeuOVvz18AmzVVDPnjvFFGYWkqFeSUXpgnz10+JqSy6+1upkW25CWIY5AYyrwOlllLTnq+hwDTYBxXfPBLv8+Xol1hy3aZCpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ubci5-0008Kz-K1
	for linux-can@vger.kernel.org; Tue, 15 Jul 2025 12:16:29 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ubci5-008Z0p-1J
	for linux-can@vger.kernel.org;
	Tue, 15 Jul 2025 12:16:29 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 1BA3A4422FA
	for <linux-can@vger.kernel.org>; Tue, 15 Jul 2025 10:16:29 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 728A74422EB;
	Tue, 15 Jul 2025 10:16:27 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 372304e2;
	Tue, 15 Jul 2025 10:16:26 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Brett Werling <brett.werling@garmin.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net] can: tcan4x5x: fix reset gpio usage during probe
Date: Tue, 15 Jul 2025 12:13:39 +0200
Message-ID: <20250715101625.3202690-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250715101625.3202690-1-mkl@pengutronix.de>
References: <20250715101625.3202690-1-mkl@pengutronix.de>
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

From: Brett Werling <brett.werling@garmin.com>

Fixes reset GPIO usage during probe by ensuring we retrieve the GPIO and
take the device out of reset (if it defaults to being in reset) before
we attempt to communicate with the device. This is achieved by moving
the call to tcan4x5x_get_gpios() before tcan4x5x_find_version() and
avoiding any device communication while getting the GPIOs. Once we
determine the version, we can then take the knowledge of which GPIOs we
obtained and use it to decide whether we need to disable the wake or
state pin functions within the device.

This change is necessary in a situation where the reset GPIO is pulled
high externally before the CPU takes control of it, meaning we need to
explicitly bring the device out of reset before we can start
communicating with it at all.

This also has the effect of fixing an issue where a reset of the device
would occur after having called tcan4x5x_disable_wake(), making the
original behavior not actually disable the wake. This patch should now
disable wake or state pin functions well after the reset occurs.

Signed-off-by: Brett Werling <brett.werling@garmin.com>
Link: https://patch.msgid.link/20250711141728.1826073-1-brett.werling@garmin.com
Cc: Markus Schneider-Pargmann <msp@baylibre.com>
Fixes: 142c6dc6d9d7 ("can: tcan4x5x: Add support for tcan4552/4553")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 61 ++++++++++++++++++---------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 8edaa339d590..39b0b5277b11 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -343,21 +343,19 @@ static void tcan4x5x_get_dt_data(struct m_can_classdev *cdev)
 		of_property_read_bool(cdev->dev->of_node, "ti,nwkrq-voltage-vio");
 }
 
-static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
-			      const struct tcan4x5x_version_info *version_info)
+static int tcan4x5x_get_gpios(struct m_can_classdev *cdev)
 {
 	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
 	int ret;
 
-	if (version_info->has_wake_pin) {
-		tcan4x5x->device_wake_gpio = devm_gpiod_get(cdev->dev, "device-wake",
-							    GPIOD_OUT_HIGH);
-		if (IS_ERR(tcan4x5x->device_wake_gpio)) {
-			if (PTR_ERR(tcan4x5x->device_wake_gpio) == -EPROBE_DEFER)
-				return -EPROBE_DEFER;
+	tcan4x5x->device_wake_gpio = devm_gpiod_get_optional(cdev->dev,
+							     "device-wake",
+							     GPIOD_OUT_HIGH);
+	if (IS_ERR(tcan4x5x->device_wake_gpio)) {
+		if (PTR_ERR(tcan4x5x->device_wake_gpio) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 
-			tcan4x5x_disable_wake(cdev);
-		}
+		tcan4x5x->device_wake_gpio = NULL;
 	}
 
 	tcan4x5x->reset_gpio = devm_gpiod_get_optional(cdev->dev, "reset",
@@ -369,14 +367,31 @@ static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
 	if (ret)
 		return ret;
 
-	if (version_info->has_state_pin) {
-		tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
-								      "device-state",
-								      GPIOD_IN);
-		if (IS_ERR(tcan4x5x->device_state_gpio)) {
-			tcan4x5x->device_state_gpio = NULL;
-			tcan4x5x_disable_state(cdev);
-		}
+	tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
+							      "device-state",
+							      GPIOD_IN);
+	if (IS_ERR(tcan4x5x->device_state_gpio))
+		tcan4x5x->device_state_gpio = NULL;
+
+	return 0;
+}
+
+static int tcan4x5x_check_gpios(struct m_can_classdev *cdev,
+				const struct tcan4x5x_version_info *version_info)
+{
+	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
+	int ret;
+
+	if (version_info->has_wake_pin && !tcan4x5x->device_wake_gpio) {
+		ret = tcan4x5x_disable_wake(cdev);
+		if (ret)
+			return ret;
+	}
+
+	if (version_info->has_state_pin && !tcan4x5x->device_state_gpio) {
+		ret = tcan4x5x_disable_state(cdev);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -468,15 +483,21 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 		goto out_m_can_class_free_dev;
 	}
 
+	ret = tcan4x5x_get_gpios(mcan_class);
+	if (ret) {
+		dev_err(&spi->dev, "Getting gpios failed %pe\n", ERR_PTR(ret));
+		goto out_power;
+	}
+
 	version_info = tcan4x5x_find_version(priv);
 	if (IS_ERR(version_info)) {
 		ret = PTR_ERR(version_info);
 		goto out_power;
 	}
 
-	ret = tcan4x5x_get_gpios(mcan_class, version_info);
+	ret = tcan4x5x_check_gpios(mcan_class, version_info);
 	if (ret) {
-		dev_err(&spi->dev, "Getting gpios failed %pe\n", ERR_PTR(ret));
+		dev_err(&spi->dev, "Checking gpios failed %pe\n", ERR_PTR(ret));
 		goto out_power;
 	}
 

base-commit: f0f2b992d8185a0366be951685e08643aae17d6d
-- 
2.47.2



