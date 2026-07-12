Return-Path: <linux-can+bounces-8349-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I97hOkXWU2rVfQMAu9opvQ
	(envelope-from <linux-can+bounces-8349-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 20:00:37 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A25F745944
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 20:00:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=uUEyfdgc;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8349-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8349-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D51693010BAC
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 17:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9970B36655D;
	Sun, 12 Jul 2026 17:59:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74407366042
	for <linux-can@vger.kernel.org>; Sun, 12 Jul 2026 17:59:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783879183; cv=none; b=VL5N5V10pYqldRiC6ccoNeB5wX9H9TX47Px2fYhyYupFcm6gGjQtb9yS38iTthpjC5wH6NagXIVXWr61VcBb+YZuvAvQEcB6u44Hbcnmm6c8HXGE3CSfLtyO4vB+MMkCD6rIjBxpGM8HBwr7UwEoDu8OA7kJ8SibILe2KRuVYUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783879183; c=relaxed/simple;
	bh=e432Y13nQmrHCYP44fKQDFz6BrJGYqQs8I+CX7Zfxf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sro6q1NJCc+fH3UGDayD0vE9Y7HxLXeqia0eDK/M7VFRow/VPqZjV3nSmel62d/bZ/J8wfp7LDJxXZxYffqTDlPXPMYb9Sm9SXEs/NJakmLFnQydG9p9aLCCSOC0j8xzUyJYqpWXUbcamZNIoza7ZnVsQ36ZLJCz12R5I1ih0BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUEyfdgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CECCC2BCFA;
	Sun, 12 Jul 2026 17:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783879183;
	bh=e432Y13nQmrHCYP44fKQDFz6BrJGYqQs8I+CX7Zfxf8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uUEyfdgcOR4Xca2MBeJizPMZxEwkoZEq1lmr4MHdJ/i4OOHpvdOUjZqlfyJYVGCDM
	 m4Snnpl5F+sIONhp8f8Ni5pRXKllXLOqKc0NfZp52A7bw2voT7usGnEPyE0BZ8ekYr
	 ZLuQNtPmlnldPX2d8Cotah2a8ArVe4/7rJPskBA090PHkmzQwXCDL30zmMM9wXYCQD
	 1mbicZqYga0tfaGihzs9iqsh76Y51h7rh5BfpLn/x96W6ZULcgipOIPpRcLwYLkYAQ
	 TTKScFfVaOBiAoRsnNiLB8Nm5GiFf1kxdQA3pLd5po6nIjJR/P7xHrAX8TIaRtIgd2
	 MESF4jddsfWNA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BC9C44508;
	Sun, 12 Jul 2026 17:59:43 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Sun, 12 Jul 2026 19:59:43 +0200
Subject: [PATCH v10 3/3] can: isotp: serialize TX state transitions under
 so->rx_lock
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-isotp-fixes-v10-3-793a1b1ce17f@hartkopp.net>
References: <20260712-isotp-fixes-v10-0-793a1b1ce17f@hartkopp.net>
In-Reply-To: <20260712-isotp-fixes-v10-0-793a1b1ce17f@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783879182; l=16836;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=5M7SIafCDOY4YORoJe/wMltFB973YQmL/fCaMeVJf3E=;
 b=E3V4raHIpXY1dE+QrrUgAVrKDV1nTf+qjUOy9P9rAwgutbabKLNF2g+LgbfBixcTWnrsPvcHP
 aPuWsh52g1dBCwl/sZYI0kV+CVyA9W00jDSUTMFrhfvQjnitGhe73C8
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8349-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:replyto,hartkopp.net:mid,hartkopp.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A25F745944

From: Oliver Hartkopp <socketcan@hartkopp.net>

The TX state machine (so->tx.state) is driven from three contexts:
sendmsg() claiming and progressing a transfer, the RX path consuming
Flow Control/echo frames, and two hrtimers timing out a stalled
transfer. Mixing a lock-free cmpxchg() claim in sendmsg() with
hrtimer_cancel() calls made under so->rx_lock elsewhere left windows
where a frame or timer callback could act on a state that had already
moved on, corrupting an unrelated transfer.

so->rx_lock now covers the full lifecycle of a TX claim: sendmsg()
takes it to check so->tx.state is ISOTP_IDLE, switch it to
ISOTP_SENDING, bump so->tx_gen and drain the previous transfer's
timers - all as one critical section. isotp_rcv_fc()/isotp_rcv_cf()
already run under this lock via isotp_rcv(), and isotp_rcv_echo() now
takes it itself, so none of them can ever observe a transfer mid-claim.
This also means a transfer can no longer be handed to sendmsg()'s
cleanup paths (signal or send error) while another thread is
concurrently claiming or finishing it, so those paths can cancel
timers and reset the state unconditionally.

isotp_release() claims the socket the same way, so a racing sendmsg()
sees a consistent ISOTP_SHUTDOWN and skips arming its timer or sending.

Only the hrtimer callbacks stay outside so->rx_lock, since they run
under so->rx_lock's cancellation elsewhere and taking it themselves
would deadlock. so->tx_gen lets them recognize whether the transfer
they timed out is still the one currently active, so they don't
report an error against a transfer that has since completed or been
superseded.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/linux-can/20260710142146.BDAE61F000E9@smtp.kernel.org/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 202 ++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 160 insertions(+), 42 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 44c044eb83e1..54becaf6898f 100644
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
@@ -870,78 +888,124 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 	struct sock *sk = (struct sock *)data;
 	struct isotp_sock *so = isotp_sk(sk);
 	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 
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
 	/* cancel local echo timeout */
-	hrtimer_cancel(&so->txtimer);
+	hrtimer_cancel(&so->echotimer);
 
 	/* local echo skb with consecutive frame has been consumed */
 	so->cfecho = 0;
 
+	/* claiming a transfer also takes so->rx_lock, so a plain recheck
+	 * is enough: so->tx.state can't have flipped to ISOTP_SENDING for
+	 * a new claim while we're still in here
+	 */
+	if (so->tx.state != ISOTP_SENDING)
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
@@ -958,30 +1022,53 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	struct net_device *dev;
 	struct canfd_frame *cf;
 	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
 	int wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
 	s64 hrtimer_sec = ISOTP_ECHO_TIMEOUT;
+	struct hrtimer *tx_hrt = &so->echotimer;
+	u32 new_state = ISOTP_SENDING;
 	int off;
 	int err;
 
 	if (!so->bound || so->tx.state == ISOTP_SHUTDOWN)
 		return -EADDRNOTAVAIL;
 
-	while (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE) {
+	/* claim the socket under so->rx_lock: this serializes the claim
+	 * with the RX path and with sendmsg()'s own error paths below, so
+	 * none of them can ever see a transfer mid-claim
+	 */
+	for (;;) {
+		spin_lock_bh(&so->rx_lock);
+		if (READ_ONCE(so->tx.state) == ISOTP_IDLE)
+			break;
+		spin_unlock_bh(&so->rx_lock);
+
 		/* we do not support multiple buffers - for now */
 		if (msg->msg_flags & MSG_DONTWAIT)
 			return -EAGAIN;
 
 		if (so->tx.state == ISOTP_SHUTDOWN)
 			return -EADDRNOTAVAIL;
 
 		/* wait for complete transmission of current pdu */
-		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+		err = wait_event_interruptible(so->wait,
+					       so->tx.state == ISOTP_IDLE);
 		if (err)
-			goto err_event_drop;
+			return err;
 	}
 
+	/* new transfer: bump so->tx_gen and drain the old one's timers,
+	 * still under the so->rx_lock we just claimed the socket with
+	 */
+	WRITE_ONCE(so->tx.state, ISOTP_SENDING);
+	WRITE_ONCE(so->tx_gen, READ_ONCE(so->tx_gen) + 1);
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
@@ -1094,22 +1181,37 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 			/* set CF echo tag for isotp_rcv_echo() (CF-mode) */
 			so->cfecho = *(u32 *)cf->data;
 		} else {
 			/* standard flow control check */
-			so->tx.state = ISOTP_WAIT_FIRST_FC;
+			new_state = ISOTP_WAIT_FIRST_FC;
 
 			/* start timeout for FC */
 			hrtimer_sec = ISOTP_FC_TIMEOUT;
+			tx_hrt = &so->txtimer;
 
 			/* no CF echo tag for isotp_rcv_echo() (FF-mode) */
 			so->cfecho = 0;
 		}
 	}
 
