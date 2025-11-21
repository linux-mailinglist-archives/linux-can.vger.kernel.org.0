Return-Path: <linux-can+bounces-5537-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 882D6C77ED9
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 8832629A14
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 08:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55BD331234;
	Fri, 21 Nov 2025 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="hlYpB6GK";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Iq6l7M4s"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7382E0917
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 08:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763714085; cv=pass; b=YyhZg4dWH1VEA4Xm211bYbDMMZJ6bQskKhlIL9E95BSLsvVHP5wbMxazyv0o2uiYuQieK6dwxlqsJNjRxYt0aDYg6+HsnG/xLn9g8kEzo6TGno3ZABN4bspM2xvw4SPNjPBPF29owkzx3aH6Hq3Lqv557SYBZnE0fIzy0YLiHX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763714085; c=relaxed/simple;
	bh=a+vW+il+xes8C0rE4Uq6w96qZcBD8cP/CgMqLBMEU7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f3dTu16WdwvD0S7NNNrIR5GZLlQO1cXIhFfHT3uJ33LRRM4bRtcEqis2Q9xJd0mC+SJwl2F2zWsq4E5r8oxwuBGEVZty7C/iqQJgonmanG+yk9xO+BehoGXJl36t7+oGsN8FJyvxwH1h3ryQdxet4PMacyb9CPbWnJ9pXTCF/ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=hlYpB6GK; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Iq6l7M4s; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763714072; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nNyRZgmctwkvzZHjbbjr+ShfxT8QHciY3rfUTu55DDH/hU039GiR7fgARnhwaosLXp
    3snBH+q137GCx8RyeBdZm+ifA9ULiU/Q1hGWAxIkwehRfs1ePAbO5dNVXNEPGudHae5h
    mGG5yAXdo6lYnfZCoIUkY9D2Jn5JwXrHGNPt2WWuCzXuFP2BrEm2+1+CF5APLFG76q3q
    VGnAM2Lde+gbhfd58I3oD4+f1MFbLjlhyCsO836RMXO2Xv4CIYz9zybfAzqOpieDUhBQ
    FTMTJzJ5XQPXoL+r/CwAPsbjwha5GLKtOtXz2moXnwx8eCvPLwbn6Iq/n21bvxaVH/5g
    siKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714072;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=rTsJiKqABWv6MzK1MpgWYSiXBU3fuGfAVDN+hfxPbHE=;
    b=U2Ut+VXXK9K/TahPRrOKiXKIRlo1lu3ARUCp0k9k3crX+BxdE3RVVaXo2cls7r7vaJ
    Qbk9Z5+xYVGiALYgY9ruWXLIUYwzXcCAx4HzNTslQnXVsWYPbdhSArWG7f2RkTt3CJBq
    yC/BJSFl3OaUCU9dpKdLLBNkSy2ktYf852PiWDQyNcUqoxz+DabLP4VBG54s1mjKpY+a
    yYMorUtk7lD1cA9mzuYv0D0jA7RYmuL1hTo2Rt3b1bMYn8oiBQcT5r7BPjmXjSlVMhEl
    B/xN+Ykk8QT/EAxsSY3GLt2p9zdCK/GG+G84JX2A+TL3+BXLRSRAPP5HQRm+iVBossUN
    c6Xw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714072;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=rTsJiKqABWv6MzK1MpgWYSiXBU3fuGfAVDN+hfxPbHE=;
    b=hlYpB6GKWNM48Bg5aIdShn0BxgDQ3pLNY6fYmez5vQKVCAO7buMxSIf1nh5ruKWe+z
    9Vw6XjBOX3yTLmcdsm9Q3E4rbtKH8uqpoxSkIH+G8HNMZtM+ljc4qNTUH20UMRnqQEJ0
    i/CJCbwmsx2/vnsmMjKva5mHserHTTiM0ibllihCPUCyMJZl6ma+SSh4i7DvhZh/rl28
    nmfGiIJaTIIhGS8ZZBZcC/UNQDiM4nwDeU6XiJmGflEHKNBXBGLbep4uTnHE1yN8BHfn
    a8A9oX3KKMdhguvGVl4QshPbvc3rVamfrVdI+8BbrSZAoyYMQuJ35oZW5hoALGhwxtrh
    eShw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763714072;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=rTsJiKqABWv6MzK1MpgWYSiXBU3fuGfAVDN+hfxPbHE=;
    b=Iq6l7M4sfCCDOe4d5Pj/SBS4ivcG0TWSs7GyxpRhbBRkJmrrJy+2jHR5f5swcCeYxU
    /Zl1hM8OZYYg/E0r3kDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AL8YWAg4
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 09:34:32 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Stephane Grosjean <stephane.grosjean@hms-networks.com>
Subject: [canxl v4 16/17] can: dev: can_get_ctrlmode_str: use capitalized ctrlmode strings
Date: Fri, 21 Nov 2025 09:34:13 +0100
Message-ID: <20251121083414.3642-17-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251121083414.3642-1-socketcan@hartkopp.net>
References: <20251121083414.3642-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Unify the ctrlmode related strings to the command line options of the
'ip' tool from the iproute2 package. The capitalized strings are also
shown when the detailed interface configuration is printed by 'ip'.

