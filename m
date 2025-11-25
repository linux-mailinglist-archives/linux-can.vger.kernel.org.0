Return-Path: <linux-can+bounces-5644-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E78EC84FFF
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 13:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C46A3B272B
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 12:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA411320A22;
	Tue, 25 Nov 2025 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="BsvuhD1y";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="t+/glEXd"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69F1320A1A
	for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764074370; cv=pass; b=N3CMsMYjCn32fle8YSahXcoa7yMfkxZTR5XWFwX71CrPTtw2qyhoJBV8RkNABd9mu89ANYg7qHo8mI/GFGgxci3kRLOie3P3WKf8crH8G5VYNIJHoKK9ucy2+2DOoibx3pDiiHtcQeydzTJaKR01S1cvPf7lWXdLNOP2fbacEko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764074370; c=relaxed/simple;
	bh=m7EeSy2+xKqgnXdooRw95j4Mc3UdRErVYKrMnhFrMio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTnv9IMpYUsAC6LTZxkNN2UnrTw8AJAUdb6pC4JB+fvt03Kln4AA59uKqkX2CP523kdcjDdXgFfH7cVY3/2G4OulHCRtMWkZwLFy/VJoCqyzfwhU0rnmKKnVK9zDvtfcQtBO+vtQT5Cj3gbguVrlfmyQbdeeowZfKGlYScg4qiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=BsvuhD1y; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=t+/glEXd; arc=pass smtp.client-ip=81.169.146.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764074357; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Sa+BD0dvcNjvu8I9NaTTF927E1KIEKwnT9K7f172EOXDwgNPCMJOl3ZfL62w3qldCy
    og5Cjeqb0yY3KK2N1B/UQpBU9KXEwzERf91T6UgEQSHPIYhoe2FY3A62B9naTuLIB5y/
    arMbaZfY6/bt6CXoXSq1a8+paVk+0hAypGVGAXyWzUO2hTeA5SJxk/Db1p40A1p3C4I2
    VVEjiCgYh1fL9mFJ4L+DeJjvBLgLCgPv32S8w5lOv15r1AXDkYwaPqFWC/3A5uW0AZjI
    Q7rCSwGE7EEun12fLS8A4u+mvTWFYIvVKwLlMUsiruqkwP9g4OxmfOCN4oJYSlgcXN9C
    Um0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074357;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mv4MJQA7KSzTFdvYxdDLGEQT/672EB+06RsOc+u97Q0=;
    b=m9lbbGFPcL/ZmitfIEBq5vtqeoODU28nZlF8M0XWCUohKw6/reSnGYBJFnXRuGv7x4
    xGzgUipoJGBOxyRxFhlmt6mPQbpPtu7LalQuPRO1zgL2RSrtXX1Ki8/8b9KxoQF3mZcL
    v4Fw9ABdx8v5oiQS58eu72o4fA0nBtOZGDfG2+Lzf116xIoJLzyxjuEIZXkH5UCxdXJu
    SdCCuhH0gDYMW4bwHeQAC2ZvrchKZlNdYvl2Q1X1HWx47EON5KhvKGtHzuHr6DqMXqnE
    VyXRtRi75pLi21t1yZaXxan1g088ABHC12JjJvPGe7xllriX+O75vpN/a+9mBHpBX9RM
    TfWw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074357;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mv4MJQA7KSzTFdvYxdDLGEQT/672EB+06RsOc+u97Q0=;
    b=BsvuhD1y6y83NO+VXX89L5ovOkVRRX+lF0u7/3iGnCc792obsjUXyfItROCXB/oeyD
    H3pP2lGrTtebt1y30dPuKUdC8qBCX1k1oUdHdUOgPbDbYXqTfhtmMDQvkHya5pcfJj66
    tGImalR5+GhgPh/BVIxGfwv4gYBo2Ti21b6KcSMUt8HbZkUbccPG9mi6HzCWlfZ5Nfkj
    Lmf8gqm959jPPrLZuJYnYyvNoqhSTUb64/c5aQ+obEyZZw1nSZhCUP9JYR0VxhJNcKl8
    44FodDgf4rKRwOMWWAzZeAIinITNYO27e4adpnriKNNyAEoE74jDLc+mAQ7t67i6JOBA
    GOWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764074357;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mv4MJQA7KSzTFdvYxdDLGEQT/672EB+06RsOc+u97Q0=;
    b=t+/glEXdhHkjyQtfJPBey7W69bONRLzDSsgaqmMvDvIDXCev9bYiHbc7Gn70hk48z+
    lle/fuIi9a+BJA4EWZAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461APCdHT8b
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 25 Nov 2025 13:39:17 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [canxl v7 17/17] can: dev: print bitrate error with two decimal digits
Date: Tue, 25 Nov 2025 13:38:59 +0100
Message-ID: <20251125123859.3924-18-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251125123859.3924-1-socketcan@hartkopp.net>
References: <20251125123859.3924-1-socketcan@hartkopp.net>
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
index 0b11c4e98172..e232993a5138 100644
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
+		/* print at least 0.01% if the error is smaller */
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


