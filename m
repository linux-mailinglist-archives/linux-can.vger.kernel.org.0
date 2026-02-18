Return-Path: <linux-can+bounces-6584-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMOOBFWblWmsSgIAu9opvQ
	(envelope-from <linux-can+bounces-6584-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Feb 2026 11:58:29 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF72155B6F
	for <lists+linux-can@lfdr.de>; Wed, 18 Feb 2026 11:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 737033017274
	for <lists+linux-can@lfdr.de>; Wed, 18 Feb 2026 10:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BCF30148D;
	Wed, 18 Feb 2026 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLRJ3CLx"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBDC27713;
	Wed, 18 Feb 2026 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771412304; cv=none; b=qVAG7AAvKz18gBS5m7Bixzk82l8znbO8OIi6NP3M/TA+UjogxGYLk5Rj6qWj/dwPTC1WVVOmU1hxiReXdAexxsOZA/m7OmqSuf5P4eZea9c3ftezdpGmBE3lrexhtJ0mPeOluS/xqb2r6SjN6TqnSJlVrpBft5Whcq4RB/49fb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771412304; c=relaxed/simple;
	bh=YgcSEXIrZFrF3LfKi9YSAXsAPmV4qkpf0yisl8CTxd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=exqlZV3rTKsvtseGQ6fb9JB5KK15ETiwWx34MvKM7n5ClA1hKxJM5l0Dg04Ks0qEcACsUnhng9omyY/ehiiR9ZLDvhzePuHWxrK16+hsyTg1DIoUDUsKu6/lPxv/fpLIPZXEdVqECgTsB4o9KAoERTLApTYCcK4VVu+6rvdSKmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLRJ3CLx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FF5CC19421;
	Wed, 18 Feb 2026 10:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771412304;
	bh=YgcSEXIrZFrF3LfKi9YSAXsAPmV4qkpf0yisl8CTxd4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=bLRJ3CLxE80mnJA1ZAaZJeoYJVTUpAKTng/ZgkQWPQy7fImONf1UplasNwq+cHfhn
	 FQSGP3B7lzOv3Hju0XBuMA/8H6wS5hjcJ2HOL+3HgAuxAwGxWstnx5dKNLLRUnNSew
	 50ArXkFjc8yhebnhAuzsGc2XwPAXjNxoB1IrEQpC0mOTL5NQHv0sRCpCMg30mK5kGJ
	 CCyCZ6KvoGUbZEchUm2fjzo2fTP1ZPO/dyAawiEjDiQcsnIdem9m9kCSQm7Zoi4Vzy
	 3t+tLYeNQXf2jJePiiqPbI4rvdOFOmTzhF1ebrlm8uSTcTSBX1R8NU7Njfwni4xXQ0
	 XB0Jqy9Gp4o9Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C85AE9A047;
	Wed, 18 Feb 2026 10:58:24 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Wed, 18 Feb 2026 11:58:06 +0100
Subject: [PATCH] can: bcm: fix locking for bcm_op runtime updates
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-bcm_spin_lock_init-v1-1-592634c8a5b5@hartkopp.net>
X-B4-Tracking: v=1; b=H4sIAD2blWkC/yXMTQqDMBBA4avIrA0kQUvwKiLBxGk7/kTJqAji3
 Rvt8lu8dwJjJGSoshMi7sQ0hwSVZ+C/bfigoC4ZtNQvqZURzk+WFwp2nP1gKdAqdKkMOtMVpVS
 QwiXim45nWjd/8+Z69Ot9guv6Ad2nx7V2AAAA
X-Change-ID: 20260218-bcm_spin_lock_init-2518eb8d4501
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+5b11eccc403dd1cea9f8@syzkaller.appspotmail.com, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771412303; l=1718;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=6cstQeyQgLIl4DE3G5AH+ISHLnxDQyJA9yrO83rD9qM=;
 b=tzCSZ60jq1WYEiVxpsmi1veCfJ/CplHayT7UuuFYty2KctMTPN3SsgsNyWsGXU8QNIF34qsJx
 fi821KxQBL2BlennaF+hUqmROr0q+v2Nrmb65iftXKlH5XEiy9Ydpte
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6584-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can,5b11eccc403dd1cea9f8];
	RCPT_COUNT_FIVE(0.00)[5];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net]
X-Rspamd-Queue-Id: 7DF72155B6F
X-Rspamd-Action: no action

From: Oliver Hartkopp <socketcan@hartkopp.net>

Commit c2aba69d0c36 ("can: bcm: add locking for bcm_op runtime updates")
added a locking for some variables that can be modified at runtime when
updating the sending bcm_op with a new TX_SETUP command in bcm_tx_setup().

Usually the RX_SETUP only handles and filters incoming traffic with one
exception: When the RX_RTR_FRAME flag is set a predefined CAN frame is
sent when a specific RTR frame is received. Therefore the rx bcm_op uses
bcm_can_tx() which uses the bcm_tx_lock that was only initialized in
bcm_tx_setup(). Add the missing spin_lock_init() when allocating the
bcm_op in bcm_rx_setup() to handle the RTR case properly.

Fixes: c2aba69d0c36 ("can: bcm: add locking for bcm_op runtime updates")
Reported-by: syzbot+5b11eccc403dd1cea9f8@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-can/699466e4.a70a0220.2c38d7.00ff.GAE@google.com/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index b7324e9c955b..fd9fa072881e 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1174,10 +1174,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		/* insert new BCM operation for the given can_id */
 		op = kzalloc(OPSIZ, GFP_KERNEL);
 		if (!op)
 			return -ENOMEM;
 
+		spin_lock_init(&op->bcm_tx_lock);
 		op->can_id = msg_head->can_id;
 		op->nframes = msg_head->nframes;
 		op->cfsiz = CFSIZ(msg_head->flags);
 		op->flags = msg_head->flags;
 

---
base-commit: 2961f841b025fb234860bac26dfb7fa7cb0fb122
change-id: 20260218-bcm_spin_lock_init-2518eb8d4501

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>



