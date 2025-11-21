Return-Path: <linux-can+bounces-5571-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC49C7B8C7
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 20:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5EF8F3525CC
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 19:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35745301016;
	Fri, 21 Nov 2025 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="QUkBB2LD";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="0gxSVC4f"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3BB302774
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753738; cv=pass; b=MAVV7JzV/8Hj8gq6tqfwDB5df4lXJJraR+ew4CbTGreWiryCTQiH3KN34ioAAJakyUF+W1tpa3zvbutaU7+CF3WVZt4w4I1EKofqmrkiOpEDaVH5XCawPSykxv0q0VcJaoNBqwmUGP8sqSCT3iO4TJhk01nfhzJjpX0j/yLqtrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753738; c=relaxed/simple;
	bh=Hxof2O3UdzpM1ttMczPgbAMZ5GEMQTpZxZBjKp1EMEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXeDPaAMACrHa4TEwlYfr9dQvzxdbtVhFEuYV+w8G+XkoZmtsE1b1dIxn6cIehHmRrRPboJ5coh6XyE5ljZfMS5EsiA/lGlRNeE4jLnElhJB/v0AVBO8iV3taw6ql7bErnHfd8/34a2lTgYFZyanwOkEQGk0fRhraOmb3A/2hQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=QUkBB2LD; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=0gxSVC4f; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763753726; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lVm9/OxOqcUpEVrFyUIfy3ypxpNGc/IQHlIljAEGxZiszAXGrVaIL6R3cBvR4jomnb
    GhD52EkQjvzyEcC84rS5Lqdqaeu9pCmmLMAx6DSSWoex4x3SGYXPixfJeP2T4bZaOXcY
    f+PCcsKdKaIbB8Dv26IhdV4PDZgKzqVcf4nZc74XuFBCv9KSX5mE9ohjezL+gUMXMql6
    OSydRNT4NhBLLi0I8M2w3cFIQpzThdrgVO/CxKmkKK4jEcq1oWe6IegfXeos7iKENO7L
    j1spn2vQVpOVK5zxyFqkalnh1EX6ra8CTR7jyw9FVp33EVU6MrP1WSw7/vcHlsZDO68w
    mgTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753726;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=z1K8d1Zvz4kmnl8uZijeDNjm5gkR4HlXB9xOBvjElzc=;
    b=hV7CEniMX3FnA8Y51l/cOREEFWx1Lu8vJwYhwiMEmrNc4wlPft22aB3lseggbbD/8D
    Bl99SYNnRecb33Zal5WXFijuhYlgHS+plZwLIOh/u/RRsiBCmzuYaW7v/wuj1PsOkEGx
    D+nGl1flKqbVOQngBPp6/JKKOTNuEJCmGqePDvMKYXKmpHil3CHN+JtEtNGcnsaFgYkk
    bIXxbve+CB2W7OzI23kYcDFLihXISqcp0fUXYC8a65egxYl2AWAX95H5CVT3sXoANfVL
    UX944CagZQBClG5h9dVaT1Ih+zXeMcSDEyQpupEnWaGWrFWEIiaShhv2oL5BHltyGt+5
    DqiA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753726;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=z1K8d1Zvz4kmnl8uZijeDNjm5gkR4HlXB9xOBvjElzc=;
    b=QUkBB2LDQV8sFa9ZXmFMdorP3dOrInGkQL9Ezrmw/KHub1h/xmMXXaWHhXEpkujl2f
    b9MfAZs+Awt3RPFcqp+3agee26BDhQxZQSMgxBTGeCrh62mojmhViNalb4jrW7FCAdhh
    lhsP0nZOc8xydJ7cdLlqM98iX7iKuK/zptm44owM2uELfA5Pes52DUmICtO9tWhDHnyC
    /uI0bYrBwjEmxljLwHW2eN+Fl3ZRq8cHCh2vDuXBu1Ba7gwr7iYw8Su65f01UMDuVnv4
    m7e8Y4OyNqSgqaVczxW5i7c3pWkgLseq4KwWxcHQt19u8wDw+2Il2jhGkZU3aP4SXmtD
    O8Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763753726;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=z1K8d1Zvz4kmnl8uZijeDNjm5gkR4HlXB9xOBvjElzc=;
    b=0gxSVC4faLle4Ch9Do5MuAvdZ5FcWBE+Q9Btc5gpTHgSmTCwgXLhInUVVgCOBk66Oe
    3B+d3W3ilYO3Xu0LFgAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ALJZQEn2
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 20:35:26 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Stephane Grosjean <stephane.grosjean@hms-networks.com>
Subject: [canxl v5 01/17] can: dev: can_get_ctrlmode_str: use capitalized ctrlmode strings
Date: Fri, 21 Nov 2025 20:34:57 +0100
Message-ID: <20251121193513.2097-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251121193513.2097-1-socketcan@hartkopp.net>
References: <20251121193513.2097-1-socketcan@hartkopp.net>
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
 drivers/net/can/dev/dev.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 0cc3d008adb3..735faa888886 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -90,33 +90,33 @@ EXPORT_SYMBOL_GPL(can_get_state_str);
 
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
 	default:
 		return "<unknown>";
 	}
 }
 EXPORT_SYMBOL_GPL(can_get_ctrlmode_str);
-- 
2.47.3


