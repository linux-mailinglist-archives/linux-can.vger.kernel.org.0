Return-Path: <linux-can+bounces-8152-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t0AmLOmITmpjOwIAu9opvQ
	(envelope-from <linux-can+bounces-8152-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 19:29:13 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDE272935A
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 19:29:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b="QNR/BL8f";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8152-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8152-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2295F30568A2
	for <lists+linux-can@lfdr.de>; Wed,  8 Jul 2026 17:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7791549550B;
	Wed,  8 Jul 2026 17:27:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FD742B32F
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 17:27:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783531625; cv=none; b=lUG1xmyhsKmE+6Oub34aKfLHpoC9S20JjkHVON+UOxWjVpmGCCsU36k9FCIkOpreze7buCXsTCmeh8x22R0COh4+mVq0aWlzQ3PMJwHk4lEuZ6Yp8xnfEvWxlIiBg5EpDOIt1UePpOdjrDkFu36MWQhjkRWSq1HVWu3id3jwuAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783531625; c=relaxed/simple;
	bh=rTeKvi/x5lpPfyC60LCTF21rSAlwk23x5rWgAPAFjFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CXCMAg/jm1e27qprUk8v7L2Kn2LFbKcBspP6+VvETjBJOK51wivCzZGEjkd9Mt4kYDb7m7vRgB2MCRQ/MIXPgM7SZyIemdnlGYqkFPiV9kL1GjZqtnsRPZPiySgmTCe8ki/dNlXFiVLp2e52x1HbkD8aJKuYTgJDPoOSUqtpsKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNR/BL8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 328F9C2BCF4;
	Wed,  8 Jul 2026 17:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783531625;
	bh=rTeKvi/x5lpPfyC60LCTF21rSAlwk23x5rWgAPAFjFI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QNR/BL8fshfEz/mD4bCsU8L5L262S1WQD2KPbpbUAupETuzf6DDN8+gjQJsMsRlvA
	 Hb0i6msb9+dnIepwQU+zKkx5iPAwSOtk+wfeyljcOiZv4M+JEkaKmRZId4i9SBVNO2
	 XT3451B9U95thbJAb3WAzkvFlFtd3dhV3BBTJmUDMALQMwD5tDcKm5EYqUiNMI4j1z
	 omuKvScgU9igyKewqFJK8mj6sCTZDMZDr8PK+46hlP67ebSTKfUWtf4YZPuNKQNTGF
	 YdOfZ3diiaAbPGrc/CPGtAHNMlvoQszDFGlyD8aWuJmcq3qdOHBEHy510AjhV2CDop
	 l+G5TXk9cqfYQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AF1C44506;
	Wed,  8 Jul 2026 17:27:05 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Wed, 08 Jul 2026 19:27:01 +0200
Subject: [PATCH v8 04/10] can: bcm: fix CAN frame rx/tx statistics
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-bcm_fixes-v8-4-8c2f5f3bc212@hartkopp.net>
References: <20260708-bcm_fixes-v8-0-8c2f5f3bc212@hartkopp.net>
In-Reply-To: <20260708-bcm_fixes-v8-0-8c2f5f3bc212@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783531623; l=5246;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=9nUyZLVL8gRmQOXh/UV97B3g1LLHaQafpLp/e7ndSOQ=;
 b=9Vd4+C7SWi3vCPpPdBnrundOceoIrmID6R9U5CvTcPxQOHNCAoj5FMQj6csKgUWQTrw2ZJjTP
 fwf0sXYo5UGAWaPUE0iY40Dy7Ris8peER7RExFNgzg87m0b8YOtLepw
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8152-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,hartkopp.net:replyto,hartkopp.net:mid,hartkopp.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0DDE272935A

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
 net/can/bcm.c | 47 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index af4bb4182bc2..340b7fc89744 100644
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
@@ -746,20 +756,23 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 
 	/* save rx timestamp */
 	op->rx_stamp = skb->tstamp;
 	/* save originator for recvfrom() */
 	op->rx_ifindex = skb->dev->ifindex;
-	/* update statistics */
-	op->frames_abs++;
 
-	/* snapshot the flag under lock: op->flags/op->frames may be updated
-	 * concurrently by bcm_rx_setup().
+	/* snapshot RTR content under lock: op->flags/op->frames may be
+	 * updated concurrently by bcm_rx_setup().
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



