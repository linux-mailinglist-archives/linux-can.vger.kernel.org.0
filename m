Return-Path: <linux-can+bounces-5813-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6266ECA14DD
	for <lists+linux-can@lfdr.de>; Wed, 03 Dec 2025 20:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5C0130F74F8
	for <lists+linux-can@lfdr.de>; Wed,  3 Dec 2025 18:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6851E32B9A0;
	Wed,  3 Dec 2025 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxJouGFI"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3789031B101;
	Wed,  3 Dec 2025 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786363; cv=none; b=eFCIYDnS0ExYn/IdDb9SseuWpIpjQMD2SiLoMIfSMVCDqWzzUgc1n3crRFC3ZYVQEwwFoiCOj9k9VGQqN3N8UxVY6qM3yWVJ65ySfdyXIe0g6rKUkcHIvfToNapPhENBNoWr4KZ5Uq+2wLAgnHQzxGPqKdD/gGdnlluy7RB9NT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786363; c=relaxed/simple;
	bh=mJaIOjf4TRv4beB1yQdNszFV8zzBBZCGjwUvaq6QOFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B2i0yMRx3IWq3lSw+NqUuoVipP8Gx+sKsLeTP1CeL96MPdE4/E9nVdy9e4nIjqu/+K2ulgWYmlzkrou4K1nKVUB/I/1eYglnznwsn2B1/Kvj0rvnU687FF+cLCnVJCJnyECnINrHAsa6eHew4rgWE4XFswjBVTV+eN7rsSKOnvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxJouGFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3DEC116B1;
	Wed,  3 Dec 2025 18:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764786362;
	bh=mJaIOjf4TRv4beB1yQdNszFV8zzBBZCGjwUvaq6QOFk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rxJouGFIpZI+iZatp4NoPGYbMTHWUWvMddsEHX72F28dLLOUvdUhZA60Rs2QxeZe9
	 smnzi/U0YH/Qzfj+MVTSjUntaf7cJ9Efkmy2gcPwToi+oZpxNiReLkLE9AbCqnsd18
	 uDgQAaf1oqE+QX0yHEwHMtdTgs3xeYnSsbab4oMwaY94v3S1rAyn1ZXWRqV6qhqkHo
	 jvSIhKi+Wkfx82wpLHII0fma3/LqEO4CjrHQjBL24jbjaCvCjPypvW/psNhMUgLvoV
	 ma5gTYRbuq1AkRlYfhFQ04GO0YlFA5cvECw6meknDgUTK9u4LkK+oJA1kUE6qtnh9/
	 0wnDppzVaXQuQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 03 Dec 2025 19:24:30 +0100
Subject: [PATCH iproute2-next v3 3/7] iplink_can: print_usage: describe the
 CAN bittiming units
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-canxl-netlink-v3-3-999f38fae8c2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1032; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=mJaIOjf4TRv4beB1yQdNszFV8zzBBZCGjwUvaq6QOFk=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJkGDfPTdj2eUW84x9P6yqav2g6ZEtGVK4+85rmyVDJ5m
 dijoIDbHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACZSLsbI0ONeFDDrRX/qs6+u
 6n+zOc4HahT/9jtzQImPv+v29l2X/RkZXj2ax1E3tXvaSsYdVkqs/qFBCnKx56asf7lKa7mIVto
 1XgA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

While the meaning of "bps" or "ns" may be relatively easy to understand,
some of the CAN specific units such as "mtq" (minimum time quanta) may be
harder to understand.

Add a new paragraph to the help menu which describes all the different
units used for the CAN bittiming parameters.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changelog

v1 -> v2:

  - "s/milli second/millisecond/g" and "s/nano second/nanosecond/g"
---
 ip/iplink_can.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index ee27659c..d5abc43a 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -60,6 +60,13 @@ static void print_usage(FILE *f)
 		"\t	TDCO		:= { NUMBER in mtq }\n"
 		"\t	TDCF		:= { NUMBER in mtq }\n"
 		"\t	RESTART-MS	:= { 0 | NUMBER in ms }\n"
+		"\n"
+		"\tUnits:\n"
+		"\t	bps	:= bit per second\n"
+		"\t	ms	:= millisecond\n"
+		"\t	mtq	:= minimum time quanta\n"
+		"\t	ns	:= nanosecond\n"
+		"\t	tq	:= time quanta\n"
 		);
 }
 

-- 
2.51.2


