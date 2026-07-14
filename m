Return-Path: <linux-can+bounces-8406-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IAaUBdcdVmqCzQAAu9opvQ
	(envelope-from <linux-can+bounces-8406-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 13:30:31 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8377753E68
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 13:30:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=NxxLaQcZ;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8406-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8406-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 425863009CD8
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 11:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD87A36165F;
	Tue, 14 Jul 2026 11:30:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7F735C1BD
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 11:30:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028625; cv=none; b=KAxQEVTQbgWv9pttP+HLOh6kMxpB8CsjtAEMKtZ24ZwBZNhtEhkS85lYCL8Dk5sq/UP0Wnt4Y3KR5MFiC9tuvMvB4cwRL1/blhRIfh1eLdhQjHeC5pe9a9Sj6AZvErzBk3yZKJJWC3ET7s/Ivs86FKpphJ7UH3ctPQ/WWaELSNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028625; c=relaxed/simple;
	bh=UcDE3x5gWXeUFnj/AVaTzbDJenaSK64nhsszwhqQbKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WI01pfVUxN56oCX7K7V1DNvGe9+uN48e4vOieSTeC78mCvP12lbK6ZCwnCV3AQwLcB0wWbzGeU+FFIcyaJqzAWor96YrVSSGay8EDYPDIIWxHKJeZSUkwoW0EaNKQQHOOp08aIxnBvm26U9I9IZvPTrEE4Cmoz9tFctX7UJUrYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxxLaQcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 848A3C2BCC9;
	Tue, 14 Jul 2026 11:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784028625;
	bh=UcDE3x5gWXeUFnj/AVaTzbDJenaSK64nhsszwhqQbKw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NxxLaQcZIEQEWH3vKB/vQe+oAnt2htKx5NJvVkcMjYhFRUk8nQkRP+h72FK2JkmOR
	 lmIoEU+IO0+puA1zB0iEFm9NFYTX+TcYBNjnWwV/bY+813/kmmnw5Caa5JuKJkTrca
	 j5YVnuUWmJv7VpjRjnnDC14av+cuO5HgRVbktpO3and/mRbIm80o0ZJwmaxOfB1GL2
	 Q4Yq8BoEQEYwmX+ztASrEpLwmLttsVwruG5xdmWXQqz2WP6+BlkPfxMa7zQTJsClKp
	 dQW9mu8QW9/2xZK/XlmU8Svh6uCqXLbhecvNc/LjMXGcc98JOiHTlgeROGH1n6GWcP
	 dvo4lBpgKzbqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A9FC44501;
	Tue, 14 Jul 2026 11:30:25 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Tue, 14 Jul 2026 13:30:28 +0200
Subject: [PATCH v14 07/11] can: bcm: validate frame length in
 bcm_rx_setup() for RTR replies
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-bcm_fixes-v14-7-867a4be60a61@hartkopp.net>
References: <20260714-bcm_fixes-v14-0-867a4be60a61@hartkopp.net>
In-Reply-To: <20260714-bcm_fixes-v14-0-867a4be60a61@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784028623; l=3930;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=BmTR1mk3C176rdTwV642OI0T9LTbvM9bkInzG2RYjf8=;
 b=TivIfrSf4RjcAqK2VC97r6ZXlsJMSaBmjE3EvHx1c7PT6knBFevatAYRUFSYaSoOtindmwnas
 yt+6Wjb5XDWCL2QP6FCKpuBb3TkpDLEk69F+YtQhivU31Z0x99pDzuy
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
	TAGGED_FROM(0.00)[bounces-8406-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:mid,hartkopp.net:email,hartkopp.net:replyto,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8377753E68

From: Oliver Hartkopp <socketcan@hartkopp.net>

bcm_tx_setup() validates cf->len against the CAN/CAN FD DLC limits
before installing frames for TX_SETUP, but bcm_rx_setup() never did
the same for the RTR-reply frame configured via RX_SETUP with
RX_RTR_FRAME.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 59 +++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index d5ca5ca472f1..e2f8c54b2546 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1236,26 +1236,41 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		kfree(op->frames);
 	kfree(op);
 	return err;
 }
 
-static void bcm_rx_setup_rtr_check(struct bcm_msg_head *msg_head,
-				   struct bcm_op *op, void *new_frames)
+static int bcm_rx_setup_rtr_check(struct bcm_msg_head *msg_head,
+				  struct bcm_op *op, void *new_frames)
 {
+	struct canfd_frame *frame0 = new_frames;
+
+	if (!(msg_head->flags & RX_RTR_FRAME))
+		return 0;
+
+	/* this frame is sent out as-is by bcm_can_tx() whenever a matching
+	 * remote request is received, so validate its length the same way
+	 * bcm_tx_setup() validates TX_SETUP frames before installing it
+	 */
+	if (msg_head->flags & CAN_FD_FRAME) {
+		if (frame0->len > 64)
+			return -EINVAL;
+	} else {
+		if (frame0->len > 8)
+			return -EINVAL;
+	}
+
 	/* funny feature in RX(!)_SETUP only for RTR-mode:
 	 * copy can_id into frame BUT without RTR-flag to
 	 * prevent a full-load-loopback-test ... ;-]
 	 * normalize this on the staged buffer, before it is
 	 * ever installed into op->frames.
 	 */
-	if (msg_head->flags & RX_RTR_FRAME) {
-		struct canfd_frame *frame0 = new_frames;
+	if ((msg_head->flags & TX_CP_CAN_ID) ||
+	    frame0->can_id == op->can_id)
+		frame0->can_id = op->can_id & ~CAN_RTR_FLAG;
 
-		if ((msg_head->flags & TX_CP_CAN_ID) ||
-		    frame0->can_id == op->can_id)
-			frame0->can_id = op->can_id & ~CAN_RTR_FLAG;
-	}
+	return 0;
 }
 
 /*
  * bcm_rx_setup - create or update a bcm rx op (for bcm_sendmsg)
  */
@@ -1314,11 +1329,15 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			if (err < 0) {
 				kfree(new_frames);
 				return err;
 			}
 
-			bcm_rx_setup_rtr_check(msg_head, op, new_frames);
+			err = bcm_rx_setup_rtr_check(msg_head, op, new_frames);
+			if (err < 0) {
+				kfree(new_frames);
+				return err;
+			}
 		}
 
 		spin_lock_bh(&op->bcm_rx_update_lock);
 		op->nframes = msg_head->nframes;
 		op->flags = msg_head->flags;
