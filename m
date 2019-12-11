Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D15B11ACA1
	for <lists+linux-can@lfdr.de>; Wed, 11 Dec 2019 14:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfLKN7D (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Dec 2019 08:59:03 -0500
Received: from first.geanix.com ([116.203.34.67]:60066 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbfLKN7D (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 11 Dec 2019 08:59:03 -0500
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 4622B492;
        Wed, 11 Dec 2019 13:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1576072713; bh=wfH74zFrEAXNIyvLrbQD0mjNCBdp3zJerPCcME4k2KA=;
        h=From:To:Cc:Subject:Date;
        b=A4Krn4h0+drmE1uEEm+A4s9ME2fbC1qSAlIPsEGPRvXKrbqmMVCX+yqyfucI1SEnw
         F2ds4zzy25tKxnXTfmNnxlIs6p00vtLhi2l81piTn+qqouQtf73V9xzY7tYkfgjQd2
         r4gLbzoxuEpqYOM7uqrNQabKCMRmc7xBtB6seDHlxhFRlXeQZV0fuslMchUvtjya/y
         6NyXlkORtej0/4RmUwDOYojJ8cvGyi642zXCVhicqiVt26W8UMwVId2aIZFmIE6Mz/
         lbxYZKpd8wAEWoHKhFtn7ZPj518N3Sz5URag0EWKXYjtfxmwKruNz6hmxLb8Nzzl7y
         Li64HVVY6ztfQ==
From:   Sean Nyekjaer <sean@geanix.com>
To:     mkl@pengutronix.de, dmurphy@ti.com, linux-can@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v6 1/2] can: tcan4x5x: reset device before register access
Date:   Wed, 11 Dec 2019 14:58:51 +0100
Message-Id: <20191211135852.320650-1-sean@geanix.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=4.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 8b5b6f358cc9
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

It's a good idea to reset a ip-block/spi device before using it, this
patch will reset the device.

And a generic reset function if needed elsewhere.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes since v3:
 - added reset if the reset_gpio is not avaliable

Changes since v4:
 - added error handling for the SPI I/O

Changes since v5:
 - Removed braces for single statement if's

 Sorry for the mess :)

 drivers/net/can/m_can/tcan4x5x.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index 6676ecec48c3..dcfa85edc787 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -166,6 +166,28 @@ static void tcan4x5x_check_wake(struct tcan4x5x_priv *priv)
 	}
 }
 
+static int tcan4x5x_reset(struct tcan4x5x_priv *priv)
+{
+	int ret = 0;
+
+	if (priv->reset_gpio) {
+		gpiod_set_value(priv->reset_gpio, 1);
+
+		/* tpulse_width minimum 30us */
+		usleep_range(30, 100);
+		gpiod_set_value(priv->reset_gpio, 0);
+	} else {
+		ret = regmap_write(priv->regmap, TCAN4X5X_CONFIG,
+				   TCAN4X5X_SW_RESET);
+		if (ret)
+			return ret;
+	}
+
+	usleep_range(700, 1000);
+
+	return ret;
+}
+
 static int regmap_spi_gather_write(void *context, const void *reg,
 				   size_t reg_len, const void *val,
 				   size_t val_len)
@@ -351,6 +373,7 @@ static int tcan4x5x_disable_wake(struct m_can_classdev *cdev)
 static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 {
 	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
+	int ret;
 
 	tcan4x5x->device_wake_gpio = devm_gpiod_get(cdev->dev, "device-wake",
 						    GPIOD_OUT_HIGH);
@@ -366,7 +389,9 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 	if (IS_ERR(tcan4x5x->reset_gpio))
 		tcan4x5x->reset_gpio = NULL;
 
-	usleep_range(700, 1000);
+	ret = tcan4x5x_reset(tcan4x5x);
+	if (ret)
+		return ret;
 
 	tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
 							      "device-state",
-- 
2.24.0

