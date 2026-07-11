Return-Path: <linux-can+bounces-8323-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rntnFPsxUmouNAMAu9opvQ
	(envelope-from <linux-can+bounces-8323-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 11 Jul 2026 14:07:23 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A55174173D
	for <lists+linux-can@lfdr.de>; Sat, 11 Jul 2026 14:07:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=WkdRguuU;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8323-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-8323-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F88D3008456
	for <lists+linux-can@lfdr.de>; Sat, 11 Jul 2026 12:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760FA3B42C2;
	Sat, 11 Jul 2026 12:07:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF1A38AC83
	for <linux-can@vger.kernel.org>; Sat, 11 Jul 2026 12:07:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783771636; cv=none; b=HGsP5pP2xp8J7fDAN4o+1YnZ8blW31pRbWpq43bd1joq8KeZchZD0yMO+E89Fg4y1tmtVay41LrtP1lNDWkZHeRXpwYYwJZ+PdD8c9Vl8/r98U261fKLdvfRuFX5SXj2MQ6NDPE2n9J779bzuenVY76pi+IUVf1KkYh6kv2wgXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783771636; c=relaxed/simple;
	bh=IvodxcRlklD6YJY3tUH9UB/7Q3X8cXVhAo3+PsLSN90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OTs5PzjCS6X7ep1mvz5l/v7jq0aouDKO9kIS3F2oqPfWR5j7zNe1KNbVEFzE6vmq2rhetBhKMu0PMGj9tXTYVlQSFYlSSsBq84s8paDaaJ9Wx/dN5iR90d4nwdgc32/rg/lEKGi9b2hSHNDOIQgahZgtKZL/0D+vhWhrl4pNrVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkdRguuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DAE8C2BCF6;
	Sat, 11 Jul 2026 12:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783771636;
	bh=IvodxcRlklD6YJY3tUH9UB/7Q3X8cXVhAo3+PsLSN90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WkdRguuU/aCrhEY6wDfCz208MYw+TqcSaQwUnFhBqJ83rme1g/iBR7w2v+H7PuyTJ
	 Lue4+oXAqanJrPbF7IFNUHsnxJdER06Y6kCeCbwKyahN0D0S01OA3ix451DGwvt8Zt
	 Wzm0hBhA45BlzLfTyEFdrBpbNbUM6hXOeKaIgsAAMh2SciV/F1NK/VCsmqgLDPva+a
	 zm5hPGSErETWOdk1y+aAj7ftyUb3Rc6WXuwRclTNpw1xv8NzlxbUoPQrUYC5iX6AKf
	 ajwk28dH9C1rjlnQb2qTsKHhMuBtdTyrbDHcyF96ftmtmXSl0fYFKYUEWmpYGDbYKJ
	 agpOhXR2EMz1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0415AC44506;
	Sat, 11 Jul 2026 12:07:16 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Sat, 11 Jul 2026 14:07:14 +0200
Subject: [PATCH v7 3/5] can: isotp: fix race between RX/TX timers and frame
 reception
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-isotp-fixes-v7-3-f03af24d8397@hartkopp.net>
References: <20260711-isotp-fixes-v7-0-f03af24d8397@hartkopp.net>
In-Reply-To: <20260711-isotp-fixes-v7-0-f03af24d8397@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783771634; l=7226;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=g5Q4jzJmCFa2+qxJr3RmgfEOzAHC1nAZx/SokfGpgfI=;
 b=bnoo2OCjwXO6b8QbW5K11GB+H3cFmZ1UWGzDtH+E3brMfL1OSyUHlxkK12VzsTJPPqvM4YKmX
 QcLs0LwXQwnC87vDzfWN4SXUrLR34rUagXrQKxgI5vnqJ2nbIPM3JW/
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8323-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A55174173D

From: Oliver Hartkopp <socketcan@hartkopp.net>

When receiving a Consecutive Frame, Flow Control frame, or local echo
frame, hrtimer_cancel() is called to stop the corresponding watchdog
timer. If the timer handler was already running concurrently on another
CPU, hrtimer_cancel() waits for it to finish.

By the time it returns, the timer handler may have already reported a
timeout error and reset the state machine. Blindly continuing corrupts
the newly reset or idle state, and can let a concurrent sendmsg() claim
the same IDLE state at the same time.

Fix this by re-checking the state right after canceling the timer in all
three call sites (isotp_rcv_cf(), isotp_rcv_fc(), isotp_rcv_echo()). If
the state changed, the transfer has already timed out, so drop the frame
instead of resuming it.

However, the state check alone cannot tell a genuinely resumed transfer
from a new one: while hrtimer_cancel() waits, a concurrent sendmsg()
could claim ISOTP_IDLE and start a new transfer that happens to reach
the very same state again. so->tx_gen, bumped each time sendmsg() claims
a new transfer, disambiguates the two and is checked alongside the state.

For the same reason, isotp_sendmsg()'s err_event_drop path must cancel
so->txfrtimer/txtimer before setting so->tx.state to ISOTP_IDLE, not
after: otherwise a concurrent sendmsg() could claim ISOTP_SENDING and
start filling so->tx.buf while a still-armed timer from the aborted
transfer fires and sends a stale frame from it.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/linux-can/20260710142146.BDAE61F000E9@smtp.kernel.org/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 44c044eb83e1..f05703ddd2ea 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -164,10 +164,11 @@ struct isotp_sock {
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
@@ -369,17 +370,27 @@ static int check_pad(struct isotp_sock *so, struct canfd_frame *cf,
 static void isotp_send_cframe(struct isotp_sock *so);
 
 static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 {
 	struct sock *sk = &so->sk;
+	u32 gen = READ_ONCE(so->tx_gen);
 
 	if (so->tx.state != ISOTP_WAIT_FC &&
 	    so->tx.state != ISOTP_WAIT_FIRST_FC)
 		return 0;
 
 	hrtimer_cancel(&so->txtimer);
 
+	/* hrtimer_cancel() may have let isotp_tx_timer_handler() give up on
+	 * this job (state changed) or a new sendmsg() claim and reach the
+	 * same state again (tx_gen changed) - either way this FC is stale.
+	 */
+	if ((so->tx.state != ISOTP_WAIT_FC &&
+	     so->tx.state != ISOTP_WAIT_FIRST_FC) ||
+	    READ_ONCE(so->tx_gen) != gen)
+		return 1;
+
 	if ((cf->len < ae + FC_CONTENT_SZ) ||
 	    ((so->opt.flags & ISOTP_CHECK_PADDING) &&
 	     check_pad(so, cf, ae + FC_CONTENT_SZ, so->opt.rxpad_content))) {
 		/* malformed PDU - report 'not a data message' */
 		sk->sk_err = EBADMSG;
@@ -575,10 +586,18 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
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
@@ -868,10 +887,11 @@ static void isotp_create_fframe(struct canfd_frame *cf, struct isotp_sock *so,
 static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 {
 	struct sock *sk = (struct sock *)data;
 	struct isotp_sock *so = isotp_sk(sk);
 	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
+	u32 gen = READ_ONCE(so->tx_gen);
 
 	/* only handle my own local echo CF/SF skb's (no FF!) */
 	if (skb->sk != sk || so->cfecho != *(u32 *)cf->data)
 		return;
 
@@ -879,10 +899,18 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 	hrtimer_cancel(&so->txtimer);
 
 	/* local echo skb with consecutive frame has been consumed */
 	so->cfecho = 0;
 
+	/* hrtimer_cancel() may have let isotp_tx_timer_handler() give up
+	 * on this job (state changed) or a new sendmsg() claim and reach
+	 * ISOTP_SENDING again (tx_gen changed) - either way this echo is
+	 * stale.
+	 */
+	if (so->tx.state != ISOTP_SENDING || READ_ONCE(so->tx_gen) != gen)
+		return;
+
 	if (so->tx.idx >= so->tx.len) {
 		/* we are done */
 		so->tx.state = ISOTP_IDLE;
 		wake_up_interruptible(&so->wait);
 		return;
@@ -960,10 +988,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
 	int wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
 	s64 hrtimer_sec = ISOTP_ECHO_TIMEOUT;
 	int off;
 	int err;
+	u32 my_gen;
 
 	if (!so->bound || so->tx.state == ISOTP_SHUTDOWN)
 		return -EADDRNOTAVAIL;
 
 	while (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE) {
@@ -978,10 +1007,17 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
 		if (err)
 			goto err_event_drop;
 	}
 
+	/* new transfer: bump generation and drop any echo tag left behind
+	 * by a previously aborted transfer
+	 */
+	my_gen = so->tx_gen + 1;
+	WRITE_ONCE(so->tx_gen, my_gen);
+	so->cfecho = 0;
+
 	/* so->bound is only checked once above - a wakeup may have
 	 * unbound/rebound the socket meanwhile, so re-validate it
 	 */
 	if (!so->bound) {
 		err = -EADDRNOTAVAIL;
@@ -1141,17 +1177,24 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	}
 
 	return size;
 
 err_event_drop:
-	/* got signal: force tx state machine to be idle */
-	so->tx.state = ISOTP_IDLE;
+	/* got signal: cancel timers before touching state, so a concurrent
+	 * sendmsg() can't claim ISOTP_SENDING while a stale timer is armed
+	 */
 	hrtimer_cancel(&so->txfrtimer);
 	hrtimer_cancel(&so->txtimer);
 err_out_drop:
-	/* drop this PDU and unlock a potential wait queue */
-	so->tx.state = ISOTP_IDLE;
+	/* drop this PDU and unlock a potential wait queue, but only if no
+	 * concurrent sendmsg() has since claimed the socket for a new
+	 * transfer while we were cancelling timers above
+	 */
+	if (READ_ONCE(so->tx_gen) == my_gen) {
+		so->cfecho = 0;
+		so->tx.state = ISOTP_IDLE;
+	}
 	wake_up_interruptible(&so->wait);
 
 	return err;
 }
 

-- 
2.53.0



