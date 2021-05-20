Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5426A38B987
	for <lists+linux-can@lfdr.de>; Fri, 21 May 2021 00:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhETWg7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 20 May 2021 18:36:59 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:37872 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231593AbhETWg6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 20 May 2021 18:36:58 -0400
Received: from MTA-13-4.privateemail.com (mta-13.privateemail.com [198.54.118.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 4D7BB8154C
        for <linux-can@vger.kernel.org>; Thu, 20 May 2021 18:28:21 -0400 (EDT)
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
        by mta-13.privateemail.com (Postfix) with ESMTP id 48F0F80078;
        Thu, 20 May 2021 18:28:19 -0400 (EDT)
Received: from localhost (unknown [10.20.151.240])
        by mta-13.privateemail.com (Postfix) with ESMTPA id 1CEF08006C;
        Thu, 20 May 2021 18:28:19 -0400 (EDT)
Date:   Thu, 20 May 2021 15:28:18 -0700
From:   Matt Kline <mkline@anduril.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: [PATCH 1/2] can: m_can: Batch FIFO reads during CAN receive
Message-ID: <cb36acc2ce9c6bd8f517a8ccee9a651a243bf8be.1621547812.git.mkline@anduril.com>
References: <cover.1621547812.git.mkline@anduril.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1621547812.git.mkline@anduril.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On peripherals communicating over a relatively slow SPI line
(e.g. tcan4x5x), individual transfers have high fixed costs.
This causes the driver to spend most of its time waiting between
transfers and severely limits throughput.

Reduce these overheads by reading more than one word at a time.
Writing could get a similar treatment.

Signed-off-by: Matt Kline <mkline@anduril.com>
---
 drivers/net/can/m_can/m_can.c          | 27 +++++++++++++++-----------
 drivers/net/can/m_can/m_can.h          |  2 +-
 drivers/net/can/m_can/m_can_pci.c      |  6 ++++--
 drivers/net/can/m_can/m_can_platform.c |  6 ++++--
 drivers/net/can/m_can/tcan4x5x-core.c  |  8 +++-----
 5 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 3cf6de21d19c..0defdb33a7c0 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -344,13 +344,15 @@ static inline void m_can_write(struct m_can_classdev *cdev, enum m_can_reg reg,
 	cdev->ops->write_reg(cdev, reg, val);
 }
 
-static u32 m_can_fifo_read(struct m_can_classdev *cdev,
-			   u32 fgi, unsigned int offset)
+static void m_can_fifo_read(struct m_can_classdev *cdev,
+			    u32 fgi, unsigned int offset, void *val, size_t val_count)
 {
+	u32 result;
 	u32 addr_offset = cdev->mcfg[MRAM_RXF0].off + fgi * RXF0_ELEMENT_SIZE +
 		offset;
 
-	return cdev->ops->read_fifo(cdev, addr_offset);
+	result = cdev->ops->read_fifo(cdev, addr_offset, val, val_count);
+	WARN_ON(result != 0);
 }
 
 static void m_can_fifo_write(struct m_can_classdev *cdev,
@@ -370,10 +372,13 @@ static inline void m_can_fifo_write_no_off(struct m_can_classdev *cdev,
 
 static u32 m_can_txe_fifo_read(struct m_can_classdev *cdev, u32 fgi, u32 offset)
 {
+	u32 val, result;
 	u32 addr_offset = cdev->mcfg[MRAM_TXE].off + fgi * TXE_ELEMENT_SIZE +
 		offset;
 
-	return cdev->ops->read_fifo(cdev, addr_offset);
+	result = cdev->ops->read_fifo(cdev, addr_offset, &val, 1);
+	WARN_ON(result != 0);
+	return val;
 }
 
 static inline bool m_can_tx_fifo_full(struct m_can_classdev *cdev)
@@ -485,13 +490,17 @@ static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	struct canfd_frame *cf;
 	struct sk_buff *skb;
+	u32 id_and_dlc[2];
 	u32 id, fgi, dlc;
 	u32 timestamp = 0;
-	int i;
 
 	/* calculate the fifo get index for where to read data */
 	fgi = (rxfs & RXFS_FGI_MASK) >> RXFS_FGI_SHIFT;
-	dlc = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_DLC);
+
+	m_can_fifo_read(cdev, fgi, M_CAN_FIFO_ID, id_and_dlc, ARRAY_SIZE(id_and_dlc));
+	id = id_and_dlc[0];
+	dlc = id_and_dlc[1];
+
 	if (dlc & RX_BUF_FDF)
 		skb = alloc_canfd_skb(dev, &cf);
 	else
@@ -506,7 +515,6 @@ static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
 	else
 		cf->len = can_cc_dlc2len((dlc >> 16) & 0x0F);
 
-	id = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_ID);
 	if (id & RX_BUF_XTD)
 		cf->can_id = (id & CAN_EFF_MASK) | CAN_EFF_FLAG;
 	else
@@ -523,10 +531,7 @@ static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
 		if (dlc & RX_BUF_BRS)
 			cf->flags |= CANFD_BRS;
 
-		for (i = 0; i < cf->len; i += 4)
-			*(u32 *)(cf->data + i) =
-				m_can_fifo_read(cdev, fgi,
-						M_CAN_FIFO_DATA(i / 4));
+		m_can_fifo_read(cdev, fgi, M_CAN_FIFO_DATA(0), cf->data, DIV_ROUND_UP(cf->len, 4));
 	}
 
 	/* acknowledge rx fifo 0 */
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index ace071c3e58c..2571ec1efec4 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -64,7 +64,7 @@ struct m_can_ops {
 	int (*clear_interrupts)(struct m_can_classdev *cdev);
 	u32 (*read_reg)(struct m_can_classdev *cdev, int reg);
 	int (*write_reg)(struct m_can_classdev *cdev, int reg, int val);
-	u32 (*read_fifo)(struct m_can_classdev *cdev, int addr_offset);
+	int (*read_fifo)(struct m_can_classdev *cdev, int addr_offset, void *val, size_t val_count);
 	int (*write_fifo)(struct m_can_classdev *cdev, int addr_offset,
 			  int val);
 	int (*init)(struct m_can_classdev *cdev);
diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
index 128808605c3f..11614a635796 100644
--- a/drivers/net/can/m_can/m_can_pci.c
+++ b/drivers/net/can/m_can/m_can_pci.c
@@ -39,11 +39,13 @@ static u32 iomap_read_reg(struct m_can_classdev *cdev, int reg)
 	return readl(priv->base + reg);
 }
 
-static u32 iomap_read_fifo(struct m_can_classdev *cdev, int offset)
+static int iomap_read_fifo(struct m_can_classdev *cdev, int offset, void *val, size_t val_count)
 {
 	struct m_can_pci_priv *priv = cdev_to_priv(cdev);
 
-	return readl(priv->base + offset);
+	ioread32_rep(priv->base + offset, val, val_count);
+
+	return 0;
 }
 
 static int iomap_write_reg(struct m_can_classdev *cdev, int reg, int val)
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 599de0e08cd7..94c82dd39076 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -28,11 +28,13 @@ static u32 iomap_read_reg(struct m_can_classdev *cdev, int reg)
 	return readl(priv->base + reg);
 }
 
