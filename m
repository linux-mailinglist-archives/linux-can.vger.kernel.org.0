Return-Path: <linux-can+bounces-5145-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96622BD23DD
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 11:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41413C2A19
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 09:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6E92FD1D6;
	Mon, 13 Oct 2025 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRUfjMKy"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1902FD1BC;
	Mon, 13 Oct 2025 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347170; cv=none; b=frr6bJUsrgRM1/OorkDGPrq4fcGoRo+Bi2FK5M48cMNOcg5MMG2nmtXVCGER4GeqQZEVqhD22T6gSAL+iKryXC7Xr2jfU5u26/cSpWZiHo9Pr/BWI4y4XT1e5I4wYElwpVauEPAUALxbYMjDwhwFeCW+8mzzPBkZBMCUPCTgufw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347170; c=relaxed/simple;
	bh=uNFGhoAGgykNoPJ8CNQn5LZshPohZnbUoD3NSbz5JRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oCT2I2zl/FsjQClZ/tMmAWyD7eEibnRvj8n5nIex3hdspfUxlgbvihs5id/QUuh2ah55LlwewmugrOCUf7NaVsAFLyTZS9zUz9ih25ZX00jy2GEg3+IYDNtcIQoNq3iGBjScwsCIRbpfs5O3Fvjkr2fG1iTq0QH2gWckp3PD4BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRUfjMKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 429ACC4CEF8;
	Mon, 13 Oct 2025 09:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760347170;
	bh=uNFGhoAGgykNoPJ8CNQn5LZshPohZnbUoD3NSbz5JRM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lRUfjMKytE1MB89vYpfQKHKZw2Ezmx4uBSYdfouwFxm/1P5eUKZg2HUnJOw1EahRg
	 +KfnPlFMRkqYrhEABogsubC94xYUkZd97OjPT7gZp62BoeZF7vah8/8/hgTjsIRbNa
	 bV2JIkdBnwgn0yihA2CjtnavIsUbosSN59aAU6b5YqKeYC9TdUr5LhQm1od6gNQRFq
	 J0Hd0PvC+K1G91VHABSRvmP6m6mYb4m4HfB+jWmLbjGPgIDg7Ikzr2Pv2D9/VTkixS
	 MkJFA2CiSMUtblqZV7k0cZYSf2zaAL0zlbvVKWMnaWabM/Kqdya/NusK+n409Z6ZKU
	 0uCs8OyILZO1Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33213CCA476;
	Mon, 13 Oct 2025 09:19:30 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Mon, 13 Oct 2025 11:19:19 +0200
Subject: [PATCH v3 2/2] phy: add basic support for NXPs TJA1145 CAN
 transceiver
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-tja1145-support-v3-2-4a9d245fe067@liebherr.com>
References: <20251013-tja1145-support-v3-0-4a9d245fe067@liebherr.com>
In-Reply-To: <20251013-tja1145-support-v3-0-4a9d245fe067@liebherr.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760347168; l=7265;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=m4QiREHDlNRu4w4+aKlLV9DdljRQB5Dfw10oKYtH/Oc=;
 b=G08KFMJnckl9HbiuGU1DW/NNgr892iIRjXj7cOB28r5Ii4/cxIf4UgH9pikn8f6AVcekJGyi3
 m9THSlhXx+WBuAzAgRPhZfnBBGydOI+VZGi8vqCaa+f5yz3PFDKQiKd
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Add basic driver support for NXPs TJA1145 CAN transceiver which brings the
PHY up/down by switching to normal/standby mode using SPI commands.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/phy/Kconfig           |  10 +++
 drivers/phy/Makefile          |   1 +
 drivers/phy/phy-nxp-tja1145.c | 185 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 196 insertions(+)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 678dd0452f0aa0597773433f04d2a9ba77474d2a..2f2c8f29cce2beb20c584adfe8acfe23de14e128 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -101,6 +101,16 @@ config PHY_NXP_PTN3222
 	  schemes. It supports all three USB 2.0 data rates: Low Speed, Full
 	  Speed and High Speed.
 
