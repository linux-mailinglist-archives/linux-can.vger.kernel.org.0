Return-Path: <linux-can+bounces-7641-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DBrIeuxCWo4lgQAu9opvQ
	(envelope-from <linux-can+bounces-7641-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 14:17:47 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 913EB560EA3
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 14:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6E4A3006B46
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 12:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432862F1FEF;
	Sun, 17 May 2026 12:17:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C204C305691;
	Sun, 17 May 2026 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779020264; cv=none; b=gdEU25VmyGP1PCV/poJrjWonxCgFCjHXyZPSlB0aOvHWlnh/cV/sKT1+XtuVSsfLzcMJmdN6Gf/Y1g6AL7XXQCVbs4WRYvABgxcGzf8252XL8J3qsOdudKIdf58RYda7jI8/JQwjO97B2il+0PO0Ti83EHbmp8ICAMS+cF81CFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779020264; c=relaxed/simple;
	bh=afeVXxMLu9PA/RifFsGXDf3B7y8laAam881xtqAvz40=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=gnkieHgNg9hqlazRv6JtOyg/IgBk+fbGn9OCzLYile0b2pcZIjoQAm7LJRvI/I+0gxFU1HyhLFABLkWqUgjszmJWjBgK4VQFloSVlxA3Fls69sbfn9kFv3HkcXIw9168a3+QsSSKZMesL37gksUJuEIt9/YbrWQlKWwPsaKJ2VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64HCHJi3038911;
	Sun, 17 May 2026 21:17:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64HCHJGc038908
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 17 May 2026 21:17:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c109e9fc-3fb7-4a48-a0bd-a4d7663e7342@I-love.SAKURA.ne.jp>
Date: Sun, 17 May 2026 21:17:19 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH net] can: j1939: use netdevice_tracker for j1939_priv tracking
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav303.rs.sakura.ne.jp
X-Virus-Status: clean
X-Rspamd-Queue-Id: 913EB560EA3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-7641-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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

For further investigation using upstream kernels, enable netdevice_tracker
in j1939_priv management.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/can/j1939/j1939-priv.h | 1 +
 net/can/j1939/main.c       | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 81f58924b4ac..e92beb24b50b 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -60,6 +60,7 @@ struct j1939_priv {
 	rwlock_t lock;
 
 	struct net_device *ndev;
+	netdevice_tracker dev_tracker;
 
 	/* list of 256 ecu ptrs, that cache the claimed addresses.
 	 * also protected by the above lock
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
-- 
2.54.0


