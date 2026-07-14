Return-Path: <linux-can+bounces-8384-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vpreBeQLVmoPygAAu9opvQ
	(envelope-from <linux-can+bounces-8384-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 12:13:56 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E1F7534A9
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 12:13:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=NTC5F9T6;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8384-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8384-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DBB430DA4BD
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 10:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EEE3644C6;
	Tue, 14 Jul 2026 10:12:14 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000063644C4
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 10:12:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784023934; cv=none; b=pab8UrS3RJ3ORJSR+dBh6LzIIGlRqakK21tGSDIeYpf/vemTmrOrfAEaZMObZ49a8RPAZD1CkIXw09IqeXex/dQS+YOZwReM/5m9PKt9q93L+G5IBxbQwMHxqYySYiMInssvnruM5sSCn2CzefOlvwFEWS40NbnwmHAqvY0iG7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784023934; c=relaxed/simple;
	bh=iDT3B2lkvV16yvmcUuoORV0acI6RViOkmMjRgXPeGXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ang2nYFNtSjRov63Vg+EXdgEzERdHJwqDSCg7BnhlYwrZ6sSIb+R6/jJDLNwg4aawh3Z9waYnK70sOHpiUQElNalVZM7dJ+MVrof1XOYv1JSxCPERvyLrCpGCtd7hQbD0v3R+kWoosqpeK8eYW1+VgUw8I9iVdcrMnEtntVm1bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTC5F9T6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6933C2BCB8;
	Tue, 14 Jul 2026 10:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784023933;
	bh=iDT3B2lkvV16yvmcUuoORV0acI6RViOkmMjRgXPeGXk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NTC5F9T6cxFO4wfdKMi3+/lDJhn+fwd0jhhZzwEJ2EiRchiVaG8XKhefwkZc7YxPw
	 2MrHijc9CwodLBg4dFfUwWc9OsPM04F3j4NbCejSa+yrohYDzAk/jCMCcQfKgaejb2
	 Zml4Ss/7y8Cxt7YxfdGtocW8NsVhuz1YMhJzlEGQbcNrXVLiAm1gflPR4e/arARQlq
	 oAOeQyZOpbjHyb5FGvWL1uP5e75fQgyKLWQueBH4A0Q9utlXg88DYuweJ607d2FKsU
	 jiZS33QgCd2HqHRk23OGiLGQINzxhpWmyHxbddqFbzgKlZyH9nSuWtuyp8fIPGijZa
	 b9yYvVsCEIJ6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DDAC44508;
	Tue, 14 Jul 2026 10:12:13 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Tue, 14 Jul 2026 12:12:15 +0200
Subject: [PATCH v13 11/11] can: bcm: track a single source interface for
 ANYDEV timeout/throttle ops
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-bcm_fixes-v13-11-fd667c61099a@hartkopp.net>
References: <20260714-bcm_fixes-v13-0-fd667c61099a@hartkopp.net>
In-Reply-To: <20260714-bcm_fixes-v13-0-fd667c61099a@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784023931; l=5840;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=Osdc4ZlOuS7wBhCddPc7JLkoTsPdelRe7Vzm1xJS+G8=;
 b=6le7DK+4cSiYfKy7kIeKTJWIH2ceVDimgaNNg9wfE3SCfXErtw41HZwCOEoW+yGc11QoaQ0Q5
 jnXWD/cc8Y+ApGGnOuEsrDTVXafOrw+RPQTtxPNG7dB+3AfGWCOqVyr
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8384-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91E1F7534A9

From: Oliver Hartkopp <socketcan@hartkopp.net>

An ANYDEV rx op (ifindex == 0) with an active RX timeout and/or
throttle timer has no defined semantics when matching frames arrive
from several interfaces: bcm_rx_handler() can run concurrently for
the same op on different CPUs, racing hrtimer_cancel()/
bcm_rx_starttimer() against bcm_rx_timeout_handler() and causing
spurious RX_TIMEOUT notifications and last_frames corruption. The
same concurrency lets throttled multiplex frames from different
interfaces clobber the single rx_ifindex/rx_stamp fields shared by
the op.

Add op->if_detected to track the first interface that delivers a
matching frame while a timeout/throttle timer is configured, and
reject frames from any other interface for that op. The claim is
decided in bcm_rx_handler() before hrtimer_cancel() touches
op->timer, so a rejected frame can never disturb the claimed
interface's watchdog. RTR-mode ops are excluded via RX_RTR_FRAME,
independent of kt_ival1/kt_ival2, since those may briefly hold a
stale value from an earlier non-RTR configuration.

The claim is released in bcm_notify() on NETDEV_UNREGISTER and in
bcm_rx_setup() when SETTIMER reconfigures the timer values.

A (re-)claim is only possible on CAN devices in NETREG_REGISTERED
dev->reg_state to cover the release in bcm_notify() where reg_state
becomes NETREG_UNREGISTERING until synchronize_net().

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/linux-can/20260709105031.1A39C1F000E9@smtp.kernel.org/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 0ada2402c24c..a3ce0d49d952 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -115,10 +115,11 @@ struct bcm_op {
 	atomic_long_t frames_abs, frames_filtered;
 	struct bcm_timeval ival1, ival2;
 	struct hrtimer timer, thrtimer;
 	ktime_t rx_stamp, kt_ival1, kt_ival2, kt_lastmsg;
 	int rx_ifindex;
+	int if_detected; /* first received ifindex in ANYDEV rx_op mode */
 	int cfsiz;
 	u32 count;
 	u32 nframes;
 	u32 currframe;
 	/* void pointers to arrays of struct can[fd]_frame */
@@ -774,10 +775,37 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 	} else {
 		if (!can_is_can_skb(skb))
 			return;
 	}
 
+	/* An ANYDEV op with an active RX timeout and/or throttle timer
+	 * tracks a single source interface: claim the first interface that
+	 * delivers a matching frame and reject frames from any other one,
+	 * before hrtimer_cancel() below can touch op->timer - this avoids
+	 * racing bcm_rx_timeout_handler() across concurrent interfaces.
+	 * RX_RTR_FRAME ops are excluded, as kt_ival1/kt_ival2 may briefly
+	 * hold a stale value from an earlier non-RTR configuration.
+	 */
+	if (!op->ifindex) {
+		spin_lock_bh(&op->bcm_rx_update_lock);
+
+		if (!(op->flags & RX_RTR_FRAME) &&
+		    (op->kt_ival1 || op->kt_ival2)) {
+			/* don't claim to vanishing interface */
+			if (!op->if_detected &&
+			    READ_ONCE(skb->dev->reg_state) == NETREG_REGISTERED)
+				op->if_detected = skb->dev->ifindex;
+
+			if (op->if_detected != skb->dev->ifindex) {
+				spin_unlock_bh(&op->bcm_rx_update_lock);
+				return;
+			}
+		}
+
+		spin_unlock_bh(&op->bcm_rx_update_lock);
+	}
+
 	/* disable timeout */
 	hrtimer_cancel(&op->timer);
 
 	/* op->flags/op->frames may be updated concurrently by bcm_rx_setup() */
 	spin_lock_bh(&op->bcm_rx_update_lock);
@@ -808,14 +836,13 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 		traffic_flags |= RX_LOCAL;
 		if (skb->sk == op->sk)
 			traffic_flags |= RX_OWN;
 	}
 
