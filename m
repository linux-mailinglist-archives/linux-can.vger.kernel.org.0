Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46903D6BB6
	for <lists+linux-can@lfdr.de>; Tue, 27 Jul 2021 04:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbhG0BYt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Jul 2021 21:24:49 -0400
Received: from h2.fbrelay.privateemail.com ([131.153.2.43]:37924 "EHLO
        h2.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229575AbhG0BYs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Jul 2021 21:24:48 -0400
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jul 2021 21:24:48 EDT
Received: from MTA-08-3.privateemail.com (mta-08-1.privateemail.com [68.65.122.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id 29B688083D
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 21:59:51 -0400 (EDT)
Received: from mta-08.privateemail.com (localhost [127.0.0.1])
        by mta-08.privateemail.com (Postfix) with ESMTP id 5941518000BE;
        Mon, 26 Jul 2021 21:59:50 -0400 (EDT)
Received: from localhost.localdomain (unknown [10.20.151.244])
        by mta-08.privateemail.com (Postfix) with ESMTPA id ED2F31800181;
        Mon, 26 Jul 2021 21:59:49 -0400 (EDT)
From:   Matt Kline <matt@bitbashing.io>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Matt Kline <matt@bitbashing.io>, linux-can@vger.kernel.org
Subject: [PATCH v2 1/2] can: m_can: Batch FIFO reads during CAN receive
Date:   Mon, 26 Jul 2021 18:58:54 -0700
Message-Id: <20210727015855.17482-2-matt@bitbashing.io>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210727015855.17482-1-matt@bitbashing.io>
References: <20210727015855.17482-1-matt@bitbashing.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On peripherals communicating over a relatively slow SPI line
(e.g. tcan4x5x), individual transfers have high fixed costs.
This causes the driver to spend most of its time waiting between
transfers and severely limits throughput.

Reduce these overheads by reading more than one word at a time.
Writing could get a similar treatment in follow-on commits.

Signed-off-by: Matt Kline <matt@bitbashing.io>
---
 drivers/net/can/m_can/m_can.c          | 27 +++++++++++++++-----------
 drivers/net/can/m_can/m_can.h          |  2 +-
 drivers/net/can/m_can/m_can_pci.c      |  6 ++++--
 drivers/net/can/m_can/m_can_platform.c |  6 ++++--
 drivers/net/can/m_can/tcan4x5x-core.c  |  8 +++-----
 5 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index bba2a449ac70..233d5da907ec 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -319,13 +319,15 @@ static inline void m_can_write(struct m_can_classdev *cdev, enum m_can_reg reg,
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
@@ -345,10 +347,13 @@ static inline void m_can_fifo_write_no_off(struct m_can_classdev *cdev,
 
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
@@ -460,13 +465,17 @@ static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	struct canfd_frame *cf;
 	struct sk_buff *skb;
+	u32 id_and_dlc[2];
 	u32 id, fgi, dlc;
 	u32 timestamp = 0;
-	int i;
 
 	/* calculate the fifo get index for where to read data */
 	fgi = FIELD_GET(RXFS_FGI_MASK, rxfs);
-	dlc = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_DLC);
+
+	m_can_fifo_read(cdev, fgi, M_CAN_FIFO_ID, id_and_dlc, ARRAY_SIZE(id_and_dlc));
+	id = id_and_dlc[0];
+	dlc = id_and_dlc[1];
+
 	if (dlc & RX_BUF_FDF)
 		skb = alloc_canfd_skb(dev, &cf);
 	else
@@ -481,7 +490,6 @@ static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
 	else
 		cf->len = can_cc_dlc2len((dlc >> 16) & 0x0F);
 
-	id = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_ID);
 	if (id & RX_BUF_XTD)
 		cf->can_id = (id & CAN_EFF_MASK) | CAN_EFF_FLAG;
 	else
@@ -498,10 +506,7 @@ static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
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
2.32.0

