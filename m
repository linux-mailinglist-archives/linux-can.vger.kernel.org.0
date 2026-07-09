Return-Path: <linux-can+bounces-8175-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j0oFN71ZT2roewIAu9opvQ
	(envelope-from <linux-can+bounces-8175-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 10:20:13 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8CB72E2F8
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 10:20:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=ZD81nAsg;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8175-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8175-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97E3F30D08ED
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 08:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7136E233944;
	Thu,  9 Jul 2026 08:16:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A11A3DEAC9;
	Thu,  9 Jul 2026 08:16:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584969; cv=none; b=EgpzwjVta1iDlTV027Hr66DEEsDoe0Dg4WxyibxPjuh+Y6Pfhl3lO14nNA3tzrMnE4As3yA5924HEmMlMsDztV9rGjqGFeEKVOpppeQWPEBgoxYscIdJfzgZU3hwVPMXmbkWqUxlD6fnt9P8Cec3Aoj/9XAWD11RU3JLvZqO6Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584969; c=relaxed/simple;
	bh=aZiDN+VGs4HWcEjup6JCl5Bu85uqQk439I6zrRhM5yI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mwsTBLG5J0/7BfWPJRI/A/T9Bdnq3hgiFmHLcBJE9JaI7I+v3ZhdXGuNEFM+fMnD5pM4SxBnLo8zcC98IBfztli3jqJ/CWMug8Ji7WktgxbkRcQhyIr+IYzqbu4R19zDPKdyd7wUxlx+FCnDh3n+RnXu3BZQISsxJiXIv1BunsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZD81nAsg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC8C2C2BCF6;
	Thu,  9 Jul 2026 08:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783584968;
	bh=aZiDN+VGs4HWcEjup6JCl5Bu85uqQk439I6zrRhM5yI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZD81nAsgarHYcBKGlPtrwyUf1Wj2ziSY3ZIM3FlA62YeAcfrSnMAYaxL0SrQq1FDS
	 8Tcl5v9ARyKLRGsl5h6ck7a54Cms7friGwj+nnSCjzuT3ljRoiEscayWKUAJlWGTNc
	 Ci//sc8x37JBkCAgxOMgHQ6v39lv6ud5yxnEW/x5u7BmDuSxUSwtJsYSa9hKMZEx//
	 XTWiyiDZRe9br4jVCAFTCs/fMSZ7EBF9NsqeZdO7UHj7cuG77N28WYvd+SY5mcKyWi
	 uGWCwhvzqGpRGelCKzoIVzp0JQBHUAYbK67cBV0QoMWpn/tUs1Vf3z21ok1sSuJLEO
	 DwwyB76duZ7Pw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBF5C44507;
	Thu,  9 Jul 2026 08:16:08 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Thu, 09 Jul 2026 10:16:07 +0200
Subject: [PATCH v9 05/10] can: bcm: add missing rcu list annotations and
 operations
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-bcm_fixes-v9-5-6eebb78ccfb2@hartkopp.net>
References: <20260709-bcm_fixes-v9-0-6eebb78ccfb2@hartkopp.net>
In-Reply-To: <20260709-bcm_fixes-v9-0-6eebb78ccfb2@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, sashiko-reviews@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783584967; l=5017;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=xWTGMpj6r9WjQWKiiIthA0/GfYQq26dlCpl9hxBzEI4=;
 b=RdITgVxad9aQeLLUJOVPPEiSKUrw67SxwZrg/p0Q3kuvAaZca6Lv3eyf6bJ+2pxUuhWPSn643
 6gKhXmujNXzB5KXwzzMCGBYmtuQ6qlATeUp4PC5OHk6p4YWQqiAiuIi
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
	TAGGED_FROM(0.00)[bounces-8175-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:sashiko-reviews@lists.linux.dev,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hartkopp.net:replyto,hartkopp.net:mid,hartkopp.net:email,vger.kernel.org:from_smtp,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A8CB72E2F8

From: Oliver Hartkopp <socketcan@hartkopp.net>

sashiko-bot remarked the missing use of list_add_rcu() in
bcm_[rx|tx]_setup() to have a proper initialized bcm_op structure
when bcm_proc_show() traverses the bcm_op's under rcu_read_lock().

To cover all initial settings of the bcm_op's the list_add_rcu() calls
are moved to the end of the setup code.

While at it, also fix the mirroring removal side: bcm_release() called
bcm_remove_op() - which frees the op via call_rcu() - on ops that were
still linked in bo->tx_ops/bo->rx_ops, without list_del_rcu() first.
Unlink each op with list_del_rcu() before handing it to bcm_remove_op(),
matching the existing pattern in bcm_delete_tx_op()/bcm_delete_rx_op().

Reported-by: sashiko-reviews@lists.linux.dev
Closes: https://lore.kernel.org/linux-can/20260610094654.A1FFE1F00893@smtp.kernel.org/
Fixes: dac5e6249159 ("can: bcm: add missing rcu read protection for procfs content")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 1623a402600c..0a7819bc891f 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -263,11 +263,11 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 
 		seq_printf(m, "%s%ld%%\n",
 			   (reduction == 100) ? "near " : "", reduction);
 	}
 
-	list_for_each_entry(op, &bo->tx_ops, list) {
+	list_for_each_entry_rcu(op, &bo->tx_ops, list) {
 
 		seq_printf(m, "tx_op: %03X %s ", op->can_id,
 			   bcm_proc_getifname(net, ifname, op->ifindex));
 
 		if (op->flags & CAN_FD_FRAME)
@@ -1006,10 +1006,11 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			int ifindex, struct sock *sk)
 {
 	struct bcm_sock *bo = bcm_sk(sk);
 	struct bcm_op *op;
 	struct canfd_frame *cf;
+	bool add_op_to_list = false;
 	unsigned int i;
 	int err;
 
 	/* we need a real device to send frames */
 	if (!ifindex)
@@ -1147,12 +1148,11 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 		/* currently unused in tx_ops */
 		hrtimer_setup(&op->thrtimer, hrtimer_dummy_timeout, CLOCK_MONOTONIC,
 			      HRTIMER_MODE_REL_SOFT);
 
-		/* add this bcm_op to the list of the tx_ops */
-		list_add(&op->list, &bo->tx_ops);
+		add_op_to_list = true;
 
 	} /* if ((op = bcm_find_op(&bo->tx_ops, msg_head->can_id, ifindex))) */
 
 	if (op->flags & SETTIMER) {
 		/* set timer values */
@@ -1170,10 +1170,14 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		hrtimer_cancel(&op->timer);
 		/* spec: send CAN frame when starting timer */
 		op->flags |= TX_ANNOUNCE;
 	}
 
+	/* add this bcm_op to the list of the tx_ops? */
+	if (add_op_to_list)
+		list_add_rcu(&op->list, &bo->tx_ops);
+
 	if (op->flags & TX_ANNOUNCE)
 		bcm_can_tx(op, NULL);
 
 	if (op->flags & STARTTIMER)
 		bcm_tx_start_timer(op);
@@ -1354,13 +1358,10 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		hrtimer_setup(&op->timer, bcm_rx_timeout_handler, CLOCK_MONOTONIC,
 			      HRTIMER_MODE_REL_SOFT);
 		hrtimer_setup(&op->thrtimer, bcm_rx_thr_handler, CLOCK_MONOTONIC,
 			      HRTIMER_MODE_REL_SOFT);
 
-		/* add this bcm_op to the list of the rx_ops */
-		list_add(&op->list, &bo->rx_ops);
-
 		/* call can_rx_register() */
 		do_rx_register = 1;
 
 	} /* if ((op = bcm_find_op(&bo->rx_ops, msg_head->can_id, ifindex))) */
 
@@ -1428,14 +1429,16 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			err = can_rx_register(sock_net(sk), NULL, op->can_id,
 					      REGMASK(op->can_id),
 					      bcm_rx_handler, op, "bcm", sk);
 		if (err) {
 			/* this bcm rx op is broken -> remove it */
-			list_del_rcu(&op->list);
 			bcm_remove_op(op);
 			return err;
 		}
+
+		/* add this bcm_op to the list of the rx_ops */
+		list_add_rcu(&op->list, &bo->rx_ops);
 	}
 
 	return msg_head->nframes * op->cfsiz + MHSIZ;
 }
 
@@ -1765,12 +1768,14 @@ static int bcm_release(struct socket *sock)
 	/* remove procfs entry */
 	if (net->can.bcmproc_dir && bo->bcm_proc_read)
 		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
 #endif /* CONFIG_PROC_FS */
 
-	list_for_each_entry_safe(op, next, &bo->tx_ops, list)
+	list_for_each_entry_safe(op, next, &bo->tx_ops, list) {
+		list_del_rcu(&op->list);
 		bcm_remove_op(op);
+	}
 
 	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
 		/*
 		 * Don't care if we're bound or not (due to netdev problems)
 		 * can_rx_unregister() is always a save thing to do here.
@@ -1797,12 +1802,14 @@ static int bcm_release(struct socket *sock)
 
 	}
 
 	synchronize_rcu();
 
-	list_for_each_entry_safe(op, next, &bo->rx_ops, list)
+	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
+		list_del_rcu(&op->list);
 		bcm_remove_op(op);
+	}
 
 	/* remove device reference */
 	if (bo->bound) {
 		WRITE_ONCE(bo->bound, 0);
 		bo->ifindex = 0;

-- 
2.53.0



