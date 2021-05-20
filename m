Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B49A38B986
	for <lists+linux-can@lfdr.de>; Fri, 21 May 2021 00:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhETWg6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 20 May 2021 18:36:58 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:35394 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229951AbhETWg6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 20 May 2021 18:36:58 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 May 2021 18:36:58 EDT
Received: from MTA-13-4.privateemail.com (mta-13.privateemail.com [198.54.118.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 883918154E
        for <linux-can@vger.kernel.org>; Thu, 20 May 2021 18:28:58 -0400 (EDT)
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
        by mta-13.privateemail.com (Postfix) with ESMTP id 851C380075;
        Thu, 20 May 2021 18:28:57 -0400 (EDT)
Received: from localhost (unknown [10.20.151.204])
        by mta-13.privateemail.com (Postfix) with ESMTPA id 5B0318006C;
        Thu, 20 May 2021 18:28:57 -0400 (EDT)
Date:   Thu, 20 May 2021 15:28:56 -0700
From:   Matt Kline <mkline@anduril.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: [PATCH 2/2] can: m_can: Batch FIFO writes during CAN send
Message-ID: <697b8b12e2a0f4b08477827f86a1c15b1c2563eb.1621547812.git.mkline@anduril.com>
References: <cover.1621547812.git.mkline@anduril.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1621547812.git.mkline@anduril.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Reduce send overhead by grouping FIFO writes into fewer transfers.
Individual transfers on a slow bus (e.g., tcan4x5x) have high fixed
costs, so fewer transfers means higher throughput.

Signed-off-by: Matt Kline <mkline@anduril.com>
---
 drivers/net/can/m_can/m_can.c          | 52 ++++++++++++--------------
 drivers/net/can/m_can/m_can.h          |  2 +-
 drivers/net/can/m_can/m_can_pci.c      |  5 ++-
 drivers/net/can/m_can/m_can_platform.c |  5 ++-
 drivers/net/can/m_can/tcan4x5x-core.c  |  4 +-
 5 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 0defdb33a7c0..7ed52e3fd006 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -302,7 +302,7 @@ enum m_can_reg {
 /* Message RAM Elements */
 #define M_CAN_FIFO_ID		0x0
 #define M_CAN_FIFO_DLC		0x4
-#define M_CAN_FIFO_DATA(n)	(0x8 + ((n) << 2))
+#define M_CAN_FIFO_DATA		0x8
 
 /* Rx Buffer Element */
 /* R0 */
@@ -356,18 +356,20 @@ static void m_can_fifo_read(struct m_can_classdev *cdev,
 }
 
 static void m_can_fifo_write(struct m_can_classdev *cdev,
-			     u32 fpi, unsigned int offset, u32 val)
+			     u32 fpi, unsigned int offset, const void *val, size_t val_count)
 {
 	u32 addr_offset = cdev->mcfg[MRAM_TXB].off + fpi * TXB_ELEMENT_SIZE +
 		offset;
+	int result;
 
-	cdev->ops->write_fifo(cdev, addr_offset, val);
+	result = cdev->ops->write_fifo(cdev, addr_offset, val, val_count);
+	WARN_ON(result != 0);
 }
 
 static inline void m_can_fifo_write_no_off(struct m_can_classdev *cdev,
 					   u32 fpi, u32 val)
 {
-	cdev->ops->write_fifo(cdev, fpi, val);
+	cdev->ops->write_fifo(cdev, fpi, &val, 1);
 }
 
 static u32 m_can_txe_fifo_read(struct m_can_classdev *cdev, u32 fgi, u32 offset)
@@ -531,7 +533,7 @@ static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
 		if (dlc & RX_BUF_BRS)
 			cf->flags |= CANFD_BRS;
 
-		m_can_fifo_read(cdev, fgi, M_CAN_FIFO_DATA(0), cf->data, DIV_ROUND_UP(cf->len, 4));
+		m_can_fifo_read(cdev, fgi, M_CAN_FIFO_DATA, cf->data, DIV_ROUND_UP(cf->len, 4));
 	}
 
 	/* acknowledge rx fifo 0 */
@@ -1564,8 +1566,8 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 	struct net_device *dev = cdev->net;
 	struct sk_buff *skb = cdev->tx_skb;
 	u32 id, cccr, fdflags;
-	int i;
 	int putidx;
+	u32 id_and_dlc[2];
 
 	cdev->tx_skb = NULL;
 
@@ -1581,18 +1583,16 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 	if (cf->can_id & CAN_RTR_FLAG)
 		id |= TX_BUF_RTR;
 
+	id_and_dlc[0] = id;
+
 	if (cdev->version == 30) {
 		netif_stop_queue(dev);
 
-		/* message ram configuration */
-		m_can_fifo_write(cdev, 0, M_CAN_FIFO_ID, id);
-		m_can_fifo_write(cdev, 0, M_CAN_FIFO_DLC,
-				 can_fd_len2dlc(cf->len) << 16);
+		id_and_dlc[1] = can_fd_len2dlc(cf->len) << 16;
 
-		for (i = 0; i < cf->len; i += 4)
-			m_can_fifo_write(cdev, 0,
-					 M_CAN_FIFO_DATA(i / 4),
-					 *(u32 *)(cf->data + i));
+		/* Write the frame ID, DLC, and payload to the FIFO element. */
+		m_can_fifo_write(cdev, 0, M_CAN_FIFO_ID, id_and_dlc, ARRAY_SIZE(id_and_dlc));
+		m_can_fifo_write(cdev, 0, M_CAN_FIFO_DATA, cf->data, DIV_ROUND_UP(cf->len, 4));
 
 		can_put_echo_skb(skb, dev, 0, 0);
 
@@ -1636,8 +1636,11 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 		/* get put index for frame */
 		putidx = ((m_can_read(cdev, M_CAN_TXFQS) & TXFQS_TFQPI_MASK)
 			  >> TXFQS_TFQPI_SHIFT);
-		/* Write ID Field to FIFO Element */
-		m_can_fifo_write(cdev, putidx, M_CAN_FIFO_ID, id);
+
+		/* Construct the DLC Field, with CAN-FD configuration.
+		 * Use the put index of fifo as message the marker,
+		 * used in the TX interrupt for sending the correct echo frame.
+		 */
 
 		/* get CAN FD configuration of frame */
 		fdflags = 0;
@@ -1646,21 +1649,14 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 			if (cf->flags & CANFD_BRS)
 				fdflags |= TX_BUF_BRS;
 		}
-
-		/* Construct DLC Field. Also contains CAN-FD configuration
-		 * use put index of fifo as message marker
-		 * it is used in TX interrupt for
-		 * sending the correct echo frame
-		 */
-		m_can_fifo_write(cdev, putidx, M_CAN_FIFO_DLC,
-				 ((putidx << TX_BUF_MM_SHIFT) &
+		id_and_dlc[1] = ((putidx << TX_BUF_MM_SHIFT) &
 				  TX_BUF_MM_MASK) |
 				 (can_fd_len2dlc(cf->len) << 16) |
-				 fdflags | TX_BUF_EFC);
+				 fdflags | TX_BUF_EFC;
 
-		for (i = 0; i < cf->len; i += 4)
-			m_can_fifo_write(cdev, putidx, M_CAN_FIFO_DATA(i / 4),
-					 *(u32 *)(cf->data + i));
+		/* Write the frame ID, DLC, and payload to the FIFO element. */
+		m_can_fifo_write(cdev, putidx, M_CAN_FIFO_ID, id_and_dlc, ARRAY_SIZE(id_and_dlc));
+		m_can_fifo_write(cdev, 0, M_CAN_FIFO_DATA, cf->data, DIV_ROUND_UP(cf->len, 4));
 
 		/* Push loopback echo.
 		 * Will be looped back on TX interrupt based on message marker
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 2571ec1efec4..edf2477b064f 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -66,7 +66,7 @@ struct m_can_ops {
 	int (*write_reg)(struct m_can_classdev *cdev, int reg, int val);
 	int (*read_fifo)(struct m_can_classdev *cdev, int addr_offset, void *val, size_t val_count);
 	int (*write_fifo)(struct m_can_classdev *cdev, int addr_offset,
-			  int val);
+			  const void *val, size_t val_count);
 	int (*init)(struct m_can_classdev *cdev);
 };
 
diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
index 11614a635796..89cc3d41e952 100644
--- a/drivers/net/can/m_can/m_can_pci.c
+++ b/drivers/net/can/m_can/m_can_pci.c
@@ -57,11 +57,12 @@ static int iomap_write_reg(struct m_can_classdev *cdev, int reg, int val)
 	return 0;
 }
 
-static int iomap_write_fifo(struct m_can_classdev *cdev, int offset, int val)
+static int iomap_write_fifo(struct m_can_classdev *cdev, int offset,
+			    const void *val, size_t val_count)
 {
 	struct m_can_pci_priv *priv = cdev_to_priv(cdev);
 
-	writel(val, priv->base + offset);
+	iowrite32_rep(priv->base + offset, val, val_count);
 
 	return 0;
 }
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 94c82dd39076..40e5351c7f74 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -46,11 +46,12 @@ static int iomap_write_reg(struct m_can_classdev *cdev, int reg, int val)
 	return 0;
 }
 
-static int iomap_write_fifo(struct m_can_classdev *cdev, int offset, int val)
+static int iomap_write_fifo(struct m_can_classdev *cdev, int offset,
+			    const void *val, size_t val_count)
 {
 	struct m_can_plat_priv *priv = cdev_to_priv(cdev);
 
-	writel(val, priv->mram_base + offset);
+	iowrite32_rep(priv->base + offset, val, val_count);
 
 	return 0;
 }
diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 4f77b1dbd492..89d2009c895b 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -170,11 +170,11 @@ static int tcan4x5x_write_reg(struct m_can_classdev *cdev, int reg, int val)
 }
 
 static int tcan4x5x_write_fifo(struct m_can_classdev *cdev,
-			       int addr_offset, int val)
+			       int addr_offset, const void *val, size_t val_count)
 {
 	struct tcan4x5x_priv *priv = cdev_to_priv(cdev);
 
-	return regmap_write(priv->regmap, TCAN4X5X_MRAM_START + addr_offset, val);
+	return regmap_bulk_write(priv->regmap, TCAN4X5X_MRAM_START + addr_offset, val, val_count);
 }
 
 static int tcan4x5x_power_enable(struct regulator *reg, int enable)
-- 
2.31.1

