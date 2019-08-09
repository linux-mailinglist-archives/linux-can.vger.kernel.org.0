Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF8E8744D
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2019 10:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405940AbfHIIgG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 9 Aug 2019 04:36:06 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48253 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405668AbfHIIgF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Aug 2019 04:36:05 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NU-00059A-Ih; Fri, 09 Aug 2019 10:36:00 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NO-0004Ph-Mh; Fri, 09 Aug 2019 10:35:54 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 10/21] j1939: j1939_sk_errqueue: add some debug
Date:   Fri,  9 Aug 2019 10:35:42 +0200
Message-Id: <20190809083553.16687-11-o.rempel@pengutronix.de>
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
 net/can/j1939/socket.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 8e236336a346..7de4e6decbf3 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -875,6 +875,7 @@ void j1939_sk_errqueue(struct j1939_session *session,
 	struct j1939_sock *jsk;
 	struct sock_exterr_skb *serr;
 	struct sk_buff *skb;
+	char *state = "UNK";
 	int err;
 
 	/* currently we have no sk for the RX session */
@@ -904,6 +905,7 @@ void j1939_sk_errqueue(struct j1939_session *session,
 		serr->ee.ee_errno = ENOMSG;
 		serr->ee.ee_origin = SO_EE_ORIGIN_TIMESTAMPING;
 		serr->ee.ee_info = SCM_TSTAMP_ACK;
+		state = "ACK";
 		break;
 	case J1939_ERRQUEUE_SCHED:
 		if (!(sk->sk_tsflags & SOF_TIMESTAMPING_TX_SCHED))
@@ -912,11 +914,13 @@ void j1939_sk_errqueue(struct j1939_session *session,
 		serr->ee.ee_errno = ENOMSG;
 		serr->ee.ee_origin = SO_EE_ORIGIN_TIMESTAMPING;
 		serr->ee.ee_info = SCM_TSTAMP_SCHED;
+		state = "SCH";
 		break;
 	case J1939_ERRQUEUE_ABORT:
 		serr->ee.ee_errno = session->err;
 		serr->ee.ee_origin = SO_EE_ORIGIN_LOCAL;
 		serr->ee.ee_info = J1939_EE_INFO_TX_ABORT;
+		state = "ABT";
 		break;
 	default:
 		netdev_err(priv->ndev, "Unknown errqueue type %i\n", type);
@@ -926,6 +930,7 @@ void j1939_sk_errqueue(struct j1939_session *session,
 	if (sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)
 		serr->ee.ee_data = session->tskey;
 
+	netdev_dbg(session->priv->ndev, "%s: 0x%p tskey: %i, state: %s\n", __func__, session, session->tskey, state);
 	err = sock_queue_err_skb(sk, skb);
 
 	if (err)
-- 
2.20.1

