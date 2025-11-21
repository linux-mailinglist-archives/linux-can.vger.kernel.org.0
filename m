Return-Path: <linux-can+bounces-5540-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C4585C77F3D
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 8737F33330
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 08:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E847334C32;
	Fri, 21 Nov 2025 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="dXFzhUKx";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="etj48Iyv"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E127527A469
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763714086; cv=pass; b=HF+uNSCuW1MMEl/JUmlsfL7TfTKEWi5WZVm9Wx0+OaZxW4Z/08vZ+30OgTbG2vSvyqjlFGTlk0GKsc8HH7NV2FgR9h8qp8OhUFoQVdM7jE6AlJYBpz0ywkexoRXAQBVsJyAyGT4KBTgGpIHmTyIFRyQCVEGcghkRGPymIdpfcNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763714086; c=relaxed/simple;
	bh=hCMjZSOy18suJGYTab5et7WKaLI9f32haxJK8JwW3IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ij6K48T8f6cW3ax8NaI8vjuo++6gO7WymQSBkTskBjeiU34865fOuvFUFZcUu2KRc/86oR6a8BsWvYiXtJ60v13biRHhKtiY/eXmWFQtMNb8jde+fhBCB83MkABVj/eFklZChkNrCmkdbK5GvAUEJUl3M5KHMUtGmfHeHqdZppE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=dXFzhUKx; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=etj48Iyv; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763714072; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ssbMlA/Vik2FvY9rsptqLRlPz9BFk1fdfgUJwIx6LDUxzRRl38avR8VH+/mQxC8Saj
    iUpBwJzrz5im2XZpix/a6BqVVBzutkVj8SGqQrB6HCQxBhBdXnYj8e7oyC4d5pxKWt8e
    61z7IdyaNgx26ZlzbBRofBwIHbKdcAswC0nwuZ8fwU/wQ51AcYDi+XblJTtgsMfEpeyV
    N/ELiaZd5oyuH3IJFyoOlZBkTQjzuXudnLX5HfPFoVH6vTUTwERUZjLdGWc3grgPakJE
    6F0TV/TxVIU37VH2HYDxBe9EyEXKrSXr19pDHXB1TtRcdgCwB2QcLv2OTuwTAgRutiB8
    q69Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714072;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=sJ81r3TrgljKWPrAIOL+Bvo/RD5VEx2JUzNt09ddzBw=;
    b=lR/GJ2BSmGYeBe2UdJxovExRCZaUyljpGs51bqPszBZ+NbnF71UgxBKhPx8dyKue2e
    5OhGXXKv4nmBVGhatkyjXQT0rdFd25jJgIRl/INaZdTtc4OiJWtDW1ACcaaDjR8Ybr8f
    yE8LsS0mJwkvnXmZBij0IcyyTwSN1QOHvRaAVSK6C8ZNpsOGXaDGnSXODTHpfRv0JqBl
    AWAWI+P8LJm/Xl2c/j9QV1NMwKMJ6KEA9ww38H7Nb5AYOLSisweNhjeOshuJpKV8MylA
    Ya9YW0ivC/4PAM1xoNpHfCO1st8HTlBWlNvu+x5srRqNai1Tdth8tYFbaL+slvghd8ug
    VgCA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714072;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=sJ81r3TrgljKWPrAIOL+Bvo/RD5VEx2JUzNt09ddzBw=;
    b=dXFzhUKxoRfGLH/w7jvVe7EOZ9n3FaRz6/48NkxoQYxcW0jbbaV3Fh8ZtAVvnnAiPH
    MOReZieM+DYxs48C6/mC1zFrZ6s1q/YTTvJpwEX+xXLmRabjfxuvTZx7xNE+6FbWJQfN
    zfyvLN+qgu5BrV75LqjtAq/w9c2+CpN+TwgR9FJk18Me/gASlPZ7Ke/9AWGYAfZSWgue
    UYHSjweIPm64pYKJXM/KJUUD9Z5CJxUcWNAbu2dLNCC47I9T65M2flh5w7qvJoKuvaE5
    MJ5xz5iQxBQcFDqgwGOQVcjGr1C0+swOSytJ2HQqFI0wn5S4cnACDKhk81tQwDWlN0UG
    5gvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763714072;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=sJ81r3TrgljKWPrAIOL+Bvo/RD5VEx2JUzNt09ddzBw=;
    b=etj48IyvP5GOp/QWykyJuURTI/dIFb8nK39DcKSK2qzoZKmaPVn9F1Q8JjiTXKCXRX
    +farpscRoVzwf7MxB3BA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AL8YWAg5
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 09:34:32 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [canxl v4 17/17] can: dev: print bitrate error with two decimal digits
Date: Fri, 21 Nov 2025 09:34:14 +0100
Message-ID: <20251121083414.3642-18-socketcan@hartkopp.net>
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

Increase the resolution when printing the bitrate error and round-up the
value to 0.01% in the case the resolution would still provide values
which would lead to 0.00%.

Suggested-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/calc_bittiming.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 0b11c4e98172..103128773a7d 100644
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
+				   bitrate_error / 100,
+				   ((bitrate_error / 100) || (bitrate_error % 100))?
+				   (bitrate_error % 100):1);
 	}
 
 	/* real sample point */
 	bt->sample_point = can_update_sample_point(btc, sample_point, best_tseg,
 						   &tseg1, &tseg2, NULL);
-- 
2.47.3


