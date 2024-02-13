Return-Path: <linux-can+bounces-245-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7B6852F71
	for <lists+linux-can@lfdr.de>; Tue, 13 Feb 2024 12:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712941C21330
	for <lists+linux-can@lfdr.de>; Tue, 13 Feb 2024 11:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF34383B4;
	Tue, 13 Feb 2024 11:34:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426D537144
	for <linux-can@vger.kernel.org>; Tue, 13 Feb 2024 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824086; cv=none; b=in1dwNxI9+zW8u7CHQfEgqVaZ8HCUnl4UywDnx0cH2pYQ0G36ELat7kaNQSV3DH8MEYn2Yz9Tey8I49of/l1pbft4ymQPWL5XmAWLvM1mty+2FY8B0mtjbMsDNU/eyE5QR/loIUOzSvRnDy6JuUSvGCn9WO03J+mhVSNKZRTwXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824086; c=relaxed/simple;
	bh=KLi0/FAg/Bav3TH0PUn7u/UAA9/NYMyQ//t9F6wlva8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGQFVYuELxgC48HHr8+EF7vtiQoLb/7CJjotrNTmjE2ThPH9vRULQSeo41MHoi4LlZwKP5arpXy9zRJCrXWkw/L9MxkPrHxQahn1zIknH4Wgjpkqfr2M7dLsXJFoaun4bJSDRhaLvQ1esrAqKA7AeP/JOvuvS0QGyCiNw5UDJ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZr3i-000164-8h
	for linux-can@vger.kernel.org; Tue, 13 Feb 2024 12:34:42 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZr3h-000TR4-4Z
	for linux-can@vger.kernel.org; Tue, 13 Feb 2024 12:34:41 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 75B6628D64E
	for <linux-can@vger.kernel.org>; Tue, 13 Feb 2024 11:34:40 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id BBD6E28D622;
	Tue, 13 Feb 2024 11:34:38 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1004fc2b;
	Tue, 13 Feb 2024 11:34:38 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Nicolas Maier <nicolas.maier.dev@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 01/23] can: bcm: add recvmsg flags for own, local and remote traffic
