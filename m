Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 091FE9B5DC
	for <lists+linux-can@lfdr.de>; Fri, 23 Aug 2019 19:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbfHWRvY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 23 Aug 2019 13:51:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44556 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404583AbfHWRvX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 23 Aug 2019 13:51:23 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7NHpItH054615;
        Fri, 23 Aug 2019 12:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566582678;
        bh=UenbNFcdxNFSdWapMMQhaACGIZTo/PFEpEF1VRVHvHY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mvFx6PmWXZ0oFE5kOYZ4SYhKTuL2qgKQ9GpyoCbG35PDq1Ge8LWRySY7Ifg9KeFHv
         pGBziK0ADGp5hWkz7oQeUtOoBwWB6H/6qUI6vus//0w+cSWON0OTkMdthuj+YJ0ym0
         sRDwCxZ5jZAyzXwcOA4DqPWSTSo5qmRt4Zopchtc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7NHpIxD008925
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Aug 2019 12:51:18 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 23
 Aug 2019 12:51:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 23 Aug 2019 12:51:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7NHpHAx044835;
        Fri, 23 Aug 2019 12:51:17 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <linux-can@vger.kernel.org>, <mkl@pengutronix.de>
CC:     Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 2/3] net: can: tcan4x5x: Remove data-ready gpio interrupt
Date:   Fri, 23 Aug 2019 12:50:57 -0500
Message-ID: <20190823175058.7442-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.22.0.214.g8dca754b1e
In-Reply-To: <20190823175058.7442-1-dmurphy@ti.com>
References: <20190823175058.7442-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Remove the data-ready gpio interrupt handling and use the spi->irq
that is created based on the interrupt DT property.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/net/can/m_can/tcan4x5x.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index a697996d81b4..bb41e8d5f3a2 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -117,7 +117,6 @@ struct tcan4x5x_priv {
 	struct m_can_classdev *mcan_dev;
 
 	struct gpio_desc *reset_gpio;
-	struct gpio_desc *interrupt_gpio;
 	struct gpio_desc *device_wake_gpio;
 	struct gpio_desc *device_state_gpio;
 	struct regulator *power;
@@ -356,13 +355,6 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 {
 	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
 
-	tcan4x5x->interrupt_gpio = devm_gpiod_get(cdev->dev, "data-ready",
-						  GPIOD_IN);
-	if (IS_ERR(tcan4x5x->interrupt_gpio)) {
-		dev_err(cdev->dev, "data-ready gpio not defined\n");
-		return -EINVAL;
-	}
-
 	tcan4x5x->device_wake_gpio = devm_gpiod_get(cdev->dev, "device-wake",
 						    GPIOD_OUT_HIGH);
 	if (IS_ERR(tcan4x5x->device_wake_gpio)) {
@@ -381,8 +373,6 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 	if (IS_ERR(tcan4x5x->device_state_gpio))
 		tcan4x5x->device_state_gpio = NULL;
 
-	cdev->net->irq = gpiod_to_irq(tcan4x5x->interrupt_gpio);
-
 	tcan4x5x->power = devm_regulator_get_optional(cdev->dev,
 						      "vsup");
 	if (PTR_ERR(tcan4x5x->power) == -EPROBE_DEFER)
@@ -447,6 +437,7 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	mcan_class->is_peripheral = true;
 	mcan_class->bit_timing = &tcan4x5x_bittiming_const;
 	mcan_class->data_timing = &tcan4x5x_data_bittiming_const;
+	mcan_class->net->irq = spi->irq;
 
 	spi_set_drvdata(spi, priv);
 
-- 
2.22.0.214.g8dca754b1e

