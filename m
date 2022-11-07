Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B7F620D04
	for <lists+linux-can@lfdr.de>; Tue,  8 Nov 2022 11:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbiKHKTS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Nov 2022 05:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbiKHKTP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Nov 2022 05:19:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BE715FCB
        for <linux-can@vger.kernel.org>; Tue,  8 Nov 2022 02:19:14 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1osLhJ-0006MN-4E
        for linux-can@vger.kernel.org; Tue, 08 Nov 2022 11:19:13 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 3883D115C67
        for <linux-can@vger.kernel.org>; Mon,  7 Nov 2022 13:32:31 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id EAE40115C44;
        Mon,  7 Nov 2022 13:32:26 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8e54a572;
        Mon, 7 Nov 2022 13:32:20 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>,
        Wei Chen <harperchen1110@gmail.com>, stable@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 3/6] can: isotp: fix tx state handling for echo tx processing
Date:   Mon,  7 Nov 2022 14:32:14 +0100
Message-Id: <20221107133217.59861-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221107133217.59861-1-mkl@pengutronix.de>
References: <20221107133217.59861-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>

In commit 4b7fe92c0690 ("can: isotp: add local echo tx processing for
consecutive frames") the data flow for consecutive frames (CF) has been
reworked to improve the reliability of long data transfers.

This rework did not touch the transmission and the tx state changes of
single frame (SF) transfers which likely led to the WARN in the
isotp_tx_timer_handler() catching a wrong tx state. This patch makes use
of the improved frame processing for SF frames and sets the ISOTP_SENDING
state in isotp_sendmsg() within the cmpxchg() condition handling.

A review of the state machine and the timer handling additionally revealed
a missing echo timeout handling in the case of the burst mode in
isotp_rcv_echo() and removes a potential timer configuration uncertainty
in isotp_rcv_fc() when the receiver requests consecutive frames.

Fixes: 4b7fe92c0690 ("can: isotp: add local echo tx processing for consecutive frames")
Link: https://lore.kernel.org/linux-can/CAO4mrfe3dG7cMP1V5FLUkw7s+50c9vichigUMQwsxX4M=45QEw@mail.gmail.com/T/#u
Reported-by: Wei Chen <harperchen1110@gmail.com>
Cc: stable@vger.kernel.org # v6.0
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://lore.kernel.org/all/20221104142551.16924-1-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/isotp.c | 71 ++++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index a9d1357f8489..608f8c24ae46 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -111,6 +111,9 @@ MODULE_ALIAS("can-proto-6");
 #define ISOTP_FC_WT 1		/* wait */
 #define ISOTP_FC_OVFLW 2	/* overflow */
 
+#define ISOTP_FC_TIMEOUT 1	/* 1 sec */
+#define ISOTP_ECHO_TIMEOUT 2	/* 2 secs */
+
 enum {
 	ISOTP_IDLE = 0,
 	ISOTP_WAIT_FIRST_FC,
@@ -258,7 +261,8 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 	so->lastrxcf_tstamp = ktime_set(0, 0);
 
 	/* start rx timeout watchdog */
-	hrtimer_start(&so->rxtimer, ktime_set(1, 0), HRTIMER_MODE_REL_SOFT);
+	hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
+		      HRTIMER_MODE_REL_SOFT);
 	return 0;
 }
 
@@ -344,6 +348,8 @@ static int check_pad(struct isotp_sock *so, struct canfd_frame *cf,
 	return 0;
 }
 
