Return-Path: <linux-can+bounces-5527-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E16B1C75F93
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 19:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 5373129320
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 18:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11331A0BF3;
	Thu, 20 Nov 2025 18:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="rc7gMBgk";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="T5VjFGmg"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CFB4C98
	for <linux-can@vger.kernel.org>; Thu, 20 Nov 2025 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763664508; cv=pass; b=QW9ypW6fQNHTXTPAWMwHBgvnerXWNZYCjolM1doD20NWyS0coX0CiRm7cF7RpXK3dQna4fskgSmY2qXT1/1JUo8IuZ/RT+FfYIjxhJs3/HkaZGvUP3TqiQNisQOXQmfHRGQnJ/MJjMUWwYLfRsdC4kKccFESVGpauIRR1AAHnoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763664508; c=relaxed/simple;
	bh=kFo+cWd3FsEA77InQXoAwGerQqlnV47knYv1zjqj/9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h4PCT+6R1YtKfd+lke+BWy1E8N2pnkfIffEGvutus6MZerLCYGSpXvThxq2iE/mC6+eZdxfwIZ5Wek96VkvTNRTCOr6/LEiz8APVQXDXfm0e7S2pCu49MfSf4UDh+9Gw2Xh6VUUvky0QYdoXUZeT6Ylh+pilF0QtQ1Wcn9kMmeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=rc7gMBgk; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=T5VjFGmg; arc=pass smtp.client-ip=81.169.146.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763664324; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cJwx5hoq+A4Lh3YtWHNRyFS+0+L1WKu9JCiH5hAoWJ202W+uaTf5H82jeVmNap2yKT
    qEVK+1kOR4s88neyr8WFCh08WqDmBYsjVlOyP5gojYdV5/1WMJIOs1twNhjI8zeYBhSw
    FHm4Zo0t37rWHk6EpzHDFppbwnXsIVxhJH0Za+gbE5lwzGK7r0TzPzKNdTyuLVLgzort
    1oMgkfyPOtx+3TnYwb90jicu+cz5a8sDPJik8lHAy+M4IPdzAkBQTw+Wgseyk5I9gb6b
    cD6W9wtFW5PPF8yztZDg1zrxdUYOedtrUkh/qIQFnQoVttlXSs6sXDaEYhqzNtvnx3EI
    h4eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664324;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BVTOWs4g5KEdda5lO51oBHxVDDNtA9WS5KpPLtm1fEc=;
    b=HC4IQdNZE53d6rJe5jJ4XSnExLuulIho1q/pZ0eOPNMQG5c7HTcOHTzyvWmIQ6hOAc
    PPzctwLPlNRAr7dZ8APdp/N+EmGlfRFc3DnPuoHajLZ2Swd+Qm804dVsLs/wigoXgLlO
    97ueeLSTDDGK+iDoki2Hwj70eJtKopMACZJJGW9rFZXL486NckwQKaqQm0dcQKKhZTSP
    LWH7exfQW+looRIbAOSd4mV9ogjMcAURASfJtI9W+vIeoE4gsOqM7X572gEWSSwHPNY/
    d4oy/tGHy1ZgY7wMvKbY2TE64XFSqimmpfuTsWwwk4ZJv3lghe2iWoX7UNQCAoKU+M7M
    QXgw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664324;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BVTOWs4g5KEdda5lO51oBHxVDDNtA9WS5KpPLtm1fEc=;
    b=rc7gMBgkk5oCnViP49eWCHsnsXeXLKfy2x7Wy6kGcdFFVnRPOhpas8BfUCizNbwjiH
    NuoDQ1vAozLEm7DM6J3/DWPnvlNLGddlEy+JfjZZv5S7cnw53hs7vfmDzp6r6FnS77Ze
    aErI+RAUvey1ruiUzHWowgfVbQKLA3ct99FUs+6FhelyfZ31VQpvpY7NhydlJmZANJur
    6AkfDVWbWHWbcJOtiB8SVh8ctrBqvBqCqEk7z+aYYyUIdfZJYICERlHc17ZUeplka1uC
    gyWi5zL6elnBx11u/kuIys/GuVNGD6OsNrcmAMj188VwD7J/fCSsoP7gP6nut8SzXqLW
    Yk7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763664324;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BVTOWs4g5KEdda5lO51oBHxVDDNtA9WS5KpPLtm1fEc=;
    b=T5VjFGmg6Z0I7pkvg5CEvhyngnPpdXBf3MgkioXmhcwJLw2Ulx3hRH0h5zc89sVGDN
    oBWpnpukl17wED2dScBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AKIjO9DZ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 20 Nov 2025 19:45:24 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v3 15/17] can: raw: instantly reject unsupported CAN frames
Date: Thu, 20 Nov 2025 19:44:59 +0100
Message-ID: <20251120184501.27597-16-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251120184501.27597-1-socketcan@hartkopp.net>
References: <20251120184501.27597-1-socketcan@hartkopp.net>
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


