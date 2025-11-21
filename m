Return-Path: <linux-can+bounces-5528-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B55C77F30
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 2806933121
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 08:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB1A22541B;
	Fri, 21 Nov 2025 08:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="L7q/1Ppn";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="vbEP8I0q"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86478277818
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763714073; cv=pass; b=b0YtoyhPCjJptOdsR/djkd2N4rC/apeOcEbXXsu6x0Yc3GB2FeCatM7QskVh+Hhcc6KUxOG6v+7SrTkXCaShZIFMB0rw3UYS8kF0OtI0T+cZ4lxjtap855eq7w698pG9Ao9gQH7fNILg5HAiGgIsz+uWoEWaA0UdQNVn1MlNtJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763714073; c=relaxed/simple;
	bh=odmNXRSVHCJpaxQaUGaHTVRhSe1XmlYN1erWE0FO0/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ReL+n+lQkNtKKji2dM2VoX1U7PgnF8slGnwX7upf77UOIBq2m6Siv85z3eclyJddrySVpCC6tR2GQjmc2tMLxRZT4drJNEMJJ9wqNyflT3aJmp837rbaqVs0VuIp1cG3FlBk2sXMWZi0ps2JZ+oNFrgb0x4c/jec7w/TyWgi+s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=L7q/1Ppn; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=vbEP8I0q; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763714069; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EPhbeQZMpQOrSSNLHf1FBXL8pviLH697EBAsLNBXKURoxZuHtI5kBHXVGl2sDcNfGT
    OMort3PXzj/5bmWWGcMvrAfllPxMYer8ngd7Fs0TNUMxNSevmsm2d/Lz+qQG5CA0DOKW
    SVpeJqbrIbzy02uxKpe2ceqikYfYQSwz1ychy4sbSSslni2kpHGRMsgUry1TknMNwdAM
    D3avrOMS2vEwylHFLhF4KeA0GQwuQZLy6Tf26HNksLRTpnMXfzsyhzX22bVymylY7bMQ
    CB+C0IfZWZondPxfs5rk0RNCC81Ya7zg3xfvUXeUMKnKD/5dqAhd+uuPWEzv/qxRiBlt
    i/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714069;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=R2HBjICR4zHJ6NbAEBWhWf91SklrpfIglkI8e4mDEwg=;
    b=dr7V/1GH/egAyJGAMiA8Tp0cjWKRToH8UolJb1UQDRIlp9pDymsY/KTgfpjyyjgdb5
    FfzabiD0WWTF0ko24g9Ic6UBKpOX94nmCAktm0Y3sXEw+VgjJ6mxAt1RcFJMO9rmaI5h
    vYhlGEazpC8/hyM423od9X5lFDsFdOeY4UfhBV1X3QapgtjcCdczafY0UakSgAwp2yQJ
    r5dAplE4dhFjXefJPm4O2yUNYoiZ8x439XA50/T7c8Mseen/sg2l9ZtW7lz0Q+APffta
    0POYCaxAEh2pI5EBXU3TM/XltZLKCSgsRbr2YYQpfQPYnM4LEO76iePVKHURn0G7w7gC
    xHvg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714069;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=R2HBjICR4zHJ6NbAEBWhWf91SklrpfIglkI8e4mDEwg=;
    b=L7q/1Ppnh97EZYec10u0/wjkh0MvG8VsQye+RjZL2aV4tBOuMt5o8AB3Kq/hWT6q+K
    ANBaCkVO8/pMdlzOYf6HrLKmDQiEBpMAa57uKAmfUqyMeS2cit6nC9zWl/eAP0xs3hfw
    rRBLErE2ZRR2IFVVM127wOxoXUvI4p2ng1bI5Ilwqek0WjDxRhKtVdq/qunP6ZFLcbHy
    dc2aq1tdnp1McnyKEQPpDrEmGXKvyY+DgIh7Qbgga55MAY9O115GdWzx3W14JZHgvVBL
    lcbR2SoeT8d/7qT1HKOgI7XfZ4Kk+H339DSWd2855uDjSSGoskbEe5HVQOfFV8lVmrqV
    v3Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763714069;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=R2HBjICR4zHJ6NbAEBWhWf91SklrpfIglkI8e4mDEwg=;
    b=vbEP8I0qUqSgGDyzwulCRu/u2XO0hAyppvJZ/wWY+bE0LQG/n10+qoxdqyMJ2afbOv
    RJZM9hgJkdwjvCObUoDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AL8YSAft
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 09:34:28 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v4 06/17] can: dev: can_dev_dropped_skb: drop CC/FD frames in CANXL-only mode
Date: Fri, 21 Nov 2025 09:34:03 +0100
Message-ID: <20251121083414.3642-7-socketcan@hartkopp.net>
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

