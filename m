Return-Path: <linux-can+bounces-5754-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BF1C902CE
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 22:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039AB3AA8E1
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 21:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB4D313E02;
	Thu, 27 Nov 2025 21:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Uzw7fxh4";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="rWpr80g8"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089B9305E28;
	Thu, 27 Nov 2025 21:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764277686; cv=pass; b=WC52D+PyNqRFISATwX8yjf75BOxXCsi9t76Vgc5LRErnRwR93aIQpdU4tmBIRGRGXbn3gcWKiTpYSwU2lu5di6nH8nKH9b59SscCv/C/aC+30Aja47/SDQJcSBEWeEqZgCM6eoacdvwkxWZ/xPR+Kj3uD8hOWO/q499WCx7F388=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764277686; c=relaxed/simple;
	bh=hYnQf5OORS1eNmLfHb/yHxGMlHy1Hf50VdgLGijes0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dCYipnvqMYq1CM/y0ot5bMc4AW+pZvv8W/wR7j1OyOsjbV6JdPncdlKDQI+P6tOQWLhsUMrBns3Wm/nff9glwfcUUogXEqHRv7ibNZ3YTvxJmo4uMtgbSVrtzJSC4m3CMz6Hb4XDsE3IMn0/zgIPZH1yDpZCEOv3uJ1lgt14RvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Uzw7fxh4; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=rWpr80g8; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764277661; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jZtrWWKgjeXIj3CBDgxDShRI0DNUO0oR6DTnt0VvUE94J3tG+rML5cMAM6xyWt1ymd
    qV4e0aXxVI1oVMeDhpishllZWwzqrgHU30bL/+7Sn62qg9n1OVZYgyz1EoXEkzPYP+1q
    vLx0w47QmL5jFnBCev0fkOUbCq9Sm134ffsvU7bzolKgAJQkKyepKxs8EJMC8RNkSUfc
    CY25bTw72vrvriatRgGym5oDL88c9g7tf/JQCWb20Rxz+bDuJTf1+FTpGUZif0fBDvI7
    S5BpJk7Id+snMB/ATTgjBftWrOISY4TUH6VQKksI7mlh+E3wZ8pmx1KuleNHTLIRTP9X
    Yx0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764277661;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=dYOBhnmaJLalmRTcFXcEdjjp5HKm9Nxmm+2azfoQxjc=;
    b=YHVEXuuG050LMS4/U/xz7uNet+EqqhbQ3/I38JBNgv8W69u1jSaVuVGE4BrI39IK03
    6pBtjYoAW8CzythfVHiOWWOY/oieHDcgmFQr39/RoO26DlkIOP4LbDVdscYX8VZXuQtA
    PPYOvrHN7i6puJ7hitMF7vkIQ9Gvb5vOCu4I60kRh4mgC8qPti7PB4bSF9/iO49E9UqH
    FG2Y+mHn0Xnm+fMzoOdlK1iZ2Hr5YFSXjzya5tVFjbYNNkexWIFwGEPh5kkildGfijxS
    /bS1uj9YhdyzeiCUQnrje65nXNXZMYFO6AL7vjJ1zWcmClgtslbRy0k4bC68Bv8H0nSN
    CBtA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764277661;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=dYOBhnmaJLalmRTcFXcEdjjp5HKm9Nxmm+2azfoQxjc=;
    b=Uzw7fxh4NXnuSlNkPXFweJAckZXeaG1nqauNWnXECFip1/t5i74+83i1sDk91r0hFf
    gE4CE2gYLpeK54+J3SHFnwlUm46OTSI8qKjh2CFP8seZL3iXHYnNVPL19AUhuMianvJG
    PVMYTmQ7zb6GcK5yH560dT5zeqB3ZSbvfci4i9tcSwgFa/08Nru/ZeMEm2bm3mDhvMkc
    h4PQ+ywK3CT/yQ8IONEHvqMTiH0cguV4wDXPiHvjc6YqdvLVQycSQAC6USah3dSMNKSG
    YZTq/+1t124xg0xL9rvFi6td0yvfe33XjttHbY9EBraQ0eVXFsQilLwbUonsvibWCIhs
    llWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764277661;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=dYOBhnmaJLalmRTcFXcEdjjp5HKm9Nxmm+2azfoQxjc=;
    b=rWpr80g8R0uktyinaSrnIeZofF/iS1rx0AMCWDmrrjaRUd8gD9mR/9x/ORFu9mHkwJ
    um3JmseEDsJD2B2QQ9DA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ARL7edAO
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 27 Nov 2025 22:07:40 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	kernel@pengutronix.de,
	mkl@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [net-next] can: raw: fix build without CONFIG_CAN_DEV
