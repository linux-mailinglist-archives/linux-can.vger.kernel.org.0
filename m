Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 926C98745A
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2019 10:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405690AbfHIIid (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 9 Aug 2019 04:38:33 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47829 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfHIIic (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Aug 2019 04:38:32 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NQ-000592-IG; Fri, 09 Aug 2019 10:35:56 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NO-0004Oe-G6; Fri, 09 Aug 2019 10:35:54 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 03/21] j1939: make J1939_ERRQUEUE_SCHED/ACK optional again.
Date:   Fri,  9 Aug 2019 10:35:35 +0200
Message-Id: <20190809083553.16687-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809083553.16687-1-o.rempel@pengutronix.de>
References: <20190809083553.16687-1-o.rempel@pengutronix.de>
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

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/socket.c    | 7 ++++++-
 net/can/j1939/transport.c | 1 -
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 3c1b3c0ec18f..da93afee1d0a 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -811,7 +811,6 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
 	ret = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (ret < 0)
 		goto free_skb;
-	sock_tx_timestamp(sk, skb->sk->sk_tsflags, &skb_shinfo(skb)->tx_flags);
 
 	skb->dev = ndev;
 
@@ -901,11 +900,17 @@ void j1939_sk_errqueue(struct j1939_session *session,
 	memset(serr, 0, sizeof(*serr));
 	switch (type) {
 	case J1939_ERRQUEUE_ACK:
+		if (!(sk->sk_tsflags & SOF_TIMESTAMPING_TX_ACK))
+			return;
+
 		serr->ee.ee_errno = ENOMSG;
 		serr->ee.ee_origin = SO_EE_ORIGIN_TIMESTAMPING;
 		serr->ee.ee_info = SCM_TSTAMP_ACK;
 		break;
 	case J1939_ERRQUEUE_SCHED:
+		if (!(sk->sk_tsflags & SOF_TIMESTAMPING_TX_SCHED))
+			return;
+
 		serr->ee.ee_errno = ENOMSG;
 		serr->ee.ee_origin = SO_EE_ORIGIN_TIMESTAMPING;
 		serr->ee.ee_info = SCM_TSTAMP_SCHED;
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 4d285a92bd41..c2573d0f0721 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1004,7 +1004,6 @@ static int j1939_simple_txnext(struct j1939_session *session)
 		return -ENOMEM;
 
 	can_skb_set_owner(skb, se_skb->sk);
-	skb_shinfo(skb)->tx_flags &= ~SKBTX_ANY_TSTAMP;
 
 	j1939_tp_set_rxtimeout(session,
 			       J1939_XTP_ABORT_TIMEOUT_MS);
-- 
2.20.1

