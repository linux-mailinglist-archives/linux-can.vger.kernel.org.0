Return-Path: <linux-can+bounces-638-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C6D8C5151
	for <lists+linux-can@lfdr.de>; Tue, 14 May 2024 13:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516BC1C20BC8
	for <lists+linux-can@lfdr.de>; Tue, 14 May 2024 11:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C971304A1;
	Tue, 14 May 2024 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qh904XOk"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153CA320F;
	Tue, 14 May 2024 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684324; cv=none; b=Uu5Ypiwx8hQUHjSCOQeSDskpb60CVNFMWkrew8gy1APZesXVma8NmX4K1vr6FHVBJ5Ho5ZwYYQQNTPF4B7wb34z5X6QhrKQjfiqtPjw21iNXH15EejpR20ZD733WloOMXZPLUuFexL3E0YIL4Z1h6AWE7iSE2PfS9Eg9JeCTPag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684324; c=relaxed/simple;
	bh=lpcqTqrvcgADw0vPU8bnP14Eq09pMdEMy88+H2lqisc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oXZLo7KEBg+f+Dob9qwXm1hp6XwCOvM4aD2nuXErrdHdbgOk6l+dlWCeegS2XSzQO8kj0s7sNA2Aty+LhM+jhcNH50O3uRbuEri3vzuJd9sSZ9Sc93Tq8JVDTIX9xPrS3+0ms6pHEiKpVf1JzKiBxtTKSikG53t1MgI4bLKkziw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qh904XOk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41ff5e3d86aso28248265e9.1;
        Tue, 14 May 2024 03:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715684321; x=1716289121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zcss4NldlyQ6tiuFcBRQjRJyCadmCYp5vKGWkvqedX8=;
        b=Qh904XOk7LMUyNy7Q5+GqF0I2UviQeY33yJ5uoLesm/l6BiRfyXFiimax2YzrQWYIt
         xJA4WrM4Dibyi4WRCHaaRqjTZdbo/3dhScI3CxF6yjVzfw+R7dIBrjaJAXg3eQVZ9W1v
         owqSwpR0mbps4s8cXRA3pNBzyqXz3CHUVGIR3Z54VhmztTmO2cOo3HcT6K5HlHUp0WTC
         ch64YeqElZKlSs676krVvvRsK4tGn1WuNCmVIR5/TaC2TZjmW9LKujOmr1WDui3ujv83
         i9wbXBizJJjlJvq698htrM7eYZzAEPFieLJWOMDdDvNMRots6soyIagtNRv8ep7J4PJ7
         C64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715684321; x=1716289121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zcss4NldlyQ6tiuFcBRQjRJyCadmCYp5vKGWkvqedX8=;
        b=gt4pL/ow0/lWaeu7FLXu3b2yqlV0Me7bwy+MOqO+cQEtngOm0gWdHfdgpflrS47+GW
         Ja0NzebhSPSgxhAYVRy/1H1IbO+oJvdz9ZScU18RdKyHLda0vpM7U3NjWgKNURsNKqF0
         g+8kAb0F+WMHxc3+BCEIZGwJHaF4xu+U1m3IWPAFTo3q4ZPwn8vSqmmXSnVTQ1s8M+we
         O14R7dv30PPjsMjj2vu4XJJHBhkhHnRwNxAZy3TNsLhJxz4itvkDq5z+Yjl9eBwX3xzS
         30s+S15VoXNbH6y3bEl8sUoXjbqGThQKlVuB7F/DeblsL8YfZGt/7kxzE7wcPmrmhM9Z
         Acgg==
X-Forwarded-Encrypted: i=1; AJvYcCXrlsM7bdFpUjcRAD81Cis/TK7O54Rezw23sNpBbdAnizxpUf3deHGJZeeNI9lKkgPwnHGb7Hr8slza8j5JRPBqwS9j2AXZHlTVGDE9+VLCnLD6eyMZvefHOokUi/UvqMkf020g7opkLHwXVtw6bQG8ODGtA8J9VB8Mmi0VTYwatR4ybAk/D9o8XxXw4rrZvfirOVSbNAfN
X-Gm-Message-State: AOJu0YzE4qzKFWTuQOyBJRZmzOxLezpvhE2s9VCi1LM1wersH9kxNKgY
	/qJiN3i2WoHD4/1FwC0F6uEAv/709NUy5QiWJNukk82nCKgX1Cxu
X-Google-Smtp-Source: AGHT+IHavPP3p7VgtypkEZA30JLLaKH02FZ4mtDF6rpdxpx+nbNFgjPzyo0LtoD2LFO9QdAan7y7bQ==
X-Received: by 2002:adf:eb12:0:b0:347:9bec:9ba3 with SMTP id ffacd0b85a97d-3504aa64997mr9449373f8f.66.1715684321125;
        Tue, 14 May 2024 03:58:41 -0700 (PDT)
Received: from vitor-nb.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bca6sm13355328f8f.12.2024.05.14.03.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 03:58:40 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ivitro@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v5] can: mcp251xfd: fix infinite loop when xmit fails
Date: Tue, 14 May 2024 11:58:22 +0100
Message-Id: <20240514105822.99986-1-ivitro@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitor Soares <vitor.soares@toradex.com>

When the mcp251xfd_start_xmit() function fails, the driver stops
processing messages, and the interrupt routine does not return,
running indefinitely even after killing the running application.

