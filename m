Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFDE46FC86
	for <lists+linux-can@lfdr.de>; Fri, 10 Dec 2021 09:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbhLJIWa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 10 Dec 2021 03:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhLJIWa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 10 Dec 2021 03:22:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BC5C061746
        for <linux-can@vger.kernel.org>; Fri, 10 Dec 2021 00:18:55 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mvb7F-0005vP-4q
        for linux-can@vger.kernel.org; Fri, 10 Dec 2021 09:18:53 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 469306C11D0
        for <linux-can@vger.kernel.org>; Fri, 10 Dec 2021 08:18:52 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id D06E06C11CD;
        Fri, 10 Dec 2021 08:18:51 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 96580d97;
        Fri, 10 Dec 2021 08:18:51 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH] fixup! can: do not increase tx_bytes statistics for RTR frames
Date:   Fri, 10 Dec 2021 09:18:49 +0100
Message-Id: <20211210081849.358365-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

I'm going to squash this into Vincent's last patch of the series:

[1] https://lore.kernel.org/all/20211207121531.42941-6-mailhol.vincent@wanadoo.fr

Marc

 drivers/net/can/grcan.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 1b8ef97e4139..d0c5a7a60daf 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -255,7 +255,6 @@ struct grcan_priv {
 	struct grcan_dma dma;
 
 	struct sk_buff **echo_skb;	/* We allocate this on our own */
-	u8 *txdlc;			/* Length of queued frames */
 
 	/* The echo skb pointer, pointing into echo_skb and indicating which
 	 * frames can be echoed back. See the "Notes on the tx cyclic buffer
@@ -515,9 +514,7 @@ static int catch_up_echo_skb(struct net_device *dev, int budget, bool echo)
 		if (echo) {
 			/* Normal echo of messages */
 			stats->tx_packets++;
-			stats->tx_bytes += priv->txdlc[i];
-			priv->txdlc[i] = 0;
-			can_get_echo_skb(dev, i, NULL);
+			stats->tx_bytes += can_get_echo_skb(dev, i, NULL);
 		} else {
 			/* For cleanup of untransmitted messages */
 			can_free_echo_skb(dev, i, NULL);
@@ -1062,16 +1059,10 @@ static int grcan_open(struct net_device *dev)
 	priv->can.echo_skb_max = dma->tx.size;
 	priv->can.echo_skb = priv->echo_skb;
 
-	priv->txdlc = kcalloc(dma->tx.size, sizeof(*priv->txdlc), GFP_KERNEL);
-	if (!priv->txdlc) {
-		err = -ENOMEM;
-		goto exit_free_echo_skb;
-	}
-
 	/* Get can device up */
 	err = open_candev(dev);
 	if (err)
-		goto exit_free_txdlc;
+		goto exit_free_echo_skb;
 
 	err = request_irq(dev->irq, grcan_interrupt, IRQF_SHARED,
 			  dev->name, dev);
@@ -1093,8 +1084,6 @@ static int grcan_open(struct net_device *dev)
 
 exit_close_candev:
 	close_candev(dev);
-exit_free_txdlc:
-	kfree(priv->txdlc);
 exit_free_echo_skb:
 	kfree(priv->echo_skb);
 exit_free_dma_buffers:
@@ -1129,7 +1118,6 @@ static int grcan_close(struct net_device *dev)
 	priv->can.echo_skb_max = 0;
 	priv->can.echo_skb = NULL;
 	kfree(priv->echo_skb);
-	kfree(priv->txdlc);
 
 	return 0;
 }
@@ -1447,7 +1435,6 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	 * can_put_echo_skb would be an error unless other measures are
 	 * taken.
 	 */
-	priv->txdlc[slotindex] = cf->len; /* Store dlc for statistics */
 	can_put_echo_skb(skb, dev, slotindex, 0);
 
 	/* Make sure everything is written before allowing hardware to
-- 
2.33.0


