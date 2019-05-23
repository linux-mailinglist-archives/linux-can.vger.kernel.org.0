Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B76DD27981
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2019 11:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbfEWJlw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 May 2019 05:41:52 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51259 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730293AbfEWJls (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 May 2019 05:41:48 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEI-0001G0-Px; Thu, 23 May 2019 11:41:42 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEH-00044M-E7; Thu, 23 May 2019 11:41:41 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 07/17] j1939: move struct j1939_sock to the header file
Date:   Thu, 23 May 2019 11:41:29 +0200
Message-Id: <20190523094139.15517-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523094139.15517-1-o.rempel@pengutronix.de>
References: <20190523094139.15517-1-o.rempel@pengutronix.de>
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

we will need it for sk session queue support

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h | 38 +++++++++++++++++++++++++++++++++++++-
 net/can/j1939/socket.c     | 33 ---------------------------------
 2 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index cad62665854d..4fb31d9d609e 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -7,11 +7,11 @@
 #define _J1939_PRIV_H_
 
 #include <linux/can/j1939.h>
+#include <net/sock.h>
 
 /* TODO: return ENETRESET on busoff. */
 
 struct j1939_session;
-
 enum j1939_sk_errqueue_type {
 	J1939_ERRQUEUE_ACK,
 	J1939_ERRQUEUE_SCHED,
@@ -250,6 +250,42 @@ struct j1939_session {
 	struct hrtimer txtimer, rxtimer;
 };
 
+struct j1939_sock {
+	struct sock sk; /* must be first to skip with memset */
+	struct list_head list;
+
+#define J1939_SOCK_BOUND BIT(0)
+#define J1939_SOCK_CONNECTED BIT(1)
+#define J1939_SOCK_PROMISC BIT(2)
+#define J1939_SOCK_RECV_OWN BIT(3)
+#define J1939_SOCK_ERRQUEUE BIT(4)
+	int state;
+
+	int ifindex;
+	struct j1939_addr addr;
+	struct j1939_filter *filters;
+	int nfilters;
+	pgn_t pgn_rx_filter;
+
+	size_t etp_tx_complete_size;
+	size_t etp_tx_done_size;
+
+	/* j1939 may emit equal PGN (!= equal CAN-id's) out of order
+	 * when transport protocol comes in.
+	 * To allow emitting in order, keep a 'pending' nr. of packets
+	 */
+	atomic_t skb_pending;
+	wait_queue_head_t waitq;
+
+	spinlock_t session_fifo_lock;
+	struct list_head session_fifo;
+};
+
+static inline struct j1939_sock *j1939_sk(const struct sock *sk)
+{
+	return container_of(sk, struct j1939_sock, sk);
+}
+
 void j1939_session_get(struct j1939_session *session);
 void j1939_session_put(struct j1939_session *session);
 void j1939_session_skb_queue(struct j1939_session *session,
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 68f1ccc44109..5e97988cc59f 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -16,39 +16,6 @@
 
 #define J1939_MIN_NAMELEN REQUIRED_SIZE(struct sockaddr_can, can_addr.j1939)
 
-struct j1939_sock {
-	struct sock sk; /* must be first to skip with memset */
-	struct list_head list;
-
-#define J1939_SOCK_BOUND BIT(0)
-#define J1939_SOCK_CONNECTED BIT(1)
-#define J1939_SOCK_PROMISC BIT(2)
-#define J1939_SOCK_RECV_OWN BIT(3)
-#define J1939_SOCK_ERRQUEUE BIT(4)
-	int state;
-
-	int ifindex;
-	struct j1939_addr addr;
-	struct j1939_filter *filters;
-	int nfilters;
-	pgn_t pgn_rx_filter;
-
-	size_t etp_tx_complete_size;
-	size_t etp_tx_done_size;
-
-	/* j1939 may emit equal PGN (!= equal CAN-id's) out of order
-	 * when transport protocol comes in.
-	 * To allow emitting in order, keep a 'pending' nr. of packets
-	 */
-	atomic_t skb_pending;
-	wait_queue_head_t waitq;
-};
-
-static inline struct j1939_sock *j1939_sk(const struct sock *sk)
-{
-	return container_of(sk, struct j1939_sock, sk);
-}
-
 /* conversion function between struct sock::sk_priority from linux and
  * j1939 priority field
  */
-- 
2.20.1

