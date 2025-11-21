Return-Path: <linux-can+bounces-5535-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F2EC77EFA
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C2674E8A07
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 08:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C35337104;
	Fri, 21 Nov 2025 08:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ApybdQxs";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XsFI4a90"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C140022DFB8
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 08:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763714081; cv=pass; b=AuWEx4+VeqCtnNRA7tho49IB8OpqW4/sbkpB0l1LcgMrLmvke2DIzDW4rdZsFwByiJPKAG98DEDnqVSvl92ydAUINbHSAFqvKnAcDWV/GF/O9aBmZw4WHH8B4m1vctyDT4aXVF555mCklbVbsvTyFqOVv2ndmAYsKhfDf1C2kUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763714081; c=relaxed/simple;
	bh=kFo+cWd3FsEA77InQXoAwGerQqlnV47knYv1zjqj/9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJWJjdSH/gP3UQlnE2vt/TCiEvysaqTtd994TbfCPl9DulKz2Qv7Yl+DX8t5SMOyEUGj4g3qO2f5sJmV67vEwE5GpStnSwr6nOyWwA0CWJnflEQ2z1HfKhD6bYk5jUNd+YZeGuyHRmdcblmgREEGKB1DmOJXD886ziAbGzfiZI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ApybdQxs; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XsFI4a90; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763714071; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=eX2XaJzVnO8xFDdfX5c9kyowT3cHNgjwXXCAAoxLf8LRcExIrNdNSFxaJqLT6sxh3y
    /fCVfE/yiMGap/oqYxvfWTtruzCCkEYDoCR73tk8RP9++qOIHIiqQgWZfuRKVWqi8K7Z
    D7e97TQJp6hqszfTCoLFJXsTa1SavEryopdJyuIMAGNgzrDO+mYLRWlxGYHQLAsK2aCc
    QvYD/jVxASPnSHPHDBDTFlF9f09sduOX4nUqP7AyTQX3GvoppJuL0Bhn5WNKBEvnJvJA
    pc6k75Rn/W1TMehCK+B4HDnDFDTvNwTai1H/e7tA8erTsmjUnJi+pmMKI952eXzk6G0A
    YLZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714071;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BVTOWs4g5KEdda5lO51oBHxVDDNtA9WS5KpPLtm1fEc=;
    b=KzpsIZJN57cAkx6fGMN0MfAnUvT8fKUlX/9FZJceo9BvY+GZUhXhVj4oDU7zORBKsi
    jfVLl1+xXKVcqzieMQwFEas65rLrA5eMckRAjYss9bCYuZvVPqiVLb9jw/yw1LNj+gGh
    P0EE3JP6lhzpBQFH2vdiS5fdLKhLKg0w/QY1zZVxwHIiYynBnH1zY7k74mrRkp8Qv48h
    zQw27mKXYmkpZX2Gmx4hz5cBlEa4FDTp0Wdaf2hRynhwiDbJQqgMEaiheWk3rc37knww
    E0nCur//mxjf9mcCquZh8lF9iXsMg/ucm5pl4miqTR+f55+weviamwxFS82XAh/IVXYe
    L3cg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714071;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BVTOWs4g5KEdda5lO51oBHxVDDNtA9WS5KpPLtm1fEc=;
    b=ApybdQxsjrvgd/GEGVWqLUd2kIv7owj44noSM/rWZ3Kgc0FJlFSJEbgNp4YoyzrB32
    HSCBccHMQlY+P47v/73UyqjBKxyfJeZApInH5qMFFES9nzfB3VbozHBkzFiSRcEi41pQ
    LkXcK/HiIHwkuZd9VLHyDIwC5yxiXbJ5xYGbSBhJ+TNEKZD6COVOCdH/TJKF4sWIXB7h
    Q4ZFYi+cY2720XMUGX8vGQ5xbx7Mpr7Y43BNchlPH4yzXG/3yTIAsffRfztDUn0bT0/K
    u023b3r/EMHbGNcr13HeAteU2CmqTCBXhD5Fa3wJ0jTna/bqT5F/eOUMQTMkej1mHi5b
    3+CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763714071;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BVTOWs4g5KEdda5lO51oBHxVDDNtA9WS5KpPLtm1fEc=;
    b=XsFI4a90+e5/Yeb7wtt/tQAxocGamzEO8t2RCpcLsSRae447uqFjjWaZgB2FEf942H
    5/XkkhLDq8pve0bF0uBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AL8YVAg3
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 09:34:31 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v4 15/17] can: raw: instantly reject unsupported CAN frames
Date: Fri, 21 Nov 2025 09:34:12 +0100
Message-ID: <20251121083414.3642-16-socketcan@hartkopp.net>
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

