Return-Path: <linux-can+bounces-3776-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EF4ACE1ED
	for <lists+linux-can@lfdr.de>; Wed,  4 Jun 2025 18:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5174F7A8F27
	for <lists+linux-can@lfdr.de>; Wed,  4 Jun 2025 16:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237B128DD0;
	Wed,  4 Jun 2025 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0pfRBwu"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474CD4C7C
	for <linux-can@vger.kernel.org>; Wed,  4 Jun 2025 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749053233; cv=none; b=rMd80DFc4Vg3pjBdX8M6fwwVgVbdwWHVJM8jtOn7SJQi3cfdCRRKW7hAo7yNqRTr5Y9jL6zfw35qQoFnjIVSiyy/65vbu+8cxK00S4oy387w388YB4vDTa/Oje2tOAtZrRNdk/Sy4S2X4IolT/iT/ovwFKc0T5euI48Ke/kP94U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749053233; c=relaxed/simple;
	bh=wORs7QoUPc8m9EkvvRlGtRXZaZBtr3sAYb3gpJqEzOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FPzN255VvtrA17Z9k9eXZdeIOZRjD3kW3eefl95zEP43aY+y/SMwbfHiaxnDQ6neqT1+k8mZjpp/YS+wvFIGUmsZZ8kscqz+Rt77QzP8r/MmuOq5eJOhXepuLwntQ4jfvQfjbrxo01e2qLYGvo7htJKnUlqaGYX2cTwzbKqojjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0pfRBwu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749053230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QhjuKMco+THwe/DlID2SOAHuyzdtktTWUDL3PLD1nQ8=;
	b=U0pfRBwuBY6TAjdI2BBISPTHJSFGlHt6Bk5l2ERvfcgkMAzDYXDQiZl6sbL479Wv/S7tKr
	9S4J1PgPkaCFGMCg9ip+99CYW3mPZcSfCv881pTzk/4sG8OCIWXMe/EAciDdp4C6w2zxvi
	gpzt5nS2HZiArtVOMYTWSfSPMx3nGPU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-jrJz_uf9Oe-pwV_jP4uN_w-1; Wed,
 04 Jun 2025 12:07:06 -0400
X-MC-Unique: jrJz_uf9Oe-pwV_jP4uN_w-1
X-Mimecast-MFC-AGG-ID: jrJz_uf9Oe-pwV_jP4uN_w_1749053225
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 864D319560B1;
	Wed,  4 Jun 2025 16:07:05 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.38])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7555F30002CE;
	Wed,  4 Jun 2025 16:07:02 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: linux-can@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: fstornio@redhat.com,
	fmaurer@redhat.com
Subject: [PATCH 2/2] can: add drop reasons in CAN protocols receive path
Date: Wed,  4 Jun 2025 18:06:05 +0200
Message-ID: <20250604160605.1005704-3-dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

sock_queue_rcv_skb() can fail because of lack of memory resources: use
drop reasons and pass the receiving socket to the tracepoint, so that
it's possible to better locate/debug such events.

Tested with:

