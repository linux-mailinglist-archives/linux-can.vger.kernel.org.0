Return-Path: <linux-can+bounces-3576-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87CAABBE49
	for <lists+linux-can@lfdr.de>; Mon, 19 May 2025 14:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC583BC08E
	for <lists+linux-can@lfdr.de>; Mon, 19 May 2025 12:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8532777E4;
	Mon, 19 May 2025 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="DTg+FOqc";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="foiaQ9dG"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1011E27587C
	for <linux-can@vger.kernel.org>; Mon, 19 May 2025 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747659065; cv=pass; b=LBkpONppBv0dwTPcWlD0Y/sbW4k3voDVGUT97I7GlBiX2sl1uWCl/XjBVOqHUayOu87B2uu6gYyLpexj0tTE8/ezW/pUnsjnZeHLsUrymYWT9wN+ad1oLe2LsHEDA5UJsMsiM0gG9S9CMOpOc6H3eag3WQ8R93BUP2VrGdE+Ebg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747659065; c=relaxed/simple;
	bh=Vcs7iu4MZ4wsnNKJ4UFWdutMvQB3RF+NlOq19i6crtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lOxCZKcQdnEnwbvax6DP/1jsNHpdMti/8JTPC3Hlp3xqrk8gFalTYbvnqal14BTV2orjS6009rhyK6opTJa61aUu8g1uWiuk1x8K/0OV/F9EJy3zKD1U/yH80YIOrZ/c/SiYqNrktBECXG719B3UCiVbd00vDIdSp4tHbYGMLVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=DTg+FOqc; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=foiaQ9dG; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1747659052; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KQbHM9VQYzLbRv7e5GxSRXR69mcwH07Q4T0KUumLF+OQ6+bUk3X2NXL3bSGMZSBD+a
    I/9WFad0R6lSbGD0o5ZEKF7n+REAK1B25iKscz+kc0nTYhyx4oRBDE6faAgTp4rony/i
    jGt8ZnVEHRipow0Q7A94qdkRB7JE9A0fR+6E+rSVPILy7wWT6TcG2Y0KgSJmxqb+bXmF
    cwAJKBV4GrVlQqLMuH6N4EZjILt21SrlMOmo3Z91PVB0MyzfqOhM0Hs4PTEHABOjY1dc
    atuXcCJOELvhAZoeHdY7jmNKXENhdoWPRiIUnxEatyFNAKNUvN+La3XiSrRhvgu8KcpG
    uw7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1747659052;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=slb0CbXoJtQGMamdomkEaabRmFOCWy2n0jX/vGZjgSQ=;
    b=BcAob1YnoszfkJl3a++YcGONxErpNINjxKBJLd99tRSTMgR5RwlMZDq/ImRkm/iS/W
    up3X8e9cvkHIDvKyMiahPo/5ViYbUl71JHlluPIw0xF/BCHCDE+ld3MBAcuWWk3JT3Nj
    9r3FQOQ4YwpjYAIQLLhv7ve1u1AK05b4WRkijgvFS6FZ+bhUwGBddzk2abhgfJ+l9LGG
    jZUmWaoLxEv0DsJGQdllwAR9biNw/dist5yRqv2HCyLNBclq3BIHNh31gRnWxid01zoZ
    iVPmZohEsyQ2YQ8brQa3RdP1nLQYQdxHCv17e9qSVaSiMN6+GuceFDxcJydYHi9c1TYh
    LT1g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1747659052;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=slb0CbXoJtQGMamdomkEaabRmFOCWy2n0jX/vGZjgSQ=;
    b=DTg+FOqcHk3qQJk7g2s3vPMIU+3KkC4dCAGSFwAZmK6eQSW0hErWDue0zWyZ3A1CU4
    Me9Nc0A1gi6aXzjQckH+2fSSFWM4fI4ZeVRxy75b2E4jB+9H+L5nWwtklMqOMFEMk3ZI
    WMFrh9RjfNwVtqjP3nll82iY/Gu01XbTbY1tIDtuN7Ox5k+T9bsH1q9COTk8wD+jvsa5
    wYxS4X3sHCjGhhD+/GwRy4k29D+XJ7lbjBFyt+mIY7cLgZfNWso48mU/mI1naL0Sf8Pp
    MDbp5zmWMu9e/HpN2OwPfgHxEN0f4QH2dyPDUIdQqmfv9GD1sBnAH2hy7i5g63fTFB9I
    HqhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1747659052;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=slb0CbXoJtQGMamdomkEaabRmFOCWy2n0jX/vGZjgSQ=;
    b=foiaQ9dG0urWGabm8WXCemA8ptba1tm+GBNZind6jB1sIhDTCFvAGW8roiXESKDN4U
    6IaE7GenKs5ayEMc/5Cw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+4xtv9aJ67XA=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e514JCoqDpn
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 May 2025 14:50:52 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Anderson Nascimento <anderson@allelesecurity.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/2] can: bcm: add locking for bcm_op runtime updates
Date: Mon, 19 May 2025 14:50:26 +0200
Message-ID: <20250519125027.11900-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The CAN broadcast manager (CAN BCM) can send a sequence of CAN frames via
hrtimer. The content and also the length of the sequence can be changed
resp reduced at runtime where the 'currframe' counter is then set to zero.

