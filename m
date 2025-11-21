Return-Path: <linux-can+bounces-5569-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B31C7B889
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 20:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C611F4E29D5
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 19:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC3D21578D;
	Fri, 21 Nov 2025 19:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="kchOi/jl";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="yL6Zmkjp"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E212848AA
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753733; cv=pass; b=iLTn7J+YnjL993DbK63Eote4+TZSk1LCqr8kUxizZijGwYu7HBDTigNzQsH8nEgnHrRzgu8lh2nuswlrjdthPWU+Pzhq++dL/evvwyrXMR4jrdUMl1IXEp8qLn6asxC590eD1WeJoPe//RWVnTZZPOxr0izPTQAGOIvmXok6Ytk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753733; c=relaxed/simple;
	bh=odmNXRSVHCJpaxQaUGaHTVRhSe1XmlYN1erWE0FO0/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPU5FbUvJbj8pEWV7pA5nqQarbKUO+Nixtw/ffSMjYHQPVib9DaXqXSzNjpb4GOrgC8TWlRSk+PgG8Aco69zxcKmUWy9hthQrgJqWP8hbm2QyrKchr01e7PuH94uBEfMIjmA1HFBzHevqFtQ/nsECEdGA+ngGHoMKvdu/cFB4iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=kchOi/jl; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=yL6Zmkjp; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763753728; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EyetroHb7hrsANETc36bKyDncw6b4KsHJUlkBMF8UNrWA6cFv2JNcuNsrg3/xeeMBv
    jBoAwtBis+YJRI5TLQgMh1xYisLd73zOunoJUKMZhotZ6KCGiozHSo/wpTqvywGSLVRf
    OgUG/Omkc8N95oP2puzfaVvB+upL5F0Cf07scnM9x6mVhoAu6pjnxZpHHPA/Ox0Xzdfy
    iNOBCP3dQZeqsVKDZrPXeKjrjKoDKHuM8+vR91yWthaiIPSbvvrGnSy2pIRoFfq7Qs/8
    scIU98KecM32nzMWnxoOYWPZemLW8OYogAfs8m5xWja8/8XVC39pYrTXvBi2dSmskTvp
    yeAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753728;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=R2HBjICR4zHJ6NbAEBWhWf91SklrpfIglkI8e4mDEwg=;
    b=oWePg0NPlnhTd3wXn+19C7wSp1aL9b6nVGvl/01IRvj6rWGEPnlJ6MaDYk7sXVlMdc
    gsupSKwUde1xKQN5P2sUH72E6zdPlAVXm8iJ5iectKCHsJUx2eeNmRU+HZL+uvTnqN/T
    pSFO2OXBqoB2M8YvdTeXOF8bnPZUTWctJrhWiBuh3KBdbyaEL8etwL/dUQY6+HPYpoAT
    1ot/ETXohFbGzh55AcaNoIr5uYX94TYqEk9fKicqQAyTZ4r1DNmzMxIovMHAAe5F0Nyn
    unRPVUJMwakqwcbFxdxIst268QyTHs+Tb7ql0VOD/rzo7MDIFt3R8fS+heR33kydzKsz
    S5+w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753728;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=R2HBjICR4zHJ6NbAEBWhWf91SklrpfIglkI8e4mDEwg=;
    b=kchOi/jli8/ba740km82Jml9hxgz5EbOuIl6/sVrMR5K6KYDAkl2mx7+6DbZCRlzAW
    RvbGl4Atuwyw+n6EUpqeIZm8Lz6b6bQnDAuDkkMGyVo/atn258+YkGMrT7Ia98OCuFW9
    llx4UI0ncYNPyU+I+XPs2l7TZELjpL+xXGpd/dEHOvgZuYqhDCqCkmOjZz7t5r822/q2
    nPXpJZ0dss101WkeZ32Vq6ajn19S99y4S41E0wlZFIsDe3trbtDbcvs8RgfDraa61s4n
    isPeLcXXAVVAWuJ+uNIa7CkGOBTQQTHZB79TwZSJXDHOEnBk1wIRAWH/CbE2OI5TsSs5
    REHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763753728;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=R2HBjICR4zHJ6NbAEBWhWf91SklrpfIglkI8e4mDEwg=;
    b=yL6Zmkjp+hXThFIo7QGso3eu2qbP/R0OIVXBdKC3MEm09Q4YNvXI36+bjrNI3QgO94
    JrM8niat9DCReoYO6BAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ALJZSEn8
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 20:35:28 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v5 07/17] can: dev: can_dev_dropped_skb: drop CC/FD frames in CANXL-only mode
Date: Fri, 21 Nov 2025 20:35:03 +0100
Message-ID: <20251121193513.2097-8-socketcan@hartkopp.net>
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


