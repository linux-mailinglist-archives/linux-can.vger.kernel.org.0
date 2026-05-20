Return-Path: <linux-can+bounces-7666-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMvlL0ypDWpr1AUAu9opvQ
	(envelope-from <linux-can+bounces-7666-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 14:30:04 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DDF58DACF
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 14:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C20B130E4F9E
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 12:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60067221F26;
	Wed, 20 May 2026 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="KPy8s53y";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="4pdTDbmn"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6195369D7E
	for <linux-can@vger.kernel.org>; Wed, 20 May 2026 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.160
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779279312; cv=pass; b=Uv2X4lXWQOSBqrYFto5IcDRACr0lQCrzuOs+/hLfNROfKAnHldiEhtwBLvbXUKzAF8kfauUk50doNxRPLC7yNUa95vRzV/UCBgVYdUaQC6GmswqmYLXBW0h7vBZ1ERd98vj1wqqCk6/pHAnjTxpDxTZzRTP4gRXqdIgJkd9mcns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779279312; c=relaxed/simple;
	bh=MO3C2rpOufXkooAuPzsXPBN8o1QTup5w8YsFmOX4Eeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjmo2duRytVqADRnrjqIVDSqNtUDeXuzd7RUYWfHqYQBuvXYA05D215oCbEMttqENV3rZBEYaFRN1QECqyNZ/3qGmECrAt4C6TvFcgQ11yQ5GNZYC64j04Jv7k0Sovq4SEfC3l+nRIwoqz/x+WYwFyPm/61p6RUZ4DRzziEoz4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=KPy8s53y; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=4pdTDbmn; arc=pass smtp.client-ip=81.169.146.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1779279301; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=a9vi1kBUT7mEkAy98LaXtcQVtcCBKFFCHZNrgzM2sRWlJtF9voKuFeVmZRGAa7Pgav
    rGeunmee2NkBIScD9Z6r+7jlkofNsR7pKktWCtRnHp7Mm4WN7VybS+XARD+EVf7e/h6O
    dkC9PkZY08yeb3p46IkmgHlfKI61pxMzjPMP9KWYRQLtq2gIzSpIBW7D1IfFk3jDufZ9
    BD020fDhMDLWg6Xh1svN/MVwfkerL+Xe/0p8aad3+UG99Brf3DfeDwiIYqdnvcCtRlE5
    nVYSRRe4TamO7q9ei0D55+cF82RYlHcluQgdZRv5vjweA33zDQsm7XnyyoBfEgXONJPp
    WSNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1779279301;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=h3DGUwjMKcujEbOe/t4SbVPuweMHfgZVkpQpUW8Nu0k=;
    b=PhoZrgkdFgBL8z1uXK/aPPBYT7MNf4zm1VYG/9KWHY7Qy4FIbhNywy4j/BZAbIXINe
    jta0ghJXOtL8l101dSp4MvRQ4yukYvMbP0K0y2KeCvbnrMIvkqnek3yhmsh5kkrMjfJW
    i8Wo61lDTMQpcTTu/8kSAxKgVP7xL59L7mFZm/cbAj39YvOlipzl9XwIzGdndsTM+sSV
    c813DCH+7ue/kbIwX9461Bm1xvHPNJfKJHFwZjLFXRigmUNoIohaFsUleaAs1jk9Wixi
    dwTfCyuSYteecxy/E3JD1fWFe+lptfQSaNrSIUg4GovAlTsyaDlPRkuByydtOJ3UWRdP
    lpJg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1779279301;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=h3DGUwjMKcujEbOe/t4SbVPuweMHfgZVkpQpUW8Nu0k=;
    b=KPy8s53yLX4vUVxjkacUtquTZWW5UNXFzrvBDpgOo9uYOc+k3SZ151jBHZ/PtzWjoY
    4IWHYY4tQQYRCGXJqsw61lQqqGXMgd5S9QSSDMi7hItq2dFUMMve5o0mHU2qwDwZC0W9
    +S89awB9nw/OFB7+4aVgGrsyDM78ZHEfY25BXisvlCdQZVdMb0dpcFCntNK9stdl+fTE
    UuwFb3ZPV85oa/4K0Rph3DKwZ+ADEmwkPiskCxzRVLn7HgZ5NRCmH13aQiAW1fk6F0se
    SsOy2xcVrp2X/2IWASReZnJTu5H8By74x7CzdynaQEzNdgIXeflifQiiYK7qagv1ZF9G
    p7Nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1779279301;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=h3DGUwjMKcujEbOe/t4SbVPuweMHfgZVkpQpUW8Nu0k=;
    b=4pdTDbmnEvcq9NKgizuA/eayhtI9Sr0jQXiTbCqY3c9XIGPBK+1seZyx3zTg6MG/TF
    nhDtzjlvvE+nE0wmRQDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d24KCF1LFI
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 20 May 2026 14:15:01 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 2/2] can: bcm: use atomic access in receive statistics
Date: Wed, 20 May 2026 14:14:50 +0200
Message-ID: <20260520121450.27964-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520121450.27964-1-socketcan@hartkopp.net>
References: <20260520121450.27964-1-socketcan@hartkopp.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7666-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:email,hartkopp.net:mid,hartkopp.net:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 26DDF58DACF
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
index ff1f5ff8121d..0fe2904d2ce3 100644
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
@@ -739,11 +746,11 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
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


