Return-Path: <linux-can+bounces-5812-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF55CA14F7
	for <lists+linux-can@lfdr.de>; Wed, 03 Dec 2025 20:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D972F303B1AF
	for <lists+linux-can@lfdr.de>; Wed,  3 Dec 2025 18:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA15328603;
	Wed,  3 Dec 2025 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGhD1Cg8"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6868F328634;
	Wed,  3 Dec 2025 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786360; cv=none; b=frWBZg+GGoyt5w0Uo38cfxFE+UmyByKmKPiGXeYZrZX2PVdfqa/I01Lq8gKO7clkEgSN/o0vDEXtHynI1yLaGkrLlQ8SvjMDZ0ZJtvawu0PNLFxZGTmlQT1snspiR5i4e3fUHiLFcpDYz5/srvZC3YgPKVYn6sbgUmB3k3UeXr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786360; c=relaxed/simple;
	bh=M4KKHo72Z25bXFP51FFH0SkrJdmV0dkgh6ZN6tjjy80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iseILfFJMtzrZZ2HvMKFNipRoheckc0D00uTZyQooYsaMDHi5/MvbURdmYKZtwBlMUkABpp8m3q+0EnCTaWX0LuN4w51j0ZVjMs3zxjXl82OYA4HUyXJnRlR+e+DL4DXYQLQJxKSoDs1mHNhJb4WBPA9hyUTvuGfUByeM2bXl1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGhD1Cg8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDD6C16AAE;
	Wed,  3 Dec 2025 18:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764786359;
	bh=M4KKHo72Z25bXFP51FFH0SkrJdmV0dkgh6ZN6tjjy80=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eGhD1Cg87k3AA+sF7HlR5cbEwSGs+VN6peIwg/BSj64h0C5T+OXNlRd00wWGtIwax
	 TmjbmkUX9TyCAmGG1GaY0Yd40+s+Zo66YzlV8E8xMv4Kbd8OAvCEtVPHb52qQ4zss1
	 w8V6hXat4wM4Xwe/yaiIcNyiRhknr9osHc6Zqq3FXuKP94Q/+K/cqTQrp/4qUYMeTa
	 WTEuVTPHqVHhBdFq5B9pkAiGPzIBkhMXEs/YR+STPl8D+FnCQGnNRbdM51FrPeV9Qo
	 vmQ79Ap9RmB2XFUI6MrE7wgYbPJLkiJPXryTSqLItPALp5qY3BrRqqWx/EKEQAT+vv
	 wsRbHfsu7lWIA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 03 Dec 2025 19:24:29 +0100
Subject: [PATCH iproute2-next v3 2/7] iplink_can: print_usage: change unit
 for minimum time quanta to mtq
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-canxl-netlink-v3-2-999f38fae8c2@kernel.org>
References: <20251203-canxl-netlink-v3-0-999f38fae8c2@kernel.org>
In-Reply-To: <20251203-canxl-netlink-v3-0-999f38fae8c2@kernel.org>
To: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, David Ahern <dsahern@kernel.org>
Cc: Rakuram Eswaran <rakuram.e96@gmail.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>, 
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1309; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=M4KKHo72Z25bXFP51FFH0SkrJdmV0dkgh6ZN6tjjy80=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJkGDXPm5gpf9/S2FjZiqDcorYqeIVe3vk/27MYzR6/8e
 L9y1c22jlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABNpiWFkWGc96YOtZ1GQdZpy
 +emoI5leMze6nNw5Nbku7um67zymPgz/NFyP/556ct1tdvutjBz7Lee/dj1p6Oe43vG4nkDQh5K
 5XAA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

In the vast majority of the available CAN datasheets, the minimum time
quanta is abbreviated as "mtq". Note that the ISO standard uses "tqmin"
(with the "min" part as a subscript).

One fact is that no one seems to be using "tc". I was actually the one who
initially proposed to use "tc", but I can not recall anymore the reasoning
behind that.

Change the minimum time quanta unit from "tc" to "mtq" to follow what the
majority of the industry does.

Fixes: 0c263d7c36ff ("iplink_can: add new CAN FD bittiming parameters: Transmitter Delay Compensation (TDC)")
Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 ip/iplink_can.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index f3640fe0..ee27659c 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -56,9 +56,9 @@ static void print_usage(FILE *f)
 		"\t	PHASE-SEG1	:= { NUMBER in tq }\n"
 		"\t	PHASE-SEG2	:= { NUMBER in tq }\n"
 		"\t	SJW		:= { NUMBER in tq }\n"
-		"\t	TDCV		:= { NUMBER in tc }\n"
-		"\t	TDCO		:= { NUMBER in tc }\n"
-		"\t	TDCF		:= { NUMBER in tc }\n"
+		"\t	TDCV		:= { NUMBER in mtq }\n"
+		"\t	TDCO		:= { NUMBER in mtq }\n"
+		"\t	TDCF		:= { NUMBER in mtq }\n"
 		"\t	RESTART-MS	:= { 0 | NUMBER in ms }\n"
 		);
 }

-- 
2.51.2


