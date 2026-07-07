Return-Path: <linux-can+bounces-8031-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lWarLhSwTGqfoAEAu9opvQ
	(envelope-from <linux-can+bounces-8031-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 09:51:48 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 389B7718B00
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 09:51:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=k9QRgJwZ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8031-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8031-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B62B631D152F
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 07:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF853CF67F;
	Tue,  7 Jul 2026 07:27:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3DE3C81AD
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 07:27:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409253; cv=none; b=OO7ih2EBSPSeOCpbLKVk2rA3J/5mIj3qFZc3KZG4lguI161vaa/XJ7M7GH78kYEemiQBODoorBtf3MTAYLFUY0xlHkpB4w9clDcPuMWv6q0jyRzghbQD/vfz16ZSNgLKN+NEnsmGnGWRcojgK8LnDHqV2SrBIcIfU7fH+41mVYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409253; c=relaxed/simple;
	bh=NgLxA7+CfML8741PbpXr63TkLRSvMBHjFVuEHpgvTp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BVcxRuCnoOJ/wTkOICUv0xrrveYkBqoead5uaNxjFDQdGoBC6m0UhaA9P0HNuE4uF6q2qdB7U+r70k7lGa4677Uify052OYIF9sRWca5VPOfDRg5+9bO9vLwBbb1KlDP2GnEfVoiHzL3nLTD7p4AK+mfEbmoZvccV82PC8An404=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9QRgJwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CEF1C2BCF7;
	Tue,  7 Jul 2026 07:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783409249;
	bh=NgLxA7+CfML8741PbpXr63TkLRSvMBHjFVuEHpgvTp8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=k9QRgJwZiUQhCKBjmeA7Ay110VJybxtdHH0Up3t8dTL5V1E7A/SyzCBPHxapPciVE
	 rqC6Twikod9kglp3Ut2rUxHBKqjJuReWd6Cx593sAqQQBXRNUlDMCjKfc5BvWVfueB
	 09oh5pnWJNCh+cujM37XmooeT0/ahHon/uv6wefjiDiL7XM9BxweXVK4RS/hJe0PX7
	 YHVbIWXA9aZfgcZwA7Rrc2uzEQGG2/mEuTV/uSnpsai0gfI0uKSdaR8NZu+9SXkjYg
	 tZDJZLArSpv2/hrLaRYPPiRunScttA0T11jJtk7lmapAa8i8alhZ1DPsMtZfZ1iO86
	 KSJPRR9jF2BaA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF65C43602;
	Tue,  7 Jul 2026 07:27:29 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Tue, 07 Jul 2026 09:27:16 +0200
Subject: [PATCH v2 6/6] can: bcm: extend bcm_tx_lock usage for data and
 timer updates
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-bcm_fixes-v2-6-96620c534b75@hartkopp.net>
References: <20260707-bcm_fixes-v2-0-96620c534b75@hartkopp.net>
In-Reply-To: <20260707-bcm_fixes-v2-0-96620c534b75@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783409247; l=6201;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=PZc6t73WtXCbVIX4LEg8HGRkgaiNhi+bLpz7FppAD6c=;
 b=H6dRMWY5KYqOQ7hb0Ao5wVqeDbDlww6TD+5ig+2mPliz2GOjrnXzpD/hMQiVKHBx6oExQvElf
 y1ItXzxN1ZqDh/Wr0JjDMmZh8LBYneaCaNon6EDpp9qwWmQHWfNtA56
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8031-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,hartkopp.net:replyto,hartkopp.net:mid,hartkopp.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 389B7718B00

From: Oliver Hartkopp <socketcan@hartkopp.net>

Stage new CAN frame content for an existing tx op into a kmalloc()'d
buffer and validate it there, mirroring the approach already used in
bcm_rx_setup(). Only copy the validated data into op->frames while
holding op->bcm_tx_lock, so bcm_can_tx() and bcm_tx_timeout_handler()
can no longer observe a partially updated or unvalidated frame.

Also move the kt_ival1/kt_ival2/ival1/ival2 updates in bcm_tx_setup()
under op->bcm_tx_lock, and read kt_ival1/kt_ival2/count under the same
lock in bcm_tx_set_expiry() and bcm_tx_timeout_handler(), closing the
torn 64-bit ktime_t read on 32-bit platforms.

Fixes: c2aba69d0c36 ("can: bcm: add locking for bcm_op runtime updates")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 75 +++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 23 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 3609178a1367..fdde25b5aa1d 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -450,16 +450,22 @@ static void bcm_send_to_user(struct bcm_op *op, struct bcm_msg_head *head,
 
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
 
@@ -472,12 +478,21 @@ static void bcm_tx_start_timer(struct bcm_op *op)
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
@@ -490,11 +505,11 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
 			msg_head.nframes = 0;
 
 			bcm_send_to_user(op, &msg_head, NULL, 0);
 		}
 
-	} else if (op->kt_ival2) {
+	} else if (tx_ival2) {
 		bcm_can_tx(op, NULL);
 	}
 
 	return bcm_tx_set_expiry(op, &op->timer) ?
 		HRTIMER_RESTART : HRTIMER_NORESTART;
@@ -1009,64 +1024,76 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -1138,14 +1165,16 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
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