| # modprobe vcan echo=1
| # ip link add name vcan2 type vcan
| # ip link set dev vcan2 up
| # ./netlayer/tst-proc 1 &
| # bg
| # while true ; do perf record -e skb:kfree_skb -aR  -- \
| > ./raw/tst-raw-sendto vcan2 ; perf script ; done
| [...]
| tst-raw-sendto 10942 [000] 506428.431856: skb:kfree_skb: skbaddr=0xffff97cec38b4200 rx_sk=0xffff97cf0f75a800 protocol=12 location=raw_rcv+0x20e reason: SOCKET_RCVBUF

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 net/can/bcm.c          | 5 +++--
 net/can/isotp.c        | 5 +++--
 net/can/j1939/socket.c | 5 +++--
 net/can/raw.c          | 5 +++--
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 6dc041e054ba..4ece0e847e96 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -338,6 +338,7 @@ static void bcm_send_to_user(struct bcm_op *op, struct bcm_msg_head *head,
 	unsigned int datalen = head->nframes * op->cfsiz;
 	int err;
 	unsigned int *pflags;
+	enum skb_drop_reason reason;
 
 	skb = alloc_skb(sizeof(*head) + datalen, gfp_any());
 	if (!skb)
@@ -392,11 +393,11 @@ static void bcm_send_to_user(struct bcm_op *op, struct bcm_msg_head *head,
 	addr->can_family  = AF_CAN;
 	addr->can_ifindex = op->rx_ifindex;
 
-	err = sock_queue_rcv_skb(sk, skb);
+	err = sock_queue_rcv_skb_reason(sk, skb, &reason);
 	if (err < 0) {
 		struct bcm_sock *bo = bcm_sk(sk);
 
-		kfree_skb(skb);
+		sk_skb_reason_drop(sk, skb, reason);
 		/* don't care about overflows in this statistic */
 		bo->dropped_usr_msgs++;
 	}
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 789583c62f98..eaf27ba062d5 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -278,6 +278,7 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 static void isotp_rcv_skb(struct sk_buff *skb, struct sock *sk)
 {
 	struct sockaddr_can *addr = (struct sockaddr_can *)skb->cb;
+	enum skb_drop_reason reason;
 
 	BUILD_BUG_ON(sizeof(skb->cb) < sizeof(struct sockaddr_can));
 
@@ -285,8 +286,8 @@ static void isotp_rcv_skb(struct sk_buff *skb, struct sock *sk)
 	addr->can_family = AF_CAN;
 	addr->can_ifindex = skb->dev->ifindex;
 
-	if (sock_queue_rcv_skb(sk, skb) < 0)
-		kfree_skb(skb);
+	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0)
+		sk_skb_reason_drop(sk, skb, reason);
 }
 
 static u8 padlen(u8 datalen)
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 382c9a97f8e6..96221b2d9f44 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -311,6 +311,7 @@ static void j1939_sk_recv_one(struct j1939_sock *jsk, struct sk_buff *oskb)
 {
 	const struct j1939_sk_buff_cb *oskcb = j1939_skb_to_cb(oskb);
 	struct j1939_sk_buff_cb *skcb;
+	enum skb_drop_reason reason;
 	struct sk_buff *skb;
 
 	if (oskb->sk == &jsk->sk)
@@ -331,8 +332,8 @@ static void j1939_sk_recv_one(struct j1939_sock *jsk, struct sk_buff *oskb)
 	if (skb->sk)
 		skcb->msg_flags |= MSG_DONTROUTE;
 
-	if (sock_queue_rcv_skb(&jsk->sk, skb) < 0)
-		kfree_skb(skb);
+	if (sock_queue_rcv_skb_reason(&jsk->sk, skb, &reason) < 0)
+		sk_skb_reason_drop(&jsk->sk, skb, reason);
 }
 
 bool j1939_sk_recv_match(struct j1939_priv *priv, struct j1939_sk_buff_cb *skcb)
diff --git a/net/can/raw.c b/net/can/raw.c
index 020f21430b1d..76b867d21def 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -129,6 +129,7 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 {
 	struct sock *sk = (struct sock *)data;
 	struct raw_sock *ro = raw_sk(sk);
+	enum skb_drop_reason reason;
 	struct sockaddr_can *addr;
 	struct sk_buff *skb;
 	unsigned int *pflags;
@@ -205,8 +206,8 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 	if (oskb->sk == sk)
 		*pflags |= MSG_CONFIRM;
 
-	if (sock_queue_rcv_skb(sk, skb) < 0)
-		kfree_skb(skb);
+	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0)
+		sk_skb_reason_drop(sk, skb, reason);
 }
 
 static int raw_enable_filters(struct net *net, struct net_device *dev,
-- 
2.27.0


