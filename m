Return-Path: <linux-can+bounces-3704-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CC8AC5B12
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 21:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622504A5791
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 19:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE86620296A;
	Tue, 27 May 2025 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="BrMTEsNi";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Cz+yi70o"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FA6202965
	for <linux-can@vger.kernel.org>; Tue, 27 May 2025 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748375813; cv=pass; b=TIsznLPErKoHMGX3/VtZEJp2jIVK4zpvZMBbCl0dHNcncmI/nYJPnEZkAAWf9xW8JaGlfVcKzmG7kFr5KBVsIWcmWE1CkqcuVzhrbdZer7cd43NxWjEFjGUO31Lh85pLM+Wp4Orhp3LGeeRfVlDRsJj8Rgf+z5EYaEnmqj9c+Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748375813; c=relaxed/simple;
	bh=ghaye+2gQTf1s/JGDUvNX8YqxG9kcpQ2s4IRt/a9cWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pdipIdwqBdioR0Vch5DkrmP+/Ov4rk64UGhlqm79K/ik0xEqYGOaya4Xm46VGJlCwh+Tt1cDlMDht3uMKNFCnq0n/Y1OCAuBWl87rD4GEaI5ZjQH91SMiDViaFtRzKUASdnTmlRkCcLINk6Uky4qgDgKjSQqDFN20PnCRvVweFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=BrMTEsNi; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Cz+yi70o; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1748375801; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HlhlvgNhfFNTIYQIo2UmnAcl7bFbQUCt+yE0LBLZ82EJ9lRYuFzxVKn7FuRHHfAoy6
    iBh8jv1qGXWQ7ievGr6fdMX9TsCDHyRiuRNcb/duHH9OGK/Afp+QVYfIr48hHg4Oi0LY
    HmJaJpuhUo6hpCCpnSD75XkNbUVGvrCG5PVaf1oS1ZvkJw4JgsQvnCug3168wOjWqUrZ
    QVA+1wBwsAzP2d4RRkjCj5T7fcBSMktz9ZsQVLovu1XweqkOHOOvq6gdLf+OUyxGy7l4
    p9vETvCFCNwJOZLrpMqSQTNjSIk1nRoqWie3fW4dkSoONfwgY4XNPX89gwFeE3QlaNuS
    41jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375801;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=yb5xsHy3d7PWNjCxFQp4L0fNuUaSthTFiFGFbHYqKZw=;
    b=KsISy7cj1fb3LDvjmJrT2DID1SpG9Pnl5p9SaoUH3ZBunTCxS4mpAzMuuMgSTJU61D
    IsXLgBCq0AUqs0bDFtmvuEvAH1t8BzSaP4Ld6W1UD2VaULndCpVEUaW1zxlAJNvUoZjh
    ZYqs8UYpWFR6diQ7jMZJQh2nx5my9TMUkDLh/iSAqDMnpYFfr4KWHlL/MaHu/n1ibDz/
    IYi68jzWH0Joajt9lm9bHz7MCSSjC1XFQk0VuknzUVDFzAJr4fJ3VG6UnCdYdrqeXzU9
    IQPufgQZwn8RJnpo7/S0EjDMlUHGKxeq+BdvLlIaVGjBE54+tEf48qyqqBw91NHMFW1q
    hlFQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375801;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=yb5xsHy3d7PWNjCxFQp4L0fNuUaSthTFiFGFbHYqKZw=;
    b=BrMTEsNiyv7e/wkC3Bb86lRq1IO3Q6yIAssh/GQ3AsRMDJzf3RnJ168EE7g0z9EFRd
    ZmOsC53s1q/CsmoHk3GSdV6oVhjNLCvXs+i5Aa60arDCA2mR2w/Zs0h8HTa2K2W9h10C
    pUEknnHHF00XgHZJHkJQEe06nd+iw7EdajK3lA1lT18pKfDFGji7p9D0riXsqnr2tiKj
    Vrrub3w+5P+Ckk/d8lGHVE2pH9ZeQJSo+miYZKwx/Uris/mf9aCQDMAnaaisM6hBD2wS
    KdqW5fWknuMnr1UNhsipoaC6LZ7vrYvQBJ7LkaczIGCvj5JWZTAsBeI/jyvTytzbVSbz
    XNPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1748375801;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=yb5xsHy3d7PWNjCxFQp4L0fNuUaSthTFiFGFbHYqKZw=;
    b=Cz+yi70ocM5vM+uzAdxwMexeCrAXdrdaXiC42IvyiqdlgNoGgvQFQXLpBAOOsJyPoI
    9Wjot0fUBcVboG+tmQCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e514RJufiW5
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 27 May 2025 21:56:41 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 03/11] can: bittiming: rename CAN_CTRLMODE_TDC_MASK into CAN_CTRLMODE_FD_TDC_MASK
Date: Tue, 27 May 2025 21:56:17 +0200
Message-ID: <20250527195625.65252-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250527195625.65252-1-socketcan@hartkopp.net>
References: <20250527195625.65252-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

