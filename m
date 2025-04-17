Return-Path: <linux-can+bounces-3439-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1208AA91FFE
	for <lists+linux-can@lfdr.de>; Thu, 17 Apr 2025 16:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 653C03AAD5F
	for <lists+linux-can@lfdr.de>; Thu, 17 Apr 2025 14:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF90C1AA7BA;
	Thu, 17 Apr 2025 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iaUafgX7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7mn1DhVp"
X-Original-To: linux-can@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892EB2512E2
	for <linux-can@vger.kernel.org>; Thu, 17 Apr 2025 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900888; cv=none; b=ROEHtrPqIrdcHwME/+ocWOw3AvDKje0QfibnH74FKtiCv+p0IEXbyddbum9WSH063U4ZCWXu8ojFKyduA0Ttaxk51hHCf2e2URtLzY9iqf7zFPfKPoYwNFKbnl1EHBKzNsaXTgrMdPOXvZUQaTOlKFsIpT5xMTS+/RUAOhVu62s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900888; c=relaxed/simple;
	bh=MPrUqPag29G5YQr81OaMHNC2xB9imFiMzsNiJCAYsx8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pKIlWWs2zoRCzwy2jlmv+bP8jvhF8CVj+sJVcSmnnV8gysdNRftlPYW0BqhEfouFNbb70A3Hnn10eDQITbACB+1Lywu74v47hXFvKxYx64crICUWSwn9hmIkPKfquTBZWeVxR7r/PkOst8k6p30aDIWNaMapbQY8a/YdquZDJfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iaUafgX7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7mn1DhVp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 16:41:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744900884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=6kXse2KhaZUBUEc63h956+VZ7p5QdXp2Htaycq8Dy0o=;
	b=iaUafgX7UFI3ObU4/vBED/Lo3INEtSVoQTpqPXPTPgt0JcV1xBW3MQcgIgkB4PEoBOZphd
	28WZfuTLLsVF/2DYvoA+eT7dL5+wVKGwMm0EEJyGVC72c7nnEb2+eYzeyVRKPI5gGfa1XQ
	FsTFvSg7pBo+tCzKqsS65moY7sjGwcGtbPNX3R/Wk5kp9a9F7xMuyY6EiBJdQQG3L+fghg
	HRoNu4ONYCR3PasGOqdy3k0xznsRoYohU8oGfgwtzR020soIwnGri/ia85midLOneAuXoL
	GBgV/fQcvPiArp0xrNnj4c3vYoYkupxy3y9OL05jwzIpA1PaPPduyLdT6IHcOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744900884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=6kXse2KhaZUBUEc63h956+VZ7p5QdXp2Htaycq8Dy0o=;
	b=7mn1DhVpi5SXO8DVNesvKHpjhHL5PeFg9vr/r96YsCo+WCIde9xnzmFRMos5vqQhKY+7Vt
	5LkRk/8nP3XolgAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, tglx@linutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: gw: fix RCU/BH usage in cgw_create_job()
Message-ID: <20250417144122.LVyWdXXO@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

From: Oliver Hartkopp <socketcan@hartkopp.net>

As reported by Sebastian Andrzej Siewior the use of local_bh_disable()
is only feasible in uni processor systems to update the modification rules.
The usual use-case to update the modification rules is to update the data
of the modifications but not the modification types (AND/OR/XOR/SET) or
the checksum functions itself.

To omit additional memory allocations to maintain fast modification
switching times, the modification description space is doubled at gw-job
creation time so that only the reference to the active modification
desciption is changed under rcu protection.

Rename cgw_job::mod to cf_mod and make it a RCU pointer. Allocate in
cgw_create_job() and free it together with cgw_job in
cgw_job_free_rcu(). Update all users to dereference cgw_job::cf_mod with
a RCU accessor and if possible once.

[bigeasy: Replace mod1/mod2 from the Oliver's original patch with dynamic
allocation, use RCU annotation and accessor]

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Closes: https://lore.kernel.org/linux-can/20231031112349.y0aLoBrz@linutronix.de/
Fixes: dd895d7f21b2 ("can: cangw: introduce optional uid to reference created routing jobs")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/can/gw.c | 152 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 92 insertions(+), 60 deletions(-)

diff --git a/net/can/gw.c b/net/can/gw.c
index ef93293c1fae3..e11c38c55f5c5 100644
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
@@ -1149,12 +1175,15 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	ASSERT_RTNL();
 
 	err = cgw_register_filter(net, gwj);
-	if (!err)
+	if (!err) {
 		hlist_add_head_rcu(&gwj->list, &net->can.cgw_list);
+		mod = NULL;
+	}
 out:
 	if (err)
 		kmem_cache_free(cgw_cache, gwj);
-
+out_free_cf:
+	kfree(mod);
 	return err;
 }
 
@@ -1214,19 +1243,22 @@ static int cgw_remove_job(struct sk_buff *skb, struct nlmsghdr *nlh,
 
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
2.49.0