@@ -1379,20 +1398,16 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		}
 
 		if (msg_head->nframes) {
 			err = memcpy_from_msg(op->frames, msg,
 					      msg_head->nframes * op->cfsiz);
-			if (err < 0) {
-				if (op->frames != &op->sframe)
-					kfree(op->frames);
-				if (op->last_frames != &op->last_sframe)
-					kfree(op->last_frames);
-				kfree(op);
-				return err;
-			}
+			if (err < 0)
+				goto free_op;
 
-			bcm_rx_setup_rtr_check(msg_head, op, op->frames);
+			err = bcm_rx_setup_rtr_check(msg_head, op, op->frames);
+			if (err < 0)
+				goto free_op;
 		}
 
 		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
 		op->sk = sk;
 		sock_hold(sk);
@@ -1485,10 +1500,18 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		/* add this bcm_op to the list of the rx_ops */
 		list_add_rcu(&op->list, &bo->rx_ops);
 	}
 
 	return msg_head->nframes * op->cfsiz + MHSIZ;
+
+free_op:
+	if (op->frames != &op->sframe)
+		kfree(op->frames);
+	if (op->last_frames != &op->last_sframe)
+		kfree(op->last_frames);
+	kfree(op);
+	return err;
 }
 
 /*
  * bcm_tx_send - send a single CAN frame to the CAN interface (for bcm_sendmsg)
  */

-- 
2.53.0



