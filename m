Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2606FF8AB
	for <lists+linux-can@lfdr.de>; Thu, 11 May 2023 19:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238606AbjEKRq6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 11 May 2023 13:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238084AbjEKRq5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 11 May 2023 13:46:57 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E72FE46
        for <linux-can@vger.kernel.org>; Thu, 11 May 2023 10:46:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1683827211; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Ww2Pu2c7vzr2IftO/GPr2qYMek7MRKKx0/ziBbBLXLihu5IzeHPkHvr14d3YLkzNDy
    lC53Ed4llI6nt0Zyljj44eL8b2fG/Z+f/7R9gScUUNhPGjBK8VzmmGbJqACogaGwdHzu
    eUq3SXO6M/btPnP6qNYlg0odGXJPn+I3wIQXIASuDfPMYuXOEgaEwjYZd0bRKYIgxgIK
    D2QSPFPi8YtMdunRUPYUQMs83hTmpw8pNp83u9wgtW+/iPtlTwXwHYTvY1SNYjJURJoN
    caJmq9kJkkR3YisuMzugYT50W3gaogPhqGDak66uPNWtZ/QC0pbPOw+sCYGALarBbGah
    JfoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1683827211;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=V4uBX3Mowd5GC/LB56XSKSoEjlVn9ihWqzFTuYS2NkY=;
    b=Zkxb8haJCoz+S4utT8Vjc7xTWWZalJbm0b0xoI/UI8lqPJrcVZq+IVRIKcrx3PZCLU
    MmXjG4OQ56e5FAMyYuzzhheswIJ4vqWfyCreUHMcf2bI+nUym8LRdaYU8CbcmcuvLnZP
    cd7/nB9FSpSaRKq3KyujoMKMrWWVNLXD/4u7LwBscCiXw8y0dJcuknqphOSkDpeytu+L
    +N6ghNNUbRlp0fGlLV7QcVa31b5Uckqm+E6m/l21hGUxLFdxABKkxm1mSKLg7SxdkP1h
    Veo8WBK4s2iqCOpSJ9YOLCjeRpfl54hquyWm0u26ipzC1wvBaCg/VRCarsod+aQAE6vd
    vrgw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1683827211;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=V4uBX3Mowd5GC/LB56XSKSoEjlVn9ihWqzFTuYS2NkY=;
    b=VRaoFf8zASMYFMK3Y/QBvUuUCQLBgQxpgb+UIIOa0a0jn+NC9r2eP8eyB+ZDnvhND/
    MO+fTd9AIhBsumuuMUjHwygdgWZro94CZBvXLQXtmrMDjMMZZJkRA4YnXzv6pUhf+hby
    oNML/XuUVciZWT4V0hDjo3zuPpv/joBdwMvq9ph9NRl+4+VcANuGDZg03q7qLLNNIUSX
    DUFMhy52a7Vde1WvRvAsA11RJBAxplQGcDbIo3uWm0Vq+frPvj+MkliUzo/QhKZGlJZQ
    WBBrrAko1HIV01Ti1l8quhxiPmeq75/VZnFx6h6kqRuAeCMyoEQUuOILSDOwZLAvj+iQ
    +E0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1683827211;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=V4uBX3Mowd5GC/LB56XSKSoEjlVn9ihWqzFTuYS2NkY=;
    b=pfYxklleYlkCpb6i8K8JjH9BM7QTAgYBaZNJFrhyEtXs9W3bjnMRUNwP7KvqU45zR3
    R1kAzvaIM/lNGk+dShCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmVcfh+rd"
Received: from silver.lan
    by smtp.strato.de (RZmta 49.4.0 AUTH)
    with ESMTPSA id x06214z4BHkpaHt
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 11 May 2023 19:46:51 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot+e1786f049e71693263bf@syzkaller.appspotmail.com
Subject: [RFC PATCH] can: bcm: add locking for bcm tx job updates
Date:   Thu, 11 May 2023 19:46:44 +0200
Message-Id: <20230511174644.8849-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Syzbot detected a concurrent write of op->currframe which is modified in
bcm_can_tx() which can be triggerd from user context in bcm_tx_setup()
and from the soft hrtimer callback bcm_tx_timeout_handler().

This patch reorders the code to minimize the potential concurrent code
section in bcm_tx_setup() and bcm_tx_timeout_handler() which modifies
op->currframe, op->count and executes bcm_can_tx(). This minimized code
section is then protected with spin_lock_bh().

The referenced commit in the "Fixes:" tag did not really cause the issue
but is the first commit where the fix could be reasonably backported.

Cc: Dmitry Vyukov <dvyukov@google.com>
Fixes: bf74aa86e111 ("can: bcm: switch timer to HRTIMER_MODE_SOFT and remove hrtimer_tasklet")
Reported-by: syzbot+e1786f049e71693263bf@syzkaller.appspotmail.com
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 87 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 32 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index a962ec2b8ba5..34edd258f086 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -41,10 +41,11 @@
  */
 
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/spinlock.h>
 #include <linux/hrtimer.h>
 #include <linux/list.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/uio.h>
