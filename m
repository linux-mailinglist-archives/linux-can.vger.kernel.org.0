Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573EC460629
	for <lists+linux-can@lfdr.de>; Sun, 28 Nov 2021 13:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357547AbhK1Mnc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 28 Nov 2021 07:43:32 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:58960 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357411AbhK1Mlc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 28 Nov 2021 07:41:32 -0500
Received: from tomoyo.flets-east.jp ([114.149.34.46])
        by smtp.orange.fr with ESMTPA
        id rJR2meSen2lVYrJRcmr5RK; Sun, 28 Nov 2021 13:38:15 +0100
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: MDU0YmViZGZmMDIzYiBlMiM2NTczNTRjNWZkZTMwOGRiOGQ4ODf3NWI1ZTMyMzdiODlhOQ==
X-ME-Date: Sun, 28 Nov 2021 13:38:15 +0100
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v3 2/5] can: kvaser_usb: do not increase tx statistics when sending error message frames
Date:   Sun, 28 Nov 2021 21:37:31 +0900
Message-Id: <20211128123734.1049786-3-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211128123734.1049786-1-mailhol.vincent@wanadoo.fr>
References: <20211128123734.1049786-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The CAN error message frames (i.e. error skb) are an interface
specific to socket CAN. The payload of the CAN error message frames
does not correspond to any actual data sent on the wire. Only an error
flag and a delimiter are transmitted when an error occurs (c.f. ISO
11898-1 section 10.4.4.2 "Error flag").

For this reason, it makes no sense to increment the tx_packets and
tx_bytes fields of struct net_device_stats when sending an error
message frame because no actual payload will be transmitted on the
wire.

N.B. Sending error message frames is a very specific feature which, at
the moment, is only supported by the Kvaser Hydra hardware. Please
refer to [1] for more details on the topic.

[1] https://lore.kernel.org/linux-can/CAMZ6RqK0rTNg3u3mBpZOoY51jLZ-et-J01tY6-+mWsM4meVw-A@mail.gmail.com/t/#u

CC: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 3398da323126..32fe352dabeb 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -1111,8 +1111,10 @@ static void kvaser_usb_hydra_tx_acknowledge(const struct kvaser_usb *dev,
 {
 	struct kvaser_usb_tx_urb_context *context;
 	struct kvaser_usb_net_priv *priv;
+	struct can_frame *cf;
 	unsigned long irq_flags;
-	bool one_shot_fail = false;
+	int len;
+	bool one_shot_fail = false, is_err_frame = false;
 	u16 transid = kvaser_usb_hydra_get_cmd_transid(cmd);
 
 	priv = kvaser_usb_hydra_net_priv_from_cmd(dev, cmd);
@@ -1134,21 +1136,27 @@ static void kvaser_usb_hydra_tx_acknowledge(const struct kvaser_usb *dev,
 	}
 
 	context = &priv->tx_contexts[transid % dev->max_tx_urbs];
-	if (!one_shot_fail) {
-		struct net_device_stats *stats = &priv->netdev->stats;
-
-		stats->tx_packets++;
-		stats->tx_bytes += can_fd_dlc2len(context->dlc);
-	}
+	len = context->dlc;
 
 	spin_lock_irqsave(&priv->tx_contexts_lock, irq_flags);
 
+	cf = (struct can_frame *)priv->can.echo_skb[context->echo_index]->data;
+	if (cf)
+		is_err_frame = !!(cf->can_id & CAN_RTR_FLAG);
+
 	can_get_echo_skb(priv->netdev, context->echo_index, NULL);
 	context->echo_index = dev->max_tx_urbs;
 	--priv->active_tx_contexts;
 	netif_wake_queue(priv->netdev);
 
 	spin_unlock_irqrestore(&priv->tx_contexts_lock, irq_flags);
+
+	if (!one_shot_fail && !is_err_frame) {
+		struct net_device_stats *stats = &priv->netdev->stats;
+
+		stats->tx_packets++;
+		stats->tx_bytes += len;
+	}
 }
 
 static void kvaser_usb_hydra_rx_msg_std(const struct kvaser_usb *dev,
-- 
2.32.0

