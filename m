Return-Path: <linux-can+bounces-7668-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGTWKFqqDWpr1AUAu9opvQ
	(envelope-from <linux-can+bounces-7668-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 14:34:34 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7C158DC49
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 14:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F6A6302003B
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 12:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEFB3DBD73;
	Wed, 20 May 2026 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="iPBR4wSB";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Lw7WvieL"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75BC39B483
	for <linux-can@vger.kernel.org>; Wed, 20 May 2026 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.216
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280030; cv=pass; b=acyTtupLGzRX65O1pikzHCGogfsbX4fVxlBUYRFPZUGx45DG6z57f4vljN7HNRq+GfZqUCEHPtOAU99sKQ1/ftislwRrhgawuQlGXYOmVmHDlxZvEdLxNZu6O5/46Hz7mUC4n6K4SSkH/Qui0vUYnqwqrAdjmnQu7wV2p/ktPNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280030; c=relaxed/simple;
	bh=ov+Fi7x7NyEQ8WLARRi6DEERVtZyOqfcA/7l3QE+G/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDI+tfBcQ38W5Jwz7220KysUwKU1Lkq5JI58Viytmto4ZhvLi4JhGI8v4IUog94+1QXI4mESLKT81nXIQa5SjDaPUzS1P5wpm4/w860YMthTiER90YLXyeeebrUU5SMaF4I1SJoaK6nvH3qifvkC6Mj0AiJBGOz49+XJumN54p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=iPBR4wSB; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Lw7WvieL; arc=pass smtp.client-ip=81.169.146.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1779279301; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BXXt3K26coP7dcRAojQHILmwROs+P0uoGuQ4TfnssiU0i0FCfun7cJZr59t6857pHu
    yl+w4G9P8YvIgotbEolpia+Hk4+z2rEnRCS1M+IIq3659gYxHnYebL6JU1sIfiZX7Wu6
    Mm6luoIymTjgMp0FR4A9go/7HhIOWVJk/SJ70CDylsfI7TKYnZpS12G8+6de2G162v8c
    oj8qlXHoFKq95r2ilstJw8OS/NL37Qv0gMlimFwhrwsdDH4LNVYS0cfjpUF6ky2g76RL
    F+smRFvkDrvhQENtUX8x+7Am2ciLmZ/YNoNL7ZWONlhkrJvZ8S78gOmQHVCjXwL6Qr0G
    RY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1779279301;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=VH2WMST+t50EOxz85a/NTnDdIsdV25Thz78cdUTxFMc=;
    b=Mab+zvvuKDT3074qAdBnkE15a5arSaYWdCoL4sCDaJ5QK7enrbwCfI7qjtGnRNGl6X
    OrUudQpGn7CIYD7u4dnwUZ7AC5AhFB18SkjtEd07RDg/UNr5yXvQKXkrU76LLGRYiRIY
    zB1WP+AAQATyiKT7Prf8EvQwVv77H3niDq7IKZQW1Khkn+/uvviFswWHDgo6TKYY/zQN
    HDU5I4vAu74AYm1jXh3HGo2YgXyhdNdKrXPafUWNotXjCFeAnnDAkySi4soXzuPCIJmb
    L7tQF2q6Ez8nNE+Jzhufz9m9d1lMn9jA1AiIxtX5RaVl6lmGLmFEyiCfBsFflHac2x/9
    Q1JA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1779279301;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=VH2WMST+t50EOxz85a/NTnDdIsdV25Thz78cdUTxFMc=;
    b=iPBR4wSBlzczUFBXEcEx73PkwQqFTDn0+Pa+Kbx5OUHW5JelZVJ61tvV7Mi9fDHozu
    w8Gi0WC7r2LF+EPu5D5AcPf3RKvuW2tbS7Uwy3E0bXjoyANgrJmq+cTAbFfwPQ0RiUTp
    4kQbMh5tTeA41iMzCDKoyr1IzNd3hEWO/zmJuRoSgGD8lGQWhKxd6Kzm7CVp/tasW2v6
    3+39SN/C8vKelq69/3wJOHGI8NBZT0ojrbTG0V/Tc7M1Mb6Wc9uYeFCiT78uY7pkYzMf
    4o8EbX642Xo82qAlMChYO5A62oWEMXgYpp/Yq0A4OxlreppUq0N2LNWAwcKTHbuqi90Z
    jPlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1779279301;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=VH2WMST+t50EOxz85a/NTnDdIsdV25Thz78cdUTxFMc=;
    b=Lw7WvieLTv2s1qQHkzV6usa4K64Gb2+6gkJU5tGPGL0a1EJzWS8dEVVDWBDYahlhzr
    72iWhbipSD0cQK8hXjCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d24KCF1LFH
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 20 May 2026 14:15:01 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com
Subject: [PATCH 1/2] can: bcm: add locking when updating filter and timer values
Date: Wed, 20 May 2026 14:14:49 +0200
Message-ID: <20260520121450.27964-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520121450.27964-1-socketcan@hartkopp.net>
References: <20260520121450.27964-1-socketcan@hartkopp.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7668-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hartkopp.net:email,hartkopp.net:mid,hartkopp.net:dkim]
X-Rspamd-Queue-Id: 0A7C158DC49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

KCSAN detected a simultaneous access to timer values that can be
overwritten in bcm_rx_setup when updating timer and filter content.
This caused no functional issues in the past as the new values might
show up at any time without losing its intended functionality.

Btw. the KCSAN report can be resolved by protecting the 'lockless'
data updates with a spin_lock_bh().

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Reported-by: syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022.GAE@google.com/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 61 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index abf7bd2c2e6f..ff1f5ff8121d 100644
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
@@ -622,10 +623,12 @@ static void bcm_rx_starttimer(struct bcm_op *op)
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
@@ -638,10 +641,12 @@ static enum hrtimer_restart bcm_rx_timeout_handler(struct hrtimer *hrtimer)
 	msg_head.ival1   = op->ival1;
 	msg_head.ival2   = op->ival2;
 	msg_head.can_id  = op->can_id;
 	msg_head.nframes = 0;
 
+	spin_unlock_bh(&op->bcm_rx_update_lock);
+
 	bcm_send_to_user(op, &msg_head, NULL, 0);
 
 	return HRTIMER_NORESTART;
 }
 
@@ -686,19 +691,26 @@ static int bcm_rx_thr_flush(struct bcm_op *op)
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
@@ -743,10 +755,12 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
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
@@ -778,10 +792,12 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
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
@@ -1146,10 +1162,12 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -1157,33 +1175,53 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
 
@@ -1266,26 +1304,31 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
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


