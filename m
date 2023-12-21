Return-Path: <linux-can+bounces-99-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3350981B611
	for <lists+linux-can@lfdr.de>; Thu, 21 Dec 2023 13:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE8E28823C
	for <lists+linux-can@lfdr.de>; Thu, 21 Dec 2023 12:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B430F1DDE3;
	Thu, 21 Dec 2023 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="smRzk6YQ";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="I4ll3hXl"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEA76E585
	for <linux-can@vger.kernel.org>; Thu, 21 Dec 2023 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1703162235; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VI+TXqE4930tHu6fQeeRdxc0+8TEYhtWYVxLunrbqQJIy4I3leooefNoo9143q1QSc
    LEqgcSqaUSg3+D/mcaegZI/vbBu39sPvGQAVD+4K2+HlkyMIxtt/o+0JTZGpo8iMuYWO
    KGo4BQrCNvYs8hlbBpQktAc3MQoO+7WJywMesgcuLAlj1ewTKhN3eR9fE5FG7/W3RUCi
    7wwulBoTSA4CU/GIhX03QB6B4rrNXA11QC1tF+euwRTJj6uL3C488UGCxzfvIFcVwz6U
    VcDm1yD4XQcmWD0+gIY79rtTX86MYCifJ+fmiqCGC+gpYUKtE8np179qXTnyQflyJwLK
    YVCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1703162235;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=2vAxVRfDF5nEdEqSto8hjRul3a4SCHjQ9iaFgeBvlkU=;
    b=tmPlqn698Ht54afhcADWZ96zB9SKy4i3CoLel/BIyrkQnQsgDYUaN+bgKSXMzT1ATz
    fntQaZDfM7rCc2fUKNjTuKGYqtnr6dEusygcp2tCAWgnvlmI9r+tKbROuw1koMMml5s6
    +BPoG/izQPUNKsJ3W/oJPbSl6XYwiYPETEaCwUCnpw/BhW/57DbEfdSyRxHzIk9vx1jS
    jkZlZj8+erTdhvVqKHm/iNhJgF7kq7ECnf3GXXDJwIQKRaAXGOsLmOnujLJTESIu9O+V
    lU0u5QpUchYLnkjFzRIj1J0/SU1aOhUDqdcXp0LEMzs52VzOSkFAbhgKroTEguBNhDoG
    I96g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1703162235;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=2vAxVRfDF5nEdEqSto8hjRul3a4SCHjQ9iaFgeBvlkU=;
    b=smRzk6YQXZFuMc3B4l0bqXvYny5R7OwAjYiu3BjFTioqWjs1PVHyaHD1rmI1uX+csX
    U2+eFn6lgMJ/MMU+mUA8XGTD8xDz6SXWBw0sfDA5Taw4vEKZhbsT7ln2G3GBTwekIfq+
    AHvoL5xYf6T7uN9fT4aPRopXUjY9qbUYfF6kZdtVENSzuv8sVvS9iZQUlqLAfSe4c6gB
    MwGFsnV87Bd7s+t0R8d2+0d6PlYaaR17daGvcxPHcIlfcviDb/ctaO5Z+YFCNJKhKJyl
    jdfhZS9SbIHgnEN0p4iZW6Q1qSrBTPiJm5OoTvFXPcX/fRFVRv7G27nAEnbfkZG8fVv5
    0ZvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1703162235;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=2vAxVRfDF5nEdEqSto8hjRul3a4SCHjQ9iaFgeBvlkU=;
    b=I4ll3hXlg2KcC+MMrntyCXRbJ2EmvybEjiFmLf3fH6cHVeai4P7omndiWxa8UNOrmq
    E/DLSFg5w/eIW3HAFWAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qVzYmRsVrJ/w58VQ8zHJI7gXbo7PY1fM"
Received: from blue.lan
    by smtp.strato.de (RZmta 49.10.0 AUTH)
    with ESMTPSA id Kf147azBLCbFlFr
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 21 Dec 2023 13:37:15 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH] can: gw: fix RCU/BH usage in cgw_create_job()
Date: Thu, 21 Dec 2023 13:37:03 +0100
Message-Id: <20231221123703.8170-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

As reported by Sebastian Andrzej Siewior the use of local_bh_disable()
is only feasible in uni processor systems to update the modification rules.
The usual use-case to update the modification rules is to update the data
of the modifications but not the modification types (AND/OR/XOR/SET) or
the checksum functions itself.

To omit additional memory allocations to maintain fast modification
switching times, the modification description space is doubled at gw-job
creation time so that only the reference to the active modification
desciption is changed under rcu protection.

Link: https://lore.kernel.org/linux-can/20231031112349.y0aLoBrz@linutronix.de/
Fixes: dd895d7f21b2 ("can: cangw: introduce optional uid to reference created routing jobs")
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/gw.c | 99 ++++++++++++++++++++++++++++------------------------
 1 file changed, 53 insertions(+), 46 deletions(-)

