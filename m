Return-Path: <linux-can+bounces-7664-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMXMKtFsDWrgxAUAu9opvQ
	(envelope-from <linux-can+bounces-7664-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 10:12:01 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1586258975D
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 10:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7595F30F21D8
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 08:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3444736E489;
	Wed, 20 May 2026 08:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsFCSxdd"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD122E11DC;
	Wed, 20 May 2026 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264336; cv=none; b=Ze09kUUOUdt6MJ05pcDBNIjTajdfAkmVl8Lxg4G4MQbYI0UJIjVdhWPMB8ajM5wNKZNKURoq0F/bOP9Blg3wYmg6I9rOtYJMj813P4bIdLofPeqcI12ny2ZkkX/Ef2LrzPkU8wmz0YFHc/CCNpNpr07LFS34MXwNWAVjJL5r7XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264336; c=relaxed/simple;
	bh=WVlyY/hDAjGnfHPan8TJTofhOdYOAQsa8eAmhn3UpK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ktNtWEEJVeS6rFrjP6IF31HiGkdL7IolBi2///UYm3kMuRtjEHeoQTQy67esQj5aVCaAR3520wfGLkJ0B8WfYtmGooNgrwmLLudvsO1JW834Wk2TstQQGKKVQSOLdVohoPTdOekA493DCKPB0ozLkNWh1oXbDuyEvHcr5Nwt7o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsFCSxdd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C20D1F000E9;
	Wed, 20 May 2026 08:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779264332;
	bh=+A6TLYm2amfTjZeZ59mJL1aGdm/BKak08Nxwhh3dsSc=;
	h=From:To:Cc:Subject:Date;
	b=QsFCSxdd2pA73IfOXUc0F1pLjzYF+t5qAXM9t6Wxhe0kNG8YYvUVXo+fffjFseMYz
	 6lRTT/SStqQZIDq+v36T+X4hzyWRh6TYP5El06V65ALbFPFS5EVgtVbktp5Ptr2eBj
	 4Lb7ZQXulA8pL9To2fmSBtZJdOcxLqc8Z0tfpZy7I/cHlPyGuPEgKNwTH6RLmGFC7Z
	 8YN5jLrOdxUBynTqBVMst19InwO2fFS46+jn+L3PAXHLM0EKCEeRwPqpNyBf+eqHVA
	 uH5kZnNvfgIhwBb94qaM8IzHrHyaXwIHhQd0ougznM8DZu7fo7vZZGul0v2QMV2Xb9
	 zRfdbyYFGScpg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kuba@kernel.org
Subject: [PATCH 1/1] can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF
Date: Wed, 20 May 2026 09:05:21 +0100
Message-ID: <20260520080523.2513957-1-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7664-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1586258975D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly synchronize_rcu()")
Signed-off-by: Lee Jones <lee@kernel.org>
---
Not v2 per-say - this is replaces the following with a different approach:

can: bcm: prevent thrtimer UAF in rx path by checking RX_NO_AUTOTIMER
- https://lore.kernel.org/r/20260422102239.948594-1-lee@kernel.org
- https://lore.kernel.org/r/20260508151237.7d0a9105@kernel.org

 net/can/bcm.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index a4bef2c48a55..fa42c0f89f4e 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -58,6 +58,7 @@
 #include <linux/can/skb.h>
 #include <linux/can/bcm.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 #include <linux/spinlock.h>
 #include <net/can.h>
 #include <net/sock.h>
@@ -92,6 +93,8 @@ MODULE_ALIAS("can-proto-2");
 
 #define BCM_MIN_NAMELEN CAN_REQUIRED_SIZE(struct sockaddr_can, can_ifindex)
 
+static struct workqueue_struct *bcm_wq;
+
 /*
  * easy access to the first 64 bit of can(fd)_frame payload. cp->data is
  * 64 bit aligned so the offset has to be multiples of 8 which is ensured
@@ -105,6 +108,7 @@ static inline u64 get_u64(const struct canfd_frame *cp, int offset)
 struct bcm_op {
 	struct list_head list;
 	struct rcu_head rcu;
+	struct work_struct work;
 	int ifindex;
 	canid_t can_id;
 	u32 flags;
@@ -793,9 +797,12 @@ static struct bcm_op *bcm_find_op(struct list_head *ops,
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
@@ -806,6 +813,14 @@ static void bcm_free_op_rcu(struct rcu_head *rcu_head)
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
@@ -1839,11 +1854,15 @@ static int __init bcm_module_init(void)
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
@@ -1861,6 +1880,8 @@ static int __init bcm_module_init(void)
 	unregister_netdevice_notifier(&canbcm_notifier);
 register_notifier_failed:
 	unregister_pernet_subsys(&canbcm_pernet_ops);
+register_pernet_failed:
+	destroy_workqueue(bcm_wq);
 	return err;
 }
 
@@ -1869,6 +1890,7 @@ static void __exit bcm_module_exit(void)
 	can_proto_unregister(&bcm_can_proto);
 	unregister_netdevice_notifier(&canbcm_notifier);
 	unregister_pernet_subsys(&canbcm_pernet_ops);
+	destroy_workqueue(bcm_wq);
 }
 
 module_init(bcm_module_init);
-- 
2.54.0.631.ge1b05301d1-goog


