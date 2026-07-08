Return-Path: <linux-can+bounces-8118-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mtvlIY0YTmp/DAIAu9opvQ
	(envelope-from <linux-can+bounces-8118-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 11:29:49 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC4E723BC9
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 11:29:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=Af+ONG3Q;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8118-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8118-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDDEC3025C69
	for <lists+linux-can@lfdr.de>; Wed,  8 Jul 2026 09:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EF3407CD3;
	Wed,  8 Jul 2026 09:22:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11BE409610
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 09:22:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502570; cv=none; b=OXJIfddSzLKrcyeQqv1DEhx9yHn60WmdO/p+vA+kIczwYHtysVFOVLVVDqydApgu53DcNBEDiDnXXqZzMk4fAndLkfK95pPmuKNXqXDoGRmELiZSyeOt1f/wxMGSBPHvQiXpgP+8kNvJ9KJelbAfJVVD2SjKVMOi31j7DV2XEHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502570; c=relaxed/simple;
	bh=MuYUid1xVvQoJLvSFmjm5oh3fievMVOo3NepEzJmtZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z2wSnQAxV1JT63aVOG3ixzsdJlQOlKef2Qv7acvVpsw5cMk/4YoYiaA7FAjZ4MBS1/9TxnvPJV7JFh0IE4tAluHqGW2oT6P4aaNTcWQFr0sZTbPPaHRxtl+69LCRqmWVL5omJU759c+YvHuqikhwvwQYAAe1bjwKn6YMSF2GXkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Af+ONG3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5EA4C2BCFF;
	Wed,  8 Jul 2026 09:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783502569;
	bh=MuYUid1xVvQoJLvSFmjm5oh3fievMVOo3NepEzJmtZ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Af+ONG3QWrt2OP5Yh1FKMJdVnMqAgZ2A3mdsAF/D4MVSJc9zrlFy2GVE6Ou08KJka
	 rEaI9jGTYV1Zbngv2gMAZ1wLqDUKiKyLQCfyDRZrjVE7gRzUVk/J0ZnD1yQMpjmdBd
	 ba+TtuWCniN1OADjSnfIn4x9powMKDkUG2mD4csQiyOOhWG2iQGkU/Rs2xQddOyfDM
	 tXGzDmXEXBpXSiLCP6JTMRF7msoUkSS31CvTOlDkmrCK+Tt3y+PqLw0rwV5mXkGHhC
	 5XV1Wp0M/7OWzoZQyV+9eKOHZck1zk071BelDgEnjR7HYt9Tf8MSRa4s0CozHIiENF
	 PnNO7Fn2iONUw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B540EC44501;
	Wed,  8 Jul 2026 09:22:49 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Wed, 08 Jul 2026 11:22:34 +0200
Subject: [PATCH v6 8/9] can: bcm: add missing device refcount for CAN
 filter removal
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-bcm_fixes-v6-8-80710a2bc398@hartkopp.net>
References: <20260708-bcm_fixes-v6-0-80710a2bc398@hartkopp.net>
In-Reply-To: <20260708-bcm_fixes-v6-0-80710a2bc398@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783502567; l=4807;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=e+4060p0TLpVYJANRm8fMWWwjGdEnSDV8K40Qsp0eoQ=;
 b=v0Nq4/Dr4arnjHnil8Kh71ebsUhv5sgO5F5Einp93pmnOnMOLeauin5SaCGRJwdb/ftKn+2Y6
 0XPdMZ14s8tDNszbcWzALi6eC9sCbPcUaaKtJADymDAnxxFTrOxPvyA
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8118-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,hartkopp.net:replyto,hartkopp.net:mid,hartkopp.net:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AC4E723BC9

From: Oliver Hartkopp <socketcan@hartkopp.net>

sashiko-bot remarked a problem with a concurrent device unregistration
in isotp.c which also is present in the bcm.c code. A former fix for raw.c
commit c275a176e4b6 ("can: raw: add missing refcount for memory leak fix")
introduced a netdevice_tracker which solves the issue for bcm.c too.

bcm_release(), bcm_delete_rx_op() and bcm_notifier() relied on
dev_get_by_index(ifindex) to re-find the device for an rx_op before
unregistering its filter. If a concurrent NETDEV_UNREGISTER has already
unlisted the device from the ifindex table, that lookup fails and
can_rx_unregister() is silently skipped, leaving a stale CAN filter
pointing at the soon-to-be-freed bcm_op/socket.

Hold a netdev_hold()/netdev_put() tracked reference on op->rx_reg_dev
from the moment the rx filter is registered in bcm_rx_setup() until it
is unregistered in bcm_rx_unreg(), and use that reference directly in
bcm_release() and bcm_delete_rx_op() instead of re-looking the device
up by ifindex.

Reported-by: sashiko-bot@kernel.org
Link: https://sashiko.dev/#/patchset/20260707094716.63578-1-socketcan@hartkopp.net
Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 300f1f88c4d2..4bdca72f9327 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -126,10 +126,11 @@ struct bcm_op {
 	void *last_frames;
 	struct canfd_frame sframe;
 	struct canfd_frame last_sframe;
 	struct sock *sk;
 	struct net_device *rx_reg_dev;
+	netdevice_tracker rx_reg_dev_tracker;
 	spinlock_t bcm_tx_lock; /* protect tx data and timer updates */
 	spinlock_t bcm_rx_update_lock; /* protect filter/timer data updates */
 };
 
 struct bcm_sock {
@@ -904,10 +905,11 @@ static void bcm_rx_unreg(struct net_device *dev, struct bcm_op *op)
 		can_rx_unregister(dev_net(dev), dev, op->can_id,
 				  REGMASK(op->can_id), bcm_rx_handler, op);
 
 		/* mark as removed subscription */
 		op->rx_reg_dev = NULL;
+		netdev_put(dev, &op->rx_reg_dev_tracker);
 	} else
 		printk(KERN_ERR "can-bcm: bcm_rx_unreg: registered device "
 		       "mismatch %p %p\n", op->rx_reg_dev, dev);
 }
 
