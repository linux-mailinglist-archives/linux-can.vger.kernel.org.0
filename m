Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACACE831FD
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2019 14:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfHFM6r (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Aug 2019 08:58:47 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45719 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfHFM6r (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Aug 2019 08:58:47 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1huz37-0002wH-7e; Tue, 06 Aug 2019 14:58:45 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1huz36-0003rN-Kk; Tue, 06 Aug 2019 14:58:44 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 3/6] j1939: remove SO_J1939_RECV_OWN support
Date:   Tue,  6 Aug 2019 14:58:37 +0200
Message-Id: <20190806125840.5634-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806125840.5634-1-o.rempel@pengutronix.de>
References: <20190806125840.5634-1-o.rempel@pengutronix.de>
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

it is hard to combine with IsoCAN support and make no sense if it
is needed to confirm transferred package.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 Documentation/networking/j1939.rst |  6 ------
 include/uapi/linux/can/j1939.h     |  5 ++---
 net/can/j1939/j1939-priv.h         |  3 +--
 net/can/j1939/socket.c             | 12 ++----------
 4 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/Documentation/networking/j1939.rst b/Documentation/networking/j1939.rst
index ba981ee8d717..814fcc6054ad 100644
--- a/Documentation/networking/j1939.rst
+++ b/Documentation/networking/j1939.rst
@@ -217,7 +217,6 @@ modified with setsockopt(2) & getsockopt(2).
 RX path related options:
 SO_J1939_FILTER - configure array of filters
 SO_J1939_PROMISC - disable filters set by bind(2) and connect(2)
-SO_J1939_RECV_OWN - receive packets that have been sent on this socket
 
 By default no broadcast packets can't be send or received. To enable sending
 or receiving broadcast packets use the socket option SO_BROADCAST:
@@ -237,11 +236,6 @@ The following diagram illustrates the RX path:
                               |
                               V
                     +--------------------+
-                    | SO_J1939_RECV_OWN? |
-                    +--------------------+
-                              |
-                              v
-                    +--------------------+
                     | SO_J1939_PROMISC?  |
                     +--------------------+
                              |  |
diff --git a/include/uapi/linux/can/j1939.h b/include/uapi/linux/can/j1939.h
index 603ce1394ebb..c32325342d30 100644
--- a/include/uapi/linux/can/j1939.h
+++ b/include/uapi/linux/can/j1939.h
@@ -64,9 +64,8 @@ typedef __u64 name_t;
 enum {
 	SO_J1939_FILTER = 1,	/* set filters */
 	SO_J1939_PROMISC = 2,	/* set/clr promiscuous mode */
-	SO_J1939_RECV_OWN = 3,
-	SO_J1939_SEND_PRIO = 4,
-	SO_J1939_ERRQUEUE = 5,
+	SO_J1939_SEND_PRIO = 3,
+	SO_J1939_ERRQUEUE = 4,
 };
 
 enum {
diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 303fd15ca595..f68256aa01f2 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -282,8 +282,7 @@ struct j1939_sock {
 #define J1939_SOCK_BOUND BIT(0)
 #define J1939_SOCK_CONNECTED BIT(1)
 #define J1939_SOCK_PROMISC BIT(2)
-#define J1939_SOCK_RECV_OWN BIT(3)
-#define J1939_SOCK_ERRQUEUE BIT(4)
+#define J1939_SOCK_ERRQUEUE BIT(3)
 	int state;
 
 	int ifindex;
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index f29b5613207b..90c4e766e60b 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -275,7 +275,7 @@ static bool j1939_sk_recv_match_one(struct j1939_sock *jsk,
 	if (!(jsk->state & J1939_SOCK_BOUND))
 		return false;
 
-	if (skcb->insock == &jsk->sk && !(jsk->state & J1939_SOCK_RECV_OWN))
+	if (skcb->insock == &jsk->sk)
 		/* own message */
 		return false;
 
@@ -303,11 +303,9 @@ static void j1939_sk_recv_one(struct j1939_sock *jsk, struct sk_buff *oskb)
 		return;
 	}
 	skcb = j1939_skb_to_cb(skb);
-	skcb->msg_flags &= ~(MSG_DONTROUTE | MSG_CONFIRM);
+	skcb->msg_flags &= ~(MSG_DONTROUTE);
 	if (skcb->insock)
 		skcb->msg_flags |= MSG_DONTROUTE;
-	if (skcb->insock == &jsk->sk)
-		skcb->msg_flags |= MSG_CONFIRM;
 
 	if (sock_queue_rcv_skb(&jsk->sk, skb) < 0)
 		kfree_skb(skb);
@@ -641,9 +639,6 @@ static int j1939_sk_setsockopt(struct socket *sock, int level, int optname,
 	case SO_J1939_PROMISC:
 		return j1939_sk_setsockopt_flag(jsk, optval, optlen,
 						J1939_SOCK_PROMISC);
-	case SO_J1939_RECV_OWN:
-		return j1939_sk_setsockopt_flag(jsk, optval, optlen,
-						J1939_SOCK_RECV_OWN);
 	case SO_J1939_ERRQUEUE:
 		ret = j1939_sk_setsockopt_flag(jsk, optval, optlen,
 					       J1939_SOCK_ERRQUEUE);
@@ -694,9 +689,6 @@ static int j1939_sk_getsockopt(struct socket *sock, int level, int optname,
 	case SO_J1939_PROMISC:
 		tmp = (jsk->state & J1939_SOCK_PROMISC) ? 1 : 0;
 		break;
-	case SO_J1939_RECV_OWN:
-		tmp = (jsk->state & J1939_SOCK_RECV_OWN) ? 1 : 0;
-		break;
 	case SO_J1939_ERRQUEUE:
 		tmp = (jsk->state & J1939_SOCK_ERRQUEUE) ? 1 : 0;
 		break;
-- 
2.20.1

