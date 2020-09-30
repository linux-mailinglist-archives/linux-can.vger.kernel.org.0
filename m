Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC4027E4CE
	for <lists+linux-can@lfdr.de>; Wed, 30 Sep 2020 11:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgI3JPV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 30 Sep 2020 05:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbgI3JOd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 30 Sep 2020 05:14:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEBCC0613D7
        for <linux-can@vger.kernel.org>; Wed, 30 Sep 2020 02:14:30 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kNYBw-0007UQ-MU; Wed, 30 Sep 2020 11:14:28 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 08/12] can: mcp251xfd: rename all user facing strings to mcp251xfd
Date:   Wed, 30 Sep 2020 11:14:20 +0200
Message-Id: <20200930091424.792165-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930091424.792165-1-mkl@pengutronix.de>
References: <20200930091424.792165-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In [1] Geert noted that the autodetect compatible for the mcp25xxfd driver,
which is "microchip,mcp25xxfd" might be too generic and overlap with upcoming,
but incompatible chips.

In the previous patch the autodetect DT compatbile has been renamed to
"microchip,mcp251xfd", this patch changes all user facing strings from
"mcp25xxfd" to "mcp251xfd" and "MCP25XXFD" to "MCP251XFD", including:
- kconfig symbols
- name of kernel module
- DT and SPI compatible

[1] http://lore.kernel.org/r/CAMuHMdVkwGjr6dJuMyhQNqFoJqbh6Ec5V2b5LenCshwpM2SDsQ@mail.gmail.com

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/Kconfig         | 10 ++++-----
 drivers/net/can/spi/mcp251xfd/Makefile        | 10 ++++-----
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 22 +++++++++----------
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  4 ++--
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/Kconfig b/drivers/net/can/spi/mcp251xfd/Kconfig
index 9eb596019a58..f5a147a92cb2 100644
--- a/drivers/net/can/spi/mcp251xfd/Kconfig
+++ b/drivers/net/can/spi/mcp251xfd/Kconfig
@@ -1,14 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-config CAN_MCP25XXFD
-	tristate "Microchip MCP25xxFD SPI CAN controllers"
+config CAN_MCP251XFD
+	tristate "Microchip MCP251xFD SPI CAN controllers"
 	select REGMAP
 	help
-	  Driver for the Microchip MCP25XXFD SPI FD-CAN controller
+	  Driver for the Microchip MCP251XFD SPI FD-CAN controller
 	  family.
 
-config CAN_MCP25XXFD_SANITY
-	depends on CAN_MCP25XXFD
+config CAN_MCP251XFD_SANITY
+	depends on CAN_MCP251XFD
 	bool "Additional Sanity Checks"
 	help
 	  This option enables additional sanity checks in the driver,
diff --git a/drivers/net/can/spi/mcp251xfd/Makefile b/drivers/net/can/spi/mcp251xfd/Makefile
index e943e6a2db0c..cb71244cbe89 100644
--- a/drivers/net/can/spi/mcp251xfd/Makefile
+++ b/drivers/net/can/spi/mcp251xfd/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_CAN_MCP25XXFD) += mcp25xxfd.o
+obj-$(CONFIG_CAN_MCP251XFD) += mcp251xfd.o
 
-mcp25xxfd-objs :=
-mcp25xxfd-objs += mcp251xfd-core.o
-mcp25xxfd-objs += mcp251xfd-crc16.o
-mcp25xxfd-objs += mcp251xfd-regmap.o
+mcp251xfd-objs :=
+mcp251xfd-objs += mcp251xfd-core.o
+mcp251xfd-objs += mcp251xfd-crc16.o
+mcp251xfd-objs += mcp251xfd-regmap.o
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 2988d93fbf82..37d3f07c9bf6 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -25,7 +25,7 @@
 
 #include "mcp251xfd.h"
 
