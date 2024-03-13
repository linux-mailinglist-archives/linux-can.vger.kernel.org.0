Return-Path: <linux-can+bounces-372-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EAB87A545
	for <lists+linux-can@lfdr.de>; Wed, 13 Mar 2024 10:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554E71F21D01
	for <lists+linux-can@lfdr.de>; Wed, 13 Mar 2024 09:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B902E636;
	Wed, 13 Mar 2024 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="LFI5StyS"
X-Original-To: linux-can@vger.kernel.org
Received: from forward206b.mail.yandex.net (forward206b.mail.yandex.net [178.154.239.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4281CF9C;
	Wed, 13 Mar 2024 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710323472; cv=none; b=HzFepLoJCQYuzVJovL4myc0DZXZ4/IEcPf2khykahocRT70arsnWOEzSAdnFjytJqbAam03/maLb0aVBH4UfUaNLFWGTIEa6C90H9hZ9oaP8JUx9LlChADxTrdfDde+U5qzrNMSQGJLvLtQAHc15YU/iLwYvOJs/0nT8uxV3YsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710323472; c=relaxed/simple;
	bh=TAVuMOk8xlvmomXd4PqVinKGpsfWHwJ8/HlXJLO77fA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EMnAAxRm1RHDUVv89mwTDppHORHWEAGsHkyAcPLBAxXZPq6CG8zJCu1xi9XShjSUHAkILWJnQZzVqSlZ57WIxPsbeySpVm5QW2Yw7qUtG8hnfjAOs67uQReuij0n3cwUr7/8EyEolIWaqNFA9kKw5T3Q4gkJdL/shO6gLFzgVRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=LFI5StyS; arc=none smtp.client-ip=178.154.239.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
	by forward206b.mail.yandex.net (Yandex) with ESMTPS id 2271D660E9;
	Wed, 13 Mar 2024 12:43:36 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:291a:0:640:791e:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 3B15560020;
	Wed, 13 Mar 2024 12:43:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Qhj3uETpASw0-MDVzFfwE;
	Wed, 13 Mar 2024 12:43:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1710323007; bh=xZLUKE7ja4TGTRIsC8isThMkYqx3sVWQgnkvSVCUdjk=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=LFI5StyS1ahARKOT1iSghUwe55XnTtuHDmTJsFLZHwzeHBLPz7o1lf6XxUfvmsAJl
	 G83SfN+o81cm3DwBDOZzVDzNRWEEvuLsN/aRgiAZKANi148NIZDHFNEnYwW3zLhjgH
	 GPPfGe+riuKcK/9T5NvGSgo0OXR0b3d6mwz3aU1E=
Authentication-Results: mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] can: gw: prefer kfree_rcu() over call_rcu() with cgw_job_free_rcu()
Date: Wed, 13 Mar 2024 12:42:07 +0300
Message-ID: <20240313094207.70334-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop trivial free-only 'cgw_job_free_rcu()' RCU callback and
switch to 'kfree_rcu()' in 'cgw_notifier()', 'cgw_remove_job()'
and 'cgw_remove_all_jobs()'. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/can/gw.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/net/can/gw.c b/net/can/gw.c
index 37528826935e..ffb9870e2d01 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -577,13 +577,6 @@ static inline void cgw_unregister_filter(struct net *net, struct cgw_job *gwj)
 			  gwj->ccgw.filter.can_mask, can_can_gw_rcv, gwj);
 }
 
-static void cgw_job_free_rcu(struct rcu_head *rcu_head)
-{
-	struct cgw_job *gwj = container_of(rcu_head, struct cgw_job, rcu);
-
-	kmem_cache_free(cgw_cache, gwj);
-}
-
 static int cgw_notifier(struct notifier_block *nb,
 			unsigned long msg, void *ptr)
 {
@@ -603,7 +596,7 @@ static int cgw_notifier(struct notifier_block *nb,
 			if (gwj->src.dev == dev || gwj->dst.dev == dev) {
 				hlist_del(&gwj->list);
 				cgw_unregister_filter(net, gwj);
-				call_rcu(&gwj->rcu, cgw_job_free_rcu);
+				kfree_rcu(gwj, rcu);
 			}
 		}
 	}
@@ -1168,7 +1161,7 @@ static void cgw_remove_all_jobs(struct net *net)
 	hlist_for_each_entry_safe(gwj, nx, &net->can.cgw_list, list) {
 		hlist_del(&gwj->list);
 		cgw_unregister_filter(net, gwj);
-		call_rcu(&gwj->rcu, cgw_job_free_rcu);
+		kfree_rcu(gwj, rcu);
 	}
 }
 
@@ -1236,7 +1229,7 @@ static int cgw_remove_job(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 		hlist_del(&gwj->list);
 		cgw_unregister_filter(net, gwj);
-		call_rcu(&gwj->rcu, cgw_job_free_rcu);
+		kfree_rcu(gwj, rcu);
 		err = 0;
 		break;
 	}
-- 
2.44.0


