Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0F26D2163
	for <lists+linux-can@lfdr.de>; Fri, 31 Mar 2023 15:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjCaNUO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 31 Mar 2023 09:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjCaNTu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 31 Mar 2023 09:19:50 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46B02061F
        for <linux-can@vger.kernel.org>; Fri, 31 Mar 2023 06:19:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680268781; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DO2S4DkIXxYp4G1ESUUmEo4i+11iXiM9fPRif5CRH8aU2RBevGNj8EGt1SPRn13mSr
    yWvB167+0UVRWCeRjtPcWCzFhDSmj0TxuJx1npVOyp2ogUGuBmm4/fmtwEyenobSh/bB
    KRKKhi+UOZ1YVqTyIJuXQbyKJsS2j67yZzPNbxaa7yy0myJuQoN+LrLN2VtbMY34Yyt9
    Q5t2/0JQioDGYH5oKMYN+WJtjdhYI7TK0ns9W/I5CeD3574UpjyMe3mvr3+dvCPT6uAo
    40C/am82hvy7qW12jyQMivpOLTSKJpfWxTT9B1ftFTzTWbrEQJ0q8z3/I4h1iPPRusms
    RWYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680268781;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=09P2NJkLlDUQBTMaurZVBxCduoKUiiwVyLlWmL4EEyo=;
    b=m3o6cLV3/oRsuDNls8w+JNVtSfvkBmm6JSIv0Vv0miGgevUj3bYBfU/GmcOiOBx+cI
    sOlx8+vlkaG01MhFVBqNqSMdQBD1jfIY5hgJF0LAcslTV6/kWU3wIMD3j83U+bmAviG4
    7hyhBp84Xwa4xld4UNJD8ZyARx1X5gyNz0ESMRGm764IgNiivaIg/jXFqSF98hmfl2JJ
    Wy69t6i2u/5pRg+hiZY+eCoA/n0QrtFm5Jddi5ZJERKOzX+ta5fAz2rWEkWHFKPytzkA
    3Qp3NH4BeGLuKnJTIXpWsaNnrcsN2QuqBAIMSgQvgTjcQAW7TTtAtmMTE2eUTvNbF9TY
    YMdQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680268781;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=09P2NJkLlDUQBTMaurZVBxCduoKUiiwVyLlWmL4EEyo=;
    b=DC3N376pclMkUoZuzqEvLEA4pmZ5y2opD+qnQO4iymAWVdpHIMuGXYmXhu9SNat7eB
    UzgEpeaSNbC2LaOwPDv8yHt+jLttMmpXIm030jA5FuJjbImKiJS6j4wm0mT03WFjAugn
    Gf8qvtzJhrbtIH7AiMxuTYF5PDMjisKISHwuhYhmOApylX+CuEchkLlHrQO/M4UIRjuD
    CQu4N0StFtgiaZDc9Z5OoQHYsFGasuQdwFVgwVFV1tyuj5cbsDBub9+/7uuxHiZo27W7
    ZY590ZvICVX+wIKnjTNPw1ERCSIdeW2NhDT4lNnk6czHK9j4qH8pBn9EsnpyM4K7R7/V
    t8CA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmVcfh+rd"
Received: from silver.lan
    by smtp.strato.de (RZmta 49.3.1 AUTH)
    with ESMTPSA id n9397fz2VDJejQ7
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 31 Mar 2023 15:19:40 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        "Dae R . Jeong" <threeearcat@gmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: [RFC PATCH v4] can: isotp: fix race between isotp_sendsmg() and isotp_release()
Date:   Fri, 31 Mar 2023 15:19:35 +0200
Message-Id: <20230331131935.21465-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS
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
v4: take care of signal interrupts for wait_event_interruptible() in
    isotp_sendmsg() in ALL cases
    
 net/can/isotp.c | 55 ++++++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 9bc344851704..f70ee4cf4997 100644
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
+		goto err_event_drop;
 
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
+		if (err)
+			goto err_event_drop;
 
 		if (sk->sk_err)
 			return -sk->sk_err;
 	}
 
 	return size;
 
+err_event_drop:
+	/* got signal: force tx state machine to be idle */
+	so->tx.state = ISOTP_IDLE;
+	hrtimer_cancel(&so->txfrtimer);
+	hrtimer_cancel(&so->txtimer);
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