With the introduction of CAN XL, a new CAN_CTRLMODE_XL_TDC_MASK will
be introduced later on. Because CAN_CTRLMODE_TDC_MASK is not part of
the uapi, rename it to CAN_CTRLMODE_FD_TDC_MASK to make it more
explicit that this mask is meant for CAN FD.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/calc_bittiming.c |  2 +-
 drivers/net/can/dev/netlink.c        | 12 ++++++------
 include/linux/can/bittiming.h        |  2 +-
 include/linux/can/dev.h              |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 3809c148fb88..a94bd67c670c 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -177,11 +177,11 @@ void can_calc_tdco(struct can_tdc *tdc, const struct can_tdc_const *tdc_const,
 
 {
 	if (!tdc_const || !(ctrlmode_supported & CAN_CTRLMODE_TDC_AUTO))
 		return;
 
-	*ctrlmode &= ~CAN_CTRLMODE_TDC_MASK;
+	*ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
 
 	/* As specified in ISO 11898-1 section 11.3.3 "Transmitter
 	 * delay compensation" (TDC) is only applicable if data BRP is
 	 * one or two.
 	 */
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 4ebd5181aea9..08261cfcf6b2 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -65,16 +65,16 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 	if (!data)
 		return 0;
 
 	if (data[IFLA_CAN_CTRLMODE]) {
 		struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
-		u32 tdc_flags = cm->flags & CAN_CTRLMODE_TDC_MASK;
+		u32 tdc_flags = cm->flags & CAN_CTRLMODE_FD_TDC_MASK;
 
 		is_can_fd = cm->flags & cm->mask & CAN_CTRLMODE_FD;
 
 		/* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually exclusive */
-		if (tdc_flags == CAN_CTRLMODE_TDC_MASK)
+		if (tdc_flags == CAN_CTRLMODE_FD_TDC_MASK)
 			return -EOPNOTSUPP;
 		/* If one of the CAN_CTRLMODE_TDC_* flag is set then
 		 * TDC must be set and vice-versa
 		 */
 		if (!!tdc_flags != !!data[IFLA_CAN_TDC])
@@ -228,20 +228,20 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			dev->mtu = CANFD_MTU;
 		} else {
 			dev->mtu = CAN_MTU;
 			memset(&priv->fd.data_bittiming, 0,
 			       sizeof(priv->fd.data_bittiming));
-			priv->ctrlmode &= ~CAN_CTRLMODE_TDC_MASK;
+			priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
 			memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
 		}
 
-		tdc_mask = cm->mask & CAN_CTRLMODE_TDC_MASK;
+		tdc_mask = cm->mask & CAN_CTRLMODE_FD_TDC_MASK;
 		/* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually
 		 * exclusive: make sure to turn the other one off
 		 */
 		if (tdc_mask)
-			priv->ctrlmode &= cm->flags | ~CAN_CTRLMODE_TDC_MASK;
+			priv->ctrlmode &= cm->flags | ~CAN_CTRLMODE_FD_TDC_MASK;
 	}
 
 	if (data[IFLA_CAN_BITTIMING]) {
 		struct can_bittiming bt;
 
@@ -337,11 +337,11 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		if (data[IFLA_CAN_TDC]) {
 			/* TDC parameters are provided: use them */
 			err = can_tdc_changelink(priv, data[IFLA_CAN_TDC],
 						 extack);
 			if (err) {
-				priv->ctrlmode &= ~CAN_CTRLMODE_TDC_MASK;
+				priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
 				return err;
 			}
 		} else if (!tdc_mask) {
 			/* Neither of TDC parameters nor TDC flags are
 			 * provided: do calculation
diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index 9b8a9c39614b..5dfdbb63b1d5 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -12,11 +12,11 @@
 #define CAN_SYNC_SEG 1
 
 #define CAN_BITRATE_UNSET 0
 #define CAN_BITRATE_UNKNOWN (-1U)
 
-#define CAN_CTRLMODE_TDC_MASK					\
+#define CAN_CTRLMODE_FD_TDC_MASK				\
 	(CAN_CTRLMODE_TDC_AUTO | CAN_CTRLMODE_TDC_MANUAL)
 
 /*
  * struct can_tdc - CAN FD Transmission Delay Compensation parameters
  *
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 492d23bec7be..e492dfa8a472 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -91,11 +91,11 @@ struct can_priv {
 				   struct can_berr_counter *bec);
 };
 
 static inline bool can_tdc_is_enabled(const struct can_priv *priv)
 {
-	return !!(priv->ctrlmode & CAN_CTRLMODE_TDC_MASK);
+	return !!(priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);
 }
 
 /*
  * can_get_relative_tdco() - TDCO relative to the sample point
  *
-- 
2.47.2


