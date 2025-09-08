Return-Path: <linux-can+bounces-4529-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DC6B4988A
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 20:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5DB206D7E
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 18:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058FF1CAA92;
	Mon,  8 Sep 2025 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="b7kk10rr";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="3ZlUlV7Q"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210A9315D25
	for <linux-can@vger.kernel.org>; Mon,  8 Sep 2025 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357124; cv=pass; b=SgiHW1OYdj9mfrR/2ChXZrmcPLjbCkbZDZMjymQIL8jwpIKuP9GczjlLNHy+xkA1dLKLCZs4QQu6dpxbd7x8r8ezadbHZp7zOKxI5HsHOYasQExgbtMRv4Ai6/SXVSZA1wwjXCzS8zlSU9oYr3lXiRhFjF+G6J3MHlxQBZUUzf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357124; c=relaxed/simple;
	bh=2tTrBu9V1y4+vqiHv72FO+4m+H0yKJhCv20mwf7h4Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ndtRhYeEmhPLlaSOzTInnjsTWWyKXdlRKLM0QSIrhSgphZ45QDD93B/u9xTZ0fzRaNiLNsvkR+ZrEquygtMW0MnVLrJeNm+zOzT85IdGGm3sf/1oNZgQJIyFVMCFQp2cSdkTci8DS1qdnEiem5naTF6aO+B6FP7HHE/PTm5hbNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=b7kk10rr; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=3ZlUlV7Q; arc=pass smtp.client-ip=81.169.146.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757357119; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GcpNBaTCRIg6qPYo58hlh2caQd4jP7wlh+jYukj5QZOPlIBtKOCKMwgTo3XcXmjyeM
    nTskjHq7kgS5qFMZOAKv7rKBLPlR75LxgDz9mAL2akDKe03VES9bAx2WsG3ooj4mECnP
    uqHAo/LOsggfdHr58fcNGmST9Ohlzi6z9H0T95ZM0uSpy6lRLmYovTUHVnkrKTBQKkuc
    ctPgcJCw54uM3BGNrpYpITznypxr/rV7/VEbTS0z7FUoReemSkuZZAmtcU7uHjoNfU/4
    kTcK56xXKgXjCW8aL7TrriNQcFGcJHlMJmYYphDp+I8sPVqvV4dGa4kqspiaPtvMdbjl
    jfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757357119;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=/oReRJHGnt834+mXGj0XWCLWZ/6Xmqlegy4Tk7tImRE=;
    b=V19Mf/jvuUWLV0WKYHLbeSkREVyVc2lOp3/F7bvFaINfO92q1NyK7bwz/CSl5UC8Ie
    igHjetDNyPpXYSinEuuX42ystnHH/LhM+3sxQq/+Y8B43nL85OX31thiXT7pvE2xlKRR
    WMp0SxiSvZkAMihysHVfwxYZBuoDujsmhrzNP1vw2Ru5oYi/teOmxHINkKCaYTAuexNE
    /DrvvaDne16urYC9Xd0YF51zm+/915OVjGu236bdG8ObX308IKKAZQ2XhE9eAWO++k2e
    glAtSP3iKDDVFxJYL1GIeUfqOVhS3YLHbkkg/UXfoGOxJeyReUC0xtUq/2UX/A150+4k
    l7Nw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757357119;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=/oReRJHGnt834+mXGj0XWCLWZ/6Xmqlegy4Tk7tImRE=;
    b=b7kk10rrZWnlLelicGXSgkWaZu9Zfi2iMeoLlobASxBGdMSSK7nfBuDrULSZ9lSKLn
    yDQCUTDu7p0x6RJH54kctzGbAVgImLlJis/I590WPhb71dRxyBgIwhFhGb2O1E011zB/
    OiR5gQ3G+NZop9YD3QC9QipRzVY8XB9ynIjrwldWnzL+yPlUo+kcohg0vB12Db/aspBd
    SCpG4IOhURmzYQT7yzdzonCNlbvVgnj/3fBHVay/qtrnBln4K4tYYrv0ZRqVUS/y0jU5
    E2kFcnfBrM5kHqSwbnLi3IoZTOUgUlSAWiFDWQWTkSuxpbmOUr1jzNjHf1uzJksjwSE1
    lFtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757357119;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=/oReRJHGnt834+mXGj0XWCLWZ/6Xmqlegy4Tk7tImRE=;
    b=3ZlUlV7QEviSEEvOU1ZbV7dYSuRW3HK0XCHkw4ShB+ekOOhdn+6XFg3Rslrd8RvyJl
    LMpGRvTcP05N/6vaikAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d361188IjJbQV
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 8 Sep 2025 20:45:19 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH v3 1/2] can: skb: enforce CANFD_FDF check in can_is_canfd_skb()
Date: Mon,  8 Sep 2025 20:45:11 +0200
Message-ID: <20250908184512.78449-1-socketcan@hartkopp.net>
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


