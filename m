Return-Path: <linux-can+bounces-7688-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iTf5Gq2bEGpuawYAu9opvQ
	(envelope-from <linux-can+bounces-7688-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 22 May 2026 20:08:45 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 068B25B8D25
	for <lists+linux-can@lfdr.de>; Fri, 22 May 2026 20:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E42BF3010BFD
	for <lists+linux-can@lfdr.de>; Fri, 22 May 2026 18:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4676F32C957;
	Fri, 22 May 2026 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Nx4BH1D/";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="IiBowGfg"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1BD33A9CB
	for <linux-can@vger.kernel.org>; Fri, 22 May 2026 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779473308; cv=pass; b=QVLWI5n9Nq9bsJ3GpV7An66TzYZfAshPmiZvSuVIvkzbHxjCcfiicygPVZOUU2ihgmo06+LXq15C4V6sOWlXGcLXfRpQ5neGzLEVhZ5vUbS+HgidRMLIEolrlix9YQKMvS6tQFa+BnSdIc4UyDzSXHo/4FK238m2+YCjojVmRjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779473308; c=relaxed/simple;
	bh=igL1ukzisPilhQquEks62I80Y0TSzB1zSMUrZdE7rio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=taAlBPOVwaYjabYFdcYkTX9ff3/8T3OQg+WTeZu3l6PtlBA3lY1yRpJD7vUHiZmzFNvfQoMyRbcUfeRKEbtpPZm1rOkH+PFYyFvmx9f7PHinXsR99fOmvLt5FbHYuOZJHtp3CHcVdiAeOj5pKyIEjWujwYhCE+6j8eyLC2RoBVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Nx4BH1D/; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=IiBowGfg; arc=pass smtp.client-ip=81.169.146.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1779473295; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YvRXkHpEAfYIYnOYqMRxm2P1fzmFzdnBpD0RwgxwaJGFRPeeM0cxBQ4E/EsIMmm1IS
    /GqK5KblOa372+A+A196coFAxtu736vg2kjCYTqMX8Crd6EB9/i/Z1ziyCs+uiXzux58
    E/CN2EX/uzcMzYj2bNSSz9Hiva7rHcMiV9xMKBVFV+Opxqx/NaQlXMNuYWUWjBF3gR5i
    rFVo5JYSdJ4cCDvBRK6JiAH3TfxQv4Rr2DELqHXd4FW6BSAVkyjkNtNh9J1O7R+MOAWM
    dBtvwJBs0jHcyeYV3aT4dfyCJYGyJM6V+ZaqrVRU6bJkBOrFbJ2L8hKjiDgn/Oxo/m9S
    Q+Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1779473295;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=EDhdRmH9Ons+qCcKh5r48flGtxfmWSQ1+jnzhPzyV8g=;
    b=mc9jjH4f5Eyyx0Nmjed9EP9tMndDHQxdLqFd2YqsCe1GpT61XisATCldpeiW/tD1CY
    oYF6S5CRQ6HLBcyTlWoU8ZZq3wf6/DRwUoAg2MWIWDqMiOUci6bWSw+i8NJsTpYFhBZU
    7uOCQTa4ueWGkFdtWDKbDIiXJu7NaWiRGb3KrNcNhL1ECVhxQ7QMp5jIh0rwGXhdTG4z
    dEUuDxiBRLRfje1NkuAfiQYe1cNmWqOwnPuqcrzKzaTVvlQZXSn9Frj0cfVwWOMlQCgU
    /7hBuwsbzz+9OweV2Xm3+Zj+30lyIdLqyTuJXezTdssyP1wRyCmgHL3FaVK+Og6ccy19
    xXTw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1779473295;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=EDhdRmH9Ons+qCcKh5r48flGtxfmWSQ1+jnzhPzyV8g=;
    b=Nx4BH1D/AlnFzYtm7K/47g8W+ELvg+fhVg48MSyqO7JQBnmMU5ycraT6P3I0W+rAAJ
    nJBl5EfNyny9ghUlUF5g1MRQ08Gynbw5O2nUzVrar+VSCVrXPR/Bs2i98qnA6d/n1xdg
    bLb3d3EoNiAGRq49G+kgdQ3v244gAW4ggHy/TWNWBUxUrIytGCqdqiC+xWWUnMyhJgm/
    lAd+Qn9kPFqM0AqmdDLYQAU4Cq2LIojGfwL0LxrrnOR38Z7LnCKZZN6CyfUg8Ij3pYfV
    vJqQe054t2p3LxVf5+ifEQqNGHn99IG1vXJkMEhEI+GVupRO/lPIUArJ59e6xjYL6vtl
    MxRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1779473295;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=EDhdRmH9Ons+qCcKh5r48flGtxfmWSQ1+jnzhPzyV8g=;
    b=IiBowGfgrA5KQAK+L29OzB3Goi0UawpWZ9YCsY6LSjeIBfRDMS5NDKDnwZlDP4zJWw
    AHZY9ICIbuCyb41nxUAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d24MI8FUgz
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 22 May 2026 20:08:15 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2 2/2] can: bcm: use atomic access in receive statistics
Date: Fri, 22 May 2026 20:07:58 +0200
Message-ID: <20260522180758.51128-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522180758.51128-1-socketcan@hartkopp.net>
References: <20260522180758.51128-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7688-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 068B25B8D25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

