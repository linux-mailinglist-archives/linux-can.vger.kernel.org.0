Return-Path: <linux-can+bounces-3788-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3ECAD32BC
	for <lists+linux-can@lfdr.de>; Tue, 10 Jun 2025 11:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB073A254C
	for <lists+linux-can@lfdr.de>; Tue, 10 Jun 2025 09:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A184028D8F3;
	Tue, 10 Jun 2025 09:49:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4B928C2C5
	for <linux-can@vger.kernel.org>; Tue, 10 Jun 2025 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548983; cv=none; b=tvjfdin0J6Bh+xjpHgsPrlqtTih7izFskQxTro32dwaC+4Q/TyYWWPcHzkTKGl+7aU+LNbhMfaKABF89oNe6Cve7VKiguDqNm1QUZd8RFffPUzGzi8g8ZJRC5ITjllCg0iNrvOZdjDFCQGW62yQF8R28lRNM9ubsR+qaA6X6h00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548983; c=relaxed/simple;
	bh=sfksOESy/54OYTsecxQUt2yOqobn76gzeR6X8QIzFQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNVle04yD9b2/pAx/TYl35DrZq8iGeEDVf2LpTrcOs6wrAxh9rJRPkU36aj00DVMBvmcBQmevp6AHR21XzS66iPokUbyc22SwtGSVWuVtTFgiK8PhW9f1cybomXA7GhCfXEX/K7nR9i8GmMxd+8U1jyTuJdvrTByJ1HZmXksuRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uOvbv-00068L-Lc
	for linux-can@vger.kernel.org; Tue, 10 Jun 2025 11:49:39 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uOvbu-002keG-2O
	for linux-can@vger.kernel.org;
	Tue, 10 Jun 2025 11:49:38 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 6A75F4241BC
	for <linux-can@vger.kernel.org>; Tue, 10 Jun 2025 09:49:38 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id AA60042418C;
	Tue, 10 Jun 2025 09:49:35 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d159747e;
	Tue, 10 Jun 2025 09:49:34 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Davide Caratti <dcaratti@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 7/7] can: add drop reasons in CAN protocols receive path
Date: Tue, 10 Jun 2025 11:46:22 +0200
Message-ID: <20250610094933.1593081-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610094933.1593081-1-mkl@pengutronix.de>
References: <20250610094933.1593081-1-mkl@pengutronix.de>
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

From: Davide Caratti <dcaratti@redhat.com>

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
Link: https://patch.msgid.link/20250604160605.1005704-3-dcaratti@redhat.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/bcm.c          | 5 +++--
 net/can/isotp.c        | 5 +++--
 net/can/j1939/socket.c | 5 +++--
 net/can/raw.c          | 5 +++--
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 6bc1cc4c94c5..5e690a2377e4 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -359,6 +359,7 @@ static void bcm_send_to_user(struct bcm_op *op, struct bcm_msg_head *head,
 	unsigned int datalen = head->nframes * op->cfsiz;
 	int err;
 	unsigned int *pflags;
+	enum skb_drop_reason reason;
 
 	skb = alloc_skb(sizeof(*head) + datalen, gfp_any());
 	if (!skb)
@@ -413,11 +414,11 @@ static void bcm_send_to_user(struct bcm_op *op, struct bcm_msg_head *head,
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
index 1efa377f002e..dee1412b3c9c 100644
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
index 6fefe7a68761..3d8b588822f9 100644
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
2.47.2



