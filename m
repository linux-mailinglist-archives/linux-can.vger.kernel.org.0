Return-Path: <linux-can+bounces-4547-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FCDB4A540
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 10:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326B5188C81C
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 08:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C378924166D;
	Tue,  9 Sep 2025 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="NWBZBtiR";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="dtaacTj4"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F5823C8C5
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406473; cv=pass; b=Tz40EPJXVgZlynjLnBerfoipO5qeFF83Wnn1ADYVCArKFAPRbiAqCZIUqq+Rzv3Oma8PacZj1r8mFzC71cyVPNTi5WXw7jUnjXq0c4M5NyBYjUv3D8L24qc66GQcy69MIK5yTVOG+zq3bJDw74zMbnsfUaGsA2RWMfN6HBjPBt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406473; c=relaxed/simple;
	bh=2tTrBu9V1y4+vqiHv72FO+4m+H0yKJhCv20mwf7h4Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sh2uWuT5aS+S2d68ZlS6E7joi9GiCA0/ysfmIZfQq5O964oRG1nBOluJsyPpMDAs8WZKwLfmKyQBal/8DxvR/XgcInvx0Zp5N4J6wpolAz3ACjMn5nMwpucvLbJjgyFcse7Xm3DkrOF8QK+85zv/7N/xtdIrxPNwgGXVXwx3xl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=NWBZBtiR; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=dtaacTj4; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757406463; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iwzpD12NvmYNzv/3EP3LWEA3ma+uw+Fi82hZ4bZ9ZRYhig9sl9oWHQYnchQKKtImVw
    fAAx+Tp6tjQTDFe6Vgs0CT7VaqcxJ6EqqqRzrhBsqEd0MwuCK9WR4pKXdjGnd1EPYi7r
    DVxrgvXBa236fxSFQ4y7R//0UpOu8+vV76sL+D6xbfVhT159rb2OZF+cAeZYezw+iykx
    Elbm51Ca3qhWdYa0uTjNcKKCXNqbTb2wGzj5QKKo0dmSlUSxn0e7Z4a2oAVBkRw5EIhH
    5YxTdRwcyX25UMS+9n6lE7BS4QOPoonzu2uvUKfpcjwkMbzucQa0PAfsrfbw+GtDJW5O
    w/lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757406463;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=/oReRJHGnt834+mXGj0XWCLWZ/6Xmqlegy4Tk7tImRE=;
    b=eERX7msCDUbnEx5iEczJ9UDNg1q3G+CfuBLN9rrbMTtlImTDHBdR72aZFicFWV3BM8
    L3we3ZDN84vAarhzH/3yBlSN2AtCn0z1z7MctbJQXMtE3VpLuhSM1jcxzP7oP+I86JB8
    7eQT85dgizdqzQ5ZNDUSeReNID8sKm2V72aRMUj5dIXlab/MH8xrrw81Q9T0oWIxAQkU
    OcAB9WJcVbvsrFQJyZ0QBmo6aCMZwAItp4X9VcwL/tS8aDrUkU2FpbIFKkfoSAsY6Deq
    eMIuEd578XagMArdsjp4DRLbEk8kqtuymdiDhIzh0Q6qo+57wy/nN073dnzhd94WEhbw
    QjvQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757406463;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=/oReRJHGnt834+mXGj0XWCLWZ/6Xmqlegy4Tk7tImRE=;
    b=NWBZBtiRpzB00wLdnG+Ju4XXia0EkyHXcvT5SWhIRUkVHPgmdMGZx9rT7wlAcFXbYj
    aj88W4r5c3REqGMm8k63LsCTscocK3DFCkoijPDeN+Js9XRpHFB8DeC2gQ694ZvICRce
    ahH7OangAfMJoqZcewgKk53UGJqatfepkqsiUMqjp1eurovRhv9eyLYFXsSjw8SzbaGK
    1198ikAomcq1WLT4XYbDzaGr6WTXj3xkepaKNbeiCPIRSr7+a9Qefqx79Qy06awNTCWC
    bhjj8Wje4dn23REBpY40Qs9K5R5OlmLCT5ledHqI+bFAqwIcc/v5l8AXtHP8cjW8wOhA
    Q2aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757406463;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=/oReRJHGnt834+mXGj0XWCLWZ/6Xmqlegy4Tk7tImRE=;
    b=dtaacTj4w6SWsu/e4mNVNLVV6+TCG3/1/LexnsDKJsF/IGSHiLsUN1XmG1ZpJB61tU
    mcNxSRuPtpnr3/R+8yCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d3611898RheYi
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 9 Sep 2025 10:27:43 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH v4 1/2] can: skb: enforce CANFD_FDF check in can_is_canfd_skb()
Date: Tue,  9 Sep 2025 10:27:35 +0200
Message-ID: <20250909082736.9912-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The check in can_is_canfd_skb() is about a length check of skb->len and
the CAN FD data length. As a skb length of CANFD_MTU can potentially be
created with a CAN XL frame with a data length of 60, the length check of
the CAN FD data length is used to detect CAN XL frames via its CANXL_XLF
flag which exceeds valid CAN FD data length values.

