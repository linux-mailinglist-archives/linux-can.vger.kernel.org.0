Return-Path: <linux-can+bounces-5593-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFA1C7CBCD
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 10:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 645DF4E43DF
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 09:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EAC277013;
	Sat, 22 Nov 2025 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="E17AGp7u";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="/grerpCV"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCF92BE7C0
	for <linux-can@vger.kernel.org>; Sat, 22 Nov 2025 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763804182; cv=pass; b=lO668XLV6rzA5kMTHKgc8upRU5tVQHpp1vgB8uUwXvjA65o/3VA6Ytt9519nZAPU4OzsumMYg+hTaaVCZJzPUutfcQ7OTE5Tb212Vjc3gcQxXGeqFlbuWj9Agog84Fo8THpFrgAbhfAJW3w2qkIEXbiSvpzGpBolaBRfEiAVWNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763804182; c=relaxed/simple;
	bh=763O7b50HhSXxC0PWYbJMawZSqyGGOShMQL2VLkUu3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wu13PZvfaUBl0eEEfry8Nx09UTjOElmL90GqgY3XS8ayWTMCuJBcw9NqfX0evQKHk4C1ItGXazjDifkJbterdSkUKn3zjzPzpiFCQm/RGcvD1WcByy2K6e59JjGGBVwReFyHhtk1dNbTzDwSTDFl7HIm6UWm/ArtGASbd2ScdBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=E17AGp7u; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=/grerpCV; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763804169; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nJop202HiZ65bvis6jdo0eD/gHJGGsaYdJbe+t0RCwCTD/rfQaoM5tXaW4Vl3SE38j
    IgiNxomrOHfjj+lfQQrfFqNDtDWUV+IZojYujMOaXsPm4Xgpt+KWc50gZ6qEEZIUAPAa
    uX6ehVjpUwlc3G5q++8KfqP5+/u5uEhDjvpVDh7xAam/kaXANnbm9P4/dOniURE8Zk+j
    1vP75KdASSG1tQds8x9iQrgj657KfqhKcDTwam6mpfNANNO24enRHzkS4V57m7/q8Ljo
    Re6SZHNqfJZ7bincY8aSiL5ktDKi1kR/SRQFRnSqNYmzqcKKgpXyZt5x+8FbeNbT7jof
    qFOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804169;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LG3Urxe8pmGbWGjgXk2KNAQtE01ZON6ODg6OQ1bmVnM=;
    b=o62xCuU7GSc4PqiRGTqv4e0Ru7JgFk+fSHBmFfvqvVxjht6IplDorsVpRiaLC7bifZ
    DXfiCrfED4QSi58nTp6vRqYNGiLHEKj2rSIm+lLvFw6CBypc+koYmHyVLYfm2yPInFuH
    S8PUm6Iz+BYM4Wwk1SpeU1tgHPp3/8jOTrTCf29QDGtx3PTun2ivxgVqZizKbsraQ0i4
    WYBx74UlqmM0k0K46vE5QENLvTwz5xS2hIhsyXSZz3nLaH+olXhkJZdLPcxam1Fn9Ghb
    W3m8CRiBakMcdaqRy4cHG9S/rpvuT+T/B2DSmCQGdw1HGCx862M2knieBeN75RBpX4g9
    J1gQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804169;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LG3Urxe8pmGbWGjgXk2KNAQtE01ZON6ODg6OQ1bmVnM=;
    b=E17AGp7urjaOM+JZ5eeDxzFzjA/ENTlSmLjx2sLy+ppi5exaXMGpf8UoEbxAewSit0
    bGDLYWvbOkNW95SEq2NU14JjK7rJBIWrna/sM1LpQOtOlqSPITtFkQ1s61DmquVGioZb
    e5x46Bz6Jhrmn7RhwBP9AiQXYEKQn3PtjAHhiQ4s3Bw9+K8Lakt0/FPCvs2hrC1p/dnO
    8x+IJtzbmT5aN8v+8HIn0vxKTSJ+EXYfE73vSYap9tFI4YnIkhMzsDV/pkMu3JDY2MzD
    BMfb35eGxD4/oxW11k8LTYvCCT0HXtdDNoRwYpLbR0CSbs4krmOk9nlEBGZJGudvB4x6
    Hi8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763804169;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LG3Urxe8pmGbWGjgXk2KNAQtE01ZON6ODg6OQ1bmVnM=;
    b=/grerpCV/zulV4rrqfyjhUqDiMjejHxEaFmkNcv7R/gWwEi40AStcYGa+TdlWzGkOe
    f8DbvB+RRzw1ciDVV/Dg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AM9a9Fdn
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 22 Nov 2025 10:36:09 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v6 03/17] can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD is off
Date: Sat, 22 Nov 2025 10:35:47 +0100
Message-ID: <20251122093602.1660-4-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251122093602.1660-1-socketcan@hartkopp.net>
References: <20251122093602.1660-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Vincent Mailhol <mailhol@kernel.org>

Currently, the CAN FD skb validation logic is based on the MTU: the
interface is deemed FD capable if and only if its MTU is greater or
equal to CANFD_MTU.

This logic is showing its limit with the introduction of CAN XL. For
example, consider the two scenarios below:

  1. An interface configured with CAN FD on and CAN XL on

  2. An interface configured with CAN FD off and CAN XL on

In those two scenarios, the interfaces would have the same MTU:

  CANXL_MTU

making it impossible to differentiate which one has CAN FD turned on
and which one has it off.

Because of the limitation, the only non-UAPI-breaking workaround is to
do the check at the device level using the can_priv->ctrlmode flags.
Unfortunately, the virtual interfaces (vcan, vxcan), which do not have
a can_priv, are left behind.

Add a check on the CAN_CTRLMODE_FD flag in can_dev_dropped_skb() and
drop FD frames whenever the feature is turned off.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/dev.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 0fe8f80f223e..d59b283c981a 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -101,16 +101,24 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
 	struct can_priv *priv = netdev_priv(dev);
 
 	if (priv->ctrlmode & CAN_CTRLMODE_LISTENONLY) {
 		netdev_info_once(dev,
 				 "interface in listen only mode, dropping skb\n");
-		kfree_skb(skb);
-		dev->stats.tx_dropped++;
-		return true;
+		goto invalid_skb;
+	}
+
+	if (!(priv->ctrlmode & CAN_CTRLMODE_FD) && can_is_canfd_skb(skb)) {
+		netdev_info_once(dev, "CAN FD is disabled, dropping skb\n");
+		goto invalid_skb;
 	}
 
 	return can_dropped_invalid_skb(dev, skb);
+
+invalid_skb:
+	kfree_skb(skb);
+	dev->stats.tx_dropped++;
+	return true;
 }
 
 void can_setup(struct net_device *dev);
 
 struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
-- 
2.47.3


