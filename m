Return-Path: <linux-can+bounces-646-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0822B8C8765
	for <lists+linux-can@lfdr.de>; Fri, 17 May 2024 15:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6E21F230AE
	for <lists+linux-can@lfdr.de>; Fri, 17 May 2024 13:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED9354BED;
	Fri, 17 May 2024 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBq5T0dz"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C589B3A1AB;
	Fri, 17 May 2024 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715953444; cv=none; b=C8HvB9lJjZS9mxFCHQPJXyLYmOG0LlCO4MoBdyw/wvs0wET3lmbwHCTChkGAglgHsB3V752ctUpuxS51pGBgZlCJR6ARcRA2ryrchUxstG7oBl3HRoPOhOA4+19ywdtyqFfD9nbqowg2e7IGshLI2Tdo/eop42io128eVES2Nog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715953444; c=relaxed/simple;
	bh=p8W5iIh906TA2cC4Yb3yk78pNyjKZhRk3rRRGzZM3cI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b0gZPUWOiTBqTeO9ttNjS8QvZ7HLS2yFTHLVJC5Sm3Sc7MNBYMH584bRL811nQAjEBjDRLFexqJ4VDEm32FSNKzhDTeNYp7L+YeUu9mwM0QoD5xkUSwWo8a1YL/oDoq0zpwrsaCYkpJFjKb53fwmSBjt3xjLV7LbkQ1GOhbZUkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBq5T0dz; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-574f7c0bab4so5505393a12.0;
        Fri, 17 May 2024 06:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715953441; x=1716558241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xc6UrTeeAbRqxqH2tddrJB8Tu920z+7rYx2BwE6FU4o=;
        b=hBq5T0dzjuiUfu8MiVqwsWja2TRSXDCDrhELHl6mLqbbRV85a9cqBp6qHlURNnwrkS
         bihsoE5sWWRwAGcSecxwN7NamYeuPRJQE4AlcezyqMYrz+GgxSBcK2O2PQjnVeBjmpKe
         i43S+2mzAPUT/xPgHEsuw4YBTztjRVqoaFrY+BF2n9A9NW42DW/0fa9q/8IQXW4njHWd
         X0ykeVqz0NGkleyanURkxWCbfn+VvDJm7gchRGkLxC80gUlhgwQQ+busfyEvS4hKekW0
         b3+JMGoj9NdSdV7FUsSRch9wKulrDpNGZcTeyeU2aSLHfs6a9PKEFBLvK2XBWvtkb8m7
         J9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715953441; x=1716558241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xc6UrTeeAbRqxqH2tddrJB8Tu920z+7rYx2BwE6FU4o=;
        b=sfeaf0uwwIocpd/srpzCK4rWJMLtMf+N+0upAust1esUEJCzCzhnwoHs1P57wh1D5f
         9NwQWzPT8DqM82VabeLb0KeBDE4FgC3z9IxivI5b7vJwxP/4yaog6YNqd/GmstirdDXc
         hEEB1XNhVJrb8RS465YWA50ob7Uw2x5KrX/Lk7YRtJyaf+Qfqn8pgKvjgtjicyLuDniw
         JHi/g4IQ1WfeGPyT1xbwWEyNQ2E60I8nqVXG0in/WMIGfWp6Az+T1NTkPgNtGNPyiATQ
         EMIUPUFcOZzt5MX/PoWSZBfd6Ud4RX3P2h1egju/H1WcoF0R+EQ+MG1B/7JbvSpTAX7p
         aRPA==
X-Forwarded-Encrypted: i=1; AJvYcCU5HcWmaZDHnu5SJvWBgOEWVERvkyog8G8yhc1DG9wX6XKI4Y+B0YFUCNZy8pWhjRGW0CDXaHy63PPVcHK3Y+GY80ticusb9zMEoSplaB0LsNHjJyDyqBKlAegT1cLhLdygHhupfA4VW+tG2zu4Vm/gPQOrd134OAQRbKcFtT7yh2B/kYi9xJwtULFtyeuXAEqJ8ZznueZC
X-Gm-Message-State: AOJu0Yylq7xHuhBSv678ikyRXMMQTgaI9FXCGDzizVyf0dQ+FiAld3vV
	dTmQ60gzpQWLeuX4mqr8vZmgr9Oobaj/+GnSamZo2L7V4sNaUDqW
X-Google-Smtp-Source: AGHT+IHBnfhjj5I1gOOdYGdV1S6MrXbS4jtZMTyBBi/RKh2ly7X/tmYR+Br6WizoBNrM9rAgz4Iw0w==
X-Received: by 2002:a05:6402:430c:b0:572:afb6:3b7c with SMTP id 4fb4d7f45d1cf-573322c59ecmr27025166a12.0.1715953440689;
        Fri, 17 May 2024 06:44:00 -0700 (PDT)
Received: from vitor-nb.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574bcad0362sm8706350a12.20.2024.05.17.06.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 06:44:00 -0700 (PDT)
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
	stable@vger.kernel.org
Subject: [PATCH v6] can: mcp251xfd: fix infinite loop when xmit fails
Date: Fri, 17 May 2024 14:43:55 +0100
Message-Id: <20240517134355.770777-1-ivitro@gmail.com>
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

v5->v6
  - Move alloc/destroy workqueue to open()/stop() callbacks.
  - Change workqueue to workqueue ordered.
  - Return NETDEV_TX_BUSY if the worker is busy, replacing the previouse
    priv->tx_work_obj = NULL. With this change, setting priv->tx_work_obj = NULL
    is not necessary anymore.

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
2.34.1


