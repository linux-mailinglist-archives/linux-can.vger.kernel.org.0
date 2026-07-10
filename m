Return-Path: <linux-can+bounces-8309-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4XpHHHhZUWq+CwMAu9opvQ
	(envelope-from <linux-can+bounces-8309-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 22:43:36 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F7773E730
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 22:43:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=KX3sSdb2;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8309-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8309-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F98B3023F8B
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 20:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB903A7858;
	Fri, 10 Jul 2026 20:43:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872823A16B8
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 20:42:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783716179; cv=none; b=HOwjV6GMht8m1jie4ALGwgvirfo0Kd0YfG1qqenwu5a7A58jEcvIGUJ3VEvWJsFCse0qjiZbZROtVkGo5E+FXRhILbNPaWVomDkmgkJjy4nGYP3hQ9yjPH8IWJFIMspbQJq9c4IISHpsTp0h3yGtzF/Bu+Tj78fZMoFG5qtfmZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783716179; c=relaxed/simple;
	bh=TE6oHu4q8fWrW17bY+A8ALkYTLwVwl0pxWMG7Rl71HM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K3m6Vr/ewbEj0olb2XsJDNdxb3rItoAl2iv9KBQlLBZt8VgHSA53MoOhQfwlmyTR6+/Tfa+kicyckH6du624QCug4d5UTwgTZDtHwVU+ERi+I8paY7RtP+rAlGLdU+5xnDrSdAgDRKcr9jF6XQgnJxuq9c4Mee58NeQIR4cBNH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KX3sSdb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16C03C2BCF5;
	Fri, 10 Jul 2026 20:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783716179;
	bh=TE6oHu4q8fWrW17bY+A8ALkYTLwVwl0pxWMG7Rl71HM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KX3sSdb2zb+CJlBtY8BQubwZqq8yljvex5OAYS+a4rsBWo4R1H9XU8lom1JkIrJrM
	 ulmNJXP7mbK677uw6YwR0h5OYLBjVJTl92ecFFzhi7fbXWRTdSNTadL+Skq810Te8p
	 +vnqDvYqGqqSEHS2rKHAx0bAU5+eht3rtDC5Q7XFTHlOzv4fNnvJlOI8TKjhK6x/ii
	 izgKvTKYOamp2TwOG3XNP4hblj7y1zTFxilFXqvcleYWv5TTf4m1uLAcQpIkBoh+OX
	 F64WRRbjrXfsgndhOowk7SJdYDZa3m1tSrrZ2DedNb3fN/yxGoL4J+KYcy4gLYrNBg
	 E3icfCGna25kw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5AEC44506;
	Fri, 10 Jul 2026 20:42:58 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Fri, 10 Jul 2026 22:42:54 +0200
Subject: [PATCH v6 3/5] can: isotp: fix race between RX/TX timers and frame
 reception
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-isotp-fixes-v6-3-a13c2539093d@hartkopp.net>
References: <20260710-isotp-fixes-v6-0-a13c2539093d@hartkopp.net>
In-Reply-To: <20260710-isotp-fixes-v6-0-a13c2539093d@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783716177; l=4179;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=pyGHkunbhmyG18O15nIawnmCk/gN0NevMAxv3PlAyNw=;
 b=88xtklvO9j/3NgwdgMbrUdjuWqS9RgEBN/SmG1+T9dctxP8wuxiUxsBlFlTxOhxhFX07B8M75
 vxQgCHpUViWAcwk6TLiUiRGqrVX85MtbnauUjUFZPO9w1L4VDLQFFJf
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
	TAGGED_FROM(0.00)[bounces-8309-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hartkopp.net:replyto,hartkopp.net:mid,hartkopp.net:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B2F7773E730

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
 net/can/isotp.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 44c044eb83e1..5ef2a610fc17 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -376,10 +376,19 @@ static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 	    so->tx.state != ISOTP_WAIT_FIRST_FC)
 		return 0;
 
 	hrtimer_cancel(&so->txtimer);
 
+	/* isotp_tx_timer_handler() may have raced us for so->tx.state while
+	 * hrtimer_cancel() above waited for it to finish, already reporting
+	 * the tx error and resetting the state; don't resume a tx job that
+	 * has already been given up on.
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
@@ -575,10 +584,18 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
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
@@ -879,10 +896,18 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 	hrtimer_cancel(&so->txtimer);
 
 	/* local echo skb with consecutive frame has been consumed */
 	so->cfecho = 0;
 
+	/* isotp_tx_timer_handler() may have raced us for so->tx.state while
+	 * hrtimer_cancel() above waited for it to finish, already reporting
+	 * the tx error and resetting the state; don't resume a tx job that
+	 * has already been given up on.
+	 */
+	if (so->tx.state != ISOTP_SENDING)
+		return;
+
 	if (so->tx.idx >= so->tx.len) {
 		/* we are done */
 		so->tx.state = ISOTP_IDLE;
 		wake_up_interruptible(&so->wait);
 		return;
@@ -1141,12 +1166,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	}
 
 	return size;
 
 err_event_drop:
-	/* got signal: force tx state machine to be idle */
-	so->tx.state = ISOTP_IDLE;
+	/* got signal: force tx state machine to be ISOTP_IDLE */
 	hrtimer_cancel(&so->txfrtimer);
 	hrtimer_cancel(&so->txtimer);
 err_out_drop:
 	/* drop this PDU and unlock a potential wait queue */
 	so->tx.state = ISOTP_IDLE;

-- 
2.53.0



