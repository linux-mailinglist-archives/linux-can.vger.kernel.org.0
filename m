Return-Path: <linux-can+bounces-6589-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EHMDWwGl2kWtwIAu9opvQ
	(envelope-from <linux-can+bounces-6589-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 13:47:40 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC09815EADB
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 13:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 085A63028803
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 12:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9D6339870;
	Thu, 19 Feb 2026 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqDERcrc"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCFF334373;
	Thu, 19 Feb 2026 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771505256; cv=none; b=IN0lTNDuENqExq0lHBqzmsFcfPskaMMgnbsTqiYOGHcvS+PIBoQFv4xrN+rcj5AD0PFi4wlfIJrq9kvShUZk3ZGTaJ1jXmGjGB3/o24VZ6mRWe2FH1AkH1laQDd08JfuSuXAavGqsNJx6DDOF6MiIhS8J8YYgenzvWibAMh0H4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771505256; c=relaxed/simple;
	bh=Ndj7MZu1RYgFXaRQMR5Ww5AM02i+hNiCGZqxPAQvqAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XGUlbfJzZRzq+ijjXUfFQq5qVa/2kEbwDaJ1C/lkNihC7eOjFL7PoCV+bafatj82DDBFZPPGyqO87q6z/oPk/iZnMdWIFkneO8ykUz8A/xx03N3IGvvtV5PI/LWLO49ewtRtKMhru9OYCNLPgQZzGAeviH3p64VlapDvUY7kxAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqDERcrc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9D8BC19423;
	Thu, 19 Feb 2026 12:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771505255;
	bh=Ndj7MZu1RYgFXaRQMR5Ww5AM02i+hNiCGZqxPAQvqAw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WqDERcrc0FYzd/D55jUSdQUW05D/UmahoEmFzJPjNltZU4czHcowLQyRBRStcDzfR
	 +HsYN4zfF6Y62vsGKwmigBhvVHWIWSx79mVT/P9CeFBvbD4N4yKGJbW7+iNk493uBf
	 rxVk8W5f1lpgH6160hnH49SEi/tizBz372p67w/ALZ8OV1qsKoSzR+yXobpGM2xqqr
	 DtqOH3roZdtVXPhnb2toHxEn0LIb4tKVhTF0ekZCkM8oL39uGexX5G5waNLXK4thEH
	 imrPrpxulv1kBH+wAY5SnKwVDOno2/3T3zR+Rd8k5QjN7GMbBNWBelINnC06b+nlul
	 qWZJ4B34lf7Mg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F29E9A048;
	Thu, 19 Feb 2026 12:47:35 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Thu, 19 Feb 2026 13:47:31 +0100
Subject: [PATCH v2 1/2] can: bcm: fix locking for bcm_op runtime updates
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-bcm_spin_lock_init-v2-1-694352bfca62@hartkopp.net>
References: <20260219-bcm_spin_lock_init-v2-0-694352bfca62@hartkopp.net>
In-Reply-To: <20260219-bcm_spin_lock_init-v2-0-694352bfca62@hartkopp.net>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Urs Thuermann <urs.thuermann@volkswagen.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 syzbot+5b11eccc403dd1cea9f8@syzkaller.appspotmail.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771505254; l=1553;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=XQu0DK6j8SlJ077Pj9O4qw1EtV49i3xT6l7+T5PUHaM=;
 b=E5k7ahkcLuD04La9QHnSdaDaGBBREOmrl/6BUT125ocgAwYdag/7dEbI9bPskUma7PIdZk0sl
 dx80MgCRF6zAqLA2vIzal4nSs1Qq8MbSjF79uYElQiiHkdAMo22i/0c
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6589-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
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
	TAGGED_RCPT(0.00)[linux-can,5b11eccc403dd1cea9f8];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hartkopp.net:mid,hartkopp.net:email,hartkopp.net:replyto,appspotmail.com:email]
X-Rspamd-Queue-Id: BC09815EADB
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
 

-- 
2.51.0



