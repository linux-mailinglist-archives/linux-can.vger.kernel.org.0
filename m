Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FC444DAA9
	for <lists+linux-can@lfdr.de>; Thu, 11 Nov 2021 17:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbhKKQqa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 11 Nov 2021 11:46:30 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39350 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbhKKQq3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 11 Nov 2021 11:46:29 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1ABGhSnY117449;
        Thu, 11 Nov 2021 10:43:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1636649008;
        bh=k7bXhLNoj5kt2tCLCeFAz4grzLxLsAhcddQpqYT9CII=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RAAsnX7E+DGOBjiY2SGnsWRNwQSKsHXPCe6A477iKaoCElAAnOgJlSJWqyQKgPCQu
         TBTH8blQMovYHz+DIjh9Ow//xw81DXR4PBNxsjuTEgxGURz5EKvrx8f2u7TgKS98WH
         BnsLKkeLRt/Rf0r4GpWnop3F6nEvSyx7WMgfj5wY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1ABGhS8W067768
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Nov 2021 10:43:28 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 11
 Nov 2021 10:43:28 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 11 Nov 2021 10:43:28 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1ABGhEg4104171;
        Thu, 11 Nov 2021 10:43:24 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-can@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC 2/2] phy: phy-can-transceiver: Add support for setting mux
Date:   Thu, 11 Nov 2021 22:13:12 +0530
Message-ID: <20211111164313.649-3-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211111164313.649-1-a-govindraju@ti.com>
References: <20211111164313.649-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On some boards, for routing CAN signals from controller to transceiver,
muxes might need to be set. Therefore, add support for setting the mux by
reading the mux-controls property from the device tree node.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/phy-can-transceiver.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 6f3fe37dee0e..3d8da5226e27 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -10,6 +10,7 @@
 #include<linux/module.h>
 #include<linux/gpio.h>
 #include<linux/gpio/consumer.h>
+#include <linux/mux/consumer.h>
 
 struct can_transceiver_data {
 	u32 flags;
@@ -21,13 +22,22 @@ struct can_transceiver_phy {
 	struct phy *generic_phy;
 	struct gpio_desc *standby_gpio;
 	struct gpio_desc *enable_gpio;
+	struct mux_control *mux_ctrl;
 };
 
 /* Power on function */
 static int can_transceiver_phy_power_on(struct phy *phy)
 {
+	int ret;
 	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
 
+	if (can_transceiver_phy->mux_ctrl) {
+		ret = mux_control_select(can_transceiver_phy->mux_ctrl, 1);
+		if (ret) {
+			dev_err(&phy->dev, "Failed to select CAN mux: %d\n", ret);
+			return ret;
+		}
+	}
 	if (can_transceiver_phy->standby_gpio)
 		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
 	if (can_transceiver_phy->enable_gpio)
@@ -45,6 +55,8 @@ static int can_transceiver_phy_power_off(struct phy *phy)
 		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
 	if (can_transceiver_phy->enable_gpio)
 		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
+	if (can_transceiver_phy->mux_ctrl)
+		mux_control_deselect(can_transceiver_phy->mux_ctrl);
 
 	return 0;
 }
@@ -95,6 +107,15 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
 	drvdata = match->data;
 
+	if (of_property_read_bool(dev->of_node, "mux-controls")) {
+		struct mux_control *control;
+
+		control = devm_mux_control_get(dev, NULL);
+		if (IS_ERR(control))
+			return PTR_ERR(control);
+		can_transceiver_phy->mux_ctrl = control;
+	}
+
 	phy = devm_phy_create(dev, dev->of_node,
 			      &can_transceiver_phy_ops);
 	if (IS_ERR(phy)) {
-- 
2.17.1

