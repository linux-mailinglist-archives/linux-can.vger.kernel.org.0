Return-Path: <linux-can+bounces-581-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF978BD0B1
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 16:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63AE51C217CD
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 14:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9353153BD7;
	Mon,  6 May 2024 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzngEn52"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3FB1534FD;
	Mon,  6 May 2024 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006983; cv=none; b=JKPU7ZlcvYihe850GQt3GlmzolbnFE31wmSQokGf/puxpr/apH4BIzoskYNqQoGuzeniod7I+fVvHvRWA3YHU8OHH0cDMo/fqyDE443N4rqe7VyKhd2LVq6gmJtqaLxfewsjbhTbJmvuVdYjUwNkxnuFA0tufMEIb+guNqNOzs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006983; c=relaxed/simple;
	bh=ZK+XOL8bJQqTl71D+nNJPPuMVqC5lU22ILMhkVdpqXo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rCG5Gg+feWiCkH92ae51fMfd7sZkD8fPa8pWKtIuS4zpDoGnJsuIG+3AM+BuJqzQgQAaoU7BnvQTKhd1+3onuXOa+uVW6eAKSMdmSalDk1Dxv3KNSZkJSU+JB/mTpNLKUQYxgWe+udL2/iXh/Vhw/CufmHqurcvCQ4uAy6/7b7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzngEn52; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41bab13ca4eso13294575e9.1;
        Mon, 06 May 2024 07:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715006980; x=1715611780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HVbZDFfLK9GlBOKzZLEG1i0oNm4kAONQTZZJbg419As=;
        b=TzngEn52o2M3Abb0R22xedesh8zKkNUqCaF1jrnrkfQxuNnckbk+cYLcFbsaoggrc0
         hbYBsQ8KYaInU23NOGxOvlG77/AQWm5ZXvyo2EZ58aXnuY7seuN0jf82rvM6uSQifge1
         l/9bbgPp7bD2+ev80wqLIew9wSV8GA9H8HNYQkzV2Mj6ME9bnrsq4TvEBG0g8vfNCP0y
         LTcghxmkHs3d/efVsCnWw5X9ehEp7EnC53k1zGg99YHnjQaxlZdOsEpooPrPkZz43gam
         McRX46pIpMoYi7D3eOl5NdNsCG4ECrIzDOzps/gifOgXqJJsJr6YUY7fyna9eQK0oFFW
         FzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715006980; x=1715611780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVbZDFfLK9GlBOKzZLEG1i0oNm4kAONQTZZJbg419As=;
        b=Umm1/xfFdSxH4AYGzDj5rXgHpZKNEoIWKRVWDG05gaxPDm4mj04J+FNHB8cOHriFg+
         kjo7KpD+KOhSEse0ry8d/73xzYOI1FlwIbFjOgdbw0smewC8NAB/J8lfguBgL9/BBsFd
         PO97y9MepNZazEBHHuUvfYz5ijjxNNOu5gDpD3Ze8x6MEWseB0ldFERjQ6BrRhldZkbM
         VY4UQqje7BtW0yG/nEH05ZLVgNe+TWe8zOG6sJiSoZ0VNhEEwQDcglWjvRw7CQFvFU4V
         2og3nivCDwstG/1YUm6zV/UD3KuDVLsosGc1G0hI5fi7hlj1QKOfQ3SgZQDeL1Umf8vS
         QDZw==
X-Forwarded-Encrypted: i=1; AJvYcCWcIlkkGa51eW8KzR+3fVpe/QN4fG+hWfaH53alUV5HXWKSf4o0NVJW6K8W7aglwXNzd2cOw4FA8kAuYHLWtKJ+bUAlFEFTqGhMjxx2O6X0rbukXafB2+2SUVJPL01U7L/vyy4Q1lFoMBWG2NrpHQH9bIeGv0nitEjZaDDRoSn2g7vDTwoKzJdz+WYEOeudDOyadudYYlHB
X-Gm-Message-State: AOJu0YwuncSwB8UzBlMZVBJZtoVDAXFgQHg71tzUz+25MEsyzVVTAaZT
	ZEplEhWuRyJsvQ8i9fa7LQTMmUCQqWcSH25odXPo/J8cWwx95R3T
