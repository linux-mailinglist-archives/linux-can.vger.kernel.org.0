Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83842179DA
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2019 15:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfEHNFW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 May 2019 09:05:22 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58467 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfEHNFW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 May 2019 09:05:22 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hOMG7-0005R9-BH; Wed, 08 May 2019 15:05:19 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92-RC6)
        (envelope-from <ore@pengutronix.de>)
        id 1hOMG6-0004rK-CZ; Wed, 08 May 2019 15:05:18 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v3 2/3] j1939: add MSG_ERRQUEUE support
Date:   Wed,  8 May 2019 15:05:15 +0200
Message-Id: <20190508130516.3954-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190508130516.3954-1-o.rempel@pengutronix.de>
References: <20190508130516.3954-1-o.rempel@pengutronix.de>
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

Add optional error queue support. If enabled, user space will be able to
get different notifications about session state with time stamps,
statistics and error value (if present).

All information is send as CMSG.
Session statistic is done in the netlink way and can be extended without
breaking support for old software.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/uapi/linux/can/j1939.h |  12 ++++
 net/can/j1939/j1939-priv.h     |  11 ++++
 net/can/j1939/socket.c         | 100 ++++++++++++++++++++++++++++++++-
 net/can/j1939/transport.c      |   7 +++
 4 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/can/j1939.h b/include/uapi/linux/can/j1939.h
