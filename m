Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EE15870AA
	for <lists+linux-can@lfdr.de>; Mon,  1 Aug 2022 21:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiHATAc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 1 Aug 2022 15:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiHATA3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 1 Aug 2022 15:00:29 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A83DFF3
        for <linux-can@vger.kernel.org>; Mon,  1 Aug 2022 12:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1659380421;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=FCRuF+q2DALIlkVrQH3aWH+6rk/pC3Le7Lv488Pea+w=;
    b=PqZ96eX2/h+ZAUh6fz1uyHai4vRbb3zQ5RYoliDpELEaSrcAeP12x9yqNWykKRKeMi
    6PKmMuMaZHthXxjg4vmlV2W7l5eEZO4dfL8Di0MMb+hURFt9d5K7vjUvBsceLx3LRAQf
    +GOnC60QvSK6QY48hGnQvNHnyNbyPaCIvGK1p5nc4D+S0L2lctd4c88CG3x4Nshw5SLD
    T+VCKhnXe0+Vto8ubAYrRaK3UBJedHaJK2QnP+SLq9E96OmNMEBzwWjZO0gG2EyfsqRE
    TLeJQDHRuXI/1RA2vPqHaE1Um1Yg4G/5lSNppiPbn0c6/hrp2bsccgZCvzw2zspAmjpe
    IPOg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JiLceSWJaYwXUKbZ"
X-RZG-CLASS-ID: mo01
Received: from silver.lan
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id Icb1b0y71J0LHw0
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 1 Aug 2022 21:00:21 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v8 7/7] can: raw: add CAN XL support
Date:   Mon,  1 Aug 2022 21:00:10 +0200
Message-Id: <20220801190010.3344-8-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220801190010.3344-1-socketcan@hartkopp.net>
References: <20220801190010.3344-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
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

In opposite to the fixed number of bytes for
- CAN frames (CAN_MTU = sizeof(struct can_frame))
- CAN FD frames (CANFD_MTU = sizeof(struct can_frame))
the number of bytes when reading/writing CAN XL frames depends on the
number of data bytes. For efficiency reasons the length of the struct
canxl_frame is truncated to the needed size for read/write operations.
This leads to a calculated size of CANXL_HDR_SIZE + canxl_frame::len which
is enforced on write() operations and guaranteed on read() operations.

NB: Valid length values are 1 .. 2048 (CANXL_MIN_DLEN .. CANXL_MAX_DLEN).

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can/raw.h |  1 +
 net/can/raw.c                | 55 ++++++++++++++++++++++++++++--------
 2 files changed, 44 insertions(+), 12 deletions(-)

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
index d1bd9cc51ebe..c6859a061a7c 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -48,10 +48,11 @@
 #include <linux/socket.h>
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #include <linux/can.h>
 #include <linux/can/core.h>
+#include <linux/can/dev.h> /* for can_is_canxl_dev_mtu() */
 #include <linux/can/skb.h>
 #include <linux/can/raw.h>
 #include <net/sock.h>
 #include <net/net_namespace.h>
 
@@ -85,10 +86,11 @@ struct raw_sock {
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
@@ -127,12 +129,13 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 
 	/* check the received tx sock reference */
 	if (!ro->recv_own_msgs && oskb->sk == sk)
 		return;
 
-	/* do not pass non-CAN2.0 frames to a legacy socket */
-	if (!ro->fd_frames && oskb->len != CAN_MTU)
+	/* make sure to not pass oversized frames to the socket */
+	if ((can_is_canfd_skb(oskb) && !ro->fd_frames && !ro->xl_frames) ||
+	    (can_is_canxl_skb(oskb) && !ro->xl_frames))
 		return;
 
 	/* eliminate multiple filter matches for the same skb */
 	if (this_cpu_ptr(ro->uniq)->skb == oskb &&
 	    this_cpu_ptr(ro->uniq)->skbcnt == can_skb_prv(oskb)->skbcnt) {
@@ -344,10 +347,11 @@ static int raw_init(struct sock *sk)
 
 	/* set default loopback behaviour */
 	ro->loopback         = 1;
 	ro->recv_own_msgs    = 0;
 	ro->fd_frames        = 0;
+	ro->xl_frames        = 0;
 	ro->join_filters     = 0;
 
 	/* alloc_percpu provides zero'ed memory */
 	ro->uniq = alloc_percpu(struct uniqframe);
 	if (unlikely(!ro->uniq))
@@ -667,10 +671,19 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
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
@@ -749,10 +762,16 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
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
@@ -774,11 +793,15 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	struct raw_sock *ro = raw_sk(sk);
 	struct sockcm_cookie sockc;
 	struct sk_buff *skb;
 	struct net_device *dev;
 	int ifindex;
-	int err;
+	int err = -EINVAL;
+
+	/* check for valid CAN frame sizes */
+	if (size < CANXL_HDR_SIZE + CANXL_MIN_DLEN || size > CANXL_MTU)
+		return -EINVAL;
 
 	if (msg->msg_name) {
 		DECLARE_SOCKADDR(struct sockaddr_can *, addr, msg->msg_name);
 
 		if (msg->msg_namelen < RAW_MIN_NAMELEN)
@@ -794,32 +817,40 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
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
-
 	skb = sock_alloc_send_skb(sk, size + sizeof(struct can_skb_priv),
 				  msg->msg_flags & MSG_DONTWAIT, &err);
 	if (!skb)
 		goto put_dev;
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
 	can_skb_prv(skb)->skbcnt = 0;
 
+	/* fill the skb before testing for valid CAN frames */
 	err = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (err < 0)
 		goto free_skb;
 
+	err = -EINVAL;
+	if (ro->xl_frames && can_is_canxl_dev_mtu(dev->mtu)) {
+		/* CAN XL, CAN FD and Classical CAN */
+		if (!can_is_canxl_skb(skb) && !can_is_canfd_skb(skb) &&
+		    !can_is_can_skb(skb))
+			goto free_skb;
+	} else if (ro->fd_frames && dev->mtu == CANFD_MTU) {
+		/* CAN FD and Classical CAN */
+		if (!can_is_canfd_skb(skb) && !can_is_can_skb(skb))
+			goto free_skb;
+	} else {
+		/* Classical CAN */
+		if (!can_is_can_skb(skb))
+			goto free_skb;
+	}
+
 	sockcm_init(&sockc, sk);
 	if (msg->msg_controllen) {
 		err = sock_cmsg_send(sk, msg, &sockc);
 		if (unlikely(err))
 			goto free_skb;
-- 
2.30.2

