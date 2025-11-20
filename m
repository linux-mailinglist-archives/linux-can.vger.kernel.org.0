Return-Path: <linux-can+bounces-5511-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A01C0C75F54
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 19:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2708E4E0F90
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 18:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3368E19005E;
	Thu, 20 Nov 2025 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="B3X4all3";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="2pCCUXx2"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D531736D4E5
	for <linux-can@vger.kernel.org>; Thu, 20 Nov 2025 18:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763664331; cv=pass; b=ENmqsxlhmiA3Cshz80dYT/zI4CJtKLWKUqCsUXM/aM0pgbCCvZ+Lf0MHeLFQam2p1qnyUqR1hFreM+LIXQPxKeq5s9uQNf5B15SvhAqi/arryWaF0Y1UfuQFrlHrZndSe2DbvF1xsZAo0TVvWexpQvGYMmdDft6rzzvXgCWBIv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763664331; c=relaxed/simple;
	bh=odmNXRSVHCJpaxQaUGaHTVRhSe1XmlYN1erWE0FO0/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RtDZrl9hg4cMLiCuXDNhWLOXWwo6b/1TnGMFNuRMFkDWWd888U9guu0MZL0U4SxuUaf18idn2Q9GzymUjftCgBG7ucGD2QRJfzpwm5vnCFMnXXN25ciiBf8JyaKzRBLdDDs9oXIgczyEhw7njvdgZJLkrrLQddMKB3dDDF+KR1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=B3X4all3; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=2pCCUXx2; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763664322; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=eh8eTjduufyj60Yc7vwfIxCP2ypC84qgCQrSaygcmheUaIx3nTxcKX34sNPI858sxI
    XAkD8d4JF/pAGMM33n4oVUgulJkHN9V0klH4dXXGfJbkvNysIRKEvLN/4GKP4V3seVoG
    mJ7imWmVANLfpeeGqN4tmTnI3y+ZKbzlwxSvlywQaBpQv4BImPHmoRNfI2zxO2ITDPnw
    HrBCezcvEr0i7jCCuxBwm7T4iZVuUuaDo9qGOzDiGosAHcekpUm27WXov4C7lr2g5HAc
    /Ff6SJf5BaTvnzPPy02zjSmyLadCwRZH33piTSROEzOisLOgmzYKt4crMnDqTRbxLLf2
    ASMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664322;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=R2HBjICR4zHJ6NbAEBWhWf91SklrpfIglkI8e4mDEwg=;
    b=Lkx1lZ0ybn2zjHnNsdfhZMQYVnHrvFUWmyHW9dFKZZWukINueNIxDa6rBLKyYg+Y/s
    l6sGqGXd1c51SAQqeNfquntqkzIlDtSOkcQTyL8SR3A/bSnEHfATRB6z0At//xXVii7G
    LxITr6fxudJucb4WO6ZLMzjJZ4OsRxDMWOMkPA78BOZRkOhkgapGuOeaOhQ5unCbo0/p
    HqLWni1H1brDWG/dkymosKJPv0oiWRW81/ZEq5Ej1+pPwcYlBZ2Z3OG0IRphHI3JLYpt
    KZ1ObsDFIYeh2L1WFa5T0y9IZ4c0Eeb31dEtA3Ev+cwNVrf7LpbbbE4EDQuu3XiMeD/c
    atow==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664322;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=R2HBjICR4zHJ6NbAEBWhWf91SklrpfIglkI8e4mDEwg=;
    b=B3X4all3on6+mdOXAnWMm2VZWl/U8dnvtOX5bHHmlu0KD1SAtQfdbWYPAZSwbujdfT
    gc588bcexGydcYB/ncBGC7xEPmwmztNZxsB4nql8OMouCSasxqlM2PCG/ZUJM8g5SSCG
    qzK/9VqV6kj6haCQTyqE4HJMeaBHTt9c1s0eF0seONRLW9qN5jltBOX4jQG4bHcYxPLs
    YvbM60KLgL/IUpECjbJzlalbwao7e6HE+sDKnhBAGM2iVz7st+i0L98Bccbmt+EAS22Z
    Sgt22up9bDVq2z0accJ+/06ntOh2Wn821c80a8PVpW0yq9iWsA5vUxlAFQJU7lMSI9G6
    JBQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763664322;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=R2HBjICR4zHJ6NbAEBWhWf91SklrpfIglkI8e4mDEwg=;
    b=2pCCUXx27mULN5/ayQGHOkZNPMAb8oScks+XF2lYGaHEDRQHJEMIet5zjBqHLqsABc
    I4y1ZXma2fuc4mm1y8Aw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AKIjM9DQ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 20 Nov 2025 19:45:22 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v3 06/17] can: dev: can_dev_dropped_skb: drop CC/FD frames in CANXL-only mode
Date: Thu, 20 Nov 2025 19:44:50 +0100
Message-ID: <20251120184501.27597-7-socketcan@hartkopp.net>
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


