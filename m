Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7C86D1DF6
	for <lists+linux-can@lfdr.de>; Fri, 31 Mar 2023 12:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjCaKYQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 31 Mar 2023 06:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjCaKXm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 31 Mar 2023 06:23:42 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30671F7AB
        for <linux-can@vger.kernel.org>; Fri, 31 Mar 2023 03:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680258083; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=i9gqkH7AvhRMgor3uKTV2NP3Vess5+EUl2Qe0S4J+uR0fim1xIY3IgpIW3RzAlSVzN
    m2I8ZtHDUmkey3lZPu+Wa3nhtFLclerPPVVJX9KFvMY0MKed6sFOgIpMYw+dpPwn7dRO
    uRJ2mMq30SHnChn9KgvOv40r0NeWewAFVHi9FX8cxK4NEdUzOzeb6pk2ZCsjBMaTE3MF
    yy9p2sNrSMqEaIzZXeMPiY6EXpDFcq8Rjqs0kp/EMXwLawH/sn96B7cSSZjbUdXIdhm+
    WFnfm+a/qiolhDEIXJST2ftw/5FTA9S6XdK9bs7DHvHher+bXa5WCA5DGQZa+YHgYDes
    4mwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680258083;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=OZfKMp3hbWVwYxe/xWo0VVUv815K1mwjhAPVFKOWY9U=;
    b=HJRPOzCAVg7CFXMoLGw3maUxaQcg/72UnuYKjNF6BbMLA5HGu5zj2v4D7PmtKbn/b5
    DhbzuTaRhmJ97m9IJSgMl1kCtak8tOh5k7O7spsPB0Vykgx2BAGw1ttFMq/Vbkh2sDB1
    edPxjucxyWIc3RMB8Gb0AA8UmtTI8iA84UiVLZwkKVVu6sTU/Y10W4E6Q7JonKXpmIpq
    HVvCRBCdVXFctXxwlax1pnjlLtEZldh/brItGPt7VrwVNyuqPzlLAEe7GgzbIOasbbr6
    UfNV6Qr8MFiXgJEEl3BPYhj3Kr9rvVDihWJfmX0ULlhkOcxp6GSN6GnyhSnH8OJsycPp
    hBug==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680258083;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=OZfKMp3hbWVwYxe/xWo0VVUv815K1mwjhAPVFKOWY9U=;
    b=SBe8w4Dx0B+9sib9yjJPMfCGDL69xViD4+ZYY6Ru7PRTtqcL76hIArm0x27FGuGjdY
    zFaTNsDbyi7AiD/8TQclK2SH3ESemR99PuwPHLjNtzZpeVPApAu1repxdxwP/ZRl1NE6
    uuYeU9V7HENwgrTXTz/AUta2uz9fktGgBVFgoltUPy+jHpKmRsAUYRy2blEIt03dVSeI
    0qrXiEoUFdE2zuzodfYZdvuH6iql79jklrmHTRStL6ixSdnhIMWigbXiXKFVcx/R83Fu
    V6u+dfTicUNt8Vn0/z4L9rVwBDY4PlVVVBUnhO/6oKM2fCW61+oUU4Qg8sozm26mUlhh
    pQ5A==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmVcfh+rd"
Received: from silver.lan
    by smtp.strato.de (RZmta 49.3.1 AUTH)
    with ESMTPSA id n9397fz2VALMii2
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 31 Mar 2023 12:21:22 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        "Dae R . Jeong" <threeearcat@gmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: [RFC PATCH] can: isotp: fix race between isotp_sendsmg() and isotp_release()
Date:   Fri, 31 Mar 2023 12:21:14 +0200
Message-Id: <20230331102114.15164-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

As discussed with Dae R. Jeong and Hillf Danton here [1] the sendmsg()
function in isotp.c might get into a race condition when restoring the
former tx.state from the old_state. This patch removes the old_state
concept and implements a proper locking for ISOTP_IDLE transitions in
isotp_sendmsg() inspired by a simplification idea from Hillf Danton.
Additionally a new tx.state ISOTP_SHUTDOWN has been introduced to use
the same locking mechanism from isotp_release() which resolves a
potential race between isotp_sendsmg() and isotp_release().

[1] https://lore.kernel.org/linux-can/ZB%2F93xJxq%2FBUqAgG@dragonet/