-#define DEVICE_NAME "mcp25xxfd"
+#define DEVICE_NAME "mcp251xfd"
 
 static const struct mcp25xxfd_devtype_data mcp25xxfd_devtype_data_mcp2517fd = {
 	.quirks = MCP25XXFD_QUIRK_MAB_NO_WARN | MCP25XXFD_QUIRK_CRC_REG |
@@ -41,10 +41,10 @@ static const struct mcp25xxfd_devtype_data mcp25xxfd_devtype_data_mcp2518fd = {
 };
 
 /* Autodetect model, start with CRC enabled. */
-static const struct mcp25xxfd_devtype_data mcp25xxfd_devtype_data_mcp25xxfd = {
+static const struct mcp25xxfd_devtype_data mcp25xxfd_devtype_data_mcp251xfd = {
 	.quirks = MCP25XXFD_QUIRK_CRC_REG | MCP25XXFD_QUIRK_CRC_RX |
 		MCP25XXFD_QUIRK_CRC_TX | MCP25XXFD_QUIRK_ECC,
-	.model = MCP25XXFD_MODEL_MCP25XXFD,
+	.model = MCP25XXFD_MODEL_MCP251XFD,
 };
 
 static const struct can_bittiming_const mcp25xxfd_bittiming_const = {
@@ -78,8 +78,8 @@ static const char *__mcp25xxfd_get_model_str(enum mcp25xxfd_model model)
 		return "MCP2517FD"; break;
 	case MCP25XXFD_MODEL_MCP2518FD:
 		return "MCP2518FD"; break;
-	case MCP25XXFD_MODEL_MCP25XXFD:
-		return "MCP25xxFD"; break;
+	case MCP25XXFD_MODEL_MCP251XFD:
+		return "MCP251xFD"; break;
 	}
 
 	return "<unknown>";
@@ -2494,7 +2494,7 @@ static int mcp25xxfd_register_chip_detect(struct mcp25xxfd_priv *priv)
 	else
 		devtype_data = &mcp25xxfd_devtype_data_mcp2517fd;
 
-	if (!mcp25xxfd_is_25XX(priv) &&
+	if (!mcp25xxfd_is_251X(priv) &&
 	    priv->devtype_data.model != devtype_data->model) {
 		netdev_info(ndev,
 			    "Detected %s, but firmware specifies a %s. Fixing up.",
@@ -2703,8 +2703,8 @@ static const struct of_device_id mcp25xxfd_of_match[] = {
 		.compatible = "microchip,mcp2518fd",
 		.data = &mcp25xxfd_devtype_data_mcp2518fd,
 	}, {
-		.compatible = "microchip,mcp25xxfd",
-		.data = &mcp25xxfd_devtype_data_mcp25xxfd,
+		.compatible = "microchip,mcp251xfd",
+		.data = &mcp25xxfd_devtype_data_mcp251xfd,
 	}, {
 		/* sentinel */
 	},
@@ -2719,8 +2719,8 @@ static const struct spi_device_id mcp25xxfd_id_table[] = {
 		.name = "mcp2518fd",
 		.driver_data = (kernel_ulong_t)&mcp25xxfd_devtype_data_mcp2518fd,
 	}, {
-		.name = "mcp25xxfd",
-		.driver_data = (kernel_ulong_t)&mcp25xxfd_devtype_data_mcp25xxfd,
+		.name = "mcp251xfd",
+		.driver_data = (kernel_ulong_t)&mcp25xxfd_devtype_data_mcp251xfd,
 	}, {
 		/* sentinel */
 	},
@@ -2923,5 +2923,5 @@ static struct spi_driver mcp25xxfd_driver = {
 module_spi_driver(mcp25xxfd_driver);
 
 MODULE_AUTHOR("Marc Kleine-Budde <mkl@pengutronix.de>");
-MODULE_DESCRIPTION("Microchip MCP25xxFD Family CAN controller driver");
+MODULE_DESCRIPTION("Microchip MCP251xFD Family CAN controller driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 3bc799204cb0..b1b5d7fd33ea 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -553,7 +553,7 @@ struct mcp25xxfd_regs_status {
 enum mcp25xxfd_model {
 	MCP25XXFD_MODEL_MCP2517FD = 0x2517,
 	MCP25XXFD_MODEL_MCP2518FD = 0x2518,
-	MCP25XXFD_MODEL_MCP25XXFD = 0xffff,	/* autodetect model */
+	MCP25XXFD_MODEL_MCP251XFD = 0xffff,	/* autodetect model */
 };
 
 struct mcp25xxfd_devtype_data {
@@ -607,7 +607,7 @@ mcp25xxfd_is_##_model(const struct mcp25xxfd_priv *priv) \
 
 MCP25XXFD_IS(2517);
 MCP25XXFD_IS(2518);
-MCP25XXFD_IS(25XX);
+MCP25XXFD_IS(251X);
 
 static inline u8 mcp25xxfd_first_byte_set(u32 mask)
 {
-- 
2.28.0

