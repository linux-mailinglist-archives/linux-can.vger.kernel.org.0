Return-Path: <linux-can+bounces-6451-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CE/jOE5kf2lNpgIAu9opvQ
	(envelope-from <linux-can+bounces-6451-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 01 Feb 2026 15:33:50 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F35E4C626B
	for <lists+linux-can@lfdr.de>; Sun, 01 Feb 2026 15:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9D2D3001048
	for <lists+linux-can@lfdr.de>; Sun,  1 Feb 2026 14:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64304350D7E;
	Sun,  1 Feb 2026 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIv6ORl7"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ECC350A3D;
	Sun,  1 Feb 2026 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769956421; cv=none; b=M5rLhdydG8ZHhwKXUoSqGMOyuePQ1hWnYMwpszYv9WzM3tb+J2q97exE8PAArL4el0uawHuMeydY+AJuEK0zQMNtI2JsFP7JqCBq0R9pmBhFKVScASjMGOe+iqDUr8q0jqXTFPrwqKIDqeHzW5ep3Fisql95pKAeTvCnf4ZwXYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769956421; c=relaxed/simple;
	bh=SBs/C150pguj/vCEZlWhOTRKiUV8IQgb9NQzwVbQ8vI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fydjZuj39ghUx+4Wf2OTWhoIi4GYy6VDoh9/LfUwcmaXbV3maLFvfoI8JcR6ntDqcWqKym2plAAPddcN+1Eh77+Iw5nsAcKN7ZrHNmoD7s8CVEPvBPmqFR0AkYPF5HPKhy/dQ5qDpdAPUlLuNwWavDU7prU/zcoNF8fvNjbhck8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIv6ORl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B418C116C6;
	Sun,  1 Feb 2026 14:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769956421;
	bh=SBs/C150pguj/vCEZlWhOTRKiUV8IQgb9NQzwVbQ8vI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QIv6ORl7m6UuDf8UJQdA3OqxD9uB7GngmKIcFpqEzLWvg57YX1O5Ipb7VusMA9yox
	 8WN1FfGSSIy/nz6I1yk9UHl61Cq2ppFcVqviwkcKOcyprHiidBKtlT1fMqD8M30rYD
	 yjSx3Gm8X+3UglAeHgOvxPWlMZ6+/Zaz2SoV25boWb50ODQn165rcluQYgE9F4VlhZ
	 6EU/fPlSgNXI4ncvqrOjZHWzW8n2OjDWcT00AstDw+CyTjmHyyFrIlEcg3uUtCFrNX
	 mTf4vTRJSLP71X6vXkMYroIYzuYeNYHG6dC7yAm4A5TWGdoNUsLrq2SsqKLrsIrVVa
	 pGjEM7eEcuMZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06D8E6528B;
	Sun,  1 Feb 2026 14:33:40 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Sun, 01 Feb 2026 15:33:19 +0100
Subject: [PATCH net-next v8 4/6] can: move frame_len to CAN skb extensions
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260201-can_skb_ext-v8-4-3635d790fe8b@hartkopp.net>
References: <20260201-can_skb_ext-v8-0-3635d790fe8b@hartkopp.net>
In-Reply-To: <20260201-can_skb_ext-v8-0-3635d790fe8b@hartkopp.net>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769956418; l=3158;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=ArF50dGFLTJeKrJinhCvEu9UmJPwPrODNYHzRcVUyg0=;
 b=TIdS5g/KZ3Ligx58NhDD26OUNNDD87+SjOwjneW+1wx7RSHTgcj1vA2DXSWTXQmYaQD6iZ6ak
 jcyoEhl1PUZCB+zrTDR07D17kT6rdTBSlL90Wo47yPRxmKzloMxVwQQ
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6451-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: F35E4C626B
X-Rspamd-Action: no action

From: Oliver Hartkopp <socketcan@hartkopp.net>

The can_skb_priv::frame_len variable is used to cache a previous
calculated CAN frame length to be passed to BQL queueing disciplines.

Move the can_skb_priv::frame_len content to can_skb_ext::can_framelen.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/skb.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 470255fe7367..408ee49abce1 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -47,10 +47,11 @@ void can_flush_echo_skb(struct net_device *dev)
  */
 int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 		     unsigned int idx, unsigned int frame_len)
 {
 	struct can_priv *priv = netdev_priv(dev);
+	struct can_skb_ext *csx;
 
 	if (idx >= priv->echo_skb_max) {
 		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
 			   __func__, idx, priv->echo_skb_max);
 		return -EINVAL;
@@ -73,11 +74,13 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 		/* make settings for echo to reduce code in irq context */
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 		skb->dev = dev;
 
 		/* save frame_len to reuse it when transmission is completed */
-		can_skb_prv(skb)->frame_len = frame_len;
+		csx = can_skb_ext_find(skb);
+		if (csx)
+			csx->can_framelen = frame_len;
 
 		if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 
 		skb_tx_timestamp(skb);
@@ -110,20 +113,25 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx,
 	if (priv->echo_skb[idx]) {
 		/* Using "struct canfd_frame::len" for the frame
 		 * length is supported on both CAN and CANFD frames.
 		 */
 		struct sk_buff *skb = priv->echo_skb[idx];
-		struct can_skb_priv *can_skb_priv = can_skb_prv(skb);
+		struct can_skb_ext *csx;
 
 		if (skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS)
 			skb_tstamp_tx(skb, skb_hwtstamps(skb));
 
 		/* get the real payload length for netdev statistics */
 		*len_ptr = can_skb_get_data_len(skb);
 
-		if (frame_len_ptr)
-			*frame_len_ptr = can_skb_priv->frame_len;
+		if (frame_len_ptr) {
+			csx = can_skb_ext_find(skb);
+			if (csx)
+				*frame_len_ptr = csx->can_framelen;
+			else
+				*frame_len_ptr = 0;
+		}
 
 		priv->echo_skb[idx] = NULL;
 
 		if (skb->pkt_type == PACKET_LOOPBACK) {
 			skb->pkt_type = PACKET_BROADCAST;
@@ -179,14 +187,19 @@ void can_free_echo_skb(struct net_device *dev, unsigned int idx,
 		return;
 	}
 
 	if (priv->echo_skb[idx]) {
 		struct sk_buff *skb = priv->echo_skb[idx];
-		struct can_skb_priv *can_skb_priv = can_skb_prv(skb);
-
-		if (frame_len_ptr)
-			*frame_len_ptr = can_skb_priv->frame_len;
+		struct can_skb_ext *csx;
+
+		if (frame_len_ptr) {
+			csx = can_skb_ext_find(skb);
+			if (csx)
+				*frame_len_ptr = csx->can_framelen;
+			else
+				*frame_len_ptr = 0;
+		}
 
 		dev_kfree_skb_any(skb);
 		priv->echo_skb[idx] = NULL;
 	}
 }

-- 
2.51.0



