Return-Path: <linux-can+bounces-5406-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0F4C60445
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 12:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3203A91FA
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 11:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B9429AB07;
	Sat, 15 Nov 2025 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XyqQdvl+";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="QxJerK4Q"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A76128D83D
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763207482; cv=pass; b=jenTqDK4r0uXvCHVCMx97uWn2l60ryDuv0tHKtm8/m5S2GqAuepx6YTj13XXIplf8MY2FrGVutNtZ2bEpJM1By7drDQ+gN+Q0vU/fmkAnIOjEwlJbazggn9gXjeSaIXfJkN+AAVVO344PR9KMhRr9PnqDoJqypG1947uUeDsUGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763207482; c=relaxed/simple;
	bh=MuX286oxUZ8YOyZtXuymWdY3UhYrGP2K8lVLc5PFs0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqIoND6y3dDtKHODp+AAUR9x0K3UOQEtvMCG/FEwQc9vyok+Nm1ZPRs9SyCFcQDZTCVHBs2lWxJRbsirnG2bSG0KEyPPTtOAoA3O4ypHPP4CmmfgK7T94Ae++/4rpkFCZxCX+oI4piso6zAiIElJxrjZm3De7wLKV1A7ROu+xLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XyqQdvl+; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=QxJerK4Q; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763207464; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nlGN6JHGRI/PvZ2VNO7UD1uJv+3Cf/XqX3aIOSRrRWAjR5s17RfA1ZbdCceRRnaefu
    CBTOq6UOYO1W1lfnil6S51T+B66rJFzmftw7GCDBAJfdkEWIBcPd6VuACxO4xzD9hX9T
    YQlnyJK9ZDUWuNz23qHOZqqHtGVy5O9tjwq+1x/LriWGDsCwSH4SCg1P1Z2aPWQhpLMO
    7eYm8mGiGjXDPmedaxxL8lxg832xKH7yrXqc2ncLYmVpauUtzOqFfAhnlaJtnJSAc0zZ
    9Adn1uVNCMCSjPZxykZTsyvjw4AbzFsaG5oCKUyC5DGzH5N4SPv17SDU09ECj5kvF4DO
    L4dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763207464;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7CnAUXl77iU3byj1HoDDkLhwM1RRaebYwKbVhgkWJQo=;
    b=WoePA3OYQ01EsXMtMIoo5U3r5va1AOQLqZ7KtVPDuRPNu8f1sAzokgMs1ZNEAjWxyp
    RnzaIx0fVH+KNuRDQHNqE9bHbFpPIBb5fiez1oeJYsjbKI9QmTrqFcnZvG7T81VvUBy8
    +dbINtS5msvxkW8ZhveV6bXb8ECnUMch+h4d+JVnicA3gqv8NQi8jiL6fYt3z1ewT48M
    /73CUu3wM7ChmsNHuCTy9q+ZZRQrx8E3pSBovGHixlexp+rNjFLuzmnXMpPdHNgd8B4n
    CUQOBMiEpqrEnrVhfkEKxQGyRSVNJdhb2at2zZ6IKRQoe2lD/r5fEOZTI5fUtGCYdow3
    7OKQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763207464;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7CnAUXl77iU3byj1HoDDkLhwM1RRaebYwKbVhgkWJQo=;
    b=XyqQdvl+l16sEJhKqmp24mO3fPvJmW7cNusKRSZqy5o1UMQd1u0++Y8tFGcRuiis7w
    h2XHufFYZ6Lm6WeTbx8hG2pCyVASzTgXkBepDQLCPMZRlevDd9ceikmN3DqjU+bvtTTQ
    7sa3bMKPrb5fRasMUBLc1qsmSz8782gStpud4WdPEl3rSc2HGQsh3195WoS9AZCi7xrG
    hPDkd06emEeB2Zsyvp/jmOXd4UKgejwvXur6jUohKV3drVSpjz+y+BsyKtBSrf4Tl2H3
    K2o8zw98wl/KdE2CMaykNP5+MpxoGIxujzMUaSRXcDH6sSmRPYRi3/JveyPGRncaEujE
    8nzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763207464;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7CnAUXl77iU3byj1HoDDkLhwM1RRaebYwKbVhgkWJQo=;
    b=QxJerK4QINaKxdxpnxQqv3E+iu6wUS18SLIKQYsoegADLAoHqQL6jWL0TE3AxaQSdw
    7R4Z/oMDr/Z7S/uF1ZCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFBp4dZh
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 12:51:04 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>
Subject: [canxl 02/10] can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD is off
Date: Sat, 15 Nov 2025 12:50:45 +0100
Message-ID: <20251115115053.72673-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251115115053.72673-1-socketcan@hartkopp.net>
References: <20251115115053.72673-1-socketcan@hartkopp.net>
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
---
 include/linux/can/dev.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index bd7410b5d8a6..a7a39a6101d9 100644
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


