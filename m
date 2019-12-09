Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA202116892
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 09:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfLIIsT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 03:48:19 -0500
Received: from first.geanix.com ([116.203.34.67]:40328 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbfLIIsS (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 9 Dec 2019 03:48:18 -0500
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 2ABF8427;
        Mon,  9 Dec 2019 08:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575881278; bh=+KHQfpFBfx5PyUjh/fPV8Ne1QpMFs17pyp6yOoaVWUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YK27lVToorbAqVF8vY5MhYcoX9Rz/htNeXArPRjAspf1YPppuG8Uw2AzX2Sg4p4Ws
         gDq2FKw0pG7iqAObRGm703LoW7dxw0+2SulEQCWDVfr8viE7/l0J4VNWZvqNVIDXUm
         ks+xsKGniH38duEZG49k1ncK0oPxtY2sU/CIYywnmBzd4W3aFjQ+KjiwU7CbfNUkGU
         gUlvnuKIARCaTiPoBrdQCMdnzMaAN2U8gtfWs/tyUArGys25exP3CK/lLykzCvdYeN
         h7XaID3+ftzSqUVcCsn54+7SANoMcjU9g/CE68YMOboibUFz5WuPPMIYh/SpOVQktb
         gV4NC7WeT68LA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     mkl@pengutronix.de, dmurphy@ti.com, linux-can@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, martin@geanix.com
Subject: [PATCH 2/2] can: m_can: tcan4x5x: reset device before register access
Date:   Mon,  9 Dec 2019 09:48:08 +0100
Message-Id: <20191209084808.908116-2-sean@geanix.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209084808.908116-1-sean@geanix.com>
References: <20191209084808.908116-1-sean@geanix.com>
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

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/net/can/m_can/tcan4x5x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index 7f26c2d53f8c..dd812d40d475 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -361,14 +361,15 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 
 		tcan4x5x_disable_wake(cdev);
 	}
-
 	tcan4x5x->reset_gpio = devm_gpiod_get_optional(cdev->dev, "reset",
-						       GPIOD_OUT_LOW);
+						       GPIOD_OUT_HIGH);
 	if (IS_ERR(tcan4x5x->reset_gpio))
 		tcan4x5x->reset_gpio = NULL;
 
 	usleep_range(700, 1000);
 
+	gpiod_set_value(tcan4x5x->reset_gpio, 0);
+
 	tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
 							      "device-state",
 							      GPIOD_IN);
-- 
2.24.0

