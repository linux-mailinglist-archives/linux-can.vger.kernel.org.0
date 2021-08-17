Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61213EE60B
	for <lists+linux-can@lfdr.de>; Tue, 17 Aug 2021 07:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhHQFJc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 Aug 2021 01:09:32 -0400
Received: from h2.fbrelay.privateemail.com ([131.153.2.43]:33995 "EHLO
        h2.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233861AbhHQFJc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 17 Aug 2021 01:09:32 -0400
Received: from MTA-13-3.privateemail.com (mta-13-1.privateemail.com [198.54.122.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id EB38F80070
        for <linux-can@vger.kernel.org>; Tue, 17 Aug 2021 01:08:58 -0400 (EDT)
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
        by mta-13.privateemail.com (Postfix) with ESMTP id 1929F18000AD;
        Tue, 17 Aug 2021 01:08:58 -0400 (EDT)
Received: from localhost.localdomain (unknown [10.20.151.223])
        by mta-13.privateemail.com (Postfix) with ESMTPA id A1BFA18000BD;
        Tue, 17 Aug 2021 01:08:57 -0400 (EDT)
From:   Matt Kline <matt@bitbashing.io>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Matt Kline <matt@bitbashing.io>, linux-can@vger.kernel.org
Subject: [PATCH v3 1/3] can: m_can: Disable IRQs on FIFO bus errors
Date:   Mon, 16 Aug 2021 22:08:51 -0700
Message-Id: <20210817050853.14875-2-matt@bitbashing.io>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817050853.14875-1-matt@bitbashing.io>
References: <20210817050853.14875-1-matt@bitbashing.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

If FIFO reads or writes fail due to the underlying regmap (e.g., SPI)
I/O, propagate that up to the m_can driver, log an error, and disable
interrupts, similar to the mcp251xfd driver.

While reworking the FIFO functions to add this error handling,
add support for bulk reads and writes of multiple registers.

Signed-off-by: Matt Kline <matt@bitbashing.io>
---
 drivers/net/can/m_can/m_can.c          | 177 +++++++++++++++++--------
 drivers/net/can/m_can/m_can.h          |   6 +-
 drivers/net/can/m_can/m_can_pci.c      |  11 +-
 drivers/net/can/m_can/m_can_platform.c |  15 ++-
 drivers/net/can/m_can/tcan4x5x-core.c  |  16 +--
 5 files changed, 152 insertions(+), 73 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 43bca315a66c..83eb5cd51de5 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -319,36 +319,36 @@ static inline void m_can_write(struct m_can_classdev *cdev, enum m_can_reg reg,
 	cdev->ops->write_reg(cdev, reg, val);
 }
 
-static u32 m_can_fifo_read(struct m_can_classdev *cdev,
-			   u32 fgi, unsigned int offset)
+static int m_can_fifo_read(struct m_can_classdev *cdev,
+			   u32 fgi, unsigned int offset, void *val, size_t val_count)
 {
 	u32 addr_offset = cdev->mcfg[MRAM_RXF0].off + fgi * RXF0_ELEMENT_SIZE +
 		offset;
 
-	return cdev->ops->read_fifo(cdev, addr_offset);
+	return cdev->ops->read_fifo(cdev, addr_offset, val, val_count);
 }
 
-static void m_can_fifo_write(struct m_can_classdev *cdev,
-			     u32 fpi, unsigned int offset, u32 val)
+static int m_can_fifo_write(struct m_can_classdev *cdev,
+			    u32 fpi, unsigned int offset, const void *val, size_t val_count)
 {
 	u32 addr_offset = cdev->mcfg[MRAM_TXB].off + fpi * TXB_ELEMENT_SIZE +
 		offset;
 
-	cdev->ops->write_fifo(cdev, addr_offset, val);
+	return cdev->ops->write_fifo(cdev, addr_offset, val, val_count);
 }
 
-static inline void m_can_fifo_write_no_off(struct m_can_classdev *cdev,
-					   u32 fpi, u32 val)
+static inline int m_can_fifo_write_no_off(struct m_can_classdev *cdev,
+					  u32 fpi, u32 val)
 {
-	cdev->ops->write_fifo(cdev, fpi, val);
+	return cdev->ops->write_fifo(cdev, fpi, &val, 1);
 }
 
-static u32 m_can_txe_fifo_read(struct m_can_classdev *cdev, u32 fgi, u32 offset)
+static int m_can_txe_fifo_read(struct m_can_classdev *cdev, u32 fgi, u32 offset, u32 *val)
 {
 	u32 addr_offset = cdev->mcfg[MRAM_TXE].off + fgi * TXE_ELEMENT_SIZE +
 		offset;
 
-	return cdev->ops->read_fifo(cdev, addr_offset);
+	return cdev->ops->read_fifo(cdev, addr_offset, val, 1);
 }
 
 static inline bool m_can_tx_fifo_full(struct m_can_classdev *cdev)
@@ -454,7 +454,7 @@ static void m_can_receive_skb(struct m_can_classdev *cdev,
 	}
 }
 
-static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
+static int m_can_read_fifo(struct net_device *dev, u32 rxfs)
 {
 	struct net_device_stats *stats = &dev->stats;
 	struct m_can_classdev *cdev = netdev_priv(dev);
@@ -462,18 +462,21 @@ static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
 	struct sk_buff *skb;
 	u32 id, fgi, dlc;
 	u32 timestamp = 0;
-	int i;
+	int i, err;
 
 	/* calculate the fifo get index for where to read data */
 	fgi = FIELD_GET(RXFS_FGI_MASK, rxfs);
-	dlc = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_DLC);
+	err = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_DLC, &dlc, 1);
+	if (err)
+		goto out_fail;
+
 	if (dlc & RX_BUF_FDF)
 		skb = alloc_canfd_skb(dev, &cf);
 	else
 		skb = alloc_can_skb(dev, (struct can_frame **)&cf);
 	if (!skb) {
 		stats->rx_dropped++;
-		return;
+		return 0;
 	}
 
 	if (dlc & RX_BUF_FDF)
@@ -481,7 +484,10 @@ static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
 	else
 		cf->len = can_cc_dlc2len((dlc >> 16) & 0x0F);
 
-	id = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_ID);
+	err = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_ID, &id, 1);
+	if (err)
+		goto out_fail;
+
 	if (id & RX_BUF_XTD)
 		cf->can_id = (id & CAN_EFF_MASK) | CAN_EFF_FLAG;
 	else
