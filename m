Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B2B2448A3
	for <lists+linux-can@lfdr.de>; Fri, 14 Aug 2020 13:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgHNLEm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 Aug 2020 07:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgHNLEh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 Aug 2020 07:04:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC757C061389
        for <linux-can@vger.kernel.org>; Fri, 14 Aug 2020 04:04:36 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1k6XVh-00040D-Hq; Fri, 14 Aug 2020 13:04:33 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6/6] can: j1939: transport: j1939_xtp_rx_dat_one(): compare own packets to detect corruptions
Date:   Fri, 14 Aug 2020 13:04:28 +0200
Message-Id: <20200814110428.405051-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200814110428.405051-1-mkl@pengutronix.de>
References: <20200814110428.405051-1-mkl@pengutronix.de>
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

From: Oleksij Rempel <o.rempel@pengutronix.de>

Since the stack relays on receiving own packets, it was overwriting own
transmit buffer from received packets.

At least theoretically, the received echo buffer can be corrupt or
changed and the session partner can request to resend previous data. In
this case we will re-send bad data.

With this patch we will stop to overwrite own TX buffer and use it for
sanity checking.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://lore.kernel.org/r/20200807105200.26441-6-o.rempel@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/transport.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 90a2baac8a4a..5cf107cb447c 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1792,7 +1792,20 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
 	}
 
 	tpdat = se_skb->data;
-	memcpy(&tpdat[offset], &dat[1], nbytes);
+	if (!session->transmission) {
+		memcpy(&tpdat[offset], &dat[1], nbytes);
+	} else {
+		int err;
+
+		err = memcmp(&tpdat[offset], &dat[1], nbytes);
+		if (err)
+			netdev_err_once(priv->ndev,
+					"%s: 0x%p: Data of RX-looped back packet (%*ph) doesn't match TX data (%*ph)!\n",
+					__func__, session,
+					nbytes, &dat[1],
+					nbytes, &tpdat[offset]);
+	}
+
 	if (packet == session->pkt.rx)
 		session->pkt.rx++;
 
-- 
2.28.0

