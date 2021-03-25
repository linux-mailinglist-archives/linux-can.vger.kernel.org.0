Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D701C348B49
	for <lists+linux-can@lfdr.de>; Thu, 25 Mar 2021 09:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhCYIOE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 Mar 2021 04:14:04 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:26720 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhCYINv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Mar 2021 04:13:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1616660015; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bb3GI5OJmRC+NfPROGEeiPKyUMwIROmfASF58GgQyd++SFTYkxWobg9szaiqS/B5wL
    Lo0j6ql6e8lIssQkPoiNJJybdKfX08OPnygMfyJaCfsg7MlaS4GP0howvzfCDu6b778I
    H77YFdMmc5qdc5XmCn2r6ORoa0qCVa1RgOytFi5585bjeEYF0NvLvnwwTnH0rlw7T6gB
    3yIj4LuJumHLAqXBJueyac12kaV+FsYOLeI8TXhX4+hHKRe1gh7ZvfHzmREJOMgjmDsO
    9q1izQEw1ZR36IIR6mpVRr9sYyIMDZyVIfQbEYeig39KJnmQALDaUI4+HduCJ/W5ksBK
    d/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1616660015;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=RdVBB4NZ/J5F5FSsP8Lqg4uBygthRGbbCDAxqm7//C4=;
    b=MmMtfdev0IOb7H5MPQuclW8s7kkn8O4Pl4sPN18pKRkRVWvRcmffpYKYmX1dlR9ld1
    h9C9/YhIQxoDK2qqIMQSxeJeIWNfpYhY3a9MS8E38Y5jY/XPaUv7/nv2H/rOvcuFIrTK
    b+SLq7GF5qIRXCLrLDKLZg5PN0hM8RQZxpuSXrLz90B9nwt7+4fsO5XnNF3rdjbdRwGZ
    QaZw/cC31X67JtUXj56LnRxyGtxh9xv0ALaejKzpMXzqjImyyd52+GYMb73Gwpz6DuFs
    v92H7Lt3J2gfr/xszLMd+GAkEkEEnmLHQnppeB4T9AEaY+v+S1RDF/6xxB3k5JCdnDXi
    DLHg==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1616660015;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=RdVBB4NZ/J5F5FSsP8Lqg4uBygthRGbbCDAxqm7//C4=;
    b=ggHoYhFQgzUtShDZGclcw4RIw56nM5aEFuIDF6zACRad6OwcyJSS3NK7kf1lZFEQmH
    eBMBmPHHsUkIzhzv6CpVRSSL6lv8NMpwp4Zd9kCH1e7lsbfa+nOoLrU3xq3dR7wVXSBV
    maDz5WZz+dFKgtnM0LqDTmhaRtsrHnabXlDS7QubkvXJz2K2xJEe9JctCPtXVT1eN+v8
    U4jGL3up+RzI/ZGoQBW4jv+V0wb2xEvQS4V/3zcWah6Pteb4PxivA9luJosHVqVgvV1m
    wSGcGa5D6M6ewsN/ggxAtA/cF+9DT0wiNl4iZUg+9ZOBy5qziJ5jXttzMBjx5l8zptId
    a8uw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejuVLjM8tyWa"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.22.0 DYNA|AUTH)
    with ESMTPSA id z00fabx2P8DY2sM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 25 Mar 2021 09:13:34 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Richard Weinberger <richard@nod.at>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH v2] [RFC] can: fix msg_namelen values depending on CAN_REQUIRED_SIZE
Date:   Thu, 25 Mar 2021 09:13:26 +0100
Message-Id: <20210325081326.1652-1-socketcan@hartkopp.net>
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
new CAN_REQUIRED_SIZE macro for the other CAN protocols which leads
to a problem when an existing binary reads the (increased)
struct sockaddr_can in msg_name.

Fixes: f5223e9eee65 ("can: extend sockaddr_can to include j1939 members")
Link: https://lore.kernel.org/linux-can/1135648123.112255.1616613706554.JavaMail.zimbra@nod.at/T/#t
Reported-by: Richard Weinberger <richard@nod.at>
Suggested-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c   | 10 ++++++----
 net/can/isotp.c | 11 +++++++----
 net/can/raw.c   | 14 ++++++++------
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 0e5c37be4a2b..909b9e684e04 100644
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
@@ -1614,12 +1616,12 @@ static int bcm_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
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
index 3ef7f78e553b..86945dbb6c76 100644
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
@@ -987,11 +989,12 @@ static int isotp_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	}
 
 	sock_recv_timestamp(msg, sk, skb);
 
 	if (msg->msg_name) {
-		msg->msg_namelen = sizeof(struct sockaddr_can);
+		__sockaddr_check_size(ISOTP_MIN_NAMELEN);
+		msg->msg_namelen = ISOTP_MIN_NAMELEN;
 		memcpy(msg->msg_name, skb->cb, msg->msg_namelen);
 	}
 
 	skb_free_datagram(sk, skb);
 
@@ -1057,11 +1060,11 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
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
@@ -1153,17 +1156,17 @@ static int isotp_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
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
index 37b47a39a3ed..139d9471ddcf 100644
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
 
@@ -830,12 +832,12 @@ static int raw_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
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

