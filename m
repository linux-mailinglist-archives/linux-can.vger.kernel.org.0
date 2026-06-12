Return-Path: <linux-can+bounces-7826-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j25KIC/oK2o0HgQAu9opvQ
	(envelope-from <linux-can+bounces-7826-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2026 13:06:23 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D19678DDF
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2026 13:06:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=UUJDL3Kq;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=0Uifv8QG;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7826-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-7826-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2485E30BAB94
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2026 11:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D10737BE6B;
	Fri, 12 Jun 2026 11:05:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1D238399C
	for <linux-can@vger.kernel.org>; Fri, 12 Jun 2026 11:05:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781262346; cv=pass; b=VfJ6Qdnj6kwodJvi+GT/at+d2NwOF2hKCxtSLcx30nOGKmO2WBbfGvLr2p1VmYsTP2uxYBWAEy4c797vz2cIZqe9BbYaW48n1fu3PRDiOEAOaIio9mHT0+zU9XCBEYior3Dy3QgOcNayxJmqGPAuUOYHxc5Zu1MEnH0SctFC8FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781262346; c=relaxed/simple;
	bh=KyOJL+8riywQWwSvms9L2892yHVEpfGvRMNs/APPfzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mp2cVrQn7DVok7M7j0BvZ4s1denOfiQ3a1MwHfH5E0/6WGNbq0yw1++fBOUM/NLXB4GAs0p7CTFMnXpnYGEFl6DjIgoBEkFLGyijIEAm/ZKq/6F+v+d+N4ucWMaQmzTdtmNzpKtTl1yqzb95tNrsZAwFfkExdPPqU6Ab7L3Vjgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UUJDL3Kq; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=0Uifv8QG; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal: i=1; a=rsa-sha256; t=1781262336; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RaXlo9FD9lFbrpJ65AYnfNkYZh7bkM50Kj14Hf7eVVbDfke4uJFkwq8hNpTpTlrJXB
    lM9pu8BaKaw7DzMwalqlmJNTYJDuv6qtl2jURFWT6K4FzSeQX+qr6RxU2sO/GhhFw/Z2
    GujWOq+MUEGMn7cKGryXSDd+/fIfdR9/+I1AAyJ38yDwySju+U60l2bnh7cM+I0ZLlVn
    4VklVhGqopLrr9Ge3ajZ6d3h9qp7MZ1eXxU+qa8ZcYIFMzrfwQob/3LieobHp14A4GJj
    rKV/NUmqYHBXOSFkLxS/zRU1fwfOnNlGPUM275NoWGjeji8FE5gmkL2q7kzFiKeeM4Ox
    O3kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1781262336;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=i9suZLtuO5sXh06slJWyr1Vrf05w7Inds+5l25iUY7g=;
    b=QA/xdZubrETjgTeWKmXKmNM53nulgF0kUG/R/o0sZcp/3c5gSkA9XBoQmvHvFGSwOl
    4q7/l3OsUaBxphXSK5oNB9OUVgYGm+oI7IisRWrlD177jzefiIHiW/qpmh1hJbtsQaCR
    /ccqjRXWP+KU0Buj62gOvbBcix1kVLibUBrQwkVRxS1kQH45AKI8We9q6i6N/BwBuEbx
    lltPW5JjWOswe91hgXKU3A6pXTV5S8iJTvXRN6TI6N+TtxCDZA3dZaIhQJsnO2EDFYpW
    wm6wV7wjwAFtxj+j/GcEu1+axns5D5jpyZlTVIq/jJR/FQ4c4L+eEdswrvbsdiezS6J5
    PP+w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1781262336;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=i9suZLtuO5sXh06slJWyr1Vrf05w7Inds+5l25iUY7g=;
    b=UUJDL3KqO3AZxas+eP3YmJoufs6RzW7xB2Q7C5Wfmp0AuRwif/ce8R8Vj8Sq0yVykH
    uxXRjgbTJh/oySpa0WCeN4O5WY6euJGp0mHEi83NTBik0jFiu5WKnIr4Bf9voV0jcBIi
    YNVm8Xkw1RtThiOH9WeFhiqr/J13s7e0yFTWOdpbUx1m5jm4jxzsooGTdiS1W/y0i3NX
    y9LzPo+iyEXpBu5iYkQeQhP8D9Tz03/t/5B5AVG7LftlwY0ujcM8pZEkZdWY12ylRyZ9
    K7AkIF647vGAz9ALhrcKzVNI4S+7V9WJkiunjpDQ3SOtKf9YitqZf2U7QvxTZWLx3l27
    UOnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1781262336;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=i9suZLtuO5sXh06slJWyr1Vrf05w7Inds+5l25iUY7g=;
    b=0Uifv8QG8JjMCB9iZqJ7EFoGT7oVAimLWiS4A9nULkJLctu2OeSlaXazjO/l9XGbVi
    4O3nwbSSQDcvN9wFghAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d25CB5a8w7
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 12 Jun 2026 13:05:36 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Fri, 12 Jun 2026 13:05:16 +0200
Subject: [PATCH 1/5] can: bcm: defer rx_op deallocation to workqueue to fix
 thrtimer UAF
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-bcm_fixes-v1-1-ca2fa07ee70f@hartkopp.net>
References: <20260612-bcm_fixes-v1-0-ca2fa07ee70f@hartkopp.net>
In-Reply-To: <20260612-bcm_fixes-v1-0-ca2fa07ee70f@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Lee Jones <lee@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781262336; l=4918;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=87y9klb+KGXDzNFshqV6uGcyXJJleji+c9iIKS9zQrk=;
 b=WE6DIJuhEFjFZuTQQ3Y3+TvovHdh2b5ffHgprJkBVCIFgVmGwmyd/hyVKHax0y2/PNX2SDW2h
 K12o4waCPuVDTxiWkS71NJaXF5UZN5C5p/3on0BWJJNDpBvV7N25R0N
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7826-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:lee@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,volkswagen.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5D19678DDF

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

Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly synchronize_rcu()")
Signed-off-by: Lee Jones <lee@kernel.org>
---
 net/can/bcm.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index a4bef2c48a55..c49b09f3229f 100644
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
@@ -791,23 +795,34 @@ static struct bcm_op *bcm_find_op(struct list_head *ops,
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
 
@@ -1837,15 +1852,19 @@ static struct notifier_block canbcm_notifier = {
 
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
 
@@ -1859,17 +1878,21 @@ static int __init bcm_module_init(void)
 
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


