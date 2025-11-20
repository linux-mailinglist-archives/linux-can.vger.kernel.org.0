Return-Path: <linux-can+bounces-5526-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F95C75F90
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 19:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BDFF035A1B4
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 18:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3821D36D4E5;
	Thu, 20 Nov 2025 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="qfW0kOYK";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="TcOHFQSV"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0524C98
	for <linux-can@vger.kernel.org>; Thu, 20 Nov 2025 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763664505; cv=pass; b=ruQvCkAZx5zVaEu75DAi/AXTJdyWC09pgoKNHmewc3AZjOSoFQDrLHWNJMP/dc8YBlOa26oZTRq0hgQuLhVJ9Tuob2Q16a2IdqYrAiR2VfmQPK7LqTYRvVSHi0jKh5pzaAtx4RT84Vo5Dya0Ckq8LqpIcynVWCeK1nCls9W4Mlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763664505; c=relaxed/simple;
	bh=a+vW+il+xes8C0rE4Uq6w96qZcBD8cP/CgMqLBMEU7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCjK6gZUGNFZewUN0/q+xTOIvqDL0CsBYszRp/ZRHdiXXJggxjvOnOg9/Aln6oSdSPbcLVGntV7Omd/pWytmn0ylTANaTE+Fu48erUa/+pPS5NGFWhxTQt+UyVMTRls0oRJCv+o+cdpDt5VxmydlvXBscvaC9/iOyJgVwUU656o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=qfW0kOYK; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=TcOHFQSV; arc=pass smtp.client-ip=81.169.146.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763664325; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=G58b6XXxFTGhSnwUIwN7aqh5xSQOOBbQN23GQ7UZJu5PWUheUvh0XkK2F7sdmr8CKX
    FthzRAngN6+WX42VkNOnHc4J71i1MZVeGdNOAUwt1ljTtefB/pJoQ8ZV8hq62B/gnmg6
    kn3krC347VanOQzWuy/8J4mKDbZKuAfsrmNwS+7oGJuz8Yq+lnje6wpyt+w7JhREsz3F
    Lo/YK1NmWidfid61IZbaPFtFH/0AGGClh2xyx52tjzTYMk8qCdqcxbOTm/4cYSpIjyM4
    NJZq8y82O+I8p/iTvEZiKmBFSt1C2ESqCLgg5OlzQMZqTCov4ZHUvSbcBsUqDAARHfjW
    YsdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664325;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=rTsJiKqABWv6MzK1MpgWYSiXBU3fuGfAVDN+hfxPbHE=;
    b=bhEibR2TX+yQR505EqZuydyVYfMCxGJKYatxLo8kJTfB1+wLXK5gH+INl4jxeSCKqn
    beGxSnzTZfVlNmFfYQ96rjazU9oEvZjmOwsd1F/UhXBUQJo4VNAP+BSkbgh5n3GsVbFD
    qWVCN77aXYGpp9VepPKCaf7+kPSls0Zwh/tT9tGCB4J4SovnGpk7PjTSrB7iroo2bN6C
    riOUcGomLxLy1kax1bR4fIaKOjV2m5A9l0ma+jheqBKavhSlUOdqPLMGjZVPDZibXjrH
    3oF6doeGzk5lqspkPq0TtetkpHlx3ATW/C13Vco4I95u4WFp+1jG0+tzKQi4ngGt4DlX
    nA7Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664325;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=rTsJiKqABWv6MzK1MpgWYSiXBU3fuGfAVDN+hfxPbHE=;
    b=qfW0kOYKdK1khD0YLT593fI/J0FtBHcDjBiXgY9OYgsQwvPkSE139BF9aiBn3b/cCl
    JMw18gpXy/F/zC7mEX+SfOaXhMTde3sNtpwV4Z+1/6TgKNY3bhsSNkJYj1+99jDOuFnt
    wnxRq5XSdGTMXo7vXsyRDxLeqOCMnUbWUxYn+Mm8pGYuXaJlYTpP1GzcppVnt2idPmDQ
    lZ23kU6wOOfwK9UJEu7l4e9O5dLUz9ErhFB4jwXgg2/lEq4JRKQyPCZooBpf286ldOVe
    zo9Nv0N+g0gIq23Jp9F2FRZCoiI6WlGp8OxAsvQMeoMf4zNjmHJFZVSySVwOEt1nlmWS
    KHaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763664325;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=rTsJiKqABWv6MzK1MpgWYSiXBU3fuGfAVDN+hfxPbHE=;
    b=TcOHFQSV3C0vOVup7iT2wRgU19LogmA07kPLcNcL5UkXOHaDlMOwPUN/XgqKT9TQLC
    GheDPH8tALBRmb9qfeDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AKIjO9Da
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 20 Nov 2025 19:45:24 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Stephane Grosjean <stephane.grosjean@hms-networks.com>
Subject: [canxl v3 16/17] can: dev: can_get_ctrlmode_str: use capitalized ctrlmode strings
Date: Thu, 20 Nov 2025 19:45:00 +0100
Message-ID: <20251120184501.27597-17-socketcan@hartkopp.net>
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