@@ -498,10 +504,11 @@ static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
 		if (dlc & RX_BUF_BRS)
 			cf->flags |= CANFD_BRS;
 
-		for (i = 0; i < cf->len; i += 4)
-			*(u32 *)(cf->data + i) =
-				m_can_fifo_read(cdev, fgi,
-						M_CAN_FIFO_DATA(i / 4));
+		for (i = 0; i < cf->len; i += 4) {
+			err = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_DATA(i / 4), cf->data + i, 1);
+			if (err)
+				goto out_fail;
+		}
 	}
 
 	/* acknowledge rx fifo 0 */
@@ -513,6 +520,12 @@ static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
 	timestamp = FIELD_GET(RX_BUF_RXTS_MASK, dlc);
 
 	m_can_receive_skb(cdev, skb, timestamp);
+
+	return 0;
+
+out_fail:
+	netdev_err(dev, "FIFO read returned %d\n", err);
+	return err;
 }
 
 static int m_can_do_rx_poll(struct net_device *dev, int quota)
@@ -520,6 +533,7 @@ static int m_can_do_rx_poll(struct net_device *dev, int quota)
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	u32 pkts = 0;
 	u32 rxfs;
+	int err;
 
 	rxfs = m_can_read(cdev, M_CAN_RXF0S);
 	if (!(rxfs & RXFS_FFL_MASK)) {
@@ -528,7 +542,14 @@ static int m_can_do_rx_poll(struct net_device *dev, int quota)
 	}
 
 	while ((rxfs & RXFS_FFL_MASK) && (quota > 0)) {
-		m_can_read_fifo(dev, rxfs);
+		err = m_can_read_fifo(dev, rxfs);
+		if (err) {
+			/* Trust that an error back from a FIFO read is negative
+			 * so that we can differentiate it from work done (pkts).
+			 */
+			WARN_ON(err >= 0);
+			return err;
+		}
 
 		quota--;
 		pkts++;
@@ -874,6 +895,7 @@ static int m_can_handle_bus_errors(struct net_device *dev, u32 irqstatus,
 static int m_can_rx_handler(struct net_device *dev, int quota)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
+	int rx_work_or_err;
 	int work_done = 0;
 	u32 irqstatus, psr;
 
@@ -910,8 +932,13 @@ static int m_can_rx_handler(struct net_device *dev, int quota)
 	if (irqstatus & IR_ERR_BUS_30X)
 		work_done += m_can_handle_bus_errors(dev, irqstatus, psr);
 
-	if (irqstatus & IR_RF0N)
-		work_done += m_can_do_rx_poll(dev, (quota - work_done));
+	if (irqstatus & IR_RF0N) {
+		rx_work_or_err = m_can_do_rx_poll(dev, (quota - work_done));
+		if (rx_work_or_err < 0)
+			return rx_work_or_err;
+
+		work_done += rx_work_or_err;
+	}
 end:
 	return work_done;
 }
@@ -919,12 +946,16 @@ static int m_can_rx_handler(struct net_device *dev, int quota)
 static int m_can_rx_peripheral(struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
+	int work_done;
 
-	m_can_rx_handler(dev, M_CAN_NAPI_WEIGHT);
+	work_done = m_can_rx_handler(dev, M_CAN_NAPI_WEIGHT);
 
-	m_can_enable_all_interrupts(cdev);
+	// Don't re-enable interrupts if the driver had a fatal error
+	// (e.g., FIFO read failure).
+	if (work_done >= 0)
+		m_can_enable_all_interrupts(cdev);
 
-	return 0;
+	return work_done;
 }
 
 static int m_can_poll(struct napi_struct *napi, int quota)
@@ -934,7 +965,10 @@ static int m_can_poll(struct napi_struct *napi, int quota)
 	int work_done;
 
 	work_done = m_can_rx_handler(dev, quota);
-	if (work_done < quota) {
+
+	// Don't re-enable interrupts if the driver had a fatal error
+	// (e.g., FIFO read failure).
+	if (work_done >= 0 && work_done < quota) {
 		napi_complete_done(napi, work_done);
 		m_can_enable_all_interrupts(cdev);
 	}
@@ -965,7 +999,7 @@ static void m_can_tx_update_stats(struct m_can_classdev *cdev,
 	stats->tx_packets++;
 }
 
-static void m_can_echo_tx_event(struct net_device *dev)
+static int m_can_echo_tx_event(struct net_device *dev)
 {
 	u32 txe_count = 0;
 	u32 m_can_txefs;
@@ -984,12 +1018,18 @@ static void m_can_echo_tx_event(struct net_device *dev)
 	/* Get and process all sent elements */
 	for (i = 0; i < txe_count; i++) {
 		u32 txe, timestamp = 0;
+		int err;
 
 		/* retrieve get index */
 		fgi = FIELD_GET(TXEFS_EFGI_MASK, m_can_read(cdev, M_CAN_TXEFS));
 
 		/* get message marker, timestamp */
-		txe = m_can_txe_fifo_read(cdev, fgi, 4);
+		err = m_can_txe_fifo_read(cdev, fgi, 4, &txe);
+		if (err) {
+			netdev_err(dev, "TXE FIFO read returned %d\n", err);
+			return err;
+		}
+
 		msg_mark = FIELD_GET(TX_EVENT_MM_MASK, txe);
 		timestamp = FIELD_GET(TX_EVENT_TXTS_MASK, txe);
 
@@ -1000,6 +1040,8 @@ static void m_can_echo_tx_event(struct net_device *dev)
 		/* update stats */
 		m_can_tx_update_stats(cdev, msg_mark, timestamp);
 	}
+
+	return 0;
 }
 
 static irqreturn_t m_can_isr(int irq, void *dev_id)
@@ -1031,8 +1073,8 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 		m_can_disable_all_interrupts(cdev);
 		if (!cdev->is_peripheral)
 			napi_schedule(&cdev->napi);
-		else
-			m_can_rx_peripheral(dev);
+		else if (m_can_rx_peripheral(dev) < 0)
+			goto out_fail;
 	}
 
 	if (cdev->version == 30) {
@@ -1050,7 +1092,9 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	} else  {
 		if (ir & IR_TEFN) {
 			/* New TX FIFO Element arrived */
-			m_can_echo_tx_event(dev);
+			if (m_can_echo_tx_event(dev) != 0)
+				goto out_fail;
+
 			can_led_event(dev, CAN_LED_EVENT_TX);
 			if (netif_queue_stopped(dev) &&
 			    !m_can_tx_fifo_full(cdev))
@@ -1059,6 +1103,10 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	}
 
 	return IRQ_HANDLED;
+
+out_fail:
+	m_can_disable_all_interrupts(cdev);
+	return IRQ_HANDLED;
 }
 
 static const struct can_bittiming_const m_can_bittiming_const_30X = {
@@ -1540,8 +1588,8 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 	struct canfd_frame *cf = (struct canfd_frame *)cdev->tx_skb->data;
 	struct net_device *dev = cdev->net;
 	struct sk_buff *skb = cdev->tx_skb;
-	u32 id, cccr, fdflags;
-	int i;
+	u32 id, dlc, cccr, fdflags;
+	int i, err;
 	int putidx;
 
 	cdev->tx_skb = NULL;
@@ -1562,14 +1610,20 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 		netif_stop_queue(dev);
 
 		/* message ram configuration */
-		m_can_fifo_write(cdev, 0, M_CAN_FIFO_ID, id);
-		m_can_fifo_write(cdev, 0, M_CAN_FIFO_DLC,
-				 can_fd_len2dlc(cf->len) << 16);
+		err = m_can_fifo_write(cdev, 0, M_CAN_FIFO_ID, &id, 1);
+		if (err)
+			goto out_fail;
 
-		for (i = 0; i < cf->len; i += 4)
-			m_can_fifo_write(cdev, 0,
-					 M_CAN_FIFO_DATA(i / 4),
-					 *(u32 *)(cf->data + i));
+		dlc = can_fd_len2dlc(cf->len) << 16;
+		err = m_can_fifo_write(cdev, 0, M_CAN_FIFO_DLC, &dlc, 1);
+		if (err)
+			goto out_fail;
+
+		for (i = 0; i < cf->len; i += 4) {
+			err = m_can_fifo_write(cdev, 0, M_CAN_FIFO_DATA(i / 4), cf->data + i, 1);
+			if (err)
+				goto out_fail;
+		}
 
 		can_put_echo_skb(skb, dev, 0, 0);
 
@@ -1614,7 +1668,9 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 		putidx = FIELD_GET(TXFQS_TFQPI_MASK,
 				   m_can_read(cdev, M_CAN_TXFQS));
 		/* Write ID Field to FIFO Element */
-		m_can_fifo_write(cdev, putidx, M_CAN_FIFO_ID, id);
+		err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_ID, &id, 1);
+		if (err)
+			goto out_fail;
 
 		/* get CAN FD configuration of frame */
 		fdflags = 0;
@@ -1629,15 +1685,19 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 		 * it is used in TX interrupt for
 		 * sending the correct echo frame
 		 */
-		m_can_fifo_write(cdev, putidx, M_CAN_FIFO_DLC,
-				 FIELD_PREP(TX_BUF_MM_MASK, putidx) |
-				 FIELD_PREP(TX_BUF_DLC_MASK,
-					    can_fd_len2dlc(cf->len)) |
-				 fdflags | TX_BUF_EFC);
+		dlc = FIELD_PREP(TX_BUF_MM_MASK, putidx) |
+			FIELD_PREP(TX_BUF_DLC_MASK, can_fd_len2dlc(cf->len)) |
+			fdflags | TX_BUF_EFC;
+		err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_DLC, &dlc, 1);
+		if (err)
+			goto out_fail;
 