Suggested-by: Stephane Grosjean <stephane.grosjean@hms-networks.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/dev.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 1de5babcc4f3..32db9f69844d 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -90,43 +90,43 @@ EXPORT_SYMBOL_GPL(can_get_state_str);
 
 const char *can_get_ctrlmode_str(u32 ctrlmode)
 {
 	switch (ctrlmode & ~(ctrlmode - 1)) {
 	case 0:
-		return "none";
+		return "(none)";
 	case CAN_CTRLMODE_LOOPBACK:
-		return "loopback";
+		return "LOOPBACK";
 	case CAN_CTRLMODE_LISTENONLY:
-		return "listen-only";
+		return "LISTEN-ONLY";
 	case CAN_CTRLMODE_3_SAMPLES:
-		return "triple-sampling";
+		return "TRIPLE-SAMPLING";
 	case CAN_CTRLMODE_ONE_SHOT:
-		return "one-shot";
+		return "ONE-SHOT";
 	case CAN_CTRLMODE_BERR_REPORTING:
-		return "berr-reporting";
+		return "BERR-REPORTING";
 	case CAN_CTRLMODE_FD:
-		return "fd";
+		return "FD";
 	case CAN_CTRLMODE_PRESUME_ACK:
-		return "presume-ack";
+		return "PRESUME-ACK";
 	case CAN_CTRLMODE_FD_NON_ISO:
-		return "fd-non-iso";
+		return "FD-NON-ISO";
 	case CAN_CTRLMODE_CC_LEN8_DLC:
-		return "cc-len8-dlc";
+		return "CC-LEN8-DLC";
 	case CAN_CTRLMODE_TDC_AUTO:
-		return "fd-tdc-auto";
+		return "TDC-AUTO";
 	case CAN_CTRLMODE_TDC_MANUAL:
-		return "fd-tdc-manual";
+		return "TDC-MANUAL";
 	case CAN_CTRLMODE_RESTRICTED:
-		return "restricted-operation";
+		return "RESTRICTED";
 	case CAN_CTRLMODE_XL:
-		return "xl";
+		return "XL";
 	case CAN_CTRLMODE_XL_TDC_AUTO:
-		return "xl-tdc-auto";
+		return "XL-TDC-AUTO";
 	case CAN_CTRLMODE_XL_TDC_MANUAL:
-		return "xl-tdc-manual";
+		return "XL-TDC-MANUAL";
 	case CAN_CTRLMODE_XL_TMS:
-		return "xl-tms";
+		return "TMS";
 	default:
 		return "<unknown>";
 	}
 }
 EXPORT_SYMBOL_GPL(can_get_ctrlmode_str);
-- 
2.47.3


