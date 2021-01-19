Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD3E2FBC66
	for <lists+linux-can@lfdr.de>; Tue, 19 Jan 2021 17:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbhASQ2N (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jan 2021 11:28:13 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:22180 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729498AbhASQ2A (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jan 2021 11:28:00 -0500
Received: from tomoyo.flets-east.jp ([153.202.107.157])
        by mwinf5d12 with ME
        id JgS9240013PnFJp03gSCtF; Tue, 19 Jan 2021 17:26:15 +0100
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Jan 2021 17:26:15 +0100
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Loris Fauster <loris.fauster@ttcontrol.com>,
        Alejandro Concepcion Rodriguez <alejandro@acoro.eu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 2/3] can: vxcan: vxcan_xmit: fix use after free bug
Date:   Wed, 20 Jan 2021 01:25:11 +0900
Message-Id: <20210119162512.5236-3-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210119162512.5236-1-mailhol.vincent@wanadoo.fr>
References: <20210119162512.5236-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

After calling netif_rx_ni(skb), dereferencing skb is unsafe.
Especially, the canfd_frame cfd which aliases skb memory is accessed
after the netif_rx_ni().

fixes: a8f820a380a2 ("can: add Virtual CAN Tunnel driver (vxcan)")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/vxcan.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index fa47bab510bb..a525ef8d19b0 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -39,6 +39,7 @@ static netdev_tx_t vxcan_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct net_device *peer;
 	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 	struct net_device_stats *peerstats, *srcstats = &dev->stats;
+	u8 len;
 
 	if (can_dropped_invalid_skb(dev, skb))
 		return NETDEV_TX_OK;
@@ -61,12 +62,13 @@ static netdev_tx_t vxcan_xmit(struct sk_buff *skb, struct net_device *dev)
 	skb->dev        = peer;
 	skb->ip_summed  = CHECKSUM_UNNECESSARY;
 
+	u8 len = cfd->len;
 	if (netif_rx_ni(skb) == NET_RX_SUCCESS) {
 		srcstats->tx_packets++;
-		srcstats->tx_bytes += cfd->len;
+		srcstats->tx_bytes += len;
 		peerstats = &peer->stats;
 		peerstats->rx_packets++;
-		peerstats->rx_bytes += cfd->len;
+		peerstats->rx_bytes += len;
 	}
 
 out_unlock:
-- 
2.26.2

