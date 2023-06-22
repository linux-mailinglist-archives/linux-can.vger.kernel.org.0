Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F747399A5
	for <lists+linux-can@lfdr.de>; Thu, 22 Jun 2023 10:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjFVI2A (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jun 2023 04:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjFVI1x (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Jun 2023 04:27:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392662122
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 01:27:29 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qCFez-00031M-BC
        for linux-can@vger.kernel.org; Thu, 22 Jun 2023 10:27:21 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 4D0641DF420
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 08:27:06 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 6EC341DF3AE;
        Thu, 22 Jun 2023 08:27:04 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 053cf0d5;
        Thu, 22 Jun 2023 08:27:01 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Jimmy Assarsson <extja@kvaser.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 25/33] can: kvaser_pciefd: Remove SPI flash parameter read functionality
Date:   Thu, 22 Jun 2023 10:26:50 +0200
Message-Id: <20230622082658.571150-26-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622082658.571150-1-mkl@pengutronix.de>
References: <20230622082658.571150-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Remove SPI flash parameter read functionality, since it's only used for
reading the interface CAN controller count.
This information is already read from a register, making the information
redundant.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20230529134248.752036-7-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/Kconfig         |   3 +-
 drivers/net/can/kvaser_pciefd.c | 220 +-------------------------------
 2 files changed, 5 insertions(+), 218 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index b190007c01be..a5c5036dfb94 100644
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
2.40.1


