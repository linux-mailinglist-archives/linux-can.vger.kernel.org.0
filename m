Return-Path: <linux-can+bounces-8172-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3eexIwJZT2qtewIAu9opvQ
	(envelope-from <linux-can+bounces-8172-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 10:17:06 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AEB72E26B
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 10:17:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=ER5rVxHn;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8172-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8172-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C48B304EC1C
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 08:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAA13EAC80;
	Thu,  9 Jul 2026 08:16:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0283F37C0E5
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 08:16:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584969; cv=none; b=DzznpHBK7MkVHoYS+nVbul2hYkGGgKna3RndO1wastSGlWHZ4NHQHZPTECgmIGniBXOUXOwidUTTGjdOTPNgq0im1Xy7T81nun1O1jeJ47nqHobqI1wmjijc3fWjSdSV9KuOSGRmcTc9iTHYlriA93kVs2O8JnGrD+b/DHJKcJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584969; c=relaxed/simple;
	bh=kwbu0QASqGIWWWjcnuvtcz1YToVZ4hA+G5Ckol+wvwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S+aYx4A2pt3C2G41Dy4qs/PqF1iogrqlRWRsycMA7d2AYDzdZkb1th1XhchGHeT/y5u78jFaKrN0JmVKEXsiP9Eedydp1EXxf3OVKGOtyZCEgV4fubbTe0diripue3qWEurTqhw4FI/vliU6e+DPUpVUxZI6nmJepPkCanYxip0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ER5rVxHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D749DC2BCFB;
	Thu,  9 Jul 2026 08:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783584968;
	bh=kwbu0QASqGIWWWjcnuvtcz1YToVZ4hA+G5Ckol+wvwo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ER5rVxHnQpZzg8r3DIftkKCJ/rynxglnZ8mvOKOLKxcOXx4WRYwYBoVIsYBpxSMDB
	 Dc7Kln8H12C9BoG6bHPl8zQQpW1FmDcpb6nsdB2UXslKchUTEGvZnA5Q7JgmukU3LU
	 NTJYP0NldsqHUHkH+3BE3TiF0Ob2hA+JQdJIU12ynCWy/yN55kJdX50Ibu3yCvFywI
	 XR0BX7bIq84utFge0Z/BkysQIqZnNdbsmz01FRFBDgxgqo8F2+Ns+sSWNu+3O7bPGP
	 esUM1ADZFawRB0+aL67SPjL/2Ws7I8F0/os2LiKNaH02gM8lMmJbGQKXJmh9bKSLtY
	 o4HpGSuhTZWqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11A8C44508;
	Thu,  9 Jul 2026 08:16:08 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Thu, 09 Jul 2026 10:16:06 +0200
Subject: [PATCH v9 04/10] can: bcm: fix CAN frame rx/tx statistics
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-bcm_fixes-v9-4-6eebb78ccfb2@hartkopp.net>
References: <20260709-bcm_fixes-v9-0-6eebb78ccfb2@hartkopp.net>
In-Reply-To: <20260709-bcm_fixes-v9-0-6eebb78ccfb2@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783584967; l=5897;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=QpQoH5NlkXdS7idcNsT8qsMuCvJl/KwWNKPLu5Mg2Jw=;
 b=B9IzWb0ik9KAu0vYdEtDw75ksa/PHcFIp9waoOymZ7t4uFs23UTlTedIgolpPeXdJVXl1y9iz
 WsjkfR8cHkWBvzcKVqaG06wAfnCmOz2ySk3v8/XPxWhW/YNm+tDwaFJ
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8172-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,hartkopp.net:replyto,hartkopp.net:mid,hartkopp.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28AEB72E26B

From: Oliver Hartkopp <socketcan@hartkopp.net>

KCSAN detected a data race within the bcm_rx_handler() when two CAN frames
have been simultaneously received and processed in a single rx op by two
different CPUs.

Use atomic operations with (signed) long data types to access the
statistics in the hot path to fix the KCSAN complaint.

Additionally simplify the update and check of statistics overflow by
using the atomic operations in separate bcm_update_[rx|tx]_stats()
functions. The rx variant runs under bcm_rx_update_lock to prevent
races when resetting the two rx counters; the tx variant runs under
bcm_tx_lock and only needs to guard its own counter's overflow.

As the rx path resets its values already at LONG_MAX / 100, there is
no conflict between the two locking domains (bcm_rx_update_lock vs.
bcm_tx_lock) even for ops that use both paths.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 56 +++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 17 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index af4bb4182bc2..1623a402600c 100644
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
 
@@ -278,20 +281,39 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 
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
 
+static void bcm_update_rx_stats(struct bcm_op *op)
+{
+	/* prevent overflow of the reduction% calculation in bcm_proc_show() */
+	if (atomic_long_inc_return(&op->frames_abs) > LONG_MAX / 100) {
+		atomic_long_set(&op->frames_filtered, 0);
+		atomic_long_set(&op->frames_abs, 0);
+	}
+}
+
+static void bcm_update_tx_stats(struct bcm_op *op)
+{
+	/* tx_op has no reduction% calculation - use the full range and
+	 * just keep the displayed counter non-negative on overflow
+	 */
+	if (atomic_long_inc_return(&op->frames_abs) == LONG_MAX)
+		atomic_long_set(&op->frames_abs, 0);
+}
+
 /*
  * bcm_can_tx - send the (next) CAN frame to the appropriate CAN interface
  *              of the given bcm tx op
  */
 static void bcm_can_tx(struct bcm_op *op, struct canfd_frame *cf)
@@ -342,11 +364,11 @@ static void bcm_can_tx(struct bcm_op *op, struct canfd_frame *cf)
 
 	/* update currframe and count under lock protection */
 	spin_lock_bh(&op->bcm_tx_lock);
 
 	if (!err)
-		op->frames_abs++;
+		bcm_update_tx_stats(op);
 
 	op->currframe++;
 
 	/* reached last frame? */
 	if (op->currframe >= op->nframes)
@@ -495,16 +517,13 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
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
@@ -746,20 +765,23 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 
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
+	bcm_update_rx_stats(op);
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