-	hrtimer_start(&so->txtimer, ktime_set(hrtimer_sec, 0),
+	spin_lock_bh(&so->rx_lock);
+	if (so->tx.state == ISOTP_SHUTDOWN) {
+		/* isotp_release() has since taken over and already drained
+		 * our timers - don't send into a socket that's going away
+		 */
+		spin_unlock_bh(&so->rx_lock);
+		kfree_skb(skb);
+		dev_put(dev);
+		wake_up_interruptible(&so->wait);
+		return -EADDRNOTAVAIL;
+	}
+	/* WAIT_FIRST_FC for standard FF, else stays ISOTP_SENDING */
+	so->tx.state = new_state;
+	hrtimer_start(tx_hrt, ktime_set(hrtimer_sec, 0),
 		      HRTIMER_MODE_REL_SOFT);
+	spin_unlock_bh(&so->rx_lock);
 
 	/* send the first or only CAN frame */
 	cf->flags = so->ll.tx_flags;
 
 	skb->dev = dev;
@@ -1118,17 +1220,14 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	dev_put(dev);
 	if (err) {
 		pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
 			       __func__, ERR_PTR(err));
 
+		spin_lock_bh(&so->rx_lock);
 		/* no transmission -> no timeout monitoring */
-		hrtimer_cancel(&so->txtimer);
-
-		/* reset consecutive frame echo tag */
-		so->cfecho = 0;
-
-		goto err_out_drop;
+		hrtimer_cancel(tx_hrt);
+		goto err_out_drop_locked;
 	}
 
 	if (wait_tx_done) {
 		/* wait for complete transmission of current pdu */
 		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
@@ -1140,18 +1239,25 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			return err;
 	}
 
 	return size;
 
