Return-Path: <linux-can+bounces-7689-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGHXCK+bEGpuawYAu9opvQ
	(envelope-from <linux-can+bounces-7689-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 22 May 2026 20:08:47 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1805B8D33
	for <lists+linux-can@lfdr.de>; Fri, 22 May 2026 20:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6446130078AF
	for <lists+linux-can@lfdr.de>; Fri, 22 May 2026 18:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6B6368D4E;
	Fri, 22 May 2026 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Q/Kqqn9A";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="qyBLa2xZ"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD53368D7F
	for <linux-can@vger.kernel.org>; Fri, 22 May 2026 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779473308; cv=pass; b=WMwEcc4rETiofxjUbmL40MyRnta0PObKFX3SW5+HN+qf9l/aggIlG/rFOpPCpnFxqC+OeN/s6I6yR/YFWAz8rqJU/ntHZX3n2+vriGmbRBUTJqoxFcsIE5vfuHB0kXs06lr+VL9n4HythGRAyJ3s57SNhd8nfI/pa8ANQZ1hgEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779473308; c=relaxed/simple;
	bh=CCr50l498vrPiVDsnQuH/5JEpLVVIEjtnzINCrJWBnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TX18yAElL+Ui9/TPCtMnItfgPEjDrdf0fHPftAFfjNt7DvEqLwrv/y00VFCjnPour8U0vnZ1rlMFAKEIaiKeOlVnFMxKxGUr0kMuFJDRPgomqyYB3a26PCPIl/QyFRWSzqxlecEcYnJPWLTcb92Akxb6qfYBRGIzM0izCJYPFZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Q/Kqqn9A; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=qyBLa2xZ; arc=pass smtp.client-ip=85.215.255.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1779473295; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YyOuVRJZSI9I/IAaV5fD5Es9bH2gABFzAHUtguOXeU8Zl5iP1Iq/rNkpSCMS5DCQmV
    kmlEDQU1pv/WNVYGcjRUSu7vZoatS9NLWuMAruma9GeDe8DHPcYWhubrcZlUIpg4eHfU
    WhPryZlgJVtMwmQ1+tvNA8430JigIHACRKl7r3ENLA1s+5oDJwa+g6LNpkUSX1aGgZQO
    F38E/bRifwZqv/5hnBn0dXl+7fj8BgHk5XAcUuIoCHco42Gxn28MhYvcm7b3J4aJYayD
    GdZTDvLW/KbRRJwwKYp1EwkdAd4iJlfvGXhmpul9lPmtSwLd/RSBiWuxLuTVL7mBqJxt
    3YJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1779473295;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=FJ6qRMe2BSap1OSSxkgsQhbZVG3BcTrIPBWMF3X+Mwo=;
    b=EvH+iRyAJvnunhcAC4Lsq9KVVQaZHoo0BGtNucmDB6t1EU5E4lyjnHwOi03BnitcFa
    6MqGkfsXQ9jsNimTa9eBMuk7VIXJ9UedlI7HRcqUNIrJZh5rNFQTpPpqkloQfJRNbYFF
    CM7JJBbnmlASeg2Sj/Am5GpIwQ8FvyKrnjM19RWPoj6oXFTj2+lpW8EAeOQeN6Jm8G5v
    Flk2iLF9LzyesOv3jy/xpSQuA2aCYHcUC6D66K7musLNZjSURz4yZk+egXk+zbocRgW/
    aknjO+S8ivsgRutmRVbOxKXIKFqycvZgX6vpWzUyhUw8SUuEGU1txEQ6MIpLV0i1Qk2t
    +ACQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1779473295;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=FJ6qRMe2BSap1OSSxkgsQhbZVG3BcTrIPBWMF3X+Mwo=;
    b=Q/Kqqn9AnfeHqfFwX+vBz0Vyzr6eUSK4MxDwJXdTIU1Hw4ef0/1xJBMYlgDxa/RkeQ
    YFsxUZ5Y/FSl47Ybhh5MzYhjtc/caTAhmfKU8L72IA1ru/XjTM7Qu7dD7aJ7hrs0RnDe
    DNu4nxyiIpaEwW7kHtYH+zsvHmVcS3+goEldGP5Kf468OKl0UMinq6fZiaC5r3tFPfk1
    QdAIFlBYCbj5O2+ekTEpC5Wxuk70U+9bx0iVXzgQ/Jya3M2wu+O3qnKD8rVeWCOn14jE
    W/401nzZSnT/nsfKW3DbSbJlrR45AU92Md7aeqD0O3lzIjpylblsP2JsbDMZzQU2wRqm
    Q3iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1779473295;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=FJ6qRMe2BSap1OSSxkgsQhbZVG3BcTrIPBWMF3X+Mwo=;
    b=qyBLa2xZmgfzLW8MPodw+1NoZlztQV/dKxOgNZdiI6vB/SRoeMscIrRRN8JBvP3iP2
    zHxJZaYi7H5hQ8hd77Aw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d24MI8FUgy
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 22 May 2026 20:08:15 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com
Subject: [PATCH v2 1/2] can: bcm: add locking when updating filter and timer values
Date: Fri, 22 May 2026 20:07:57 +0200
Message-ID: <20260522180758.51128-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522180758.51128-1-socketcan@hartkopp.net>
References: <20260522180758.51128-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7689-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,75e5e4ae00c3b4bb544e];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CC1805B8D33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