X-Google-Smtp-Source: AGHT+IGl7zXDr9leH/q9qrgTMzgAy+NEDD71IXcy8Lrko6LQCqNtY1rqNwlvt41J2VWHV4ujK6Ftiw==
X-Received: by 2002:a05:600c:19cc:b0:41c:15d:98ac with SMTP id u12-20020a05600c19cc00b0041c015d98acmr8128552wmq.11.1715006979612;
        Mon, 06 May 2024 07:49:39 -0700 (PDT)
Received: from vitor-nb.. ([2001:8a0:e622:f700:5a5f:df46:89e1:5068])
        by smtp.gmail.com with ESMTPSA id g19-20020a05600c311300b0041496734318sm20134756wmo.24.2024.05.06.07.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 07:49:39 -0700 (PDT)
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
Subject: [PATCH v4] can: mcp251xfd: fix infinite loop when xmit fails
Date: Mon,  6 May 2024 15:49:18 +0100
Message-Id: <20240506144918.419536-1-ivitro@gmail.com>
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

This patch resolves the issue by decreasing tx_ring->head and removing
the skb from the echo stack if mcp251xfd_start_xmit() fails.
Consequently, the package is dropped not been possible to re-transmit.

Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
Cc: stable@vger.kernel.org
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
With this approach, some packages get lost in concurrent SPI bus access
due to can_put_echo_skb() being called before mcp251xfd_tx_obj_write().
The can_put_echo_skb() calls can_create_echo_skb() that consumes the original skb
resulting in a Kernel NULL pointer dereference error if return NETDEV_TX_BUSY on
mcp251xfd_tx_obj_write() failure.
A potential solution would be to change the code to use spi_sync(), which would
wait for SPI bus to be unlocked. Any thoughts about this?

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

 drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c | 26 ++++++++++++++------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
index 160528d3cc26..9909e23de7b9 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
@@ -166,11 +166,12 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 				 struct net_device *ndev)
 {
 	struct mcp251xfd_priv *priv = netdev_priv(ndev);
+	struct net_device_stats *stats = &ndev->stats;
 	struct mcp251xfd_tx_ring *tx_ring = priv->tx;
 	struct mcp251xfd_tx_obj *tx_obj;
 	unsigned int frame_len;
+	int err, echo_err;
 	u8 tx_head;
-	int err;
 
 	if (can_dev_dropped_skb(ndev, skb))
 		return NETDEV_TX_OK;
@@ -188,18 +189,27 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 		netif_stop_queue(ndev);
 
 	frame_len = can_skb_get_frame_len(skb);
-	err = can_put_echo_skb(skb, ndev, tx_head, frame_len);
-	if (!err)
+	echo_err = can_put_echo_skb(skb, ndev, tx_head, frame_len);
+	if (!echo_err)
 		netdev_sent_queue(priv->ndev, frame_len);
 
 	err = mcp251xfd_tx_obj_write(priv, tx_obj);
-	if (err)
-		goto out_err;
+	if (err) {
+		tx_ring->head--;
 
-	return NETDEV_TX_OK;
+		if (!echo_err) {
+			can_free_echo_skb(ndev, tx_head, &frame_len);
+			netdev_completed_queue(ndev, 1, frame_len);
+		}
+
+		if (mcp251xfd_get_tx_free(tx_ring))
+			netif_wake_queue(ndev);
 
- out_err:
-	netdev_err(priv->ndev, "ERROR in %s: %d\n", __func__, err);
+		stats->tx_dropped++;
+		if (net_ratelimit())
+			netdev_err(priv->ndev,
+				   "ERROR in %s: %d\n", __func__, err);
+	}
 
 	return NETDEV_TX_OK;
 }
-- 
2.34.1


