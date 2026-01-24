Return-Path: <linux-can+bounces-6293-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBDwJqA3dWkqCQEAu9opvQ
	(envelope-from <linux-can+bounces-6293-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 24 Jan 2026 22:20:32 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BD37F06F
	for <lists+linux-can@lfdr.de>; Sat, 24 Jan 2026 22:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 512BE3002B6C
	for <lists+linux-can@lfdr.de>; Sat, 24 Jan 2026 21:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEA610F1;
	Sat, 24 Jan 2026 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="U9iS5e+O";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="6qRnUUip"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048D6217722
	for <linux-can@vger.kernel.org>; Sat, 24 Jan 2026 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.217
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769289626; cv=pass; b=DxGx/8xqv6otkM1x4D4mOV+gJ6Od0MRfXerRTFyw19Ej0MxpJujrLGMLNk9OBBMkGBaOy19rRDQedbI1bxCU9SWb3apXeu0jOHMi7HjnBVGPykIxIJISHFF2aJ9Jn9TkDJI8rPZNwqw5KsiCwsRnowmJEiQjc1l8zdQt3kwp47Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769289626; c=relaxed/simple;
	bh=aAhgxlohdOtQjhqj48JabHB76MDQPcdWO6canHEuAvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mMaCR3znqqy6hOE3NvRByG4WOd4O3TSVYgLNP+OlJQxuawurij6lTnIdWxtZxDVI9auvViECoKUk42YCgFgVOaPjXL5zbwseVy4z3PkWligKhXlbgtd769DuOLFResfA4hC6qKpRg/1hXECjwdSSlnzZwgsAm6aMuIcIxdJfkJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=U9iS5e+O; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=6qRnUUip; arc=pass smtp.client-ip=81.169.146.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1769289431; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Rz3gHSJpe2KR8IDL1C0z0MDakOmoMSn3ckIFKCL82AekI77RzeyIf1gBHsEbVXWdwS
    V6BoNTDScL7QJANurX9HMYT5bH6T7kEIQzoFFD6IrlnWqofVy1AN1FSBBo3oXQ8Iq+Pj
    WmWtB4n2DSfk9de/8wTGc6drAPFjlNV+aT4rxTABstf0dfinrP6jpvUG7m04YF6Tlj9O
    xpnrOTE5g1cNGI8mjzPqDf14R6cs7t2l1X1LCTXW0GnunOA7RFtV0GJ6xkckUWwJ7s2C
    PjHHrEPN+w2og9i1Pc4uKJS19e6l4zc285GQVAbqD3o2jOyr0/4xBc0cfIC8IB0g9+BW
    2LXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769289431;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=VlOnmIz6GfXlD7Y0wDFsUE9BCQ5nPgYdBxOA2Thrhs0=;
    b=TGLLJiiU/mUcEtmkCK9Vh82lNOlnUjTkYSNqKJv2o18wJ3gjqhX82Dfzbmf17nWGqV
    /wa3JCUBXAHn+KthwU8opC3pTL38k6A3bcm+8Jjpf91N+6QxXJSl2DSZRmxx7ORpGiGX
    vD++vCssPyhCWNs+J2OoijzQste6MP7WU+HEVdUoEV17Oo8CNJB+CwAiK3PMmqqmrdhQ
    7RXkPywAOsZ1M6Sw7giBL10x62mcv2tf69qWAlbjsrzw0Ke5Y20zlgeuIfJF6NXDOdAK
    Jmdxq7oZG+QGBZ1wrLAB8QAJLDS+QHzZZ3RQJwzTl6n8ikwpWjHQmsE7lsGABF9XzTUc
    ZwHw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769289431;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=VlOnmIz6GfXlD7Y0wDFsUE9BCQ5nPgYdBxOA2Thrhs0=;
    b=U9iS5e+O/ppHzTTwY9pRrKd42oHF7UwHN5k9lvfe3H5tnNciEh594PYUkuqroD+njY
    +ppEEXZuUKkVTdvDVt1l5IJ7evMjEDm58owdXUlD4LWGJFyQlEjk+RI0C9tXp4buW4Ol
    0nKZsAtwxXEaW61VKL380Lz9cCYGiit6U8FMM58eqahi71O/nmTzw7rdV/BcBaRkfbdF
    eGIlwPGgs8B1NcuadrIha8qHn0r80+mjU4LP9sud7l9wjJRIPUMjj3t1BRS8tH+IK6Nz
    ktYP1BaH0uqllWwYZEXscq4969WgWERIEcPYgM3enHkJ6V6jNv4vMBvBcarP2lzKwiIC
    LguQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769289431;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=VlOnmIz6GfXlD7Y0wDFsUE9BCQ5nPgYdBxOA2Thrhs0=;
    b=6qRnUUipBpf1IgWnva1U3KE67jjMjFrBpIFZnHI8fMEFUrOFK1vaYK/HOUMeORX9hp
    iUxrcrjGB4lDz2szXeCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7tnMDLztswwlyqon4XDpA0w0c7HaA=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20OLHBX1C
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 24 Jan 2026 22:17:11 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH] dummy_can: fix packet statistics
Date: Sat, 24 Jan 2026 22:17:04 +0100
Message-ID: <20260124211704.16430-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6293-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86BD37F06F
X-Rspamd-Action: no action

