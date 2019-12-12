Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8CAE11D20F
	for <lists+linux-can@lfdr.de>; Thu, 12 Dec 2019 17:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfLLQSL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 12 Dec 2019 11:18:11 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54824 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbfLLQSK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 Dec 2019 11:18:10 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBCGHvLv077744;
        Thu, 12 Dec 2019 10:17:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576167477;
        bh=nkLQXRQ87/SfQSBWWiilrp7/xPrpCi1hyGz8PEvF/Ss=;
        h=From:To:CC:Subject:Date;
        b=MePKYqk8/SzAObjqBi4Ei8Jj/L7n8dXOapx3cZPfRREr2XbqjHMo6qeDpjL7JMINx
         aorcAwPvlEPWZENyarLXp1EPYBvJm2qxB1jHrZijLpIj8QeJWoDQo3inBbCpxzaSvI
         Napit0EFcN1FLgXCYEA5W99U2Xu74ez1rBaoyGY8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBCGHvK9122783
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Dec 2019 10:17:57 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 12
 Dec 2019 10:17:57 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 12 Dec 2019 10:17:57 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBCGHvpu030666;
        Thu, 12 Dec 2019 10:17:57 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <linux-kernel@vger.kernel.org>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>, <wg@grandegger.com>,
        <sriram.dash@samsung.com>
CC:     Dan Murphy <dmurphy@ti.com>
Subject: [PATCH linux-can/testing] can: tcan4x5x: Disable the INH pin device-state GPIO is unavailable
Date:   Thu, 12 Dec 2019 10:15:36 -0600
Message-ID: <20191212161536.23264-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

If the device state GPIO is not connected to the host then disable the
INH output from the TCAN device per section 8.3.5 of the data sheet.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/net/can/m_can/tcan4x5x.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index b5d2ea0999c1..6a1f242d1876 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -102,6 +102,7 @@
 #define TCAN4X5X_MODE_NORMAL BIT(7)
 
 #define TCAN4X5X_DISABLE_WAKE_MSK	(BIT(31) | BIT(30))
+#define TCAN4X5X_DISABLE_INH_MSK	BIT(9)
 
 #define TCAN4X5X_SW_RESET BIT(2)
 
@@ -360,6 +361,15 @@ static int tcan4x5x_disable_wake(struct m_can_classdev *cdev)
 				  TCAN4X5X_DISABLE_WAKE_MSK, 0x00);
 }
 
+static int tcan4x5x_disable_state(struct m_can_classdev *cdev)
+{
+	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
+
+	return regmap_update_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
+				  TCAN4X5X_DISABLE_INH_MSK, 0x01);
+
+}
+
 static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 {
 	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
@@ -383,8 +393,10 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
 	tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
 							      "device-state",
 							      GPIOD_IN);
-	if (IS_ERR(tcan4x5x->device_state_gpio))
+	if (IS_ERR(tcan4x5x->device_state_gpio)) {
 		tcan4x5x->device_state_gpio = NULL;
+		tcan4x5x_disable_state(cdev);
+	}
 
 	return 0;
 }
-- 
2.23.0

