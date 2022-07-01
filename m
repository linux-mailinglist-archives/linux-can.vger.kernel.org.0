Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4160562F59
	for <lists+linux-can@lfdr.de>; Fri,  1 Jul 2022 11:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiGAJB4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 1 Jul 2022 05:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiGAJB4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 1 Jul 2022 05:01:56 -0400
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Jul 2022 02:01:54 PDT
Received: from mail.prodrive-technologies.com (mail.prodrive-technologies.com [212.61.153.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3178D1C92E
        for <linux-can@vger.kernel.org>; Fri,  1 Jul 2022 02:01:54 -0700 (PDT)
Received: from EXC03.bk.prodrive.nl (10.1.1.212) by EXC03.bk.prodrive.nl
 (10.1.1.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2242.12; Fri, 1
 Jul 2022 10:46:50 +0200
Received: from lnxdevrm02.prodrive.nl (10.1.1.121) by EXC03.bk.prodrive.nl
 (10.1.1.212) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 1 Jul 2022 10:46:50 +0200
From:   Wouter van Herpen <wouter.van.herpen@prodrive-technologies.com>
To:     <mkl@pengutronix.de>
CC:     <linux-can@vger.kernel.org>,
        Wouter van Herpen <wouter.van.herpen@prodrive-technologies.com>
Subject: [PATCH] can: m_can: fix netif_stop/wake_queue race condition between m_can_tx_handler() and m_can_isr().
Date:   Fri, 1 Jul 2022 09:46:37 +0100
Message-ID: <5083a7dfca89695f4359e519d8fd483900dea1f6.1656492416.git.wouter.van.herpen@prodrive-technologies.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

m_can_tx_handler() initiates a write by calling can_put_echo_skb() and
m_can_write() to M_CAN_TXBAR.
After that, netif_stop_queue is called depending on the FIFO status.

Observed with a TCAN45 controller and under high CPU load, the TCAN45
can already generate an interrupt after the m_can_write to M_CAN_TXBAR,
but before netif_stop_queue is executed.
The m_can_isr() is then executed (performing a netif_wake_queue) before
the netif_stop_queue is executed, leading to a blocking socket.

Fix this for TX FIFO size 1, where the queue can always be stopped
before initiating a transfer.

Signed-off-by: Wouter van Herpen <wouter.van.herpen@prodrive-technologies.com>
---
Possible improvement to this patch would be to predict if the next write
would fill the FIFO, and if so, stop the queue before initiating the
transfer. Then the race condition would also be fixed for TX buffer sizes
larger than 1. However, I do not recognize a proper diagnostic register
in the TCAN45 for that purpose.

Alternatively a locking mechanism could be introduced, which I did not
investigate further as there can be sleeps involved in the SPI writes.

 drivers/net/can/m_can/m_can.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 5d0c82d8b9a9..2817f8e83206 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1684,6 +1684,15 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 		if (err)
 			goto out_fail;
 
+		/* A race can occur between netif_stop_queue here and
+		 * netif_wake_queue in m_can_isr(), if the queue is stopped
+		 * after initiating a transfer. If the TX buffer has size 1,
+		 * it is allowed to always stop the queue and only then
+		 * initiate the transfer, thus avoiding any race condition.
+		 */
+		if (cdev->mcfg[MRAM_TXB].num == 1)
+			netif_stop_queue(dev);
+
 		/* Push loopback echo.
 		 * Will be looped back on TX interrupt based on message marker
 		 */
@@ -1692,10 +1701,12 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 		/* Enable TX FIFO element to start transfer  */
 		m_can_write(cdev, M_CAN_TXBAR, (1 << putidx));
 
-		/* stop network queue if fifo full */
-		if (m_can_tx_fifo_full(cdev) ||
-		    m_can_next_echo_skb_occupied(dev, putidx))
-			netif_stop_queue(dev);
+		if (cdev->mcfg[MRAM_TXB].num != 1) {
+			/* stop network queue if fifo full */
+			if (m_can_tx_fifo_full(cdev) ||
+			    m_can_next_echo_skb_occupied(dev, putidx))
+				netif_stop_queue(dev);
+		}
 	}
 
 	return NETDEV_TX_OK;
-- 
2.30.2