-		for (i = 0; i < cf->len; i += 4)
-			m_can_fifo_write(cdev, putidx, M_CAN_FIFO_DATA(i / 4),
-					 *(u32 *)(cf->data + i));
+		for (i = 0; i < cf->len; i += 4) {
+			err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_DATA(i / 4),
+					       cf->data + i, 1);
+			if (err)
+				goto out_fail;
+		}
 
 		/* Push loopback echo.
 		 * Will be looped back on TX interrupt based on message marker
@@ -1654,6 +1714,11 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 	}
 
 	return NETDEV_TX_OK;
+
+out_fail:
+	netdev_err(dev, "FIFO write returned %d\n", err);
+	m_can_disable_all_interrupts(cdev);
+	return NETDEV_TX_BUSY;
 }
 
 static void m_can_tx_work_queue(struct work_struct *ws)
@@ -1819,9 +1884,10 @@ static void m_can_of_parse_mram(struct m_can_classdev *cdev,
 		cdev->mcfg[MRAM_TXB].off, cdev->mcfg[MRAM_TXB].num);
 }
 
-void m_can_init_ram(struct m_can_classdev *cdev)
+int m_can_init_ram(struct m_can_classdev *cdev)
 {
 	int end, i, start;
+	int err = 0;
 
 	/* initialize the entire Message RAM in use to avoid possible
 	 * ECC/parity checksum errors when reading an uninitialized buffer
@@ -1830,8 +1896,13 @@ void m_can_init_ram(struct m_can_classdev *cdev)
 	end = cdev->mcfg[MRAM_TXB].off +
 		cdev->mcfg[MRAM_TXB].num * TXB_ELEMENT_SIZE;
 
-	for (i = start; i < end; i += 4)
-		m_can_fifo_write_no_off(cdev, i, 0x0);
+	for (i = start; i < end; i += 4) {
+		err = m_can_fifo_write_no_off(cdev, i, 0x0);
+		if (err)
+			break;
+	}
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(m_can_init_ram);
 
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index ace071c3e58c..7a3bc878535c 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -64,9 +64,9 @@ struct m_can_ops {
 	int (*clear_interrupts)(struct m_can_classdev *cdev);
 	u32 (*read_reg)(struct m_can_classdev *cdev, int reg);
 	int (*write_reg)(struct m_can_classdev *cdev, int reg, int val);
-	u32 (*read_fifo)(struct m_can_classdev *cdev, int addr_offset);
+	int (*read_fifo)(struct m_can_classdev *cdev, int addr_offset, void *val, size_t val_count);
 	int (*write_fifo)(struct m_can_classdev *cdev, int addr_offset,
-			  int val);
+			  const void *val, size_t val_count);
 	int (*init)(struct m_can_classdev *cdev);
 };
 
@@ -102,7 +102,7 @@ void m_can_class_free_dev(struct net_device *net);
 int m_can_class_register(struct m_can_classdev *cdev);
 void m_can_class_unregister(struct m_can_classdev *cdev);
 int m_can_class_get_clocks(struct m_can_classdev *cdev);
-void m_can_init_ram(struct m_can_classdev *priv);
+int m_can_init_ram(struct m_can_classdev *priv);
 
 int m_can_class_suspend(struct device *dev);
 int m_can_class_resume(struct device *dev);
diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
index 128808605c3f..89cc3d41e952 100644
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
@@ -55,11 +57,12 @@ static int iomap_write_reg(struct m_can_classdev *cdev, int reg, int val)
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
index 599de0e08cd7..12dec09cbd9f 100644
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
@@ -44,11 +46,12 @@ static int iomap_write_reg(struct m_can_classdev *cdev, int reg, int val)
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
@@ -115,7 +118,9 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mcan_class);
 
-	m_can_init_ram(mcan_class);
+	ret = m_can_init_ram(mcan_class);
+	if (ret)
+		goto probe_fail;
 
 	pm_runtime_enable(mcan_class->dev);
 	ret = m_can_class_register(mcan_class);
diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 4147cecfbbd6..11c096fe94a2 100644
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
@@ -172,11 +170,11 @@ static int tcan4x5x_write_reg(struct m_can_classdev *cdev, int reg, int val)
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
@@ -238,7 +236,9 @@ static int tcan4x5x_init(struct m_can_classdev *cdev)
 		return ret;
 
 	/* Zero out the MCAN buffers */
-	m_can_init_ram(cdev);
+	ret = m_can_init_ram(cdev);
+	if (ret)
+		return ret;
 
 	ret = regmap_update_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
 				 TCAN4X5X_MODE_SEL_MASK, TCAN4X5X_MODE_NORMAL);
-- 
2.32.0