-static u32 iomap_read_fifo(struct m_can_classdev *cdev, int offset)
+static int iomap_read_fifo(struct m_can_classdev *cdev, int offset, void *val, size_t val_count)
 {
 	struct m_can_plat_priv *priv = cdev_to_priv(cdev);
 
-	return readl(priv->mram_base + offset);
+	ioread32_rep(priv->mram_base + offset, val, val_count);
+
+	return 0;
 }
 
 static int iomap_write_reg(struct m_can_classdev *cdev, int reg, int val)
diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 4147cecfbbd6..4f77b1dbd492 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -154,14 +154,12 @@ static u32 tcan4x5x_read_reg(struct m_can_classdev *cdev, int reg)
 	return val;
 }
 
-static u32 tcan4x5x_read_fifo(struct m_can_classdev *cdev, int addr_offset)
+static int tcan4x5x_read_fifo(struct m_can_classdev *cdev, int addr_offset,
+			      void *val, size_t val_count)
 {
 	struct tcan4x5x_priv *priv = cdev_to_priv(cdev);
-	u32 val;
 
-	regmap_read(priv->regmap, TCAN4X5X_MRAM_START + addr_offset, &val);
-
-	return val;
+	return regmap_bulk_read(priv->regmap, TCAN4X5X_MRAM_START + addr_offset, val, val_count);
 }
 
 static int tcan4x5x_write_reg(struct m_can_classdev *cdev, int reg, int val)
-- 
2.31.1

