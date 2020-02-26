Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 661151700BF
	for <lists+linux-can@lfdr.de>; Wed, 26 Feb 2020 15:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgBZOJ1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Feb 2020 09:09:27 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37238 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgBZOJ0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Feb 2020 09:09:26 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01QE9BV5019682;
        Wed, 26 Feb 2020 08:09:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582726151;
        bh=qUxpFXYzynf3ipW3FKuxj4cz1djFjusDhz0uClvVdSw=;
        h=From:To:CC:Subject:Date;
        b=jO6ErSZTVXqX9HpWFTN0w3YCqcD0P/qaduGDLTz9RTOHbcV+fzq+d9YM/dE6idNys
         4WsJmvliPgjydWCqyx5LzLdmmmqa/zppDRlQDK66CHS63uTW6vdQmXBe7DNXShprGu
         LHIoD7zVxL9faD3wMXCMagqtSso9Ypd5EPmuNwBY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01QE9B3B075413;
        Wed, 26 Feb 2020 08:09:11 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 26
 Feb 2020 08:09:11 -0600
Received: from localhost.localdomain (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 26 Feb 2020 08:09:11 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 01QE9BAN103623;
        Wed, 26 Feb 2020 08:09:11 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <mkl@pengutronix.de>, <wg@grandegger.com>
CC:     <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH can-next] can: tcan4x5x: Rename parse_config function
Date:   Wed, 26 Feb 2020 08:03:58 -0600
Message-ID: <20200226140358.30017-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Rename the tcan4x5x_parse_config function to tcan4x5x_get_gpios since
the function retrieves the gpio configurations from the firmware.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

API name change request - https://lore.kernel.org/patchwork/patch/1165091/

 drivers/net/can/m_can/tcan4x5x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index 9821babef55e..37d53ecc560b 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -381,7 +381,7 @@ static int tcan4x5x_disable_state(struct m_can_classdev *cdev)
 				  TCAN4X5X_DISABLE_INH_MSK, 0x01);
 }
 
-static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
+static int tcan4x5x_get_gpios(struct m_can_classdev *cdev)
 {
 	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
 	int ret;
@@ -507,7 +507,7 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = tcan4x5x_parse_config(mcan_class);
+	ret = tcan4x5x_get_gpios(mcan_class);
 	if (ret)
 		goto out_power;
 
-- 
2.25.0

