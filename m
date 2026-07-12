Return-Path: <linux-can+bounces-8342-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bzJbG8eaU2rRcAMAu9opvQ
	(envelope-from <linux-can+bounces-8342-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 15:46:47 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F84744DB6
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 15:46:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=j8ZA7gaU;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8342-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8342-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 391E13036386
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 13:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C543A3E87;
	Sun, 12 Jul 2026 13:44:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545EC367F4A
	for <linux-can@vger.kernel.org>; Sun, 12 Jul 2026 13:44:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783863847; cv=none; b=kmlRDwcwBx7vAHnQIVmuy+Gr7VvMTQ3FgjBTTzy9cdDjBnA+p2EpYqc+N+eYsXlSvtfswH8J7ZQuANLYoVk9bK/pslYD2zT3MEPbUsO4ZlAIBDY/K4OGCcnRdDodx5lIAJzHpCgSGdLT7P8T8Br+wx64xa84g1mNuF6jtofMgh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783863847; c=relaxed/simple;
	bh=yjfkQLKWmt0pWD7xH1dbRWBxs5HE7obR4w2+8mZH9fM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gEVxX1QUAH/lzJPjdPmn1kYkfdBKT3ATWJXUmBG8slr/WvYD9h2BRQnh5JhiVZ7w78AxWQtGDiBCdSpHYTAo1JDCBsgCP2OIcZjbiqSucAmko7lwmhYDJLEonA+tU739ApGziJVmA/HThf+X133vHWqNBrHhq0bQkilNKlf92Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8ZA7gaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A11DC2BCF4;
	Sun, 12 Jul 2026 13:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783863847;
	bh=yjfkQLKWmt0pWD7xH1dbRWBxs5HE7obR4w2+8mZH9fM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=j8ZA7gaUjy+9PToLD/3WSxwUSFE2e8QEdWOUmeJyKFR32zP5hag0/XliS+CsIpCzE
	 vnDebLyRrRG5nWzFDKK/DHWo9pvl3MGwMYPG+EIhKgrENWDX2j4yNMdaoxfPCndBSG
	 EVIOanaYuCoZQQ40/svSmewp/iR9El/IU+GGgtaCoZpdqQqgO4Gp22VCpzRFpxefGu
	 9Otd7DR0m7Y92m/OkGkr4gzENMprjSpuXGhmIzBWauHWp8YVDS1EBnKpIy9sA7k5D7
	 0bW446Zy/afdiFQ/8ItQ4kSkvDW+Z1+pfFIx3HZzmB0aGO+6C98JUO3xltVfclqrk/
	 9wnZ4YdgX35PA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1965C44508;
	Sun, 12 Jul 2026 13:44:06 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Sun, 12 Jul 2026 15:44:07 +0200
Subject: [PATCH v9 3/4] can: isotp: fix race between RX/TX timers and frame
 reception
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-isotp-fixes-v9-3-137840d7f0f4@hartkopp.net>
References: <20260712-isotp-fixes-v9-0-137840d7f0f4@hartkopp.net>
In-Reply-To: <20260712-isotp-fixes-v9-0-137840d7f0f4@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783863845; l=16857;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=p3ffVy+Cw0wLZVsgnsq4HHq7xCYrbFNHiA+Q3HUD2Ek=;
 b=aDWdFGIZef3E7sVtIWR74Uc2m2MmNZSkLLdUSY6xFTun8lwj3bgEDqFhk0L/1RXEQy9j5hBAw
 7UrftQI6PVtAFvVMWDxWjlBZIGgWTV7YoCosKJwB5b4NLp0QlYrXFds
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Endpoint-Received: by B4 Relay for socketcan@hartkopp.net/20260128 with
 auth_id=620
X-Original-From: Oliver Hartkopp <socketcan@hartkopp.net>
Reply-To: socketcan@hartkopp.net
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8342-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,hartkopp.net:replyto,hartkopp.net:mid,hartkopp.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3F84744DB6

From: Oliver Hartkopp <socketcan@hartkopp.net>

When receiving a Consecutive Frame, Flow Control frame, or local echo
frame, hrtimer_cancel() is called to stop the corresponding watchdog
timer. If the timer handler is already running on another CPU,
hrtimer_cancel() waits for it, and by the time it returns, the timer
handler may have already reported a timeout and reset the state
machine.

so->rx_lock now also covers the TX side: isotp_rcv_echo() takes it
(isotp_rcv_fc()/isotp_rcv_cf() already run under it via isotp_rcv()),
and sendmsg() takes it briefly when claiming a new transfer to bump
so->tx_gen, cancel all three TX timers and clear so->cfecho, all in
the same critical section - isotp_rcv_echo() must never be able to
observe the new generation alongside the old, not yet cleared cfecho
tag, or a stale echo could pass its generation check and corrupt the
new transfer. A concurrent claim cannot get past this point while an
old-generation frame is still being processed under the same lock, so
isotp_rcv_fc()/isotp_rcv_cf() only need a plain state recheck after
hrtimer_cancel().

Two spots additionally need so->tx_gen, because sendmsg()'s initial
claim is a lock-free cmpxchg() to ISOTP_SENDING that can succeed while
the old generation's rx_lock holder is still active:

 - isotp_rcv_echo() checks state == ISOTP_SENDING, exactly what a
   brand new claim also sets before it ever reaches the lock; so->tx_gen
   tells the two apart.
 - sendmsg()'s error paths unconditionally wrote so->tx.state =
   ISOTP_IDLE; that write is now gated on so->tx_gen too, since a new
   claim can succeed while we're still cancelling our own timers.

rx_lock only guarantees a new transfer can't have armed a timer of its
own while its claim is still waiting for the lock; it does not cover
sendmsg()'s later, unlocked hrtimer_start() before can_send(). So the
error paths also recheck so->tx_gen before each individual
hrtimer_cancel() and stop as soon as it no longer matches - at most one
of the three TX timers is ever armed for a given transfer, so the
other two calls are harmless no-ops regardless of the check.

so->tx_gen is otherwise only used by isotp_tx_timer_handler()/
isotp_echo_timer_handler(), which must stay lock-free to avoid
deadlocking against the hrtimer_cancel() calls made under so->rx_lock
elsewhere.

isotp_tx_timeout() still suppresses its ECOMM report on a so->tx_gen
mismatch, so a non-blocking sendmsg() that timed out can lose its only
notification via so->sk_err if a new transfer claims the socket first.
That is accepted as the lesser problem versus tainting an active new
transfer with a stale error.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/linux-can/20260710142146.BDAE61F000E9@smtp.kernel.org/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 188 +++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 152 insertions(+), 36 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 44c044eb83e1..c4ca8a64e7ce 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -156,18 +156,19 @@ struct isotp_sock {
 	netdevice_tracker dev_tracker;
 	canid_t txid;
 	canid_t rxid;
 	ktime_t tx_gap;
 	ktime_t lastrxcf_tstamp;
-	struct hrtimer rxtimer, txtimer, txfrtimer;
+	struct hrtimer rxtimer, txtimer, txfrtimer, echotimer;
 	struct can_isotp_options opt;
 	struct can_isotp_fc_options rxfc, txfc;
 	struct can_isotp_ll_options ll;
 	u32 frame_txtime;
 	u32 force_tx_stmin;
 	u32 force_rx_stmin;
 	u32 cfecho; /* consecutive frame echo tag */
+	u32 tx_gen; /* generation, bumped per new tx transfer */
 	struct tpcon rx, tx;
 	struct list_head notifier;
 	wait_queue_head_t wait;
 	spinlock_t rx_lock; /* protect single thread state machine */
 };
@@ -376,10 +377,19 @@ static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 	    so->tx.state != ISOTP_WAIT_FIRST_FC)
 		return 0;
 
 	hrtimer_cancel(&so->txtimer);
 
