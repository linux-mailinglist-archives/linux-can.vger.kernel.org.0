Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9D4F02F8
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2019 17:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390404AbfKEQdN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 5 Nov 2019 11:33:13 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33631 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390372AbfKEQcs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Nov 2019 11:32:48 -0500
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iS1l6-0002Hp-4n; Tue, 05 Nov 2019 17:32:44 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 16/33] can: rx-offload: can_rx_offload_offload_one(): increment rx_fifo_errors on queue overflow or OOM
Date:   Tue,  5 Nov 2019 17:31:58 +0100
Message-Id: <20191105163215.30194-17-mkl@pengutronix.de>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191105163215.30194-1-mkl@pengutronix.de>
References: <20191105163215.30194-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

If the rx-offload skb_queue is full or the skb allocation fails (due to OOM),
the mailbox contents is discarded.

This patch adds the incrementing of the rx_fifo_errors statistics counter.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rx-offload.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index bdc27481b57f..e224530a0630 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -125,8 +125,10 @@ static struct sk_buff *can_rx_offload_offload_one(struct can_rx_offload *offload
 
 		ret = offload->mailbox_read(offload, &cf_overflow,
 					    &timestamp, n);
-		if (ret)
+		if (ret) {
 			offload->dev->stats.rx_dropped++;
+			offload->dev->stats.rx_fifo_errors++;
+		}
 
 		return NULL;
 	}
-- 
2.24.0.rc1

