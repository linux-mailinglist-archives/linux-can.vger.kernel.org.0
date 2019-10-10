Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A52A1D2950
	for <lists+linux-can@lfdr.de>; Thu, 10 Oct 2019 14:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387503AbfJJMSg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 10 Oct 2019 08:18:36 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34193 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387505AbfJJMSJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Oct 2019 08:18:09 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iIXOP-0006Lw-2Y; Thu, 10 Oct 2019 14:18:05 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Cc:     davem@davemloft.net, kernel@pengutronix.de,
        jhofstee@victronenergy.com,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-stable <stable@vger.kernel.org>
Subject: [PATCH 12/29] can: rx-offload: can_rx_offload_queue_sorted(): fix error handling, avoid skb mem leak
Date:   Thu, 10 Oct 2019 14:17:33 +0200
Message-Id: <20191010121750.27237-13-mkl@pengutronix.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010121750.27237-1-mkl@pengutronix.de>
References: <20191010121750.27237-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

If the rx-offload skb_queue is full can_rx_offload_queue_sorted() will
not queue the skb and return with an error.

None of the callers of this function, issue a kfree_skb() to free the
not queued skb. This results in a memory leak.

This patch fixes the problem by freeing the skb in case of a full queue.
The return value is adjusted to -ENOBUFS to better reflect the actual
problem.

The device stats handling is left to the callers, as this function
mightbe used in both the rx and tx path.

Fixes: 55059f2b7f86 ("can: rx-offload: introduce can_rx_offload_get_echo_skb() and can_rx_offload_queue_sorted() functions")
Cc: linux-stable <stable@vger.kernel.org>
Cc: Martin Hundebøll <martin@geanix.com>
Reported-by: Martin Hundebøll <martin@geanix.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rx-offload.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index e6a668ee7730..663697439d1c 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -207,8 +207,10 @@ int can_rx_offload_queue_sorted(struct can_rx_offload *offload,
 	unsigned long flags;
 
 	if (skb_queue_len(&offload->skb_queue) >
-	    offload->skb_queue_len_max)
-		return -ENOMEM;
+	    offload->skb_queue_len_max) {
+		kfree_skb(skb);
+		return -ENOBUFS;
+	}
 
 	cb = can_rx_offload_get_cb(skb);
 	cb->timestamp = timestamp;
-- 
2.23.0

