Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879ED36194A
	for <lists+linux-can@lfdr.de>; Fri, 16 Apr 2021 07:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237998AbhDPF1h (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 16 Apr 2021 01:27:37 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52472 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237946AbhDPF1g (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Apr 2021 01:27:36 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13G5R4LC100520;
        Fri, 16 Apr 2021 00:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1618550824;
        bh=lwxVMlwuqdF0QN7LNGKmmThT0L4EvWg4hfu0HYGlBX0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZqZm6j8aOMieC+7f74SV1VVBLZ6KvKdTdRK0qXTAUI1HJkCNKiwA+3U3AwdgcTWUZ
         B7ndFaGFfjC/QG6JQw3kSoBJSni3OEorcR98cPwKLCk2rPaRkScxWGjY9jPG0sAqb2
         EDgBbLqKHkmLsuHsklfhcM9Kvby94/jguaaw+C8s=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13G5R4AE115781
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Apr 2021 00:27:04 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 16
 Apr 2021 00:27:03 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 16 Apr 2021 00:27:03 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13G5QlLO023847;
        Fri, 16 Apr 2021 00:27:00 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-can@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH v4 3/3] phy: phy-can-transceiver: Add support for generic CAN transceiver driver
Date:   Fri, 16 Apr 2021 10:56:47 +0530
Message-ID: <20210416052647.2758-4-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210416052647.2758-1-a-govindraju@ti.com>
References: <20210416052647.2758-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The driver adds support for generic CAN transceivers. Currently
the modes supported by this driver are standby and normal modes for TI
TCAN1042 and TCAN1043 CAN transceivers.

The transceiver is modelled as a phy with pins controlled by gpios, to put
the transceiver in various device functional modes. It also gets the phy
attribute max_link_rate for the usage of CAN drivers.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 MAINTAINERS                       |   1 +
 drivers/phy/Kconfig               |   9 ++
 drivers/phy/Makefile              |   1 +
 drivers/phy/phy-can-transceiver.c | 146 ++++++++++++++++++++++++++++++
 4 files changed, 157 insertions(+)
 create mode 100644 drivers/phy/phy-can-transceiver.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e666d33af10d..4e868f2a97c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4048,6 +4048,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git
 F:	Documentation/devicetree/bindings/net/can/
 F:	Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
 F:	drivers/net/can/
+F:	drivers/phy/phy-can-transceiver.c
 F:	include/linux/can/bittiming.h
 F:	include/linux/can/dev.h
 F:	include/linux/can/led.h
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 54c1f2f0985f..51902b629fc6 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -61,6 +61,15 @@ config USB_LGM_PHY
 	  interface to interact with USB GEN-II and USB 3.x PHY that is part
 	  of the Intel network SOC.
 
+config PHY_CAN_TRANSCEIVER
+	tristate "CAN transceiver PHY"
+	select GENERIC_PHY
+	help
+	  This option enables support for CAN transceivers as a PHY. This
+	  driver provides function for putting the transceivers in various
+	  functional modes using gpios and sets the attribute max link
+	  rate, for mcan drivers.
+
 source "drivers/phy/allwinner/Kconfig"
 source "drivers/phy/amlogic/Kconfig"
 source "drivers/phy/broadcom/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index adac1b1a39d1..01e9efffc726 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
 obj-$(CONFIG_GENERIC_PHY_MIPI_DPHY)	+= phy-core-mipi-dphy.o
+obj-$(CONFIG_PHY_CAN_TRANSCEIVER)	+= phy-can-transceiver.o
 obj-$(CONFIG_PHY_LPC18XX_USB_OTG)	+= phy-lpc18xx-usb-otg.o
 obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
 obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
new file mode 100644
index 000000000000..c24aa2eab9e4
--- /dev/null
+++ b/drivers/phy/phy-can-transceiver.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * phy-can-transceiver.c - phy driver for CAN transceivers
+ *
+ * Copyright (C) 2021 Texas Instruments Incorporated - http://www.ti.com
+ *
+ */
+#include<linux/phy/phy.h>
+#include<linux/platform_device.h>
+#include<linux/module.h>
+#include<linux/gpio.h>
+#include<linux/gpio/consumer.h>
+
+struct can_transceiver_data {
+	u32 flags;
+#define CAN_TRANSCEIVER_STB_PRESENT	BIT(0)
+#define CAN_TRANSCEIVER_EN_PRESENT	BIT(1)
+};
+
+struct can_transceiver_phy {
+	struct phy *generic_phy;
+	struct gpio_desc *standby_gpio;
+	struct gpio_desc *enable_gpio;
+};
+
+/* Power on function */
+static int can_transceiver_phy_power_on(struct phy *phy)
+{
+	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
+
+	if (can_transceiver_phy->standby_gpio)
+		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
+	if (can_transceiver_phy->enable_gpio)
+		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 1);
+
+	return 0;
+}
+
+/* Power off function */
+static int can_transceiver_phy_power_off(struct phy *phy)
+{
+	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
+
+	if (can_transceiver_phy->standby_gpio)
+		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
+	if (can_transceiver_phy->enable_gpio)
+		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
+
+	return 0;
+}
+
+static const struct phy_ops can_transceiver_phy_ops = {
+	.power_on	= can_transceiver_phy_power_on,
+	.power_off	= can_transceiver_phy_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static const struct can_transceiver_data tcan1042_drvdata = {
+	.flags = CAN_TRANSCEIVER_STB_PRESENT,
+};
+
+static const struct can_transceiver_data tcan1043_drvdata = {
+	.flags = CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_EN_PRESENT,
+};
+
+static const struct of_device_id can_transceiver_phy_ids[] = {
+	{
+		.compatible = "ti,tcan1042",
+		.data = &tcan1042_drvdata
+	},
+	{
+		.compatible = "ti,tcan1043",
+		.data = &tcan1043_drvdata
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, can_transceiver_phy_ids);
+
+static int can_transceiver_phy_probe(struct platform_device *pdev)
+{
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	struct can_transceiver_phy *can_transceiver_phy;
+	const struct can_transceiver_data *drvdata;
+	const struct of_device_id *match;
+	struct phy *phy;
+	struct gpio_desc *standby_gpio;
+	struct gpio_desc *enable_gpio;
+	u32 max_bitrate = 0;
+
+	can_transceiver_phy = devm_kzalloc(dev, sizeof(struct can_transceiver_phy), GFP_KERNEL);
+	if (!can_transceiver_phy)
+		return -ENOMEM;
+
+	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
+	drvdata = match->data;
+
+	phy = devm_phy_create(dev, dev->of_node,
+			      &can_transceiver_phy_ops);
+	if (IS_ERR(phy)) {
+		dev_err(dev, "failed to create can transceiver phy\n");
+		return PTR_ERR(phy);
+	}
+
+	device_property_read_u32(dev, "max-bitrate", &max_bitrate);
+	if (!max_bitrate)
+		dev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit\n");
+	phy->attrs.max_link_rate = max_bitrate;
+
+	can_transceiver_phy->generic_phy = phy;
+
+	if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
+		standby_gpio = devm_gpiod_get(dev, "standby", GPIOD_OUT_HIGH);
+		if (IS_ERR(standby_gpio))
+			return PTR_ERR(standby_gpio);
+		can_transceiver_phy->standby_gpio = standby_gpio;
+	}
+
+	if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
+		enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
+		if (IS_ERR(enable_gpio))
+			return PTR_ERR(enable_gpio);
+		can_transceiver_phy->enable_gpio = enable_gpio;
+	}
+
+	phy_set_drvdata(can_transceiver_phy->generic_phy, can_transceiver_phy);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static struct platform_driver can_transceiver_phy_driver = {
+	.probe = can_transceiver_phy_probe,
+	.driver = {
+		.name = "can-transceiver-phy",
+		.of_match_table = can_transceiver_phy_ids,
+	},
+};
+
+module_platform_driver(can_transceiver_phy_driver);
+
+MODULE_AUTHOR("Faiz Abbas <faiz_abbas@ti.com>");
+MODULE_AUTHOR("Aswath Govindraju <a-govindraju@ti.com>");
+MODULE_DESCRIPTION("CAN TRANSCEIVER PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

