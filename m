Return-Path: <linux-can+bounces-3549-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE20BAAC743
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 16:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3685F7B3598
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 13:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D763A28137D;
	Tue,  6 May 2025 13:59:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C180281520
	for <linux-can@vger.kernel.org>; Tue,  6 May 2025 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539989; cv=none; b=JDW6xdy5Ad2poVBoniRtSrh3tJ1sNOFMDGDTe3k5kL4tL/qagHW3eIc6bN+mlv9LWGrHd1wG4qt3s+SsTWZ4UXZkJvP8hMwONo8S1JqdufLtHWi5cc/fPImkvzp6eeHaJ7oNc0Rx7hiBA6tBqGtjdW86Y5L2hSzVMoSi4nQLpZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539989; c=relaxed/simple;
	bh=Z+C7SBA2YY5IiaznpkJg3RedVKZeVa2a8yyaADaLpnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwCzz2aJucwoMfB/0+hoDuIfScekq3Eqplpac6Txn0XgF+QKqL6+YHdnSlAImMIHZ8BYdnWnw+ppydJVrRTVqtA15KHfUjewoYs7bY2J7JpU++H1EIDkHScmxbZAJVWAHUkp7CFnimNC/WSQXc3bDtTlyIZlhp2Sfqu3VfZSbzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uCIpl-0007tj-S2
	for linux-can@vger.kernel.org; Tue, 06 May 2025 15:59:45 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uCIpl-001P9y-0l
	for linux-can@vger.kernel.org;
	Tue, 06 May 2025 15:59:45 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id E09F0408F6C
	for <linux-can@vger.kernel.org>; Tue, 06 May 2025 13:59:44 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 4211F408F3C;
	Tue, 06 May 2025 13:59:42 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b4cb5cdc;
	Tue, 6 May 2025 13:59:41 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 6/6] can: gw: fix RCU/BH usage in cgw_create_job()
Date: Tue,  6 May 2025 15:56:22 +0200
Message-ID: <20250506135939.652543-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250506135939.652543-1-mkl@pengutronix.de>
References: <20250506135939.652543-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>

As reported by Sebastian Andrzej Siewior the use of local_bh_disable()
is only feasible in uni processor systems to update the modification rules.
The usual use-case to update the modification rules is to update the data
of the modifications but not the modification types (AND/OR/XOR/SET) or
the checksum functions itself.

To omit additional memory allocations to maintain fast modification
switching times, the modification description space is doubled at gw-job
creation time so that only the reference to the active modification
description is changed under rcu protection.

Rename cgw_job::mod to cf_mod and make it a RCU pointer. Allocate in
cgw_create_job() and free it together with cgw_job in
cgw_job_free_rcu(). Update all users to dereference cgw_job::cf_mod with
a RCU accessor and if possible once.

[bigeasy: Replace mod1/mod2 from the Oliver's original patch with dynamic
allocation, use RCU annotation and accessor]

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Closes: https://lore.kernel.org/linux-can/20231031112349.y0aLoBrz@linutronix.de/
Fixes: dd895d7f21b2 ("can: cangw: introduce optional uid to reference created routing jobs")
Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://patch.msgid.link/20250429070555.cs-7b_eZ@linutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/gw.c | 151 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 91 insertions(+), 60 deletions(-)

