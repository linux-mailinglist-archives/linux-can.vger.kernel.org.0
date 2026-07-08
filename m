Return-Path: <linux-can+bounces-8133-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4hHHJKlwTmofMwIAu9opvQ
	(envelope-from <linux-can+bounces-8133-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 17:45:45 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BA9728363
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 17:45:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b="kDOEr/sD";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8133-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8133-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8498131A4D6F
	for <lists+linux-can@lfdr.de>; Wed,  8 Jul 2026 15:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD5F3F12DB;
	Wed,  8 Jul 2026 15:21:23 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C1D3B813A
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 15:21:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524082; cv=none; b=ZUz3YtLcVgSWOcQ9diQzI7m/p3BiZS1/eZTryPHMZClfzysiUNMrZ/AkTqzp3Qp+ZX9olRkcfAYd2qNn+nnmUIL0UD5mPzdYkJkrf8qzoQYzoqimFyp2Pt/oHTquUFmxlJYhjo26Pp3BvxfwrZvygsH5p1uRyr2uvPF58gEHTOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524082; c=relaxed/simple;
	bh=b0VHGNfSKkdaRe44rgMgbVJ3bvrqgw1UMcsUmFbBiQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N7lM8Ht6fblpr5K10BzjRvP2GvfdEZlRhZnZNwk91mC/Y44CL8wsIYsJ/UA1MaBkNRyfM033kbzYObMZWvW31ENOdXj+WNEKfhDOtyYnQyEnR2A59EClEVAt8OEuF/gNox5C70f245uHxkWYavWEeFuaO3qh/SVw3TwikMGHWU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDOEr/sD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFC3BC2BCB3;
	Wed,  8 Jul 2026 15:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783524082;
	bh=b0VHGNfSKkdaRe44rgMgbVJ3bvrqgw1UMcsUmFbBiQY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kDOEr/sDTy+FfZQRabdqPQH037C49TIZurkUbOcJohkk0DD7w+ws3Oauo+TUoC5dy
	 vZS9MfO34VCjLxg2qhAAlpeaIDCoAJ0f5xlIFchoGn1r+HIsOHd75jzkzoxC3quKPm
	 igTu07O/gsoY4wGMskWQ8cUQvze8nBE5gyGlhNRBM1h/fTA0dWNVBMQr9iZi32bdjM
	 by+DNpT/xHb3VxCGAABiv+co2t1lEpCcy5If5I76nSOb0Yvq349sECW6OqTeQovFr+
	 xwIStxf/3MUIZ6CAtLgREvslLBpapughKhP+aHrflpHisk00Pgpc+mQcJEBd0ZzrcT
	 pAa9/MoluP/tA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0041C44501;
	Wed,  8 Jul 2026 15:21:21 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Wed, 08 Jul 2026 17:21:11 +0200
Subject: [PATCH v7 01/10] can: bcm: defer rx_op deallocation to workqueue
 to fix thrtimer UAF
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-bcm_fixes-v7-1-c78896b342e4@hartkopp.net>
References: <20260708-bcm_fixes-v7-0-c78896b342e4@hartkopp.net>
In-Reply-To: <20260708-bcm_fixes-v7-0-c78896b342e4@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Lee Jones <lee@kernel.org>, 
 Feng Xue <feng.xue@outlook.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783524080; l=6459;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=HLu6KLqysIbTcTJRJ9fWwVQaVrLBGRp/BcX5+2NtnEw=;
 b=JAHL3E3OfFcczP5sr1gkZJViev+YIB6H0PjQfno0+Se+Q7i4Jo+T7m4z1Fz278dUoLetDTT08
 csK/bqsIcGeCkV/9XlthRHqTmvRGyXmREYP/W/bAzCrHdc3zHJ0R9q/
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8133-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:lee@kernel.org,m:feng.xue@outlook.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:replyto,hartkopp.net:mid,hartkopp.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,volkswagen.de:email,outlook.com:email];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[hartkopp.net,pengutronix.de,kernel.org,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27BA9728363

From: Lee Jones <lee@kernel.org>

Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
synchronize_rcu()") replaced synchronize_rcu() in bcm_delete_rx_op()
with call_rcu() and introduced the RX_NO_AUTOTIMER flag.

However, this flag check was omitted for thrtimer in the packet rx
fast-path. During BCM RX operation teardown, a concurrent RCU reader
(bcm_rx_handler) can race and re-arm thrtimer via
bcm_rx_update_and_send() after call_rcu() has been scheduled.  Once
the RCU grace period elapses, bcm_op is freed.  The subsequently
firing thrtimer then dereferences the deallocated op, causing a UAF.

Adding flag checks to the rx fast-path (bcm_rx_update_and_send) does not
fully close the TOCTOU race and introduces latency for every CAN frame.
Conversely, calling hrtimer_cancel() directly inside the RCU callback
(softirq context) is fatal as hrtimer_cancel() can sleep, triggering
a "scheduling while atomic" panic.

Resolve this by deferring the timer cancellation and memory free to a
dedicated unbound workqueue (bcm_wq).  The RCU callback now queues a
work item to bcm_wq, which safely cancels both timers and deallocates
memory in sleepable process context.  A dedicated workqueue is used to
prevent system-wide WQ saturation and is cleanly flushed/destroyed
on module unload to avoid rmmod page faults.

Since the deferred work can now outlive the calling context by an
unbounded amount, also take a reference on op->sk when it is assigned
and drop it only once the deferred work has cancelled both timers, so a
socket can no longer be freed out from under a still-armed timer whose
callback (bcm_send_to_user()) dereferences op->sk.

Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly synchronize_rcu()")
Tested-by: Feng Xue <feng.xue@outlook.com>
Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index a4bef2c48a55..bdf53241bd7b 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -56,10 +56,11 @@
 #include <linux/can.h>
 #include <linux/can/core.h>
 #include <linux/can/skb.h>
 #include <linux/can/bcm.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 #include <linux/spinlock.h>
 #include <net/can.h>
 #include <net/sock.h>
 #include <net/net_namespace.h>
 
@@ -90,10 +91,12 @@ MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Oliver Hartkopp <oliver.hartkopp@volkswagen.de>");
 MODULE_ALIAS("can-proto-2");
 
 #define BCM_MIN_NAMELEN CAN_REQUIRED_SIZE(struct sockaddr_can, can_ifindex)
 
+static struct workqueue_struct *bcm_wq;
+
 /*
  * easy access to the first 64 bit of can(fd)_frame payload. cp->data is
  * 64 bit aligned so the offset has to be multiples of 8 which is ensured
  * by the only callers in bcm_rx_cmp_to_index() bcm_rx_handler().
  */
@@ -103,10 +106,11 @@ static inline u64 get_u64(const struct canfd_frame *cp, int offset)
 }
 
 struct bcm_op {
 	struct list_head list;
 	struct rcu_head rcu;
+	struct work_struct work;
 	int ifindex;
 	canid_t can_id;
 	u32 flags;
 	unsigned long frames_abs, frames_filtered;
 	struct bcm_timeval ival1, ival2;
@@ -791,23 +795,40 @@ static struct bcm_op *bcm_find_op(struct list_head *ops,
 	}
 
 	return NULL;
 }
 