To make sure the CANFD_FDF flag can be safely used as a marker for CAN FD
frame skbs the bit was set in can_send() and is now also set in
raw_check_txframe() to re-use the indroduced can_is_canfd_skb_set_fdf()
function. In the RX path alloc_canfd_skb() sets the CANFD_FDF flag.

The enforced CANFD_FDF check in can_is_canfd_skb() clears up the potential
uncertainty when using the skb->len check with the CANFD_MTU.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/skb.h | 25 +++++++++++++++++++++++--
 net/can/af_can.c        |  7 +------
 net/can/raw.c           |  2 +-
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index 1abc25a8d144..38d036b43280 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -111,12 +111,33 @@ static inline bool can_is_can_skb(const struct sk_buff *skb)
 
 static inline bool can_is_canfd_skb(const struct sk_buff *skb)
 {
 	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 
-	/* the CAN specific type of skb is identified by its data length */
-	return (skb->len == CANFD_MTU && cfd->len <= CANFD_MAX_DLEN);
+	if (skb->len != CANFD_MTU || cfd->len > CANFD_MAX_DLEN)
+		return false;
+
+	return cfd->flags & CANFD_FDF;
+}
+
+static inline bool can_is_canfd_skb_set_fdf(const struct sk_buff *skb)
+{
+	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
+
+	/* The CAN specific type of skb is identified by its data length.
+	 * A CAN XL frame skb might have a skb->len of CANFD_MTU but the
+	 * skb would have the CANXL_XLF bit set (0x80 = 128) in the
+	 * cfd->len field position which would intentionally break the
+	 * CAN FD length check here. So we can surely tag it as CAN FD.
+	 */
+	if (skb->len == CANFD_MTU && cfd->len <= CANFD_MAX_DLEN) {
+		/* set CAN FD flag for CAN FD frames by default */
+		cfd->flags |= CANFD_FDF;
+		return true;
+	}
+
+	return false;
 }
 
 static inline bool can_is_canxl_skb(const struct sk_buff *skb)
 {
 	const struct canxl_frame *cxl = (struct canxl_frame *)skb->data;
diff --git a/net/can/af_can.c b/net/can/af_can.c
index b2387a46794a..0caf75a9e27f 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -207,17 +207,12 @@ int can_send(struct sk_buff *skb, int loop)
 
 	if (can_is_canxl_skb(skb)) {
 		skb->protocol = htons(ETH_P_CANXL);
 	} else if (can_is_can_skb(skb)) {
 		skb->protocol = htons(ETH_P_CAN);
-	} else if (can_is_canfd_skb(skb)) {
-		struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
-
+	} else if (can_is_canfd_skb_set_fdf(skb)) {
 		skb->protocol = htons(ETH_P_CANFD);
-
-		/* set CAN FD flag for CAN FD frames by default */
-		cfd->flags |= CANFD_FDF;
 	} else {
 		goto inval_skb;
 	}
 
 	/* Make sure the CAN frame can pass the selected CAN netdevice. */
diff --git a/net/can/raw.c b/net/can/raw.c
index 76b867d21def..f48b1f3fd6e8 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -886,11 +886,11 @@ static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb,
 	/* Classical CAN -> no checks for flags and device capabilities */
 	if (can_is_can_skb(skb))
 		return CAN_MTU;
 
 	/* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
-	if (ro->fd_frames && can_is_canfd_skb(skb) &&
+	if (ro->fd_frames && can_is_canfd_skb_set_fdf(skb) &&
 	    (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
 		return CANFD_MTU;
 
 	/* CAN XL -> needs to be enabled and a CAN XL device */
 	if (ro->xl_frames && can_is_canxl_skb(skb) &&
-- 
2.47.3


