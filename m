Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973946D2125
	for <lists+linux-can@lfdr.de>; Fri, 31 Mar 2023 15:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjCaNHN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 31 Mar 2023 09:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbjCaNHM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 31 Mar 2023 09:07:12 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA631206C
        for <linux-can@vger.kernel.org>; Fri, 31 Mar 2023 06:07:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680268019; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IuzCKHqRRcX2KYcK9k6b6aCn/GGekkUWd6L/3u/QvB7N+OkztzYAuoFrh8EVQXpUjY
    kK2jO/Vj7jlaZFpVB1TGNefr+4UszxPO8b4NEnT6VlYEL6vT+yA1ef4LDKv+SylxA/Yq
    uyDcrgKl+5PRfgix1VGJ1bMIRPBe8LuGZNk80LIUDNatOMfnQRg7N+rrZnlDOtf+kep8
    ml2dLK1YMZ9fnGmHyNLbi1wIoJAVpkrU7FCg6hiFXtNYzYfG5KU9WqS2kutBDFS4CjDi
    vq9CaUCPDhMEkIdquI7ZSENrjeh9AKiWB14PHrO9/wUPKhcbYA2Dcf7gs32g4eINK/na
    zjfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680268019;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=oNxeZ2eVNxHzSD9+MOvqgG3dnPpOJ5ZoVEw8lgSs83Q=;
    b=EIAzRGu0rvS0/jmztY9C2OHouNo5POLTNRoY9w3qPH1gtjbEF+EAoIYdwrQC2QGSGd
    JwQEkCxEo0fsv9JCesgw5eLT17+bD909ynmcYPigLUCoR8gJ99aCpKGcBshShKythTPw
    tkL5pRk07ad/FBvInNaFAChAaic8oWVIUl95pDWBD7FRMFoa7io0+7s4Y45lQeB+me2s
    NDajvb4wwziiuc2OhvEqG1adCoVpjufdNcJH10cEo97igS3jf3bZBsOlp7jvFHZ0/iiQ
    Tvyp4Ba8oxJ3/yzhTdigMCYOoUhDOyW6kQUc6N3TbUxFW6V9pg1JbvfI75wjEm872A5h
    /TnA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680268019;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=oNxeZ2eVNxHzSD9+MOvqgG3dnPpOJ5ZoVEw8lgSs83Q=;
    b=qPbPC75SZ6q6y/oCnqS09WjnpPT2v/onpggXYy6/o2zAQI94V4NjjJmqLlEthYKNFP
    5HqR2dgTBkZIu/VfzHMWkVjTRDPhCbnJfnoFyhlHrGG2rkPqqHF+HjJUnaSXsN+btMPD
    YhA4Jkjy3s0HHss1FryYuiO1vAhUMK8TaKYUKWfGWdkZJB/t75MDBPqAb9LT6fEEoSx6
    1hklA7XQW7v8khpukhgqDi4JmxgpOW0PQfGvv2JCvHEFdq3IIC0t1TvLo1l/B1HRyCs+
    zsrLTTtn7t2s8pF71Ka6J2crsJNehetP8QN8/wDIOg7GIIHhAwAjx0+sOSsgWng+I644
    FVLA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmVcfh+rd"
Received: from silver.lan
    by smtp.strato.de (RZmta 49.3.1 AUTH)
    with ESMTPSA id n9397fz2VD6xjNv
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 31 Mar 2023 15:06:59 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        "Dae R . Jeong" <threeearcat@gmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: [RFC PATCH v3] can: isotp: fix race between isotp_sendsmg() and isotp_release()
Date:   Fri, 31 Mar 2023 15:06:54 +0200
Message-Id: <20230331130654.9886-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
v2: take care of signal interrupts for wait_event_interruptible() in
    isotp_release()
v3: take care of signal interrupts for wait_event_interruptible() in
    isotp_sendmsg() in the wait_tx_done case

 net/can/isotp.c | 55 ++++++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 9bc344851704..7928dc9ddb80 100644
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
@@ -1072,25 +1073,29 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		goto err_out_drop;
 	}
 
 	if (wait_tx_done) {
 		/* wait for complete transmission of current pdu */
-		wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+		if (err) {
+			/* got signal: force tx state machine to be idle */
+			so->tx.state = ISOTP_IDLE;
+			hrtimer_cancel(&so->txfrtimer);
+			hrtimer_cancel(&so->txtimer);
+			goto err_out_drop;
+		}
 
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
@@ -1148,14 +1153,16 @@ static int isotp_release(struct socket *sock)
 
 	so = isotp_sk(sk);
 	net = sock_net(sk);
 
 	/* wait for complete transmission of current pdu */
-	wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+	while (wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE) == 0 &&
+	       cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SHUTDOWN) != ISOTP_IDLE)
+		;
 
 	/* force state machines to be idle also when a signal occurred */
-	so->tx.state = ISOTP_IDLE;
+	so->tx.state = ISOTP_SHUTDOWN;
 	so->rx.state = ISOTP_IDLE;
 
 	spin_lock(&isotp_notifier_lock);
 	while (isotp_busy_notifier == so) {
 		spin_unlock(&isotp_notifier_lock);
-- 
2.30.2

