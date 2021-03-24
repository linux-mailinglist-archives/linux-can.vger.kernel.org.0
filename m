Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B806348433
	for <lists+linux-can@lfdr.de>; Wed, 24 Mar 2021 22:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhCXVzu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 24 Mar 2021 17:55:50 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:12716 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbhCXVzO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 24 Mar 2021 17:55:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1616622896; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jphxfFxu4hIvRH7sjmtEksu8LW7kK+kxbhcY9BHSd9YgCxGPb3+ehVYns53+2hnPwp
    nHlEzRDkqIzt58GAacUE2j/YJUTwnjJrTu+8zUQrgB0fotLKWXU2HBvYjXmzczBuXs/e
    9IUjBqbSQO3zdusLKNhfgl46LDG1YCMq1TiumRlQfAWDziLL7KjsdE/B+JPnB7+Djmrl
    +QN89L/5XKLlGX7aULuAzfY0VKgvQbssPvyL1cZnwKq6Ek7YtwRzXWe1ERGQ6lb905yZ
    VJ58CHL9lCIFiUlKshgrGr79YtYdUaod/MgWYpFxpu+U6ZStBpZanyRpTFFQC3IBZzdf
    BVBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1616622896;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Iyi44ng2Ab2TXmK3jFPDYBVzAJ4cMHVm6ZLxEm9aDFI=;
    b=an6BH+hixtV8+79s0YDWX6rR6gGJRw1TXV8srY2oC95Iz8gYBiNamU1hRKu1rGvoKG
    N1aQ62NyC+nw2XAAX0aMoqrYcazNqf7unjVYfgSTs5D+3+TYU2KxuXbNhYk79wpnoUFl
    zK2aCVyiC7rXshHw8rqcXO9/mj3TTabsxm5hdj+swyA67nb+bPQyb6YKmm/qiFt0Rs8J
    kZhE7piLfE+hVgG1edWqaTA7AJv6uTG08GoBXpHCS1kyFt4ciOtsZ2INkBW5rhdnRXXs
    GdaP8+dJXGWc/G4iFXotTYlGzTsYJfJrjlxpF6q+bipsQ9eSdAQcmV4xl2KORorglfVn
    EVCw==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1616622896;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Iyi44ng2Ab2TXmK3jFPDYBVzAJ4cMHVm6ZLxEm9aDFI=;
    b=JCx1NA4/ZNFExwieSQENf/UC8UrtJBgBTwxNrT8JRMFBUF9TS06TYe/zQacEhzKAKh
    gwzihACnKeLD3Vlt1Cd1lKBbG49iMWHV/MMvZ4X10+W8+xOcjWNHKRPM+kjWeqZBRJKO
    azgja7uknaXWDnLclsfwkBWOSM9D4Df60gov4GutXwIbhPv0MCRXQoos0ZFFExt1NIwN
    V21U6KTk+0Agt7oGvmTSQAjgB1Lisxt0dXU8HoRKfyuflWDgWFCkoZm9bqwY01sFynhP
    P2LC3LEOhXRvHeCHajW9UNUw8pwnZA82/1HWU11ZS4OjFkV0A22czg7qp62V/FHj/myr
    ktag==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0lu8GW276ZqiLaA=="
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.22.0 DYNA|AUTH)
    with ESMTPSA id z00fabx2OLsu2E3
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 24 Mar 2021 22:54:56 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Richard Weinberger <richard@nod.at>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH] [RFC] can: fix msg_namelen values depending on CAN_REQUIRED_SIZE
Date:   Wed, 24 Mar 2021 22:54:42 +0100
Message-Id: <20210324215442.44537-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Since commit f5223e9eee65 ("can: extend sockaddr_can to include j1939
members") the sockaddr_can has been extended in size and a new
CAN_REQUIRED_SIZE macro has been introduced to calculate the protocol
specific needed size.

The ABI for the msg_name and msg_namelen has not been adapted to the
new CAN_REQUIRED_SIZE macro which leads to a problem when an existing
binary reads the (increased) struct sockaddr_can in msg_name.

Fixes: f5223e9eee65 ("can: extend sockaddr_can to include j1939 members")
Link: https://lore.kernel.org/linux-can/1135648123.112255.1616613706554.JavaMail.zimbra@nod.at/T/#t
Reported-by: Richard Weinberger <richard@nod.at>
Suggested-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c   | 14 ++++++++++----
 net/can/isotp.c | 14 ++++++++++----
 net/can/raw.c   | 17 +++++++++++------
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 0e5c37be4a2b..0886d5bca65d 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -84,10 +84,12 @@
 MODULE_DESCRIPTION("PF_CAN broadcast manager protocol");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Oliver Hartkopp <oliver.hartkopp@volkswagen.de>");
 MODULE_ALIAS("can-proto-2");
 
+#define BCM_MIN_NAMELEN CAN_REQUIRED_SIZE(struct sockaddr_can, can_ifindex)
+
 /*
  * easy access to the first 64 bit of can(fd)_frame payload. cp->data is
  * 64 bit aligned so the offset has to be multiples of 8 which is ensured
  * by the only callers in bcm_rx_cmp_to_index() bcm_rx_handler().
  */
@@ -1290,11 +1292,11 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	if (!ifindex && msg->msg_name) {
 		/* no bound device as default => check msg_name */
 		DECLARE_SOCKADDR(struct sockaddr_can *, addr, msg->msg_name);
 
-		if (msg->msg_namelen < CAN_REQUIRED_SIZE(*addr, can_ifindex))
+		if (msg->msg_namelen < BCM_MIN_NAMELEN)
 			return -EINVAL;
 
 		if (addr->can_family != AF_CAN)
 			return -EINVAL;
 
@@ -1532,11 +1534,11 @@ static int bcm_connect(struct socket *sock, struct sockaddr *uaddr, int len,
 	struct sock *sk = sock->sk;
 	struct bcm_sock *bo = bcm_sk(sk);
 	struct net *net = sock_net(sk);
 	int ret = 0;
 
-	if (len < CAN_REQUIRED_SIZE(*addr, can_ifindex))
+	if (len < BCM_MIN_NAMELEN)
 		return -EINVAL;
 
 	lock_sock(sk);
 
 	if (bo->bound) {
@@ -1598,10 +1600,14 @@ static int bcm_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	int noblock;
 	int err;
 
 	noblock =  flags & MSG_DONTWAIT;
 	flags   &= ~MSG_DONTWAIT;
+
+	if (msg->msg_name && msg->msg_namelen < BCM_MIN_NAMELEN)
+		return -EINVAL;
+
 	skb = skb_recv_datagram(sk, flags, noblock, &error);
 	if (!skb)
 		return error;
 
 	if (skb->len < size)
@@ -1614,12 +1620,12 @@ static int bcm_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	}
 
 	sock_recv_ts_and_drops(msg, sk, skb);
 
 	if (msg->msg_name) {
-		__sockaddr_check_size(sizeof(struct sockaddr_can));
-		msg->msg_namelen = sizeof(struct sockaddr_can);
+		__sockaddr_check_size(BCM_MIN_NAMELEN);
+		msg->msg_namelen = BCM_MIN_NAMELEN;
 		memcpy(msg->msg_name, skb->cb, msg->msg_namelen);
 	}
 
 	skb_free_datagram(sk, skb);
 
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 3ef7f78e553b..29ad5b7077df 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -75,10 +75,12 @@
 MODULE_DESCRIPTION("PF_CAN isotp 15765-2:2016 protocol");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Oliver Hartkopp <socketcan@hartkopp.net>");
 MODULE_ALIAS("can-proto-6");
 
+#define ISOTP_MIN_NAMELEN CAN_REQUIRED_SIZE(struct sockaddr_can, can_addr.tp)
+
 #define SINGLE_MASK(id) (((id) & CAN_EFF_FLAG) ? \
 			 (CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG) : \
 			 (CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG))
 
 /* ISO 15765-2:2016 supports more than 4095 byte per ISO PDU as the FF_DL can
@@ -969,10 +971,13 @@ static int isotp_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	int noblock;
 
 	noblock = flags & MSG_DONTWAIT;
 	flags &= ~MSG_DONTWAIT;
 
+	if (msg->msg_name && msg->msg_namelen < ISOTP_MIN_NAMELEN)
+		return -EINVAL;
+
 	skb = skb_recv_datagram(sk, flags, noblock, &err);
 	if (!skb)
 		return err;
 
 	if (size < skb->len)
@@ -987,11 +992,12 @@ static int isotp_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	}
 
 	sock_recv_timestamp(msg, sk, skb);
 
 	if (msg->msg_name) {
-		msg->msg_namelen = sizeof(struct sockaddr_can);
+		__sockaddr_check_size(ISOTP_MIN_NAMELEN);
+		msg->msg_namelen = ISOTP_MIN_NAMELEN;
 		memcpy(msg->msg_name, skb->cb, msg->msg_namelen);
 	}
 
 	skb_free_datagram(sk, skb);
 
@@ -1057,11 +1063,11 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	struct net_device *dev;
 	int err = 0;
 	int notify_enetdown = 0;
 	int do_rx_reg = 1;
 
-	if (len < CAN_REQUIRED_SIZE(struct sockaddr_can, can_addr.tp))
+	if (len < ISOTP_MIN_NAMELEN)
 		return -EINVAL;
 
 	/* do not register frame reception for functional addressing */
 	if (so->opt.flags & CAN_ISOTP_SF_BROADCAST)
 		do_rx_reg = 0;
@@ -1153,17 +1159,17 @@ static int isotp_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
 	struct isotp_sock *so = isotp_sk(sk);
 
 	if (peer)
 		return -EOPNOTSUPP;
 
-	memset(addr, 0, sizeof(*addr));
+	memset(addr, 0, ISOTP_MIN_NAMELEN);
 	addr->can_family = AF_CAN;
 	addr->can_ifindex = so->ifindex;
 	addr->can_addr.tp.rx_id = so->rxid;
 	addr->can_addr.tp.tx_id = so->txid;
 
-	return sizeof(*addr);
+	return ISOTP_MIN_NAMELEN;
 }
 
 static int isotp_setsockopt(struct socket *sock, int level, int optname,
 			    sockptr_t optval, unsigned int optlen)
 {
diff --git a/net/can/raw.c b/net/can/raw.c
index 37b47a39a3ed..d6eaa1d4eadb 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -58,10 +58,12 @@
 MODULE_DESCRIPTION("PF_CAN raw protocol");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Urs Thuermann <urs.thuermann@volkswagen.de>");
 MODULE_ALIAS("can-proto-1");
 
+#define RAW_MIN_NAMELEN CAN_REQUIRED_SIZE(struct sockaddr_can, can_ifindex)
+
 #define MASK_ALL 0
 
 /* A raw socket has a list of can_filters attached to it, each receiving
  * the CAN frames matching that filter.  If the filter list is empty,
  * no CAN frames will be received by the socket.  The default after
@@ -392,11 +394,11 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	struct raw_sock *ro = raw_sk(sk);
 	int ifindex;
 	int err = 0;
 	int notify_enetdown = 0;
 
-	if (len < CAN_REQUIRED_SIZE(*addr, can_ifindex))
+	if (len < RAW_MIN_NAMELEN)
 		return -EINVAL;
 	if (addr->can_family != AF_CAN)
 		return -EINVAL;
 
 	lock_sock(sk);
@@ -473,15 +475,15 @@ static int raw_getname(struct socket *sock, struct sockaddr *uaddr,
 	struct raw_sock *ro = raw_sk(sk);
 
 	if (peer)
 		return -EOPNOTSUPP;
 
-	memset(addr, 0, sizeof(*addr));
+	memset(addr, 0, RAW_MIN_NAMELEN);
 	addr->can_family  = AF_CAN;
 	addr->can_ifindex = ro->ifindex;
 
-	return sizeof(*addr);
+	return RAW_MIN_NAMELEN;
 }
 
 static int raw_setsockopt(struct socket *sock, int level, int optname,
 			  sockptr_t optval, unsigned int optlen)
 {
@@ -737,11 +739,11 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	int err;
 
 	if (msg->msg_name) {
 		DECLARE_SOCKADDR(struct sockaddr_can *, addr, msg->msg_name);
 
-		if (msg->msg_namelen < CAN_REQUIRED_SIZE(*addr, can_ifindex))
+		if (msg->msg_namelen < RAW_MIN_NAMELEN)
 			return -EINVAL;
 
 		if (addr->can_family != AF_CAN)
 			return -EINVAL;
 
@@ -808,10 +810,13 @@ static int raw_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	int noblock;
 
 	noblock = flags & MSG_DONTWAIT;
 	flags &= ~MSG_DONTWAIT;
 
+	if (msg->msg_name && msg->msg_namelen < RAW_MIN_NAMELEN)
+		return -EINVAL;
+
 	if (flags & MSG_ERRQUEUE)
 		return sock_recv_errqueue(sk, msg, size,
 					  SOL_CAN_RAW, SCM_CAN_RAW_ERRQUEUE);
 
 	skb = skb_recv_datagram(sk, flags, noblock, &err);
@@ -830,12 +835,12 @@ static int raw_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	}
 
 	sock_recv_ts_and_drops(msg, sk, skb);
 
 	if (msg->msg_name) {
-		__sockaddr_check_size(sizeof(struct sockaddr_can));
-		msg->msg_namelen = sizeof(struct sockaddr_can);
+		__sockaddr_check_size(RAW_MIN_NAMELEN);
+		msg->msg_namelen = RAW_MIN_NAMELEN;
 		memcpy(msg->msg_name, skb->cb, msg->msg_namelen);
 	}
 
 	/* assign the flags that have been recorded in raw_rcv() */
 	msg->msg_flags |= *(raw_flags(skb));
-- 
2.30.2