-static void bcm_free_op_rcu(struct rcu_head *rcu_head)
+static void bcm_free_op_work(struct work_struct *work)
 {
-	struct bcm_op *op = container_of(rcu_head, struct bcm_op, rcu);
+	struct bcm_op *op = container_of(work, struct bcm_op, work);
+
+	hrtimer_cancel(&op->timer);
+	hrtimer_cancel(&op->thrtimer);
 
 	if ((op->frames) && (op->frames != &op->sframe))
 		kfree(op->frames);
 
 	if ((op->last_frames) && (op->last_frames != &op->last_sframe))
 		kfree(op->last_frames);
 
+	/* the last possible access to op->timer/op->thrtimer has now
+	 * happened above via hrtimer_cancel() - op->sk is no longer
+	 * needed by any pending timer callback, so drop our reference
+	 */
+	sock_put(op->sk);
+
 	kfree(op);
 }
 
+static void bcm_free_op_rcu(struct rcu_head *rcu_head)
+{
+	struct bcm_op *op = container_of(rcu_head, struct bcm_op, rcu);
+
+	INIT_WORK(&op->work, bcm_free_op_work);
+	queue_work(bcm_wq, &op->work);
+}
+
 static void bcm_remove_op(struct bcm_op *op)
 {
 	hrtimer_cancel(&op->timer);
 	hrtimer_cancel(&op->thrtimer);
 
@@ -1058,10 +1079,11 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		/* tx_ops never compare with previous received messages */
 		op->last_frames = NULL;
 
 		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
 		op->sk = sk;
+		sock_hold(sk);
 		op->ifindex = ifindex;
 
 		/* initialize uninitialized (kzalloc) structure */
 		hrtimer_setup(&op->timer, bcm_tx_timeout_handler, CLOCK_MONOTONIC,
 			      HRTIMER_MODE_REL_SOFT);
@@ -1219,10 +1241,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			}
 		}
 
 		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
 		op->sk = sk;
+		sock_hold(sk);
 		op->ifindex = ifindex;
 
 		/* ifindex for timeout events w/o previous frame reception */
 		op->rx_ifindex = ifindex;
 
@@ -1837,15 +1860,19 @@ static struct notifier_block canbcm_notifier = {
 
 static int __init bcm_module_init(void)
 {
 	int err;
 
+	bcm_wq = alloc_workqueue("can-bcm-wq", WQ_UNBOUND, 0);
+	if (!bcm_wq)
+		return -ENOMEM;
+
 	pr_info("can: broadcast manager protocol\n");
 
 	err = register_pernet_subsys(&canbcm_pernet_ops);
 	if (err)
-		return err;
+		goto register_pernet_failed;
 
 	err = register_netdevice_notifier(&canbcm_notifier);
 	if (err)
 		goto register_notifier_failed;
 
@@ -1859,17 +1886,21 @@ static int __init bcm_module_init(void)
 
 register_proto_failed:
 	unregister_netdevice_notifier(&canbcm_notifier);
 register_notifier_failed:
 	unregister_pernet_subsys(&canbcm_pernet_ops);
+register_pernet_failed:
+	destroy_workqueue(bcm_wq);
 	return err;
 }
 
 static void __exit bcm_module_exit(void)
 {
 	can_proto_unregister(&bcm_can_proto);
 	unregister_netdevice_notifier(&canbcm_notifier);
 	unregister_pernet_subsys(&canbcm_pernet_ops);
+	rcu_barrier();
+	destroy_workqueue(bcm_wq);
 }
 
 module_init(bcm_module_init);
 module_exit(bcm_module_exit);

-- 
2.53.0



