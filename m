Return-Path: <linux-can+bounces-5639-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A944FC84FDE
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 13:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6181B3B170E
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 12:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF642D8363;
	Tue, 25 Nov 2025 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="s5z6loFf";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="xIc6kEEf"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D0018DB1E
	for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764074361; cv=pass; b=g1/FIudskwJUQwCoLPnNNXASqzRb/spe1yYIB9pY2/dB98P8q+XSvBJLwA8QE+yTrNNxVk58kyB4T7cDN2D6XskYw3+Wn3TkpCInLNztR1bamHUyTcIqsRaLK0jKxkUqwUhBskPZlPDwjVTdcAdLstcN89ZTr7Da7ewRd/K3iew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764074361; c=relaxed/simple;
	bh=kFo+cWd3FsEA77InQXoAwGerQqlnV47knYv1zjqj/9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eymTh4Y7WRPxIgCfx/e51nOUI4GE5+LAhSYmZ4tgG50w4X9wsGFDJwk0r06VpLircH+mQye60lyjoeOxfXAQR3av5GFkPeGDR29S7dy/RgcDwq1TyKywQgcDf7qn8RuQDZ7ybfajJYMub/YFINPPMuOTQfV+HTvlBgQMnZViKNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=s5z6loFf; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=xIc6kEEf; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764074357; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=W5e8J6y6bTyOVVU0VI5K87fNdVnUHDm8LZ+qwlGQWpQSOC67okc977QyT4zdZ9CfKH
    gRiQ6V3n8MHg02Ay6xpjbvYozl81Yxhz0KphCRxf4pV6xh2J0E1lg2NbWZ3KB+q6DjH6
    S1tFcugTA8yBeLIgUx1BGKCYv+YRgHfC82xdx2pIfFmTCfpCota5JivFff0jBMDZoBW0
    qufY27Pf5FKwLTftb7cWBt0F9ttfbC/nPvICpkzUqYnXIbc3T70BLYuL58+JB59SAdZu
    A30vWjX/JYEJZFRUGsWsf+qhkEw+kvEg8zaq6sZwmuHi/1fmiCJQ8zxTZY1J4GXAbdFM
    sNhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074357;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BVTOWs4g5KEdda5lO51oBHxVDDNtA9WS5KpPLtm1fEc=;
    b=q3NwiFE5yPYB6ZNSaiyYXU8BTy/7mn5GaL/njMBBwKu6t5tTrHcWmTpSYoTYPX3Kej
    r6V9bvXdBiPNiZ2EM50Tpyt4P4uwTer4I9+OHlGDE9LeV87RDCrwLrFmolD88WK/Tn6y
    FxtUZUDmKNwvAlq25o1VceivnqOA7ZjpJ6ZXYDVZ3NgceHNs6YA77LOxCfLzMZScMc88
    z56scV+Szy2+QY0ak/0RjS52lbASqRWw+LdfEITf+LQaCI0GvvoDA0DaWcPxuRpX7R8I
    mCzBFeryNU81qVMHLeEasEIF3Xu6+m507bai7bGOHmtmeD4SRGxswzM6aHGJWufCsydD
    6hhw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074357;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BVTOWs4g5KEdda5lO51oBHxVDDNtA9WS5KpPLtm1fEc=;
    b=s5z6loFfW+Hxae3nDPd1iqGt1gbG6QQLoYFhcgArP/Y7BObZBOw9vmqI+L/+ZukkN5
    dyP7t9dCQ42UavZmF/QBGMQzaUgv6Vsjd2QZHiC8YhnENaN8fijFe5Ay70AJxNO4W6Wv
    H4oCCQdAZLW5v7Cyg752x+OMJfUn3oqN83i/nfLpd4tFV0xj7O0+D6DFQmmlfgGyTwuU
    63LRYRZQHyq5SPOKa0kzZk/JqmDW6cTx/pUleC7bntcERsltxzjErlABP1ziqS9rrh8L
    wdosL+Asv9BBWsx9CCRw/Mk0CWa4TC7mW0VB5IhFqnEa6kugevdvM7xCmO1uEN80nXrr
    UK9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764074357;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BVTOWs4g5KEdda5lO51oBHxVDDNtA9WS5KpPLtm1fEc=;
    b=xIc6kEEf3ikjtlPLP2N9lZdJ0y/fA4Ra8x2CvwyHySafl921dVi6oMdSer/Q81cyOH
    7ty5PThRdubjSuMfoaBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461APCdHT8a
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 25 Nov 2025 13:39:17 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v7 16/17] can: raw: instantly reject unsupported CAN frames
Date: Tue, 25 Nov 2025 13:38:58 +0100
Message-ID: <20251125123859.3924-17-socketcan@hartkopp.net>
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