index c7eb94d2ab10..603ce1394ebb 100644
--- a/include/uapi/linux/can/j1939.h
+++ b/include/uapi/linux/can/j1939.h
@@ -66,12 +66,24 @@ enum {
 	SO_J1939_PROMISC = 2,	/* set/clr promiscuous mode */
 	SO_J1939_RECV_OWN = 3,
 	SO_J1939_SEND_PRIO = 4,
+	SO_J1939_ERRQUEUE = 5,
 };
 
 enum {
 	SCM_J1939_DEST_ADDR = 1,
 	SCM_J1939_DEST_NAME = 2,
 	SCM_J1939_PRIO = 3,
+	SCM_J1939_ERRQUEUE = 4,
+};
+
+enum {
+	J1939_NLA_PAD,
+	J1939_NLA_BYTES_ACKED,
+};
+
+enum {
+	J1939_EE_INFO_NONE,
+	J1939_EE_INFO_TX_ABORT,
 };
 
 struct j1939_filter {
diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index ff59301c9dc3..a3df43919505 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -10,6 +10,14 @@
 
 /* TODO: return ENETRESET on busoff. */
 
+struct j1939_session;
+
+enum j1939_sk_errqueue_type {
+	J1939_ERRQUEUE_ACK,
+	J1939_ERRQUEUE_SCHED,
+	J1939_ERRQUEUE_ABORT,
+};
+
 /* j1939 devices */
 struct j1939_ecu {
 	struct list_head list;
@@ -152,6 +160,8 @@ int j1939_send_one(struct j1939_priv *priv, struct sk_buff *skb);
 void j1939_sk_recv(struct j1939_priv *priv, struct sk_buff *skb);
 void j1939_sk_send_multi_abort(struct j1939_priv *priv, struct sock *sk,
 			       int err);
+void j1939_sk_errqueue(struct j1939_session *session,
+		       enum j1939_sk_errqueue_type type);
 
 /* stack entries */
 struct j1939_session *j1939_tp_send(struct j1939_priv *priv,
@@ -208,6 +218,7 @@ struct j1939_session {
 	bool extd;
 	unsigned int total_message_size; /* Total message size, number of bytes */
 	int err;
+	u32 tskey;
 
 	/* Packets counters for a (extended) transfer session. The packet is
 	 * maximal of 7 bytes. */
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index ea9ce6d99332..658ee798e794 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -9,6 +9,7 @@
 
 #include <linux/can/core.h>
 #include <linux/can/skb.h>
+#include <linux/errqueue.h>
 #include <linux/if_arp.h>
 
 #include "j1939-priv.h"
@@ -23,6 +24,7 @@ struct j1939_sock {
 #define J1939_SOCK_CONNECTED BIT(1)
 #define J1939_SOCK_PROMISC BIT(2)
 #define J1939_SOCK_RECV_OWN BIT(3)
+#define J1939_SOCK_ERRQUEUE BIT(4)
 	int state;
 
 	int ifindex;
@@ -487,7 +489,7 @@ static int j1939_sk_setsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 	struct j1939_sock *jsk = j1939_sk(sk);
-	int tmp, count = 0;
+	int tmp, count = 0, ret = 0;
 	struct j1939_filter *filters = NULL, *ofilters;
 
 	if (level != SOL_CAN_J1939)
@@ -531,6 +533,15 @@ static int j1939_sk_setsockopt(struct socket *sock, int level, int optname,
 	case SO_J1939_RECV_OWN:
 		return j1939_sk_setsockopt_flag(jsk, optval, optlen,
 						J1939_SOCK_RECV_OWN);
+	case SO_J1939_ERRQUEUE:
+		ret = j1939_sk_setsockopt_flag(jsk, optval, optlen,
+					       J1939_SOCK_ERRQUEUE);
+		if (ret < 0)
+			return ret;
+
+		if (!(jsk->state & J1939_SOCK_ERRQUEUE))
+			skb_queue_purge(&sk->sk_error_queue);
+		return ret;
 	case SO_J1939_SEND_PRIO:
 		if (optlen != sizeof(tmp))
 			return -EINVAL;
@@ -575,6 +586,9 @@ static int j1939_sk_getsockopt(struct socket *sock, int level, int optname,
 	case SO_J1939_RECV_OWN:
 		tmp = (jsk->state & J1939_SOCK_RECV_OWN) ? 1 : 0;
 		break;
+	case SO_J1939_ERRQUEUE:
+		tmp = (jsk->state & J1939_SOCK_ERRQUEUE) ? 1 : 0;
+		break;
 	case SO_J1939_SEND_PRIO:
 		tmp = j1939_prio(jsk->sk.sk_priority);
 		break;
@@ -608,6 +622,10 @@ static int j1939_sk_recvmsg(struct socket *sock, struct msghdr *msg,
 	struct j1939_sk_buff_cb *skcb;
 	int ret = 0;
 
+	if (flags & MSG_ERRQUEUE)
+		return sock_recv_errqueue(sock->sk, msg, size, SOL_CAN_J1939,
+					  SCM_J1939_ERRQUEUE);
+
 	skb = skb_recv_datagram(sk, flags, 0, &ret);
 	if (!skb)
 		return ret;
@@ -713,6 +731,86 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
 	return NULL;
 }
 
+static size_t j1939_sk_opt_stats_get_size(void)
+{
+	return
+		nla_total_size(sizeof(u32)) + /* J1939_NLA_BYTES_ACKED */
+		0;
+}
+
+struct sk_buff *j1939_sk_get_timestamping_opt_stats(struct j1939_session *session)
+{
+	struct sk_buff *stats;
+
+	stats = alloc_skb(j1939_sk_opt_stats_get_size(), GFP_ATOMIC);
+	if (!stats)
+		return NULL;
+
+	nla_put_u32(stats, J1939_NLA_BYTES_ACKED,
+		    min(session->pkt.done * 7, session->total_message_size));
+
+	return stats;
+}
+
+void j1939_sk_errqueue(struct j1939_session *session,
+		       enum j1939_sk_errqueue_type type)
+{
+	struct j1939_priv *priv = session->priv;
+	struct sock *sk = session->sk;
+	struct j1939_sock *jsk;
+	struct sock_exterr_skb *serr;
+	struct sk_buff *skb;
+	int err;
+
+	/* currently we have no sk for the RX session */
+	if (!sk)
+		return;
+
+	jsk = j1939_sk(sk);
+
+	if (!(jsk->state & J1939_SOCK_ERRQUEUE))
+		return;
+
+	skb = j1939_sk_get_timestamping_opt_stats(session);
+	if (!skb)
+		return;
+
+	skb->tstamp = ktime_get_real();
+
+	BUILD_BUG_ON(sizeof(struct sock_exterr_skb) > sizeof(skb->cb));
+
+	serr = SKB_EXT_ERR(skb);
+	memset(serr, 0, sizeof(*serr));
+	switch (type) {
+	case J1939_ERRQUEUE_ACK:
+		serr->ee.ee_errno = ENOMSG;
+		serr->ee.ee_origin = SO_EE_ORIGIN_TIMESTAMPING;
+		serr->ee.ee_info = SCM_TSTAMP_ACK;
+		break;
+	case J1939_ERRQUEUE_SCHED:
+		serr->ee.ee_errno = ENOMSG;
+		serr->ee.ee_origin = SO_EE_ORIGIN_TIMESTAMPING;
+		serr->ee.ee_info = SCM_TSTAMP_SCHED;
+		break;
+	case J1939_ERRQUEUE_ABORT:
+		serr->ee.ee_errno = session->err;
+		serr->ee.ee_origin = SO_EE_ORIGIN_LOCAL;
+		serr->ee.ee_info = J1939_EE_INFO_TX_ABORT;
+		break;
+	default:
+		netdev_err(priv->ndev, "Unknown errqueue type %i\n", type);
+	}
+
+	serr->opt_stats = true;
+	if (sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)
+		serr->ee.ee_data = session->tskey;
+
+	err = sock_queue_err_skb(sk, skb);
+
+	if (err)
+		kfree_skb(skb);
+};
+
 void j1939_sk_send_multi_abort(struct j1939_priv *priv, struct sock *sk,
 			       int err)
 {
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 62838d2e1173..64f2796756f4 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -261,6 +261,11 @@ static void __j1939_session_drop(struct j1939_session *session)
 
 static void j1939_session_destroy(struct j1939_session *session)
 {
+
+	if (session->err)
+		j1939_sk_errqueue(session, J1939_ERRQUEUE_ABORT);
+	else
+		j1939_sk_errqueue(session, J1939_ERRQUEUE_ACK);
 	j1939_session_list_lock(session->priv);
 	j1939_session_list_del(session);
 	j1939_session_list_unlock(session->priv);
@@ -835,6 +840,7 @@ static int j1939_tp_txnext(struct j1939_session *session)
 			j1939_tp_set_rxtimeout(session, 250);
 		if (ret)
 			goto failed;
+		j1939_sk_errqueue(session, J1939_ERRQUEUE_SCHED);
 		break;
 	}
 
@@ -1483,6 +1489,7 @@ struct j1939_session *j1939_tp_send(struct j1939_priv *priv,
 		goto failed;
 
 	/* transmission started */
+	session->tskey = session->sk->sk_tskey++;
 	return session;
 
  failed:
-- 
2.20.1

