Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D432B714A8E
	for <lists+linux-can@lfdr.de>; Mon, 29 May 2023 15:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjE2Noz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 May 2023 09:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjE2Noy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 May 2023 09:44:54 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D31F9C
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 06:44:52 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f4db9987f8so4640274e87.1
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 06:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1685367890; x=1687959890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoQl7neWUUG9XRfrLiG+imkYpfJMcZK8KAHS6OMRv5o=;
        b=delalG1VBSTRVZjzTkhA0dChTBx3MNTupgvpA/LWdmpYs75Uh6KUxs2vKGezt53Ijd
         Nx2CIX1Yu/ZBfeYUooVjouUuuenFuW2CsRolZg0U2r9f/LCNSUuQGcwXOiaP9OdZrRz7
         AHttao/MtYGbq+GydPVkrQeZclZgUISvCTx9o/EhfOA//BMFELn3mSlJd/vnbTzHrA8i
         Wl5toQjcKy8Bk7FBuzrPsrmtZUxHxpUMVYrQqhqnd4paRzcTRjypThhZq39qx7brktkr
         nQf9imcvI0HWoIt1xKo0v24Tz/B46gQKG90ag5ZPGlzu195kjOAZZcuZzSMq3msmoEBO
         sDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685367890; x=1687959890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoQl7neWUUG9XRfrLiG+imkYpfJMcZK8KAHS6OMRv5o=;
        b=CiCZW4ELpg8mQt7gP+zu/q/wFsZeJcK0610EMN2SJQovxyLrkW3OEHWfJsCo05+eGu
         xA+EJxKrLffQmvh0b8oDYcCzVP1mrurJZtqAyVOPsLJP/lscWfK+/kvM12G5CAgtdLoC
         Gk11aWdgDAvU8lgKDmEIeueKd9+wp7zhsOH3Sjr6zKdfYf3Nmj0Gx3D0QJi/8jt1unhu
         peXd5sZz60bg/H6B92wjyJXpGa909gxsXiXokPvoQL7akDVO9TF5g21O42XodYy15Bdv
         plRYW65fUnoagybw7tTwGkXa8dkxfDUimx5aZdJ9jMklwC3iHlwXhkxgchDmmk48HMmk
         5+dA==
X-Gm-Message-State: AC+VfDyIvzbjPIakK9e1JwV9SNSfIn4yfuf/+T6h0OZ7Li425O7gRzI1
        W9w2ynL5oiiWwU8q+PGUrHgyrJPgWOK6WiB2kJQ=
X-Google-Smtp-Source: ACHHUZ6uXSyxJ4FOjTKDquC48b5yEMr8QgGdTvbAudzeUvedz+Zx8im2mbMq9TubElXkm3dGwuP28Q==
X-Received: by 2002:ac2:5581:0:b0:4e8:487a:7c2e with SMTP id v1-20020ac25581000000b004e8487a7c2emr3016668lfg.14.1685367890469;
        Mon, 29 May 2023 06:44:50 -0700 (PDT)
Received: from freke.kvaser.se (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id s7-20020a19ad47000000b004ebae99cc1dsm580lfd.159.2023.05.29.06.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 06:44:50 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 06/14] can: kvaser_pciefd: Remove SPI flash parameter read functionality
Date:   Mon, 29 May 2023 15:42:40 +0200
Message-Id: <20230529134248.752036-7-extja@kvaser.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230529134248.752036-1-extja@kvaser.com>
References: <20230529134248.752036-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Remove SPI flash parameter read functionality, since it's only used for
reading the interface CAN controller count.
This information is already read from a register, making the information
redundant.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---

This additional sanity check doesn't justify the extra 150 lines of code.

 drivers/net/can/Kconfig         |   3 +-
 drivers/net/can/kvaser_pciefd.c | 220 +-------------------------------
 2 files changed, 5 insertions(+), 218 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 3ceccafd701b..b929a9da7920 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -153,8 +153,7 @@ config CAN_JANZ_ICAN3
 config CAN_KVASER_PCIEFD
 	depends on PCI
 	tristate "Kvaser PCIe FD cards"
-	select CRC32
-	  help
+	help
 	  This is a driver for the Kvaser PCI Express CAN FD family.
 
 	  Supported devices:
diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index abb556fb5cb6..e24a8e77aef1 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -3,10 +3,10 @@
  * Parts of this driver are based on the following:
  *  - Kvaser linux pciefd driver (version 5.25)
  *  - PEAK linux canfd driver
- *  - Altera Avalon EPCS flash controller driver
  */
 
 #include <linux/kernel.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/ethtool.h>
@@ -14,7 +14,6 @@
 #include <linux/can/dev.h>
 #include <linux/timer.h>
 #include <linux/netdevice.h>
-#include <linux/crc32.h>
 #include <linux/iopoll.h>
 
 MODULE_LICENSE("Dual BSD/GPL");
@@ -78,13 +77,6 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_SRB_STAT_REG (KVASER_PCIEFD_SRB_BASE + 0x210)
 #define KVASER_PCIEFD_SRB_RX_NR_PACKETS_REG (KVASER_PCIEFD_SRB_BASE + 0x214)
 #define KVASER_PCIEFD_SRB_CTRL_REG (KVASER_PCIEFD_SRB_BASE + 0x218)
-/* EPCS flash controller registers */
-#define KVASER_PCIEFD_SPI_BASE 0x1fc00
-#define KVASER_PCIEFD_SPI_RX_REG KVASER_PCIEFD_SPI_BASE
-#define KVASER_PCIEFD_SPI_TX_REG (KVASER_PCIEFD_SPI_BASE + 0x4)
-#define KVASER_PCIEFD_SPI_STATUS_REG (KVASER_PCIEFD_SPI_BASE + 0x8)
-#define KVASER_PCIEFD_SPI_CTRL_REG (KVASER_PCIEFD_SPI_BASE + 0xc)
-#define KVASER_PCIEFD_SPI_SSEL_REG (KVASER_PCIEFD_SPI_BASE + 0x14)
 
 #define KVASER_PCIEFD_IRQ_ALL_MSK 0x1f
 #define KVASER_PCIEFD_IRQ_SRB BIT(4)
@@ -119,23 +111,6 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 /* DMA Enable */
 #define KVASER_PCIEFD_SRB_CTRL_DMA_ENABLE BIT(0)
 
-/* EPCS flash controller definitions */
-#define KVASER_PCIEFD_CFG_IMG_SZ (64 * 1024)
-#define KVASER_PCIEFD_CFG_IMG_OFFSET (31 * 65536L)
-#define KVASER_PCIEFD_CFG_MAX_PARAMS 256
-#define KVASER_PCIEFD_CFG_MAGIC 0xcafef00d
-#define KVASER_PCIEFD_CFG_PARAM_MAX_SZ 24
-#define KVASER_PCIEFD_CFG_SYS_VER 1
-#define KVASER_PCIEFD_CFG_PARAM_NR_CHAN 130
-#define KVASER_PCIEFD_SPI_TMT BIT(5)
-#define KVASER_PCIEFD_SPI_TRDY BIT(6)
-#define KVASER_PCIEFD_SPI_RRDY BIT(7)
-#define KVASER_PCIEFD_FLASH_ID_EPCS16 0x14
-/* Commands for controlling the onboard flash */
-#define KVASER_PCIEFD_FLASH_RES_CMD 0xab
-#define KVASER_PCIEFD_FLASH_READ_CMD 0x3
-#define KVASER_PCIEFD_FLASH_STATUS_CMD 0x5
-
 /* Kvaser KCAN definitions */
 #define KVASER_PCIEFD_KCAN_CTRL_EFLUSH (4 << 29)
 #define KVASER_PCIEFD_KCAN_CTRL_EFRAME (5 << 29)
@@ -306,20 +281,6 @@ static const struct can_bittiming_const kvaser_pciefd_bittiming_const = {
 	.brp_inc = 1,
 };
 
-struct kvaser_pciefd_cfg_param {
-	__le32 magic;
-	__le32 nr;
-	__le32 len;
-	u8 data[KVASER_PCIEFD_CFG_PARAM_MAX_SZ];
-};
-
-struct kvaser_pciefd_cfg_img {
-	__le32 version;
-	__le32 magic;
-	__le32 crc;
-	struct kvaser_pciefd_cfg_param params[KVASER_PCIEFD_CFG_MAX_PARAMS];
-};
-
 static struct pci_device_id kvaser_pciefd_id_table[] = {
 	{ PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_4HS_ID), },
 	{ PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_2HS_ID), },
