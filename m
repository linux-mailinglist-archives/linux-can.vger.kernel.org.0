Return-Path: <linux-can+bounces-3503-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCE8AA0407
	for <lists+linux-can@lfdr.de>; Tue, 29 Apr 2025 09:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0101B640AC
	for <lists+linux-can@lfdr.de>; Tue, 29 Apr 2025 07:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C853E1C1F13;
	Tue, 29 Apr 2025 07:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lu7CbzhH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xKkUuG1O"
X-Original-To: linux-can@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9496211460
	for <linux-can@vger.kernel.org>; Tue, 29 Apr 2025 07:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745910360; cv=none; b=RYNiF2q/LZI4MpYHhSlQv18U4n4FtaEwCkLeJJZYfCS3AV4hqFxbAhpPtLa2jTQuewnJ9j0AwPfb9T7NFlq3XzlQ0Is87gZdR4K8imUlCnrJnPBIXxTUOV1JdLDm1mudVHbDFior5/l8loV+XMxU+Tq1L5jH8ue3BngY3+nXTfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745910360; c=relaxed/simple;
	bh=oes87vMxZX/xsvQnOqLGHMsclcmmtZ5+nhzlQRcWUKk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q4y7H7I2nJRJjHOXZEhifOYz5hoG96/2CNDsmXHEF+aZCMiI793NbdmLxEPH+o7H6dYTtXKUgmDV2hAdcg6ObNCvut0tgbzvkFBjbnJ8nbA7kbCYdpe5JNH3CLPbAiJFEuXT2HDTjFYF5xoEgHiWQ45I+0NpDCj1i4M2WNbNjxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lu7CbzhH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xKkUuG1O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 29 Apr 2025 09:05:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745910357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KbGWrlI7kSBwSJwt1os3XsmNuRMBqwhbAuyQ/WbwHME=;
	b=Lu7CbzhHDJY6yveDXETonp58NbXHdJPxVqLrv1soY3zdjL+G7adLbB9zVW0TQCU7uF4K4a
	O4Ap+MlfjMDWIGwrBZgyXvGx08NSkjHzmcbLuqROoFWMAkmFoqCb5ZuVJaYehZQ3I14FRh
	ssBztm0P/wdzs/7lagjirzMZVWDgtL+U/fVn8eNgK8HJfRUexrVDPo98acWqy/zz9SroxS
	4eV2FbiMsmHM3ZXTEVPlkoF+SWJAIZpfnO2HyQTTMN2EJ8cmKPYRtlOJc6W6XHmZJk1gbd
	TP41qyi5X0z5TyXnEGodxrDABKVv7p+f/rg2wuWTtoWIJysh3lpYWUGfvdRwiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745910357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KbGWrlI7kSBwSJwt1os3XsmNuRMBqwhbAuyQ/WbwHME=;
	b=xKkUuG1O+QPH7mVv1lObWrR8Wlr4cbNaLTnXcXS4xoJVFQvzNMqxZbDjbMUq5gz8aPbltG
	QncHFu45mdNQidDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, tglx@linutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2] can: gw: fix RCU/BH usage in cgw_create_job()
Message-ID: <20250429070555.cs-7b_eZ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Oliver Hartkopp <socketcan@hartkopp.net>

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
Closes: https://lore.kernel.org/linux-can/20231031112349.y0aLoBrz@linutroni=
x.de/
Fixes: dd895d7f21b2 ("can: cangw: introduce optional uid to reference creat=
ed routing jobs")
Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2: https://lore.kernel.org/all/20250417144122.LVyWdXXO@linutron=
ix.de/
  - Add brackets around the error free in cgw_create_job() so that the
    NULL assignment to mod can be avoided.
  - Add Oliver's tested-by.

 net/can/gw.c | 151 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 91 insertions(+), 60 deletions(-)

diff --git a/net/can/gw.c b/net/can/gw.c
index ef93293c1fae3..55eccb1c7620c 100644
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
@@ -459,6 +459,7 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *d=
ata)
 	struct cgw_job *gwj =3D (struct cgw_job *)data;
 	struct canfd_frame *cf;
 	struct sk_buff *nskb;
+	struct cf_mod *mod;
 	int modidx =3D 0;
=20
 	/* process strictly Classic CAN or CAN FD frames */
@@ -506,7 +507,8 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *d=
ata)
 	 * When there is at least one modification function activated,
 	 * we need to copy the skb as we want to modify skb->data.
 	 */