+err_out_drop:
+	/* claimed but nothing sent yet - no timer to cancel */
+	spin_lock_bh(&so->rx_lock);
+	goto err_out_drop_locked;
 err_event_drop:
-	/* got signal: force tx state machine to be idle */
-	so->tx.state = ISOTP_IDLE;
+	/* interrupted waiting on our own transfer - drain its timers */
+	spin_lock_bh(&so->rx_lock);
 	hrtimer_cancel(&so->txfrtimer);
 	hrtimer_cancel(&so->txtimer);
-err_out_drop:
-	/* drop this PDU and unlock a potential wait queue */
+	hrtimer_cancel(&so->echotimer);
+err_out_drop_locked:
+	/* release the claim; so->rx_lock still held from above */
+	so->cfecho = 0;
 	so->tx.state = ISOTP_IDLE;
+	spin_unlock_bh(&so->rx_lock);
 	wake_up_interruptible(&so->wait);
 
 	return err;
 }
 
@@ -1209,17 +1315,24 @@ static int isotp_release(struct socket *sock)
 		return 0;
 
 	so = isotp_sk(sk);
 	net = sock_net(sk);
 
-	/* wait for complete transmission of current pdu */
-	while (wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE) == 0 &&
-	       cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SHUTDOWN) != ISOTP_IDLE)
+	/* best-effort: wait for a running pdu to finish, but don't block on
+	 * it forever - give up after the first signal
+	 */
+	while (so->tx.state != ISOTP_IDLE &&
+	       wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE) == 0)
 		;
 
-	/* force state machines to be idle also when a signal occurred */
+	/* claim the socket under so->rx_lock like sendmsg() does, so its
+	 * claim can't race the forced ISOTP_SHUTDOWN below; force it
+	 * unconditionally, even when a signal cut the wait above short
+	 */
+	spin_lock_bh(&so->rx_lock);
 	so->tx.state = ISOTP_SHUTDOWN;
+	spin_unlock_bh(&so->rx_lock);
 	so->rx.state = ISOTP_IDLE;
 
 	spin_lock(&isotp_notifier_lock);
 	while (isotp_busy_notifier == so) {
 		spin_unlock(&isotp_notifier_lock);
@@ -1261,10 +1374,11 @@ static int isotp_release(struct socket *sock)
 	 */
 	synchronize_rcu();
 
 	hrtimer_cancel(&so->txfrtimer);
 	hrtimer_cancel(&so->txtimer);
+	hrtimer_cancel(&so->echotimer);
 	hrtimer_cancel(&so->rxtimer);
 
 	sock_orphan(sk);
 	sock->sk = NULL;
 
@@ -1700,14 +1814,18 @@ static int isotp_init(struct sock *sk)
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