@@ -330,164 +291,6 @@ static struct pci_device_id kvaser_pciefd_id_table[] = {
 };
 MODULE_DEVICE_TABLE(pci, kvaser_pciefd_id_table);
 
-/* Onboard flash memory functions */
-static int kvaser_pciefd_spi_wait_loop(struct kvaser_pciefd *pcie, int msk)
-{
-	u32 res;
-
-	return readl_poll_timeout(pcie->reg_base + KVASER_PCIEFD_SPI_STATUS_REG,
-			res, res & msk, 0, 10);
-}
-
-static int kvaser_pciefd_spi_cmd(struct kvaser_pciefd *pcie, const u8 *tx,
-				 u32 tx_len, u8 *rx, u32 rx_len)
-{
-	int c;
-
-	iowrite32(BIT(0), pcie->reg_base + KVASER_PCIEFD_SPI_SSEL_REG);
-	iowrite32(BIT(10), pcie->reg_base + KVASER_PCIEFD_SPI_CTRL_REG);
-	ioread32(pcie->reg_base + KVASER_PCIEFD_SPI_RX_REG);
-
-	c = tx_len;
-	while (c--) {
-		if (kvaser_pciefd_spi_wait_loop(pcie, KVASER_PCIEFD_SPI_TRDY))
-			return -EIO;
-
-		iowrite32(*tx++, pcie->reg_base + KVASER_PCIEFD_SPI_TX_REG);
-
-		if (kvaser_pciefd_spi_wait_loop(pcie, KVASER_PCIEFD_SPI_RRDY))
-			return -EIO;
-
-		ioread32(pcie->reg_base + KVASER_PCIEFD_SPI_RX_REG);
-	}
-
-	c = rx_len;
-	while (c-- > 0) {
-		if (kvaser_pciefd_spi_wait_loop(pcie, KVASER_PCIEFD_SPI_TRDY))
-			return -EIO;
-
-		iowrite32(0, pcie->reg_base + KVASER_PCIEFD_SPI_TX_REG);
-
-		if (kvaser_pciefd_spi_wait_loop(pcie, KVASER_PCIEFD_SPI_RRDY))
-			return -EIO;
-
-		*rx++ = ioread32(pcie->reg_base + KVASER_PCIEFD_SPI_RX_REG);
-	}
-
-	if (kvaser_pciefd_spi_wait_loop(pcie, KVASER_PCIEFD_SPI_TMT))
-		return -EIO;
-
-	iowrite32(0, pcie->reg_base + KVASER_PCIEFD_SPI_CTRL_REG);
-
-	if (c != -1) {
-		dev_err(&pcie->pci->dev, "Flash SPI transfer failed\n");
-		return -EIO;
-	}
-
-	return 0;
-}
-
-static int kvaser_pciefd_cfg_read_and_verify(struct kvaser_pciefd *pcie,
-					     struct kvaser_pciefd_cfg_img *img)
-{
-	int offset = KVASER_PCIEFD_CFG_IMG_OFFSET;
-	int res, crc;
-	u8 *crc_buff;
-
-	u8 cmd[] = {
-		KVASER_PCIEFD_FLASH_READ_CMD,
-		(u8)((offset >> 16) & 0xff),
-		(u8)((offset >> 8) & 0xff),
-		(u8)(offset & 0xff)
-	};
-
-	res = kvaser_pciefd_spi_cmd(pcie, cmd, ARRAY_SIZE(cmd), (u8 *)img,
-				    KVASER_PCIEFD_CFG_IMG_SZ);
-	if (res)
-		return res;
-
-	crc_buff = (u8 *)img->params;
-
-	if (le32_to_cpu(img->version) != KVASER_PCIEFD_CFG_SYS_VER) {
-		dev_err(&pcie->pci->dev,
-			"Config flash corrupted, version number is wrong\n");
-		return -ENODEV;
-	}
-
-	if (le32_to_cpu(img->magic) != KVASER_PCIEFD_CFG_MAGIC) {
-		dev_err(&pcie->pci->dev,
-			"Config flash corrupted, magic number is wrong\n");
-		return -ENODEV;
-	}
-
-	crc = ~crc32_be(0xffffffff, crc_buff, sizeof(img->params));
-	if (le32_to_cpu(img->crc) != crc) {
-		dev_err(&pcie->pci->dev,
-			"Stored CRC does not match flash image contents\n");
-		return -EIO;
-	}
-
-	return 0;
-}
-
-static void kvaser_pciefd_cfg_read_params(struct kvaser_pciefd *pcie,
-					  struct kvaser_pciefd_cfg_img *img)
-{
-	struct kvaser_pciefd_cfg_param *param;
-
-	param = &img->params[KVASER_PCIEFD_CFG_PARAM_NR_CHAN];
-	memcpy(&pcie->nr_channels, param->data, le32_to_cpu(param->len));
-}
-
-static int kvaser_pciefd_read_cfg(struct kvaser_pciefd *pcie)
-{
-	int res;
-	struct kvaser_pciefd_cfg_img *img;
-
-	/* Read electronic signature */
-	u8 cmd[] = {KVASER_PCIEFD_FLASH_RES_CMD, 0, 0, 0};
-
-	res = kvaser_pciefd_spi_cmd(pcie, cmd, ARRAY_SIZE(cmd), cmd, 1);
-	if (res)
-		return -EIO;
-
-	img = kmalloc(KVASER_PCIEFD_CFG_IMG_SZ, GFP_KERNEL);
-	if (!img)
-		return -ENOMEM;
-
-	if (cmd[0] != KVASER_PCIEFD_FLASH_ID_EPCS16) {
-		dev_err(&pcie->pci->dev,
-			"Flash id is 0x%x instead of expected EPCS16 (0x%x)\n",
-			cmd[0], KVASER_PCIEFD_FLASH_ID_EPCS16);
-
-		res = -ENODEV;
-		goto image_free;
-	}
-
-	cmd[0] = KVASER_PCIEFD_FLASH_STATUS_CMD;
-	res = kvaser_pciefd_spi_cmd(pcie, cmd, 1, cmd, 1);
-	if (res) {
-		goto image_free;
-	} else if (cmd[0] & 1) {
-		res = -EIO;
-		/* No write is ever done, the WIP should never be set */
-		dev_err(&pcie->pci->dev, "Unexpected WIP bit set in flash\n");
-		goto image_free;
-	}
-
-	res = kvaser_pciefd_cfg_read_and_verify(pcie, img);
-	if (res) {
-		res = -EIO;
-		goto image_free;
-	}
-
-	kvaser_pciefd_cfg_read_params(pcie, img);
-
-image_free:
-	kfree(img);
-	return res;
-}
-
 static void kvaser_pciefd_request_status(struct kvaser_pciefd_can *can)
 {
 	u32 cmd;
@@ -1125,25 +928,10 @@ static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
 static int kvaser_pciefd_setup_board(struct kvaser_pciefd *pcie)
 {
 	u32 sysid, srb_status, build;
-	u8 sysid_nr_chan;
-	int ret;
-
-	ret = kvaser_pciefd_read_cfg(pcie);
-	if (ret)
-		return ret;
 
 	sysid = ioread32(pcie->reg_base + KVASER_PCIEFD_SYSID_VERSION_REG);
-	sysid_nr_chan = (sysid >> KVASER_PCIEFD_SYSID_NRCHAN_SHIFT) & 0xff;
-	if (pcie->nr_channels != sysid_nr_chan) {
-		dev_err(&pcie->pci->dev,
-			"Number of channels does not match: %u vs %u\n",
-			pcie->nr_channels,
-			sysid_nr_chan);
-		return -ENODEV;
-	}
-
-	if (pcie->nr_channels > KVASER_PCIEFD_MAX_CAN_CHANNELS)
-		pcie->nr_channels = KVASER_PCIEFD_MAX_CAN_CHANNELS;
+	pcie->nr_channels = min(KVASER_PCIEFD_MAX_CAN_CHANNELS,
+				((sysid >> KVASER_PCIEFD_SYSID_NRCHAN_SHIFT) & 0xff));
 
 	build = ioread32(pcie->reg_base + KVASER_PCIEFD_SYSID_BUILD_REG);
 	dev_dbg(&pcie->pci->dev, "Version %u.%u.%u\n",
@@ -1167,7 +955,7 @@ static int kvaser_pciefd_setup_board(struct kvaser_pciefd *pcie)
 
 	/* Turn off all loopback functionality */
 	iowrite32(0, pcie->reg_base + KVASER_PCIEFD_LOOP_REG);
-	return ret;
+	return 0;
 }
 
 static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
-- 
2.40.0