KCSAN detected a data race within the bcm_rx_handler() when two CAN frames
have been simultaneously received and processed in a single rx op by two
different CPUs.

Use atomic operations to access the statistics in the hot path to fix the
KCSAN complaint.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index dbdf5d4f4ed7..8a2cb766603d 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -106,11 +106,12 @@ struct bcm_op {
 	struct list_head list;
 	struct rcu_head rcu;
 	int ifindex;
 	canid_t can_id;
 	u32 flags;
-	unsigned long frames_abs, frames_filtered;
+	atomic_long_t frames_abs;
+	atomic_long_t frames_filtered;
 	struct bcm_timeval ival1, ival2;
 	struct hrtimer timer, thrtimer;
 	ktime_t rx_stamp, kt_ival1, kt_ival2, kt_lastmsg;
 	int rx_ifindex;
 	int cfsiz;
@@ -226,11 +227,11 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 	list_for_each_entry_rcu(op, &bo->rx_ops, list) {
 
 		unsigned long reduction;
 
 		/* print only active entries & prevent division by zero */
-		if (!op->frames_abs)
+		if (!atomic_long_read(&op->frames_abs))
 			continue;
 
 		seq_printf(m, "rx_op: %03X %-5s ", op->can_id,
 			   bcm_proc_getifname(net, ifname, op->ifindex));
 
@@ -248,13 +249,16 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 		if (op->kt_ival2)
 			seq_printf(m, "thr=%lld ",
 				   (long long)ktime_to_us(op->kt_ival2));
 
 		seq_printf(m, "# recv %ld (%ld) => reduction: ",
-			   op->frames_filtered, op->frames_abs);
+			   atomic_long_read(&op->frames_filtered),
+			   atomic_long_read(&op->frames_abs));
 
-		reduction = 100 - (op->frames_filtered * 100) / op->frames_abs;
+		reduction = 100 -
+			(atomic_long_read(&op->frames_filtered) * 100) /
+			atomic_long_read(&op->frames_abs);
 
 		seq_printf(m, "%s%ld%%\n",
 			   (reduction == 100) ? "near " : "", reduction);
 	}
 
@@ -274,11 +278,12 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 
 		if (op->kt_ival2)
 			seq_printf(m, "t2=%lld ",
 				   (long long)ktime_to_us(op->kt_ival2));
 
-		seq_printf(m, "# sent %ld\n", op->frames_abs);
+		seq_printf(m, "# sent %ld\n",
+			   atomic_long_read(&op->frames_abs));
 	}
 	seq_putc(m, '\n');
 
 	rcu_read_unlock();
 
@@ -334,11 +339,11 @@ static void bcm_can_tx(struct bcm_op *op)
 
 	/* update currframe and count under lock protection */
 	spin_lock_bh(&op->bcm_tx_lock);
 
 	if (!err)
-		op->frames_abs++;
+		atomic_long_inc(&op->frames_abs);
 
 	op->currframe++;
 
 	/* reached last frame? */
 	if (op->currframe >= op->nframes)
@@ -488,15 +493,17 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
 static void bcm_rx_changed(struct bcm_op *op, struct canfd_frame *data)
 {
 	struct bcm_msg_head head;
 
 	/* update statistics */
-	op->frames_filtered++;
+	atomic_long_inc(&op->frames_filtered);
 
 	/* prevent statistics overflow */
-	if (op->frames_filtered > ULONG_MAX/100)
-		op->frames_filtered = op->frames_abs = 0;
+	if (atomic_long_read(&op->frames_filtered) > ULONG_MAX / 100) {
+		atomic_long_set(&op->frames_filtered, 0);
+		atomic_long_set(&op->frames_abs, 0);
+	}
 
 	/* this element is not throttled anymore */
 	data->flags &= ~RX_THR;
 
 	memset(&head, 0, sizeof(head));
@@ -733,11 +740,11 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 	/* save rx timestamp */
 	op->rx_stamp = skb->tstamp;
 	/* save originator for recvfrom() */
 	op->rx_ifindex = skb->dev->ifindex;
 	/* update statistics */
-	op->frames_abs++;
+	atomic_long_inc(&op->frames_abs);
 
 	if (op->flags & RX_RTR_FRAME) {
 		/* send reply for RTR-request (placed in op->frames[0]) */
 		bcm_can_tx(op);
 		return;
-- 
2.53.0


