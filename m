Return-Path: <linux-can+bounces-6303-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGd/LCl7dmloRAEAu9opvQ
	(envelope-from <linux-can+bounces-6303-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 21:20:57 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9E6825C4
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 21:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 420053000FF5
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 20:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2372F745B;
	Sun, 25 Jan 2026 20:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="gZ8p8FGr";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ej7ZBRjZ"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DB62BE7A7;
	Sun, 25 Jan 2026 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769372454; cv=pass; b=jxQQoW2BkGOWjuYtlH6BD0+IVR/y8hknjGEC0Cg9hbpKBhVtfT78FEMlPOSTJR36RuVxv7A2mLiXAcYeu5RV/IfgO++Cnh2ObRoGhTo+eBVJ0QLzvOJ+nyWUDMVgaIdY+bP8F/inLo28XWx5aHxW5C3v2NFDxB/CBqOyuF0Dwwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769372454; c=relaxed/simple;
	bh=67iLx+zCeqGhk7Uqk3k6MRn9oTCS3BfsHKwE6dkh7hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZbSMVdHulBgoCSy8GxfkNsYcS/JyhQh2T1Pe2vKB2OiUNfLEmON//QiE2SW8qj8etkItSAcobZq/ID0Zs1g8jM+s9YRkKMKEliQjdRfoR1w1IwzsMSuMhXh+qJ1w9DORQk94Z6qoInJkyZmY87Y/a0QWH/H7FL+q0jUwfffzQDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=gZ8p8FGr; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ej7ZBRjZ; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1769372268; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dNv1PgbLp/daF2ICd+IuSeVjNZAN8wUSpt+TRh+5ndaN018S0djfi2GAPUd6p6aha/
    27CK5ZrMDmZXm4K2dEiEsS5Tt35geSitm3krrRm2OhuVN+DcXh2bO3XBERMDGr0E8AUv
    9IaIL+Uv+j5FEoBoJbzeqFkptTQNqPUQc7UDzg4Y8765sccEYRi9eF8xW5BjfVTMQ6um
    YforDt50vXrswXu3AZXhgcbo1696Vp32bg0fqJk3yA0x02gB1YqM+vmI2iiuZ9DR1Soj
    kR//iZ3uc96pgkkY5DobHDX4C3sYEMCAccxkhN3DSUXo2Ilm8BQj5qelmz7lpbQr7eRd
    c7+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769372268;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0uHijS46Xoxb/9x5YWjsNQb+joxjop52cpbuYPa9TUQ=;
    b=OKieDfAbU2+3RsJdKUJTdNOERgsB3C2hqs+c2C3XwKCtbNksMtiP2Ktz4rY549O5I8
    vCyqP8bbJhpPKuMQVNVryTaA3olbdvZYgyKjzyeAPMnR229aHK+3m5Y2T4MujFw/nWBX
    Qpf+L6yVyHZnSqVxvEQ53vIaXSQhM7Kw7sMua0kGjfDRewXA05phXdL/8miS0nC1+6Ee
    7a7BI3J3XKnTvHA2vU06QvguZy/6JV9B6hsrJc5D1GR0hZ/u4XVETUtf2vQ+zX93w25X
    9YAq4HD+BEPaStJv9ZsZz2UljYiMgWXWuOGiqVOMkldWT5kKcsaKA/3btwH9uhUbqiNi
    KjZg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769372268;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0uHijS46Xoxb/9x5YWjsNQb+joxjop52cpbuYPa9TUQ=;
    b=gZ8p8FGrNAom0uKYcJtncv3MYJlYOKmapzuTGzhT/1rzcAz7GPCclGDm4nbryZcm9K
    0+iLHcb0h7Jnl78EYgPqxRZcrIdllBNcAWQcP44+KGaMEFNQeYRdr8+maHT+rp76PA7M
    To/dCkxyyMk+ggMQRqyNZFD6CgaKug+dlW5reBA5J6SIuBfpeorzDsaBHHm7XHJ5B6wO
    pwTsflb/IRcfea5op9bqRX8CzkgkefQbTZiOmNVV36xn+Vo/qJOE/g9LTc86oNDWc8rg
    BHp3VsrvfPz82fqtgDof71utdM0UulvxZJ7a30IJrNMustjvKkQ96gRlny/jnW6XXPeV
    fQJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769372268;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0uHijS46Xoxb/9x5YWjsNQb+joxjop52cpbuYPa9TUQ=;
    b=ej7ZBRjZ+jQFAyriq7jhqjj8HtEYqofFkFsz59Db+ZZiVm0aB7aFZGcaS5XFvs7QvQ
    BwojcnCZtB1yN1aTnZDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s1YTqptmo87qzm6sElmZEI+VN6rw=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20PKHmYsV
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 25 Jan 2026 21:17:48 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: netdev@vger.kernel.org,
	linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [net-next 4/6] can: move frame_len to CAN skb extensions
Date: Sun, 25 Jan 2026 21:15:59 +0100
Message-ID: <20260125201601.5018-5-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260125201601.5018-1-socketcan@hartkopp.net>
References: <20260125201601.5018-1-socketcan@hartkopp.net>
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
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_FROM(0.00)[bounces-6303-lists,linux-can=lfdr.de];
	TAGGED_RCPT(0.00)[linux-can];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[hartkopp.net:+]
X-Rspamd-Queue-Id: 3D9E6825C4
X-Rspamd-Action: no action

The can_skb_priv::frame_len variable is used to cache a previous
calculated CAN frame length to be passed to BQL queueing disciplines.

Move the can_skb_priv::frame_len content to can_skb_ext::can_framelen.

Patch 4/6 to remove the private CAN bus skb headroom infrastructure.

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
2.47.3


