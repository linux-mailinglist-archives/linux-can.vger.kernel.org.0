Return-Path: <linux-can+bounces-136-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A7A833331
	for <lists+linux-can@lfdr.de>; Sat, 20 Jan 2024 09:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44FA21F21892
	for <lists+linux-can@lfdr.de>; Sat, 20 Jan 2024 08:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6DF2106;
	Sat, 20 Jan 2024 08:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="K2FPqvI8";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="b2f0Gs1f"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CDD2105
	for <linux-can@vger.kernel.org>; Sat, 20 Jan 2024 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705738446; cv=pass; b=eXFZzbV9Tds94aot5/IDXVa7ZN0FlcKEFpNtcN0QMTUD+ZgItc+EYTicsZ/tcjl+6yXavxGSUF+reLNpkkoDxLcW5qSP83CFA6SAVZZYa0z+3CqTNyo5qVlqe8+w9ddaJzF+ScI0v83xiMjyWA05gzVcuwpFnBRv24FX/cANaOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705738446; c=relaxed/simple;
	bh=CNT7aCFlP8mRTt05LPRTSa08aykDDagCyXLjFyaTTUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=p0KWWwGn9vPOD3Od5kkXeOyvSg9SKDsVobBYnDI/tmdlyb+BhUNpqtIjFRpmBnQ82p9GCFAh3NLaTL055PcsJ83uY4hQsCez1JEW8rzt/aogq3V2NJnAMIB7C+n0iJNAtVfixF5+KJZWt9kwUyk+PX0Yjjhp5yrxsUrsAI3Quak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=K2FPqvI8; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=b2f0Gs1f; arc=pass smtp.client-ip=81.169.146.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1705738252; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MA/TocokrTvSb4rNhcYkduknuAQCvyYIKqNItdDklv6dZuEMaSKmr+vYrqJgu91WC0
    VbPgO9+FYqTAkJrrp3/WIWIiwjYuZBK+xiEP1qEQaT5AN2vxC7e9zZKnGKAgrrEdFyxc
    m9RypnxlmuDL3i7WftnPEe9E00Y0DDqIraUCTulsdTNq8uWEjnwprhzfePJ6NhCRDmnY
    oortY76cY6lIDl1s/+ZQSlQrCfr+8wTg8JmuDRMYkeHcLzNTLqi0IP2P2Mz77NQVMv32
    8Jgqz2D2xsyRKkHkIZQrG9MOy4E6geu6Q1Yc0QE70/PjcCZfHQUiGIN+ZUovAWyc3HmU
    k2OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1705738252;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=DlI30iWqlNPXhWxKH1WMTSTBUv1Hs4ROy1o1Qudad/g=;
    b=Ry6w1PstvcT+3z2+zWfUalNVqj3JDHczIAM7wKVdtwtdOSw4zoWQ940PdPPThFE0gq
    yqAlxfSYuZBwUYcX0snl+DWzCkdkeQZ5iox0ayQo9VYV3LYKLjJUFCGj1OnYjaKmKPDh
    OAIN/f0FdUg8VM7Agf4+AeHvq1Jw7+rceBR3CzQFgQmnfAxcczMQ3DJaAbRu04hvy1Rm
    tJ07fIym4FG4LjYSlUWv46vhsIr2LVDSPg4oVjbq+bowKeCnajVGoIQ/loyXerMunfqZ
    CLq9rAYgmyn9bui6/BsnknD9lpDluAhtkoLDvaDnXbn6axJ2r0LaNZ2exVxmUOgN5T0b
    4qDg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1705738252;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=DlI30iWqlNPXhWxKH1WMTSTBUv1Hs4ROy1o1Qudad/g=;
    b=K2FPqvI8Jr5C+t+Tl3htdXJ35XuxXY/8rusPZL7GwwJghUttOIZoqjlX8oGSkxizGC
    oWlA485fgiGvNV41+6PW8FunuYZB1qPmE8McWmHK3MGm6xsxuJAgHbWBNpnEivG511Jz
    3++i2pIuXlP8LCZXf63+FCzVzrzNseBOBg+bTT+zTZsy3KMdwgsZG9YJC2SVVw7h7ll1
    xZsXi88gDtuX237sSEyY1vEVAL07orELk4oPx4K2E5WWXJ28khWG6OwXJEuWbzDve8YI
    1JtHLp8c7i1sKAlaAy7gZUMiBWhFWUmBsWqY6Y26tSjArCd7+Rgajif+veH5Ng61GuPk
    cNjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1705738252;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=DlI30iWqlNPXhWxKH1WMTSTBUv1Hs4ROy1o1Qudad/g=;
    b=b2f0Gs1fIJfuqWBAKCS5yWQNVAqrR6gRVo1wEs53Ij7YPeGHdPozXotJZUuq08a+/d
    kRMbDvytQVJtmevrrGDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmVcfhbrd"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 49.10.2 AUTH)
    with ESMTPSA id K7b2c200K8AqbRJ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 20 Jan 2024 09:10:52 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Nicolas Maier <nicolas.maier.dev@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v3] can: bcm: add recvmsg flags for own, local and remote traffic
