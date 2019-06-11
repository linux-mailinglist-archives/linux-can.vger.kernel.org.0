Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9F53CC13
	for <lists+linux-can@lfdr.de>; Tue, 11 Jun 2019 14:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387802AbfFKMsY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 Jun 2019 08:48:24 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46789 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388429AbfFKMsY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Jun 2019 08:48:24 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCH-0006En-Mx; Tue, 11 Jun 2019 14:48:17 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCG-0005R7-N5; Tue, 11 Jun 2019 14:48:16 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 09/16] j1939: don't store msg_flags on the TX path
Date:   Tue, 11 Jun 2019 14:48:07 +0200
Message-Id: <20190611124814.19908-10-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611124814.19908-1-o.rempel@pengutronix.de>
References: <20190611124814.19908-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

We do not actually use them.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/socket.c    | 1 -
 net/can/j1939/transport.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index cb5978b4146c..68d5894f9e33 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -813,7 +813,6 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
 	memset(skcb, 0, sizeof(*skcb));
 	skcb->addr = jsk->addr;
 	skcb->priority = j1939_prio(sk->sk_priority);
-	skcb->msg_flags = msg->msg_flags;
 
 	if (msg->msg_name) {
 		struct sockaddr_can *addr = msg->msg_name;
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 9ca01d1130d5..1750377ece3f 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1519,7 +1519,6 @@ struct j1939_session *j1939_tp_send(struct j1939_priv *priv,
 		session->pkt.last = session->pkt.total;
 
 	session->tskey = session->sk->sk_tskey++;
-	session->skcb.msg_flags |= MSG_DONTWAIT;
 
 	return session;
 }
-- 
2.20.1

