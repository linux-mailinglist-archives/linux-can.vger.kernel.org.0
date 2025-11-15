Return-Path: <linux-can+bounces-5417-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F7AC6055F
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 14:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 72C3E35DE20
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 13:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D4C255F2C;
	Sat, 15 Nov 2025 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="KRlxWiDq";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Dj7NK8d9"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29F9209F43
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763211903; cv=pass; b=aa0v31MqCiZAmwBeHJXP71xKhFjKrBP/oACahTbYhcqZlDx2RpB7Fa5tSLYtOvOBLlX+zujUCKHdKNntAdkQpvtIpr/nTCgTzMhYOY+8CYbyQAHm1r0lURwQSA0MmtlHmuvH4tQ9PpowYU/wHRgpS6S2N3XNYIOS4WDsfOJl9+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763211903; c=relaxed/simple;
	bh=nKb8rv2lOZolhnl18V9lPJZC55QIQoYwqlTb8eq+AEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nt9Z18MnTZ4RK2m5FmAojEfrNFr6nfijUEJoxc5cbxpw1gNA2gR7eafc2BB2yXMAfRp9HjGbDP1N9EyDa1sp7y4/IORLvnqr0NSMGmPBOgzI4NOqjC/G6D4e03mcq1SWtbF2hpKO5ScOzdFnf6EmwwlcQ1claNxUeSlmsrhPkxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=KRlxWiDq; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Dj7NK8d9; arc=pass smtp.client-ip=85.215.255.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763211893; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IibL9fSY8xxczYLoIixLKxCieF9UWe/5t7wVWRx8qobrzDMEdCWSlRsJlFd+9tZYuB
    a4rQr1bA2LfnprJWBeeqWGubkPHzYkfPiuqHDWEIO/TR5VQKm3UfhvEjrQwdZ4fJwvC1
    qSAjKPLThzossAskYe5PKccm3dN6Xkahn4i+KEKlB/Vyiz1gn2x6F93LnOHb+zCs73Bn
    SpxIoxTfyE0dfZTFiAJYNA2+YFrcQrJ887/ljdKLfYUGJgHudoUEp2jX77PlPBVu/vE8
    E/0EZDuOR2/9kH51hkWpR9m+2lkJ/pbpVtzlVv0oWpa3uMMtNTg5Bf/+yqLiXCCju4nX
    wH/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763211893;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Pbj1yoQIeYF/uVG0rF+2jU+s/BQlu5rO/4DLMsB0vaY=;
    b=MPAl81T+8HDJ9RuhXUhgStw/2qe8uoZ0ipUwwG7hJcqTY3pyNZkUvsDX1shFtG3Eht
    sHRl1wTHLzBPqGYpsaIKbRxBQWwb8eJ7hGrzoHf5mFuyrcKkHMPqyXnBgT1eCGpEdriK
    vpdNyq071xP1wOfAsI5lhhpZybqku/ADbF/GeskuNCEt+zWSzPIrjY8AfIF5KMuaGUV2
    6Xni2qoVfwlWDRrYOWENrpz8jW9gulCr5lSTkqFP28J7FmRMbYeVBpkt7/1Ytqlcp1o1
    kpHFFFFO7ZPbjnyaI6qcm+RwXoxq2I8ftgWLyhahLS2d5qX5wCdoVHvGYBrW5NWnrX4J
    3oJQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763211893;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Pbj1yoQIeYF/uVG0rF+2jU+s/BQlu5rO/4DLMsB0vaY=;
    b=KRlxWiDqCUtLKVQvQ/9MTGnjykTtbX/82M26oV4864q+JTpe+fVOCjvtmvC/cbeOSy
    ODMC9tTRC16BHRl8H3JC7ElYaFkYgPZ3HmK55QRC6V1+dcaaqTLyvFr1fr8BYCqnqmeN
    ilvhWpMyV1H7AOPZpyrisWSD5as3iLuyRzvyePJK8XQe7ncU//vghfHbKJzCxskMs+WW
    hxqicy8ibA6EzJcrIQzNhwdtUHHshpgtFlFr5HYEiN0ZtjPidh7CwNxbvlowyOxSuIRG
    DWq+4BigwdcyXF5sdN7lKe0HKxNqrAKVbJBuSIFp0DSHtEKe6Xu56oZevex/V9RTT0wi
    C2rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763211893;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Pbj1yoQIeYF/uVG0rF+2jU+s/BQlu5rO/4DLMsB0vaY=;
    b=Dj7NK8d9AEyV2lAaQKH3RSmg7xU6j/rtRHZANgQW9keh1Ofgf449JtPS15l4funIXo
    5YFxdlNkCADAb/3zRRAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFD4rdhT
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 14:04:53 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl 2/2] can: raw: instantly reject unsupported CAN frames
Date: Sat, 15 Nov 2025 14:04:45 +0100
Message-ID: <20251115130445.9009-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251115130445.9009-1-socketcan@hartkopp.net>
References: <20251115130445.9009-1-socketcan@hartkopp.net>
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
index f36a83d3447c..be1ef7cf4204 100644
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


