Return-Path: <linux-can+bounces-6595-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJ8FFbA/l2lXwAIAu9opvQ
	(envelope-from <linux-can+bounces-6595-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 17:52:00 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3C3160CE9
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 17:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E94C3002D22
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 16:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8A034CFCA;
	Thu, 19 Feb 2026 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtuLLAAu"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07996346AF8;
	Thu, 19 Feb 2026 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771519909; cv=none; b=H4vJp0smpBiy3NoRAvGwC8+J/ciFmKM23WppDfA5lf061saIEQ6KbdwZptagwTTZy7zPI0P3FotsReLGQZGHo2KYhu3S8j8dT2lUoDuTJgooQ+yPNh+9K7mTJNb3cpFSdNrSOyVv52++VfDCBLO+qaYYR+s8iUJY1n6KIpvwJLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771519909; c=relaxed/simple;
	bh=mZYbmW+dvJay6yLP96rk2aVfcPCWb/vWObzqfGu6ioA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WCtzhNZT0zjLukxzUJ2oJw1/BiyO5b6L3Bi7IhuU4rJf+6JvVqvnEFpN2AAxI3iJTU4SVhY7rvVTHTrNN2x0ugLrZnZTCtdLn/BbAvc4qgh9ZP/EjNSQYfTtBddgMYYPrUi8PKckxIEG6ryu+C+aaXN1jSp9sy2qxLKYGbS5378=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtuLLAAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF73FC19423;
	Thu, 19 Feb 2026 16:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771519908;
	bh=mZYbmW+dvJay6yLP96rk2aVfcPCWb/vWObzqfGu6ioA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WtuLLAAu6nl4m/fTPxwfSnW5SVCD1TnDe64ZP89KSSOVEfIJ82XsGYIT5/exrss4F
	 FCdSUhxtvafv0mwAUNSJ9embrefN+Fc8g7h/AyghJvGMwiJxwUXo3LVu1oILBcrT8H
	 7tgmvJKk6VeYA7HWQu2M9RmoseKkpOeBcc4ge6InGbGu02lZL9hevGdO7G37hhoACx
	 FfVa9u3QPxFUffgmS/iY4i9eAD/BDViWFM0E1vC+i3RGpuHd8K+HwKitc+bNXqJIOB
	 m/5Bd5d7t420X3/wMcPiyTHvXRWgwwo0I324ORpgzRVWoH52HW+mZwadil1aQq/RO7
	 DcnXECzHYkWew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28B4E9A052;
	Thu, 19 Feb 2026 16:51:48 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Thu, 19 Feb 2026 17:51:18 +0100
Subject: [PATCH v3 2/3] can: bcm: add locking when updating filter and
 timer values
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-bcm_spin_lock_init-v3-2-c61026740d7b@hartkopp.net>
References: <20260219-bcm_spin_lock_init-v3-0-c61026740d7b@hartkopp.net>
In-Reply-To: <20260219-bcm_spin_lock_init-v3-0-c61026740d7b@hartkopp.net>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Urs Thuermann <urs.thuermann@volkswagen.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771519907; l=4358;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=LZlNTIGHLDqDPxLmvSsyaQormiMZ6P6MsnwA3/m9nxY=;
 b=P69G1IdzhnQblRhC+Bgu/Rt1k2fgv4BZnLLWj8gfBvttZens7GwCb3V5SZi36zAVQc95rYonJ
 3A9ym3fzKkLCwWuGz43/FWDfqdpIGXDonV1CC4XBYxMGE8+GKiNMxVY
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Endpoint-Received: by B4 Relay for socketcan@hartkopp.net/20260128 with
 auth_id=620
X-Original-From: Oliver Hartkopp <socketcan@hartkopp.net>
Reply-To: socketcan@hartkopp.net
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6595-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can,75e5e4ae00c3b4bb544e];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hartkopp.net:mid,hartkopp.net:email,hartkopp.net:replyto]
X-Rspamd-Queue-Id: 6D3C3160CE9
X-Rspamd-Action: no action

From: Oliver Hartkopp <socketcan@hartkopp.net>

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
 net/can/bcm.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index fd9fa072881e..0a3dc5500e14 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -123,10 +123,11 @@ struct bcm_op {
 	struct canfd_frame sframe;
 	struct canfd_frame last_sframe;
 	struct sock *sk;
 	struct net_device *rx_reg_dev;
 	spinlock_t bcm_tx_lock; /* protect currframe/count in runtime updates */
+	spinlock_t bcm_rx_update_lock; /* protect update of filter data */
 };
 
 struct bcm_sock {
 	struct sock sk;
 	int bound;
@@ -1141,10 +1142,12 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -1152,33 +1155,53 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
 
@@ -1261,24 +1284,26 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
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
 			bcm_rx_thr_flush(op);
 		}
 
 		if ((op->flags & STARTTIMER) && op->kt_ival1)

-- 
2.51.0



