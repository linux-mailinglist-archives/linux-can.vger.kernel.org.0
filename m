Return-Path: <linux-can+bounces-7830-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xQimJYXpK2qPHgQAu9opvQ
	(envelope-from <linux-can+bounces-7830-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2026 13:12:05 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 856A7678E4A
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2026 13:12:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=STLqrOsJ;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=nosdus2p;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7830-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7830-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B37F3008CAA
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2026 11:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDD0286419;
	Fri, 12 Jun 2026 11:11:42 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EBD3644C9
	for <linux-can@vger.kernel.org>; Fri, 12 Jun 2026 11:11:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781262702; cv=pass; b=OdCQj/l3GHGOGBTzW8FKkaMSQP1nrNYzL/fRyjUNoyGtslZMEGRIf/wKTr20MdttSQAF469n33zvsakbU06fhgMRGGWk5tK0Bau+DDxItr02cqm8m1M4+gLZ80lfC3mtOINqt97IkwPMV5QK0pRNUcxD+e1tZ6oIb+2kFKqzXHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781262702; c=relaxed/simple;
	bh=Ilnsz5sXFpASOuY5Fd9jyBCRq8PJJTkIx5mKPfu0YGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WdN97PxLn9/5IV8OmONQ+HGJQWpDV8bt4v5vtPZ4oUEbngtw39xPGcudNqP2xM7Yrndv0FpyvP3fRpm5IgwWY/bGPIcvQ/w3yVHI1vFe0IwR16lxvSnNGabhdvIW+al2VaFlQ6kI+Pvt4csyFNl64Cv/bPE6fYDM3HkGBOoRfNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=STLqrOsJ; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nosdus2p; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal: i=1; a=rsa-sha256; t=1781262337; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rlnj9b6cPQF+oyC8J08brptEJVhB/qUYmm0doXyGPI9Jy8ejuZDi+s0Q6xcjHTkm5X
    YArAqm+DxSYJeDoTRhUqG0AtPRpkXKShMpU34abtQthaIGv8AL31c5PLqGEGLKOAe4lr
    IWiBfmhBi4nDd37e1U2Nn4t00OnJTJ+4TL6WgUa0b/kKRG3+SWHVE4NF+ADvhX60i/Lx
    sNiIXENqLXIXr5HIV1fmmYvCOHWBCvonrp3FYQWnxm3v2N4EayFgR73kCd+DRBYlmkGw
    NFIVDV1XWhEDn0K1NkwT0AgJMBpuCsesCXEZB3B1Na+IhP7uet1TsA8gTfUnjNlHb6nT
    /ZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1781262337;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=1n103eNgOcrK42VPTL8DyI0Mveh/v9BxKKF7x6jABSM=;
    b=cgIb3yUz2DXgEUcsmJivWk1RL09jeHNN2CQx/Jo3ug4ttt7trydiNDxFAMF0jFdLdL
    XZnZ9d3wobi68PU/+MetqoR0z49Ys3v4TUw/aRYM5g0kDMi/Rw8s27A5Bjb7BOtn91rW
    iieVqohAbIRQkkg1zTyvSyqlK1c2/QMo6E67DlBYWtzKJ6NJKLr/ZJKzsBQkLNT922RZ
    Xw0MBFX0TjrBlCOIu+gTthsq0j2muxVAuQTwyaJLs1HOdzc5JL3eLbrk+e0DZKW0a/GK
    TGvS8GdpOKPEDh5Uzo0hujETwhaQ0yif03eqP4CYCCjbtV0ltJzfsT0nBz/6p4Xtkvx3
    3ucg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1781262337;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=1n103eNgOcrK42VPTL8DyI0Mveh/v9BxKKF7x6jABSM=;
    b=STLqrOsJsD4dbXKFvwUr/aox8WDnH7mAORxpql6EwcM7VF1k5fKy6S3VBMa6fDVkM1
    pVCR50NZD4J8xipsIHqNVChDWa4FiVwDtb+SJ2Mitn613V2HUlBhNFVpEt+Y53JsafX/
    xaCqueISc6/kvDhHTBVEzg+9KNL/LYnfRITpwQNemqNT6buayttS5dweb+sEQIkQSi3C
    sLzfQ0pyyove//ZkdDhsGIFkqQAfGRkuRb/8CNfIegqiQ1KCPKmr8wFjPLzO+LPOOS/t
    e1VyKAyQVu3uFke7f6Yej3D/LLJ5y+4P6NVGanUabGDLMuDa6EED9UX4/2l2VkW78W/j
    gw8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1781262337;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=1n103eNgOcrK42VPTL8DyI0Mveh/v9BxKKF7x6jABSM=;
    b=nosdus2pyIquxLaF6t2YlhinHk0fqJF7rl80FTBpMHFFLElwrSzH8QMUi8OQMYcsIi
    OwDgq6A3d5TEvJltuSBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d25CB5b8wB
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 12 Jun 2026 13:05:37 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Fri, 12 Jun 2026 13:05:19 +0200
Subject: [PATCH 4/5] can: bcm: fix CAN frame rx/tx statistics
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-bcm_fixes-v1-4-ca2fa07ee70f@hartkopp.net>
References: <20260612-bcm_fixes-v1-0-ca2fa07ee70f@hartkopp.net>
In-Reply-To: <20260612-bcm_fixes-v1-0-ca2fa07ee70f@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781262336; l=4601;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=Ilnsz5sXFpASOuY5Fd9jyBCRq8PJJTkIx5mKPfu0YGs=;
 b=A6SH8fsM79Vf0uEIT8DeGKW0mXoJs4WIWwk0rpBYB3Qo7NL3K/SGzUA3hP0LJlAfROAKV4wwt
 0eyIvZveaCUBQf3wFDKxnU1mG5dCfDQ/om8ZqmEN+p+0hLwXmW2ZVfT
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7830-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,hartkopp.net:dkim,hartkopp.net:email,hartkopp.net:mid,hartkopp.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 856A7678E4A

KCSAN detected a data race within the bcm_rx_handler() when two CAN frames
have been simultaneously received and processed in a single rx op by two
different CPUs.

Use atomic operations with (signed) long data types to access the
statistics in the hot path to fix the KCSAN complaint.

Additionally simplify the update and check of statistics overflow by
using the atomic operations in a separate bcm_update_stats() function.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index fc5158132b55..f1f1f11d1f92 100644
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
 static void bcm_can_tx(struct bcm_op *op)
@@ -338,11 +351,11 @@ static void bcm_can_tx(struct bcm_op *op)
 
 	/* update currframe and count under lock protection */
 	spin_lock_bh(&op->bcm_tx_lock);
 
 	if (!err)
-		op->frames_abs++;
+		bcm_update_stats(op);
 
 	op->currframe++;
 
 	/* reached last frame? */
 	if (op->currframe >= op->nframes)
@@ -491,16 +504,13 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
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
@@ -737,11 +747,11 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 	/* save rx timestamp */
 	op->rx_stamp = skb->tstamp;
 	/* save originator for recvfrom() */
 	op->rx_ifindex = skb->dev->ifindex;
 	/* update statistics */
-	op->frames_abs++;
+	bcm_update_stats(op);
 
 	if (op->flags & RX_RTR_FRAME) {
 		/* send reply for RTR-request (placed in op->frames[0]) */
 		bcm_can_tx(op);
 		return;

-- 
2.53.0


