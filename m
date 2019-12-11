Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A882711AC2E
	for <lists+linux-can@lfdr.de>; Wed, 11 Dec 2019 14:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfLKNjq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Dec 2019 08:39:46 -0500
Received: from first.geanix.com ([116.203.34.67]:59112 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbfLKNjq (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 11 Dec 2019 08:39:46 -0500
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id C294F490;
        Wed, 11 Dec 2019 13:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1576071555; bh=n8KMzkyatEmC+ppomN03f4PXJ10jfUzY8wTimoNWANQ=;
        h=From:To:Cc:Subject:Date;
        b=bDooYxSIFP4PbfEf82sg94k8WE0P4bJfsGa/BWbVG1x3vUcbPhuFkFkQSu2VsTITV
         GvZPkM15aymlf3zFa3jTWuCfPRzjWrbVOljCx5qR3eZE/JfKeo6FNpxC7GJA3teG3v
         ZYH2HcldSFFe2Cl1FVTVUX/84w2/o2QfaSGhn/fIXqeIiZ1h2/UQAIxmzGSWvdR9jn
         zoo933PHnRtBkxOT7tYG+c7CQwg0MUl5cHSPiwTF2RqMYqAHqCXOwFua9UVdm4zDKQ
         72V/2Zo1bm4++fSV4N6fJL0JyCpDyHABB+ildRi1jmoAIxBa6KPQksonU+GuzZuCQV
         SFlhax0lYV2HA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     mkl@pengutronix.de, dmurphy@ti.com, linux-can@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, martin@geanix.com
Subject: [PATCH v5 1/2] can: tcan4x5x: reset device before register access
Date:   Wed, 11 Dec 2019 14:39:25 +0100
Message-Id: <20191211133926.319015-1-sean@geanix.com>
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

 drivers/net/can/m_can/tcan4x5x.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index b6b2feca9e8f..032d110e0870 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -166,6 +166,27 @@ static void tcan4x5x_check_wake(struct tcan4x5x_priv *priv)
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
+		ret = regmap_write(priv->regmap, TCAN4X5X_CONFIG, TCAN4X5X_SW_RESET);
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
@@ -351,6 +372,7 @@ static int tcan4x5x_disable_wake(struct m_can_classdev *cdev)
 static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 {
 	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
+	int ret;
 
 	tcan4x5x->device_wake_gpio = devm_gpiod_get(cdev->dev, "device-wake",
 						    GPIOD_OUT_HIGH);
@@ -363,10 +385,13 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 
 	tcan4x5x->reset_gpio = devm_gpiod_get_optional(cdev->dev, "reset",
 						       GPIOD_OUT_LOW);
-	if (IS_ERR(tcan4x5x->reset_gpio))
+	if (IS_ERR(tcan4x5x->reset_gpio)) {
 		tcan4x5x->reset_gpio = NULL;
+	}
 
-	usleep_range(700, 1000);
+	ret = tcan4x5x_reset(tcan4x5x);
+	if (ret)
+		return ret;
 
 	tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
 							      "device-state",
-- 
2.24.0

