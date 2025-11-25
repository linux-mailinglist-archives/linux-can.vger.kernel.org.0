Return-Path: <linux-can+bounces-5648-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F30B4C85011
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 13:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389B73B29A7
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 12:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DCC31BCAC;
	Tue, 25 Nov 2025 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="nLgvi3Ff";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="FKdMgLrd"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C9131CA5B
	for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764074372; cv=pass; b=iskes7QzTthuK6yDNVfvdmUZXSZdyWogdY1aE2Tzvswbpf7RaIEwCXjLx0ksowU8BEWI2VM7w7og9MPGWNyYj58ax06+H3dd1ZeE1R7Ay73n1i2kW5WiRxvK6vbMjhcSfpuWkVCyMl9dXonlKtHjgo6bRFyJTsOD4kegC7iFTl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764074372; c=relaxed/simple;
	bh=763O7b50HhSXxC0PWYbJMawZSqyGGOShMQL2VLkUu3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+BvEjnN0Xrw0tgOvih4Sva/svNSFSw8Y7K9xkHUzJSIGqLCbLq4KtqO0UmHmfccmdT8/c+5btw4iC/PdLtq8uY3huTj0RfZCZn1YUVyYajZq5aBFNz+4MuwaLA8o1oRBjY4auWqeb6WLamieAeQse5+aFL6UbFW+g5HcVWvuH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nLgvi3Ff; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=FKdMgLrd; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764074353; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RjQB33oyyPbIWtNdfE/r2t54D0kLM2Di5WUxRnsnnpajAdSvvjrIfsFd0ymq6g51vW
    wIVgkaoAs13LmUlOQZ7ANAPaGbb3BV7Dqsy9fPWjjKWeOp/HS/i1cDz9TxQFGqSltkGA
    3Hy+sd/Gx2IL6FLixc49Ba4wf0MX2g83JVsnyFXIYSsI7igDpdCEmy8eGdKR/eTACxs5
    Wp5ENAuzE3hK2w1vkaUYJKu5+HXFHbZM4jYqhWib1/JfC9QH/k3aQZ8VWe5SC37iLc74
    v4ZT7pDNgcyOXoH0L26aYFmLN1j8KNyHPQUdMqS03Xqxz6Uwrr1Ld5F8DKPL9xpM1m+4
    fKyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074353;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LG3Urxe8pmGbWGjgXk2KNAQtE01ZON6ODg6OQ1bmVnM=;
    b=I3Z+c457ZXAmYRP60FeCtcSf23hFpmUz7OYJY5IZX2NohO7N4a2LKKgTGxyD/uRqL5
    luh/joVtWUE/G06S8lP7PDaN6PiI2GJORlvR0hMDshdbku6zF4Lgo76Ew6S+d2gIVs8z
    6Jicv8L4AdzAMdiEJeW8bxUKW56ZZ/gKlsK4gDeziWfqisxOJUd49RERghIY/xg4ByT0
    T8wht/+whthrhcvXZ4PnJ0JyJhFkcdDRLllaEVY5c1xxuXy7gjd05VR55fGW1kUdiMHl
    Kl7PeHMiwFPazZ/fpDKVrtZxUMH+5FfaEQbO35P8C0yXTP+kWSiIL8TMR0gqyyrhpvvC
    +Jcg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074353;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LG3Urxe8pmGbWGjgXk2KNAQtE01ZON6ODg6OQ1bmVnM=;
    b=nLgvi3Ff4UPZDzUPB2FBGSiiiaP9EnJnYKz2WlQrlZUpIWxTqOhv1lJtG27S0Juw2G
    pKylJZwrj0/ipTyXQoZtThDQ1jtR8FZunju/roiwJ6QCnWDeyHG9Ihh8y92LBZJX+3EM
    UW9sV3++j7kzAvcch2e53npRqkjs54VpEg/1BMCgQUXGTCl1GwF0iUDlKzvpIAIv9M//
    wbbDjf6F1MMMQAOALK038Qy6Y8ZH4zDnW0ewSmns4L/ThQIJqoK6ZzW8n35t7f+hLuhh
    zX1OxvHh2Rn7+nNuBoxOrXlkuDk4Xj8gm0x/RXTiRLag8ongphCkocHgs/EPOuBG+9Mq
    rLqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764074353;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LG3Urxe8pmGbWGjgXk2KNAQtE01ZON6ODg6OQ1bmVnM=;
    b=FKdMgLrdCOPidkPTxbtrNjtCb1M/TUXsFVm4MK3zXbAor2SZIWT1mwhCDSTntvuu4l
    S0+oajZr0TtbFwvrB2BQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461APCdDT8N
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 25 Nov 2025 13:39:13 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v7 03/17] can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD is off
Date: Tue, 25 Nov 2025 13:38:45 +0100
Message-ID: <20251125123859.3924-4-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251125123859.3924-1-socketcan@hartkopp.net>
References: <20251125123859.3924-1-socketcan@hartkopp.net>
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


