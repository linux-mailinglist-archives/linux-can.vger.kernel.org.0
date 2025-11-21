Return-Path: <linux-can+bounces-5579-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C0AC7B8D0
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 20:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 25C3E3537F4
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 19:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBB02DD5E2;
	Fri, 21 Nov 2025 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="GDYynxsZ";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="/MULNJYc"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983B7302CB2
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753746; cv=pass; b=IGX54c/cAbUfA/c5i5P50oaguKwAhPQljMQDW4uNPNmf2y3m83W3Wvi/0j9mQ3+cFQRPkV00NOh8e+bJssD1QTSUqr+Z44tElueOVobGHhmCTiJLSaUu1ZbrNygiXxhUZVLhHw3TXC86bSEItJgbKUtVI+jhyiCrQc1UHTv6SQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753746; c=relaxed/simple;
	bh=763O7b50HhSXxC0PWYbJMawZSqyGGOShMQL2VLkUu3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uC3KaYSkm8QrQ7iIN81pJPkp0z70L3K9Q+rPfs0JxUyOsf6axD4M72P3Zedyuo6cEDwLntUbTITY5gB9pfZ0rTU5BKrSzcHUcOSvRk17zRx9+274z623B56291rzfaLriMljdmYdMlLaW8DPD/uGOxmnoehlHx2IBNdLRu9CTv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=GDYynxsZ; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=/MULNJYc; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763753727; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HlMSPIOxtg61fWRWFkULliZqBMQVbcF/3ON+2ouxKK0gQMACHCP9ZQ3lR5DuqfyVUG
    H4L0JS9N0D4OQ+jwIwEUEada1e03iQacwk6CNeVVhXh9+lXWF+A67oSAflHfdOEpkeT6
    /Ut949TVXD13CG4F0AAXV0TlsgJkXrW5P3LF+23ubUBfUAg8VunQJbX3g2atm7V1FYXj
    ohTiMyQs0425At9BAs8WMYc4avx24yGC146bSP2UHmSbgx7hxwI8vzTtQxsvngrcJbnp
    jQ6eemrUHryq+nuGp6mqgTdnNxbYatDl1XnPCB21+F0NCUqUrm8rGaCHpicAR6fgN82l
    MUEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753727;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LG3Urxe8pmGbWGjgXk2KNAQtE01ZON6ODg6OQ1bmVnM=;
    b=UalTNqtJvohMeqNQNaJuNFhRCOrx4/gZjDOkZk/zGV6E5ByECCA16pMt2gNTjuJ5dO
    B8qYEKTgo/s2KyJt3bXcZPPUGnUeDrHPzSJzP2Bce7ihTrEiQLQwOZP+s5PwPzFfCML+
    Wh2dB5mn/6e37CvprHorolUj6hc64ZzNImp/JF6FeOkt9VAgB5XJ9w18ymX5/VXjZN5t
    naTJeE/Jm8oFVkEQ0FlhdSmpUoDG4q8+ZxCOwdcWggdusN5/OYrOSgcOvuvmkPsfSLoU
    2hIgiFxmTFaoigMhhLuwWgQ+GHCe684KEnSGzHCZ+WwhHaMMbQLFjYv1aWWK/XvMakNH
    pcNw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753727;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LG3Urxe8pmGbWGjgXk2KNAQtE01ZON6ODg6OQ1bmVnM=;
    b=GDYynxsZd9CURxi1I8rFdO/IW5kJ/2w5wRdl608R/2aKODtNsxPigV37Pdze6FPaUi
    8hMf2TjvNuXZjL7NDZOiqY3OHnIbEjLjW05zVGPp+rrwn6y9pkmGgNWfL8t5s/wjASLs
    Ch7dz0ke6Y4JBqUzRrdml2hIglGvcmwHd+3Im0tqy4hXJaKshnVMtTfrHasbwrw9s9UA
    0ND2pbu/iIrAO2Mav62VltVzpKSWS+YpeCXVNOHMdbTUrOh52VlmTzmhfEiMMHqVLWrT
    nMVvR3mQdbhLs1GLiucDfikIdXERGzgmF7AYombzG/YNbfoUod84e7aYXNRUye/pt0Oc
    wnfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763753727;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LG3Urxe8pmGbWGjgXk2KNAQtE01ZON6ODg6OQ1bmVnM=;
    b=/MULNJYcg2EG+gnk6pHhMClInSrIp5qb5xbT6/fbTITKd+4Ri8N+LIP25mt7IzvkiZ
    3jv+cqy71xqcFSPSx1BQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ALJZREn4
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 20:35:27 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v5 03/17] can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD is off
Date: Fri, 21 Nov 2025 20:34:59 +0100
Message-ID: <20251121193513.2097-4-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251121193513.2097-1-socketcan@hartkopp.net>
References: <20251121193513.2097-1-socketcan@hartkopp.net>
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


