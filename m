Return-Path: <linux-can+bounces-5336-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228E1C4F82E
	for <lists+linux-can@lfdr.de>; Tue, 11 Nov 2025 19:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D93F3ACF50
	for <lists+linux-can@lfdr.de>; Tue, 11 Nov 2025 18:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BDE29BDAC;
	Tue, 11 Nov 2025 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="FkmGtqth";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="lSnEUm0d"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D014B3AA19B
	for <linux-can@vger.kernel.org>; Tue, 11 Nov 2025 18:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.219
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762887130; cv=pass; b=YDqJ4sMejcMPQ0r+UrKHTmlybZC0WMYH78pLA0Aknr4BRNYWkwBQ+LKYcm+KIHOmx7nWMszlwfEiUfaMg0K3tzx7+8W5Q2fZpRNn8+272Uzxa9Y1zb8AwCCRrhb1pDunmgrOEqyeSDcb1nJ1pNQmkMMO8dxw5BQblE5mjzbwALs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762887130; c=relaxed/simple;
	bh=/TklQ1tYekzlD3w2l2MHP2TOpfdrh8Z34h++5wcpYHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qIJVlmMSd/4/WxmpkHCKOALV3Mnm0apQpELm6jwKa5xQMdGDuyjWhWtyflJL5uEmqkO1k3B/I3VsdmFIeR5HB7QK6i48oMuH66UwJe30/uXFug5I+4H36RbH+LXEb/zXdJ00ltEGrCEXQFxiqgCqKyXYWhpEjRT7w5t9WxYyDLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=FkmGtqth; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=lSnEUm0d; arc=pass smtp.client-ip=81.169.146.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1762887119; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=E0WdOWxqWpAp1bb2488Q7harhrWFxO4YLJ+BMB4CZHsgl7oXJK0Uwcl1B6qhwlb11H
    WkS0Ssd3jrPYhqQ+s+VLT8ew4LYnAJLZgxkDkH4NEUqAM6z0vO3wHc7uidkd8TM4cXxf
    5pMiahBo5rNvFJfuCZExM5F76LVnGv2iYt3s9jpyEpXjNr9XfxwoXduGr0Wo11bfHSpR
    fAiRTfaqu4/P0d2PtgMzHHiwulScYmXDb2JPhng5fyi4inkFOnI3bK74lsR/YI4DSLLr
    soSSTLJr3l2LY/hQly1gUrPinh1eQ+/RvGo1+jd41clWsqGm2jSZk8Q9tXTgmRXuWBWj
    pFdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1762887119;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=PqVpmc9+mZVLde+iPq15ZWD1VR2gDd9Iok6zWDkOptU=;
    b=IW37vlcLRmN31Pyq78/e264qq/jzzldPvfnFnj3atO2LgwMo24EQorhDCzIJCvOxlr
    KWhl8PQu+yCOni0xRYIf7WaTZRnGP03xUVeOTOyhq53B4Wk5iFQRvY3TVWwSK2V9XD3T
    DWAAnHxgnwQFCIhStv1l25AXGJZ+C3xLAxakTBNzyfQONJw9jyvrC3jHpOLF1icGOjlK
    TX1ITalayyL7SN/JLfyU5UOVDhSl38N62GcSQr6M1XictiL6s58XyH5XJiNKzcBoAdcQ
    MC1jzEeBcM5al+AeQLsJbYkvmxYWZ+Z2Hn2FFkWa4NQDPW0oc+w9/DIG6ZHmlYyQhW6q
    hGog==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1762887119;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=PqVpmc9+mZVLde+iPq15ZWD1VR2gDd9Iok6zWDkOptU=;
    b=FkmGtqth7fcXg7ZycJ/f/CaK7xDp+dkwryEfOL4j1A51YY9BKPO4OW0jn62Me4p79Z
    lIV0WzgyCEd9s+qrMRao9lu8McqgOut9pmuDgk5kMRyvqT0QSARNIchB5OwfCYNSy6Lf
    FwkutQTmFznHCyMO6TveT5Et+Yh9NtkmN+nZJDwk92WclM0eIOiK6cWh4pV39fPnxD6L
    Y37ekNFNay5KicwLhlWDUWcE/9FsfeExgiRX7uA1wyWGRIop1S+yPwxjRAIeE06/2DZH
    +RjcHZD/xYAaSiR7Jl/dQbS7sfW971TlsMbyXBu1bdOw7RxoDrjQgvYJeioGMvB239ym
    66Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1762887119;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=PqVpmc9+mZVLde+iPq15ZWD1VR2gDd9Iok6zWDkOptU=;
    b=lSnEUm0dNPBmaI98rEsBmDRm2W8eD9khPN7+0YC+oygD8SEbBzEY80ASaoelVHO9S4
    pbRyIDLOAjZie3BLE1BQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ABIpxPiA
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 11 Nov 2025 19:51:59 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: raw: instantly reject unsupported CAN frames
Date: Tue, 11 Nov 2025 19:51:52 +0100
Message-ID: <20251111185152.23193-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
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
 include/linux/can/dev.h | 12 +++++++++
 net/can/raw.c           | 54 +++++++++++++++++++++++++++++++++++------
 2 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 945c16743702..9c00bfd077bf 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -129,10 +129,22 @@ int can_restart_now(struct net_device *dev);
 void can_bus_off(struct net_device *dev);
 
 const char *can_get_state_str(const enum can_state state);
 const char *can_get_ctrlmode_str(u32 ctrlmode);
 
+static inline bool can_dev_err_signal_is_disabled(struct can_priv *priv)
+{
+	const u32 mixed_mode = CAN_CTRLMODE_FD | CAN_CTRLMODE_XL;
+
+	/* When CAN XL is enabled but FD is disabled we are running in
+	 * the so-called 'XL-only mode' where the error signalling is
+	 * disabled.
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
diff --git a/net/can/raw.c b/net/can/raw.c
index a53853f5e9af..c7311f27e913 100644
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
+		return !can_dev_err_signal_is_disabled(priv);
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