KCSAN detected a simultaneous access to timer values that can be
overwritten in bcm_rx_setup when updating timer and filter content.

Fix the RX_SETUP update case by protecting the timer and filter updates
with a spin_lock_bh().

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Reported-by: syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022.GAE@google.com/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 61 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index a4bef2c48a55..dbdf5d4f4ed7 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -123,10 +123,11 @@ struct bcm_op {
 	struct canfd_frame sframe;
 	struct canfd_frame last_sframe;
 	struct sock *sk;
 	struct net_device *rx_reg_dev;
 	spinlock_t bcm_tx_lock; /* protect currframe/count in runtime updates */
+	spinlock_t bcm_rx_update_lock; /* protect filter/timer data updates */
 };
 
 struct bcm_sock {
 	struct sock sk;
 	int bound;
@@ -616,10 +617,12 @@ static void bcm_rx_starttimer(struct bcm_op *op)
 static enum hrtimer_restart bcm_rx_timeout_handler(struct hrtimer *hrtimer)
 {
 	struct bcm_op *op = container_of(hrtimer, struct bcm_op, timer);
 	struct bcm_msg_head msg_head;
 
+	spin_lock_bh(&op->bcm_rx_update_lock);
+
 	/* if user wants to be informed, when cyclic CAN-Messages come back */
 	if ((op->flags & RX_ANNOUNCE_RESUME) && op->last_frames) {
 		/* clear received CAN frames to indicate 'nothing received' */
 		memset(op->last_frames, 0, op->nframes * op->cfsiz);
 	}
@@ -632,10 +635,12 @@ static enum hrtimer_restart bcm_rx_timeout_handler(struct hrtimer *hrtimer)
 	msg_head.ival1   = op->ival1;
 	msg_head.ival2   = op->ival2;
 	msg_head.can_id  = op->can_id;
 	msg_head.nframes = 0;
 
+	spin_unlock_bh(&op->bcm_rx_update_lock);
+
 	bcm_send_to_user(op, &msg_head, NULL, 0);
 
 	return HRTIMER_NORESTART;
 }
 
@@ -680,19 +685,26 @@ static int bcm_rx_thr_flush(struct bcm_op *op)
  *                      Check for throttled data and send it to the userspace
  */
 static enum hrtimer_restart bcm_rx_thr_handler(struct hrtimer *hrtimer)
 {
 	struct bcm_op *op = container_of(hrtimer, struct bcm_op, thrtimer);
+	enum hrtimer_restart ret;
+
+	spin_lock_bh(&op->bcm_rx_update_lock);
 
 	if (bcm_rx_thr_flush(op)) {
 		hrtimer_forward_now(hrtimer, op->kt_ival2);
-		return HRTIMER_RESTART;
+		ret = HRTIMER_RESTART;
 	} else {
 		/* rearm throttle handling */
 		op->kt_lastmsg = 0;
-		return HRTIMER_NORESTART;
+		ret = HRTIMER_NORESTART;
 	}
+
+	spin_unlock_bh(&op->bcm_rx_update_lock);
+
+	return ret;
 }
 
 /*
  * bcm_rx_handler - handle a CAN frame reception
  */
@@ -737,10 +749,12 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 		traffic_flags |= RX_LOCAL;
 		if (skb->sk == op->sk)
 			traffic_flags |= RX_OWN;
 	}
 