-	/* save rx timestamp and originator for recvfrom() under lock.
-	 * For an op subscribed on all interfaces (ifindex == 0)
-	 * bcm_rx_handler() can run concurrently on different CPUs so
-	 * the CAN content and the meta data must be bundled correctly.
+	/* save rx timestamp and originator for recvfrom() under lock: an
+	 * ANYDEV op without an active timer can still run concurrently on
+	 * different CPUs, so content and meta data must be bundled here.
 	 */
 	op->rx_stamp = skb->tstamp;
 	op->rx_ifindex = skb->dev->ifindex;
 
 	if (op->flags & RX_FILTER_ID) {
@@ -1439,10 +1466,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			op->ival1 = msg_head->ival1;
 			op->ival2 = msg_head->ival2;
 			op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
 			op->kt_ival2 = bcm_timeval_to_ktime(msg_head->ival2);
 			op->kt_lastmsg = 0;
+			op->if_detected = 0; /* reclaim ifindex in ANYDEV mode */
 			spin_unlock_bh(&op->bcm_rx_update_lock);
 
 			/* disable an active timer due to zero value? */
 			if (!op->kt_ival1)
 				hrtimer_cancel(&op->timer);
@@ -1742,14 +1770,25 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
 
 		/* rx_ops: remove device specific receive entries */
-		list_for_each_entry(op, &bo->rx_ops, list)
+		list_for_each_entry(op, &bo->rx_ops, list) {
 			if (op->rx_reg_dev == dev)
 				bcm_rx_unreg(dev, op);
 
+			/* release an ANYDEV op's claim (see bcm_rx_handler())
+			 * on this now confirmed-gone interface.
+			 */
+			if (!op->ifindex) {
+				spin_lock_bh(&op->bcm_rx_update_lock);
+				if (op->if_detected == dev->ifindex)
+					op->if_detected = 0;
+				spin_unlock_bh(&op->bcm_rx_update_lock);
+			}
+		}
+
 		/* tx_ops: stop device specific cyclic transmissions on the
 		 * vanishing ifindex. Cancelling the timer is enough to stop
 		 * cyclic bcm_can_tx() calls as there is no re-arming.
 		 */
 		list_for_each_entry(op, &bo->tx_ops, list)

-- 
2.53.0



