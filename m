Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CF42FBC67
	for <lists+linux-can@lfdr.de>; Tue, 19 Jan 2021 17:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbhASQ2R (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jan 2021 11:28:17 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:43967 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbhASQ2M (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jan 2021 11:28:12 -0500
Received: from tomoyo.flets-east.jp ([153.202.107.157])
        by mwinf5d12 with ME
        id JgSN2400V3PnFJp03gSSvz; Tue, 19 Jan 2021 17:26:29 +0100
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Jan 2021 17:26:29 +0100
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
Subject: [PATCH 3/3] can: peak_usb: fix use after free bugs
Date:   Wed, 20 Jan 2021 01:25:12 +0900
Message-Id: <20210119162512.5236-4-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210119162512.5236-1-mailhol.vincent@wanadoo.fr>
References: <20210119162512.5236-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

After calling peak_usb_netif_rx_ni(skb), dereferencing skb is unsafe.
Especially, the can_frame cf which aliases skb memory is accessed
after the peak_usb_netif_rx_ni().

Reordering the lines solves the issue.

fixes: 0a25e1f4f185 ("can: peak_usb: add support for PEAK new CANFD USB adapters")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 61631f4fd92a..f347ecc79aef 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -514,11 +514,11 @@ static int pcan_usb_fd_decode_canmsg(struct pcan_usb_fd_if *usb_if,
 	else
 		memcpy(cfd->data, rm->d, cfd->len);
 
-	peak_usb_netif_rx(skb, &usb_if->time_ref, le32_to_cpu(rm->ts_low));
-
 	netdev->stats.rx_packets++;
 	netdev->stats.rx_bytes += cfd->len;
 
+	peak_usb_netif_rx(skb, &usb_if->time_ref, le32_to_cpu(rm->ts_low));
+
 	return 0;
 }
 
@@ -580,11 +580,11 @@ static int pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
 	if (!skb)
 		return -ENOMEM;
 
-	peak_usb_netif_rx(skb, &usb_if->time_ref, le32_to_cpu(sm->ts_low));
-
 	netdev->stats.rx_packets++;
 	netdev->stats.rx_bytes += cf->len;
 
+	peak_usb_netif_rx(skb, &usb_if->time_ref, le32_to_cpu(sm->ts_low));
+
 	return 0;
 }
 
-- 
2.26.2