+	spin_lock_bh(&op->bcm_rx_update_lock);
+
 	if (op->flags & RX_FILTER_ID) {
 		/* the easiest case */
 		bcm_rx_update_and_send(op, op->last_frames, rxframe,
 				       traffic_flags);
 		goto rx_starttimer;
@@ -772,10 +786,12 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 		}
 	}
 
 rx_starttimer:
 	bcm_rx_starttimer(op);
+
+	spin_unlock_bh(&op->bcm_rx_update_lock);
 }
 
 /*
  * helpers for bcm_op handling: find & delete bcm [rx|tx] op elements
  */
@@ -1140,10 +1156,12 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		return -EINVAL;
 
 	/* check the given can_id */
 	op = bcm_find_op(&bo->rx_ops, msg_head, ifindex);
 	if (op) {
+		void *new_frames = NULL;
+
 		/* update existing BCM operation */
 
 		/*
 		 * Do we need more space for the CAN frames than currently
 		 * allocated? -> This is a _really_ unusual use-case and
@@ -1151,33 +1169,53 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		 */
 		if (msg_head->nframes > op->nframes)
 			return -E2BIG;
 
 		if (msg_head->nframes) {
-			/* update CAN frames content */
-			err = memcpy_from_msg(op->frames, msg,
+			/* get new CAN frames content before locking */
+			new_frames = kmalloc(msg_head->nframes * op->cfsiz,
+					     GFP_KERNEL);
+			if (!new_frames)
+				return -ENOMEM;
+
+			err = memcpy_from_msg(new_frames, msg,
 					      msg_head->nframes * op->cfsiz);
-			if (err < 0)
+			if (err < 0) {
+				kfree(new_frames);
 				return err;
-
-			/* clear last_frames to indicate 'nothing received' */
-			memset(op->last_frames, 0, msg_head->nframes * op->cfsiz);
+			}
 		}
 
+		spin_lock_bh(&op->bcm_rx_update_lock);
 		op->nframes = msg_head->nframes;
 		op->flags = msg_head->flags;
 
+		if (msg_head->nframes) {
+			/* update CAN frames content */
+			memcpy(op->frames, new_frames,
+			       msg_head->nframes * op->cfsiz);
+
+			/* clear last_frames to indicate 'nothing received' */
+			memset(op->last_frames, 0,
+			       msg_head->nframes * op->cfsiz);
+		}
+		spin_unlock_bh(&op->bcm_rx_update_lock);
+
+		/* free temporary frames / kfree(NULL) is safe */
+		kfree(new_frames);
+
 		/* Only an update -> do not call can_rx_register() */
 		do_rx_register = 0;
 
 	} else {
 		/* insert new BCM operation for the given can_id */
 		op = kzalloc(OPSIZ, GFP_KERNEL);
 		if (!op)
 			return -ENOMEM;
 
 		spin_lock_init(&op->bcm_tx_lock);
+		spin_lock_init(&op->bcm_rx_update_lock);
 		op->can_id = msg_head->can_id;
 		op->nframes = msg_head->nframes;
 		op->cfsiz = CFSIZ(msg_head->flags);
 		op->flags = msg_head->flags;
 
@@ -1260,26 +1298,31 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 	} else {
 		if (op->flags & SETTIMER) {
 
 			/* set timer value */
+			spin_lock_bh(&op->bcm_rx_update_lock);
 			op->ival1 = msg_head->ival1;
 			op->ival2 = msg_head->ival2;
 			op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
 			op->kt_ival2 = bcm_timeval_to_ktime(msg_head->ival2);
+			op->kt_lastmsg = 0;
+			spin_unlock_bh(&op->bcm_rx_update_lock);
 
 			/* disable an active timer due to zero value? */
 			if (!op->kt_ival1)
 				hrtimer_cancel(&op->timer);
 
 			/*
 			 * In any case cancel the throttle timer, flush
 			 * potentially blocked msgs and reset throttle handling
 			 */
-			op->kt_lastmsg = 0;
 			hrtimer_cancel(&op->thrtimer);
+
+			spin_lock_bh(&op->bcm_rx_update_lock);
 			bcm_rx_thr_flush(op);
+			spin_unlock_bh(&op->bcm_rx_update_lock);
 		}
 
 		if ((op->flags & STARTTIMER) && op->kt_ival1)
 			hrtimer_start(&op->timer, op->kt_ival1,
 				      HRTIMER_MODE_REL_SOFT);
-- 
2.53.0


