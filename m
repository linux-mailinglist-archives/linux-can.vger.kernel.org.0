Return-Path: <linux-can+bounces-5591-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4B9C7CBCA
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 10:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67A253A86CD
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 09:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411432E8B7D;
	Sat, 22 Nov 2025 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="bZMZvDfQ";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="/CN69yXU"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7EA1E8826
	for <linux-can@vger.kernel.org>; Sat, 22 Nov 2025 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763804181; cv=pass; b=QkLDkZrG+PXfKwXRLL2WMwwYEqCSPcC6Qfc3VdtzckSdIgyof5YstQkmKXG6OdxfEu2xUSj02B2EuLGgyVFIKwBqy0/t5fL1WsglQqZtIa7801cHAQbMsnOeJuCjeP3cZBih2FWLSCY5E6cJMHeYI0+4YqCaMFiWtc1upUUp9t4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763804181; c=relaxed/simple;
	bh=odmNXRSVHCJpaxQaUGaHTVRhSe1XmlYN1erWE0FO0/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7F36tr/OEVGvwaXmtSYsDZGfOisAyy0AtjKx4c5V3gHGowPaNXKVawhPSNYbIK37bIJ3KOaVL7QXyIx/iOiGLn9DIquUnK34oxmCruexbG8OuSRElITpAKynb6ZNnHt4Z+VR3CxUR7gMWmG0EJ6Wh2YQWtolSkl1XHmIcHS1rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=bZMZvDfQ; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=/CN69yXU; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763804170; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=p/jcjSacHKAVv3vGZXVklBKjBz/32XHo2JfpcX3xpW0VXqaQ59ZPnosmJ3Pqld/rYw
    gaYQs+C/Etz5jEifQSiaKP0lQO9asctlUr2lCsviaVPlhxyjTEzTbe+8EZ/DIjpvQ6MA
    HKYDzghGL1jPF6aDHS/RaLiCIwTl8g889d+0gtADvVuRDsACWq2NWk8Wt3Fvdzw7BnMo
    Rf/cMBq/+QH0cqze9SU6fnqmfOgKsFMgXT5sA5+IvEtpGsJexUPIsUVqIsR/n4sLdkn4
    EpKzsl1SKCgkc+lXOAVK2fxeFGXOpd6UY+bjxQxBfPcEDZ1XfQ5X6Yl6mDnAwBrkONER
    fuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804170;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=R2HBjICR4zHJ6NbAEBWhWf91SklrpfIglkI8e4mDEwg=;
    b=bmun/dA2GEoxuhQeYdchsnF7N8lzOjzKpnSMLHCiVs82LxvIqlYJYxqgObe0Xwcz4a
    j0M7lDoCNb1NNrpQxo5MWiaMTeWS8l52cAuqnkup/CnYda/DD42z1i+OfDbvS0i5/1FP
    9/ech2z1ypVLziA3d6I08WehRSz/nSysxT8xoc8IituyZyqr04pTdQ9rjFirYyu4oVvT
    mi3W+pHNQxuWxByabWHzjcz80v81F19LbduAhaKl2QXp8+wXYNmSReQ6uGyEKFdv/rGZ
    izMupGUaCxRXf2EJhHjzeNBsyRkaxlwDsFRoNfIcLLjSsHS26by0X2bMmB1nMLN5SIna
    Znzw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804170;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=R2HBjICR4zHJ6NbAEBWhWf91SklrpfIglkI8e4mDEwg=;
    b=bZMZvDfQEKjZyIWbyD/7TCz491dTSIrzAlzpJGOtgYGX0JOAbEtoh+/MWsHefAZn+x
    hXLLuHmRSJ+l/MUNbLsUjqCbYDWYu2X8ozurBzWzei3yI00FoSUvZz4f2PSvCGJ9zBrk
    KoEU9aHYQE4WmBfPNCh2kKMUS7uJfFVrITg2b3Y2c0d2RaqdqRbv0a0uSN5pMJah8Oi2
    bfFPyFDROBsl3X/wxdXLVfWI2xrplHZgz0Ux3scyv11TckZFkaiDkydkWvpbfomAkrxD
    Pc7uX4sdp+d26zI2bbk7I5456njwL14cUrYtjzfg+tfC1mkCiMVSrZfryTMYXFHcDtwc
    tf8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763804170;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=R2HBjICR4zHJ6NbAEBWhWf91SklrpfIglkI8e4mDEwg=;
    b=/CN69yXUc2a7t+qDFmUiAva9XJIrzp7dCtAQp91tG95K0wVKBhFDEFoZhWjbmsPoWl
    u50RbI0gMuboq3uSoyCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AM9aAFdr
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 22 Nov 2025 10:36:10 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v6 07/17] can: dev: can_dev_dropped_skb: drop CC/FD frames in CANXL-only mode
Date: Sat, 22 Nov 2025 10:35:51 +0100
Message-ID: <20251122093602.1660-8-socketcan@hartkopp.net>
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