@@ -934,21 +936,18 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
 			if (op->ifindex) {
 				/*
 				 * Only remove subscriptions that had not
 				 * been removed due to NETDEV_UNREGISTER
 				 * in bcm_notifier()
+				 *
+				 * op->rx_reg_dev is a tracked reference taken
+				 * when the subscription was registered, so it
+				 * stays valid here even if a concurrent
+				 * NETDEV_UNREGISTER already unlisted the dev.
 				 */
-				if (op->rx_reg_dev) {
-					struct net_device *dev;
-
-					dev = dev_get_by_index(sock_net(op->sk),
-							       op->ifindex);
-					if (dev) {
-						bcm_rx_unreg(dev, op);
-						dev_put(dev);
-					}
-				}
+				if (op->rx_reg_dev)
+					bcm_rx_unreg(op->rx_reg_dev, op);
 			} else
 				can_rx_unregister(sock_net(op->sk), NULL,
 						  op->can_id,
 						  REGMASK(op->can_id),
 						  bcm_rx_handler, op);
@@ -1453,11 +1452,21 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 						      op->can_id,
 						      REGMASK(op->can_id),
 						      bcm_rx_handler, op,
 						      "bcm", sk);
 
-				op->rx_reg_dev = dev;
+				/* keep a tracked reference so that a later
+				 * unregister can safely reach the device even
+				 * if a concurrent NETDEV_UNREGISTER has
+				 * already unlisted it by ifindex
+				 */
+				if (!err) {
+					op->rx_reg_dev = dev;
+					netdev_hold(dev,
+						    &op->rx_reg_dev_tracker,
+						    GFP_KERNEL);
+				}
 				dev_put(dev);
 			} else {
 				/* the requested device is gone - do not
 				 * silently succeed without registering
 				 */
@@ -1830,20 +1839,18 @@ static int bcm_release(struct socket *sock)
 		if (op->ifindex) {
 			/*
 			 * Only remove subscriptions that had not
 			 * been removed due to NETDEV_UNREGISTER
 			 * in bcm_notifier()
+			 *
+			 * op->rx_reg_dev is a tracked reference taken
+			 * when the subscription was registered, so it
+			 * stays valid here even if a concurrent
+			 * NETDEV_UNREGISTER already unlisted the device.
 			 */
-			if (op->rx_reg_dev) {
-				struct net_device *dev;
-
-				dev = dev_get_by_index(net, op->ifindex);
-				if (dev) {
-					bcm_rx_unreg(dev, op);
-					dev_put(dev);
-				}
-			}
+			if (op->rx_reg_dev)
+				bcm_rx_unreg(op->rx_reg_dev, op);
 		} else
 			can_rx_unregister(net, NULL, op->can_id,
 					  REGMASK(op->can_id),
 					  bcm_rx_handler, op);
 

-- 
2.53.0



