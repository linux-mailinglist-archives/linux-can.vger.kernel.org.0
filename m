Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70D511175A0
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 20:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfLITYr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 14:24:47 -0500
Received: from first.geanix.com ([116.203.34.67]:43968 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfLITYr (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 9 Dec 2019 14:24:47 -0500
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 9B55F44B;
        Mon,  9 Dec 2019 19:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575919464; bh=1IP+7+dztezCswzJlo5kNtGBW7HEn7JRLfIkOk06rqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GznADVki4PVYvwy4sWbuOsrAg5wPIlFk7u77AIdOd912//jriioQunRviVVWq9Dwd
         9l6JI55fsJ8bO24Qi0NNqd0aP7l3ldnL8FrFlNj63D7nFDxBuumYlzakj7q5MwSjj/
         w5wAVUHerebxqdCmaxg3c4n5uPXfEUEQfqY4UuzKaQ8tsZPzi8BC7WMKg7w2fGGIQR
         e4xVuCfTszDrnJtkD1G/CJGL6fhwfQMtmbpy6GV70Gck8FHHShCLD8m2F3cn84BQay
         xq560LaMp9U2PGGpYUhuAn+EikvyCCNj/dWfFNXL4JJvRri/7b0XmxVYArHYmpZLbv
         StvfO0Em+IlxA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     mkl@pengutronix.de, dmurphy@ti.com, linux-can@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, martin@geanix.com
Subject: [PATCH v2 2/2] can: m_can: tcan4x5x: reset device before register access
Date:   Mon,  9 Dec 2019 20:24:40 +0100
Message-Id: <20191209192440.998659-2-sean@geanix.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209192440.998659-1-sean@geanix.com>
References: <20191209192440.998659-1-sean@geanix.com>
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
Changes since v1:
 - Added toggle of reset pin with required delay
 - Only toggle reset pin if it exist

 drivers/net/can/m_can/tcan4x5x.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index 3c30209ca84c..5b26e494a7db 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -363,8 +363,15 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 
 	tcan4x5x->reset_gpio = devm_gpiod_get_optional(cdev->dev, "reset",
 						       GPIOD_OUT_LOW);
-	if (IS_ERR(tcan4x5x->reset_gpio))
+	if (IS_ERR(tcan4x5x->reset_gpio)) {
 		tcan4x5x->reset_gpio = NULL;
+	} else {
+		gpiod_set_value(tcan4x5x->reset_gpio, 1);
+
+		/* tpulse_width minimum 30us */
+		usleep_range(30, 100);
+		gpiod_set_value(tcan4x5x->reset_gpio, 0);
+	}
 
 	usleep_range(700, 1000);
 
-- 
2.24.0

