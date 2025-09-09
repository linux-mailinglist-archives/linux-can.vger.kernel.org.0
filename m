Return-Path: <linux-can+bounces-4580-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B901B502CA
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 18:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018384E7131
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 16:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B3A25DCEC;
	Tue,  9 Sep 2025 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="CFFzQ7b/";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="c9UcGvET"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911A123E34C
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435835; cv=pass; b=FA/I/w0ci82zPgWdGPkwuWwng2QRc9Im0xlUL5FtPnF2/RGhpzRyWVJJqDwwwMy8NTgOIgipwrpoCz7IxFoVHkzYWoH9/D6Qeh8cuEW60YeqpV5MnjP23cMomBUxtM3PkyC2fF/e0l2NoJ9IU40QA+xRVxQ+Ar5XjQ9amza0978=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435835; c=relaxed/simple;
	bh=dyY9XcwVFebLg+TvXQZ7uTR2rwmywyf/khoypsJ3COw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D4ZqydgSXwGY7edGc/5VmhjnEsyzV7jrAmOcNPkY2t4GL0b/VXn7OfPpYzcyQ4t+NlruZl6J5+rA5I+KAgWdoz1rYdAntJL5X94LB80VMgEtQiRcGVHW+clGKQU2GDsCNteYVZLPBAClN5Gxg9JHyQBzsYop9Ifa9AnV4ZVdAb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=CFFzQ7b/; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=c9UcGvET; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757435830; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=G/inmS+yn9NyFRKv4N7hq5VQedApSHNYLSr9NlLVqZnHxD/J/WJpZ0Ob4ujGj8k0zh
    hpG44551CRzD0gfnEJWGQL+q+9xwGDXGWGpqBa/MX0BzZPqdRJ0Xwa06oOmmp+Un90f6
    AbfiQrLZF46dhu7JFzbZVDewXptyG/wmSetGi2xKxdwKm7leyh0ThmFfLe1Vq7sEwWzb
    MI33ZQz39+T0AVBuYRd+KHFTbWtZOM+Yq8srVQ/RRdpxowk5l2iaISkvxWUAzNsr+V3e
    3O7zUCrgiYOlFLM7pNeEP7dJW1HZnEEz9Llfr9HAExpOfbWiVIvfvOSlqE1T3fgU3yrU
    12eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757435830;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Tq+cCLeue1y6DoQBvC7kgC1lSJlq/g0RcECXJAblGv0=;
    b=EpQMeJD0NCMiaIenxqXeDSBFAjSX0hspwcKIIaG9ATUs8b7OK/f+6JdBFJ724Qcu7t
    qNYFwmmZg0jraqjA6sM5dw7oJakIjUPTBLgLEwFs1eCnIuIZQ/l1wtdm/1ERM9AfAmED
    6+haQwYYVlGxGgSeIC76iP/aosJHuc2ri3I8ERFYGKsIm9g5RMSoca6F6gula+Ut+OgX
    83ueWMWEKetvPR7a7WCm/fZJyNwvNQbbf/SjTCp09pXcCq41Z/4y0TKly0X4EbCFvFh8
    huGeNV1P/GWH7sBxBHgAfAp7oQY4JNhfBEqOlJLf+RK3vmJvMUmtOP4Pqblu7VS34exV
    KOuw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757435830;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Tq+cCLeue1y6DoQBvC7kgC1lSJlq/g0RcECXJAblGv0=;
    b=CFFzQ7b/KOIR0wkinIzViX2LqQYRNEHwFqKwiXvpgz+fC0cEs43FIDz2tRSE3fTLzF
    wIF+03R+wsogwSBQwSf/vwpD70dpCnZ9V2CTN/Af5yQA7Ynvgvsbbf+JmtPg9WFS8Rbn
    UFJN2Y1IEYgow6UhB1zZIKzW6+QrcybkkKjz2eFvvfXxmDLsaHhemGxO6uc6WIXrybrO
    MM4dSV/rU2Awo3KcUVn14fK1ghPpJ/FOn3/lx7MWbLGKOAxuWUl8U5+ruod9X0mGmUhe
    qGseduukaCJ+SM8pZjw8DqWPJU3yBNicmxGGqzsPXYz1qjJVs+9KfQz0so1FmM4BN9sG
    2fGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757435830;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Tq+cCLeue1y6DoQBvC7kgC1lSJlq/g0RcECXJAblGv0=;
    b=c9UcGvET0LudN+qTSlT8nBYFt+5NoT1w7swDQ24cH3uM6pgjA2/EMcecn9uG+EGSX+
    BRnFeGoOL8FVZLxl3uBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d361189GbAhPK
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 9 Sep 2025 18:37:10 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH v6 1/2] can: skb: enforce CANFD_FDF check in can_is_canfd_skb()
Date: Tue,  9 Sep 2025 18:37:01 +0200
Message-ID: <20250909163702.17755-1-socketcan@hartkopp.net>
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
frame skbs the bit is set in can_send() which is used by all PF_CAN
protocols. In the RX path alloc_canfd_skb() sets the CANFD_FDF flag.