@@ -99,10 +100,11 @@ static inline u64 get_u64(const struct canfd_frame *cp, int offset)
 }
 
 struct bcm_op {
 	struct list_head list;
 	struct rcu_head rcu;
+	spinlock_t tx_setup_lock; /* protect setup/hrtimer access */
 	int ifindex;
 	canid_t can_id;
 	u32 flags;
 	unsigned long frames_abs, frames_filtered;
 	struct bcm_timeval ival1, ival2;
@@ -400,33 +402,41 @@ static void bcm_tx_start_timer(struct bcm_op *op)
 /* bcm_tx_timeout_handler - performs cyclic CAN frame transmissions */
 static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
 {
 	struct bcm_op *op = container_of(hrtimer, struct bcm_op, timer);
 	struct bcm_msg_head msg_head;
+	bool send_notification = false;
+
+	spin_lock_bh(&op->tx_setup_lock);
 
 	if (op->kt_ival1 && (op->count > 0)) {
 		op->count--;
-		if (!op->count && (op->flags & TX_COUNTEVT)) {
-
-			/* create notification to user */
-			memset(&msg_head, 0, sizeof(msg_head));
-			msg_head.opcode  = TX_EXPIRED;
-			msg_head.flags   = op->flags;
-			msg_head.count   = op->count;
-			msg_head.ival1   = op->ival1;
-			msg_head.ival2   = op->ival2;
-			msg_head.can_id  = op->can_id;
-			msg_head.nframes = 0;
-
-			bcm_send_to_user(op, &msg_head, NULL, 0);
-		}
+		if (!op->count && (op->flags & TX_COUNTEVT))
+			send_notification = true;
+
 		bcm_can_tx(op);
 
 	} else if (op->kt_ival2) {
 		bcm_can_tx(op);
 	}
 
+	spin_unlock_bh(&op->tx_setup_lock);
+
+	if (send_notification) {
+		/* create notification to user */
+		memset(&msg_head, 0, sizeof(msg_head));
+		msg_head.opcode  = TX_EXPIRED;
+		msg_head.flags   = op->flags;
+		msg_head.count   = 0; /* zero at time of check */
+		msg_head.ival1   = op->ival1;
+		msg_head.ival2   = op->ival2;
+		msg_head.can_id  = op->can_id;
+		msg_head.nframes = 0;
+
+		bcm_send_to_user(op, &msg_head, NULL, 0);
+	}
+
 	return bcm_tx_set_expiry(op, &op->timer) ?
 		HRTIMER_RESTART : HRTIMER_NORESTART;
 }
 
 /*
@@ -860,10 +870,12 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			int ifindex, struct sock *sk)
 {
 	struct bcm_sock *bo = bcm_sk(sk);
 	struct bcm_op *op;
 	struct canfd_frame *cf;
+	ktime_t setup_ival1 = ktime_set(0, 0);
+	ktime_t setup_ival2 = ktime_set(0, 0);
 	unsigned int i;
 	int err;
 
 	/* we need a real device to send frames */
 	if (!ifindex)
@@ -975,53 +987,64 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 		/* currently unused in tx_ops */
 		hrtimer_init(&op->thrtimer, CLOCK_MONOTONIC,
 			     HRTIMER_MODE_REL_SOFT);
 
+		spin_lock_init(&op->tx_setup_lock);
+
 		/* add this bcm_op to the list of the tx_ops */
 		list_add(&op->list, &bo->tx_ops);
 
 	} /* if ((op = bcm_find_op(&bo->tx_ops, msg_head->can_id, ifindex))) */
 
-	if (op->nframes != msg_head->nframes) {
-		op->nframes   = msg_head->nframes;
-		/* start multiple frame transmission with index 0 */
-		op->currframe = 0;
-	}
+	if (op->flags & SETTIMER) {
+		setup_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
+		setup_ival2 = bcm_timeval_to_ktime(msg_head->ival2);
 
-	/* check flags */
+		/* disable an active timer due to zero values? */
+		if (!setup_ival1 && !setup_ival2)
+			hrtimer_cancel(&op->timer);
+	}
 
-	if (op->flags & TX_RESET_MULTI_IDX) {
-		/* start multiple frame transmission with index 0 */
-		op->currframe = 0;
+	if (op->flags & STARTTIMER) {
+		hrtimer_cancel(&op->timer);
+		/* spec: send CAN frame when starting timer */
+		op->flags |= TX_ANNOUNCE;
 	}
 
+	spin_lock_bh(&op->tx_setup_lock);
+
 	if (op->flags & SETTIMER) {
 		/* set timer values */
 		op->count = msg_head->count;
 		op->ival1 = msg_head->ival1;
 		op->ival2 = msg_head->ival2;
-		op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
-		op->kt_ival2 = bcm_timeval_to_ktime(msg_head->ival2);
+		op->kt_ival1 = setup_ival1;
+		op->kt_ival2 = setup_ival2;
+	}
 
-		/* disable an active timer due to zero values? */
-		if (!op->kt_ival1 && !op->kt_ival2)
-			hrtimer_cancel(&op->timer);
+	if (op->nframes != msg_head->nframes) {
+		op->nframes = msg_head->nframes;
+		/* start multiple frame transmission with index 0 */
+		op->currframe = 0;
 	}
 
-	if (op->flags & STARTTIMER) {
-		hrtimer_cancel(&op->timer);
-		/* spec: send CAN frame when starting timer */
-		op->flags |= TX_ANNOUNCE;
+	/* check flags */
+
+	if (op->flags & TX_RESET_MULTI_IDX) {
+		/* start multiple frame transmission with index 0 */
+		op->currframe = 0;
 	}
 
 	if (op->flags & TX_ANNOUNCE) {
 		bcm_can_tx(op);
 		if (op->count)
 			op->count--;
 	}
 
+	spin_unlock_bh(&op->tx_setup_lock);
+
 	if (op->flags & STARTTIMER)
 		bcm_tx_start_timer(op);
 
 	return msg_head->nframes * op->cfsiz + MHSIZ;
 
-- 
2.30.2

