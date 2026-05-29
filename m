Return-Path: <linux-can+bounces-7727-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id m+NtNYfsGGqEowgAu9opvQ
	(envelope-from <linux-can+bounces-7727-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 29 May 2026 03:31:51 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2455FC07B
	for <lists+linux-can@lfdr.de>; Fri, 29 May 2026 03:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF303303AF9F
	for <lists+linux-can@lfdr.de>; Fri, 29 May 2026 01:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D1A2853E9;
	Fri, 29 May 2026 01:31:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BC0C2EA
	for <linux-can@vger.kernel.org>; Fri, 29 May 2026 01:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780018307; cv=none; b=OjsOaNABfO2cqeJQ2EiyKNGb5/CYngf+2sEgjPztIqv4N0R79RZobUElAHxtuXQ8nIcQTkCBw+Kt+8CJKIYnNAZWyDoShuv4sKxtYmTMxsOYaMeKda4gwYDEtkJV95j3OpavHdaDqQBXNgQ6qMN8v2p0KaOqo51GzRgegnW5DyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780018307; c=relaxed/simple;
	bh=ymnobiSke6JxELSo2hwSBeFw+5sU6oLWcX9BEbHjmgs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=udYh//7It7C9+mmMXBNKT2nMUrvN62sn2/PGMGRwuj41FsAU+0YJOEjc6sLxJw8CymLYeMigsa9DFo/C/A+qT0fO7hYlMVfqFKx0kG+j2BuUZIkZU8MJvG4zHF3lfv4alJHswsb7P111//YfO3K4HeWnekfmd+mHHVsV8QxocGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64T1VPqs031167;
	Fri, 29 May 2026 10:31:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64T1VOxi031164
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 29 May 2026 10:31:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2bc332e0-b250-4679-a075-1c413ad843ce@I-love.SAKURA.ne.jp>
Date: Fri, 29 May 2026 10:31:22 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-can@vger.kernel.org, Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v2 (repost)] can: j1939: use netdevice_tracker for
 j1939_{priv,session,ecu} tracking
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav302.rs.sakura.ne.jp
X-Virus-Status: clean
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7727-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,I-love.SAKURA.ne.jp:mid,i-love.sakura.ne.jp:email]
X-Rspamd-Queue-Id: 8A2455FC07B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot is still reporting

  unregister_netdevice: waiting for vcan0 to become free. Usage count = 2

problem. A debug printk() patch in linux-next-20260508 identified that
there is dev_hold()/dev_put() imbalance in j1939_priv management.

  Call trace for vcan0[26] +4 at
     __dev_hold include/linux/netdevice.h:4470 [inline]
     netdev_hold include/linux/netdevice.h:4513 [inline]
     dev_hold include/linux/netdevice.h:4536 [inline]
     j1939_priv_create net/can/j1939/main.c:140 [inline]
     j1939_netdev_start+0x36b/0xc10 net/can/j1939/main.c:268
     j1939_sk_bind+0x853/0xb30 net/can/j1939/socket.c:506
     __sys_bind_socket net/socket.c:1948 [inline]
     __sys_bind+0x2e9/0x410 net/socket.c:1979

  Call trace for vcan0[28] -3 at
     __dev_put include/linux/netdevice.h:4456 [inline]
     netdev_put include/linux/netdevice.h:4523 [inline]
     dev_put include/linux/netdevice.h:4548 [inline]
     __j1939_priv_release net/can/j1939/main.c:166 [inline]
     kref_put include/linux/kref.h:65 [inline]
     j1939_priv_put+0x128/0x270 net/can/j1939/main.c:172
     j1939_sk_sock_destruct+0x52/0x90 net/can/j1939/socket.c:388
     __sk_destruct+0x8d/0x9d0 net/core/sock.c:2352
     rcu_do_batch kernel/rcu/tree.c:2617 [inline]
     rcu_core kernel/rcu/tree.c:2869 [inline]
     rcu_cpu_kthread+0x99e/0x1470 kernel/rcu/tree.c:2957
     smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
     kthread+0x388/0x470 kernel/kthread.c:436
     ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
     ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