Date: Tue, 13 Feb 2024 12:25:04 +0100
Message-ID: <20240213113437.1884372-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213113437.1884372-1-mkl@pengutronix.de>
References: <20240213113437.1884372-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

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
Link: https://lore.kernel.org/all/20240120081018.2319-1-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/networking/can.rst | 34 ++++++++--------
 net/can/bcm.c                    | 69 ++++++++++++++++++++++++++------
 2 files changed, 75 insertions(+), 28 deletions(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index d7e1ada905b2..62519d38c58b 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -444,6 +444,24 @@ definitions are specified for CAN specific MTUs in include/linux/can.h:
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
@@ -693,22 +711,6 @@ where the CAN_INV_FILTER flag is set in order to notch single CAN IDs or
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
 
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 9168114fc87f..27d5fcf0eac9 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -72,9 +72,11 @@
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
@@ -138,6 +140,16 @@ static LIST_HEAD(bcm_notifier_list);
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
@@ -325,6 +337,7 @@ static void bcm_send_to_user(struct bcm_op *op, struct bcm_msg_head *head,
 	struct sock *sk = op->sk;
 	unsigned int datalen = head->nframes * op->cfsiz;
 	int err;
+	unsigned int *pflags;
 
 	skb = alloc_skb(sizeof(*head) + datalen, gfp_any());
 	if (!skb)
@@ -332,6 +345,14 @@ static void bcm_send_to_user(struct bcm_op *op, struct bcm_msg_head *head,
 
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
@@ -344,8 +365,14 @@ static void bcm_send_to_user(struct bcm_op *op, struct bcm_msg_head *head,
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
@@ -360,7 +387,6 @@ static void bcm_send_to_user(struct bcm_op *op, struct bcm_msg_head *head,
 	 *  containing the interface index.
 	 */
 
-	sock_skb_cb_check_size(sizeof(struct sockaddr_can));
 	addr = (struct sockaddr_can *)skb->cb;
 	memset(addr, 0, sizeof(*addr));
 	addr->can_family  = AF_CAN;
@@ -444,7 +470,7 @@ static void bcm_rx_changed(struct bcm_op *op, struct canfd_frame *data)
 		op->frames_filtered = op->frames_abs = 0;
 
 	/* this element is not throttled anymore */
-	data->flags &= (BCM_CAN_FLAGS_MASK|RX_RECV);
+	data->flags &= ~RX_THR;
 
 	memset(&head, 0, sizeof(head));
 	head.opcode  = RX_CHANGED;
@@ -465,13 +491,17 @@ static void bcm_rx_changed(struct bcm_op *op, struct canfd_frame *data)
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
@@ -508,7 +538,8 @@ static void bcm_rx_update_and_send(struct bcm_op *op,
  *                       received data stored in op->last_frames[]
  */
 static void bcm_rx_cmp_to_index(struct bcm_op *op, unsigned int index,
-				const struct canfd_frame *rxdata)
+				const struct canfd_frame *rxdata,
+				unsigned char traffic_flags)
 {
 	struct canfd_frame *cf = op->frames + op->cfsiz * index;
 	struct canfd_frame *lcf = op->last_frames + op->cfsiz * index;
@@ -521,7 +552,7 @@ static void bcm_rx_cmp_to_index(struct bcm_op *op, unsigned int index,
 
 	if (!(lcf->flags & RX_RECV)) {
 		/* received data for the first time => send update to user */
-		bcm_rx_update_and_send(op, lcf, rxdata);
+		bcm_rx_update_and_send(op, lcf, rxdata, traffic_flags);
 		return;
 	}
 
@@ -529,7 +560,7 @@ static void bcm_rx_cmp_to_index(struct bcm_op *op, unsigned int index,
 	for (i = 0; i < rxdata->len; i += 8) {
 		if ((get_u64(cf, i) & get_u64(rxdata, i)) !=
 		    (get_u64(cf, i) & get_u64(lcf, i))) {
-			bcm_rx_update_and_send(op, lcf, rxdata);
+			bcm_rx_update_and_send(op, lcf, rxdata, traffic_flags);
 			return;
 		}
 	}
@@ -537,7 +568,7 @@ static void bcm_rx_cmp_to_index(struct bcm_op *op, unsigned int index,
 	if (op->flags & RX_CHECK_DLC) {
 		/* do a real check in CAN frame length */
 		if (rxdata->len != lcf->len) {
-			bcm_rx_update_and_send(op, lcf, rxdata);
+			bcm_rx_update_and_send(op, lcf, rxdata, traffic_flags);
 			return;
 		}
 	}
@@ -644,6 +675,7 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 	struct bcm_op *op = (struct bcm_op *)data;
 	const struct canfd_frame *rxframe = (struct canfd_frame *)skb->data;
 	unsigned int i;
+	unsigned char traffic_flags;
 
 	if (op->can_id != rxframe->can_id)
 		return;
@@ -673,15 +705,24 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
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
 
@@ -698,7 +739,8 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 			if ((get_u64(op->frames, 0) & get_u64(rxframe, 0)) ==
 			    (get_u64(op->frames, 0) &
 			     get_u64(op->frames + op->cfsiz * i, 0))) {
-				bcm_rx_cmp_to_index(op, i, rxframe);
+				bcm_rx_cmp_to_index(op, i, rxframe,
+						    traffic_flags);
 				break;
 			}
 		}
@@ -1675,6 +1717,9 @@ static int bcm_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		memcpy(msg->msg_name, skb->cb, msg->msg_namelen);
 	}
 
+	/* assign the flags that have been recorded in bcm_send_to_user() */
+	msg->msg_flags |= *(bcm_flags(skb));
+
 	skb_free_datagram(sk, skb);
 
 	return size;

base-commit: 970cb1ceda170a3e583a5f26afdbebdfe5bf5a80
-- 
2.43.0