+	/* isotp_tx_timeout() may have given up on this job while
+	 * hrtimer_cancel() above waited for it to finish; so->rx_lock
+	 * (held by our caller isotp_rcv()) rules out a concurrent claim,
+	 * so a plain recheck is enough here.
+	 */
+	if (so->tx.state != ISOTP_WAIT_FC &&
+	    so->tx.state != ISOTP_WAIT_FIRST_FC)
+		return 1;
+
 	if ((cf->len < ae + FC_CONTENT_SZ) ||
 	    ((so->opt.flags & ISOTP_CHECK_PADDING) &&
 	     check_pad(so, cf, ae + FC_CONTENT_SZ, so->opt.rxpad_content))) {
 		/* malformed PDU - report 'not a data message' */
 		sk->sk_err = EBADMSG;
@@ -422,11 +432,11 @@ static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 	switch (cf->data[ae] & 0x0F) {
 	case ISOTP_FC_CTS:
 		so->tx.bs = 0;
 		so->tx.state = ISOTP_SENDING;
 		/* send CF frame and enable echo timeout handling */
-		hrtimer_start(&so->txtimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
+		hrtimer_start(&so->echotimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
 		isotp_send_cframe(so);
 		break;
 
 	case ISOTP_FC_WT:
@@ -575,10 +585,18 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 		so->lastrxcf_tstamp = skb->tstamp;
 	}
 
 	hrtimer_cancel(&so->rxtimer);
 
+	/* isotp_rx_timer_handler() may have raced us for so->rx.state
+	 * while hrtimer_cancel() above waited for it to finish, already
+	 * reporting ETIMEDOUT and resetting the reception; don't process
+	 * this CF into a reassembly that has already been given up on.
+	 */
+	if (so->rx.state != ISOTP_WAIT_DATA)
+		return 1;
+
 	/* CFs are never longer than the FF */
 	if (cf->len > so->rx.ll_dl)
 		return 1;
 
 	/* CFs have usually the LL_DL length */
@@ -868,80 +886,130 @@ static void isotp_create_fframe(struct canfd_frame *cf, struct isotp_sock *so,
 static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 {
 	struct sock *sk = (struct sock *)data;
 	struct isotp_sock *so = isotp_sk(sk);
 	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
+	u32 gen;
 
 	/* only handle my own local echo CF/SF skb's (no FF!) */
-	if (skb->sk != sk || so->cfecho != *(u32 *)cf->data)
+	if (skb->sk != sk)
 		return;
 
+	/* unlike isotp_rcv_fc()/isotp_rcv_cf(), not already under so->rx_lock
+	 * (no isotp_rcv() caller here), so take it ourselves
+	 */
+	spin_lock(&so->rx_lock);
+
+	/* so->cfecho may since belong to a new transfer; recheck under lock */
+	if (so->cfecho != *(u32 *)cf->data)
+		goto out_unlock;
+
+	gen = READ_ONCE(so->tx_gen);
+
 	/* cancel local echo timeout */
-	hrtimer_cancel(&so->txtimer);
+	hrtimer_cancel(&so->echotimer);
 
 	/* local echo skb with consecutive frame has been consumed */
 	so->cfecho = 0;
 
+	/* so->rx_lock stops a new claim from arming a timer of its own
+	 * while we're still here, but not from the lock-free cmpxchg()
+	 * claim itself: state alone can't tell our SENDING from a new
+	 * transfer's, so also gate on gen.
+	 */
+	if (so->tx.state != ISOTP_SENDING || READ_ONCE(so->tx_gen) != gen)
+		goto out_unlock;
+
 	if (so->tx.idx >= so->tx.len) {
 		/* we are done */
 		so->tx.state = ISOTP_IDLE;
 		wake_up_interruptible(&so->wait);
-		return;
+		goto out_unlock;
 	}
 
 	if (so->txfc.bs && so->tx.bs >= so->txfc.bs) {
 		/* stop and wait for FC with timeout */
 		so->tx.state = ISOTP_WAIT_FC;
 		hrtimer_start(&so->txtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
-		return;
+		goto out_unlock;
 	}
 
 	/* no gap between data frames needed => use burst mode */
 	if (!so->tx_gap) {
 		/* enable echo timeout handling */
-		hrtimer_start(&so->txtimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
+		hrtimer_start(&so->echotimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
 		isotp_send_cframe(so);
-		return;
+		goto out_unlock;
 	}
 
 	/* start timer to send next consecutive frame with correct delay */
 	hrtimer_start(&so->txfrtimer, so->tx_gap, HRTIMER_MODE_REL_SOFT);
+
+out_unlock:
+	spin_unlock(&so->rx_lock);
 }
 
-static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
+/* shared by so->txtimer's and so->echotimer's callbacks. Both timers get
+ * cancelled under so->rx_lock elsewhere, so this must stay lock-free to
+ * avoid deadlocking with that; uses so->tx_gen instead to avoid tainting
+ * a new transfer with an error from the one that just timed out.
+ */
+static enum hrtimer_restart isotp_tx_timeout(struct isotp_sock *so)
 {
-	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
-					     txtimer);
 	struct sock *sk = &so->sk;
+	u32 gen = READ_ONCE(so->tx_gen);
+	u32 old_state = READ_ONCE(so->tx.state);
 
 	/* don't handle timeouts in IDLE or SHUTDOWN state */
-	if (so->tx.state == ISOTP_IDLE || so->tx.state == ISOTP_SHUTDOWN)
+	if (old_state == ISOTP_IDLE || old_state == ISOTP_SHUTDOWN)
+		return HRTIMER_NORESTART;
+
+	/* only claim the timeout if the state is still unchanged */
+	if (cmpxchg(&so->tx.state, old_state, ISOTP_IDLE) != old_state)
 		return HRTIMER_NORESTART;
 
 	/* we did not get any flow control or echo frame in time */
 
-	/* report 'communication error on send' */
-	sk->sk_err = ECOMM;
-	if (!sock_flag(sk, SOCK_DEAD))
-		sk_error_report(sk);
+	if (READ_ONCE(so->tx_gen) == gen) {
+		/* report 'communication error on send' */
+		sk->sk_err = ECOMM;
+		if (!sock_flag(sk, SOCK_DEAD))
+			sk_error_report(sk);
+	}
 
-	/* reset tx state */
-	so->tx.state = ISOTP_IDLE;
 	wake_up_interruptible(&so->wait);
 
 	return HRTIMER_NORESTART;
 }
 
+/* so->txtimer: fires when a Flow Control frame does not arrive in time */
+static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
+{
+	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
+					     txtimer);
+
+	return isotp_tx_timeout(so);
+}
+
+/* so->echotimer: fires when a sent CF/SF's local echo does not arrive */
+static enum hrtimer_restart isotp_echo_timer_handler(struct hrtimer *hrtimer)
+{
+	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
+					     echotimer);
+
+	return isotp_tx_timeout(so);
+}
+
 static enum hrtimer_restart isotp_txfr_timer_handler(struct hrtimer *hrtimer)
 {
 	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
 					     txfrtimer);
 
 	/* start echo timeout handling and cover below protocol error */
-	hrtimer_start(&so->txtimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
+	hrtimer_start(&so->echotimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
 		      HRTIMER_MODE_REL_SOFT);
 
 	/* cfecho should be consumed by isotp_rcv_echo() here */
 	if (so->tx.state == ISOTP_SENDING && !so->cfecho)
 		isotp_send_cframe(so);
@@ -958,12 +1026,14 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	struct net_device *dev;
 	struct canfd_frame *cf;
 	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
 	int wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
 	s64 hrtimer_sec = ISOTP_ECHO_TIMEOUT;
+	struct hrtimer *tx_hrt = &so->echotimer;
 	int off;
 	int err;
+	u32 gen;
 
 	if (!so->bound || so->tx.state == ISOTP_SHUTDOWN)
 		return -EADDRNOTAVAIL;
 
 	while (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE) {
@@ -978,10 +1048,28 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
 		if (err)
 			goto err_event_drop;
 	}
 
+	/* new transfer: bump the generation (gen is used below and by
+	 * isotp_tx_timeout()/isotp_rcv_echo()) and drain the old one -
+	 * cancel its timers ourselves in case one is still concurrently
+	 * completing it, and take so->rx_lock so no isotp_rcv_fc()/
+	 * isotp_rcv_echo() call for it is still in flight. The bump and
+	 * the so->cfecho reset happen in the same so->rx_lock section so
+	 * isotp_rcv_echo() can never observe the new gen alongside the
+	 * old, not-yet-cleared cfecho tag.
+	 */
+	spin_lock_bh(&so->rx_lock);
+	gen = READ_ONCE(so->tx_gen) + 1;
+	WRITE_ONCE(so->tx_gen, gen);
+	hrtimer_cancel(&so->txtimer);
+	hrtimer_cancel(&so->echotimer);
+	hrtimer_cancel(&so->txfrtimer);
+	so->cfecho = 0;
+	spin_unlock_bh(&so->rx_lock);
+
 	/* so->bound is only checked once above - a wakeup may have
 	 * unbound/rebound the socket meanwhile, so re-validate it
 	 */
 	if (!so->bound) {
 		err = -EADDRNOTAVAIL;
@@ -1098,17 +1186,18 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			/* standard flow control check */
 			so->tx.state = ISOTP_WAIT_FIRST_FC;
 
 			/* start timeout for FC */
 			hrtimer_sec = ISOTP_FC_TIMEOUT;
+			tx_hrt = &so->txtimer;
 
 			/* no CF echo tag for isotp_rcv_echo() (FF-mode) */
 			so->cfecho = 0;
 		}
 	}
 
-	hrtimer_start(&so->txtimer, ktime_set(hrtimer_sec, 0),
+	hrtimer_start(tx_hrt, ktime_set(hrtimer_sec, 0),
 		      HRTIMER_MODE_REL_SOFT);
 
 	/* send the first or only CAN frame */
 	cf->flags = so->ll.tx_flags;
 
@@ -1118,17 +1207,17 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	dev_put(dev);
 	if (err) {
 		pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
 			       __func__, ERR_PTR(err));
 
-		/* no transmission -> no timeout monitoring */
-		hrtimer_cancel(&so->txtimer);
-
-		/* reset consecutive frame echo tag */
-		so->cfecho = 0;
-
-		goto err_out_drop;
+		spin_lock_bh(&so->rx_lock);
+		/* no transmission -> no timeout monitoring; skip if a new
+		 * claim has since taken over so we don't cancel its timer
+		 */
+		if (READ_ONCE(so->tx_gen) == gen)
+			hrtimer_cancel(tx_hrt);
+		goto err_out_drop_locked;
 	}
 
 	if (wait_tx_done) {
 		/* wait for complete transmission of current pdu */
 		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
@@ -1140,18 +1229,40 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			return err;
 	}
 
 	return size;
 
+err_out_drop:
+	spin_lock_bh(&so->rx_lock);
+	goto err_out_drop_locked;
 err_event_drop:
-	/* got signal: force tx state machine to be idle */
-	so->tx.state = ISOTP_IDLE;
+	/* got signal: cancel timers one at a time under so->rx_lock,
+	 * rechecking gen after each - a mismatch means our own transfer
+	 * already concluded on its own (leaving nothing else of ours
+	 * armed), so stop before a further cancel can hit a new transfer's
+	 * timer instead
+	 */
+	spin_lock_bh(&so->rx_lock);
+	if (READ_ONCE(so->tx_gen) != gen)
+		goto err_out_drop_locked;
 	hrtimer_cancel(&so->txfrtimer);
+	if (READ_ONCE(so->tx_gen) != gen)
+		goto err_out_drop_locked;
 	hrtimer_cancel(&so->txtimer);
-err_out_drop:
-	/* drop this PDU and unlock a potential wait queue */
-	so->tx.state = ISOTP_IDLE;
+	if (READ_ONCE(so->tx_gen) != gen)
+		goto err_out_drop_locked;
+	hrtimer_cancel(&so->echotimer);
+err_out_drop_locked:
+	/* so->rx_lock stops a new claim from cancelling anything of its own
+	 * while we're still here, but not from the lock-free cmpxchg()
+	 * claim itself; only drop our own PDU if that hasn't happened
+	 */
+	if (READ_ONCE(so->tx_gen) == gen) {
+		so->cfecho = 0;
+		so->tx.state = ISOTP_IDLE;
+	}
+	spin_unlock_bh(&so->rx_lock);
 	wake_up_interruptible(&so->wait);
 
 	return err;
 }
 
@@ -1261,10 +1372,11 @@ static int isotp_release(struct socket *sock)
 	 */
 	synchronize_rcu();
 
 	hrtimer_cancel(&so->txfrtimer);
 	hrtimer_cancel(&so->txtimer);
+	hrtimer_cancel(&so->echotimer);
 	hrtimer_cancel(&so->rxtimer);
 
 	sock_orphan(sk);
 	sock->sk = NULL;
 
@@ -1700,14 +1812,18 @@ static int isotp_init(struct sock *sk)
 	so->rx.buf = so->rx.sbuf;
 	so->tx.buf = so->tx.sbuf;
 	so->rx.buflen = ARRAY_SIZE(so->rx.sbuf);
 	so->tx.buflen = ARRAY_SIZE(so->tx.sbuf);
 
-	hrtimer_setup(&so->rxtimer, isotp_rx_timer_handler, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	hrtimer_setup(&so->txtimer, isotp_tx_timer_handler, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	hrtimer_setup(&so->txfrtimer, isotp_txfr_timer_handler, CLOCK_MONOTONIC,
-		      HRTIMER_MODE_REL_SOFT);
+	hrtimer_setup(&so->rxtimer, isotp_rx_timer_handler,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
+	hrtimer_setup(&so->txtimer, isotp_tx_timer_handler,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
+	hrtimer_setup(&so->echotimer, isotp_echo_timer_handler,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
+	hrtimer_setup(&so->txfrtimer, isotp_txfr_timer_handler,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 
 	init_waitqueue_head(&so->wait);
 	spin_lock_init(&so->rx_lock);
 
 	spin_lock(&isotp_notifier_lock);

-- 
2.53.0