The enforced CANFD_FDF check in can_is_canfd_skb() clears up the potential
uncertainty when using the skb->len check with the CANFD_MTU.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/skb.h | 19 +++++++++++++++++--
 net/can/af_can.c        |  2 +-
 net/can/raw.c           |  2 +-
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index 1abc25a8d144..09ab4dc83199 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -107,18 +107,33 @@ static inline bool can_is_can_skb(const struct sk_buff *skb)
 
 	/* the CAN specific type of skb is identified by its data length */
 	return (skb->len == CAN_MTU && cf->len <= CAN_MAX_DLEN);
 }
 
-static inline bool can_is_canfd_skb(const struct sk_buff *skb)
+static inline bool can_is_canfd_skb_mtu_len(const struct sk_buff *skb)
 {
 	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 
-	/* the CAN specific type of skb is identified by its data length */
+	/* The CAN specific type of skb is identified by its data length.
+	 * A CAN XL frame skb might have a skb->len of CANFD_MTU but the
+	 * skb would have the CANXL_XLF bit set (0x80 = 128) in the
+	 * cfd->len field position which would intentionally break the
+	 * CAN FD length check here.
+	 */
 	return (skb->len == CANFD_MTU && cfd->len <= CANFD_MAX_DLEN);
 }
 
+static inline bool can_is_canfd_skb(const struct sk_buff *skb)
+{
+	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
+
+	if (!can_is_canfd_skb_mtu_len(skb))
+		return false;
+
+	return cfd->flags & CANFD_FDF;
+}
+
 static inline bool can_is_canxl_skb(const struct sk_buff *skb)
 {
 	const struct canxl_frame *cxl = (struct canxl_frame *)skb->data;
 
 	if (skb->len < CANXL_HDR_SIZE + CANXL_MIN_DLEN || skb->len > CANXL_MTU)
diff --git a/net/can/af_can.c b/net/can/af_can.c
index b2387a46794a..7fd2ed510440 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -207,11 +207,11 @@ int can_send(struct sk_buff *skb, int loop)
 
 	if (can_is_canxl_skb(skb)) {
 		skb->protocol = htons(ETH_P_CANXL);
 	} else if (can_is_can_skb(skb)) {
 		skb->protocol = htons(ETH_P_CAN);
-	} else if (can_is_canfd_skb(skb)) {
+	} else if (can_is_canfd_skb_mtu_len(skb)) {
 		struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 
 		skb->protocol = htons(ETH_P_CANFD);
 
 		/* set CAN FD flag for CAN FD frames by default */
diff --git a/net/can/raw.c b/net/can/raw.c
index 76b867d21def..e5e3952b0e09 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -886,11 +886,11 @@ static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb,
 	/* Classical CAN -> no checks for flags and device capabilities */
 	if (can_is_can_skb(skb))
 		return CAN_MTU;
 
 	/* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
-	if (ro->fd_frames && can_is_canfd_skb(skb) &&
+	if (ro->fd_frames && can_is_canfd_skb_mtu_len(skb) &&
 	    (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
 		return CANFD_MTU;
 
 	/* CAN XL -> needs to be enabled and a CAN XL device */
 	if (ro->xl_frames && can_is_canxl_skb(skb) &&
-- 
2.47.3