Date: Thu, 27 Nov 2025 22:07:10 +0100
Message-ID: <20251127210710.25800-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The feature to instantly reject unsupported CAN frames makes use of CAN
netdevice specific flags which are only accessible when the CAN device
driver infrastructure is built.

Therefore check for CONFIG_CAN_DEV and fall back to MTU testing when the
CAN device driver infrastructure is absent.

Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
Reported-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/raw.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 223630f0f9e9..9d5c43df06dd 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -890,62 +890,66 @@ static void raw_put_canxl_vcid(struct raw_sock *ro, struct sk_buff *skb)
 		cxl->prio &= CANXL_PRIO_MASK;
 		cxl->prio |= ro->tx_vcid_shifted;
 	}
 }
 
-static inline bool raw_dev_cc_enabled(struct net_device *dev,
-				      struct can_priv *priv)
+static bool raw_dev_cc_enabled(struct net_device *dev)
 {
+#ifdef CONFIG_CAN_DEV
+	struct can_priv *priv = safe_candev_priv(dev);
+
 	/* The CANXL-only mode disables error-signalling on the CAN bus
 	 * which is needed to send CAN CC/FD frames
 	 */
 	if (priv)
 		return !can_dev_in_xl_only_mode(priv);
-
+#endif
 	/* virtual CAN interfaces always support CAN CC */
 	return true;
 }
 
-static inline bool raw_dev_fd_enabled(struct net_device *dev,
-				      struct can_priv *priv)
+static bool raw_dev_fd_enabled(struct net_device *dev)
 {
+#ifdef CONFIG_CAN_DEV
+	struct can_priv *priv = safe_candev_priv(dev);
+
 	/* check FD ctrlmode on real CAN interfaces */
 	if (priv)
 		return (priv->ctrlmode & CAN_CTRLMODE_FD);
-
+#endif
 	/* check MTU for virtual CAN FD interfaces */
 	return (READ_ONCE(dev->mtu) >= CANFD_MTU);
 }
 
-static inline bool raw_dev_xl_enabled(struct net_device *dev,
-				      struct can_priv *priv)
+static bool raw_dev_xl_enabled(struct net_device *dev)
 {
+#ifdef CONFIG_CAN_DEV
+	struct can_priv *priv = safe_candev_priv(dev);
+
 	/* check XL ctrlmode on real CAN interfaces */
 	if (priv)
 		return (priv->ctrlmode & CAN_CTRLMODE_XL);
-
+#endif
 	/* check MTU for virtual CAN XL interfaces */
 	return can_is_canxl_dev_mtu(READ_ONCE(dev->mtu));
 }
 
 static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb,
 				      struct net_device *dev)
 {
-	struct can_priv *priv = safe_candev_priv(dev);
-
 	/* Classical CAN */
-	if (can_is_can_skb(skb) && raw_dev_cc_enabled(dev, priv))
+	if (can_is_can_skb(skb) && raw_dev_cc_enabled(dev))
 		return CAN_MTU;
 
 	/* CAN FD */
 	if (ro->fd_frames && can_is_canfd_skb(skb) &&
-	    raw_dev_fd_enabled(dev, priv))
+	    raw_dev_fd_enabled(dev))
 		return CANFD_MTU;
 
 	/* CAN XL */
 	if (ro->xl_frames && can_is_canxl_skb(skb) &&
-	    raw_dev_xl_enabled(dev, priv))
+	    raw_dev_xl_enabled(dev))
 		return CANXL_MTU;
 
 	return 0;
 }
 
-- 
2.47.3