-	if (gwj->mod.modfunc[0])
+	mod =3D rcu_dereference(gwj->cf_mod);
+	if (mod->modfunc[0])
 		nskb =3D skb_copy(skb, GFP_ATOMIC);
 	else
 		nskb =3D skb_clone(skb, GFP_ATOMIC);
@@ -529,8 +531,8 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *d=
ata)
 	cf =3D (struct canfd_frame *)nskb->data;
=20
 	/* perform preprocessed modification functions if there are any */
-	while (modidx < MAX_MODFUNCTIONS && gwj->mod.modfunc[modidx])
-		(*gwj->mod.modfunc[modidx++])(cf, &gwj->mod);
+	while (modidx < MAX_MODFUNCTIONS && mod->modfunc[modidx])
+		(*mod->modfunc[modidx++])(cf, mod);
=20
 	/* Has the CAN frame been modified? */
 	if (modidx) {
@@ -546,11 +548,11 @@ static void can_can_gw_rcv(struct sk_buff *skb, void =
*data)
 		}
=20
 		/* check for checksum updates */
-		if (gwj->mod.csumfunc.crc8)
-			(*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8);
+		if (mod->csumfunc.crc8)
+			(*mod->csumfunc.crc8)(cf, &mod->csum.crc8);
=20
-		if (gwj->mod.csumfunc.xor)
-			(*gwj->mod.csumfunc.xor)(cf, &gwj->mod.csum.xor);
+		if (mod->csumfunc.xor)
+			(*mod->csumfunc.xor)(cf, &mod->csum.xor);
 	}
=20
 	/* clear the skb timestamp if not configured the other way */
@@ -581,9 +583,20 @@ static void cgw_job_free_rcu(struct rcu_head *rcu_head)
 {
 	struct cgw_job *gwj =3D container_of(rcu_head, struct cgw_job, rcu);
=20
+	/* cgw_job::cf_mod is always accessed from the same cgw_job object within
+	 * the same RCU read section. Once cgw_job is scheduled for removal,
+	 * cf_mod can also be removed without mandating an additional grace perio=
d.
+	 */
+	kfree(rcu_access_pointer(gwj->cf_mod));
 	kmem_cache_free(cgw_cache, gwj);
 }