For real CAN interfaces the CAN_CTRLMODE_FD and CAN_CTRLMODE_XL control
modes indicate whether an interface can handle those CAN FD/XL frames.

In the case a CAN XL interface is configured in CANXL-only mode with
disabled error-signalling neither CAN CC nor CAN FD frames can be sent.

The checks are performed on CAN_RAW sockets to give an instant feedback
to the user when writing unsupported CAN frames to the interface.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/raw.c | 54 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index a53853f5e9af..223630f0f9e9 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -890,24 +890,62 @@ static void raw_put_canxl_vcid(struct raw_sock *ro, struct sk_buff *skb)
 		cxl->prio &= CANXL_PRIO_MASK;
 		cxl->prio |= ro->tx_vcid_shifted;
 	}
 }
 
-static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
+static inline bool raw_dev_cc_enabled(struct net_device *dev,
+				      struct can_priv *priv)
 {
-	/* Classical CAN -> no checks for flags and device capabilities */
-	if (can_is_can_skb(skb))
+	/* The CANXL-only mode disables error-signalling on the CAN bus
+	 * which is needed to send CAN CC/FD frames
+	 */
+	if (priv)
+		return !can_dev_in_xl_only_mode(priv);
+
+	/* virtual CAN interfaces always support CAN CC */
+	return true;
+}
+
+static inline bool raw_dev_fd_enabled(struct net_device *dev,
+				      struct can_priv *priv)
+{
+	/* check FD ctrlmode on real CAN interfaces */
+	if (priv)
+		return (priv->ctrlmode & CAN_CTRLMODE_FD);
+
+	/* check MTU for virtual CAN FD interfaces */
+	return (READ_ONCE(dev->mtu) >= CANFD_MTU);
+}
+
+static inline bool raw_dev_xl_enabled(struct net_device *dev,
+				      struct can_priv *priv)
+{
+	/* check XL ctrlmode on real CAN interfaces */
+	if (priv)
+		return (priv->ctrlmode & CAN_CTRLMODE_XL);
+
+	/* check MTU for virtual CAN XL interfaces */
+	return can_is_canxl_dev_mtu(READ_ONCE(dev->mtu));
+}
+
+static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb,
+				      struct net_device *dev)
+{
+	struct can_priv *priv = safe_candev_priv(dev);
+
+	/* Classical CAN */
+	if (can_is_can_skb(skb) && raw_dev_cc_enabled(dev, priv))
 		return CAN_MTU;
 
-	/* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
+	/* CAN FD */
 	if (ro->fd_frames && can_is_canfd_skb(skb) &&
-	    (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
+	    raw_dev_fd_enabled(dev, priv))
 		return CANFD_MTU;
 
-	/* CAN XL -> needs to be enabled and a CAN XL device */
+	/* CAN XL */
 	if (ro->xl_frames && can_is_canxl_skb(skb) &&
-	    can_is_canxl_dev_mtu(mtu))
+	    raw_dev_xl_enabled(dev, priv))
 		return CANXL_MTU;
 
 	return 0;
 }
 
@@ -959,11 +997,11 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		goto free_skb;
 
 	err = -EINVAL;
 
 	/* check for valid CAN (CC/FD/XL) frame content */
-	txmtu = raw_check_txframe(ro, skb, READ_ONCE(dev->mtu));
+	txmtu = raw_check_txframe(ro, skb, dev);
 	if (!txmtu)
 		goto free_skb;
 
 	/* only CANXL: clear/forward/set VCID value */
 	if (txmtu == CANXL_MTU)
-- 
2.47.3


