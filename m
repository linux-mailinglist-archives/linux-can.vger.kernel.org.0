Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B30411A4A7
	for <lists+linux-can@lfdr.de>; Wed, 11 Dec 2019 07:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfLKGm0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Dec 2019 01:42:26 -0500
Received: from first.geanix.com ([116.203.34.67]:40042 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbfLKGm0 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 11 Dec 2019 01:42:26 -0500
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id AC8BD471;
        Wed, 11 Dec 2019 06:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1576046517; bh=HBoukt/PSwdaxzGzn7309yDi6mpTvYjKMcv1r21lKEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hHEWh5N3QvJJa7+gJmDbWYNGwPP6g7ce2oLfQ2+9IHqkUQRR8fnNqcsgS5cE+6x2O
         waam0GKQUl97sNlEND80d6DTU5FYFS84b57uWPTNcPwtyT/dnIiHAecZulQiOK266c
         GoF/rNZ0NH7PleW2TZyaIdMKml8qj7dBByqv4nj8XEl3W0JdOPq6tL9iYVRBtoJePc
         g4IFqMO/iobdvXNw0BCjyvxmlHfzNQLYGg+3bJmXPL1W/64bdYUUzTPQ4F3YH1G5un
         XNG+tEf39urCDUG8gcJRlup6xX6CBNbU+Gf4IoMMvQ/kJjQPZAhEi2hu+7TcD61ybG
         fYQ3g3NoIOEXA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     mkl@pengutronix.de, dmurphy@ti.com, linux-can@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, martin@geanix.com
Subject: [PATCH v3 2/2] can: m_can: tcan4x5x: reset device before register access
Date:   Wed, 11 Dec 2019 07:42:08 +0100
Message-Id: <20191211064208.84656-2-sean@geanix.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211064208.84656-1-sean@geanix.com>
References: <20191211064208.84656-1-sean@geanix.com>
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

It's a good idea to reset a ip-block/spi device before using it,
this patch will reset the device.
And a generic reset function if needed elsewhere.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes since v2:
 - added reset function

 drivers/net/can/m_can/tcan4x5x.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index 1f04fec7723d..b5d2ea0999c1 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -166,6 +166,18 @@ static void tcan4x5x_check_wake(struct tcan4x5x_priv *priv)
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
+		usleep_range(700, 1000);
+	}
+}
+
 static int regmap_spi_gather_write(void *context, const void *reg,
 				   size_t reg_len, const void *val,
 				   size_t val_len)
@@ -365,8 +377,8 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
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

