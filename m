Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB956442C6C
	for <lists+linux-can@lfdr.de>; Tue,  2 Nov 2021 12:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhKBLYR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 2 Nov 2021 07:24:17 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58386 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhKBLYQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 2 Nov 2021 07:24:16 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1A2BLQsX050809;
        Tue, 2 Nov 2021 06:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1635852086;
        bh=XUupCBW+p9fG5DY3LYbMQ02MmZ+a2zm4IDWJC+uv03c=;
        h=From:To:CC:Subject:Date;
        b=sPpkAfb+hHjaO8iOcKRfi/itJ1OgaV8ooxkRTGo/yGgEAIKPwdDzV758Y6/tP+aQP
         n2ByFCHXXSsTDX9kViP9/y8euSYp02GLVXv4GUyOTYtRZ1Dz5O3jX+3S02EOIZpGG3
         E9doyGSn0bwOZOpZTVrw/9HAKbfoW8Y2hqfm8A/4=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1A2BLQxA103905
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Nov 2021 06:21:26 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 2
 Nov 2021 06:21:25 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 2 Nov 2021 06:21:26 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1A2BLMpg112235;
        Tue, 2 Nov 2021 06:21:22 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Nishanth Menon <nm@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, <linux-can@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] phy: phy-can-transceiver: Make devm_gpiod_get optional
Date:   Tue, 2 Nov 2021 16:51:20 +0530
Message-ID: <20211102112120.23637-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In some cases the standby/enable gpio can be pulled low/high and would not
be connected to a gpio. The current driver implementation will return an
error in these cases. Therefore, make devm_gpiod_get optional.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/phy-can-transceiver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index c2cb93b4df71..6f3fe37dee0e 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -110,14 +110,14 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	can_transceiver_phy->generic_phy = phy;
 
 	if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
-		standby_gpio = devm_gpiod_get(dev, "standby", GPIOD_OUT_HIGH);
+		standby_gpio = devm_gpiod_get_optional(dev, "standby", GPIOD_OUT_HIGH);
 		if (IS_ERR(standby_gpio))
 			return PTR_ERR(standby_gpio);
 		can_transceiver_phy->standby_gpio = standby_gpio;
 	}
 
 	if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
-		enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
+		enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
 		if (IS_ERR(enable_gpio))
 			return PTR_ERR(enable_gpio);
 		can_transceiver_phy->enable_gpio = enable_gpio;
-- 
2.17.1

