Return-Path: <linux-can+bounces-8353-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oAtPAVEFVGrlgwMAu9opvQ
	(envelope-from <linux-can+bounces-8353-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 23:21:21 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5BD745F1F
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 23:21:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=BjAmmdvJ;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8353-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8353-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14490300A3A8
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 21:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C20299943;
	Sun, 12 Jul 2026 21:21:18 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8182701B6
	for <linux-can@vger.kernel.org>; Sun, 12 Jul 2026 21:21:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783891278; cv=none; b=Qi6LMapzyIlz7cWOP06pxt+gtRgd1wREt1UmLhQUMd/Sf9CfyfZas/wvlhS3FG/nquI9TtTzPrkwdcID3MQFQ1St1GnSz1adQoFGlulGVv/bXe1abRxjTm0JyGC+cWftIbqPqNnke4iqT7IgUtEZuzXh7c7ZCd1KUB+Ht7ZFFRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783891278; c=relaxed/simple;
	bh=HQ9uV+e+UJUm0/QCfX6YXDV7IC9Vrpc3Cc9c8/8NzjE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c9bAStvEJbcI5E5mXSFUOWbloJSlkwC/DGa+g3tMByQH6xc3PF+5GEpHK+t3dDypdwgLhKUjvqOvv3Wam8NOsDQh03aANYEfcZlfMWpc0Mf2qXkWAJ4f21jyUqtClDXiNvDIj3gCoo14fQ8IxtJ4crZ78XRZkRpGvmQgeKKTV5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BjAmmdvJ; arc=none smtp.client-ip=209.85.216.74
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-381250979d5so2777689a91.0
        for <linux-can@vger.kernel.org>; Sun, 12 Jul 2026 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783891276; x=1784496076; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e4rXRPbfeC6mVzKvFVhXkq2wmASEcGbz8F4Jb8LgzSg=;
        b=BjAmmdvJHROpm4BqL0F0odeEgFNcYJ0mHzg7HjVnKJ+ikbKBOmeTu9oLp7UlleLzLc
         qxvvqTozOwdFIF6X6NHkDUqZUIruwdoumsSJgnIGhDAs8Y52txVzic/wtqznVAd1VJgZ
         S3SUt5AudfIAAapolSAgsk+uMpiEAd0+05uRH78LevlxtvWaW3dUM5AB4BaDmCYaYZx6
         APrVhUkPGD9TbRRKlqdpQFkm9+EDUwW1bDkK4heJbY58RlwcaLGi9EsVeL0g9k8aiDmh
         phNx9C5VB+Vw8X+S2EHyrefTdWG/5zhnTwsmBtK/potoNLmbvU0ho8+Wi/TLk1S1t5ER
         xs/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783891276; x=1784496076;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e4rXRPbfeC6mVzKvFVhXkq2wmASEcGbz8F4Jb8LgzSg=;
        b=dzzXWxFiW02Tc7UHiSL9Y+ytYCPEaStolVdBLjjLL5VgsoVF4ivP75LC6Xnmr7rBdd
         ydrmmnp67IEFM0IEiZv135M6Lr8y71E1H7QK+3jO4MkHaykDubsxbnpbYd4e8KUotnsT
         2GfH5s8sgAiPda4K1otpb5+G6tqTxQvD/2YV9now8ekvAnkroopJpfCi1Czsnv+4kAxD
         c94w3VlhH2aAJ6IKsUonL4YVr7iPLOoNMU1JqcXVXPA5CS9/Wm5uIu5+lH4giGFURSkc
         uTs4g3AYG7MUS9yiLPIqCJkuog9XS8VakpG3ngESBh2Gf4Lbflg4PjiPyITdiajib9kG
         ZjRA==
X-Forwarded-Encrypted: i=1; AHgh+Rp7jyNTKJGnGuI9F/t9JICk0gfqGPiIwxgrfiDisE7v+ZRLBotEuI+sju/WPyBJdjFWvSuui4/bxnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB4ZwsgDErs8fRxJlBdX+/JkfIKAFjp7u0ySHOS/uIhpByge/N
	Xn+Y20lH+7U7PGnL2ZyTHmb01W9q7+Suv4y/B0gkkYSBWfLbXjYau9qYoBtEtenx7H/gjHDed1w
	G7TJxcQ==
X-Received: from pjbpm14.prod.google.com ([2002:a17:90b:3c4e:b0:380:f768:acfb])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2889:b0:387:e0db:bc34
 with SMTP id 98e67ed59e1d1-38dc7bbee67mr6416251a91.42.1783891275866; Sun, 12
 Jul 2026 14:21:15 -0700 (PDT)
Date: Sun, 12 Jul 2026 21:21:08 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260712212113.181121-1-kuniyu@google.com>
Subject: [PATCH v1] vxcan: Support per-netns device unregistration.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-8353-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,gmail.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A5BD745F1F

Currently, vxcan_dellink() unregisters both local and peer devices
synchronously under RTNL.

Once RTNL is removed, it can be called concurrently from different
netns.

Let's use xchg() and unregister_netdevice_queue_net() to support
per-netns device unregistration.

This way, each device is queued for destruction only once by
the winner of the race.

Note that the extra netdev_hold() ensures that @peer obtained by
the first xchg() is not freed during the subsequent access to
netdev_priv(peer).  The 2nd xchg() overwrites @dev to balance
the refcount.

Tested:

1. Create two vxcan pairs (vxcan1-2, vxcan3-4) between two netns
   (ns1 & ns2).

  # ip netns add ns1
  # ip netns add ns2
  # ip -n ns1 link add vxcan1 type vxcan peer vxcan2 netns ns2
  # ip -n ns1 link add vxcan3 type vxcan peer vxcan4 netns ns2

2. Run bpftrace to check if the same process does NOT
   unregister the paired vxcan devices

  # bpftrace -e '#include <linux/netdevice.h>
  kprobe:free_netdev {
      $dev = (struct net_device *)arg0;
      printf("PID: %d | DEV: %s%s\n", pid, $dev->name, kstack());
  }'

3. Remove vxcan2 in ns2 and check bpftrace output

  # ip -n ns2 link del vxcan2

  PID: 1524 | DEV: vxcan2
          free_netdev+5
          netdev_run_todo+4798
          rtnl_dellink+1507
          rtnetlink_rcv_msg+1791
          netlink_rcv_skb+504
  ...
  PID: 453 | DEV: vxcan1
          free_netdev+5
          netdev_run_todo+4798
          process_scheduled_works+2538
          worker_thread+1906
          kthread+806
          ret_from_fork+805
          ret_from_fork_asm+17

4. Remove ns2 (thus vxcan4) and check bpftrace output

  # ip netns del ns2

  PID: 12 | DEV: vxcan4
          free_netdev+5
          netdev_run_todo+4798
          default_device_exit_batch+2271
          ops_undo_list+993
          cleanup_net+1122
          process_scheduled_works+2538
          worker_thread+1906
          kthread+806
          ret_from_fork+805
          ret_from_fork_asm+17
  ...
  PID: 462 | DEV: vxcan3
          free_netdev+5
          netdev_run_todo+4798
          process_scheduled_works+2538
          worker_thread+1906
          kthread+806
          ret_from_fork+805
          ret_from_fork_asm+17

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
This mirros commit d7fda2c776b2 ("veth: Support per-netns device
unregistration.").

The patch is based on net-next.git because it seems both main/master
of linux-can.git and linux-can-next.git are not synced with net-next.
71ac90cca6d8 is needed to verify the test output.
---
 drivers/net/can/vxcan.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index e882250180ef..b7efed1226d8 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -33,6 +33,7 @@ MODULE_ALIAS_RTNL_LINK(DRV_NAME);
 
 struct vxcan_priv {
 	struct net_device __rcu	*peer;
+	netdevice_tracker	peer_tracker;
 };
 
 static netdev_tx_t vxcan_xmit(struct sk_buff *oskb, struct net_device *dev)
@@ -268,9 +269,11 @@ static int vxcan_newlink(struct net_device *dev,
 	/* cross link the device pair */
 	priv = netdev_priv(dev);
 	rcu_assign_pointer(priv->peer, peer);
+	netdev_hold(peer, &priv->peer_tracker, GFP_KERNEL);
 
 	priv = netdev_priv(peer);
 	rcu_assign_pointer(priv->peer, dev);
+	netdev_hold(dev, &priv->peer_tracker, GFP_KERNEL);
 
 	return 0;
 
@@ -281,24 +284,25 @@ static int vxcan_newlink(struct net_device *dev,
 
 static void vxcan_dellink(struct net_device *dev, struct list_head *head)
 {
+	netdevice_tracker *peer_tracker;
 	struct vxcan_priv *priv;
 	struct net_device *peer;
 
 	priv = netdev_priv(dev);
-	peer = rtnl_dereference(priv->peer);
+	peer_tracker = &priv->peer_tracker;
+	peer = unrcu_pointer(xchg(&priv->peer, NULL));
+	if (!peer)
+		return;
 
-	/* Note : dellink() is called from default_device_exit_batch(),
-	 * before a rcu_synchronize() point. The devices are guaranteed
-	 * not being freed before one RCU grace period.
-	 */
-	RCU_INIT_POINTER(priv->peer, NULL);
 	unregister_netdevice_queue(dev, head);
 
-	if (peer) {
-		priv = netdev_priv(peer);
-		RCU_INIT_POINTER(priv->peer, NULL);
-		unregister_netdevice_queue(peer, head);
-	}
+	priv = netdev_priv(peer);
+	dev = unrcu_pointer(xchg(&priv->peer, NULL));
+	if (dev)
+		unregister_netdevice_queue_net(dev_net(dev), peer, head);
+
+	netdev_put(peer, peer_tracker);
+	netdev_put(dev, &priv->peer_tracker);
 }
 
 static const struct nla_policy vxcan_policy[VXCAN_INFO_MAX + 1] = {
-- 
2.55.0.795.g602f6c329a-goog