+static void isotp_send_cframe(struct isotp_sock *so);
+
 static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 {
 	struct sock *sk = &so->sk;
@@ -398,14 +404,15 @@ static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 	case ISOTP_FC_CTS:
 		so->tx.bs = 0;
 		so->tx.state = ISOTP_SENDING;
-		/* start cyclic timer for sending CF frame */
-		hrtimer_start(&so->txtimer, so->tx_gap,
+		/* send CF frame and enable echo timeout handling */
+		hrtimer_start(&so->txtimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
+		isotp_send_cframe(so);
 		break;
 
 	case ISOTP_FC_WT:
 		/* start timer to wait for next FC frame */
-		hrtimer_start(&so->txtimer, ktime_set(1, 0),
+		hrtimer_start(&so->txtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
 		break;
 
@@ -600,7 +607,7 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 	/* perform blocksize handling, if enabled */
 	if (!so->rxfc.bs || ++so->rx.bs < so->rxfc.bs) {
 		/* start rx timeout watchdog */
-		hrtimer_start(&so->rxtimer, ktime_set(1, 0),
+		hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
 		return 0;
 	}
@@ -829,7 +836,7 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 	struct isotp_sock *so = isotp_sk(sk);
 	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 
-	/* only handle my own local echo skb's */
+	/* only handle my own local echo CF/SF skb's (no FF!) */
 	if (skb->sk != sk || so->cfecho != *(u32 *)cf->data)
 		return;
 
@@ -849,13 +856,16 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 	if (so->txfc.bs && so->tx.bs >= so->txfc.bs) {
 		/* stop and wait for FC with timeout */
 		so->tx.state = ISOTP_WAIT_FC;
-		hrtimer_start(&so->txtimer, ktime_set(1, 0),
+		hrtimer_start(&so->txtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
 		return;
 	}
 
 	/* no gap between data frames needed => use burst mode */
 	if (!so->tx_gap) {
+		/* enable echo timeout handling */
+		hrtimer_start(&so->txtimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
+			      HRTIMER_MODE_REL_SOFT);
 		isotp_send_cframe(so);
 		return;
 	}
@@ -879,7 +889,7 @@ static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
 			/* start timeout for unlikely lost echo skb */
 			hrtimer_set_expires(&so->txtimer,
 					    ktime_add(ktime_get(),
-						      ktime_set(2, 0)));
+						      ktime_set(ISOTP_ECHO_TIMEOUT, 0)));
 			restart = HRTIMER_RESTART;
 
 			/* push out the next consecutive frame */
@@ -907,7 +917,8 @@ static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
 		break;
 
 	default:
-		WARN_ON_ONCE(1);
+		WARN_ONCE(1, "can-isotp: tx timer state %08X cfecho %08X\n",
+			  so->tx.state, so->cfecho);
 	}
 
 	return restart;
@@ -923,7 +934,7 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	struct canfd_frame *cf;
 	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
 	int wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
-	s64 hrtimer_sec = 0;
+	s64 hrtimer_sec = ISOTP_ECHO_TIMEOUT;
 	int off;
 	int err;
 
@@ -942,6 +953,8 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
 		if (err)
 			goto err_out;
+
+		so->tx.state = ISOTP_SENDING;
 	}
 
 	if (!size || size > MAX_MSG_LENGTH) {
@@ -986,6 +999,10 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	cf = (struct canfd_frame *)skb->data;
 	skb_put_zero(skb, so->ll.mtu);
 
+	/* cfecho should have been zero'ed by init / former isotp_rcv_echo() */
+	if (so->cfecho)
+		pr_notice_once("can-isotp: uninit cfecho %08X\n", so->cfecho);
+
 	/* check for single frame transmission depending on TX_DL */
 	if (size <= so->tx.ll_dl - SF_PCI_SZ4 - ae - off) {
 		/* The message size generally fits into a SingleFrame - good.
@@ -1011,11 +1028,8 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		else
 			cf->data[ae] |= size;
 
-		so->tx.state = ISOTP_IDLE;
-		wake_up_interruptible(&so->wait);
-
-		/* don't enable wait queue for a single frame transmission */
-		wait_tx_done = 0;
+		/* set CF echo tag for isotp_rcv_echo() (SF-mode) */
+		so->cfecho = *(u32 *)cf->data;
 	} else {
 		/* send first frame */
 
@@ -1031,31 +1045,23 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			/* disable wait for FCs due to activated block size */
 			so->txfc.bs = 0;
 
-			/* cfecho should have been zero'ed by init */
-			if (so->cfecho)
-				pr_notice_once("can-isotp: no fc cfecho %08X\n",
-					       so->cfecho);
-
-			/* set consecutive frame echo tag */
+			/* set CF echo tag for isotp_rcv_echo() (CF-mode) */
 			so->cfecho = *(u32 *)cf->data;
-
-			/* switch directly to ISOTP_SENDING state */
-			so->tx.state = ISOTP_SENDING;
-
-			/* start timeout for unlikely lost echo skb */
-			hrtimer_sec = 2;
 		} else {
 			/* standard flow control check */
 			so->tx.state = ISOTP_WAIT_FIRST_FC;
 
 			/* start timeout for FC */
-			hrtimer_sec = 1;
-		}
+			hrtimer_sec = ISOTP_FC_TIMEOUT;
 
-		hrtimer_start(&so->txtimer, ktime_set(hrtimer_sec, 0),
-			      HRTIMER_MODE_REL_SOFT);
+			/* no CF echo tag for isotp_rcv_echo() (FF-mode) */
+			so->cfecho = 0;
+		}
 	}
 
+	hrtimer_start(&so->txtimer, ktime_set(hrtimer_sec, 0),
+		      HRTIMER_MODE_REL_SOFT);
+
 	/* send the first or only CAN frame */
 	cf->flags = so->ll.tx_flags;
 
@@ -1068,8 +1074,7 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			       __func__, ERR_PTR(err));
 
 		/* no transmission -> no timeout monitoring */
-		if (hrtimer_sec)
-			hrtimer_cancel(&so->txtimer);
+		hrtimer_cancel(&so->txtimer);
 
 		/* reset consecutive frame echo tag */
 		so->cfecho = 0;
-- 
2.35.1


