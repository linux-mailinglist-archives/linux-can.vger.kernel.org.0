Return-Path: <linux-can+bounces-5777-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70750C940E8
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 16:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADFCE3A7DF6
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 15:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDD21F0E29;
	Sat, 29 Nov 2025 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxdlROas"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919BE1AA7BF;
	Sat, 29 Nov 2025 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764430200; cv=none; b=jyateCjmBTKq7la3eANkjpy8Dcix9W3y+x0kqOk3ZXINCNDA1cwywN6lPJhYv3JP/CpcxcrTR8yCAYPUpAFIWn9vvYoqlS/kUdFkhtCsZboDV40tnWJhgeCodFAe2Dw15KibV4pYf+V+cF1llHgFNvvfHN4UgbZrXVhNp1btfro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764430200; c=relaxed/simple;
	bh=tPQFzBWyzlWi11g6MZ0oEmeF5bwYY9HMEYIGQJpoLEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qyeCxGZ2PXiF2WtLtaLltd28vqblMQoM+5n/FxTI/NkcHiUa1+nyRwC9qfHdQWWsoNYewAd+mO0VrODOnNt1Hmip0mxdCjnLWqMfVEwsKVp4lFTxG9YGSLH1gpevQJSWCSNicEuFAcWk9jOFh3kMVcceNKbB5YjLzVg1XxKySTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxdlROas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8896EC113D0;
	Sat, 29 Nov 2025 15:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764430200;
	bh=tPQFzBWyzlWi11g6MZ0oEmeF5bwYY9HMEYIGQJpoLEE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BxdlROasFvzPCa78ZpZokiiTjyYatmq08cd0llQEXzKFMhH0wpfddBpKlw+9ENZDH
	 PjYSpAG5PZu6d4IPMjzEoFHSzOojZP6OF8JkXpHgUvyXUK0VJYt91ax5gsZNAosvdv
	 0NAkfeN7ReXzoxh0tpQELeMR0OD0OhFhn3Ng4t8WHi1xK1rykp3XRcVj7LXn66Jlag
	 GBI3W9PgGhT4crmaRSFzkAxw1j6JFYqeKmuk+K0+vgb/3sx0dDbCwGWmAWaputmXpg
	 x2k+5p/0/bvJD4YAV8OzStDHCGf6iilTcjPBO+JudwyiwSZY5IHSEFJhnDEy+EollY
	 Y2Ci8+iLsT1Dw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Sat, 29 Nov 2025 16:29:08 +0100
Subject: [PATCH 3/7] iplink_can: print_usage: describe the CAN bittiming
 units
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251129-canxl-netlink-v1-3-96f2c0c54011@kernel.org>
References: <20251129-canxl-netlink-v1-0-96f2c0c54011@kernel.org>
In-Reply-To: <20251129-canxl-netlink-v1-0-96f2c0c54011@kernel.org>
To: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, David Ahern <dsahern@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=934; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=tPQFzBWyzlWi11g6MZ0oEmeF5bwYY9HMEYIGQJpoLEE=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJnaghFHdHI6GeT6X4g9/B5wR8vqbGkkd28hu+KRbS0d+
 +b/3hHfUcrCIMbFICumyLKsnJNboaPQO+zQX0uYOaxMIEMYuDgFYCILzjP8T8+4sfVBzetVd7ca
 RIY731QoybY2XdLc0rfLa3tm4HMTPYa/8jwCDx+vZ3B1Eon7+PzhAYNN7YG/7xsf5OhNL9uwtsm
 cGwA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

While the meaning of "bps" or "ns" may be relatively easy to understand,
some of the CAN specific units such as "mtq" (minimum time quanta) may be
harder to understand.

Add a new paragraph to the help menu which describes all the different
units used for the CAN bittiming parameters.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 ip/iplink_can.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index ee27659c..a2f59764 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -60,6 +60,13 @@ static void print_usage(FILE *f)
 		"\t	TDCO		:= { NUMBER in mtq }\n"
 		"\t	TDCF		:= { NUMBER in mtq }\n"
 		"\t	RESTART-MS	:= { 0 | NUMBER in ms }\n"
+		"\n"
+		"\tUnits:\n"
+		"\t	bps	:= bit per second\n"
+		"\t	ms	:= milli second\n"
+		"\t	mtq	:= minimum time quanta\n"
+		"\t	ns	:= nano second\n"
+		"\t	tq	:= time quanta\n"
 		);
 }
 

-- 
2.51.2