Date: Sat, 20 Jan 2024 09:10:18 +0100
Message-Id: <20240120081018.2319-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Nicolas Maier <nicolas.maier.dev@gmail.com>

CAN RAW sockets allow userspace to tell if a received CAN frame comes
from the same socket, another socket on the same host, or another host.
See commit 1e55659ce6dd ("can-raw: add msg_flags to distinguish local
traffic"). However, this feature is missing in CAN BCM sockets.

Add the same feature to CAN BCM sockets. When reading a received frame
(opcode RX_CHANGED) using recvmsg, two flags in msg->msg_flags may be
set following the previous convention (from CAN RAW), to distinguish
between 'own', 'local' and 'remote' CAN traffic.

Update the documentation to reflect this change.

Signed-off-by: Nicolas Maier <nicolas.maier.dev@gmail.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---

v2:
* add 'traffic_flags' parameter to bcm_rx_update_and_send and
  bcm_rx_cmp_to_index, to put the flags in the can frame after its data
  has been copied

v3:
* add missing initialization of msg flags and check for the needed cb
  space for sockaddr_can and the msg flags only once

 Documentation/networking/can.rst | 34 ++++++++--------
 net/can/bcm.c                    | 69 ++++++++++++++++++++++++++------
 2 files changed, 75 insertions(+), 28 deletions(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index d7e1ada905b2..62519d38c58b 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -442,10 +442,28 @@ definitions are specified for CAN specific MTUs in include/linux/can.h:
 
   #define CAN_MTU   (sizeof(struct can_frame))   == 16  => Classical CAN frame
   #define CANFD_MTU (sizeof(struct canfd_frame)) == 72  => CAN FD frame
 
 
+Returned Message Flags
+----------------------
+
+When using the system call recvmsg(2) on a RAW or a BCM socket, the
+msg->msg_flags field may contain the following flags:
+
+MSG_DONTROUTE:
+	set when the received frame was created on the local host.
+
+MSG_CONFIRM:
+	set when the frame was sent via the socket it is received on.
+	This flag can be interpreted as a 'transmission confirmation' when the
+	CAN driver supports the echo of frames on driver level, see
+	:ref:`socketcan-local-loopback1` and :ref:`socketcan-local-loopback2`.
+	(Note: In order to receive such messages on a RAW socket,
+	CAN_RAW_RECV_OWN_MSGS must be set.)
+
+
 .. _socketcan-raw-sockets:
 
 RAW Protocol Sockets with can_filters (SOCK_RAW)
 ------------------------------------------------
 
@@ -691,26 +709,10 @@ semantic for the applied filters is therefore changed to a logical AND.
 This is useful especially when the filterset is a combination of filters
 where the CAN_INV_FILTER flag is set in order to notch single CAN IDs or
 CAN ID ranges from the incoming traffic.
 
 
-RAW Socket Returned Message Flags
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-When using recvmsg() call, the msg->msg_flags may contain following flags:
-
-MSG_DONTROUTE:
-	set when the received frame was created on the local host.
-
-MSG_CONFIRM:
-	set when the frame was sent via the socket it is received on.
-	This flag can be interpreted as a 'transmission confirmation' when the
-	CAN driver supports the echo of frames on driver level, see
-	:ref:`socketcan-local-loopback1` and :ref:`socketcan-local-loopback2`.
-	In order to receive such messages, CAN_RAW_RECV_OWN_MSGS must be set.
-
-
 Broadcast Manager Protocol Sockets (SOCK_DGRAM)
 -----------------------------------------------
 
 The Broadcast Manager protocol provides a command based configuration
 interface to filter and send (e.g. cyclic) CAN messages in kernel space.
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 9168114fc87f..27d5fcf0eac9 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -70,13 +70,15 @@
 
 /* limit timers to 400 days for sending/timeouts */
 #define BCM_TIMER_SEC_MAX (400 * 24 * 60 * 60)
 
 /* use of last_frames[index].flags */
+#define RX_LOCAL   0x10 /* frame was created on the local host */
+#define RX_OWN     0x20 /* frame was sent via the socket it was received on */
 #define RX_RECV    0x40 /* received data for this element */
 #define RX_THR     0x80 /* element not been sent due to throttle feature */
-#define BCM_CAN_FLAGS_MASK 0x3F /* to clean private flags after usage */
+#define BCM_CAN_FLAGS_MASK 0x0F /* to clean private flags after usage */
 
 /* get best masking value for can_rx_register() for a given single can_id */
 #define REGMASK(id) ((id & CAN_EFF_FLAG) ? \
 		     (CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG) : \
 		     (CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG))
@@ -136,10 +138,20 @@ struct bcm_sock {
 
 static LIST_HEAD(bcm_notifier_list);
 static DEFINE_SPINLOCK(bcm_notifier_lock);
 static struct bcm_sock *bcm_busy_notifier;
 
+/* Return pointer to store the extra msg flags for bcm_recvmsg().
+ * We use the space of one unsigned int beyond the 'struct sockaddr_can'
+ * in skb->cb.
+ */
+static inline unsigned int *bcm_flags(struct sk_buff *skb)
+{
+	/* return pointer after struct sockaddr_can */
+	return (unsigned int *)(&((struct sockaddr_can *)skb->cb)[1]);
+}
+
 static inline struct bcm_sock *bcm_sk(const struct sock *sk)
 {
 	return (struct bcm_sock *)sk;
 }
 
@@ -323,17 +335,26 @@ static void bcm_send_to_user(struct bcm_op *op, struct bcm_msg_head *head,
 	struct canfd_frame *firstframe;
 	struct sockaddr_can *addr;
 	struct sock *sk = op->sk;
 	unsigned int datalen = head->nframes * op->cfsiz;
 	int err;
+	unsigned int *pflags;
 
 	skb = alloc_skb(sizeof(*head) + datalen, gfp_any());
 	if (!skb)
 		return;
 
 	skb_put_data(skb, head, sizeof(*head));
 
+	/* ensure space for sockaddr_can and msg flags */
+	sock_skb_cb_check_size(sizeof(struct sockaddr_can) +
+			       sizeof(unsigned int));
+
+	/* initialize msg flags */
+	pflags = bcm_flags(skb);
+	*pflags = 0;
+
 	if (head->nframes) {
 		/* CAN frames starting here */
 		firstframe = (struct canfd_frame *)skb_tail_pointer(skb);
 
 		skb_put_data(skb, frames, datalen);
@@ -342,12 +363,18 @@ static void bcm_send_to_user(struct bcm_op *op, struct bcm_msg_head *head,
 		 * the BCM uses the flags-element of the canfd_frame
 		 * structure for internal purposes. This is only
 		 * relevant for updates that are generated by the
 		 * BCM, where nframes is 1
 		 */
-		if (head->nframes == 1)
+		if (head->nframes == 1) {
+			if (firstframe->flags & RX_LOCAL)
+				*pflags |= MSG_DONTROUTE;
+			if (firstframe->flags & RX_OWN)
+				*pflags |= MSG_CONFIRM;
+
 			firstframe->flags &= BCM_CAN_FLAGS_MASK;
+		}
 	}
 
 	if (has_timestamp) {
 		/* restore rx timestamp */
 		skb->tstamp = op->rx_stamp;
@@ -358,11 +385,10 @@ static void bcm_send_to_user(struct bcm_op *op, struct bcm_msg_head *head,
 	 *  get it from there.  We need to pass the interface index to
 	 *  bcm_recvmsg().  We pass a whole struct sockaddr_can in skb->cb
 	 *  containing the interface index.
 	 */
 
-	sock_skb_cb_check_size(sizeof(struct sockaddr_can));
 	addr = (struct sockaddr_can *)skb->cb;
 	memset(addr, 0, sizeof(*addr));
 	addr->can_family  = AF_CAN;
 	addr->can_ifindex = op->rx_ifindex;
 
@@ -442,11 +468,11 @@ static void bcm_rx_changed(struct bcm_op *op, struct canfd_frame *data)
 	/* prevent statistics overflow */
 	if (op->frames_filtered > ULONG_MAX/100)
 		op->frames_filtered = op->frames_abs = 0;
 
 	/* this element is not throttled anymore */
-	data->flags &= (BCM_CAN_FLAGS_MASK|RX_RECV);
+	data->flags &= ~RX_THR;
 
 	memset(&head, 0, sizeof(head));
 	head.opcode  = RX_CHANGED;
 	head.flags   = op->flags;
 	head.count   = op->count;
@@ -463,17 +489,21 @@ static void bcm_rx_changed(struct bcm_op *op, struct canfd_frame *data)
  *                          1. update the last received data
  *                          2. send a notification to the user (if possible)
  */
 static void bcm_rx_update_and_send(struct bcm_op *op,
 				   struct canfd_frame *lastdata,
-				   const struct canfd_frame *rxdata)
+				   const struct canfd_frame *rxdata,
+				   unsigned char traffic_flags)
 {
 	memcpy(lastdata, rxdata, op->cfsiz);
 
 	/* mark as used and throttled by default */
 	lastdata->flags |= (RX_RECV|RX_THR);
 
+	/* add own/local/remote traffic flags */
+	lastdata->flags |= traffic_flags;
+
 	/* throttling mode inactive ? */
 	if (!op->kt_ival2) {
 		/* send RX_CHANGED to the user immediately */
 		bcm_rx_changed(op, lastdata);
 		return;
@@ -506,11 +536,12 @@ static void bcm_rx_update_and_send(struct bcm_op *op,
 /*
  * bcm_rx_cmp_to_index - (bit)compares the currently received data to formerly
  *                       received data stored in op->last_frames[]
  */
 static void bcm_rx_cmp_to_index(struct bcm_op *op, unsigned int index,
-				const struct canfd_frame *rxdata)
+				const struct canfd_frame *rxdata,
+				unsigned char traffic_flags)
 {
 	struct canfd_frame *cf = op->frames + op->cfsiz * index;
 	struct canfd_frame *lcf = op->last_frames + op->cfsiz * index;
 	int i;
 
@@ -519,27 +550,27 @@ static void bcm_rx_cmp_to_index(struct bcm_op *op, unsigned int index,
 	 * so we use it here to detect the first time of reception
 	 */
 
 	if (!(lcf->flags & RX_RECV)) {
 		/* received data for the first time => send update to user */
-		bcm_rx_update_and_send(op, lcf, rxdata);
+		bcm_rx_update_and_send(op, lcf, rxdata, traffic_flags);
 		return;
 	}
 
 	/* do a real check in CAN frame data section */
 	for (i = 0; i < rxdata->len; i += 8) {
 		if ((get_u64(cf, i) & get_u64(rxdata, i)) !=
 		    (get_u64(cf, i) & get_u64(lcf, i))) {
-			bcm_rx_update_and_send(op, lcf, rxdata);
+			bcm_rx_update_and_send(op, lcf, rxdata, traffic_flags);
 			return;
 		}
 	}
 
 	if (op->flags & RX_CHECK_DLC) {
 		/* do a real check in CAN frame length */
 		if (rxdata->len != lcf->len) {
-			bcm_rx_update_and_send(op, lcf, rxdata);
+			bcm_rx_update_and_send(op, lcf, rxdata, traffic_flags);
 			return;
 		}
 	}
 }
 
@@ -642,10 +673,11 @@ static enum hrtimer_restart bcm_rx_thr_handler(struct hrtimer *hrtimer)
 static void bcm_rx_handler(struct sk_buff *skb, void *data)
 {
 	struct bcm_op *op = (struct bcm_op *)data;
 	const struct canfd_frame *rxframe = (struct canfd_frame *)skb->data;
 	unsigned int i;
+	unsigned char traffic_flags;
 
 	if (op->can_id != rxframe->can_id)
 		return;
 
 	/* make sure to handle the correct frame type (CAN / CAN FD) */
@@ -671,19 +703,28 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 		/* send reply for RTR-request (placed in op->frames[0]) */
 		bcm_can_tx(op);
 		return;
 	}
 
+	/* compute flags to distinguish between own/local/remote CAN traffic */
+	traffic_flags = 0;
+	if (skb->sk) {
+		traffic_flags |= RX_LOCAL;
+		if (skb->sk == op->sk)
+			traffic_flags |= RX_OWN;
+	}
+
 	if (op->flags & RX_FILTER_ID) {
 		/* the easiest case */
-		bcm_rx_update_and_send(op, op->last_frames, rxframe);
+		bcm_rx_update_and_send(op, op->last_frames, rxframe,
+				       traffic_flags);
 		goto rx_starttimer;
 	}
 
 	if (op->nframes == 1) {
 		/* simple compare with index 0 */
-		bcm_rx_cmp_to_index(op, 0, rxframe);
+		bcm_rx_cmp_to_index(op, 0, rxframe, traffic_flags);
 		goto rx_starttimer;
 	}
 
 	if (op->nframes > 1) {
 		/*
@@ -696,11 +737,12 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 
 		for (i = 1; i < op->nframes; i++) {
 			if ((get_u64(op->frames, 0) & get_u64(rxframe, 0)) ==
 			    (get_u64(op->frames, 0) &
 			     get_u64(op->frames + op->cfsiz * i, 0))) {
-				bcm_rx_cmp_to_index(op, i, rxframe);
+				bcm_rx_cmp_to_index(op, i, rxframe,
+						    traffic_flags);
 				break;
 			}
 		}
 	}
 
@@ -1673,10 +1715,13 @@ static int bcm_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		__sockaddr_check_size(BCM_MIN_NAMELEN);
 		msg->msg_namelen = BCM_MIN_NAMELEN;
 		memcpy(msg->msg_name, skb->cb, msg->msg_namelen);
 	}
 
+	/* assign the flags that have been recorded in bcm_send_to_user() */
+	msg->msg_flags |= *(bcm_flags(skb));
+
 	skb_free_datagram(sk, skb);
 
 	return size;
 }
 
-- 
2.39.2


