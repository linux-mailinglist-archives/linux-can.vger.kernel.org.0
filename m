Return-Path: <linux-can+bounces-7831-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kO7nAYbpK2qQHgQAu9opvQ
	(envelope-from <linux-can+bounces-7831-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2026 13:12:06 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2060E678E4B
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2026 13:12:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=lKqMWlUa;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=gsIFoXPO;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7831-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-7831-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF8AB3010736
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2026 11:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFEB286419;
	Fri, 12 Jun 2026 11:11:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4D837BE6B
	for <linux-can@vger.kernel.org>; Fri, 12 Jun 2026 11:11:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781262704; cv=pass; b=Jo+QkVBKmfsqmg1stoCkAKZ7VuqINOtxGi4xP7TMAe8Na65HdgdJXGyQRaMkmjPQ4jJz9AGiJjjHnxNZx5iDU/4ejWh4tS56ptdREt5CgZ0v/ZhDXGPCEskdqXcuRzBBwmGZMmslDRaFuwY8Z88GfJ1qJOgxX6CFOXa0u+W3KcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781262704; c=relaxed/simple;
	bh=kJ6rWaBDH7GylGnviOy8tw7bqfFkkXI+l14xMLXikIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UunnJAOKNDGHE5IhNdqNg9bna5XhEOkVa05+lueZSl8YrKGgSYVc9OcnkOjWtnX7TQ3VgiLr5qtnB7SIxdB9VkWcmQFAfG2E63fAOVsXf1z1YaNs7M1pxlcr0EJ3/eE+SLstWOwZw2e9YFBei7OIKcw7VjhuFFJCHAkmzpleoX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=lKqMWlUa; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=gsIFoXPO; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal: i=1; a=rsa-sha256; t=1781262337; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=j4GKcGdXjXpkdk3+PeCMgfValPpAbL0sd4zBDWr05Zf+rEj8DTsA1qplALD9wvfaPA
    2a46Qm/fKNp8t4S/GH+JEFqb2hZb9JnvKlZYK1V5BY8pWWfFzChkl5lln2QKEk5ZNzN9
    QxFOIOB2+XozLe/u2etoNyL0xsdDk0IU/L17+vuR/WvSji7wURRekIVimi56e2nABJwE
    4Si6OdPKpjRlySoSX0gIhRG+qM3hfXzSNUzZMsmqLSAFX8bccywmDincwQ2CUSG7et5b
    MOQiemJhXDH7AaYW2YbLvw1WzQrOomgfHp3MkAPWBC+dcIy3yqGIugtO3TplJxIcehfO
    g7Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1781262337;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=GqR7nrsUimzanreeRoYFufXaKcwMQy6zcezXfc9jJg8=;
    b=qCe9FHgqpQL50OlW0ApWnc0bd2Mer7iHrX0hNCA3yuuPx4O6V1F9ZiJ8vwiGNL8vMA
    HRwF2IolV9ynm/QkTJQPxOi8eAXe80BumjjjpfHJgdtGYA9Hn1UWv4NuAU32fIphIYfb
    RIfvxvapUZ2evKzb0Cn302bTEbTILw+EmBOSxnXFBzJ5AXIHS5gZoOkL+xIHTZ2nyNqB
    e0sWLvabzIvrLh9cTaVjaXeGeLkQLgwG4GQ0EalXt2fxR3rviKoBCYXFsmP33HpcuRi0
    NPPjWeh0ZsjJgP+fMM+Wu5fcpNay0x+Te94fALotgRP/7vbCIN8Z8hR7hUs2/DK7Auu5
    p3tQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1781262337;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=GqR7nrsUimzanreeRoYFufXaKcwMQy6zcezXfc9jJg8=;
    b=lKqMWlUa7cdEv5/DVFypAlmi7q1SVqdkvXfB3jktaCZ0qryLdQSqbbQKPnYY1ioDhl
    CsiOU9Qd+Kon6fhSXgseaGOG7aYwnjZUst1kum+tbp9SpdUFfa7AAD52Wu8osOj+0ScI
    ERpD6z5H69IfwQMfmSKQLhVh8zBX/3Hhwjsnc5oAzyURbm5xUPt/4ScruSks5x8CnTTO
    TZhIQZtc7N2juHuS1zmZPYliYmOJUkQ+PXaLFCUMP/mHIOZJyN/CDaq7btDIgs9oOniK
    j01eK8ACmKhM4/MMNivGUpk3tGRpRFLISt1cFA8Ol1bBzk3mefZYAlwICu1b0ilz/vkj
    XpUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1781262337;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=GqR7nrsUimzanreeRoYFufXaKcwMQy6zcezXfc9jJg8=;
    b=gsIFoXPODPEQ9lg7OP28t601ClMHz39NtoFf6QEDYE2qpApgNLKAYNqmzXwj7PG1UA
    Ef+umyL44qW1MU7qQWAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d25CB5a8w9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 12 Jun 2026 13:05:36 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Fri, 12 Jun 2026 13:05:18 +0200
Subject: [PATCH 3/5] can: bcm: add locking when updating filter and timer
 values
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-bcm_fixes-v1-3-ca2fa07ee70f@hartkopp.net>
References: <20260612-bcm_fixes-v1-0-ca2fa07ee70f@hartkopp.net>
In-Reply-To: <20260612-bcm_fixes-v1-0-ca2fa07ee70f@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781262336; l=6797;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=kJ6rWaBDH7GylGnviOy8tw7bqfFkkXI+l14xMLXikIM=;
 b=P8dvzsKJXaB8C8zzWNO6pJN7Lmeui0hXM6a6lxg/5Ebo4aoecS4sdL67yx4QCu5GjU+WBXPvx
 /GZfT8tpDFRAlki/p6diwZhl2jegX/hZc/wvw43oIn8L81/NGC3XKXb
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7831-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,75e5e4ae00c3b4bb544e];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,hartkopp.net:dkim,hartkopp.net:email,hartkopp.net:mid,hartkopp.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2060E678E4B

KCSAN detected a simultaneous access to timer values that can be
overwritten in bcm_rx_setup when updating timer and filter content.

Fix the RX_SETUP update case by protecting the timer and filter updates
with a spin_lock_bh().

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Reported-by: syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022.GAE@google.com/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 9475758a6749..fc5158132b55 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -127,10 +127,11 @@ struct bcm_op {
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
@@ -620,10 +621,12 @@ static void bcm_rx_starttimer(struct bcm_op *op)
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
@@ -636,10 +639,12 @@ static enum hrtimer_restart bcm_rx_timeout_handler(struct hrtimer *hrtimer)
 	msg_head.ival1   = op->ival1;
 	msg_head.ival2   = op->ival2;
 	msg_head.can_id  = op->can_id;
 	msg_head.nframes = 0;
 
+	spin_unlock_bh(&op->bcm_rx_update_lock);
+
 	bcm_send_to_user(op, &msg_head, NULL, 0);
 
 	return HRTIMER_NORESTART;
 }
 
@@ -684,19 +689,26 @@ static int bcm_rx_thr_flush(struct bcm_op *op)
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
@@ -741,10 +753,12 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
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
@@ -776,10 +790,12 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
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
@@ -1155,10 +1171,12 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -1166,33 +1184,53 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
 
@@ -1275,26 +1313,31 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
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


