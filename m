Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8960552F2DF
	for <lists+linux-can@lfdr.de>; Fri, 20 May 2022 20:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351128AbiETSdG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 May 2022 14:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346255AbiETSdB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 May 2022 14:33:01 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3B93B01A
        for <linux-can@vger.kernel.org>; Fri, 20 May 2022 11:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1653071572;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=LR7x0h96/4yM8YvZ1G35auflK5jdxERMed1yACb8+nw=;
    b=MGgLCm02ICmUgIQLZJbaE28tWR4VvdQsh5u3bm0v5M6Qa2LL2DUbk/aD32xOnsRH1X
    mJrrinVwh7kteOa+IFKtVkpQzLwr6po+afw53pWjD9cP7ez94YyJBnbY2TbYe58b+5h+
    L0Dya78klKB6Uv2Hb4QKXpAhZmromqt+hXtncidYPFbtgzQxp560ehQGJ1t6JIxchHIl
    RnMeCyo9Lvs6Jq6kIXFlDfNFbNjTIp4O1pWMIZtTu6BozyxXW0A9cXkE9Fo9XDrrVKwU
    sKwdoGh32KHVfOgzVELEGQZLt3judSlmSslmm3QQ57OfZWUvP+HrNRC8g/jvdRdccJG8
    SXYQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JCKNKiWNaXpvraas"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.45.0 AUTH)
    with ESMTPSA id R0691fy4KIWpPYI
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 20 May 2022 20:32:51 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Eric Dumazet <edumazet@google.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Subject: [PATCH RFC] can: bcm: use call_rcu() instead of costly synchronize_rcu()
Date:   Fri, 20 May 2022 20:32:39 +0200
Message-Id: <20220520183239.19111-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In commit d5f9023fa61e ("can: bcm: delay release of struct bcm_op after
synchronize_rcu()") Thadeu Lima de Souza Cascardo introduced two
synchronize_rcu() calls in bcm_release() (only once at socket close) and
in bcm_delete_rx_op() (called on removal of each single bcm_op).

Unfortunately this slow removal of the bcm_op's affects user space
applications like cansniffer where the modification of a filter removes
2048 bcm_op's which blocks the cansniffer application for 40(!) seconds.

In commit 181d4447905d ("can: gw: use call_rcu() instead of costly
synchronize_rcu()") Eric Dumazet replaced the synchronize_rcu() calls
with several call_rcu()'s to safely remove the data structures after the
removal of CAN ID subscriptions with can_rx_unregister() calls.

This patch adopts Erics approach for the can-bcm which should be
applicable since the removal of tasklet_kill() in bcm_remove_op() and
the introduction of the HRTIMER_MODE_SOFT timer handling in Linux 5.4.

Fixes: d5f9023fa61e ("can: bcm: delay release of struct bcm_op after synchronize_rcu()") # >= 5.4
Cc: Eric Dumazet <edumazet@google.com>
Cc: Norbert Slusarek <nslusarek@gmx.net>
Cc: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 65ee1b784a30..e60161bec850 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -98,10 +98,11 @@ static inline u64 get_u64(const struct canfd_frame *cp, int offset)
 	return *(u64 *)(cp->data + offset);
 }
 
 struct bcm_op {
 	struct list_head list;
+	struct rcu_head rcu;
 	int ifindex;
 	canid_t can_id;
 	u32 flags;
 	unsigned long frames_abs, frames_filtered;
 	struct bcm_timeval ival1, ival2;
@@ -716,24 +717,31 @@ static struct bcm_op *bcm_find_op(struct list_head *ops,
 	}
 
 	return NULL;
 }
 
-static void bcm_remove_op(struct bcm_op *op)
+static void bcm_free_op_rcu(struct rcu_head *rcu_head)
 {
-	hrtimer_cancel(&op->timer);
-	hrtimer_cancel(&op->thrtimer);
+	struct bcm_op *op = container_of(rcu_head, struct bcm_op, rcu);
 
 	if ((op->frames) && (op->frames != &op->sframe))
 		kfree(op->frames);
 
 	if ((op->last_frames) && (op->last_frames != &op->last_sframe))
 		kfree(op->last_frames);
 
 	kfree(op);
 }
 
+static void bcm_remove_op(struct bcm_op *op)
+{
+	hrtimer_cancel(&op->timer);
+	hrtimer_cancel(&op->thrtimer);
+
+	call_rcu(&op->rcu, bcm_free_op_rcu);
+}
+
 static void bcm_rx_unreg(struct net_device *dev, struct bcm_op *op)
 {
 	if (op->rx_reg_dev == dev) {
 		can_rx_unregister(dev_net(dev), dev, op->can_id,
 				  REGMASK(op->can_id), bcm_rx_handler, op);
@@ -755,10 +763,13 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
 
 	list_for_each_entry_safe(op, n, ops, list) {
 		if ((op->can_id == mh->can_id) && (op->ifindex == ifindex) &&
 		    (op->flags & CAN_FD_FRAME) == (mh->flags & CAN_FD_FRAME)) {
 
+			/* disable automatic timer on frame reception */
+			op->flags |= RX_NO_AUTOTIMER;
+
 			/*
 			 * Don't care if we're bound or not (due to netdev
 			 * problems) can_rx_unregister() is always a save
 			 * thing to do here.
 			 */
@@ -783,11 +794,10 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
 						  op->can_id,
 						  REGMASK(op->can_id),
 						  bcm_rx_handler, op);
 
 			list_del(&op->list);
-			synchronize_rcu();
 			bcm_remove_op(op);
 			return 1; /* done */
 		}
 	}
 
-- 
2.30.2

