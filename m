Return-Path: <linux-can+bounces-8221-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iS6DJcvgT2qGpgIAu9opvQ
	(envelope-from <linux-can+bounces-8221-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 19:56:27 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F35BC7340CA
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 19:56:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=gwzgLH1I;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8221-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8221-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 279703010266
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 17:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CB04195D2;
	Thu,  9 Jul 2026 17:56:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646D54DB548;
	Thu,  9 Jul 2026 17:56:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619782; cv=none; b=ceS5RodkVmYKR2QpWdqYjVrHKdPwUi/cQ9RxSu+Z+of5fcb1M+H7am+eLuKIO8WrZ+dp/NBHGwJZ8l5zbWnsrHcC6dJTLdfIToGYKh6LjTieljBAGLzHTxdS/gLxkq4aT2FzhokvLm0vWcILEGU7NFHxhdzAhrBTYa2ifhfm39o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619782; c=relaxed/simple;
	bh=4h5mJm6hzXmHp3RMShR5nDRhQzyUTAhBQ/DhB6jv82c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sWd4yUlLuutZF4K2j80M36pnlxl/0fXpGvWORe1hLKAKvhsVgy5EzajhSFzGKn+YthQ0Lwb6yvY4ZreIa50CGDfQOkrgVMYr1fIUTH1i5Ug+VVVn7BMU9T7Q41feXBzRk9upSaHSQc1X52o1ti/VVzlRQR6pGAsDN7yJafV1xZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwzgLH1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0542AC2BCF6;
	Thu,  9 Jul 2026 17:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783619782;
	bh=4h5mJm6hzXmHp3RMShR5nDRhQzyUTAhBQ/DhB6jv82c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gwzgLH1IFLlF6mNbP4zJjJqh1slkn/D0epWYtRAQpTXJKBJv8FW6JgLmB2IGZaK8V
	 4lE5rRmufGYo/aUp6mmn6IfS0DcZO8354wxGoMk8SdZUMWkKQSEM0h0u8kBFtxnfZB
	 h0VdqMt3IPvI32clAQJqZlvjnztN4mbkAy9hpdknEYm/nVY8AGrhSjmjNrWiBbqkvB
	 j4XSlQhiskA9YpvjeuCoirZlxDPN/jfb/Gbcx/tD0mhYDnSIF3fAcdhUH6l8lYnsBv
	 OR6b9dfKMC2VrK4uZC2Ae0jgw4uQW7GukIcAUNjzS7ibAn/MRkDNJNTB1v/MYnfzIr
	 Vl2UcU5y0c5OQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BFAC44509;
	Thu,  9 Jul 2026 17:56:21 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Thu, 09 Jul 2026 19:56:19 +0200
Subject: [PATCH v11 05/11] can: bcm: add missing rcu list annotations and
 operations
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-bcm_fixes-v11-5-067ba11bec5c@hartkopp.net>
References: <20260709-bcm_fixes-v11-0-067ba11bec5c@hartkopp.net>
In-Reply-To: <20260709-bcm_fixes-v11-0-067ba11bec5c@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, sashiko-reviews@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783619780; l=5017;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=BJJNQrapkqOpAXJaDkWSoW6xFx0Y1A2VpasMRfEZLk4=;
 b=iyrhmqnKQ4wTCmII3D3+Inkofm+gEsioLFo7C4MqCq8je2nLiI50Mg+ktm9yE1HjPH0gYcS66
 kQAUKy7gHtkBXlOl3Bcg6FgZS8TkMacJ6+fe3cQ66u2VC/AQohhDN75
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
	TAGGED_FROM(0.00)[bounces-8221-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F35BC7340CA

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
index 38c3f690c1cd..940cd9df1cca 100644
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
@@ -1007,10 +1007,11 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -1148,12 +1149,11 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 		/* currently unused in tx_ops */
 		hrtimer_setup(&op->thrtimer, hrtimer_dummy_timeout, CLOCK_MONOTONIC,
 			      HRTIMER_MODE_REL_SOFT);
 
-		/* add this bcm_op to the list of the tx_ops */
-		list_add(&op->list, &bo->tx_ops);
+		add_op_to_list = true;
 
 	} /* if ((op = bcm_find_op(&bo->tx_ops, msg_head->can_id, ifindex))) */
 
 	if (op->flags & SETTIMER) {
 		/* set timer values */
@@ -1171,10 +1171,14 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -1355,13 +1359,10 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
 
@@ -1429,14 +1430,16 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
 
@@ -1766,12 +1769,14 @@ static int bcm_release(struct socket *sock)
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
@@ -1798,12 +1803,14 @@ static int bcm_release(struct socket *sock)
 
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



