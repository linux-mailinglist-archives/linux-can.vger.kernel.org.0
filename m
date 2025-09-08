Return-Path: <linux-can+bounces-4509-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3E8B48A36
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 12:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF1F177CDD
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 10:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D778A12D1F1;
	Mon,  8 Sep 2025 10:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="jAGOgSdv";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="monl8ZHa"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31D42139C9
	for <linux-can@vger.kernel.org>; Mon,  8 Sep 2025 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757327521; cv=pass; b=jo/ojYCXQpUE+JsZaInv5iuViH6Gbed12+gqc//vTFv62egWQx0v4/i8S6vVGLolc0GgoIjdYXlH9bMbdtD11SiCzJrMY/zUHBXLMaPP5ce9oPrj99YujyGr9yMVCjGJoQehpL7GExrt4Dd0K8pjEd37e0JfksJTY8ib4aViBrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757327521; c=relaxed/simple;
	bh=2tTrBu9V1y4+vqiHv72FO+4m+H0yKJhCv20mwf7h4Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OKav6DOLsMZxQLq+mjptXol3kx4hr3ITJu4UEO9PDx8iTFQmpjFOrQF4rzSCxK2FuWJ3u4o7d8oSMqG7NVY491k4iL2K07YHKuC8M9ljAyUF+fIZxZId/A6Mnyni/N2Jyji7QnmmjlTadwIw5vj0HvMAbi7DEZKPnjmXIW762qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=jAGOgSdv; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=monl8ZHa; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757327336; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ko2xYbOYxC3+K5MMF5bQh7ylU/Gd91338zhd+7p+GG+VttAUrJvOsW5nKcRa8gpqcr
    +Qhfb7VHxqqctfA0pbL8klhOb7dp7MUafC6N/LoDJIVtNJ+jObAN7PMMfWFgBqHFCAy+
    MEVkxw/Ix9I5uNEEvMz2xOmavWEgvmeQORgQFkzJnZQtDIhKLUjVnphrM3XMLiR3z+1G
    3MsluA58FEkxS1p7ftBD2d/cuS6QVKjSnUt7HsCx2QgKXyieodKf6NAF/Zm6K6fye+C5
    agePGrkEhH6kz7uAu3sZKfMJWLEH+sbtNBOEppZW3/jxoa5WIs+leWzpXBCQvejXze0p
    TQLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757327336;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=/oReRJHGnt834+mXGj0XWCLWZ/6Xmqlegy4Tk7tImRE=;
    b=Mq9rjMgMU/DqKplJs9vnkQ1up+EWh3lGBvzd3wa+ajL/ChHCsT6Sd17JVSCcgZwtZZ
    ediN0eZe9ax8YqL7Q+aozLWgkEiJcSAK/N50GnX+m9nWAi9lZ899BY1OaSCgnUlUQ1aq
    hv9XaKbbmAKqUZ2JdNjx69nsvTrEGtnOkYvfNJoxtILk1bftNmNYcSXuJpbiJTOFgH1J
    dMath1sNrliA4ULOEhIoDgd97ZEMSI43K5LSz4Ltun13gDkUIWRP9+IfwhWlBwc7ZNDh
    ked+VU4QUjeotxjpnkNHduG10RdOPk445ANqBWp7f2bVNwpjowPveCF9WHYPxU/IYi71
    mweQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757327336;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=/oReRJHGnt834+mXGj0XWCLWZ/6Xmqlegy4Tk7tImRE=;
    b=jAGOgSdvZWSAg5fuQYC/wqb/ffLdTQaSpS9OS2XH19s27pFO4wPTzPl9qQvXNcV/n2
    ExYnck6+BX6rSBFC62/0x1NL7+nTyQ310P5xa2MzkIeECbaGShvCOmz1oeNbhxuAe35L
    taMrnOzuO8kJdk9xkSBcquSYXOBvsTD+H29dMq4uaptHK8NeW9D4ZvRYICskntC2zWAi
    W+wxb83iaf4iUhUi99RCFahu0G8Jd7WeFWXBMPdPoLX2rXmXIiaRyTvVP7AdlphC0280
    H/ES81GgshWcACfbGg0EAcumAfukJpeUAh5GapBGm0qVq7BacokAXCkdWE8Nf41/Nzgi
    iYHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757327336;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=/oReRJHGnt834+mXGj0XWCLWZ/6Xmqlegy4Tk7tImRE=;
    b=monl8ZHasHgh76XVng9TGq1JmXVYG8ALIAQ97CLQT8H3V5OpNNk7eqD8RsUQYLcjwV
    1G6HR/C7LT328p5/SNAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d361188AStYqB
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 8 Sep 2025 12:28:55 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH v2] can: skb: enforce CANFD_FDF check in can_is_canfd_skb()
Date: Mon,  8 Sep 2025 12:28:49 +0200
Message-ID: <20250908102849.3999-1-socketcan@hartkopp.net>
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


