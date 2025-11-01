Return-Path: <linux-can+bounces-5293-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA23C287D9
	for <lists+linux-can@lfdr.de>; Sat, 01 Nov 2025 21:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 960E34E1F8D
	for <lists+linux-can@lfdr.de>; Sat,  1 Nov 2025 20:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CDE22F14C;
	Sat,  1 Nov 2025 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="DtXNmggW"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799562288C6
	for <linux-can@vger.kernel.org>; Sat,  1 Nov 2025 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762030292; cv=pass; b=mJ4hP6+WJkbER8NuWdNO6jPmHwyIxWPqs78ZFvN0JcKjY+Ino2taKVtrzySTvi2DGC5NRbORaQyfP6goKRqMqXEjnFSJaSkjwfbGn3TRwhz6SuHofpiBVjxyoIqm4iHcTM1yDJ7/uyj+4QZZ+S0lmaACVEowqhdOYG3CjY3AByU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762030292; c=relaxed/simple;
	bh=5mlZPlDUzxF3hyDl83RVgRLdXnuAeQW7laLG5OUGtAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TBy2eK3WsCtm5q6SxQt6OYtJFgTzgGXx8Muv33VRxRUa7AOSKypA1DWR8J7vSjfFJaxqnt5FuKymvWHKVoBJm1WOv9HK7j1em/nfC7TjQuUZJbFBVgYsyo7TFolqrQt7eoq+ZMA9bMvXyJYgsbJ0B3pPVgwbAXLrO24g7wv0TdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=DtXNmggW; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1762029566; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WlV69DFf9EPZL05CLm2YUobwf+f4AYrhvw/W4KS9xqdFo8DJpfthM3H+RdNbKbesCk
    r5ilebmPk2izg/PLga5POQW07n0bSJXzM5RehEj+HAd0UpFNr3eoPK9aV5yRNd9/WXSQ
    eW7Xu+XrifTUGIXKid6sGiBXmffRQlI97sqgZyLinbVRtAi8qFgxln3R3sL2rHLaII8q
    z92k+1OquLDG0ghZWNsvkTGYsIkaoJF+IPmDnXl45XFNzr4S2jQGpHiu6kyIoL/o8wyI
    LL2F3XbRsZ0rBI+W9Wq2oiHfN1pCsz55I6nCMO37lyjafrBsVvUQzAzhZq3mmhmP3r5/
    2x0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1762029566;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=zTCE3Zjhk0NCALGTTACkqJcKKFMsaU01LZTx0dEEYCY=;
    b=bFyOPY2JysS8lxLzoJm53mCCfrJFN7PBkJ552Sq8Cuf6EBfkUrYZ+p0oengDIib+Qf
    Qxo1/oDBH+2QRKDlNZNZgx349f7/q9ArmD22UStcl/W+qKitU87lq4EsA1vgRute6Nze
    9fBbjxsm1HytGU/79NjNcmhvTeEiK6VpdnWYr+OYTPIlfMKFRlplQ1KHCmo++Y4c1rN9
    rWrCb001c62820LEVvgaPcyI3rljer3MIzpWlpsaGuqPzC6gYrIU1e8y+BYfsvCLymeW
    j5vxjubL3+6O7MBq1T6JWY4Al/gDqiws2Q0GjYZGDHvVTZoTs4Non9ahS3mKQKrIX1I2
    DpIA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1762029566;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=zTCE3Zjhk0NCALGTTACkqJcKKFMsaU01LZTx0dEEYCY=;
    b=DtXNmggWe/RbVA5gJrmlZm9hLZGnCmiCOI6dmummBXe8Z3LqyzfkGXj/YlCThvMIck
    67NIQzt15yS38oKU9C112s2redSg955QSNIONf6umeBrHvUrVN1a3mat6LW+Zb82Z53F
    kKQgXp5VCsxYtHdQZxrwvnOt7uY71WYMLxwLieOpd/bsI92H721SN9wQWkBblMhi6JwQ
    54sqMGaSO8vic4VwKupL/+34yIZKJG/6J3BJOcwz5bM9IUz3eTjG3Ci7kqEIH8VzN9dU
    X3Xmc9i6Kp/iejarkW9bRydagS5EQzZEwLh/xjCEIhBUzZkUxt5s0Vx+OmjvoyUVy/Eh
    IvPQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 53.4.2 AUTH)
    with ESMTPSA id Kf23d01A1KdQwCJ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 1 Nov 2025 21:39:26 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org,
	mailhol@kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH b4/canxl-netlink] can: drop unsupported CAN frames on socket and netdev level
Date: Sat,  1 Nov 2025 21:39:10 +0100
Message-ID: <20251101203910.2379-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Rework the checks for skbs containing CAN CC/FD/XL frames.

For real CAN interfaces the CAN_CTRLMODE_FD and CAN_CTRLMODE_XL control
modes indicate whether an interface can handle those CAN FD/XL frames.

In the case a CAN XL interface is used with "TMS on" neither CAN CC nor
CAN FD frames are supported. Add a check for this in can_dev_cc_enabled().
CAN_CTRLMODE_FD is ensured to be disabled when "TMS on" is enabled.