=20
+/* Return cgw_job::cf_mod with RTNL protected section */
+static struct cf_mod *cgw_job_cf_mod(struct cgw_job *gwj)
+{
+	return rcu_dereference_protected(gwj->cf_mod, rtnl_is_locked());
+}
+
 static int cgw_notifier(struct notifier_block *nb,
 			unsigned long msg, void *ptr)
 {
@@ -616,6 +629,7 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_=
job *gwj, int type,
 {
 	struct rtcanmsg *rtcan;
 	struct nlmsghdr *nlh;
+	struct cf_mod *mod;
=20
 	nlh =3D nlmsg_put(skb, pid, seq, type, sizeof(*rtcan), flags);
 	if (!nlh)
@@ -650,82 +664,83 @@ static int cgw_put_job(struct sk_buff *skb, struct cg=
w_job *gwj, int type,
 			goto cancel;
 	}
=20
+	mod =3D cgw_job_cf_mod(gwj);
 	if (gwj->flags & CGW_FLAGS_CAN_FD) {
 		struct cgw_fdframe_mod mb;
=20
-		if (gwj->mod.modtype.and) {
-			memcpy(&mb.cf, &gwj->mod.modframe.and, sizeof(mb.cf));
-			mb.modtype =3D gwj->mod.modtype.and;
+		if (mod->modtype.and) {
+			memcpy(&mb.cf, &mod->modframe.and, sizeof(mb.cf));
+			mb.modtype =3D mod->modtype.and;
 			if (nla_put(skb, CGW_FDMOD_AND, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
=20
-		if (gwj->mod.modtype.or) {
-			memcpy(&mb.cf, &gwj->mod.modframe.or, sizeof(mb.cf));
-			mb.modtype =3D gwj->mod.modtype.or;
+		if (mod->modtype.or) {
+			memcpy(&mb.cf, &mod->modframe.or, sizeof(mb.cf));
+			mb.modtype =3D mod->modtype.or;
 			if (nla_put(skb, CGW_FDMOD_OR, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
=20
-		if (gwj->mod.modtype.xor) {
-			memcpy(&mb.cf, &gwj->mod.modframe.xor, sizeof(mb.cf));
-			mb.modtype =3D gwj->mod.modtype.xor;
+		if (mod->modtype.xor) {
+			memcpy(&mb.cf, &mod->modframe.xor, sizeof(mb.cf));
+			mb.modtype =3D mod->modtype.xor;
 			if (nla_put(skb, CGW_FDMOD_XOR, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
=20
-		if (gwj->mod.modtype.set) {
-			memcpy(&mb.cf, &gwj->mod.modframe.set, sizeof(mb.cf));
-			mb.modtype =3D gwj->mod.modtype.set;
+		if (mod->modtype.set) {
+			memcpy(&mb.cf, &mod->modframe.set, sizeof(mb.cf));
+			mb.modtype =3D mod->modtype.set;
 			if (nla_put(skb, CGW_FDMOD_SET, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 	} else {
 		struct cgw_frame_mod mb;
=20
-		if (gwj->mod.modtype.and) {
-			memcpy(&mb.cf, &gwj->mod.modframe.and, sizeof(mb.cf));
-			mb.modtype =3D gwj->mod.modtype.and;
+		if (mod->modtype.and) {
+			memcpy(&mb.cf, &mod->modframe.and, sizeof(mb.cf));
+			mb.modtype =3D mod->modtype.and;
 			if (nla_put(skb, CGW_MOD_AND, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
=20
-		if (gwj->mod.modtype.or) {
-			memcpy(&mb.cf, &gwj->mod.modframe.or, sizeof(mb.cf));
-			mb.modtype =3D gwj->mod.modtype.or;
+		if (mod->modtype.or) {
+			memcpy(&mb.cf, &mod->modframe.or, sizeof(mb.cf));
+			mb.modtype =3D mod->modtype.or;
 			if (nla_put(skb, CGW_MOD_OR, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
=20
-		if (gwj->mod.modtype.xor) {
-			memcpy(&mb.cf, &gwj->mod.modframe.xor, sizeof(mb.cf));
-			mb.modtype =3D gwj->mod.modtype.xor;
+		if (mod->modtype.xor) {
+			memcpy(&mb.cf, &mod->modframe.xor, sizeof(mb.cf));
+			mb.modtype =3D mod->modtype.xor;
 			if (nla_put(skb, CGW_MOD_XOR, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
=20
-		if (gwj->mod.modtype.set) {
-			memcpy(&mb.cf, &gwj->mod.modframe.set, sizeof(mb.cf));
-			mb.modtype =3D gwj->mod.modtype.set;
+		if (mod->modtype.set) {
+			memcpy(&mb.cf, &mod->modframe.set, sizeof(mb.cf));
+			mb.modtype =3D mod->modtype.set;
 			if (nla_put(skb, CGW_MOD_SET, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 	}
=20
-	if (gwj->mod.uid) {
-		if (nla_put_u32(skb, CGW_MOD_UID, gwj->mod.uid) < 0)
+	if (mod->uid) {
+		if (nla_put_u32(skb, CGW_MOD_UID, mod->uid) < 0)
 			goto cancel;
 	}
=20
-	if (gwj->mod.csumfunc.crc8) {
+	if (mod->csumfunc.crc8) {
 		if (nla_put(skb, CGW_CS_CRC8, CGW_CS_CRC8_LEN,
-			    &gwj->mod.csum.crc8) < 0)
+			    &mod->csum.crc8) < 0)
 			goto cancel;
 	}
=20
-	if (gwj->mod.csumfunc.xor) {
+	if (mod->csumfunc.xor) {
 		if (nla_put(skb, CGW_CS_XOR, CGW_CS_XOR_LEN,
-			    &gwj->mod.csum.xor) < 0)
+			    &mod->csum.xor) < 0)
 			goto cancel;
 	}
=20
@@ -1059,7 +1074,7 @@ static int cgw_create_job(struct sk_buff *skb,  struc=
t nlmsghdr *nlh,
 	struct net *net =3D sock_net(skb->sk);
 	struct rtcanmsg *r;
 	struct cgw_job *gwj;
-	struct cf_mod mod;
+	struct cf_mod *mod;
 	struct can_can_gw ccgw;
 	u8 limhops =3D 0;
 	int err =3D 0;
@@ -1078,37 +1093,48 @@ static int cgw_create_job(struct sk_buff *skb,  str=
uct nlmsghdr *nlh,
 	if (r->gwtype !=3D CGW_TYPE_CAN_CAN)
 		return -EINVAL;
=20
-	err =3D cgw_parse_attr(nlh, &mod, CGW_TYPE_CAN_CAN, &ccgw, &limhops);
-	if (err < 0)
-		return err;
+	mod =3D kmalloc(sizeof(*mod), GFP_KERNEL);
+	if (!mod)
+		return -ENOMEM;
=20
-	if (mod.uid) {
+	err =3D cgw_parse_attr(nlh, mod, CGW_TYPE_CAN_CAN, &ccgw, &limhops);
+	if (err < 0)
+		goto out_free_cf;
+
+	if (mod->uid) {
 		ASSERT_RTNL();
=20
 		/* check for updating an existing job with identical uid */
 		hlist_for_each_entry(gwj, &net->can.cgw_list, list) {
-			if (gwj->mod.uid !=3D mod.uid)
+			struct cf_mod *old_cf;
+
+			old_cf =3D cgw_job_cf_mod(gwj);
+			if (old_cf->uid !=3D mod->uid)
 				continue;
=20
 			/* interfaces & filters must be identical */
-			if (memcmp(&gwj->ccgw, &ccgw, sizeof(ccgw)))
-				return -EINVAL;
+			if (memcmp(&gwj->ccgw, &ccgw, sizeof(ccgw))) {
+				err =3D -EINVAL;
+				goto out_free_cf;
+			}
=20
-			/* update modifications with disabled softirq & quit */
-			local_bh_disable();
-			memcpy(&gwj->mod, &mod, sizeof(mod));
-			local_bh_enable();
+			rcu_assign_pointer(gwj->cf_mod, mod);
+			kfree_rcu_mightsleep(old_cf);
 			return 0;
 		}
 	}
=20
 	/* ifindex =3D=3D 0 is not allowed for job creation */
-	if (!ccgw.src_idx || !ccgw.dst_idx)
-		return -ENODEV;
+	if (!ccgw.src_idx || !ccgw.dst_idx) {
+		err =3D -ENODEV;
+		goto out_free_cf;
+	}
=20
 	gwj =3D kmem_cache_alloc(cgw_cache, GFP_KERNEL);
-	if (!gwj)
-		return -ENOMEM;
+	if (!gwj) {
+		err =3D -ENOMEM;
+		goto out_free_cf;
+	}
=20
 	gwj->handled_frames =3D 0;
 	gwj->dropped_frames =3D 0;
@@ -1118,7 +1144,7 @@ static int cgw_create_job(struct sk_buff *skb,  struc=
t nlmsghdr *nlh,
 	gwj->limit_hops =3D limhops;
=20
 	/* insert already parsed information */
-	memcpy(&gwj->mod, &mod, sizeof(mod));
+	RCU_INIT_POINTER(gwj->cf_mod, mod);
 	memcpy(&gwj->ccgw, &ccgw, sizeof(ccgw));
=20
 	err =3D -ENODEV;
@@ -1152,9 +1178,11 @@ static int cgw_create_job(struct sk_buff *skb,  stru=
ct nlmsghdr *nlh,
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
=20
@@ -1214,19 +1242,22 @@ static int cgw_remove_job(struct sk_buff *skb, stru=
ct nlmsghdr *nlh,
=20
 	/* remove only the first matching entry */
 	hlist_for_each_entry_safe(gwj, nx, &net->can.cgw_list, list) {
+		struct cf_mod *cf_mod;
+
 		if (gwj->flags !=3D r->flags)
 			continue;
=20
 		if (gwj->limit_hops !=3D limhops)
 			continue;
=20
+		cf_mod =3D cgw_job_cf_mod(gwj);
 		/* we have a match when uid is enabled and identical */
-		if (gwj->mod.uid || mod.uid) {
-			if (gwj->mod.uid !=3D mod.uid)
+		if (cf_mod->uid || mod.uid) {
+			if (cf_mod->uid !=3D mod.uid)
 				continue;
 		} else {
 			/* no uid =3D> check for identical modifications */
-			if (memcmp(&gwj->mod, &mod, sizeof(mod)))
+			if (memcmp(cf_mod, &mod, sizeof(mod)))
 				continue;
 		}
=20
--=20
2.49.0


