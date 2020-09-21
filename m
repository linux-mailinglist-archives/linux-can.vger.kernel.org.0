Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038BE2725D9
	for <lists+linux-can@lfdr.de>; Mon, 21 Sep 2020 15:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgIUNiy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Sep 2020 09:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgIUNix (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Sep 2020 09:38:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23354C0613D4
        for <linux-can@vger.kernel.org>; Mon, 21 Sep 2020 06:38:51 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kKM1p-0000ox-8J; Mon, 21 Sep 2020 15:38:49 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 06/38] can: raw: fix indention
Date:   Mon, 21 Sep 2020 15:38:13 +0200
Message-Id: <20200921133845.2249271-7-mkl@pengutronix.de>
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

This patch fixes the indention to follow kernel coding style.

Link: https://lore.kernel.org/r/20200915223527.1417033-7-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/raw.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 94a9405658dc..57235b29f571 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -154,16 +154,16 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 	if (!skb)
 		return;
 
-	/*  Put the datagram to the queue so that raw_recvmsg() can
-	 *  get it from there.  We need to pass the interface index to
-	 *  raw_recvmsg().  We pass a whole struct sockaddr_can in skb->cb
-	 *  containing the interface index.
+	/* Put the datagram to the queue so that raw_recvmsg() can get
+	 * it from there. We need to pass the interface index to
+	 * raw_recvmsg(). We pass a whole struct sockaddr_can in
+	 * skb->cb containing the interface index.
 	 */
 
 	sock_skb_cb_check_size(sizeof(struct sockaddr_can));
 	addr = (struct sockaddr_can *)skb->cb;
 	memset(addr, 0, sizeof(*addr));
-	addr->can_family  = AF_CAN;
+	addr->can_family = AF_CAN;
 	addr->can_ifindex = skb->dev->ifindex;
 
 	/* add CAN specific message flags for raw_recvmsg() */
@@ -290,8 +290,8 @@ static int raw_notifier(struct notifier_block *nb,
 			kfree(ro->filter);
 
 		ro->ifindex = 0;
-		ro->bound   = 0;
-		ro->count   = 0;
+		ro->bound = 0;
+		ro->count = 0;
 		release_sock(sk);
 
 		sk->sk_err = ENODEV;
@@ -374,8 +374,8 @@ static int raw_release(struct socket *sock)
 		kfree(ro->filter);
 
 	ro->ifindex = 0;
-	ro->bound   = 0;
-	ro->count   = 0;
+	ro->bound = 0;
+	ro->count = 0;
 	free_percpu(ro->uniq);
 
 	sock_orphan(sk);
@@ -773,7 +773,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	skb_setup_tx_timestamp(skb, sk->sk_tsflags);
 
 	skb->dev = dev;
-	skb->sk  = sk;
+	skb->sk = sk;
 	skb->priority = sk->sk_priority;
 
 	err = can_send(skb, ro->loopback);
@@ -801,8 +801,8 @@ static int raw_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	int err = 0;
 	int noblock;
 
-	noblock =  flags & MSG_DONTWAIT;
-	flags   &= ~MSG_DONTWAIT;
+	noblock = flags & MSG_DONTWAIT;
+	flags &= ~MSG_DONTWAIT;
 
 	skb = skb_recv_datagram(sk, flags, noblock, &err);
 	if (!skb)
-- 
2.28.0