The checks are performed on CAN_RAW sockets to give an instant feedback
to the user when writing unsupported CAN frames to the interface.

Additionally we check for correct skbs on CAN netdev level in the case
the CAN frames are provided via PF_PACKET sockets.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/dev.h | 51 ++++++++++++++++++++++++++++++++++++++++-
 net/can/raw.c           | 19 ++++++++-------
 2 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 945c16743702..db8eb14c0c7f 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -129,10 +129,46 @@ int can_restart_now(struct net_device *dev);
 void can_bus_off(struct net_device *dev);
 
 const char *can_get_state_str(const enum can_state state);
 const char *can_get_ctrlmode_str(u32 ctrlmode);
 
+static inline bool can_dev_cc_enabled(struct net_device *dev)
+{
+	struct can_priv *priv = safe_candev_priv(dev);
+
+	/* only CAN XL interfaces with "TMS on" can not handle CC frames */
+	if (priv)
+		return !(priv->ctrlmode & CAN_CTRLMODE_XL_TMS);
+
+	/* virtual CAN interfaces always support CAN CC */
+	return true;
+}
+
+static inline bool can_dev_fd_enabled(struct net_device *dev)
+{
+	struct can_priv *priv = safe_candev_priv(dev);
+
+	/* check FD ctrlmode on real CAN interfaces */
+	if (priv)
+		return (priv->ctrlmode & CAN_CTRLMODE_FD);
+
+	/* check MTU for virtual CAN FD interfaces */
+	return (READ_ONCE(dev->mtu) >= CANFD_MTU);
+}
+
+static inline bool can_dev_xl_enabled(struct net_device *dev)
+{
+	struct can_priv *priv = safe_candev_priv(dev);
+
+	/* check XL ctrlmode on real CAN interfaces */
+	if (priv)
+		return (priv->ctrlmode & CAN_CTRLMODE_XL);
+
+	/* check MTU for virtual CAN XL interfaces */
+	return (READ_ONCE(dev->mtu) >= CANXL_MIN_MTU);
+}
+
 /* drop skb if it does not contain a valid CAN frame for sending */
 static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *skb)
 {
 	struct can_priv *priv = netdev_priv(dev);
 	u32 silent_mode = priv->ctrlmode & (CAN_CTRLMODE_LISTENONLY |
@@ -142,15 +178,28 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
 		netdev_info_once(dev, "interface in %s mode, dropping skb\n",
 				 can_get_ctrlmode_str(silent_mode));
 		goto invalid_skb;
 	}
 
-	if (!(priv->ctrlmode & CAN_CTRLMODE_FD) && can_is_canfd_skb(skb)) {
+	/* Classical CAN */
+	if (can_is_can_skb(skb) && !can_dev_cc_enabled(dev)) {
+		netdev_info_once(dev, "CAN CC with TMS on, dropping skb\n");
+		goto invalid_skb;
+	}
+
+	/* CAN FD */
+	if (can_is_canfd_skb(skb) && !can_dev_fd_enabled(dev)) {
 		netdev_info_once(dev, "CAN FD is disabled, dropping skb\n");
 		goto invalid_skb;
 	}
 
+	/* CAN XL */
+	if (can_is_canxl_skb(skb) && !can_dev_xl_enabled(dev)) {
+		netdev_info_once(dev, "CAN XL is disabled, dropping skb\n");
+		goto invalid_skb;
+	}
+
 	return can_dropped_invalid_skb(dev, skb);
 
 invalid_skb:
 	kfree_skb(skb);
 	dev->stats.tx_dropped++;
diff --git a/net/can/raw.c b/net/can/raw.c
index a53853f5e9af..645f1e0b2555 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -890,24 +890,23 @@ static void raw_put_canxl_vcid(struct raw_sock *ro, struct sk_buff *skb)
 		cxl->prio &= CANXL_PRIO_MASK;
 		cxl->prio |= ro->tx_vcid_shifted;
 	}
 }
 
-static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
+static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb,
+				      struct net_device *dev)
 {
-	/* Classical CAN -> no checks for flags and device capabilities */
-	if (can_is_can_skb(skb))
+	/* Classical CAN */
+	if (can_is_can_skb(skb) && can_dev_cc_enabled(dev))
 		return CAN_MTU;
 
-	/* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
-	if (ro->fd_frames && can_is_canfd_skb(skb) &&
-	    (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
+	/* CAN FD */
+	if (ro->fd_frames && can_is_canfd_skb(skb) && can_dev_fd_enabled(dev))
 		return CANFD_MTU;
 
-	/* CAN XL -> needs to be enabled and a CAN XL device */
-	if (ro->xl_frames && can_is_canxl_skb(skb) &&
-	    can_is_canxl_dev_mtu(mtu))
+	/* CAN XL */
+	if (ro->xl_frames && can_is_canxl_skb(skb) && can_dev_xl_enabled(dev))
 		return CANXL_MTU;
 
 	return 0;
 }
 
@@ -959,11 +958,11 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
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


