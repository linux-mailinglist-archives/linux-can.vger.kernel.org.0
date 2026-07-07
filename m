Return-Path: <linux-can+bounces-8082-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tjfJEdQRTWpNugEAu9opvQ
	(envelope-from <linux-can+bounces-8082-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 16:48:52 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 021DE71CD48
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 16:48:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=I1eaC2jM;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8082-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8082-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86C8730A1F7D
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 14:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2379742A14A;
	Tue,  7 Jul 2026 14:32:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F356442641A
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 14:32:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434740; cv=none; b=MYRmgA/12HX7J5WtMB0UJ3wlZXnPXyBVsV5HsxBbxCOdJDv5mLrZ0ObFPiuVTIaxQFA2qqdkVzpfc9b0HjLHyw1FrsKhaBEXyAbfdPXDLksWL4HJUPHr7dJF/cAOWoVPJDUdvTweodxJQvbLhoteZSHzWtulTb0RkkRZOZUKdwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434740; c=relaxed/simple;
	bh=f2vr/6P7m9aqe0k+y1DiPzRWO9Mf6HAuT0iantFh6YI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SHDICPu/yZ836WlFxsAtKGavL5MpFXujYWdaoaNyBjLLXz+yjc0IzYbGXSfPdKqQaVJVJ+0GwShHxSgUns1qvlHWJZ/szXwTQdKNquzFGO50TAmL5WZCIu90VnyS6VaMqmzooNOgJSVuvFFog5OwT/vJ4PsSm+lOjfM1LUwX/4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1eaC2jM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2AF5C2BCFC;
	Tue,  7 Jul 2026 14:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783434739;
	bh=f2vr/6P7m9aqe0k+y1DiPzRWO9Mf6HAuT0iantFh6YI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=I1eaC2jMovfZ29uXls6IHfBManAP649ZbcD0KeaH+5D+myid9JeJmXR4+t7smXpd8
	 XH9RVusqd9jyjxGlV0u0gc0jKQcWTY4ZHXnbhEumKQXuwT7ftf/B62JaYy8fYBE5wt
	 fgaLt70BEnhG7LFL7Vwx5oBVDsRQ5+JOT/65uE7FjoIjdyeCr0uiZrShldr/vbrBXC
	 dCawsidjQxto6ECkRIfEXCSOt9tThUAwutiFn0uUGU9MC63GM8WJg6qEKCBCBfvVd1
	 pUqGNIF9jTx1OrgWTiWikNB0QnogeiWLC12cEYbRKTlO1Lisa+VpQBoN19K41TUUNi
	 +W3CE48LcVfZw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD04C44502;
	Tue,  7 Jul 2026 14:32:19 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Tue, 07 Jul 2026 16:32:16 +0200
Subject: [PATCH v4 4/7] can: bcm: fix CAN frame rx/tx statistics
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-bcm_fixes-v4-4-aa87b8b9d33f@hartkopp.net>
References: <20260707-bcm_fixes-v4-0-aa87b8b9d33f@hartkopp.net>
In-Reply-To: <20260707-bcm_fixes-v4-0-aa87b8b9d33f@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783434738; l=5582;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=7y9a6P2rYUtkra70azjN0jxmCHqm4czAk6U7J2h46gs=;
 b=bdkhZaerEVFBLyxh+DliRvwgSyR+/a/LylQpFDE+HvC2urC7JIrjp2bZdVU6r8LzF1I//9ekA
 KV2vbqso1t/CA9T9CaG0Tl80n2ZNX/XodEIL7UQVY9VpJVA8Zf0HrEx
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
	TAGGED_FROM(0.00)[bounces-8082-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,s:lists@lfdr.de];
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
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 021DE71CD48

From: Oliver Hartkopp <socketcan@hartkopp.net>

KCSAN detected a data race within the bcm_rx_handler() when two CAN frames
have been simultaneously received and processed in a single rx op by two
different CPUs.

Use atomic operations with (signed) long data types to access the
statistics in the hot path to fix the KCSAN complaint.

Additionally simplify the update and check of statistics overflow by
using the atomic operations in a separate bcm_update_stats() function and
put this function under bcm_rx_update_lock to prevent races when resetting
the counters.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 49 +++++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index b9b6f1b7bb03..0b53dbb64dd1 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -110,11 +110,11 @@ struct bcm_op {
 	struct rcu_head rcu;
 	struct work_struct work;
 	int ifindex;
 	canid_t can_id;
 	u32 flags;
-	unsigned long frames_abs, frames_filtered;
+	atomic_long_t frames_abs, frames_filtered;
 	struct bcm_timeval ival1, ival2;
 	struct hrtimer timer, thrtimer;
 	ktime_t rx_stamp, kt_ival1, kt_ival2, kt_lastmsg;
 	int rx_ifindex;
 	int cfsiz;
@@ -227,14 +227,17 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(op, &bo->rx_ops, list) {
 
-		unsigned long reduction;
+		long reduction, frames_filtered, frames_abs;
+
+		frames_filtered = atomic_long_read(&op->frames_filtered);
+		frames_abs = atomic_long_read(&op->frames_abs);
 
 		/* print only active entries & prevent division by zero */
-		if (!op->frames_abs)
+		if (!frames_abs)
 			continue;
 
 		seq_printf(m, "rx_op: %03X %-5s ", op->can_id,
 			   bcm_proc_getifname(net, ifname, op->ifindex));
 
@@ -252,13 +255,13 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 		if (op->kt_ival2)
 			seq_printf(m, "thr=%lld ",
 				   (long long)ktime_to_us(op->kt_ival2));
 
 		seq_printf(m, "# recv %ld (%ld) => reduction: ",
-			   op->frames_filtered, op->frames_abs);
+			   frames_filtered, frames_abs);
 
-		reduction = 100 - (op->frames_filtered * 100) / op->frames_abs;
+		reduction = 100 - (frames_filtered * 100) / frames_abs;
 
 		seq_printf(m, "%s%ld%%\n",
 			   (reduction == 100) ? "near " : "", reduction);
 	}
 
@@ -278,20 +281,30 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 
 		if (op->kt_ival2)
 			seq_printf(m, "t2=%lld ",
 				   (long long)ktime_to_us(op->kt_ival2));
 
-		seq_printf(m, "# sent %ld\n", op->frames_abs);
+		seq_printf(m, "# sent %ld\n",
+			   atomic_long_read(&op->frames_abs));
 	}
 	seq_putc(m, '\n');
 
 	rcu_read_unlock();
 
 	return 0;
 }
 #endif /* CONFIG_PROC_FS */
 
