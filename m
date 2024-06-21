Return-Path: <linux-can+bounces-842-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7BA9124F8
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 14:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77562817B3
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 12:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F82914F9EF;
	Fri, 21 Jun 2024 12:17:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE6614F9F0
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718972270; cv=none; b=e+w+0RREjA/plh5f8JYEZOgZy19VEiq3tp7bt1QA4FCF630sYj/KD/vHwBqcgoAvaARd3f5DpfhkS/DryjjatayQ4xe3IWHeoLmX8sAZkG2R8dSc9BqKhzZs0rQ9AwA8g4cwLf11T5aMy3CCPWo83fRN1dymuOs2CD8tUN12lt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718972270; c=relaxed/simple;
	bh=1BM9HMqZj1L5kWAlp/tOQpnkoY14cWxaf8hX5igo8vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhoaCdl37+tZIYHZfoXVMM74HbHM+aYuuiH0QVDcVTBmll2ud1KjjFNoFve3dQGa3KnuPRi+buaseDHF+DhWSjgzIHg80q0A+CAjEDAs1X1JPHliRmvPHqHjap7Sse0h/H+1C1G7BWzNA88ImRucjzP2lKSulvPLXEi/azRcuGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKdD8-0002RC-Qm
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 14:17:46 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKdD7-003wFu-Sj
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 14:17:45 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 8A4242EE83B
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 12:17:45 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 450F82EE810;
	Fri, 21 Jun 2024 12:17:43 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 6fd26949;
	Fri, 21 Jun 2024 12:17:42 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vitor Soares <vitor.soares@toradex.com>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 5/5] can: mcp251xfd: fix infinite loop when xmit fails
Date: Fri, 21 Jun 2024 13:23:40 +0200
Message-ID: <20240621121739.434355-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621121739.434355-1-mkl@pengutronix.de>
References: <20240621121739.434355-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Vitor Soares <vitor.soares@toradex.com>

When the mcp251xfd_start_xmit() function fails, the driver stops
processing messages, and the interrupt routine does not return,
running indefinitely even after killing the running application.

Error messages:
[  441.298819] mcp251xfd spi2.0 can0: ERROR in mcp251xfd_start_xmit: -16
[  441.306498] mcp251xfd spi2.0 can0: Transmit Event FIFO buffer not empty. (seq=0x000017c7, tef_tail=0x000017cf, tef_head=0x000017d0, tx_head=0x000017d3).
... and repeat forever.

The issue can be triggered when multiple devices share the same SPI
interface. And there is concurrent access to the bus.

The problem occurs because tx_ring->head increments even if
mcp251xfd_start_xmit() fails. Consequently, the driver skips one TX
package while still expecting a response in
mcp251xfd_handle_tefif_one().

Resolve the issue by starting a workqueue to write the tx obj
synchronously if err = -EBUSY. In case of another error, decrement
tx_ring->head, remove skb from the echo stack, and drop the message.

Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
Cc: stable@vger.kernel.org
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
Link: https://lore.kernel.org/all/20240517134355.770777-1-ivitro@gmail.com
[mkl: use more imperative wording in patch description]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 14 ++++-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c  | 55 ++++++++++++++++---
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  5 ++
 3 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 1d9057dc44f2..bf1589aef1fc 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1618,11 +1618,20 @@ static int mcp251xfd_open(struct net_device *ndev)
 	clear_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
 	can_rx_offload_enable(&priv->offload);
 
+	priv->wq = alloc_ordered_workqueue("%s-mcp251xfd_wq",
+					   WQ_FREEZABLE | WQ_MEM_RECLAIM,
+					   dev_name(&spi->dev));
+	if (!priv->wq) {
+		err = -ENOMEM;
+		goto out_can_rx_offload_disable;
+	}
+	INIT_WORK(&priv->tx_work, mcp251xfd_tx_obj_write_sync);
+
 	err = request_threaded_irq(spi->irq, NULL, mcp251xfd_irq,
 				   IRQF_SHARED | IRQF_ONESHOT,
 				   dev_name(&spi->dev), priv);
 	if (err)
-		goto out_can_rx_offload_disable;
+		goto out_destroy_workqueue;
 
 	err = mcp251xfd_chip_interrupts_enable(priv);
 	if (err)
@@ -1634,6 +1643,8 @@ static int mcp251xfd_open(struct net_device *ndev)
 
  out_free_irq:
 	free_irq(spi->irq, priv);
+ out_destroy_workqueue:
+	destroy_workqueue(priv->wq);
  out_can_rx_offload_disable:
 	can_rx_offload_disable(&priv->offload);
 	set_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
@@ -1661,6 +1672,7 @@ static int mcp251xfd_stop(struct net_device *ndev)
 	hrtimer_cancel(&priv->tx_irq_timer);
 	mcp251xfd_chip_interrupts_disable(priv);
 	free_irq(ndev->irq, priv);
