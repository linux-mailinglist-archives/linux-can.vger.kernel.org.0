Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9604411ABC2
	for <lists+linux-can@lfdr.de>; Wed, 11 Dec 2019 14:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfLKNM3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Dec 2019 08:12:29 -0500
Received: from first.geanix.com ([116.203.34.67]:57892 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729238AbfLKNM3 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 11 Dec 2019 08:12:29 -0500
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 6E09D490;
        Wed, 11 Dec 2019 13:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1576069919; bh=T7vnnRX2N+LQEgNhY+dpimj8SacNmx/2tf14/cgxptw=;
        h=From:To:Cc:Subject:Date;
        b=et+WkI+RSGp1f+Os9FDcZ6z21SDTCkc8veHpztALtcisEeFzW1Hzjz8fAMSSQ1Rdu
         rjWh54NVG6ZL42ovRutTAtkpBPh/5BTQv7wgLbWfVQaV0bWcSlclmroaPcZ69FOXfA
         //Wi7xiHJOfsCh99J5JDvK58ALELVpSHF5REhJUUq+DhvCJUAKVhSXRG2i2qygNdwN
         WUyVGzZJZVDxg3m5cdyV7POFyLPsE+Thfb9nItKTYCeZk2jmXE3aknnWW+RDheWyV6
         PSowAdYgmK0HAroshkm4VksMHli52WRWRVE+f2ES+DPg/N6y4uNY96kV8XSgbAR42j
         Jg/7SlX5hj0Ow==
From:   Sean Nyekjaer <sean@geanix.com>
To:     mkl@pengutronix.de, dmurphy@ti.com, linux-can@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, martin@geanix.com
Subject: [PATCH v4 1/2] can: tcan4x5x: reset device before register access
Date:   Wed, 11 Dec 2019 14:12:22 +0100
Message-Id: <20191211131223.292455-1-sean@geanix.com>
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

Added a generic reset function if needed elsewhere.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes v3:
 - added reset if the reset_gpio is not avaliable

 drivers/net/can/m_can/tcan4x5x.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index b6b2feca9e8f..960a16aca7ca 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -166,6 +166,21 @@ static void tcan4x5x_check_wake(struct tcan4x5x_priv *priv)
 	}
 }
 
+static void tcan4x5x_reset(struct tcan4x5x_priv *priv)
+{
+	if (priv->reset_gpio) {
+		gpiod_set_value(priv->reset_gpio, 1);
+
+		/* tpulse_width minimum 30us */
+		usleep_range(30, 100);
+		gpiod_set_value(priv->reset_gpio, 0);
+	} else {
+		regmap_write(priv->regmap, TCAN4X5X_CONFIG, TCAN4X5X_SW_RESET);
+	}
+
+	usleep_range(700, 1000);
+}
+
 static int regmap_spi_gather_write(void *context, const void *reg,
 				   size_t reg_len, const void *val,
 				   size_t val_len)
@@ -365,8 +380,8 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 						       GPIOD_OUT_LOW);
 	if (IS_ERR(tcan4x5x->reset_gpio))
 		tcan4x5x->reset_gpio = NULL;
-
-	usleep_range(700, 1000);
+	else
+		tcan4x5x_reset(tcan4x5x);
 
 	tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
 							      "device-state",
-- 
2.24.0

