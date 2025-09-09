Return-Path: <linux-can+bounces-4553-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26346B4A843
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 11:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB1A1886B5E
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 09:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DA9298994;
	Tue,  9 Sep 2025 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="I5sGfPIi";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="oy3zGtaR"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89342D7DEA
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757410068; cv=pass; b=MQJrFRxRnu0krgkjOHKOldpYS/lqYlhrSnB0/J7mw8vvwZyBYqhdDcZDRj5LDogChuUhiDo0uRJw+JNidt7kP0o/0VDoKx6xozRHtUGaXpSX/MuzZCHFC+fystVfmUfEaPRRrZGh9r7Iz2ol/v6qEyDpSjZDSubyw/YQj6n13b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757410068; c=relaxed/simple;
	bh=dyY9XcwVFebLg+TvXQZ7uTR2rwmywyf/khoypsJ3COw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wrzn++TmV7TMjGUecyPtce0U3geT/9v0rY0cYdJ8JgZPZjt27Jqf1YtYByvZlgxEGK6FbJpK9x+M47YvFOucbYn2C9K0rlgDwEQn4+PWSk8XHsp9bQBD7n4DCIn1AyHyD1PIF1frVLmX4fkv3CluPU9j5YTL1bPmxQcccdmcx60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=I5sGfPIi; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=oy3zGtaR; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757409879; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fy8nhAs2pTsMfs+gejpQyXzU+HYC0YzkwtZq/wH9yChbEBMvxPhOZLiB2BBCrAo/7U
    7+Urib0QlZXWQsbJPf3j7Eh+e2RGSTsGf/H/ATRc8n7iPIzGyvOL85xHoqp1WnKTim5H
    OvavYgE0h+eRgZTwMdfd9DCI7EIUC1ciS9Nb+H8Rje20ie70T9syz3PhfvZ2N9ORZ5N9
    NETtJhQTAHOtX5vUp0izWCVGtbMxJ+/WkAm/v8MLHksGgX++Kthfs1nBb6qLyUpWToYF
    eylVZHIGQooFR79hmhRqslOZYpF0GbyJ4N0iAyu3DvTwlbDCR1ap0lH+LAc2H3b3hNoI
    dQeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757409879;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Tq+cCLeue1y6DoQBvC7kgC1lSJlq/g0RcECXJAblGv0=;
    b=LIug980KNjn7U9gbKLyvzRopcbPhgGTefOwDkFBBorjGu6lZZvX9LdEilTn720UKJ3
    ASiioiJ7ARXT6gqrinCFo4+0nG0hlkUyrxLwsWTPFpwlipSKuk3HHi3LuNItAiAZBVgz
    UU+tNKonYzp6CO3OHGB8rBBPq+u0Q5AqawsWcu2yFAJh+pJc0NO/rlAga8rWBnRtxigp
    PcLWrx5TlpuBn9sHJHeNrDyuqlmcVPbl/jiCPcCKCH6Z1oAvWHWtMAPIVshRgJJSwk7A
    Miwwk+xS3BPhzJ2xn1Xk4tzcw51aI4z8e/JZgbmnNw/VIMj20YiohHWxw9msJ0dOpy9F
    pB/g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757409879;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Tq+cCLeue1y6DoQBvC7kgC1lSJlq/g0RcECXJAblGv0=;
    b=I5sGfPIieA9fV55yGPr8LXWEhZ9+11iPeoalNOkJZ9ReYwIKRIcvP1JLx9YURANMQw
    RM87skuu84O6MCRPqIqMVDh9OmGacUP5hp4T6GTaSb80QQ3B5ZTUggZXOXPfdsM59NPh
    9cgGJd4z8wOCSUhz/CoQdecdcH3fQ0tXyaYDEsPCzSNusm7vN+L5m9wDJ/DncXAW/Xh0
    vA4JypaiJLMyIXlUbvGdAWSVwKhc3BX6VeWusmTxctgzSWSKumQdWRr2r7/AyK2JHJtH
    YyKNY4qH1bAu4iTNAErrYrIptZzFpZoPhpxI+a+sjgTFr/dDLu3BhhzbyewL1Va0wytg
    3H7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757409879;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Tq+cCLeue1y6DoQBvC7kgC1lSJlq/g0RcECXJAblGv0=;
    b=oy3zGtaRKbKHoJa2o4qCW2grURPk5wgSVJE8pXsFEqQAr6onvUSj/yky2PvJEYJq4K
    OLZrHqZlrVRIjmQ3ARCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d3611899Odf7X
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 9 Sep 2025 11:24:39 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH v5 1/2] can: skb: enforce CANFD_FDF check in can_is_canfd_skb()
Date: Tue,  9 Sep 2025 11:24:32 +0200
Message-ID: <20250909092433.30546-1-socketcan@hartkopp.net>
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


