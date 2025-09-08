Return-Path: <linux-can+bounces-4506-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDE9B4874D
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 10:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25CC11B20D09
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 08:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472F354262;
	Mon,  8 Sep 2025 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="sDn6QjmY";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ELZW36+r"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B81E1E1E1E
	for <linux-can@vger.kernel.org>; Mon,  8 Sep 2025 08:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320439; cv=pass; b=FgDcls5OrchqNTEAWpUCHCC4dB6chGZi+Hfo5+kWuT/SJU2/pvCMjZVZV6+Y6JmhonxscAhTwUO4d0huMAxfJiOXKe41rzTpfxgrpEMd1vHwWb3qTxbUFPq1oVAn4CLsYjY7BATRezUeJFG6E7hQo6pMeeHn06+SJb0FqtFW5oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320439; c=relaxed/simple;
	bh=mtu0NWh1uLNPaUBWs1dO5+yPqcebFYwwtJ4nQ7JwUFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YMSZYks7Tgf3VClVNaiyhKXf8G48EKX9Ad1kobey9O0EHgTN38H0Jkc3V/5YGmKnn93tsQvnjbfCNetnt2aklmMFJ+IywH1+k7eBekHJseYjnyFdCcBE1bV2G+huWlwM7ORQdqP3MLudXhYAyF3gJdpzUjHawhfuoTkYbX5wVu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=sDn6QjmY; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ELZW36+r; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757320254; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=R+upFLDwxhy2vU1xfi7NyUBtrp0cYZHEg+MPNC4tQKew5ULglu0INxnHJsD1xLqSx5
    Jbqs11W0baeVoCzpiq5EaQGfjr2Xgg0ipJAZDuwuanUL+6JWqDlybUi03qPajsq4dtK4
    Z1PqiGr0tcRZ17MihWqvIxII1xOces/OG/vB5B6QSMtsCs6v1p0YSyaUfmjs8rjDpAUt
    Tf33JVBNNGJ4jZrZOYsDHq9lE/l6QrIK5HozKN1nTYb9Bp/h5+kuxlQzb8X1bOpntvRe
    ieZ0LHzFKmsS2JRZLT+XKNbDgGmu8uCbxi6jzrUT6+ejx8QcnjSgakl6ixRABGVu0fHZ
    lAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757320254;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=LYGMG2d8ocFWYVQC2Bf05833UeHEKGnK0zKEJ5yrwMo=;
    b=JMYV+4OoL8cjX2pTp7cXHdRH9NJX/vCfTPrvKF/ZjsHJ2UcL0gZuai5k+j+yQprpG/
    Q41WTG6LZF7bClqLdtlXM2cJfk9n6Cu7slCZ1/58XKjn5tThdGEzFTxAUopGtAdm30I9
    wTX+dPhF9lfw1tTzcVmy3pzMFbS+6AaX2W5u1XLJ3H/MGH4xTvG6Y24PRRIFrMNCf/nY
    8LpviBFidvFoJtuUeQhMUYWCCVPUXvhirkffH40xC/d8yX7MCZ84nD7q3MZbaLWGrMdK
    TNFzv8mlRnhFaEbyWo23Ty2CXW2j9rdamCyT0mCI8Xg44dw5JQpDIFg0HvYRqiiDpJ3b
    csNw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757320254;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=LYGMG2d8ocFWYVQC2Bf05833UeHEKGnK0zKEJ5yrwMo=;
    b=sDn6QjmYdJveqI1cXzhuU8cPvsro8JJEQc6Is2wHOnLDfHEXjBaKep9CIHWHtYLzi2
    0GjxSag2hhzpP7Kq7PGKnKmYaUQT8pZ5XqGcL2sOo4btLpPSbkGTTihowIwo0asJ53Sw
    VoMpdjYfyr+g7Cip4Q2TXBlIGXvf1t0dZsYwChk9E3AEXGjQltPLRLmFLXg1X6nkeGRB
    ZAj1MaC6Mq4Ji93QBMJvhdt0688g/QpqJRbp94oPf+VDSRg34imzrCWgNyltSMtCTFnw
    hm9Gp5wDG31Y87fWZCTwUcPPoJ2OiX6sL6jE719DNSozBCzDA03/Q/qtExaD8BkemhCI
    PLWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757320254;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=LYGMG2d8ocFWYVQC2Bf05833UeHEKGnK0zKEJ5yrwMo=;
    b=ELZW36+rWZGAQbWzL+rBiDAmIi25+iaOYNxrNU+XI53cTOYXCpj3NGs/rPFiZJDAny
    /6bS7xTHIOx2EhCM6pAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d3611888UsXtc
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 8 Sep 2025 10:30:54 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH] can: skb: enforce CANFD_FDF check in can_is_canfd_skb()
Date: Mon,  8 Sep 2025 10:30:41 +0200
Message-ID: <20250908083041.1723-1-socketcan@hartkopp.net>
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
created with a CAN XL frame with a data length of 52, the length check of
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


