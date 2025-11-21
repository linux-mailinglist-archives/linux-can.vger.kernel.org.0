Return-Path: <linux-can+bounces-5545-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEC5C77F1E
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D2F24E3B27
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 08:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2396334C3E;
	Fri, 21 Nov 2025 08:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="VdN0dZY/";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="hjIqqgt9"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8835B330D42
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763714255; cv=pass; b=KTfCuiROb7rxLkxJ3vfuAg413+sGihLKC3dLugH516KRgQdylmWbVgI2l5n8BSiP8DyGBP0cra9MBVEF+iWPmM/IE+ZGdrtXEFP9YYDmAfs+36J8yKDDTx7OANrdFsNltCk8EU9tgmz7/ujcfG5P92i1tAwPfw6HjYoVXCZS7E4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763714255; c=relaxed/simple;
	bh=763O7b50HhSXxC0PWYbJMawZSqyGGOShMQL2VLkUu3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nSGG7TOJ4LWDJa71h73ZVrNRf3NiqQ5JpXgk+wiQmYayQJpyun2Ma5P8w9deCRj6PhicjlmZbmBcMSiyCA++GgOT4svj8IipEwH7Z6EbLLITsz7gnNDBmMr+/pK62wiSowiOvkzZWJS0SzQaYikpikuZDbXaq5SFtqa2kg2oPq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=VdN0dZY/; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=hjIqqgt9; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763714067; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VDU2vmgrU1GwLsfO4ERW9ErBRXlVqMzbxe3lBjTAE6UZtRsUOQ12ph/TGErurGFYnU
    UYvDwC86rB1HdSKO00qkYtpTgW2LEpEofxqwNcFBEjaZ7GsYZkZVuaoG+8EPu9NAx6MU
    KV0tvZNsRtPKBfD9n3/oxbDRnipFkJ+6gLcyq210I/MG4F6A9fi+e4xuBRUuLwgpqcTa
    aCjvWnHf+NmEiGQhoIqc7YsQXji95fNsORPBHj2TgH/geYvEqE/pb+a+XQiI+xyOhxdm
    BJLs/DyWavRwRV46AAzLQLwTIJQkjQNpamE6yzsgrj8QTxiGtiC9UYjD0YiZL96yq7JL
    iang==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714067;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LG3Urxe8pmGbWGjgXk2KNAQtE01ZON6ODg6OQ1bmVnM=;
    b=AQ4UqFjMKDgimELu/rbqvN1VfXkTkj9pbAB9PDhz7FvfcxkbmL/zTAQ8QktVIHxErt
    roqEhhX1dlRPUHdKcCONmoywk0wvKd7ZWBwCt5n/gIwo6Xd7i5wO5jTNywhijzV71Ye7
    4N2K+Yt4jSVNDFLJmkgQi8AG0XDxFxEgOGU/r8151jL18g7ON+eStWFX06JU2F0k6S1Y
    PuWLJtgsulUvzsM2ZUOkfkOPhKE1v1EqCzBmskaGekqgNG0BhyFSGM2cmjHLeRkKSPwx
    z34P//sj8p4cjEt4BslxgRWl7dnFgtG/8qPfCJdWIDX0Lbd3YbkoW31njCvYVRA732nD
    cs6g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714067;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LG3Urxe8pmGbWGjgXk2KNAQtE01ZON6ODg6OQ1bmVnM=;
    b=VdN0dZY/lp/F311uMYCzymlPDpzx7yq/jKxHQ5hvfGv60js3YYTEXFih8zcsl003HX
    w2jO7+ORw7eA2idZIJla6At3U7C1NKBAn70gjPPUeYt0NUDkIWMBBLwTnZuft6tPlZys
    nifTAQp0vKgfK2IvRSAIunzlMH/VlathKI81RbcW4sMz6i7r5oKzXFqmy23hGCB3wNvx
    NHTSdvVEzlpTUqAb5TfNBJ8sXxEz9SeK/f4h/DjOjYkdWxURBOheKRwQStEHMY2gsu/J
    ViNNwCd17Z5bp89zJQb8BXeBwwxQO1NFoVgtP5Z8cGwxUgf5TPE5mVVzjsT2dIB7+R4b
    a6Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763714067;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LG3Urxe8pmGbWGjgXk2KNAQtE01ZON6ODg6OQ1bmVnM=;
    b=hjIqqgt9j3GvjRFRHdKvHcl0Yei0co+U4c+KRKjnn/0vEAnwtZ7um6Lj8PuzuZnqSp
    QA5XdhMY0Z7bGyXSISAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AL8YRAfp
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 09:34:27 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v4 02/17] can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD is off
Date: Fri, 21 Nov 2025 09:33:59 +0100
Message-ID: <20251121083414.3642-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251121083414.3642-1-socketcan@hartkopp.net>
References: <20251121083414.3642-1-socketcan@hartkopp.net>
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


