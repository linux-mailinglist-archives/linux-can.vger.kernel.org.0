Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA52113124
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2019 18:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfLDRxX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Dec 2019 12:53:23 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50742 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfLDRxW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Dec 2019 12:53:22 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB4HrFpX079687;
        Wed, 4 Dec 2019 11:53:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575481995;
        bh=AnC853RFFoxs00i8fMk3eDa7i0nyPwZrTi1e2WCpjj8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TRXATRf5F6o/rVNB7WveJsgTC6EOTmznGk1WH/p4zF4NDAyRamYyJetXDo2rKhno6
         4/ohZEpEXJPbR8fYIXHx4OGUwf5nZJZem5qYJc6gUY2hMpsGuWp/UHT1RhHp/JWQqb
         VtNMDs2gU38WZxfEeiZoHTqzA+5/NoG85pOMxIXk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB4HrF2D040848
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Dec 2019 11:53:15 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 4 Dec
 2019 11:53:15 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 4 Dec 2019 11:53:15 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB4HrFp4034157;
        Wed, 4 Dec 2019 11:53:15 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <mkl@pengutronix.de>
CC:     <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>,
        Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH 2/2] net: m_can: Make wake-up gpio an optional
Date:   Wed, 4 Dec 2019 11:51:12 -0600
Message-ID: <20191204175112.7308-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191204175112.7308-1-dmurphy@ti.com>
References: <20191204175112.7308-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The device has the ability to disable the wake-up pin option.
The wake-up pin can be either force to GND or Vsup and does not have to
be tied to a GPIO.  In order for the device to not use the wake-up feature
write the register to disable the WAKE_CONFIG option.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
CC: Sean Nyekjaer <sean@geanix.com>
---
 drivers/net/can/m_can/tcan4x5x.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index 3db619209fe1..6e37c3fd87af 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -101,6 +101,8 @@
 #define TCAN4X5X_MODE_STANDBY BIT(6)
 #define TCAN4X5X_MODE_NORMAL BIT(7)
 
+#define TCAN4X5X_DISABLE_WAKE_MSK	(BIT(31) | BIT(30))
+
 #define TCAN4X5X_SW_RESET BIT(2)
 
 #define TCAN4X5X_MCAN_CONFIGURED BIT(5)
@@ -338,6 +340,15 @@ static int tcan4x5x_init(struct m_can_classdev *cdev)
 	return ret;
 }
 
+static int tcan4x5x_disable_wake(struct m_can_classdev *cdev)
+{
+	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
+
+	return regmap_update_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
+				  TCAN4X5X_DISABLE_WAKE_MSK, 0x00);
+
+}
+
 static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 {
 	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
@@ -345,8 +356,10 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 	tcan4x5x->device_wake_gpio = devm_gpiod_get(cdev->dev, "device-wake",
 						    GPIOD_OUT_HIGH);
 	if (IS_ERR(tcan4x5x->device_wake_gpio)) {
-		dev_err(cdev->dev, "device-wake gpio not defined\n");
-		return -EINVAL;
+		if (PTR_ERR(tcan4x5x->power) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		tcan4x5x_disable_wake(cdev);
 	}
 
 	tcan4x5x->reset_gpio = devm_gpiod_get_optional(cdev->dev, "reset",
@@ -428,10 +441,6 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, priv);
 
-	ret = tcan4x5x_parse_config(mcan_class);
-	if (ret)
-		goto out_clk;
-
 	/* Configure the SPI bus */
 	spi->bits_per_word = 32;
 	ret = spi_setup(spi);
@@ -441,6 +450,10 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	priv->regmap = devm_regmap_init(&spi->dev, &tcan4x5x_bus,
 					&spi->dev, &tcan4x5x_regmap);
 
+	ret = tcan4x5x_parse_config(mcan_class);
+	if (ret)
+		goto out_clk;
+
 	tcan4x5x_power_enable(priv->power, 1);
 
 	ret = m_can_class_register(mcan_class);
-- 
2.23.0

