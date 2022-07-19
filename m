Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754CC579874
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 13:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbiGSL2E (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 07:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236815AbiGSL2C (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 07:28:02 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFD440BE2
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 04:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658230074;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OACPG28OW6MYd2znnYksLnZjq/KcY7c3i6ahLH0oCb0=;
    b=NKWjX41JAaBau+Lo6Cr7epuqedz+DkfinU3G9gjXObMbkupwIiOrZqsfwebqUkq4xj
    Z+mKvMPMSq7DcCd0T0dRIoDxoVQFIF+p9fby3knUeTUOr55r3ekorF9JKMyvlSmKntHY
    RZyWY5L96N+4pWNUtIJbka2Kr+xH7A3YVeklkwbSG0+tLWFaZPaTwSEHwYI05uaXxd0k
    gkNlVivuE+Z3CPDLhLqHaREWP1uBDcV7lSpet4E/iThd0+McGaRAfEOIkr34e1Hxkyxx
    8ekB23o/i28cwdx70Ci9NY5iE2GJCL6rMrzpxdtj7c5eRyZ1p0+PyfJIZ6+9hfsg4cMh
    ON1w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JiLceSWJaYwXUKbZ"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6JBRsGeR
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 19 Jul 2022 13:27:54 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH v5 5/5] can: raw: add CAN XL support
Date:   Tue, 19 Jul 2022 13:27:48 +0200
Message-Id: <20220719112748.3281-6-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220719112748.3281-1-socketcan@hartkopp.net>
References: <20220719112748.3281-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Enable CAN_RAW sockets to read and write CAN XL frames analogue to the
CAN FD extension (new CAN_RAW_XL_FRAMES sockopt).

A CAN XL network interface is capable to handle Classical CAN, CAN FD and
CAN XL frames. When CAN_RAW_XL_FRAMES is enabled, the CAN_RAW socket checks
whether the addressed CAN network interface is capable to handle the
provided CAN frame.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can/raw.h |  1 +
 net/can/raw.c                | 89 ++++++++++++++++++++++++++++++------
 2 files changed, 76 insertions(+), 14 deletions(-)

diff --git a/include/uapi/linux/can/raw.h b/include/uapi/linux/can/raw.h
index 3386aa81fdf2..ff12f525c37c 100644
--- a/include/uapi/linux/can/raw.h
+++ b/include/uapi/linux/can/raw.h
@@ -60,8 +60,9 @@ enum {
 	CAN_RAW_ERR_FILTER,	/* set filter for error frames       */
 	CAN_RAW_LOOPBACK,	/* local loopback (default:on)       */
 	CAN_RAW_RECV_OWN_MSGS,	/* receive my own msgs (default:off) */
 	CAN_RAW_FD_FRAMES,	/* allow CAN FD frames (default:off) */
 	CAN_RAW_JOIN_FILTERS,	/* all filters must match to trigger */
+	CAN_RAW_XL_FRAMES,	/* allow CAN XL frames (default:off) */
 };
 
 #endif /* !_UAPI_CAN_RAW_H */
diff --git a/net/can/raw.c b/net/can/raw.c
index d1bd9cc51ebe..0090fb785480 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -85,10 +85,11 @@ struct raw_sock {
 	int ifindex;
 	struct list_head notifier;
 	int loopback;
 	int recv_own_msgs;
 	int fd_frames;
+	int xl_frames;
 	int join_filters;
 	int count;                 /* number of active filters */
 	struct can_filter dfilter; /* default/single filter */
 	struct can_filter *filter; /* pointer to filter(s) */
 	can_err_mask_t err_mask;
@@ -127,12 +128,13 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 
 	/* check the received tx sock reference */
 	if (!ro->recv_own_msgs && oskb->sk == sk)
 		return;
 
-	/* do not pass non-CAN2.0 frames to a legacy socket */
-	if (!ro->fd_frames && oskb->len != CAN_MTU)
+	/* make sure to not pass oversized frames to the socket */
+	if ((oskb->len > CAN_MTU && !ro->fd_frames && !ro->xl_frames) ||
+	    (oskb->len == CANXL_MTU && !ro->xl_frames))
 		return;
 
 	/* eliminate multiple filter matches for the same skb */
 	if (this_cpu_ptr(ro->uniq)->skb == oskb &&
 	    this_cpu_ptr(ro->uniq)->skbcnt == can_skb_prv(oskb)->skbcnt) {
@@ -344,10 +346,11 @@ static int raw_init(struct sock *sk)
 
 	/* set default loopback behaviour */
 	ro->loopback         = 1;
 	ro->recv_own_msgs    = 0;
 	ro->fd_frames        = 0;
+	ro->xl_frames        = 0;
 	ro->join_filters     = 0;
 
 	/* alloc_percpu provides zero'ed memory */
 	ro->uniq = alloc_percpu(struct uniqframe);
 	if (unlikely(!ro->uniq))
@@ -667,10 +670,19 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		if (copy_from_sockptr(&ro->fd_frames, optval, optlen))
 			return -EFAULT;
 
 		break;
 
+	case CAN_RAW_XL_FRAMES:
+		if (optlen != sizeof(ro->xl_frames))
+			return -EINVAL;
+
+		if (copy_from_sockptr(&ro->xl_frames, optval, optlen))
+			return -EFAULT;
+
+		break;
+
 	case CAN_RAW_JOIN_FILTERS:
 		if (optlen != sizeof(ro->join_filters))
 			return -EINVAL;
 
 		if (copy_from_sockptr(&ro->join_filters, optval, optlen))
@@ -749,10 +761,16 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 		if (len > sizeof(int))
 			len = sizeof(int);
 		val = &ro->fd_frames;
 		break;
 
+	case CAN_RAW_XL_FRAMES:
+		if (len > sizeof(int))
+			len = sizeof(int);
+		val = &ro->xl_frames;
+		break;
+
 	case CAN_RAW_JOIN_FILTERS:
 		if (len > sizeof(int))
 			len = sizeof(int);
 		val = &ro->join_filters;
 		break;
@@ -773,12 +791,17 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	struct sock *sk = sock->sk;
 	struct raw_sock *ro = raw_sk(sk);
 	struct sockcm_cookie sockc;
 	struct sk_buff *skb;
 	struct net_device *dev;
+	unsigned int skb_sz = size;
 	int ifindex;
-	int err;
+	int err = -EINVAL;
+
+	/* valid CAN frame sizes */
+	if (size < CANXL_HDR_SZ + CANXL_MIN_DLEN || size > CANXL_MTU)
+		return -EINVAL;
 
 	if (msg->msg_name) {
 		DECLARE_SOCKADDR(struct sockaddr_can *, addr, msg->msg_name);
 
 		if (msg->msg_namelen < RAW_MIN_NAMELEN)
@@ -794,20 +817,15 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	dev = dev_get_by_index(sock_net(sk), ifindex);
 	if (!dev)
 		return -ENXIO;
 
-	err = -EINVAL;
-	if (ro->fd_frames && dev->mtu == CANFD_MTU) {
-		if (unlikely(size != CANFD_MTU && size != CAN_MTU))
-			goto put_dev;
-	} else {
-		if (unlikely(size != CAN_MTU))
-			goto put_dev;
-	}
+	/* alloc full CAN XL space */
+	if (ro->xl_frames && dev->mtu == CANXL_MTU)
+		skb_sz = CANXL_MTU;
 
-	skb = sock_alloc_send_skb(sk, size + sizeof(struct can_skb_priv),
+	skb = sock_alloc_send_skb(sk, skb_sz + sizeof(struct can_skb_priv),
 				  msg->msg_flags & MSG_DONTWAIT, &err);
 	if (!skb)
 		goto put_dev;
 
 	can_skb_reserve(skb);
@@ -816,10 +834,43 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	err = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (err < 0)
 		goto free_skb;
 
+	err = -EINVAL;
+
+	if (ro->xl_frames && dev->mtu == CANXL_MTU) {
+		struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
+
+		if (cfx->flags & CANXL_XLF) {
+			/* check for valid CAN XL frame */
+			if (cfx->len < CANXL_MIN_DLEN ||
+			    cfx->len > CANXL_MAX_DLEN)
+			goto free_skb;
+
+			/* check truncated CAN XL frame structure */
+			if (size != cfx->len + CANXL_HDR_SZ)
+				goto free_skb;
+
+			/* push skb->len to CANXL_MTU */
+			if (size < CANXL_MTU)
+				skb_put_zero(skb, CANXL_MTU - size);
+		} else {
+			/* check for CAN FD and Classical CAN */
+			if (unlikely(size != CANFD_MTU && size != CAN_MTU))
+				goto free_skb;
+		}
+	} else if (ro->fd_frames && dev->mtu == CANFD_MTU) {
+		/* CAN FD and Classical CAN */
+		if (unlikely(size != CANFD_MTU && size != CAN_MTU))
+			goto free_skb;
+	} else {
+		/* Classical CAN */
+		if (unlikely(size != CAN_MTU))
+			goto free_skb;
+	}
+
 	sockcm_init(&sockc, sk);
 	if (msg->msg_controllen) {
 		err = sock_cmsg_send(sk, msg, &sockc);
 		if (unlikely(err))
 			goto free_skb;
@@ -850,25 +901,35 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 static int raw_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		       int flags)
 {
 	struct sock *sk = sock->sk;
+	struct raw_sock *ro = raw_sk(sk);
 	struct sk_buff *skb;
+	struct canxl_frame *cfx;
+	unsigned int rx_len;
 	int err = 0;
 
 	if (flags & MSG_ERRQUEUE)
 		return sock_recv_errqueue(sk, msg, size,
 					  SOL_CAN_RAW, SCM_CAN_RAW_ERRQUEUE);
 
 	skb = skb_recv_datagram(sk, flags, &err);
 	if (!skb)
 		return err;
 
-	if (size < skb->len)
+	rx_len = skb->len;
+	if (rx_len == CANXL_MTU) {
+		cfx = (struct canxl_frame *)skb->data;
+		if (cfx->len >= CANXL_MIN_DLEN && cfx->len < CANXL_MAX_DLEN)
+			rx_len = CANXL_HDR_SZ + cfx->len;
+	}
+
+	if (size < rx_len)
 		msg->msg_flags |= MSG_TRUNC;
 	else
-		size = skb->len;
+		size = rx_len;
 
 	err = memcpy_to_msg(msg, skb->data, size);
 	if (err < 0) {
 		skb_free_datagram(sk, skb);
 		return err;
-- 
2.30.2