Error messages:
[  441.298819] mcp251xfd spi2.0 can0: ERROR in mcp251xfd_start_xmit: -16
[  441.306498] mcp251xfd spi2.0 can0: Transmit Event FIFO buffer not empty. (seq=0x000017c7, tef_tail=0x000017cf, tef_head=0x000017d0, tx_head=0x000017d3).
... and repeat forever.

The issue can be triggered when multiple devices share the same
SPI interface. And there is concurrent access to the bus.

The problem occurs because tx_ring->head increments even if
mcp251xfd_start_xmit() fails. Consequently, the driver skips one
TX package while still expecting a response in
mcp251xfd_handle_tefif_one().

This patch resolves the issue by starting a workqueue to write
the tx obj synchronously if err = -EBUSY. In case of another error,
it decrements tx_ring->head, removes skb from the echo stack, and
drops the message.

Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
Cc: stable@vger.kernel.org
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---

V4->V5:
  - Start a workqueue to write tx obj with spi_sync() when spi_async() == -EBUSY.

V3->V4:
  - Leave can_put_echo_skb() and stop the queue if needed, before mcp251xfd_tx_obj_write().
  - Re-sync head and remove echo skb if mcp251xfd_tx_obj_write() fails.
  - Revert -> return NETDEV_TX_BUSY if mcp251xfd_tx_obj_write() == -EBUSY.

V2->V3:
  - Add tx_dropped stats.
  - netdev_sent_queue() only if can_put_echo_skb() succeed.

V1->V2:
  - Return NETDEV_TX_BUSY if mcp251xfd_tx_obj_write() == -EBUSY.
  - Rework the commit message to address the change above.
  - Change can_put_echo_skb() to be called after mcp251xfd_tx_obj_write() succeed.
    Otherwise, we get Kernel NULL pointer dereference error.

 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 13 ++++-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c  | 51 ++++++++++++++++---
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  5 ++
 3 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 1d9057dc44f2..6cca853f2b1e 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -2141,15 +2141,25 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	if (err)
 		goto out_free_candev;
 
+	priv->tx_work_obj = NULL;
+	priv->wq = alloc_workqueue("mcp251xfd_wq", WQ_FREEZABLE, 0);
+	if (!priv->wq) {
+		err = -ENOMEM;
+		goto out_can_rx_offload_del;
+	}
+	INIT_WORK(&priv->tx_work, mcp251xfd_tx_obj_write_sync);
+
 	err = mcp251xfd_register(priv);
 	if (err) {
 		dev_err_probe(&spi->dev, err, "Failed to detect %s.\n",
 			      mcp251xfd_get_model_str(priv));
-		goto out_can_rx_offload_del;
+		goto out_can_free_wq;
 	}
 
 	return 0;
 
+ out_can_free_wq:
+	destroy_workqueue(priv->wq);
  out_can_rx_offload_del:
 	can_rx_offload_del(&priv->offload);
  out_free_candev:
@@ -2165,6 +2175,7 @@ static void mcp251xfd_remove(struct spi_device *spi)
 	struct mcp251xfd_priv *priv = spi_get_drvdata(spi);
 	struct net_device *ndev = priv->ndev;
 
+	destroy_workqueue(priv->wq);
 	can_rx_offload_del(&priv->offload);
 	mcp251xfd_unregister(priv);
 	spi->max_speed_hz = priv->spi_max_speed_hz_orig;
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
index 160528d3cc26..1e7ddf316643 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
@@ -131,6 +131,41 @@ mcp251xfd_tx_obj_from_skb(const struct mcp251xfd_priv *priv,
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
+void mcp251xfd_tx_obj_write_sync(struct work_struct *ws)
+{
+	struct mcp251xfd_priv *priv = container_of(ws, struct mcp251xfd_priv,
+						   tx_work);
+	struct mcp251xfd_tx_obj *tx_obj = priv->tx_work_obj;
+	struct mcp251xfd_tx_ring *tx_ring = priv->tx;
+	int err;
+
+	err = spi_sync(priv->spi, &tx_obj->msg);
+	if (err)
+		mcp251xfd_tx_failure_drop(priv, tx_ring, err);
+
+	priv->tx_work_obj = NULL;
+}
+
 static int mcp251xfd_tx_obj_write(const struct mcp251xfd_priv *priv,
 				  struct mcp251xfd_tx_obj *tx_obj)
 {
@@ -175,7 +210,7 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 	if (can_dev_dropped_skb(ndev, skb))
 		return NETDEV_TX_OK;
 
-	if (mcp251xfd_tx_busy(priv, tx_ring))
+	if (mcp251xfd_tx_busy(priv, tx_ring) || priv->tx_work_obj)
 		return NETDEV_TX_BUSY;
 
 	tx_obj = mcp251xfd_get_tx_obj_next(tx_ring);
@@ -193,13 +228,13 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
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
+		priv->tx_work_obj = tx_obj;
+		netif_stop_queue(ndev);
+		queue_work(priv->wq, &priv->tx_work);
+	} else if (err) {
+		mcp251xfd_tx_failure_drop(priv, tx_ring, err);
+	}
 
 	return NETDEV_TX_OK;
 }
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 24510b3b8020..4e27a33f4030 100644
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
 
+void mcp251xfd_tx_obj_write_sync(struct work_struct *ws);
 netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 				 struct net_device *ndev);
 
-- 
2.34.1