The error-signalling (ES) is a mandatory functionality for CAN CC and
CAN FD to report CAN frame format violations by sending an error-frame
signal on the bus.

A so-called 'mixed-mode' is intended to have (XL-tolerant) CAN FD nodes
and CAN XL nodes on one CAN segment, where the FD-controllers can talk
CC/FD and the XL-controllers can talk CC/FD/XL. This mixed-mode
utilizes the error-signalling for sending CC/FD/XL frames.

The CANXL-only mode disables the error-signalling in the CAN XL
controller. This mode does not allow CC/FD frames to be sent but
additionally offers a CAN XL transceiver mode switching (TMS).

Configured with CAN_CTRLMODE_FD and CAN_CTRLMODE_XL this leads to:

FD=0 XL=0 CC-only mode         (ES=1)
FD=1 XL=0 FD/CC mixed-mode     (ES=1)
FD=1 XL=1 XL/FD/CC mixed-mode  (ES=1)
FD=0 XL=1 XL-only mode         (ES=0, TMS optional)

The helper function can_dev_in_xl_only_mode() determines the required
value to disable error signalling in the CAN XL controller.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/dev.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 945c16743702..13b25b0dceeb 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -129,10 +129,23 @@ int can_restart_now(struct net_device *dev);
 void can_bus_off(struct net_device *dev);
 
 const char *can_get_state_str(const enum can_state state);
 const char *can_get_ctrlmode_str(u32 ctrlmode);
 
+static inline bool can_dev_in_xl_only_mode(struct can_priv *priv)
+{
+	const u32 mixed_mode = CAN_CTRLMODE_FD | CAN_CTRLMODE_XL;
+
+	/* When CAN XL is enabled but FD is disabled we are running in
+	 * the so-called 'CANXL-only mode' where the error signalling is
+	 * disabled. This helper function determines the required value
+	 * to disable error signalling in the CAN XL controller.
+	 * The so-called CC/FD/XL 'mixed mode' requires error signalling.
+	 */
+	return ((priv->ctrlmode & mixed_mode) == CAN_CTRLMODE_XL);
+}
+
 /* drop skb if it does not contain a valid CAN frame for sending */
 static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *skb)
 {
 	struct can_priv *priv = netdev_priv(dev);
 	u32 silent_mode = priv->ctrlmode & (CAN_CTRLMODE_LISTENONLY |
@@ -147,10 +160,16 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
 	if (!(priv->ctrlmode & CAN_CTRLMODE_FD) && can_is_canfd_skb(skb)) {
 		netdev_info_once(dev, "CAN FD is disabled, dropping skb\n");
 		goto invalid_skb;
 	}
 
+	if (can_dev_in_xl_only_mode(priv) && !can_is_canxl_skb(skb)) {
+		netdev_info_once(dev,
+				 "Error signaling is disabled, dropping skb\n");
+		goto invalid_skb;
+	}
+
 	return can_dropped_invalid_skb(dev, skb);
 
 invalid_skb:
 	kfree_skb(skb);
 	dev->stats.tx_dropped++;
-- 
2.47.3


