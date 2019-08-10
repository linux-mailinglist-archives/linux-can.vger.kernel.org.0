Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E706E88CDE
	for <lists+linux-can@lfdr.de>; Sat, 10 Aug 2019 21:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbfHJTS3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 10 Aug 2019 15:18:29 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:35200 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfHJTS3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 10 Aug 2019 15:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1565464701;
        s=strato-dkim-0002; d=hartkopp.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=qjiWgz3E9Mc0pdk676AhmGQnj1SG6etQPNnbfbX/SKY=;
        b=Ux31ouo49FppTMNdezv4Ff9YPTN92e0dU1FqABtQ5vE/Z0hecJVuB3tDz0wT1AjxDq
        k6Q/sT1XMImRbfq2r5JAjPbco7Ljl7m18Cu50tRdx643fH0UipRk0ngtuvsya9Im3Zh/
        W5+47uunsQzUbDwg0mn//GQSsdbsc0JF22nTqY+hifuoqsR5Wn1yiZK0r0NpUbsvygGZ
        et4WEvRpOF0J2yRqoqo05j1bzNxzkwXoc4ZA0lOc+GGAQjRa2VVBd+5tdWMgb+qHJ2P9
        pSXQr2uhdTpbuEJw721tGT5Z/NY3FGtBbCkg041U011uSySCgNzN9i/64ljDHkROV8DC
        7cBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0lO8DsfULo/u+TWFdAQ=="
X-RZG-CLASS-ID: mo00
Received: from silver.lan
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id k05d3bv7AJIKUup
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 10 Aug 2019 21:18:20 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2 1/2] can: gw: use struct canfd_frame as internal data structure
Date:   Sat, 10 Aug 2019 21:18:09 +0200
Message-Id: <20190810191810.7638-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

To prepare the CAN FD support this patch implements the first adaptions in
data structures for CAN FD without changing the current functionality.

Additionally some code at the end of this patch is moved or indented to
simplify the review of the next implementation step.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---

v2: fixed some Checkpatch warnings

 include/uapi/linux/can/gw.h |   5 +-
 net/can/gw.c                | 222 +++++++++++++++++++-----------------
 2 files changed, 120 insertions(+), 107 deletions(-)