diff --git a/net/can/gw.c b/net/can/gw.c
index 37528826935e..6411f1c60f48 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -128,11 +128,13 @@ struct cgw_job {
 	struct hlist_node list;
 	struct rcu_head rcu;
 	u32 handled_frames;
 	u32 dropped_frames;
 	u32 deleted_frames;
-	struct cf_mod mod;
+	struct cf_mod *mod;
+	struct cf_mod mod1;
+	struct cf_mod mod2;
 	union {
 		/* CAN frame data source */
 		struct net_device *dev;
 	} src;
 	union {
@@ -504,11 +506,11 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	/* clone the given skb, which has not been done in can_rcv()
 	 *
 	 * When there is at least one modification function activated,
 	 * we need to copy the skb as we want to modify skb->data.
 	 */
-	if (gwj->mod.modfunc[0])
+	if (gwj->mod->modfunc[0])
 		nskb = skb_copy(skb, GFP_ATOMIC);
 	else
 		nskb = skb_clone(skb, GFP_ATOMIC);
 
 	if (!nskb) {
@@ -527,12 +529,12 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 
 	/* pointer to modifiable CAN frame */
 	cf = (struct canfd_frame *)nskb->data;
 
 	/* perform preprocessed modification functions if there are any */
-	while (modidx < MAX_MODFUNCTIONS && gwj->mod.modfunc[modidx])
-		(*gwj->mod.modfunc[modidx++])(cf, &gwj->mod);
+	while (modidx < MAX_MODFUNCTIONS && gwj->mod->modfunc[modidx])
+		(*gwj->mod->modfunc[modidx++])(cf, gwj->mod);
 
 	/* Has the CAN frame been modified? */
 	if (modidx) {
 		/* get available space for the processed CAN frame type */
 		int max_len = nskb->len - offsetof(struct canfd_frame, data);
@@ -544,15 +546,15 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 			kfree_skb(nskb);
 			return;
 		}
 
 		/* check for checksum updates */
-		if (gwj->mod.csumfunc.crc8)
-			(*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8);
+		if (gwj->mod->csumfunc.crc8)
+			(*gwj->mod->csumfunc.crc8)(cf, &gwj->mod->csum.crc8);
 
-		if (gwj->mod.csumfunc.xor)
-			(*gwj->mod.csumfunc.xor)(cf, &gwj->mod.csum.xor);
+		if (gwj->mod->csumfunc.xor)
+			(*gwj->mod->csumfunc.xor)(cf, &gwj->mod->csum.xor);
 	}
 
 	/* clear the skb timestamp if not configured the other way */
 	if (!(gwj->flags & CGW_FLAGS_CAN_SRC_TSTAMP))
 		nskb->tstamp = 0;
@@ -651,83 +653,83 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj, int type,
 	}
 
 	if (gwj->flags & CGW_FLAGS_CAN_FD) {
 		struct cgw_fdframe_mod mb;
 
-		if (gwj->mod.modtype.and) {
-			memcpy(&mb.cf, &gwj->mod.modframe.and, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.and;
+		if (gwj->mod->modtype.and) {
+			memcpy(&mb.cf, &gwj->mod->modframe.and, sizeof(mb.cf));
+			mb.modtype = gwj->mod->modtype.and;
 			if (nla_put(skb, CGW_FDMOD_AND, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.or) {
-			memcpy(&mb.cf, &gwj->mod.modframe.or, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.or;
+		if (gwj->mod->modtype.or) {
+			memcpy(&mb.cf, &gwj->mod->modframe.or, sizeof(mb.cf));
+			mb.modtype = gwj->mod->modtype.or;
 			if (nla_put(skb, CGW_FDMOD_OR, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.xor) {
-			memcpy(&mb.cf, &gwj->mod.modframe.xor, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.xor;
+		if (gwj->mod->modtype.xor) {
+			memcpy(&mb.cf, &gwj->mod->modframe.xor, sizeof(mb.cf));
+			mb.modtype = gwj->mod->modtype.xor;
 			if (nla_put(skb, CGW_FDMOD_XOR, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.set) {
-			memcpy(&mb.cf, &gwj->mod.modframe.set, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.set;
+		if (gwj->mod->modtype.set) {
+			memcpy(&mb.cf, &gwj->mod->modframe.set, sizeof(mb.cf));
+			mb.modtype = gwj->mod->modtype.set;
 			if (nla_put(skb, CGW_FDMOD_SET, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 	} else {
 		struct cgw_frame_mod mb;
 
-		if (gwj->mod.modtype.and) {
-			memcpy(&mb.cf, &gwj->mod.modframe.and, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.and;
+		if (gwj->mod->modtype.and) {
+			memcpy(&mb.cf, &gwj->mod->modframe.and, sizeof(mb.cf));
+			mb.modtype = gwj->mod->modtype.and;
 			if (nla_put(skb, CGW_MOD_AND, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.or) {
-			memcpy(&mb.cf, &gwj->mod.modframe.or, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.or;
+		if (gwj->mod->modtype.or) {
+			memcpy(&mb.cf, &gwj->mod->modframe.or, sizeof(mb.cf));
+			mb.modtype = gwj->mod->modtype.or;
 			if (nla_put(skb, CGW_MOD_OR, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.xor) {
-			memcpy(&mb.cf, &gwj->mod.modframe.xor, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.xor;
+		if (gwj->mod->modtype.xor) {
+			memcpy(&mb.cf, &gwj->mod->modframe.xor, sizeof(mb.cf));
+			mb.modtype = gwj->mod->modtype.xor;
 			if (nla_put(skb, CGW_MOD_XOR, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.set) {
-			memcpy(&mb.cf, &gwj->mod.modframe.set, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.set;
+		if (gwj->mod->modtype.set) {
+			memcpy(&mb.cf, &gwj->mod->modframe.set, sizeof(mb.cf));
+			mb.modtype = gwj->mod->modtype.set;
 			if (nla_put(skb, CGW_MOD_SET, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 	}
 
-	if (gwj->mod.uid) {
-		if (nla_put_u32(skb, CGW_MOD_UID, gwj->mod.uid) < 0)
+	if (gwj->mod->uid) {
+		if (nla_put_u32(skb, CGW_MOD_UID, gwj->mod->uid) < 0)
 			goto cancel;
 	}
 
-	if (gwj->mod.csumfunc.crc8) {
+	if (gwj->mod->csumfunc.crc8) {
 		if (nla_put(skb, CGW_CS_CRC8, CGW_CS_CRC8_LEN,
-			    &gwj->mod.csum.crc8) < 0)
+			    &gwj->mod->csum.crc8) < 0)
 			goto cancel;
 	}
 
-	if (gwj->mod.csumfunc.xor) {
+	if (gwj->mod->csumfunc.xor) {
 		if (nla_put(skb, CGW_CS_XOR, CGW_CS_XOR_LEN,
-			    &gwj->mod.csum.xor) < 0)
+			    &gwj->mod->csum.xor) < 0)
 			goto cancel;
 	}
 
 	if (gwj->gwtype == CGW_TYPE_CAN_CAN) {
 		if (gwj->ccgw.filter.can_id || gwj->ccgw.filter.can_mask) {
@@ -1085,21 +1087,25 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	if (mod.uid) {
 		ASSERT_RTNL();
 
 		/* check for updating an existing job with identical uid */
 		hlist_for_each_entry(gwj, &net->can.cgw_list, list) {
-			if (gwj->mod.uid != mod.uid)
+			if (gwj->mod->uid != mod.uid)
 				continue;
 
 			/* interfaces & filters must be identical */
 			if (memcmp(&gwj->ccgw, &ccgw, sizeof(ccgw)))
 				return -EINVAL;
 
 			/* update modifications with disabled softirq & quit */
-			local_bh_disable();
-			memcpy(&gwj->mod, &mod, sizeof(mod));
-			local_bh_enable();
+			if (gwj->mod == &gwj->mod1) {
+				memcpy(&gwj->mod2, &mod, sizeof(mod));
+				rcu_replace_pointer(gwj->mod, &gwj->mod2, true);
+			} else {
+				memcpy(&gwj->mod1, &mod, sizeof(mod));
+				rcu_replace_pointer(gwj->mod, &gwj->mod1, true);
+			}
 			return 0;
 		}
 	}
 
 	/* ifindex == 0 is not allowed for job creation */
@@ -1114,13 +1120,14 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	gwj->dropped_frames = 0;
 	gwj->deleted_frames = 0;
 	gwj->flags = r->flags;
 	gwj->gwtype = r->gwtype;
 	gwj->limit_hops = limhops;
+	gwj->mod = &gwj->mod1;
 
 	/* insert already parsed information */
-	memcpy(&gwj->mod, &mod, sizeof(mod));
+	memcpy(gwj->mod, &mod, sizeof(mod));
 	memcpy(&gwj->ccgw, &ccgw, sizeof(ccgw));
 
 	err = -ENODEV;
 
 	gwj->src.dev = __dev_get_by_index(net, gwj->ccgw.src_idx);
@@ -1219,16 +1226,16 @@ static int cgw_remove_job(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 		if (gwj->limit_hops != limhops)
 			continue;
 
 		/* we have a match when uid is enabled and identical */
-		if (gwj->mod.uid || mod.uid) {
-			if (gwj->mod.uid != mod.uid)
+		if (gwj->mod->uid || mod.uid) {
+			if (gwj->mod->uid != mod.uid)
 				continue;
 		} else {
 			/* no uid => check for identical modifications */
-			if (memcmp(&gwj->mod, &mod, sizeof(mod)))
+			if (memcmp(gwj->mod, &mod, sizeof(mod)))
 				continue;
 		}
 
 		/* if (r->gwtype == CGW_TYPE_CAN_CAN) - is made sure here */
 		if (memcmp(&gwj->ccgw, &ccgw, sizeof(ccgw)))
-- 
2.39.2


