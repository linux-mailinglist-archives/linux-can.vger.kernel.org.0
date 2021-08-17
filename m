Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2A63EE60D
	for <lists+linux-can@lfdr.de>; Tue, 17 Aug 2021 07:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbhHQFJh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 Aug 2021 01:09:37 -0400
Received: from h2.fbrelay.privateemail.com ([131.153.2.43]:43481 "EHLO
        h2.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234214AbhHQFJc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 17 Aug 2021 01:09:32 -0400
Received: from MTA-13-3.privateemail.com (mta-13-1.privateemail.com [198.54.122.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id F20A680682
        for <linux-can@vger.kernel.org>; Tue, 17 Aug 2021 01:08:59 -0400 (EDT)
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
        by mta-13.privateemail.com (Postfix) with ESMTP id 01A7418000BE;
        Tue, 17 Aug 2021 01:08:59 -0400 (EDT)
Received: from localhost.localdomain (unknown [10.20.151.223])
        by mta-13.privateemail.com (Postfix) with ESMTPA id 9878B18000BF;
        Tue, 17 Aug 2021 01:08:58 -0400 (EDT)
From:   Matt Kline <matt@bitbashing.io>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Matt Kline <matt@bitbashing.io>, linux-can@vger.kernel.org
Subject: [PATCH v3 3/3] can: m_can: Batch FIFO writes during CAN transmit
Date:   Mon, 16 Aug 2021 22:08:53 -0700
Message-Id: <20210817050853.14875-4-matt@bitbashing.io>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817050853.14875-1-matt@bitbashing.io>
References: <20210817050853.14875-1-matt@bitbashing.io>
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
 drivers/net/can/m_can/m_can.c | 61 +++++++++++++++--------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 85d6cd03bff1..b0e20c7d596c 100644
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
@@ -510,7 +510,7 @@ static int m_can_read_fifo(struct net_device *dev, u32 rxfs)
 		if (fifo_header.dlc & RX_BUF_BRS)
 			cf->flags |= CANFD_BRS;
 
-		err = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_DATA(0),
+		err = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_DATA,
 				      cf->data, DIV_ROUND_UP(cf->len, 4));
 		if (err)
 			goto out_fail;
@@ -1593,8 +1593,9 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 	struct canfd_frame *cf = (struct canfd_frame *)cdev->tx_skb->data;
 	struct net_device *dev = cdev->net;
 	struct sk_buff *skb = cdev->tx_skb;
-	u32 id, dlc, cccr, fdflags;
-	int i, err;
+	struct id_and_dlc fifo_header;
+	u32 cccr, fdflags;
+	int err;
 	int putidx;
 
 	cdev->tx_skb = NULL;
@@ -1602,34 +1603,30 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 	/* Generate ID field for TX buffer Element */
 	/* Common to all supported M_CAN versions */
 	if (cf->can_id & CAN_EFF_FLAG) {
-		id = cf->can_id & CAN_EFF_MASK;
-		id |= TX_BUF_XTD;
+		fifo_header.id = cf->can_id & CAN_EFF_MASK;
+		fifo_header.id |= TX_BUF_XTD;
 	} else {
-		id = ((cf->can_id & CAN_SFF_MASK) << 18);
+		fifo_header.id = ((cf->can_id & CAN_SFF_MASK) << 18);
 	}
 
 	if (cf->can_id & CAN_RTR_FLAG)
-		id |= TX_BUF_RTR;
+		fifo_header.id |= TX_BUF_RTR;
 
 	if (cdev->version == 30) {
 		netif_stop_queue(dev);
 
-		/* message ram configuration */
-		err = m_can_fifo_write(cdev, 0, M_CAN_FIFO_ID, &id, 1);
+		fifo_header.dlc = can_fd_len2dlc(cf->len) << 16;
+
+		/* Write the frame ID, DLC, and payload to the FIFO element. */
+		err = m_can_fifo_write(cdev, 0, M_CAN_FIFO_ID, &fifo_header, 2);
 		if (err)
 			goto out_fail;
 
-		dlc = can_fd_len2dlc(cf->len) << 16;
-		err = m_can_fifo_write(cdev, 0, M_CAN_FIFO_DLC, &dlc, 1);
+		err = m_can_fifo_write(cdev, 0, M_CAN_FIFO_DATA,
+				       cf->data, DIV_ROUND_UP(cf->len, 4));
 		if (err)
 			goto out_fail;
 
-		for (i = 0; i < cf->len; i += 4) {
-			err = m_can_fifo_write(cdev, 0, M_CAN_FIFO_DATA(i / 4), cf->data + i, 1);
-			if (err)
-				goto out_fail;
-		}
-
 		can_put_echo_skb(skb, dev, 0, 0);
 
 		if (cdev->can.ctrlmode & CAN_CTRLMODE_FD) {
@@ -1672,10 +1669,11 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 		/* get put index for frame */
 		putidx = FIELD_GET(TXFQS_TFQPI_MASK,
 				   m_can_read(cdev, M_CAN_TXFQS));
-		/* Write ID Field to FIFO Element */
-		err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_ID, &id, 1);
-		if (err)
-			goto out_fail;
+
+		/* Construct DLC Field, with CAN-FD configuration.
+		 * Use the put index of the fifo as the message marker,
+		 * used in the TX interrupt for sending the correct echo frame.
+		 */
 
 		/* get CAN FD configuration of frame */
 		fdflags = 0;
@@ -1685,24 +1683,17 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 				fdflags |= TX_BUF_BRS;
 		}
 
-		/* Construct DLC Field. Also contains CAN-FD configuration
-		 * use put index of fifo as message marker
-		 * it is used in TX interrupt for
-		 * sending the correct echo frame
-		 */
-		dlc = FIELD_PREP(TX_BUF_MM_MASK, putidx) |
+		fifo_header.dlc = FIELD_PREP(TX_BUF_MM_MASK, putidx) |
 			FIELD_PREP(TX_BUF_DLC_MASK, can_fd_len2dlc(cf->len)) |
 			fdflags | TX_BUF_EFC;
-		err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_DLC, &dlc, 1);
+		err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_ID, &fifo_header, 2);
 		if (err)
 			goto out_fail;
 
-		for (i = 0; i < cf->len; i += 4) {
-			err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_DATA(i / 4),
-					       cf->data + i, 1);
-			if (err)
-				goto out_fail;
-		}
+		err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_DATA,
+				       cf->data, DIV_ROUND_UP(cf->len, 4));
+		if (err)
+			goto out_fail;
 
 		/* Push loopback echo.
 		 * Will be looped back on TX interrupt based on message marker
-- 
2.32.0

