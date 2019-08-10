Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3908A88CDD
	for <lists+linux-can@lfdr.de>; Sat, 10 Aug 2019 21:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfHJTS0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 10 Aug 2019 15:18:26 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:34923 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfHJTS0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 10 Aug 2019 15:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1565464701;
        s=strato-dkim-0002; d=hartkopp.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=nnXvs25DyV6+rqloesZAE5jMX0NNnZihVN2iT5sxL8Y=;
        b=X8jrMr3jsDv9+mVbO+T8WcGQ2PQhiV7PTtt2h6ENumYURirvUfAlob9r0BzCaOLyOU
        AiRndv308G4wUnXzMeQVMRo2fIEjt9GO8vRjY2gkUB3YOa2zLvDpZslCClVIhtbXWL8L
        o6vV9c1DoE0yYtggaqzKrEvv9gfXdP14y5rxtAUD3JSgWL+VDdevYccCFpoNiZvKLsBI
        HHDCFbYZvfoBOdQkcpF2A/l3MxH4XenNT5zQajPLq9MrJWb7tuhdLGqYbphOny9LI8tm
        8z6fdOnUi+WMy6RoDxMO9ZIf12zEr5KgIka0SbFP4kfn6w8x2BtTBasunUKhV6w4xKrd
        8MZQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0lO8DsfULo/u+TWFdAQ=="
X-RZG-CLASS-ID: mo00
Received: from silver.lan
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id k05d3bv7AJILUuq
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 10 Aug 2019 21:18:21 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2 2/2] can: gw: add support for CAN FD frames
Date:   Sat, 10 Aug 2019 21:18:10 +0200
Message-Id: <20190810191810.7638-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810191810.7638-1-socketcan@hartkopp.net>
References: <20190810191810.7638-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Introduce CAN FD support which needs an extension of the netlink API to
pass CAN FD type content to the kernel which has a different size to
Classic CAN. Additionally the struct canfd_frame has a new 'flags' element
that can now be modified with can-gw.

The new CGW_FLAGS_CAN_FD option flag defines whether the routing job
handles Classic CAN or CAN FD frames. This setting is very strict at
reception time and enables the new possibilities, e.g. CGW_FDMOD_* and
modifying the flags element of struct canfd_frame, only when
CGW_FLAGS_CAN_FD is set.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---

v2: fixed some Checkpatch warnings & removed CAN FD length sanitization
    after CAN frame manipulation as suggested by Marc Kleine-Budde

 include/uapi/linux/can/gw.h |  14 ++-
 net/can/gw.c                | 215 +++++++++++++++++++++++++++++++-----
 2 files changed, 200 insertions(+), 29 deletions(-)

diff --git a/include/uapi/linux/can/gw.h b/include/uapi/linux/can/gw.h
index ed811bc463b5..3aea5388c8e4 100644
--- a/include/uapi/linux/can/gw.h
+++ b/include/uapi/linux/can/gw.h
@@ -80,6 +80,10 @@ enum {
 	CGW_DELETED,	/* number of deleted CAN frames (see max_hops param) */
 	CGW_LIM_HOPS,	/* limit the number of hops of this specific rule */
 	CGW_MOD_UID,	/* user defined identifier for modification updates */
+	CGW_FDMOD_AND,	/* CAN FD frame modification binary AND */
+	CGW_FDMOD_OR,	/* CAN FD frame modification binary OR */
+	CGW_FDMOD_XOR,	/* CAN FD frame modification binary XOR */
+	CGW_FDMOD_SET,	/* CAN FD frame modification set alternate values */
 	__CGW_MAX
 };
 
