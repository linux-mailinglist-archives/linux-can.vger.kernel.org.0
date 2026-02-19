Return-Path: <linux-can+bounces-6598-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBsZKLQ/l2lXwAIAu9opvQ
	(envelope-from <linux-can+bounces-6598-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 17:52:04 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D04160CF6
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 17:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A4983008461
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 16:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3356534CFD1;
	Thu, 19 Feb 2026 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFkRFBw6"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B5134CFB7;
	Thu, 19 Feb 2026 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771519909; cv=none; b=T2TI4eTNDABW5727ntw8VeFzheE0uwK3QYbwEwW1XzYpn9J6l794UsCd/r3Xc4ygtSVUAO7uSibel1Ng32K9pcvYNAlLcC2R2R3hM6YlElvbW19MGbYUnO8HhDX2nYpm2ZxWqB9gZnPDxxpIrJjcrn7ko5asqN+67DJ6LtVgyW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771519909; c=relaxed/simple;
	bh=Uk2s+vOYK5R2mgNSWbZlvpy2x63Rk1TzbDHp24TGokg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HXsJa16BGIno3GWtOsyhpVyeNvh4n0tqAgi6rDfDd/K/s6OMWaAe0YayzcjyVv5kBzjWT100jCXy62dfv6wdWbAMN1dX6cnYqxWRAIf497uzIf/AayqBzjQNC1FbcwW8JkfEZzl+mb2HmGI71w2PZT4h2jbUqg7m+vpLik6Cv58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFkRFBw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD68EC2BC86;
	Thu, 19 Feb 2026 16:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771519908;
	bh=Uk2s+vOYK5R2mgNSWbZlvpy2x63Rk1TzbDHp24TGokg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DFkRFBw6l55/GlYG6JDk22DmNWf6NVPgVWn10YAc19Nv1eUGiStiznbF58+R0z8Nt
	 U9iVbdT1HmBdUbfUE84ZAThM9c8aAe9UTV3KBb9ckRURuvuxuJhavbwmEpeeUkypPs
	 +O0anVh4EWgaFRcxN1oN9/KG/kzwkEYgC/3WQLfBGbGrEbDW6FcfBWjqlhLNO9Gqz4
	 m6FA3Ht9DtP1x0Pn2MLakDZUdjd1x+4ubdpTVpa+/lWQkB4rq8WUtcSdAlsVJ1LJsA
	 0rBk3xQ0w2nO3b6jb7rW06X6MHAfvYS4EWFN+bdE3N0iiAoZtaL6WXfYLM4v0hwZKu
	 SZzZLDJ6t5/iQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C271AE9A04E;
	Thu, 19 Feb 2026 16:51:48 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Thu, 19 Feb 2026 17:51:19 +0100
Subject: [PATCH v3 3/3] can: statistics: add missing atomic access in hot
 path
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-bcm_spin_lock_init-v3-3-c61026740d7b@hartkopp.net>
References: <20260219-bcm_spin_lock_init-v3-0-c61026740d7b@hartkopp.net>
In-Reply-To: <20260219-bcm_spin_lock_init-v3-0-c61026740d7b@hartkopp.net>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Urs Thuermann <urs.thuermann@volkswagen.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771519907; l=1840;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=ce7R8+1V1nd+aDx9P0nYxydlLO4gPk56OeKnN14t8O4=;
 b=NI/Zlcw/wCHgSJq9WwYK+uKaDdwN14qJIYw5kqLk0kNHqzTrxm8XvQKSCjFB8zJ9covPS5WHC
 /sU+xTvn5moD1gQqVmrLSWS5mb+oet2z7PmhEIxmXoJ/bW+RIrhnnpP
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Endpoint-Received: by B4 Relay for socketcan@hartkopp.net/20260128 with
 auth_id=620
X-Original-From: Oliver Hartkopp <socketcan@hartkopp.net>
Reply-To: socketcan@hartkopp.net
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6598-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[7];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:mid,hartkopp.net:email,hartkopp.net:replyto,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1D04160CF6
X-Rspamd-Action: no action

From: Oliver Hartkopp <socketcan@hartkopp.net>

Commit 80b5f90158d1 ("can: statistics: use atomic access in hot path")
fixed a KCSAN issue in can_receive() but missed to convert the 'matches'
variable used in can_rcv_filter().

Fixes: 80b5f90158d1 ("can: statistics: use atomic access in hot path")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/af_can.c | 4 ++--
 net/can/af_can.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 22c65a014861..31a5eab3fab3 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -467,11 +467,11 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
 	rcv_list = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
 
 	rcv->can_id = can_id;
 	rcv->mask = mask;
-	rcv->matches = 0;
+	atomic_long_set(&rcv->matches, 0);
 	rcv->func = func;
 	rcv->data = data;
 	rcv->ident = ident;
 	rcv->sk = sk;
 
@@ -571,11 +571,11 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 EXPORT_SYMBOL(can_rx_unregister);
 
 static inline void deliver(struct sk_buff *skb, struct receiver *rcv)
 {
 	rcv->func(skb, rcv->data);
-	rcv->matches++;
+	atomic_long_inc(&rcv->matches);
 }
 
 static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buff *skb)
 {
 	struct receiver *rcv;
diff --git a/net/can/af_can.h b/net/can/af_can.h
index 22f3352c77fe..87887014f562 100644
--- a/net/can/af_can.h
+++ b/net/can/af_can.h
@@ -50,11 +50,11 @@
 
 struct receiver {
 	struct hlist_node list;
 	canid_t can_id;
 	canid_t mask;
-	unsigned long matches;
+	atomic_long_t matches;
 	void (*func)(struct sk_buff *skb, void *data);
 	void *data;
 	char *ident;
 	struct sock *sk;
 	struct rcu_head rcu;

-- 
2.51.0



