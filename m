Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC4F6118DA0
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2019 17:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfLJQeS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 10 Dec 2019 11:34:18 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51142 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfLJQeR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Dec 2019 11:34:17 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBAGYD0o029944;
        Tue, 10 Dec 2019 10:34:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575995653;
        bh=TMX/OtqTGXcSlcQRliJXHDf+4GXR8VcwI5M8jDleaaw=;
        h=From:To:CC:Subject:Date;
        b=wFeQndwbuFwZfeAcWZznVdGBvAxmIRD5M2tOZ4sLa2rpR1KUQ/RNXSCQAdgZyXNsn
         5x5vhyxOXoLkNCpfobTflR2dslHCXqBvGwTeLGaoq1A4745dArvUEyXCtN0B9C3fuE
         46yQCxvjTTmJ0GbD1/PCeApQbBdXgN1kl0S3muaA=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBAGYDJs085479
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Dec 2019 10:34:13 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 10
 Dec 2019 10:34:13 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 10 Dec 2019 10:34:13 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBAGYDwN115554;
        Tue, 10 Dec 2019 10:34:13 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <mkl@pengutronix.de>
CC:     <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2] can: tcan4x5x: Turn on the power before parsing the config
Date:   Tue, 10 Dec 2019 10:32:04 -0600
Message-ID: <20191210163204.28225-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The parse config function now performs action on the device either
reading or writing and a reset.  If the regulator is managed it needs
to be turned on.  So turn on the regulator if available if the parsing
fails then turn off the regulator.

Fixes: a5235f3c7c23 ("can: tcan45x: Make wake-up GPIO an optional GPIO")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v2 - Added error handling and moved regulator_get to probe

 drivers/net/can/m_can/tcan4x5x.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index 4e1789ea2bc3..ddf7db498241 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -374,11 +374,6 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 	if (IS_ERR(tcan4x5x->device_state_gpio))
 		tcan4x5x->device_state_gpio = NULL;
 
-	tcan4x5x->power = devm_regulator_get_optional(cdev->dev,
-						      "vsup");
-	if (PTR_ERR(tcan4x5x->power) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-
 	return 0;
 }
 
@@ -412,6 +407,12 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->power = devm_regulator_get_optional(&spi->dev, "vsup");
+	if (PTR_ERR(priv->power) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	else
+		priv->power = NULL;
+
 	mcan_class->device_data = priv;
 
 	m_can_class_get_clocks(mcan_class);
@@ -451,11 +452,13 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	priv->regmap = devm_regmap_init(&spi->dev, &tcan4x5x_bus,
 					&spi->dev, &tcan4x5x_regmap);
 
-	ret = tcan4x5x_parse_config(mcan_class);
+	ret = tcan4x5x_power_enable(priv->power, 1);
 	if (ret)
 		goto out_clk;
 
-	tcan4x5x_power_enable(priv->power, 1);
+	ret = tcan4x5x_parse_config(mcan_class);
+	if (ret)
+		goto out_power;
 
 	ret = m_can_class_register(mcan_class);
 	if (ret)
-- 
2.23.0