diff --git a/net/can/gw.c b/net/can/gw.c
index ef93293c1fae..55eccb1c7620 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -130,7 +130,7 @@ struct cgw_job {
 	u32 handled_frames;
 	u32 dropped_frames;
 	u32 deleted_frames;
-	struct cf_mod mod;
+	struct cf_mod __rcu *cf_mod;
 	union {
 		/* CAN frame data source */
 		struct net_device *dev;
@@ -459,6 +459,7 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	struct cgw_job *gwj = (struct cgw_job *)data;
 	struct canfd_frame *cf;
 	struct sk_buff *nskb;
+	struct cf_mod *mod;
 	int modidx = 0;
 
 	/* process strictly Classic CAN or CAN FD frames */
@@ -506,7 +507,8 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	 * When there is at least one modification function activated,
 	 * we need to copy the skb as we want to modify skb->data.
 	 */
-	if (gwj->mod.modfunc[0])
+	mod = rcu_dereference(gwj->cf_mod);
+	if (mod->modfunc[0])
 		nskb = skb_copy(skb, GFP_ATOMIC);
 	else
 		nskb = skb_clone(skb, GFP_ATOMIC);
@@ -529,8 +531,8 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	cf = (struct canfd_frame *)nskb->data;
 
 	/* perform preprocessed modification functions if there are any */
-	while (modidx < MAX_MODFUNCTIONS && gwj->mod.modfunc[modidx])
-		(*gwj->mod.modfunc[modidx++])(cf, &gwj->mod);
+	while (modidx < MAX_MODFUNCTIONS && mod->modfunc[modidx])
+		(*mod->modfunc[modidx++])(cf, mod);
 
 	/* Has the CAN frame been modified? */
 	if (modidx) {
@@ -546,11 +548,11 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 		}
 
 		/* check for checksum updates */
-		if (gwj->mod.csumfunc.crc8)
-			(*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8);
+		if (mod->csumfunc.crc8)
+			(*mod->csumfunc.crc8)(cf, &mod->csum.crc8);
 
-		if (gwj->mod.csumfunc.xor)
-			(*gwj->mod.csumfunc.xor)(cf, &gwj->mod.csum.xor);
+		if (mod->csumfunc.xor)
+			(*mod->csumfunc.xor)(cf, &mod->csum.xor);
 	}
 
 	/* clear the skb timestamp if not configured the other way */
@@ -581,9 +583,20 @@ static void cgw_job_free_rcu(struct rcu_head *rcu_head)
 {
 	struct cgw_job *gwj = container_of(rcu_head, struct cgw_job, rcu);
 
+	/* cgw_job::cf_mod is always accessed from the same cgw_job object within
+	 * the same RCU read section. Once cgw_job is scheduled for removal,
+	 * cf_mod can also be removed without mandating an additional grace period.
+	 */
+	kfree(rcu_access_pointer(gwj->cf_mod));
 	kmem_cache_free(cgw_cache, gwj);
 }
 
+/* Return cgw_job::cf_mod with RTNL protected section */
+static struct cf_mod *cgw_job_cf_mod(struct cgw_job *gwj)
+{
+	return rcu_dereference_protected(gwj->cf_mod, rtnl_is_locked());
+}
+
 static int cgw_notifier(struct notifier_block *nb,
 			unsigned long msg, void *ptr)
 {
@@ -616,6 +629,7 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj, int type,
 {
 	struct rtcanmsg *rtcan;
 	struct nlmsghdr *nlh;
+	struct cf_mod *mod;
 
 	nlh = nlmsg_put(skb, pid, seq, type, sizeof(*rtcan), flags);
 	if (!nlh)
@@ -650,82 +664,83 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj, int type,
 			goto cancel;
 	}
 
+	mod = cgw_job_cf_mod(gwj);
 	if (gwj->flags & CGW_FLAGS_CAN_FD) {
 		struct cgw_fdframe_mod mb;
 
-		if (gwj->mod.modtype.and) {
-			memcpy(&mb.cf, &gwj->mod.modframe.and, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.and;
+		if (mod->modtype.and) {
+			memcpy(&mb.cf, &mod->modframe.and, sizeof(mb.cf));
+			mb.modtype = mod->modtype.and;
 			if (nla_put(skb, CGW_FDMOD_AND, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.or) {
-			memcpy(&mb.cf, &gwj->mod.modframe.or, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.or;
+		if (mod->modtype.or) {
+			memcpy(&mb.cf, &mod->modframe.or, sizeof(mb.cf));
+			mb.modtype = mod->modtype.or;
 			if (nla_put(skb, CGW_FDMOD_OR, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.xor) {
-			memcpy(&mb.cf, &gwj->mod.modframe.xor, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.xor;
+		if (mod->modtype.xor) {
+			memcpy(&mb.cf, &mod->modframe.xor, sizeof(mb.cf));
+			mb.modtype = mod->modtype.xor;
 			if (nla_put(skb, CGW_FDMOD_XOR, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.set) {
-			memcpy(&mb.cf, &gwj->mod.modframe.set, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.set;
+		if (mod->modtype.set) {
+			memcpy(&mb.cf, &mod->modframe.set, sizeof(mb.cf));
+			mb.modtype = mod->modtype.set;
 			if (nla_put(skb, CGW_FDMOD_SET, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 	} else {
 		struct cgw_frame_mod mb;
 
-		if (gwj->mod.modtype.and) {
-			memcpy(&mb.cf, &gwj->mod.modframe.and, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.and;
+		if (mod->modtype.and) {
+			memcpy(&mb.cf, &mod->modframe.and, sizeof(mb.cf));
+			mb.modtype = mod->modtype.and;
 			if (nla_put(skb, CGW_MOD_AND, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.or) {
-			memcpy(&mb.cf, &gwj->mod.modframe.or, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.or;
+		if (mod->modtype.or) {
+			memcpy(&mb.cf, &mod->modframe.or, sizeof(mb.cf));
+			mb.modtype = mod->modtype.or;
 			if (nla_put(skb, CGW_MOD_OR, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.xor) {
-			memcpy(&mb.cf, &gwj->mod.modframe.xor, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.xor;
+		if (mod->modtype.xor) {
+			memcpy(&mb.cf, &mod->modframe.xor, sizeof(mb.cf));
+			mb.modtype = mod->modtype.xor;
 			if (nla_put(skb, CGW_MOD_XOR, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.set) {
-			memcpy(&mb.cf, &gwj->mod.modframe.set, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.set;
+		if (mod->modtype.set) {
+			memcpy(&mb.cf, &mod->modframe.set, sizeof(mb.cf));
+			mb.modtype = mod->modtype.set;
 			if (nla_put(skb, CGW_MOD_SET, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 	}
 
-	if (gwj->mod.uid) {
-		if (nla_put_u32(skb, CGW_MOD_UID, gwj->mod.uid) < 0)
+	if (mod->uid) {
+		if (nla_put_u32(skb, CGW_MOD_UID, mod->uid) < 0)
 			goto cancel;
 	}
 
-	if (gwj->mod.csumfunc.crc8) {
+	if (mod->csumfunc.crc8) {
 		if (nla_put(skb, CGW_CS_CRC8, CGW_CS_CRC8_LEN,
-			    &gwj->mod.csum.crc8) < 0)
+			    &mod->csum.crc8) < 0)
 			goto cancel;
 	}
 
-	if (gwj->mod.csumfunc.xor) {
+	if (mod->csumfunc.xor) {
 		if (nla_put(skb, CGW_CS_XOR, CGW_CS_XOR_LEN,
-			    &gwj->mod.csum.xor) < 0)
+			    &mod->csum.xor) < 0)
 			goto cancel;
 	}
 
@@ -1059,7 +1074,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	struct net *net = sock_net(skb->sk);
 	struct rtcanmsg *r;
 	struct cgw_job *gwj;
-	struct cf_mod mod;
+	struct cf_mod *mod;
 	struct can_can_gw ccgw;
 	u8 limhops = 0;
 	int err = 0;
@@ -1078,37 +1093,48 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	if (r->gwtype != CGW_TYPE_CAN_CAN)
 		return -EINVAL;
 
-	err = cgw_parse_attr(nlh, &mod, CGW_TYPE_CAN_CAN, &ccgw, &limhops);
-	if (err < 0)
-		return err;
+	mod = kmalloc(sizeof(*mod), GFP_KERNEL);
+	if (!mod)
+		return -ENOMEM;
 
-	if (mod.uid) {
+	err = cgw_parse_attr(nlh, mod, CGW_TYPE_CAN_CAN, &ccgw, &limhops);
+	if (err < 0)
+		goto out_free_cf;
+
+	if (mod->uid) {
 		ASSERT_RTNL();
 
 		/* check for updating an existing job with identical uid */
 		hlist_for_each_entry(gwj, &net->can.cgw_list, list) {
-			if (gwj->mod.uid != mod.uid)
+			struct cf_mod *old_cf;
+
+			old_cf = cgw_job_cf_mod(gwj);
+			if (old_cf->uid != mod->uid)
 				continue;
 
 			/* interfaces & filters must be identical */
-			if (memcmp(&gwj->ccgw, &ccgw, sizeof(ccgw)))
-				return -EINVAL;
+			if (memcmp(&gwj->ccgw, &ccgw, sizeof(ccgw))) {
+				err = -EINVAL;
+				goto out_free_cf;
+			}
 
-			/* update modifications with disabled softirq & quit */
-			local_bh_disable();
-			memcpy(&gwj->mod, &mod, sizeof(mod));
-			local_bh_enable();
+			rcu_assign_pointer(gwj->cf_mod, mod);
+			kfree_rcu_mightsleep(old_cf);
 			return 0;
 		}
 	}
 
 	/* ifindex == 0 is not allowed for job creation */
-	if (!ccgw.src_idx || !ccgw.dst_idx)
-		return -ENODEV;
+	if (!ccgw.src_idx || !ccgw.dst_idx) {
+		err = -ENODEV;
+		goto out_free_cf;
+	}
 
 	gwj = kmem_cache_alloc(cgw_cache, GFP_KERNEL);
-	if (!gwj)
-		return -ENOMEM;
+	if (!gwj) {
+		err = -ENOMEM;
+		goto out_free_cf;
+	}
 
 	gwj->handled_frames = 0;
 	gwj->dropped_frames = 0;
@@ -1118,7 +1144,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	gwj->limit_hops = limhops;
 
 	/* insert already parsed information */
-	memcpy(&gwj->mod, &mod, sizeof(mod));
+	RCU_INIT_POINTER(gwj->cf_mod, mod);
 	memcpy(&gwj->ccgw, &ccgw, sizeof(ccgw));
 
 	err = -ENODEV;
@@ -1152,9 +1178,11 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	if (!err)
 		hlist_add_head_rcu(&gwj->list, &net->can.cgw_list);
 out:
-	if (err)
+	if (err) {
 		kmem_cache_free(cgw_cache, gwj);
-
+out_free_cf:
+		kfree(mod);
+	}
 	return err;
 }
 
@@ -1214,19 +1242,22 @@ static int cgw_remove_job(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	/* remove only the first matching entry */
 	hlist_for_each_entry_safe(gwj, nx, &net->can.cgw_list, list) {
+		struct cf_mod *cf_mod;
+
 		if (gwj->flags != r->flags)
 			continue;
 
 		if (gwj->limit_hops != limhops)
 			continue;
 
+		cf_mod = cgw_job_cf_mod(gwj);
 		/* we have a match when uid is enabled and identical */
-		if (gwj->mod.uid || mod.uid) {
-			if (gwj->mod.uid != mod.uid)
+		if (cf_mod->uid || mod.uid) {
+			if (cf_mod->uid != mod.uid)
 				continue;
 		} else {
 			/* no uid => check for identical modifications */
-			if (memcmp(&gwj->mod, &mod, sizeof(mod)))
+			if (memcmp(cf_mod, &mod, sizeof(mod)))
 				continue;
 		}
 
-- 
2.47.2



