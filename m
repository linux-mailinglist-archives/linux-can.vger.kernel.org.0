Return-Path: <linux-can+bounces-5572-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFF0C7B8CA
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 20:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 64D3135252E
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 19:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59A0302CBD;
	Fri, 21 Nov 2025 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="eiy2PhC5";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="9wYx5WZn"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF69830217E
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753740; cv=pass; b=Ab20x56ksJ0MHT3ts0EMVwaidq8QvWxRrpcw/EUAOvaiWcRdc4wtbxjhJ+C6kYlBsJdxQwH+xAUmjtC8hCM59I3HzllM5D6FzM427PFDjam5akDSqNW/IgZnYOUq6hVr6b9jw4bEFdOQwpS1+qPFzCMpz2SczBFNCdx4pt5M7BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753740; c=relaxed/simple;
	bh=kFo+cWd3FsEA77InQXoAwGerQqlnV47knYv1zjqj/9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRwIV0DLN0pLwfkrZ0Ax+AXCrOQOgaXfk1fdvqOJ/9whnH0YhC7umnDMa1nqilFHOAlM06O9mp8S21gfSDzK6w2PkmCgkXLsTbOQukIfjYeHAhwwWIGUk6sdTBHg8SDwNGaIj8tlYlemaZWjEMGd2KVW+QN0w2tLXjW8AxXhz6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=eiy2PhC5; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=9wYx5WZn; arc=pass smtp.client-ip=85.215.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763753731; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=K3SMTZEHBnPM3GRC8bNw6Yaa8vXft5e/W3oTIGlVdqoFhYjpxB+2qGUYG+BioOKgXO
    J9DJTbxjIQy9dTJhksjfh85TQ9oA9pve9N/VBeruhmf3TcrgRrRHsV/HaJGLrArEqN/f
    tp2tOptW269WMgSW/Cnm7pG+k8uuQabQ7WQRNWvAZp8tidD2Y8AlHXWr/xQE9xCV6lpo
    Wu7pmGeILhiS5KAuP8mMxqy4hq5/K//FA9+a88pLjGARw79PkEqh4TCmPqhHXLmpobPf
    M4o/HUXlrp/6Zv7G26BHp6EopJWLXipV0lgQ6ApR/mTUYh0SWhs/GipJObcAMUx+HaOu
    aiWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753731;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BVTOWs4g5KEdda5lO51oBHxVDDNtA9WS5KpPLtm1fEc=;
    b=bdGI3O1qgL2Ip/Ud9FsRL7cpVoUzYEQbmwjzg0Bofrvx0syG8ikvsyaVO8PRasR/G/
    58jUhj9ICkO3lkwILxtyosLfdEaDcEnHIESS8iBJ/SDdlsJCjYZ1N2A07B+mzv+KVAGH
    JDKhdrQUKRrkLf1yUJcEYP24lgNSdwXfyjSbPCQ1tDbl2Z/jnvy4usEI525qQ9v+9er0
    AAGNWCCSopXtvegTncKqh+jRScmfZ/Gqmvu5sog8wtdoI/OlP4zEWRqZm0yUa8GN5x1r
    ULukWBd4OdbP1uO/V7oJG82tZ7Y1ku2mW6v1o42z/ugP7w8Y8SJPtreG09j7jUF7fT/G
    YRaA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753731;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BVTOWs4g5KEdda5lO51oBHxVDDNtA9WS5KpPLtm1fEc=;
    b=eiy2PhC5zXR5ep4xsZkTsdyAc3gpstnqMgBJDMzqE9sz6d0ulEbR5ghSN8jYdBBC/L
    QvBQuujLqtkOM5SflMPAZxovOmlLShiR9joVMQUAbOJZV/qu4iOt/GUY7RH0yZXeU5QA
    n950bnBI0bs4XtFZUerKbl2WBy0tjb98eM0l+Di5+Ka/kW1hlA6t4rQ+CIF8XjEcVYgJ
    RlaOYe3DoWszurTzWsAmeXLYtWDIltZYnDr5aSW+4+LakqWmQsmK/Kg5Rj1ZAV9SphKe
    reJYwfG1liQbijgn/FIE2Ywl3hV43s0FT/g6wo34qxGvLvGnKzRqbzdYln97MMCKw/RL
    r4Og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763753731;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BVTOWs4g5KEdda5lO51oBHxVDDNtA9WS5KpPLtm1fEc=;
    b=9wYx5WZnJt8KvtIwNwb0CZrXFsVngfQ2HHMa2tLIKNzW755IJTc0VK+eGukSGN2ezl
    CgJq5j9g/h3EX0QR4cCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ALJZUEnH
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 20:35:30 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v5 16/17] can: raw: instantly reject unsupported CAN frames
Date: Fri, 21 Nov 2025 20:35:12 +0100
Message-ID: <20251121193513.2097-17-socketcan@hartkopp.net>
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