This refcount leak in j1939_priv might be caused by a refcount leak in
j1939_{session,ecu} because j1939_{session,ecu} holds a ref on j1939_priv.
For further investigation using upstream kernels, enable netdevice_tracker
in j1939_{priv,session,ecu} management.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
I'm waiting for your response. If you don't like this approach, please let me know.

 net/can/j1939/bus.c        | 2 ++
 net/can/j1939/j1939-priv.h | 3 +++
 net/can/j1939/main.c       | 8 ++++----
 net/can/j1939/transport.c  | 2 ++
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index dc374286eeb6..cdc3c0a71937 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -20,6 +20,7 @@ static void __j1939_ecu_release(struct kref *kref)
 	struct j1939_priv *priv = ecu->priv;
 
 	list_del(&ecu->list);
+	netdev_put(priv->ndev, &ecu->priv_dev_tracker);
 	kfree(ecu);
 	j1939_priv_put(priv);
 }
@@ -155,6 +156,7 @@ struct j1939_ecu *j1939_ecu_create_locked(struct j1939_priv *priv, name_t name)
 	if (!ecu)
 		return ERR_PTR(-ENOMEM);
 	kref_init(&ecu->kref);
+	netdev_hold(priv->ndev, &ecu->priv_dev_tracker, gfp_any());
 	ecu->addr = J1939_IDLE_ADDR;
 	ecu->name = name;
 
diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 81f58924b4ac..cf26352d1d8c 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -38,6 +38,7 @@ struct j1939_ecu {
 	struct hrtimer ac_timer;
 	struct kref kref;
 	struct j1939_priv *priv;
+	netdevice_tracker priv_dev_tracker;
 
 	/* count users, to help transport protocol decide for interaction */
 	int nusers;
@@ -60,6 +61,7 @@ struct j1939_priv {
 	rwlock_t lock;
 
 	struct net_device *ndev;
+	netdevice_tracker dev_tracker;
 
 	/* list of 256 ecu ptrs, that cache the claimed addresses.
 	 * also protected by the above lock
@@ -230,6 +232,7 @@ enum j1939_session_state {
 
 struct j1939_session {
 	struct j1939_priv *priv;
+	netdevice_tracker priv_dev_tracker;
 	struct list_head active_session_list_entry;
 	struct list_head sk_session_queue_entry;
 	struct kref kref;
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 9937c04241bc..5e5e6c228f22 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -137,7 +137,7 @@ static struct j1939_priv *j1939_priv_create(struct net_device *ndev)
 	priv->ndev = ndev;
 	kref_init(&priv->kref);
 	kref_init(&priv->rx_kref);
-	dev_hold(ndev);
+	netdev_hold(ndev, &priv->dev_tracker, GFP_KERNEL);
 
 	netdev_dbg(priv->ndev, "%s : 0x%p\n", __func__, priv);
 
@@ -163,7 +163,7 @@ static void __j1939_priv_release(struct kref *kref)
 	WARN_ON_ONCE(!list_empty(&priv->ecus));
 	WARN_ON_ONCE(!list_empty(&priv->j1939_socks));
 
-	dev_put(ndev);
+	netdev_put(ndev, &priv->dev_tracker);
 	kfree(priv);
 }
 
@@ -281,7 +281,7 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
 		 */
 		kref_get(&priv_new->rx_kref);
 		mutex_unlock(&j1939_netdev_lock);
-		dev_put(ndev);
+		netdev_put(ndev, &priv->dev_tracker);
 		kfree(priv);
 		return priv_new;
 	}
@@ -298,7 +298,7 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
 	j1939_priv_set(ndev, NULL);
 	mutex_unlock(&j1939_netdev_lock);
 
-	dev_put(ndev);
+	netdev_put(ndev, &priv->dev_tracker);
 	kfree(priv);
 
 	return ERR_PTR(ret);
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index df93d57907da..158433511552 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -283,6 +283,7 @@ static void j1939_session_destroy(struct j1939_session *session)
 		kfree_skb(skb);
 	}
 	__j1939_session_drop(session);
+	netdev_put(session->priv->ndev, &session->priv_dev_tracker);
 	j1939_priv_put(session->priv);
 	kfree(session);
 }
@@ -1515,6 +1516,7 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	INIT_LIST_HEAD(&session->active_session_list_entry);
 	INIT_LIST_HEAD(&session->sk_session_queue_entry);
 	kref_init(&session->kref);
+	netdev_hold(priv->ndev, &session->priv_dev_tracker, gfp_any());
 
 	j1939_priv_get(priv);
 	session->priv = priv;
-- 
2.54.0


