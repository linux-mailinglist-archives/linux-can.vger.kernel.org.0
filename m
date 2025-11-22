Return-Path: <linux-can+bounces-5590-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF89C7CBC7
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 10:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 140E24E34EB
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 09:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C25221F0A;
	Sat, 22 Nov 2025 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LvTiWh30";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Rm+LJdlv"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978631E8826
	for <linux-can@vger.kernel.org>; Sat, 22 Nov 2025 09:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763804177; cv=pass; b=ueaptp8Dfpnj/N4ml/7PGQQ54RwI1D+uEX7omLoenGR8n8QQJ3KZ5RpTdUuKry0zBMeTyZ+jYBWneZiMQN/a2FIU5dId7pGyENdwPk2ZPg6L6zHSqVJtxGH1wUX3Enk97+JkSgvbvRTEXrxLVIlhN753/7DHI3810VaLUsrmbbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763804177; c=relaxed/simple;
	bh=kFo+cWd3FsEA77InQXoAwGerQqlnV47knYv1zjqj/9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jc/hp7Udr7Re29jiy6LvtMvm5pDWzHI+Di+4EPw6dOm52fuTEEHtEhZPC95yPOSKxwWTKszgQmzKmL5KlzOSuEsmMaG5gnZUb1pHwITauWQsg7C5+HMs76d+QbzYF9hyXlFiiVf9D4E8wX0vzPxZAdVwrVRnxOQGPn9GeL0kR0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LvTiWh30; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Rm+LJdlv; arc=pass smtp.client-ip=85.215.255.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763804173; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=V3k421HVoo3aBWCFJc7L3gxeFFQC4nuceZEmvPGOtCMnH7UruVl7trYRD+k6uW8EWQ
    3jhgyRBVq9RaXNcTgK4tokuDbJNd5yzQxCMkjmtOad2e7rUn/sOTLje3E1NgcTsUUk49
    S94IQBjYV3V6rauxlQxpjTkCTOwbPtiHxb9e12cRqxtbeNJIiSxDCYDO78rpnz0v0MHK
    PprewqIXJNaJHBsWSCUcpTtb5DACYBmIEzPHElUraK6tgGIAkEpr/du+X2sQ86RxM3q+
    mCizIafILqi3h0PCFpTtaW/3nHFcBpZUAcuv4J6PlPHCXy1kPN+ftExVRnsvfIZWRYz+
    3SIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804173;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BVTOWs4g5KEdda5lO51oBHxVDDNtA9WS5KpPLtm1fEc=;
    b=QCLpYIO5/kJXxFkyT569oD5SShElZo6RHWrwgIEJlqZM1ZUHI3jJ84VG9Pp2uEN+kr
    E+v5h8Z5O1fSjnjiEr9bgmuIrlPlsUdGfmjxAVM1t9tg1jdsEFcwCG2JLj7Megdow/ds
    3Z9HfzatAH5r6d8z5t1m7KXEwHNiOJsd5errGRxwQYs3cGqijSQQ2SDoyw0W4tCDmxl9
    IZylKNZWLuxq6L5lokJpqs93UuaNsleu8E0nUTl2pRh8aOqWbNCdMRFC9c2t707FYjPf
    nIsZ+Z5a2618QuhaxDMtn7mem2cyQ+1htoIEgewXvC++q8DlM+vHAAvsFyLx2WeFQcuf
    GLCg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804173;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BVTOWs4g5KEdda5lO51oBHxVDDNtA9WS5KpPLtm1fEc=;
    b=LvTiWh30Yd3RuGOhZOckhnk0UwKub2JYuvCPIt4aO7C4e2i/cG7Ay8MKxFUUJT3hLS
    fz0dWLr2ZTrIDSY69J6fn5k0JGyAZqwtLqJI7bRErtLusoEbrxgpMiv7XmZfVfsKFJwk
    ET1oxSHj3JbI8HnWpVNo+I7TN75aebxXXB04Pu3g5L7jaopyvILkOa9orLwIqlhNm35n
    iOv7Nv0YI62ccc7mQYJkNwu+r9IWQyLwVZ1MjWt6i0DuamI+eU/0jvE151YW+GynKw48
    QoYN8u1OYbfdOcgzcjclcaM4ZW0mVyCoVRN1U7P6K0C5L22zt/8mpplCX3EtcrwvA7yd
    xMDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763804173;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BVTOWs4g5KEdda5lO51oBHxVDDNtA9WS5KpPLtm1fEc=;
    b=Rm+LJdlvWgAmt2bcC+G497D0TDgzh/XaNUl9lzUPpO8EfA+FavYjsvAx2LhYtzHmx0
    buNO7Mh2dk82N+feP2AQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AM9aDFe0
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 22 Nov 2025 10:36:13 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v6 16/17] can: raw: instantly reject unsupported CAN frames
Date: Sat, 22 Nov 2025 10:36:00 +0100
Message-ID: <20251122093602.1660-17-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251122093602.1660-1-socketcan@hartkopp.net>
References: <20251122093602.1660-1-socketcan@hartkopp.net>
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