+static void bcm_update_stats(struct bcm_op *op)
+{
+	/* prevent statistics overflow */
+	if (atomic_long_inc_return(&op->frames_abs) > LONG_MAX / 100) {
+		atomic_long_set(&op->frames_filtered, 0);
+		atomic_long_set(&op->frames_abs, 0);
+	}
+}
+
 /*
  * bcm_can_tx - send the (next) CAN frame to the appropriate CAN interface
  *              of the given bcm tx op
  */
 static void bcm_can_tx(struct bcm_op *op, struct canfd_frame *cf)
@@ -342,11 +355,11 @@ static void bcm_can_tx(struct bcm_op *op, struct canfd_frame *cf)
 
 	/* update currframe and count under lock protection */
 	spin_lock_bh(&op->bcm_tx_lock);
 
 	if (!err)
-		op->frames_abs++;
+		bcm_update_stats(op);
 
 	op->currframe++;
 
 	/* reached last frame? */
 	if (op->currframe >= op->nframes)
@@ -495,16 +508,13 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
  */
 static void bcm_rx_changed(struct bcm_op *op, struct canfd_frame *data)
 {
 	struct bcm_msg_head head;
 
-	/* update statistics */
-	op->frames_filtered++;
-
-	/* prevent statistics overflow */
-	if (op->frames_filtered > ULONG_MAX/100)
-		op->frames_filtered = op->frames_abs = 0;
+	/* update statistics (frames_filtered <= frames_abs) */
+	if (atomic_long_read(&op->frames_abs))
+		atomic_long_inc(&op->frames_filtered);
 
 	/* this element is not throttled anymore */
 	data->flags &= ~RX_THR;
 
 	memset(&head, 0, sizeof(head));
@@ -746,23 +756,26 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 
 	/* save rx timestamp */
 	op->rx_stamp = skb->tstamp;
 	/* save originator for recvfrom() */
 	op->rx_ifindex = skb->dev->ifindex;
-	/* update statistics */
-	op->frames_abs++;
 
-	/* snapshot the flag under lock: op->flags/op->frames may be updated
-	 * concurrently by bcm_rx_setup(). Do not call bcm_can_tx() while
-	 * holding bcm_rx_update_lock: CAN loopback on echo-capable
+	/* snapshot RTR content under lock: op->flags/op->frames may be updated
+	 * concurrently by bcm_rx_setup(). But do not call bcm_can_tx() while
+	 * holding the bcm_rx_update_lock: CAN loopback on echo-capable
 	 * interfaces (e.g. vcan) can deliver the transmitted skb back into
 	 * bcm_rx_handler() synchronously from within dev_queue_xmit().
 	 */
 	spin_lock_bh(&op->bcm_rx_update_lock);
+
+	/* update statistics with lock analogue to bcm_rx_changed() callers */
+	bcm_update_stats(op);
+
 	rtr_frame = op->flags & RX_RTR_FRAME;
 	if (rtr_frame)
 		memcpy(&rtrframe, op->frames, op->cfsiz);
+
 	spin_unlock_bh(&op->bcm_rx_update_lock);
 
 	if (rtr_frame) {
 		/* send reply for RTR-request (placed in op->frames[0]) */
 		bcm_can_tx(op, &rtrframe);

-- 
2.53.0



