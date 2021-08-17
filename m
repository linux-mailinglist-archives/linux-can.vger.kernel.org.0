Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053903EE60C
	for <lists+linux-can@lfdr.de>; Tue, 17 Aug 2021 07:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbhHQFJf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 Aug 2021 01:09:35 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:50845 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234088AbhHQFJc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 17 Aug 2021 01:09:32 -0400
Received: from MTA-13-3.privateemail.com (mta-13-1.privateemail.com [198.54.122.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 6DC4780973
        for <linux-can@vger.kernel.org>; Tue, 17 Aug 2021 01:08:59 -0400 (EDT)
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
        by mta-13.privateemail.com (Postfix) with ESMTP id 876FF18000BD;
        Tue, 17 Aug 2021 01:08:58 -0400 (EDT)
Received: from localhost.localdomain (unknown [10.20.151.223])
        by mta-13.privateemail.com (Postfix) with ESMTPA id 2860818000BE;
        Tue, 17 Aug 2021 01:08:58 -0400 (EDT)
From:   Matt Kline <matt@bitbashing.io>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Matt Kline <matt@bitbashing.io>, linux-can@vger.kernel.org
Subject: [PATCH v3 2/3] can: m_can: Batch FIFO reads during CAN receive
Date:   Mon, 16 Aug 2021 22:08:52 -0700
Message-Id: <20210817050853.14875-3-matt@bitbashing.io>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817050853.14875-1-matt@bitbashing.io>
References: <20210817050853.14875-1-matt@bitbashing.io>
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
 drivers/net/can/m_can/m_can.c | 51 +++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 83eb5cd51de5..85d6cd03bff1 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -308,6 +308,15 @@ enum m_can_reg {
 #define TX_EVENT_MM_MASK	GENMASK(31, 24)
 #define TX_EVENT_TXTS_MASK	GENMASK(15, 0)
 
+/* The ID and DLC registers are adjacent in M_CAN FIFO memory,
+ * and we can save a (potentially slow) bus round trip by combining
+ * reads and writes to them.
+ */
+struct __packed id_and_dlc {
+	u32 id;
+	u32 dlc;
+};
+
 static inline u32 m_can_read(struct m_can_classdev *cdev, enum m_can_reg reg)
 {
 	return cdev->ops->read_reg(cdev, reg);
@@ -460,17 +469,18 @@ static int m_can_read_fifo(struct net_device *dev, u32 rxfs)
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	struct canfd_frame *cf;
 	struct sk_buff *skb;
-	u32 id, fgi, dlc;
+	struct id_and_dlc fifo_header;
+	u32 fgi;
 	u32 timestamp = 0;
-	int i, err;
+	int err;
 
 	/* calculate the fifo get index for where to read data */
 	fgi = FIELD_GET(RXFS_FGI_MASK, rxfs);
-	err = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_DLC, &dlc, 1);
+	err = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_ID, &fifo_header, 2);
 	if (err)
 		goto out_fail;
 
-	if (dlc & RX_BUF_FDF)
+	if (fifo_header.dlc & RX_BUF_FDF)
 		skb = alloc_canfd_skb(dev, &cf);
 	else
 		skb = alloc_can_skb(dev, (struct can_frame **)&cf);
@@ -479,36 +489,31 @@ static int m_can_read_fifo(struct net_device *dev, u32 rxfs)
 		return 0;
 	}
 
-	if (dlc & RX_BUF_FDF)
-		cf->len = can_fd_dlc2len((dlc >> 16) & 0x0F);
+	if (fifo_header.dlc & RX_BUF_FDF)
+		cf->len = can_fd_dlc2len((fifo_header.dlc >> 16) & 0x0F);
 	else
-		cf->len = can_cc_dlc2len((dlc >> 16) & 0x0F);
+		cf->len = can_cc_dlc2len((fifo_header.dlc >> 16) & 0x0F);
 
-	err = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_ID, &id, 1);
-	if (err)
-		goto out_fail;
-
-	if (id & RX_BUF_XTD)
-		cf->can_id = (id & CAN_EFF_MASK) | CAN_EFF_FLAG;
+	if (fifo_header.id & RX_BUF_XTD)
+		cf->can_id = (fifo_header.id & CAN_EFF_MASK) | CAN_EFF_FLAG;
 	else
-		cf->can_id = (id >> 18) & CAN_SFF_MASK;
+		cf->can_id = (fifo_header.id >> 18) & CAN_SFF_MASK;
 
-	if (id & RX_BUF_ESI) {
+	if (fifo_header.id & RX_BUF_ESI) {
 		cf->flags |= CANFD_ESI;
 		netdev_dbg(dev, "ESI Error\n");
 	}
 
-	if (!(dlc & RX_BUF_FDF) && (id & RX_BUF_RTR)) {
+	if (!(fifo_header.dlc & RX_BUF_FDF) && (fifo_header.id & RX_BUF_RTR)) {
 		cf->can_id |= CAN_RTR_FLAG;
 	} else {
-		if (dlc & RX_BUF_BRS)
+		if (fifo_header.dlc & RX_BUF_BRS)
 			cf->flags |= CANFD_BRS;
 
-		for (i = 0; i < cf->len; i += 4) {
-			err = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_DATA(i / 4), cf->data + i, 1);
-			if (err)
-				goto out_fail;
-		}
+		err = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_DATA(0),
+				      cf->data, DIV_ROUND_UP(cf->len, 4));
+		if (err)
+			goto out_fail;
 	}
 
 	/* acknowledge rx fifo 0 */
@@ -517,7 +522,7 @@ static int m_can_read_fifo(struct net_device *dev, u32 rxfs)
 	stats->rx_packets++;
 	stats->rx_bytes += cf->len;
 
-	timestamp = FIELD_GET(RX_BUF_RXTS_MASK, dlc);
+	timestamp = FIELD_GET(RX_BUF_RXTS_MASK, fifo_header.dlc);
 
 	m_can_receive_skb(cdev, skb, timestamp);
 
-- 
2.32.0

