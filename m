Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395B53D6BA9
	for <lists+linux-can@lfdr.de>; Tue, 27 Jul 2021 03:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhG0BTZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Jul 2021 21:19:25 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:49500 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233249AbhG0BTZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Jul 2021 21:19:25 -0400
Received: from MTA-08-3.privateemail.com (mta-08-1.privateemail.com [68.65.122.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 927C680090
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 21:59:52 -0400 (EDT)
Received: from mta-08.privateemail.com (localhost [127.0.0.1])
        by mta-08.privateemail.com (Postfix) with ESMTP id BAD2D1800181;
        Mon, 26 Jul 2021 21:59:51 -0400 (EDT)
Received: from localhost.localdomain (unknown [10.20.151.244])
        by mta-08.privateemail.com (Postfix) with ESMTPA id 5D8DC18000A2;
        Mon, 26 Jul 2021 21:59:51 -0400 (EDT)
From:   Matt Kline <matt@bitbashing.io>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Matt Kline <matt@bitbashing.io>, linux-can@vger.kernel.org
Subject: [PATCH v2 2/2] can: m_can: Batch FIFO writes during CAN transmit
Date:   Mon, 26 Jul 2021 18:58:55 -0700
Message-Id: <20210727015855.17482-3-matt@bitbashing.io>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210727015855.17482-1-matt@bitbashing.io>
References: <20210727015855.17482-1-matt@bitbashing.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Give FIFO writes the same treatment as reads to avoid fixed costs of
individual transfers on a slow bus (e.g., tcan4x5x).

Signed-off-by: Matt Kline <matt@bitbashing.io>
---
 drivers/net/can/m_can/m_can.c          | 55 ++++++++++++--------------
 drivers/net/can/m_can/m_can.h          |  2 +-
 drivers/net/can/m_can/m_can_pci.c      |  5 ++-
 drivers/net/can/m_can/m_can_platform.c |  5 ++-
 drivers/net/can/m_can/tcan4x5x-core.c  |  4 +-
 5 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 233d5da907ec..7aae2d19ad65 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -278,7 +278,7 @@ enum m_can_reg {
 /* Message RAM Elements */
 #define M_CAN_FIFO_ID		0x0
 #define M_CAN_FIFO_DLC		0x4
-#define M_CAN_FIFO_DATA(n)	(0x8 + ((n) << 2))
+#define M_CAN_FIFO_DATA		0x8
 
 /* Rx Buffer Element */
 /* R0 */
@@ -331,18 +331,20 @@ static void m_can_fifo_read(struct m_can_classdev *cdev,
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
@@ -506,7 +508,7 @@ static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
 		if (dlc & RX_BUF_BRS)
 			cf->flags |= CANFD_BRS;
 
-		m_can_fifo_read(cdev, fgi, M_CAN_FIFO_DATA(0), cf->data, DIV_ROUND_UP(cf->len, 4));
+		m_can_fifo_read(cdev, fgi, M_CAN_FIFO_DATA, cf->data, DIV_ROUND_UP(cf->len, 4));
 	}
 
 	/* acknowledge rx fifo 0 */
@@ -1546,8 +1548,8 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 	struct net_device *dev = cdev->net;
 	struct sk_buff *skb = cdev->tx_skb;
 	u32 id, cccr, fdflags;
-	int i;
 	int putidx;
+	u32 id_and_dlc[2];
 
 	cdev->tx_skb = NULL;
 
@@ -1563,18 +1565,16 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
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
 
@@ -1618,8 +1618,11 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 		/* get put index for frame */
 		putidx = FIELD_GET(TXFQS_TFQPI_MASK,
 				   m_can_read(cdev, M_CAN_TXFQS));
-		/* Write ID Field to FIFO Element */
-		m_can_fifo_write(cdev, putidx, M_CAN_FIFO_ID, id);
+
+		/* Construct the DLC Field, with CAN-FD configuration.
+		 * Use the put index of fifo as message the marker,
+		 * used in the TX interrupt for sending the correct echo frame.
+		 */
 
 		/* get CAN FD configuration of frame */
 		fdflags = 0;
@@ -1628,21 +1631,13 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 			if (cf->flags & CANFD_BRS)
 				fdflags |= TX_BUF_BRS;
 		}
+		id_and_dlc[1] = FIELD_PREP(TX_BUF_MM_MASK, putidx) |
+				 FIELD_PREP(TX_BUF_DLC_MASK, can_fd_len2dlc(cf->len)) |
+				 fdflags | TX_BUF_EFC;
 
-		/* Construct DLC Field. Also contains CAN-FD configuration
-		 * use put index of fifo as message marker
-		 * it is used in TX interrupt for
-		 * sending the correct echo frame
-		 */
-		m_can_fifo_write(cdev, putidx, M_CAN_FIFO_DLC,
-				 FIELD_PREP(TX_BUF_MM_MASK, putidx) |
-				 FIELD_PREP(TX_BUF_DLC_MASK,
-					    can_fd_len2dlc(cf->len)) |
-				 fdflags | TX_BUF_EFC);
-
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
2.32.0

