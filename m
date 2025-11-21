Return-Path: <linux-can+bounces-5575-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C632BC7B88F
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 20:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC623A45AD
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 19:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B62926ED5C;
	Fri, 21 Nov 2025 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="CJsjqQCV";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="e4QbLgzy"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818C92F12B6
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753744; cv=pass; b=urZ7jM10g+dsZAzCtk4cbsfTEeNjqKduMgzjmLaoz9wG1xAsdM6ezwDkm7bbJ2BBC4AEtzq5NoihZGpb33AzegqT5xasFP/OG5P0TbBzXDEeYllf2WQ7sIjXG3/4kt1zO8Ap0JZBR0Fvu5NgFEP5+mpmI3pOajGTt7HoYx4jT2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753744; c=relaxed/simple;
	bh=KHtZW1uRbvRKQSUAWMNTNWltj40RHoOMfBFGO/4GdyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IpVKSPUU1Rux2a4gnbk771vv/Q8UUd59KYI9HOmkXod9vUmu13NSnWPvwAiVADR+kWLJSf73s4x4x/JFsYb3KQLIN0DguKrTrps1znsI2Y7ZZRN6QihZgrBadboa4KrQF7X4FKJPZ0xXFwx8k3+oiN4VgABa5GKKGvqM3WPgvAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=CJsjqQCV; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=e4QbLgzy; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763753731; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kvdBHg+XL/TMAzAAHWSuU16r9oaorm1V1Do6RqpKhh8quUBkdeVWzGvXVYkwXXUxeK
    bLPuPKyaFdhg5c2wuPc+HcaESs+jBHCErTEwRDWHBBv3pLHMevBsV6kFLaN0pD63b8y4
    8llGn6yeyF6zBH6S9aD0xso4/U2QqYQRyGp+H2cVI+PTNS/jC6ZQRMifrxarrvSingTO
    krgLWMVxASTlodxTNifWf6P8ivB0DhNqEVrKQdRWeWsrOHawwwN/reg8xr/AHfnZaI+L
    CbSJQ/ad/cDjs3+c4FL2msuhyhyhwGAcnU9kL1P8pLzngP1PMH9pvA3qQZzh01AtbXuj
    Z5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753731;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=9SQKY6DSw4yxigpO3SoKBygG81bm05A/vQWtGrkSlCM=;
    b=ObJe8BHTwJThDz4cmk+bUWw4uLKppP3eeTLy3E8IGGTiCWwSDzHg82ZnNvsU1xoB8j
    9yeLSYyxgl43Z0OPnELnKcm/dAbPPVZyoSNIGbWIifNNpmkhA7wTmjSc8vKmsZQ6Tor4
    GBezfPInuQcmn0mWdGIYoXPAZ96iutkrWflZEqNKrC2456st6D2f8St9VEej1IAnl9fO
    qRuYNAeBPajI/bBhplD4+fYvJK3f4+bN53gsd9BhFJG+X6X1/pj5oRZDQSyJdq9icwPJ
    9irSxDaLRTBSSr08TLFN1OJi0jvxYgEaK+PGsslKzjKogF8B5bMp7//VkPrhfTZ9W4JQ
    zXYg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753731;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=9SQKY6DSw4yxigpO3SoKBygG81bm05A/vQWtGrkSlCM=;
    b=CJsjqQCVUwTeUP3M71oPnzRIvFB5E0LZc4fuoIY0iHpvtSDZSn9TMVoGpGnlI7Klxe
    523lo+BE2cWKFYJLrPP/ObrvXqJjzsAiR9D3CPJcKj1zEycqCTZx6EMoaK4Zvlj+4sQZ
    ZlmPbpEPbr185IordBFV71FfczwfuEUUgYzyIXBXd/R9ELDaptGzZoFRsfhPH/K+IovV
    ctOAu+Wori44orec4kfieDlY2HXKd0NQEcG8WtCj/dypJZMl+FrUhM/vBC+CBkkrLe+q
    wmIUKrmyJa7m+m5z8ZqM9wxjZg5Fw3M4b+vHvPW9apW1cm11h5TryWQKB30vq6fWe6n8
    NKXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763753731;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=9SQKY6DSw4yxigpO3SoKBygG81bm05A/vQWtGrkSlCM=;
    b=e4QbLgzyX8Mu/HEa6qgWSEyy3RWET34wlX0XzkCODn30iAWMjxecSB8NaNLzYwjOzO
    Kcpu9g65jemb32n07PDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ALJZVEnI
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 20:35:31 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [canxl v5 17/17] can: dev: print bitrate error with two decimal digits
Date: Fri, 21 Nov 2025 20:35:13 +0100
Message-ID: <20251121193513.2097-18-socketcan@hartkopp.net>
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

Increase the resolution when printing the bitrate error and round-up the
value to 0.01% in the case the resolution would still provide values
which would lead to 0.00%.

Suggested-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/calc_bittiming.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 0b11c4e98172..71c5ba338f8f 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -150,23 +150,26 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 		if (bitrate_error == 0 && sample_point_error == 0)
 			break;
 	}
 
 	if (best_bitrate_error) {
-		/* Error in one-tenth of a percent */
-		v64 = (u64)best_bitrate_error * 1000;
+		/* Error in one-hundredth of a percent */
+		v64 = (u64)best_bitrate_error * 10000;
 		do_div(v64, bt->bitrate);
 		bitrate_error = (u32)v64;
+		/* print at least 0.01% when the error is smaller */
+		bitrate_error = max(bitrate_error, 1U);
 		if (bitrate_error > CAN_CALC_MAX_ERROR) {
 			NL_SET_ERR_MSG_FMT(extack,
-					   "bitrate error: %u.%u%% too high",
-					   bitrate_error / 10, bitrate_error % 10);
+					   "bitrate error: %u.%02u%% too high",
+					   bitrate_error / 100,
+					   bitrate_error % 100);
 			return -EINVAL;
 		}
 		NL_SET_ERR_MSG_FMT(extack,
-				   "bitrate error: %u.%u%%",
-				   bitrate_error / 10, bitrate_error % 10);
+				   "bitrate error: %u.%02u%%",
+				   bitrate_error / 100, bitrate_error % 100);
 	}
 
 	/* real sample point */
 	bt->sample_point = can_update_sample_point(btc, sample_point, best_tseg,
 						   &tseg1, &tseg2, NULL);
-- 
2.47.3