+	destroy_workqueue(priv->wq);
 	can_rx_offload_disable(&priv->offload);
 	mcp251xfd_timestamp_stop(priv);
 	mcp251xfd_chip_stop(priv, CAN_STATE_STOPPED);
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
index 160528d3cc26..b1de8052a45c 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
@@ -131,6 +131,39 @@ mcp251xfd_tx_obj_from_skb(const struct mcp251xfd_priv *priv,
 	tx_obj->xfer[0].len = len;
 }
 
+static void mcp251xfd_tx_failure_drop(const struct mcp251xfd_priv *priv,
+				      struct mcp251xfd_tx_ring *tx_ring,
+				      int err)
+{
+	struct net_device *ndev = priv->ndev;
+	struct net_device_stats *stats = &ndev->stats;
+	unsigned int frame_len = 0;
+	u8 tx_head;
+
+	tx_ring->head--;
+	stats->tx_dropped++;
+	tx_head = mcp251xfd_get_tx_head(tx_ring);
+	can_free_echo_skb(ndev, tx_head, &frame_len);
+	netdev_completed_queue(ndev, 1, frame_len);
+	netif_wake_queue(ndev);
+
+	if (net_ratelimit())
+		netdev_err(priv->ndev, "ERROR in %s: %d\n", __func__, err);
+}
+
+void mcp251xfd_tx_obj_write_sync(struct work_struct *work)
+{
+	struct mcp251xfd_priv *priv = container_of(work, struct mcp251xfd_priv,
+						   tx_work);
+	struct mcp251xfd_tx_obj *tx_obj = priv->tx_work_obj;
+	struct mcp251xfd_tx_ring *tx_ring = priv->tx;
+	int err;
+
+	err = spi_sync(priv->spi, &tx_obj->msg);
+	if (err)
+		mcp251xfd_tx_failure_drop(priv, tx_ring, err);
+}
+
 static int mcp251xfd_tx_obj_write(const struct mcp251xfd_priv *priv,
 				  struct mcp251xfd_tx_obj *tx_obj)
 {
@@ -162,6 +195,11 @@ static bool mcp251xfd_tx_busy(const struct mcp251xfd_priv *priv,
 	return false;
 }
 
+static bool mcp251xfd_work_busy(struct work_struct *work)
+{
+	return work_busy(work);
+}
+
 netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 				 struct net_device *ndev)
 {
@@ -175,7 +213,8 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 	if (can_dev_dropped_skb(ndev, skb))
 		return NETDEV_TX_OK;
 
-	if (mcp251xfd_tx_busy(priv, tx_ring))
+	if (mcp251xfd_tx_busy(priv, tx_ring) ||
+	    mcp251xfd_work_busy(&priv->tx_work))
 		return NETDEV_TX_BUSY;
 
 	tx_obj = mcp251xfd_get_tx_obj_next(tx_ring);
@@ -193,13 +232,13 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 		netdev_sent_queue(priv->ndev, frame_len);
 
 	err = mcp251xfd_tx_obj_write(priv, tx_obj);
-	if (err)
-		goto out_err;
-
-	return NETDEV_TX_OK;
-
- out_err:
-	netdev_err(priv->ndev, "ERROR in %s: %d\n", __func__, err);
+	if (err == -EBUSY) {
+		netif_stop_queue(ndev);
+		priv->tx_work_obj = tx_obj;
+		queue_work(priv->wq, &priv->tx_work);
+	} else if (err) {
+		mcp251xfd_tx_failure_drop(priv, tx_ring, err);
+	}
 
 	return NETDEV_TX_OK;
 }
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 24510b3b8020..b35bfebd23f2 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -633,6 +633,10 @@ struct mcp251xfd_priv {
 	struct mcp251xfd_rx_ring *rx[MCP251XFD_FIFO_RX_NUM];
 	struct mcp251xfd_tx_ring tx[MCP251XFD_FIFO_TX_NUM];
 
+	struct workqueue_struct *wq;
+	struct work_struct tx_work;
+	struct mcp251xfd_tx_obj *tx_work_obj;
+
 	DECLARE_BITMAP(flags, __MCP251XFD_FLAGS_SIZE__);
 
 	u8 rx_ring_num;
@@ -952,6 +956,7 @@ void mcp251xfd_skb_set_timestamp(const struct mcp251xfd_priv *priv,
 void mcp251xfd_timestamp_init(struct mcp251xfd_priv *priv);
 void mcp251xfd_timestamp_stop(struct mcp251xfd_priv *priv);
 
+void mcp251xfd_tx_obj_write_sync(struct work_struct *work);
 netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 				 struct net_device *ndev);
 
-- 
2.43.0



