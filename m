Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB3C911786B
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 22:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfLIV0G (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 16:26:06 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54100 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLIV0G (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Dec 2019 16:26:06 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB9LPxaH052942;
        Mon, 9 Dec 2019 15:25:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575926759;
        bh=1gk21y/pQ6pPIfwAOcAQmC6TMPt+CKlLB8VJzkcowJc=;
        h=From:To:CC:Subject:Date;
        b=cx6utzfePBIrFOCz8SZnoLJ2TcFye6i+0O5Cj2ytVnWWShvt70gkxepyPSWe62vqA
         /LWqqU8oOzOI3BTT0EF9lDgjdiHrdH8G+7q+Se1UYhdqeNrfs4NyV9VfiFyIcOUCcV
         C4qcu3Yw6lOhP9wUPuwq0L5XbYnJR1G57dXa2kFY=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB9LPxxV077034
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Dec 2019 15:25:59 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 15:25:59 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 15:25:59 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB9LPxDe011052;
        Mon, 9 Dec 2019 15:25:59 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <mkl@pengutronix.de>
CC:     <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] can: tcan4x5x: Turn on the power before parsing the config
Date:   Mon, 9 Dec 2019 15:23:51 -0600
Message-ID: <20191209212351.27518-1-dmurphy@ti.com>
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
 drivers/net/can/m_can/tcan4x5x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index 4e1789ea2bc3..515486fcb150 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -451,11 +451,11 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	priv->regmap = devm_regmap_init(&spi->dev, &tcan4x5x_bus,
 					&spi->dev, &tcan4x5x_regmap);
 
+	tcan4x5x_power_enable(priv->power, 1);
+
 	ret = tcan4x5x_parse_config(mcan_class);
 	if (ret)
-		goto out_clk;
-
-	tcan4x5x_power_enable(priv->power, 1);
+		goto out_power;
 
 	ret = m_can_class_register(mcan_class);
 	if (ret)
-- 
2.23.0

