Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E49969B5DB
	for <lists+linux-can@lfdr.de>; Fri, 23 Aug 2019 19:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404589AbfHWRvW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 23 Aug 2019 13:51:22 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43432 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfHWRvW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 23 Aug 2019 13:51:22 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7NHpIdH026421;
        Fri, 23 Aug 2019 12:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566582678;
        bh=kepUJMrNB0iOs6INlBu68+nYDwfVMm9VTcTnT8KbHlY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=XNb/2afuSvjMuE+D36OOrzQviu3Jff+z6ZUbBs5MySZxSPb85YhEnADfOEroWaru+
         qr9AkXcUZ70PohsTV8FCf0n1q7e3buFjx0sHBLUOzE/y8K62zoPYYnt67JG+OJ9hHP
         rEEVdkE96d5UPN6XexE6kLQuNz5UWR3nQ4ZBASi8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7NHpIhr045591
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Aug 2019 12:51:18 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 23
 Aug 2019 12:51:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 23 Aug 2019 12:51:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7NHpHYD051341;
        Fri, 23 Aug 2019 12:51:17 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <linux-can@vger.kernel.org>, <mkl@pengutronix.de>
CC:     Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 3/3] net: can: tcan4x5x: Remove checking the wake pin
Date:   Fri, 23 Aug 2019 12:50:58 -0500
Message-ID: <20190823175058.7442-3-dmurphy@ti.com>
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

Remove checking the wake pin for every read/write call.
The device is not explicitly put to sleep in the code
and the POR interrupt is cleared during the init of
the device.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/net/can/m_can/tcan4x5x.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index bb41e8d5f3a2..3db619209fe1 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -235,8 +235,6 @@ static u32 tcan4x5x_read_reg(struct m_can_classdev *cdev, int reg)
 	struct tcan4x5x_priv *priv = cdev->device_data;
 	u32 val;
 
-	tcan4x5x_check_wake(priv);
-
 	regmap_read(priv->regmap, priv->reg_offset + reg, &val);
 
 	return val;
@@ -247,8 +245,6 @@ static u32 tcan4x5x_read_fifo(struct m_can_classdev *cdev, int addr_offset)
 	struct tcan4x5x_priv *priv = cdev->device_data;
 	u32 val;
 
-	tcan4x5x_check_wake(priv);
-
 	regmap_read(priv->regmap, priv->mram_start + addr_offset, &val);
 
 	return val;
@@ -258,8 +254,6 @@ static int tcan4x5x_write_reg(struct m_can_classdev *cdev, int reg, int val)
 {
 	struct tcan4x5x_priv *priv = cdev->device_data;
 
-	tcan4x5x_check_wake(priv);
-
 	return regmap_write(priv->regmap, priv->reg_offset + reg, val);
 }
 
@@ -268,8 +262,6 @@ static int tcan4x5x_write_fifo(struct m_can_classdev *cdev,
 {
 	struct tcan4x5x_priv *priv = cdev->device_data;
 
-	tcan4x5x_check_wake(priv);
-
 	return regmap_write(priv->regmap, priv->mram_start + addr_offset, val);
 }
 
@@ -289,18 +281,13 @@ static int tcan4x5x_write_tcan_reg(struct m_can_classdev *cdev,
 {
 	struct tcan4x5x_priv *priv = cdev->device_data;
 
-	tcan4x5x_check_wake(priv);
-
 	return regmap_write(priv->regmap, reg, val);
 }
 
 static int tcan4x5x_clear_interrupts(struct m_can_classdev *cdev)
 {
-	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
 	int ret;
 
-	tcan4x5x_check_wake(tcan4x5x);
-
 	ret = tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_STATUS,
 				      TCAN4X5X_CLEAR_ALL_INT);
 	if (ret)
-- 
2.22.0.214.g8dca754b1e