Although this appeared to be a safe operation the updates of 'currframe'
can be triggered from user space and hrtimer context in bcm_can_tx().
Anderson Nascimento created a proof of concept that triggered a KASAN
slab-out-of-bounds read access which can be prevented with a spin_lock_bh.

At the rework of bcm_can_tx() the 'count' variable has been moved into
the protected section as this variable can be modified from both contexts
too.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Reported-by: Anderson Nascimento <anderson@allelesecurity.com>
Tested-by: Anderson Nascimento <anderson@allelesecurity.com>
Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 66 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 21 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 0bca1b9b3f70..871707dab7db 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -56,10 +56,11 @@
 #include <linux/can.h>
 #include <linux/can/core.h>
 #include <linux/can/skb.h>
 #include <linux/can/bcm.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <net/sock.h>
 #include <net/net_namespace.h>
 
 /*
  * To send multiple CAN frame content within TX_SETUP or to filter
@@ -120,10 +121,11 @@ struct bcm_op {
 	void *last_frames;
 	struct canfd_frame sframe;
 	struct canfd_frame last_sframe;
 	struct sock *sk;
 	struct net_device *rx_reg_dev;
+	spinlock_t bcm_tx_lock; /* protect currframe/count in runtime updates */
 };
 
 struct bcm_sock {
 	struct sock sk;
 	int bound;
@@ -283,17 +285,22 @@ static int bcm_proc_show(struct seq_file *m, void *v)
  */
 static void bcm_can_tx(struct bcm_op *op)
 {
 	struct sk_buff *skb;
 	struct net_device *dev;
-	struct canfd_frame *cf = op->frames + op->cfsiz * op->currframe;
+	struct canfd_frame *cf;
 	int err;
 
 	/* no target device? => exit */
 	if (!op->ifindex)
 		return;
 
+	/* read currframe under lock protection */
+	spin_lock_bh(&op->bcm_tx_lock);
+	cf = op->frames + op->cfsiz * op->currframe;
+	spin_unlock_bh(&op->bcm_tx_lock);
+
 	dev = dev_get_by_index(sock_net(op->sk), op->ifindex);
 	if (!dev) {
 		/* RFC: should this bcm_op remove itself here? */
 		return;
 	}
@@ -310,18 +317,27 @@ static void bcm_can_tx(struct bcm_op *op)
 
 	/* send with loopback */
 	skb->dev = dev;
 	can_skb_set_owner(skb, op->sk);
 	err = can_send(skb, 1);
+
+	/* update currframe and count under lock protection */
+	spin_lock_bh(&op->bcm_tx_lock);
+
 	if (!err)
 		op->frames_abs++;
 
 	op->currframe++;
 
 	/* reached last frame? */
 	if (op->currframe >= op->nframes)
 		op->currframe = 0;
+
+	if (op->count > 0)
+		op->count--;
+
+	spin_unlock_bh(&op->bcm_tx_lock);
 out:
 	dev_put(dev);
 }
 
 /*
@@ -428,11 +444,11 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
 {
 	struct bcm_op *op = container_of(hrtimer, struct bcm_op, timer);
 	struct bcm_msg_head msg_head;
 
 	if (op->kt_ival1 && (op->count > 0)) {
-		op->count--;
+		bcm_can_tx(op);
 		if (!op->count && (op->flags & TX_COUNTEVT)) {
 
 			/* create notification to user */
 			memset(&msg_head, 0, sizeof(msg_head));
 			msg_head.opcode  = TX_EXPIRED;
@@ -443,11 +459,10 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
 			msg_head.can_id  = op->can_id;
 			msg_head.nframes = 0;
 
 			bcm_send_to_user(op, &msg_head, NULL, 0);
 		}
