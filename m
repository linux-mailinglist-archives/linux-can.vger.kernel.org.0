Return-Path: <linux-can+bounces-1647-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B2D99BB88
	for <lists+linux-can@lfdr.de>; Sun, 13 Oct 2024 22:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E1E1C20BFD
	for <lists+linux-can@lfdr.de>; Sun, 13 Oct 2024 20:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B991E19E98C;
	Sun, 13 Oct 2024 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="uHGASfeZ"
X-Original-To: linux-can@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E71132124;
	Sun, 13 Oct 2024 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728850700; cv=none; b=MwLkNf8GsLDfO+QJJiqXT40EXgXSeffpAOmIuVMi5O4N+/oyOY9ha2XEkHu+ZCyPpMKhX1UD3+W24PD5qABcGkPnIofUoJy0Fwt41VJMQGBUWZ/cKCdVCj5hNmt+eJ8MmcbWF/qLpFeTj4uXUKxQDdLxUmhLiwy722KIwJnnkqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728850700; c=relaxed/simple;
	bh=6Gc8ctMbDc/p5/38zfSjiqk5ST9V7KlRwFCerRiqzLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iH5fCeuWnUxrtfvy66PdNl4ANBBXXBmKTwVKy2hi4F5N8Ov3zcIpo5hRVUX5z36x8yhlXIc7VsYNqG8csWgUZEZN/QhTCWczlFHX78kKD3e7zcrJ1P3RCCjeIXPYoMcUru391dZOjcrEg2VME09WlPu+dYIAZNVJXN1pXRzeZyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=uHGASfeZ; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=StPFXhJ0rOsMzmD4k1fWnIDRZfYck8gqHz/myPcD8Jc=;
  b=uHGASfeZ0FXjv3CPuUM3Y3zwPuYWvfTAnBEgEdnVZi2sfZD5J0X695OY
   7aRePpQ9ngGGiLes9lls7FQcAcBODmSDOgfgc82WDli0oJFDMpILIIJBu
   tOzCccUxLlhRY/UEnYd1iiSBBfyH3qjFEfwa7HFuceHnvHvp6rLmNxESB
   w=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,201,1725314400"; 
   d="scan'208";a="98968285"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 22:18:00 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: kernel-janitors@vger.kernel.org,
	vbabka@suse.cz,
	paulmck@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/17] can: gw: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
Date: Sun, 13 Oct 2024 22:16:57 +0200
Message-Id: <20241013201704.49576-11-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241013201704.49576-1-Julia.Lawall@inria.fr>
References: <20241013201704.49576-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since SLOB was removed and since
commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
it is not necessary to use call_rcu when the callback only performs
kmem_cache_free. Use kfree_rcu() directly.

The changes were made using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 net/can/gw.c |   13 +++----------
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


