Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9CE292E19
	for <lists+linux-can@lfdr.de>; Mon, 19 Oct 2020 21:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbgJSTFe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Oct 2020 15:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730945AbgJSTFe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Oct 2020 15:05:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28F4C0613CE
        for <linux-can@vger.kernel.org>; Mon, 19 Oct 2020 12:05:33 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kUaTL-0005v5-Ro; Mon, 19 Oct 2020 21:05:31 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-rfc 03/16] can: dev: can_get_echo_skb(): prevent call to kfree_skb() in hard IRQ context
Date:   Mon, 19 Oct 2020 21:05:11 +0200
Message-Id: <20201019190524.1285319-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019190524.1285319-1-mkl@pengutronix.de>
References: <20201019190524.1285319-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

If a driver calls can_get_echo_skb() during a hardware IRQ (which is often, but
not always, the case), the 'WARN_ON(in_irq)' in
net/core/skbuff.c#skb_release_head_state() might be triggered, under network
congestion circumstances, together with the potential risk of a NULL pointer
dereference.

The root cause of this issue is the call to kfree_skb() instead of
dev_kfree_skb_irq() in net/core/dev.c#enqueue_to_backlog().

This patch prevents the skb to be freed within the call to netif_rx() by
incrementing its reference count with skb_get(). The skb is finally freed by
one of the in-irq-context safe functions: dev_consume_skb_any() or
dev_kfree_skb_any(). The "any" version is used because some drivers might call
can_get_echo_skb() in a normal context.

The reason for this issue to occur is that initially, in the core network
stack, loopback skb were not supposed to be received in hardware IRQ context.
The CAN stack is an exeption.

This bug was previously reported back in 2017 in [1] but the proposed patch
never got accepted.

While [1] directly modifies net/core/dev.c, we try to propose here a
smoother modification local to CAN network stack (the assumption
behind is that only CAN devices are affected by this issue).

[1] http://lore.kernel.org/r/57a3ffb6-3309-3ad5-5a34-e93c3fe3614d@cetitec.com

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/r/20201002154219.4887-2-mailhol.vincent@wanadoo.fr
Fixes: 39549eef3587 ("can: CAN Network device driver and Netlink interface")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index b70ded3760f2..73cfcd7e9517 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -538,7 +538,11 @@ unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx)
 	if (!skb)
 		return 0;
 
-	netif_rx(skb);
+	skb_get(skb);
+	if (netif_rx(skb) == NET_RX_SUCCESS)
+		dev_consume_skb_any(skb);
+	else
+		dev_kfree_skb_any(skb);
 
 	return len;
 }
-- 
2.28.0