diff --git a/include/uapi/linux/can/gw.h b/include/uapi/linux/can/gw.h
index 7bee7a0b9800..ed811bc463b5 100644
--- a/include/uapi/linux/can/gw.h
+++ b/include/uapi/linux/can/gw.h
@@ -93,10 +93,11 @@ enum {
 
 /* CAN frame elements that are affected by curr. 3 CAN frame modifications */
 #define CGW_MOD_ID	0x01
-#define CGW_MOD_DLC	0x02
+#define CGW_MOD_DLC	0x02		/* contains the data length in bytes */
+#define CGW_MOD_LEN	CGW_MOD_DLC	/* CAN FD length representation */
 #define CGW_MOD_DATA	0x04
 
-#define CGW_FRAME_MODS 3 /* ID DLC DATA */
+#define CGW_FRAME_MODS 3 /* ID DLC/LEN DATA */
 
 #define MAX_MODFUNCTIONS (CGW_MOD_FUNCS * CGW_FRAME_MODS)
 
diff --git a/net/can/gw.c b/net/can/gw.c
index ce17f836262b..3a4f1de2c1ed 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -86,10 +86,10 @@ static struct kmem_cache *cgw_cache __read_mostly;
 /* structure that contains the (on-the-fly) CAN frame modifications */
 struct cf_mod {
 	struct {
-		struct can_frame and;
-		struct can_frame or;
-		struct can_frame xor;
-		struct can_frame set;
+		struct canfd_frame and;
+		struct canfd_frame or;
+		struct canfd_frame xor;
+		struct canfd_frame set;
 	} modframe;
 	struct {
 		u8 and;
@@ -97,7 +97,7 @@ struct cf_mod {
 		u8 xor;
 		u8 set;
 	} modtype;
-	void (*modfunc[MAX_MODFUNCTIONS])(struct can_frame *cf,
+	void (*modfunc[MAX_MODFUNCTIONS])(struct canfd_frame *cf,
 					  struct cf_mod *mod);
 
 	/* CAN frame checksum calculation after CAN frame modifications */
@@ -106,8 +106,10 @@ struct cf_mod {
 		struct cgw_csum_crc8 crc8;
 	} csum;
 	struct {
-		void (*xor)(struct can_frame *cf, struct cgw_csum_xor *xor);
-		void (*crc8)(struct can_frame *cf, struct cgw_csum_crc8 *crc8);
+		void (*xor)(struct canfd_frame *cf,
+			    struct cgw_csum_xor *xor);
+		void (*crc8)(struct canfd_frame *cf,
+			     struct cgw_csum_crc8 *crc8);
 	} csumfunc;
 	u32 uid;
 };
@@ -152,23 +154,23 @@ struct cgw_job {
 
 /* modification functions that are invoked in the hot path in can_can_gw_rcv */
 
-#define MODFUNC(func, op) static void func(struct can_frame *cf, \
+#define MODFUNC(func, op) static void func(struct canfd_frame *cf, \
 					   struct cf_mod *mod) { op ; }
 
 MODFUNC(mod_and_id, cf->can_id &= mod->modframe.and.can_id)
-MODFUNC(mod_and_dlc, cf->can_dlc &= mod->modframe.and.can_dlc)
+MODFUNC(mod_and_len, cf->len &= mod->modframe.and.len)
 MODFUNC(mod_and_data, *(u64 *)cf->data &= *(u64 *)mod->modframe.and.data)
 MODFUNC(mod_or_id, cf->can_id |= mod->modframe.or.can_id)
-MODFUNC(mod_or_dlc, cf->can_dlc |= mod->modframe.or.can_dlc)
+MODFUNC(mod_or_len, cf->len |= mod->modframe.or.len)
 MODFUNC(mod_or_data, *(u64 *)cf->data |= *(u64 *)mod->modframe.or.data)
 MODFUNC(mod_xor_id, cf->can_id ^= mod->modframe.xor.can_id)
-MODFUNC(mod_xor_dlc, cf->can_dlc ^= mod->modframe.xor.can_dlc)
+MODFUNC(mod_xor_len, cf->len ^= mod->modframe.xor.len)
 MODFUNC(mod_xor_data, *(u64 *)cf->data ^= *(u64 *)mod->modframe.xor.data)
 MODFUNC(mod_set_id, cf->can_id = mod->modframe.set.can_id)
-MODFUNC(mod_set_dlc, cf->can_dlc = mod->modframe.set.can_dlc)
+MODFUNC(mod_set_len, cf->len = mod->modframe.set.len)
 MODFUNC(mod_set_data, *(u64 *)cf->data = *(u64 *)mod->modframe.set.data)
 
-static inline void canframecpy(struct can_frame *dst, struct can_frame *src)
+static void canframecpy(struct canfd_frame *dst, struct can_frame *src)
 {
 	/*
 	 * Copy the struct members separately to ensure that no uninitialized
@@ -177,12 +179,14 @@ static inline void canframecpy(struct can_frame *dst, struct can_frame *src)
 	 */
 
 	dst->can_id = src->can_id;
-	dst->can_dlc = src->can_dlc;
+	dst->len = src->can_dlc;
 	*(u64 *)dst->data = *(u64 *)src->data;
 }
 
 static int cgw_chk_csum_parms(s8 fr, s8 to, s8 re)
 {
+	s8 dlen = CAN_MAX_DLEN;
+
 	/*
 	 * absolute dlc values 0 .. 7 => 0 .. 7, e.g. data [0]
 	 * relative to received dlc -1 .. -8 :
@@ -192,27 +196,27 @@ static int cgw_chk_csum_parms(s8 fr, s8 to, s8 re)
 	 * -8 => index = 0 (data[0])
 	 */
 
-	if (fr > -9 && fr < 8 &&
-	    to > -9 && to < 8 &&
-	    re > -9 && re < 8)
+	if (fr >= -dlen && fr < dlen &&
+	    to >= -dlen && to < dlen &&
+	    re >= -dlen && re < dlen)
 		return 0;
 	else
 		return -EINVAL;
 }
 
-static inline int calc_idx(int idx, int rx_dlc)
+static inline int calc_idx(int idx, int rx_len)
 {
 	if (idx < 0)
-		return rx_dlc + idx;
+		return rx_len + idx;
 	else
 		return idx;
 }
 
-static void cgw_csum_xor_rel(struct can_frame *cf, struct cgw_csum_xor *xor)
+static void cgw_csum_xor_rel(struct canfd_frame *cf, struct cgw_csum_xor *xor)
 {
-	int from = calc_idx(xor->from_idx, cf->can_dlc);
-	int to = calc_idx(xor->to_idx, cf->can_dlc);
-	int res = calc_idx(xor->result_idx, cf->can_dlc);
+	int from = calc_idx(xor->from_idx, cf->len);
+	int to = calc_idx(xor->to_idx, cf->len);
+	int res = calc_idx(xor->result_idx, cf->len);
 	u8 val = xor->init_xor_val;
 	int i;
 
@@ -230,7 +234,7 @@ static void cgw_csum_xor_rel(struct can_frame *cf, struct cgw_csum_xor *xor)
 	cf->data[res] = val;
 }
 
-static void cgw_csum_xor_pos(struct can_frame *cf, struct cgw_csum_xor *xor)
+static void cgw_csum_xor_pos(struct canfd_frame *cf, struct cgw_csum_xor *xor)
 {
 	u8 val = xor->init_xor_val;
 	int i;
@@ -241,7 +245,7 @@ static void cgw_csum_xor_pos(struct can_frame *cf, struct cgw_csum_xor *xor)
 	cf->data[xor->result_idx] = val;
 }
 
-static void cgw_csum_xor_neg(struct can_frame *cf, struct cgw_csum_xor *xor)
+static void cgw_csum_xor_neg(struct canfd_frame *cf, struct cgw_csum_xor *xor)
 {
 	u8 val = xor->init_xor_val;
 	int i;
@@ -252,11 +256,12 @@ static void cgw_csum_xor_neg(struct can_frame *cf, struct cgw_csum_xor *xor)
 	cf->data[xor->result_idx] = val;
 }
 
-static void cgw_csum_crc8_rel(struct can_frame *cf, struct cgw_csum_crc8 *crc8)
+static void cgw_csum_crc8_rel(struct canfd_frame *cf,
+			      struct cgw_csum_crc8 *crc8)
 {
-	int from = calc_idx(crc8->from_idx, cf->can_dlc);
-	int to = calc_idx(crc8->to_idx, cf->can_dlc);
-	int res = calc_idx(crc8->result_idx, cf->can_dlc);
+	int from = calc_idx(crc8->from_idx, cf->len);
+	int to = calc_idx(crc8->to_idx, cf->len);
+	int res = calc_idx(crc8->result_idx, cf->len);
 	u8 crc = crc8->init_crc_val;
 	int i;
 
@@ -291,7 +296,8 @@ static void cgw_csum_crc8_rel(struct can_frame *cf, struct cgw_csum_crc8 *crc8)
 	cf->data[crc8->result_idx] = crc^crc8->final_xor_val;
 }
 
-static void cgw_csum_crc8_pos(struct can_frame *cf, struct cgw_csum_crc8 *crc8)
+static void cgw_csum_crc8_pos(struct canfd_frame *cf,
+			      struct cgw_csum_crc8 *crc8)
 {
 	u8 crc = crc8->init_crc_val;
 	int i;
@@ -318,7 +324,8 @@ static void cgw_csum_crc8_pos(struct can_frame *cf, struct cgw_csum_crc8 *crc8)
 	cf->data[crc8->result_idx] = crc^crc8->final_xor_val;
 }
 
-static void cgw_csum_crc8_neg(struct can_frame *cf, struct cgw_csum_crc8 *crc8)
+static void cgw_csum_crc8_neg(struct canfd_frame *cf,
+			      struct cgw_csum_crc8 *crc8)
 {
 	u8 crc = crc8->init_crc_val;
 	int i;
@@ -349,7 +356,7 @@ static void cgw_csum_crc8_neg(struct can_frame *cf, struct cgw_csum_crc8 *crc8)
 static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 {
 	struct cgw_job *gwj = (struct cgw_job *)data;
-	struct can_frame *cf;
+	struct canfd_frame *cf;
 	struct sk_buff *nskb;
 	int modidx = 0;
 
@@ -411,7 +418,7 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	nskb->dev = gwj->dst.dev;
 
 	/* pointer to modifiable CAN frame */
-	cf = (struct can_frame *)nskb->data;
+	cf = (struct canfd_frame *)nskb->data;
 
 	/* perform preprocessed modification functions if there are any */
 	while (modidx < MAX_MODFUNCTIONS && gwj->mod.modfunc[modidx])
@@ -420,22 +427,22 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	/* Has the CAN frame been modified? */
 	if (modidx) {
 		/* get available space for the processed CAN frame type */
-		int max_len = nskb->len - offsetof(struct can_frame, data);
+		int max_len = nskb->len - offsetof(struct canfd_frame, data);
 
 		/* dlc may have changed, make sure it fits to the CAN frame */
-		if (cf->can_dlc > max_len)
+		if (cf->len > max_len)
 			goto out_delete;
 
 		/* check for checksum updates in classic CAN length only */
 		if (gwj->mod.csumfunc.crc8) {
-			if (cf->can_dlc > 8)
+			if (cf->len > 8)
 				goto out_delete;
 
 			(*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8);
 		}
 
 		if (gwj->mod.csumfunc.xor) {
-			if (cf->can_dlc > 8)
+			if (cf->len > 8)
 				goto out_delete;
 
 			(*gwj->mod.csumfunc.xor)(cf, &gwj->mod.csum.xor);
@@ -506,7 +513,6 @@ static int cgw_notifier(struct notifier_block *nb,
 static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj, int type,
 		       u32 pid, u32 seq, int flags)
 {
-	struct cgw_frame_mod mb;
 	struct rtcanmsg *rtcan;
 	struct nlmsghdr *nlh;
 
@@ -543,32 +549,36 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj, int type,
 			goto cancel;
 	}
 
-	if (gwj->mod.modtype.and) {
-		memcpy(&mb.cf, &gwj->mod.modframe.and, sizeof(mb.cf));
-		mb.modtype = gwj->mod.modtype.and;
-		if (nla_put(skb, CGW_MOD_AND, sizeof(mb), &mb) < 0)
-			goto cancel;
-	}
+	if (1) {
+		struct cgw_frame_mod mb;
 
-	if (gwj->mod.modtype.or) {
-		memcpy(&mb.cf, &gwj->mod.modframe.or, sizeof(mb.cf));
-		mb.modtype = gwj->mod.modtype.or;
-		if (nla_put(skb, CGW_MOD_OR, sizeof(mb), &mb) < 0)
-			goto cancel;
-	}
+		if (gwj->mod.modtype.and) {
+			memcpy(&mb.cf, &gwj->mod.modframe.and, sizeof(mb.cf));
+			mb.modtype = gwj->mod.modtype.and;
+			if (nla_put(skb, CGW_MOD_AND, sizeof(mb), &mb) < 0)
+				goto cancel;
+		}
 
-	if (gwj->mod.modtype.xor) {
-		memcpy(&mb.cf, &gwj->mod.modframe.xor, sizeof(mb.cf));
-		mb.modtype = gwj->mod.modtype.xor;
-		if (nla_put(skb, CGW_MOD_XOR, sizeof(mb), &mb) < 0)
-			goto cancel;
-	}
+		if (gwj->mod.modtype.or) {
+			memcpy(&mb.cf, &gwj->mod.modframe.or, sizeof(mb.cf));
+			mb.modtype = gwj->mod.modtype.or;
+			if (nla_put(skb, CGW_MOD_OR, sizeof(mb), &mb) < 0)
+				goto cancel;
+		}
 
-	if (gwj->mod.modtype.set) {
-		memcpy(&mb.cf, &gwj->mod.modframe.set, sizeof(mb.cf));
-		mb.modtype = gwj->mod.modtype.set;
-		if (nla_put(skb, CGW_MOD_SET, sizeof(mb), &mb) < 0)
-			goto cancel;
+		if (gwj->mod.modtype.xor) {
+			memcpy(&mb.cf, &gwj->mod.modframe.xor, sizeof(mb.cf));
+			mb.modtype = gwj->mod.modtype.xor;
+			if (nla_put(skb, CGW_MOD_XOR, sizeof(mb), &mb) < 0)
+				goto cancel;
+		}
+
+		if (gwj->mod.modtype.set) {
+			memcpy(&mb.cf, &gwj->mod.modframe.set, sizeof(mb.cf));
+			mb.modtype = gwj->mod.modtype.set;
+			if (nla_put(skb, CGW_MOD_SET, sizeof(mb), &mb) < 0)
+				goto cancel;
+		}
 	}
 
 	if (gwj->mod.uid) {
@@ -656,7 +666,6 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 			  u8 gwtype, void *gwtypeattr, u8 *limhops)
 {
 	struct nlattr *tb[CGW_MAX+1];
-	struct cgw_frame_mod mb;
 	int modidx = 0;
 	int err = 0;
 
@@ -676,69 +685,72 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 	}
 
 	/* check for AND/OR/XOR/SET modifications */
+	if (1) {
+		struct cgw_frame_mod mb;
 
-	if (tb[CGW_MOD_AND]) {
-		nla_memcpy(&mb, tb[CGW_MOD_AND], CGW_MODATTR_LEN);
+		if (tb[CGW_MOD_AND]) {
+			nla_memcpy(&mb, tb[CGW_MOD_AND], CGW_MODATTR_LEN);
 
-		canframecpy(&mod->modframe.and, &mb.cf);
-		mod->modtype.and = mb.modtype;
+			canframecpy(&mod->modframe.and, &mb.cf);
+			mod->modtype.and = mb.modtype;
 
-		if (mb.modtype & CGW_MOD_ID)
-			mod->modfunc[modidx++] = mod_and_id;
+			if (mb.modtype & CGW_MOD_ID)
+				mod->modfunc[modidx++] = mod_and_id;
 
-		if (mb.modtype & CGW_MOD_DLC)
-			mod->modfunc[modidx++] = mod_and_dlc;
+			if (mb.modtype & CGW_MOD_LEN)
+				mod->modfunc[modidx++] = mod_and_len;
 
-		if (mb.modtype & CGW_MOD_DATA)
-			mod->modfunc[modidx++] = mod_and_data;
-	}
+			if (mb.modtype & CGW_MOD_DATA)
+				mod->modfunc[modidx++] = mod_and_data;
+		}
 
-	if (tb[CGW_MOD_OR]) {
-		nla_memcpy(&mb, tb[CGW_MOD_OR], CGW_MODATTR_LEN);
+		if (tb[CGW_MOD_OR]) {
+			nla_memcpy(&mb, tb[CGW_MOD_OR], CGW_MODATTR_LEN);
 
-		canframecpy(&mod->modframe.or, &mb.cf);
-		mod->modtype.or = mb.modtype;
+			canframecpy(&mod->modframe.or, &mb.cf);
+			mod->modtype.or = mb.modtype;
 
-		if (mb.modtype & CGW_MOD_ID)
-			mod->modfunc[modidx++] = mod_or_id;
+			if (mb.modtype & CGW_MOD_ID)
+				mod->modfunc[modidx++] = mod_or_id;
 
-		if (mb.modtype & CGW_MOD_DLC)
-			mod->modfunc[modidx++] = mod_or_dlc;
+			if (mb.modtype & CGW_MOD_LEN)
+				mod->modfunc[modidx++] = mod_or_len;
 
-		if (mb.modtype & CGW_MOD_DATA)
-			mod->modfunc[modidx++] = mod_or_data;
-	}
+			if (mb.modtype & CGW_MOD_DATA)
+				mod->modfunc[modidx++] = mod_or_data;
+		}
 
-	if (tb[CGW_MOD_XOR]) {
-		nla_memcpy(&mb, tb[CGW_MOD_XOR], CGW_MODATTR_LEN);
+		if (tb[CGW_MOD_XOR]) {
+			nla_memcpy(&mb, tb[CGW_MOD_XOR], CGW_MODATTR_LEN);
 
-		canframecpy(&mod->modframe.xor, &mb.cf);
-		mod->modtype.xor = mb.modtype;
+			canframecpy(&mod->modframe.xor, &mb.cf);
+			mod->modtype.xor = mb.modtype;
 
-		if (mb.modtype & CGW_MOD_ID)
-			mod->modfunc[modidx++] = mod_xor_id;
+			if (mb.modtype & CGW_MOD_ID)
+				mod->modfunc[modidx++] = mod_xor_id;
 
-		if (mb.modtype & CGW_MOD_DLC)
-			mod->modfunc[modidx++] = mod_xor_dlc;
+			if (mb.modtype & CGW_MOD_LEN)
+				mod->modfunc[modidx++] = mod_xor_len;
 
-		if (mb.modtype & CGW_MOD_DATA)
-			mod->modfunc[modidx++] = mod_xor_data;
-	}
+			if (mb.modtype & CGW_MOD_DATA)
+				mod->modfunc[modidx++] = mod_xor_data;
+		}
 
-	if (tb[CGW_MOD_SET]) {
-		nla_memcpy(&mb, tb[CGW_MOD_SET], CGW_MODATTR_LEN);
+		if (tb[CGW_MOD_SET]) {
+			nla_memcpy(&mb, tb[CGW_MOD_SET], CGW_MODATTR_LEN);
 
-		canframecpy(&mod->modframe.set, &mb.cf);
-		mod->modtype.set = mb.modtype;
+			canframecpy(&mod->modframe.set, &mb.cf);
+			mod->modtype.set = mb.modtype;
 
-		if (mb.modtype & CGW_MOD_ID)
-			mod->modfunc[modidx++] = mod_set_id;
+			if (mb.modtype & CGW_MOD_ID)
+				mod->modfunc[modidx++] = mod_set_id;
 
-		if (mb.modtype & CGW_MOD_DLC)
-			mod->modfunc[modidx++] = mod_set_dlc;
+			if (mb.modtype & CGW_MOD_LEN)
+				mod->modfunc[modidx++] = mod_set_len;
 
-		if (mb.modtype & CGW_MOD_DATA)
-			mod->modfunc[modidx++] = mod_set_data;
+			if (mb.modtype & CGW_MOD_DATA)
+				mod->modfunc[modidx++] = mod_set_data;
+		}
 	}
 
 	/* check for checksum operations after CAN frame modifications */
-- 
2.20.1