@@ -88,6 +92,7 @@ enum {
 #define CGW_FLAGS_CAN_ECHO 0x01
 #define CGW_FLAGS_CAN_SRC_TSTAMP 0x02
 #define CGW_FLAGS_CAN_IIF_TX_OK 0x04
+#define CGW_FLAGS_CAN_FD 0x08
 
 #define CGW_MOD_FUNCS 4 /* AND OR XOR SET */
 
@@ -96,8 +101,9 @@ enum {
 #define CGW_MOD_DLC	0x02		/* contains the data length in bytes */
 #define CGW_MOD_LEN	CGW_MOD_DLC	/* CAN FD length representation */
 #define CGW_MOD_DATA	0x04
+#define CGW_MOD_FLAGS	0x08		/* CAN FD flags */
 
-#define CGW_FRAME_MODS 3 /* ID DLC/LEN DATA */
+#define CGW_FRAME_MODS 4 /* ID DLC/LEN DATA FLAGS */
 
 #define MAX_MODFUNCTIONS (CGW_MOD_FUNCS * CGW_FRAME_MODS)
 
@@ -106,7 +112,13 @@ struct cgw_frame_mod {
 	__u8 modtype;
 } __attribute__((packed));
 
+struct cgw_fdframe_mod {
+	struct canfd_frame cf;
+	__u8 modtype;
+} __attribute__((packed));
+
 #define CGW_MODATTR_LEN sizeof(struct cgw_frame_mod)
+#define CGW_FDMODATTR_LEN sizeof(struct cgw_fdframe_mod)
 
 struct cgw_csum_xor {
 	__s8 from_idx;
diff --git a/net/can/gw.c b/net/can/gw.c
index 3a4f1de2c1ed..066bfaaf4360 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -2,7 +2,7 @@
 /*
  * gw.c - CAN frame Gateway/Router/Bridge with netlink interface
  *
- * Copyright (c) 2017 Volkswagen Group Electronic Research
+ * Copyright (c) 2019 Volkswagen Group Electronic Research
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -60,7 +60,7 @@
 #include <net/net_namespace.h>
 #include <net/sock.h>
 
-#define CAN_GW_VERSION "20170425"
+#define CAN_GW_VERSION "20190810"
 #define CAN_GW_NAME "can-gw"
 
 MODULE_DESCRIPTION("PF_CAN netlink gateway");
@@ -159,17 +159,50 @@ struct cgw_job {
 
 MODFUNC(mod_and_id, cf->can_id &= mod->modframe.and.can_id)
 MODFUNC(mod_and_len, cf->len &= mod->modframe.and.len)
+MODFUNC(mod_and_flags, cf->flags &= mod->modframe.and.flags)
 MODFUNC(mod_and_data, *(u64 *)cf->data &= *(u64 *)mod->modframe.and.data)
 MODFUNC(mod_or_id, cf->can_id |= mod->modframe.or.can_id)
 MODFUNC(mod_or_len, cf->len |= mod->modframe.or.len)
+MODFUNC(mod_or_flags, cf->flags |= mod->modframe.or.flags)
 MODFUNC(mod_or_data, *(u64 *)cf->data |= *(u64 *)mod->modframe.or.data)
 MODFUNC(mod_xor_id, cf->can_id ^= mod->modframe.xor.can_id)
 MODFUNC(mod_xor_len, cf->len ^= mod->modframe.xor.len)
+MODFUNC(mod_xor_flags, cf->flags ^= mod->modframe.xor.flags)
 MODFUNC(mod_xor_data, *(u64 *)cf->data ^= *(u64 *)mod->modframe.xor.data)
 MODFUNC(mod_set_id, cf->can_id = mod->modframe.set.can_id)
 MODFUNC(mod_set_len, cf->len = mod->modframe.set.len)
+MODFUNC(mod_set_flags, cf->flags = mod->modframe.set.flags)
 MODFUNC(mod_set_data, *(u64 *)cf->data = *(u64 *)mod->modframe.set.data)
 
+static void mod_and_fddata(struct canfd_frame *cf, struct cf_mod *mod)
+{
+	int i;
+
+	for (i = 0; i < CANFD_MAX_DLEN; i += 8)
+		*(u64 *)(cf->data + i) &= *(u64 *)(mod->modframe.and.data + i);
+}
+
+static void mod_or_fddata(struct canfd_frame *cf, struct cf_mod *mod)
+{
+	int i;
+
+	for (i = 0; i < CANFD_MAX_DLEN; i += 8)
+		*(u64 *)(cf->data + i) |= *(u64 *)(mod->modframe.or.data + i);
+}
+
+static void mod_xor_fddata(struct canfd_frame *cf, struct cf_mod *mod)
+{
+	int i;
+
+	for (i = 0; i < CANFD_MAX_DLEN; i += 8)
+		*(u64 *)(cf->data + i) ^= *(u64 *)(mod->modframe.xor.data + i);
+}
+
+static void mod_set_fddata(struct canfd_frame *cf, struct cf_mod *mod)
+{
+	memcpy(cf->data, mod->modframe.set.data, CANFD_MAX_DLEN);
+}
+
 static void canframecpy(struct canfd_frame *dst, struct can_frame *src)
 {
 	/*
@@ -183,10 +216,26 @@ static void canframecpy(struct canfd_frame *dst, struct can_frame *src)
 	*(u64 *)dst->data = *(u64 *)src->data;
 }
 
-static int cgw_chk_csum_parms(s8 fr, s8 to, s8 re)
+static void canfdframecpy(struct canfd_frame *dst, struct canfd_frame *src)
+{
+	/* Copy the struct members separately to ensure that no uninitialized
+	 * data are copied in the 2 bytes hole of the struct. This is needed
+	 * to make easy compares of the data in the struct cf_mod.
+	 */
+
+	dst->can_id = src->can_id;
+	dst->flags = src->flags;
+	dst->len = src->len;
+	memcpy(dst->data, src->data, CANFD_MAX_DLEN);
+}
+
+static int cgw_chk_csum_parms(s8 fr, s8 to, s8 re, struct rtcanmsg *r)
 {
 	s8 dlen = CAN_MAX_DLEN;
 
+	if (r->flags & CGW_FLAGS_CAN_FD)
+		dlen = CANFD_MAX_DLEN;
+
 	/*
 	 * absolute dlc values 0 .. 7 => 0 .. 7, e.g. data [0]
 	 * relative to received dlc -1 .. -8 :
@@ -360,6 +409,15 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	struct sk_buff *nskb;
 	int modidx = 0;
 
+	/* process strictly Classic CAN or CAN FD frames */
+	if (gwj->flags & CGW_FLAGS_CAN_FD) {
+		if (skb->len != CANFD_MTU)
+			return;
+	} else {
+		if (skb->len != CAN_MTU)
+			return;
+	}
+
 	/*
 	 * Do not handle CAN frames routed more than 'max_hops' times.
 	 * In general we should never catch this delimiter which is intended
@@ -430,23 +488,19 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 		int max_len = nskb->len - offsetof(struct canfd_frame, data);
 
 		/* dlc may have changed, make sure it fits to the CAN frame */
-		if (cf->len > max_len)
-			goto out_delete;
-
-		/* check for checksum updates in classic CAN length only */
-		if (gwj->mod.csumfunc.crc8) {
-			if (cf->len > 8)
-				goto out_delete;
-
-			(*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8);
+		if (cf->len > max_len) {
+			/* delete frame due to misconfiguration */
+			gwj->deleted_frames++;
+			kfree_skb(nskb);
+			return;
 		}
 
-		if (gwj->mod.csumfunc.xor) {
-			if (cf->len > 8)
-				goto out_delete;
+		/* check for checksum updates */
+		if (gwj->mod.csumfunc.crc8)
+			(*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8);
 
+		if (gwj->mod.csumfunc.xor)
 			(*gwj->mod.csumfunc.xor)(cf, &gwj->mod.csum.xor);
-		}
 	}
 
 	/* clear the skb timestamp if not configured the other way */
@@ -458,14 +512,6 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 		gwj->dropped_frames++;
 	else
 		gwj->handled_frames++;
-
-	return;
-
- out_delete:
-	/* delete frame due to misconfiguration */
-	gwj->deleted_frames++;
-	kfree_skb(nskb);
-	return;
 }
 
 static inline int cgw_register_filter(struct net *net, struct cgw_job *gwj)
@@ -549,7 +595,37 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj, int type,
 			goto cancel;
 	}
 
-	if (1) {
+	if (gwj->flags & CGW_FLAGS_CAN_FD) {
+		struct cgw_fdframe_mod mb;
+
+		if (gwj->mod.modtype.and) {
+			memcpy(&mb.cf, &gwj->mod.modframe.and, sizeof(mb.cf));
+			mb.modtype = gwj->mod.modtype.and;
+			if (nla_put(skb, CGW_FDMOD_AND, sizeof(mb), &mb) < 0)
+				goto cancel;
+		}
+
+		if (gwj->mod.modtype.or) {
+			memcpy(&mb.cf, &gwj->mod.modframe.or, sizeof(mb.cf));
+			mb.modtype = gwj->mod.modtype.or;
+			if (nla_put(skb, CGW_FDMOD_OR, sizeof(mb), &mb) < 0)
+				goto cancel;
+		}
+
+		if (gwj->mod.modtype.xor) {
+			memcpy(&mb.cf, &gwj->mod.modframe.xor, sizeof(mb.cf));
+			mb.modtype = gwj->mod.modtype.xor;
+			if (nla_put(skb, CGW_FDMOD_XOR, sizeof(mb), &mb) < 0)
+				goto cancel;
+		}
+
+		if (gwj->mod.modtype.set) {
+			memcpy(&mb.cf, &gwj->mod.modframe.set, sizeof(mb.cf));
+			mb.modtype = gwj->mod.modtype.set;
+			if (nla_put(skb, CGW_FDMOD_SET, sizeof(mb), &mb) < 0)
+				goto cancel;
+		}
+	} else {
 		struct cgw_frame_mod mb;
 
 		if (gwj->mod.modtype.and) {
@@ -659,6 +735,10 @@ static const struct nla_policy cgw_policy[CGW_MAX+1] = {
 	[CGW_FILTER]	= { .len = sizeof(struct can_filter) },
 	[CGW_LIM_HOPS]	= { .type = NLA_U8 },
 	[CGW_MOD_UID]	= { .type = NLA_U32 },
+	[CGW_FDMOD_AND]	= { .len = sizeof(struct cgw_fdframe_mod) },
+	[CGW_FDMOD_OR]	= { .len = sizeof(struct cgw_fdframe_mod) },
+	[CGW_FDMOD_XOR]	= { .len = sizeof(struct cgw_fdframe_mod) },
+	[CGW_FDMOD_SET]	= { .len = sizeof(struct cgw_fdframe_mod) },
 };
 
 /* check for common and gwtype specific attributes */
@@ -666,6 +746,7 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 			  u8 gwtype, void *gwtypeattr, u8 *limhops)
 {
 	struct nlattr *tb[CGW_MAX+1];
+	struct rtcanmsg *r = nlmsg_data(nlh);
 	int modidx = 0;
 	int err = 0;
 
@@ -685,7 +766,85 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 	}
 
 	/* check for AND/OR/XOR/SET modifications */
-	if (1) {
+	if (r->flags & CGW_FLAGS_CAN_FD) {
+		struct cgw_fdframe_mod mb;
+
+		if (tb[CGW_FDMOD_AND]) {
+			nla_memcpy(&mb, tb[CGW_FDMOD_AND], CGW_FDMODATTR_LEN);
+
+			canfdframecpy(&mod->modframe.and, &mb.cf);
+			mod->modtype.and = mb.modtype;
+
+			if (mb.modtype & CGW_MOD_ID)
+				mod->modfunc[modidx++] = mod_and_id;
+
+			if (mb.modtype & CGW_MOD_LEN)
+				mod->modfunc[modidx++] = mod_and_len;
+
+			if (mb.modtype & CGW_MOD_FLAGS)
+				mod->modfunc[modidx++] = mod_and_flags;
+
+			if (mb.modtype & CGW_MOD_DATA)
+				mod->modfunc[modidx++] = mod_and_fddata;
+		}
+
+		if (tb[CGW_FDMOD_OR]) {
+			nla_memcpy(&mb, tb[CGW_FDMOD_OR], CGW_FDMODATTR_LEN);
+
+			canfdframecpy(&mod->modframe.or, &mb.cf);
+			mod->modtype.or = mb.modtype;
+
+			if (mb.modtype & CGW_MOD_ID)
+				mod->modfunc[modidx++] = mod_or_id;
+
+			if (mb.modtype & CGW_MOD_LEN)
+				mod->modfunc[modidx++] = mod_or_len;
+
+			if (mb.modtype & CGW_MOD_FLAGS)
+				mod->modfunc[modidx++] = mod_or_flags;
+
+			if (mb.modtype & CGW_MOD_DATA)
+				mod->modfunc[modidx++] = mod_or_fddata;
+		}
+
+		if (tb[CGW_FDMOD_XOR]) {
+			nla_memcpy(&mb, tb[CGW_FDMOD_XOR], CGW_FDMODATTR_LEN);
+
+			canfdframecpy(&mod->modframe.xor, &mb.cf);
+			mod->modtype.xor = mb.modtype;
+
+			if (mb.modtype & CGW_MOD_ID)
+				mod->modfunc[modidx++] = mod_xor_id;
+
+			if (mb.modtype & CGW_MOD_LEN)
+				mod->modfunc[modidx++] = mod_xor_len;
+
+			if (mb.modtype & CGW_MOD_FLAGS)
+				mod->modfunc[modidx++] = mod_xor_flags;
+
+			if (mb.modtype & CGW_MOD_DATA)
+				mod->modfunc[modidx++] = mod_xor_fddata;
+		}
+
+		if (tb[CGW_FDMOD_SET]) {
+			nla_memcpy(&mb, tb[CGW_FDMOD_SET], CGW_FDMODATTR_LEN);
+
+			canfdframecpy(&mod->modframe.set, &mb.cf);
+			mod->modtype.set = mb.modtype;
+
+			if (mb.modtype & CGW_MOD_ID)
+				mod->modfunc[modidx++] = mod_set_id;
+
+			if (mb.modtype & CGW_MOD_LEN)
+				mod->modfunc[modidx++] = mod_set_len;
+
+			if (mb.modtype & CGW_MOD_FLAGS)
+				mod->modfunc[modidx++] = mod_set_flags;
+
+			if (mb.modtype & CGW_MOD_DATA)
+				mod->modfunc[modidx++] = mod_set_fddata;
+		}
+	} else {
 		struct cgw_frame_mod mb;
 
 		if (tb[CGW_MOD_AND]) {
@@ -760,7 +919,7 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 			struct cgw_csum_crc8 *c = nla_data(tb[CGW_CS_CRC8]);
 
 			err = cgw_chk_csum_parms(c->from_idx, c->to_idx,
-						 c->result_idx);
+						 c->result_idx, r);
 			if (err)
 				return err;
 
@@ -784,7 +943,7 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 			struct cgw_csum_xor *c = nla_data(tb[CGW_CS_XOR]);
 
 			err = cgw_chk_csum_parms(c->from_idx, c->to_idx,
-						 c->result_idx);
+						 c->result_idx, r);
 			if (err)
 				return err;
 
-- 
2.20.1

