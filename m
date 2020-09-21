Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AED82725DA
	for <lists+linux-can@lfdr.de>; Mon, 21 Sep 2020 15:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIUNiy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Sep 2020 09:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbgIUNix (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Sep 2020 09:38:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA1EC0613D7
        for <linux-can@vger.kernel.org>; Mon, 21 Sep 2020 06:38:52 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kKM1q-0000ox-Uw; Mon, 21 Sep 2020 15:38:51 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 10/38] can: dev: can_put_echo_skb(): print number of echo_skb that is occupied
Date:   Mon, 21 Sep 2020 15:38:17 +0200
Message-Id: <20200921133845.2249271-11-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921133845.2249271-1-mkl@pengutronix.de>
References: <20200921133845.2249271-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch prints the number of the occupied echo_skb, to ease
implementing and debugging of new drivers.

Link: https://lore.kernel.org/r/20200915223527.1417033-11-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 68834a2853c9..dd443e5d8cb7 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -463,7 +463,7 @@ void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 		priv->echo_skb[idx] = skb;
 	} else {
 		/* locking problem with netif_stop_queue() ?? */
-		netdev_err(dev, "%s: BUG! echo_skb is occupied!\n", __func__);
+		netdev_err(dev, "%s: BUG! echo_skb %d is occupied!\n", __func__, idx);
 		kfree_skb(skb);
 	}
 }
-- 
2.28.0