+config PHY_NXP_TJA1145
+	tristate "NXP TJA1145 CAN transceiver PHY"
+	select GENERIC_PHY
+	select REGMAP_SPI
+	depends on SPI
+	help
+	  This option enables support for NXPs TJA1145 CAN transceiver as a PHY.
+	  This driver provides function for putting the transceiver in various
+	  functional modes using SPI commands.
+
 source "drivers/phy/allwinner/Kconfig"
 source "drivers/phy/amlogic/Kconfig"
 source "drivers/phy/broadcom/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index bfb27fb5a494283d7fd05dd670ebd1b12df8b1a1..48eac644d1e2b20f986f80de95b40c26d080358b 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_PHY_SNPS_EUSB2)		+= phy-snps-eusb2.o
 obj-$(CONFIG_USB_LGM_PHY)		+= phy-lgm-usb.o
 obj-$(CONFIG_PHY_AIROHA_PCIE)		+= phy-airoha-pcie.o
 obj-$(CONFIG_PHY_NXP_PTN3222)		+= phy-nxp-ptn3222.o
+obj-$(CONFIG_PHY_NXP_TJA1145)		+= phy-nxp-tja1145.o
 obj-y					+= allwinner/	\
 					   amlogic/	\
 					   broadcom/	\
diff --git a/drivers/phy/phy-nxp-tja1145.c b/drivers/phy/phy-nxp-tja1145.c
new file mode 100644
index 0000000000000000000000000000000000000000..4d3aa5bfcd88d5755fa37e0d42bfa8293dee2155
--- /dev/null
+++ b/drivers/phy/phy-nxp-tja1145.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Liebherr-Electronics and Drives GmbH
+ */
+#include <linux/bitfield.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include <linux/phy/phy.h>
+#include <linux/spi/spi.h>
+
+#define TJA1145_MODE_CTRL		0x01
+#define TJA1145_MODE_CTRL_MC		GENMASK(2, 0)
+#define TJA1145_MODE_CRTL_STBY		BIT(2)
+#define TJA1145_MODE_CRTL_NORMAL	TJA1145_MODE_CTRL_MC
+
+#define TJA1145_CAN_CTRL		0x20
+#define TJA1145_CAN_CTRL_CMC		GENMASK(1, 0)
+#define TJA1145_CAN_CTRL_ACTIVE		BIT(1)
+
+#define TJA1145_IDENT			0x7e
+#define TJA1145_IDENT_TJA1145T		0x70
+
+#define TJA1145_SPI_READ_BIT		BIT(0)
+#define TJA1145T_MAX_BITRATE		1000000
+
+static int tja1145_phy_power_on(struct phy *phy)
+{
+	struct regmap *map = phy_get_drvdata(phy);
+	int ret;
+
+	/*
+	 * Switch operating mode to normal which is the active operating mode.
+	 * In this mode, the device is fully operational.
+	 */
+	ret = regmap_update_bits(map, TJA1145_MODE_CTRL, TJA1145_MODE_CTRL_MC,
+				 TJA1145_MODE_CRTL_NORMAL);
+	if (ret)
+		return ret;
+
+	/*
+	 * Switch to CAN operating mode active where the PHY can transmit and
+	 * receive data.
+	 */
+	return regmap_update_bits(map, TJA1145_CAN_CTRL, TJA1145_CAN_CTRL_CMC,
+				  TJA1145_CAN_CTRL_ACTIVE);
+}
+
+static int tja1145_phy_power_off(struct phy *phy)
+{
+	struct regmap *map = phy_get_drvdata(phy);
+
+	/*
+	 * Switch to operating mode standby, the PHY is unable to transmit or
+	 * receive data in standby mode.
+	 */
+	return regmap_update_bits(map, TJA1145_MODE_CTRL, TJA1145_MODE_CTRL_MC,
+				  TJA1145_MODE_CRTL_STBY);
+}
+
+static const struct phy_ops tja1145_phy_ops = {
+	.power_on = tja1145_phy_power_on,
+	.power_off = tja1145_phy_power_off,
+};
+
+static const struct regmap_range tja1145_wr_holes_ranges[] = {
+	regmap_reg_range(0x00, 0x00),
+	regmap_reg_range(0x02, 0x03),
+	regmap_reg_range(0x05, 0x05),
+	regmap_reg_range(0x0b, 0x1f),
+	regmap_reg_range(0x21, 0x22),
+	regmap_reg_range(0x24, 0x25),
+	regmap_reg_range(0x30, 0x4b),
+	regmap_reg_range(0x4d, 0x60),
+	regmap_reg_range(0x62, 0x62),
+	regmap_reg_range(0x65, 0x67),
+	regmap_reg_range(0x70, 0xff),
+};
+
+static const struct regmap_access_table tja1145_wr_table = {
+	.no_ranges = tja1145_wr_holes_ranges,
+	.n_no_ranges = ARRAY_SIZE(tja1145_wr_holes_ranges),
+};
+
+static const struct regmap_range tja1145_rd_holes_ranges[] = {
+	regmap_reg_range(0x00, 0x00),
+	regmap_reg_range(0x02, 0x02),
+	regmap_reg_range(0x05, 0x05),
+	regmap_reg_range(0x0b, 0x1f),
+	regmap_reg_range(0x21, 0x21),
+	regmap_reg_range(0x24, 0x25),
+	regmap_reg_range(0x30, 0x4a),
+	regmap_reg_range(0x4d, 0x5f),
+	regmap_reg_range(0x62, 0x62),
+	regmap_reg_range(0x65, 0x67),
+	regmap_reg_range(0x70, 0x7d),
+	regmap_reg_range(0x7f, 0xff),
+};
+
+static const struct regmap_access_table tja1145_rd_table = {
+	.no_ranges = tja1145_rd_holes_ranges,
+	.n_no_ranges = ARRAY_SIZE(tja1145_rd_holes_ranges),
+};
+
+
+static const struct regmap_config tja1145_regmap_config = {
+	.reg_bits = 8,
+	.reg_shift = -1,
+	.val_bits = 8,
+	.wr_table = &tja1145_wr_table,
+	.rd_table = &tja1145_rd_table,
+	.read_flag_mask = TJA1145_SPI_READ_BIT,
+	.max_register = TJA1145_IDENT,
+};
+
+static int tja1145_check_ident(struct device *dev, struct regmap *map)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(map, TJA1145_IDENT, &val);
+	if (ret)
+		return ret;
+
+	if (val != TJA1145_IDENT_TJA1145T) {
+		dev_err(dev, "Expected device id: 0x%02x, got: 0x%02x\n",
+			TJA1145_IDENT_TJA1145T, val);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int tja1145_probe(struct spi_device *spi)
+{
+	struct phy_provider *phy_provider;
+	struct device *dev = &spi->dev;
+	struct regmap *map;
+	struct phy *phy;
+	int ret;
+
+	map = devm_regmap_init_spi(spi, &tja1145_regmap_config);
+	if (IS_ERR(map))
+		return dev_err_probe(dev, PTR_ERR(map), "failed to init regmap\n");
+
+	ret = tja1145_check_ident(dev, map);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to identify device\n");
+
+	phy = devm_phy_create(dev, dev->of_node, &tja1145_phy_ops);
+	if (IS_ERR(phy))
+		return dev_err_probe(dev, PTR_ERR(phy), "failed to create PHY\n");
+
+	phy->attrs.max_link_rate = TJA1145T_MAX_BITRATE;
+	phy_set_drvdata(phy, map);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct spi_device_id tja1145_spi_id[] = {
+	{ "tja1145" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, tja1145_spi_id);
+
+static const struct of_device_id tja1145_of_match[] = {
+	{ .compatible = "nxp,tja1145-can" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tja1145_of_match);
+
+static struct spi_driver tja1145_driver = {
+	.driver = {
+		.name = "tja1145",
+		.of_match_table = tja1145_of_match,
+	},
+	.probe = tja1145_probe,
+	.id_table = tja1145_spi_id,
+};
+module_spi_driver(tja1145_driver);
+
+MODULE_DESCRIPTION("NXP TJA1145 CAN transceiver PHY driver");
+MODULE_AUTHOR("Dimitri Fedrau <dimitri.fedrau@liebherr.com>");
+MODULE_LICENSE("GPL");

-- 
2.39.5