-		bcm_can_tx(op);
 
 	} else if (op->kt_ival2) {
 		bcm_can_tx(op);
 	}
 
@@ -954,20 +969,46 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 				cf->can_id = msg_head->can_id;
 			}
 		}
 		op->flags = msg_head->flags;
 
+		/* only lock for unlikely count/nframes/currframe changes */
+		if (op->nframes != msg_head->nframes ||
+		    op->flags & TX_RESET_MULTI_IDX ||
+		    op->flags & SETTIMER) {
+
+			spin_lock_bh(&op->bcm_tx_lock);
+
+			if (op->nframes != msg_head->nframes ||
+			    op->flags & TX_RESET_MULTI_IDX) {
+				/* potentially update changed nframes */
+				op->nframes = msg_head->nframes;
+				/* restart multiple frame transmission */
+				op->currframe = 0;
+			}
+
+			if (op->flags & SETTIMER)
+				op->count = msg_head->count;
+
+			spin_unlock_bh(&op->bcm_tx_lock);
+		}
+
 	} else {
 		/* insert new BCM operation for the given can_id */
 
 		op = kzalloc(OPSIZ, GFP_KERNEL);
 		if (!op)
 			return -ENOMEM;
 
+		spin_lock_init(&op->bcm_tx_lock);
 		op->can_id = msg_head->can_id;
 		op->cfsiz = CFSIZ(msg_head->flags);
 		op->flags = msg_head->flags;
+		op->nframes = msg_head->nframes;
+
+		if (op->flags & SETTIMER)
+			op->count = msg_head->count;
 
 		/* create array for CAN frames and copy the data */
 		if (msg_head->nframes > 1) {
 			op->frames = kmalloc_array(msg_head->nframes,
 						   op->cfsiz,
@@ -1021,26 +1062,12 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		/* add this bcm_op to the list of the tx_ops */
 		list_add(&op->list, &bo->tx_ops);
 
 	} /* if ((op = bcm_find_op(&bo->tx_ops, msg_head->can_id, ifindex))) */
 
-	if (op->nframes != msg_head->nframes) {
-		op->nframes   = msg_head->nframes;
-		/* start multiple frame transmission with index 0 */
-		op->currframe = 0;
-	}
-
-	/* check flags */
-
-	if (op->flags & TX_RESET_MULTI_IDX) {
-		/* start multiple frame transmission with index 0 */
-		op->currframe = 0;
-	}
-
 	if (op->flags & SETTIMER) {
 		/* set timer values */
-		op->count = msg_head->count;
 		op->ival1 = msg_head->ival1;
 		op->ival2 = msg_head->ival2;
 		op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
 		op->kt_ival2 = bcm_timeval_to_ktime(msg_head->ival2);
 
@@ -1053,15 +1080,12 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		hrtimer_cancel(&op->timer);
 		/* spec: send CAN frame when starting timer */
 		op->flags |= TX_ANNOUNCE;
 	}
 
-	if (op->flags & TX_ANNOUNCE) {
+	if (op->flags & TX_ANNOUNCE)
 		bcm_can_tx(op);
-		if (op->count)
-			op->count--;
-	}
 
 	if (op->flags & STARTTIMER)
 		bcm_tx_start_timer(op);
 
 	return msg_head->nframes * op->cfsiz + MHSIZ;
-- 
2.47.2


