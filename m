Return-Path: <linux-can+bounces-8119-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OCoJLVgXTmrtCwIAu9opvQ
	(envelope-from <linux-can+bounces-8119-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 11:24:40 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9752B723AAF
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 11:24:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=b8duSPy+;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8119-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8119-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63E3030267AF
	for <lists+linux-can@lfdr.de>; Wed,  8 Jul 2026 09:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FD7407CE8;
	Wed,  8 Jul 2026 09:22:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FDD409629
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 09:22:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502570; cv=none; b=InwSqDgftjPBUbKm66iFES4XxSbdOph2hiPL5Enue4mX6PVWEMSu2m0UM0wik4XNo36KYs9eDpPu/1LwblYtwcm+5pPwz3nx3art4oltF8StZANmPY518/9VI6HQADHw2lIp5eDP/qIH6HP8WMhFM8iyzX7aZJ0phmFxI4ass9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502570; c=relaxed/simple;
	bh=XGPvv1LrMHOYe3JNsoNeeLqHOlUBa9rxrnkCeJLQTBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kFzWitQjN0j+J+zGvyUqrGIM9r8off7+DsKPe18TIVgUnDiQ2D3dOiqaphbQ7uPhfHBu/t/4sH5Thsnd6CFL9byw9e887WWVfW0bxRtugiSAZOVWg5OEMRD95Q46sHvtvnqFDjpJIW1Zpbf7LgNxD+FJkeUGdNwlGvHgXQop7/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8duSPy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAD08C2BCFC;
	Wed,  8 Jul 2026 09:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783502569;
	bh=XGPvv1LrMHOYe3JNsoNeeLqHOlUBa9rxrnkCeJLQTBQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=b8duSPy+9XRbPIDgT0rwiSci69wdj0EqrC4oxrUbCh+/vuruTLTmw7Uc00M8Kq/6d
	 t84JqPT9pY4pZsypVjoLw8UWXhLv9pIISgoMsDQB0kwk8KazRTjhsTA6NwRY6j48A/
	 +RkAjoZ0W+h7xW+n/JD/stn5VM/O0sLRw1lEjm9O77F1sa3rbSUY+EEOIRXEhv7ung
	 kVaHXa/pa+WRoiacGRQOLb1k5/GpIlg65N5rOcMDRebK+G1esTdSPAkNyWW9y1RdC7
	 e44KZW5Fr5No5aPpKB3QXisr9xpK9JsXxDM27FUPC9gSekiotr98SYlZhFO7iNWzoV
	 08e7vNi6RVr8A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C214C43602;
	Wed,  8 Jul 2026 09:22:49 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Wed, 08 Jul 2026 11:22:32 +0200
Subject: [PATCH v6 6/9] can: bcm: extend bcm_tx_lock usage for data and
 timer updates
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-bcm_fixes-v6-6-80710a2bc398@hartkopp.net>
References: <20260708-bcm_fixes-v6-0-80710a2bc398@hartkopp.net>
In-Reply-To: <20260708-bcm_fixes-v6-0-80710a2bc398@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783502567; l=6810;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=Fx/9eeoWN2asOUImmj8KTGYN2X8F4FRB3U0bTpZhVVc=;
 b=op4TDwC/o6rxEiCV38CyrkRf1na85mgqcXJZvGPBedkZ0oMTyMZVIVmKnM0SCvsopSDa31efH
 V5hNtMfvtwFCqswfMeszfWnP5VvdKNlwdeLdyMl6tJXtlill9ugmYGz
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Endpoint-Received: by B4 Relay for socketcan@hartkopp.net/20260128 with
 auth_id=620
X-Original-From: Oliver Hartkopp <socketcan@hartkopp.net>
Reply-To: socketcan@hartkopp.net
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8119-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:replyto,hartkopp.net:mid,hartkopp.net:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9752B723AAF

From: Oliver Hartkopp <socketcan@hartkopp.net>

Stage new CAN frame content for an existing tx op into a kmalloc()'d
buffer and validate it there, mirroring the approach already used in
bcm_rx_setup(). Only copy the validated data into op->frames while
holding op->bcm_tx_lock, so bcm_can_tx() and bcm_tx_timeout_handler()
can no longer observe a partially updated or unvalidated frame.

Add a missing error path for memcpy_from_msg() when copying CAN frame
data from userspace.

Also move the kt_ival1/kt_ival2/ival1/ival2 updates in bcm_tx_setup()
under op->bcm_tx_lock, and read kt_ival1/kt_ival2/count under the same
lock in bcm_tx_set_expiry() and bcm_tx_timeout_handler(), closing the
torn 64-bit ktime_t read on 32-bit platforms.

Fixes: c2aba69d0c36 ("can: bcm: add locking for bcm_op runtime updates")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 81 +++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 24 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index fca7c714cc52..fefa77045253 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -126,11 +126,11 @@ struct bcm_op {
 	void *last_frames;
 	struct canfd_frame sframe;
 	struct canfd_frame last_sframe;
 	struct sock *sk;
 	struct net_device *rx_reg_dev;
-	spinlock_t bcm_tx_lock; /* protect currframe/count in runtime updates */
+	spinlock_t bcm_tx_lock; /* protect tx data and timer updates */
 	spinlock_t bcm_rx_update_lock; /* protect filter/timer data updates */
 };
 
 struct bcm_sock {
 	struct sock sk;
@@ -453,16 +453,22 @@ static void bcm_send_to_user(struct bcm_op *op, struct bcm_msg_head *head,
 
 static bool bcm_tx_set_expiry(struct bcm_op *op, struct hrtimer *hrt)
 {
 	ktime_t ival;
 
+	spin_lock_bh(&op->bcm_tx_lock);
+
 	if (op->kt_ival1 && op->count)
 		ival = op->kt_ival1;
-	else if (op->kt_ival2)
+	else if (op->kt_ival2) {
 		ival = op->kt_ival2;
-	else
+	} else {
+		spin_unlock_bh(&op->bcm_tx_lock);
 		return false;
+	}
+
+	spin_unlock_bh(&op->bcm_tx_lock);
 
 	hrtimer_set_expires(hrt, ktime_add(ktime_get(), ival));
 	return true;
 }
 
@@ -475,12 +481,21 @@ static void bcm_tx_start_timer(struct bcm_op *op)
 /* bcm_tx_timeout_handler - performs cyclic CAN frame transmissions */
 static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
 {
 	struct bcm_op *op = container_of(hrtimer, struct bcm_op, timer);
 	struct bcm_msg_head msg_head;
+	bool tx_ival1, tx_ival2;
 
-	if (op->kt_ival1 && (op->count > 0)) {
+	/* snapshot kt_ival1/kt_ival2/count under lock to avoid torn
+	 * ktime_t reads racing with concurrent bcm_tx_setup() updates
+	 */
+	spin_lock_bh(&op->bcm_tx_lock);
+	tx_ival1 = op->kt_ival1 && (op->count > 0);
+	tx_ival2 = !!op->kt_ival2;
+	spin_unlock_bh(&op->bcm_tx_lock);
+
+	if (tx_ival1) {
 		bcm_can_tx(op, NULL);
 		if (!op->count && (op->flags & TX_COUNTEVT)) {
 
 			/* create notification to user */
 			memset(&msg_head, 0, sizeof(msg_head));
@@ -493,11 +508,11 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
 			msg_head.nframes = 0;
 
 			bcm_send_to_user(op, &msg_head, NULL, 0);
 		}
 
-	} else if (op->kt_ival2) {
+	} else if (tx_ival2) {
 		bcm_can_tx(op, NULL);
 	}
 
 	return bcm_tx_set_expiry(op, &op->timer) ?
 		HRTIMER_RESTART : HRTIMER_NORESTART;
@@ -1016,64 +1031,80 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		return -EINVAL;
 
 	/* check the given can_id */
 	op = bcm_find_op(&bo->tx_ops, msg_head, ifindex);
 	if (op) {
+		void *new_frames;
+
 		/* update existing BCM operation */
 
 		/*
 		 * Do we need more space for the CAN frames than currently
 		 * allocated? -> This is a _really_ unusual use-case and
 		 * therefore (complexity / locking) it is not supported.
 		 */
 		if (msg_head->nframes > op->nframes)
 			return -E2BIG;
 
-		/* update CAN frames content */
+		/* get new CAN frames content into a staging buffer before
+		 * locking: validate and normalize the frames there so that
+		 * bcm_can_tx() / bcm_tx_timeout_handler() never observe a
+		 * partially updated or unvalidated frame in op->frames
+		 */
+		new_frames = kmalloc(msg_head->nframes * op->cfsiz, GFP_KERNEL);
+		if (!new_frames)
+			return -ENOMEM;
+
 		for (i = 0; i < msg_head->nframes; i++) {
 
-			cf = op->frames + op->cfsiz * i;
+			cf = new_frames + op->cfsiz * i;
 			err = memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
+			if (err < 0) {
+				kfree(new_frames);
+				return err;
+			}
 
 			if (op->flags & CAN_FD_FRAME) {
 				if (cf->len > 64)
 					err = -EINVAL;
 			} else {
 				if (cf->len > 8)
 					err = -EINVAL;
 			}
 
-			if (err < 0)
+			if (err < 0) {
+				kfree(new_frames);
 				return err;
+			}
 
 			if (msg_head->flags & TX_CP_CAN_ID) {
 				/* copy can_id into frame */
 				cf->can_id = msg_head->can_id;
 			}
 		}
+
+		spin_lock_bh(&op->bcm_tx_lock);
+
+		/* update CAN frames content */
+		memcpy(op->frames, new_frames, msg_head->nframes * op->cfsiz);
+
 		op->flags = msg_head->flags;
 
-		/* only lock for unlikely count/nframes/currframe changes */
 		if (op->nframes != msg_head->nframes ||
-		    op->flags & TX_RESET_MULTI_IDX ||
-		    op->flags & SETTIMER) {
-
-			spin_lock_bh(&op->bcm_tx_lock);
+		    op->flags & TX_RESET_MULTI_IDX) {
+			/* potentially update changed nframes */
+			op->nframes = msg_head->nframes;
+			/* restart multiple frame transmission */
+			op->currframe = 0;
+		}
 
-			if (op->nframes != msg_head->nframes ||
-			    op->flags & TX_RESET_MULTI_IDX) {
-				/* potentially update changed nframes */
-				op->nframes = msg_head->nframes;
-				/* restart multiple frame transmission */
-				op->currframe = 0;
-			}
+		if (op->flags & SETTIMER)
+			op->count = msg_head->count;
 
-			if (op->flags & SETTIMER)
-				op->count = msg_head->count;
+		spin_unlock_bh(&op->bcm_tx_lock);
 
-			spin_unlock_bh(&op->bcm_tx_lock);
-		}
+		kfree(new_frames);
 
 	} else {
 		/* insert new BCM operation for the given can_id */
 
 		op = kzalloc(OPSIZ, GFP_KERNEL);
@@ -1145,14 +1176,16 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 	} /* if ((op = bcm_find_op(&bo->tx_ops, msg_head->can_id, ifindex))) */
 
 	if (op->flags & SETTIMER) {
 		/* set timer values */
+		spin_lock_bh(&op->bcm_tx_lock);
 		op->ival1 = msg_head->ival1;
 		op->ival2 = msg_head->ival2;
 		op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
 		op->kt_ival2 = bcm_timeval_to_ktime(msg_head->ival2);
+		spin_unlock_bh(&op->bcm_tx_lock);
 
 		/* disable an active timer due to zero values? */
 		if (!op->kt_ival1 && !op->kt_ival2)
 			hrtimer_cancel(&op->timer);
 	}

-- 
2.53.0