The former implementation was only counting the tx_packets value.
Adopt the skb handling from vcan.c to correctly count the statistics
and fix the packet flow for looped packets.
The CAN echo support (IFF_ECHO) is enabled in dummy_can_init() to provide
a more realistic behaviour of real CAN hardware interfaces.

Fixes: 816cf430e84b ("can: add dummy_can driver")
Cc: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dummy_can.c | 50 ++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/dummy_can.c b/drivers/net/can/dummy_can.c
index 41953655e3d3..a77f5fc5cfda 100644
--- a/drivers/net/can/dummy_can.c
+++ b/drivers/net/can/dummy_can.c
@@ -207,17 +207,60 @@ static int dummy_can_netdev_close(struct net_device *dev)
 }
 
 static netdev_tx_t dummy_can_start_xmit(struct sk_buff *skb,
 					struct net_device *dev)
 {
+	struct net_device_stats *stats = &dev->stats;
+	unsigned int len;
+	bool loop;
+
 	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
 
-	can_put_echo_skb(skb, dev, 0, 0);
-	dev->stats.tx_packets++;
-	dev->stats.tx_bytes += can_get_echo_skb(dev, 0, NULL);
+	len = can_skb_get_data_len(skb);
+	stats->tx_packets++;
+	stats->tx_bytes += len;
+
+	/* set flag whether this packet has to be looped back */
+	loop = skb->pkt_type == PACKET_LOOPBACK;
+
+	skb_tx_timestamp(skb);
+
+	/* driver supports echo handling - see dummy_can_init() */
+	if (!(dev->flags & IFF_ECHO)) {
+		/* no echo handling available inside this driver */
+		if (loop) {
+			/* only count the packets here, because the
+			 * CAN core already did the echo for us
+			 */
+			stats->rx_packets++;
+			stats->rx_bytes += len;
+		}
+		consume_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
+	/* perform standard echo handling for CAN network interfaces */
+
+	if (loop) {
+		skb = can_create_echo_skb(skb);
+		if (!skb)
+			return NETDEV_TX_OK;
 
+		/* receive with packet counting */
+		stats->rx_packets++;
+		stats->rx_bytes += len;
+
+		skb->pkt_type  = PACKET_BROADCAST;
+		skb->dev       = dev;
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+		netif_rx(skb);
+	} else {
+		/* no looped packets => no counting */
+		consume_skb(skb);
+	}
 	return NETDEV_TX_OK;
 }
 
 static const struct net_device_ops dummy_can_netdev_ops = {
 	.ndo_open = dummy_can_netdev_open,
@@ -239,10 +282,11 @@ static int __init dummy_can_init(void)
 	if (!dev)
 		return -ENOMEM;
 
 	dev->netdev_ops = &dummy_can_netdev_ops;
 	dev->ethtool_ops = &dummy_can_ethtool_ops;
+	dev->flags |= IFF_ECHO; /* enable echo handling */
 	priv = netdev_priv(dev);
 	priv->can.bittiming_const = &dummy_can_bittiming_const;
 	priv->can.bitrate_max = 20 * MEGA /* BPS */;
 	priv->can.clock.freq = 160 * MEGA /* Hz */;
 	priv->can.fd.data_bittiming_const = &dummy_can_fd_databittiming_const;
-- 
2.47.3


