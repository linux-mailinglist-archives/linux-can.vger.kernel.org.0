Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4352D57A8
	for <lists+linux-can@lfdr.de>; Thu, 10 Dec 2020 10:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgLJJ4K (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 10 Dec 2020 04:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgLJJz5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Dec 2020 04:55:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22717C06179C
        for <linux-can@vger.kernel.org>; Thu, 10 Dec 2020 01:55:17 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1knIfL-0000yA-PI
        for linux-can@vger.kernel.org; Thu, 10 Dec 2020 10:55:15 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 1540A5AA1B8
        for <linux-can@vger.kernel.org>; Thu, 10 Dec 2020 09:55:12 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 250255AA197;
        Thu, 10 Dec 2020 09:55:09 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 89c14679;
        Thu, 10 Dec 2020 09:55:08 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Antonio Quartulli <a@unstable.cc>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next 2/7] can: rx-offload: can_rx_offload_offload_one(): avoid double unlikely() notation when using IS_ERR()
Date:   Thu, 10 Dec 2020 10:55:02 +0100
Message-Id: <20201210095507.1551220-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210095507.1551220-1-mkl@pengutronix.de>
References: <20201210095507.1551220-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Antonio Quartulli <a@unstable.cc>

The definition of IS_ERR() already applies the unlikely() notation when
checking the error status of the passed pointer. For this reason there is no
need to have the same notation outside of IS_ERR() itself.

Clean up code by removing redundant notation.

Signed-off-by: Antonio Quartulli <a@unstable.cc>
Link: https://lore.kernel.org/r/20201210085321.18693-1-a@unstable.cc
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rx-offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index 450c5cfcb3fc..3c1912c0430b 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -157,7 +157,7 @@ can_rx_offload_offload_one(struct can_rx_offload *offload, unsigned int n)
 	/* There was a problem reading the mailbox, propagate
 	 * error value.
 	 */
-	if (unlikely(IS_ERR(skb))) {
+	if (IS_ERR(skb)) {
 		offload->dev->stats.rx_dropped++;
 		offload->dev->stats.rx_fifo_errors++;
 
-- 
2.29.2


