Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419A5459D7F
	for <lists+linux-can@lfdr.de>; Tue, 23 Nov 2021 09:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhKWIQK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Nov 2021 03:16:10 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35096 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhKWIQJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Nov 2021 03:16:09 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AN8Cm5C095619;
        Tue, 23 Nov 2021 02:12:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637655168;
        bh=sTEvQ1er5plxIGdGGZR1lqxkF4CWVe/9/U+j0wI+RZc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tVpT6338lr56oldmrxQNN+QotXyK5+oUVXFPTAMHdohoDLeWxybQejxriJXnprPMq
         tIb/tzZKljaqLdt+CR+LKMIB5Iv3pOBKMvVqTaEN7zETI/+yxp1PgFb29OPQ/Y046Z
         CWygWUc/eMRGHGzll68PSdvp0GV2G7XNltJeu7Ng=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AN8CmqV010533
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Nov 2021 02:12:48 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 23
 Nov 2021 02:12:48 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 23 Nov 2021 02:12:48 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AN8CNe2101399;
        Tue, 23 Nov 2021 02:12:44 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-can@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH RFC v3 4/4] phy: phy-can-transceiver: Add support for setting mux
Date:   Tue, 23 Nov 2021 13:42:21 +0530
Message-ID: <20211123081222.27979-5-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211123081222.27979-1-a-govindraju@ti.com>
References: <20211123081222.27979-1-a-govindraju@ti.com>
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
 drivers/phy/Kconfig               |  1 +
 drivers/phy/phy-can-transceiver.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 82b63e60c5a2..300b0f2b5f84 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -64,6 +64,7 @@ config USB_LGM_PHY
 config PHY_CAN_TRANSCEIVER
 	tristate "CAN transceiver PHY"
 	select GENERIC_PHY
+	select MULTIPLEXER
 	help
 	  This option enables support for CAN transceivers as a PHY. This
 	  driver provides function for putting the transceivers in various
diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 6f3fe37dee0e..6c94e3846410 100644
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
+	struct mux_state *mux_state;
 };
 
 /* Power on function */
 static int can_transceiver_phy_power_on(struct phy *phy)
 {
+	int ret;
 	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
 
+	if (can_transceiver_phy->mux_state) {
+		ret = mux_state_select(can_transceiver_phy->mux_state);
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
+	if (can_transceiver_phy->mux_state)
+		mux_state_deselect(can_transceiver_phy->mux_state);
 
 	return 0;
 }
@@ -95,6 +107,16 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
 	drvdata = match->data;
 
+	if (of_property_read_bool(dev->of_node, "mux-controls")) {
+		struct mux_state *mux_state;
+
+		mux_state = devm_mux_state_get(dev, NULL);
+		if (IS_ERR(mux_state))
+			return dev_err_probe(&pdev->dev, PTR_ERR(mux_state),
+					     "failed to get mux\n");
+		can_transceiver_phy->mux_state = mux_state;
+	}
+
 	phy = devm_phy_create(dev, dev->of_node,
 			      &can_transceiver_phy_ops);
 	if (IS_ERR(phy)) {
-- 
2.17.1