Cc: Dae R. Jeong <threeearcat@gmail.com>
Cc: Hillf Danton <hdanton@sina.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 49 ++++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 9bc344851704..2ba043f5a9cb 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -117,11 +117,12 @@ MODULE_ALIAS("can-proto-6");
 enum {
 	ISOTP_IDLE = 0,
 	ISOTP_WAIT_FIRST_FC,
 	ISOTP_WAIT_FC,
 	ISOTP_WAIT_DATA,
-	ISOTP_SENDING
+	ISOTP_SENDING,
+	ISOTP_SHUTDOWN,
 };
 
 struct tpcon {
 	unsigned int idx;
 	unsigned int len;
@@ -878,12 +879,12 @@ static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
 {
 	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
 					     txtimer);
 	struct sock *sk = &so->sk;
 
-	/* don't handle timeouts in IDLE state */
-	if (so->tx.state == ISOTP_IDLE)
+	/* don't handle timeouts in IDLE or SHUTDOWN state */
+	if (so->tx.state == ISOTP_IDLE || so->tx.state == ISOTP_SHUTDOWN)
 		return HRTIMER_NORESTART;
 
 	/* we did not get any flow control or echo frame in time */
 
 	/* report 'communication error on send' */
@@ -916,37 +917,37 @@ static enum hrtimer_restart isotp_txfr_timer_handler(struct hrtimer *hrtimer)
 
 static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	struct sock *sk = sock->sk;
 	struct isotp_sock *so = isotp_sk(sk);
-	u32 old_state = so->tx.state;
 	struct sk_buff *skb;
 	struct net_device *dev;
 	struct canfd_frame *cf;
 	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
 	int wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
 	s64 hrtimer_sec = ISOTP_ECHO_TIMEOUT;
 	int off;
 	int err;
 
-	if (!so->bound)
+	if (!so->bound || so->tx.state == ISOTP_SHUTDOWN)
 		return -EADDRNOTAVAIL;
 
+wait_free_buffer:
 	/* we do not support multiple buffers - for now */
-	if (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE ||
-	    wq_has_sleeper(&so->wait)) {
-		if (msg->msg_flags & MSG_DONTWAIT) {
-			err = -EAGAIN;
-			goto err_out;
-		}
+	if (wq_has_sleeper(&so->wait) && (msg->msg_flags & MSG_DONTWAIT))
+		return -EAGAIN;
 
-		/* wait for complete transmission of current pdu */
-		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
-		if (err)
-			goto err_out;
+	/* wait for complete transmission of current pdu */
+	err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+	if (err)
+		return err;
 
-		so->tx.state = ISOTP_SENDING;
+	if (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE) {
+		if (so->tx.state == ISOTP_SHUTDOWN)
+			return -EADDRNOTAVAIL;
+
+		goto wait_free_buffer;
 	}
 
 	if (!size || size > MAX_MSG_LENGTH) {
 		err = -EINVAL;
 		goto err_out_drop;
@@ -1072,25 +1073,24 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		goto err_out_drop;
 	}
 
 	if (wait_tx_done) {
 		/* wait for complete transmission of current pdu */
-		wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+		if (err)
+			return err;
 
 		if (sk->sk_err)
 			return -sk->sk_err;
 	}
 
 	return size;
 
 err_out_drop:
 	/* drop this PDU and unlock a potential wait queue */
-	old_state = ISOTP_IDLE;
-err_out:
-	so->tx.state = old_state;
-	if (so->tx.state == ISOTP_IDLE)
-		wake_up_interruptible(&so->wait);
+	so->tx.state = ISOTP_IDLE;
+	wake_up_interruptible(&so->wait);
 
 	return err;
 }
 
 static int isotp_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
@@ -1147,15 +1147,18 @@ static int isotp_release(struct socket *sock)
 		return 0;
 
 	so = isotp_sk(sk);
 	net = sock_net(sk);
 
+wait_transmission_finish:
 	/* wait for complete transmission of current pdu */
 	wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
 
+	if (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SHUTDOWN) != ISOTP_IDLE)
+		goto wait_transmission_finish;
+
 	/* force state machines to be idle also when a signal occurred */
-	so->tx.state = ISOTP_IDLE;
 	so->rx.state = ISOTP_IDLE;
 
 	spin_lock(&isotp_notifier_lock);
 	while (isotp_busy_notifier == so) {
 		spin_unlock(&isotp_notifier_lock);
-- 
2.30.2

