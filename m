Return-Path: <linux-can+bounces-5800-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A83DEC9976E
	for <lists+linux-can@lfdr.de>; Mon, 01 Dec 2025 23:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300A03A5B8E
	for <lists+linux-can@lfdr.de>; Mon,  1 Dec 2025 22:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A1229E0FD;
	Mon,  1 Dec 2025 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0i5jrNw"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B905836D503;
	Mon,  1 Dec 2025 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629795; cv=none; b=Cyl7S/Kd4ViFQ1/QVg7DOlDM92BqtTOr/773pHhTSe51CMz3iXloA4tqZV+TiIY1+jiA+XC3/4I3lukSxqgDcSuggphkye443EC/it4m22XNv3SS2uq8RWMUCQ9RoFLThWV7JxWrn0arKQcXOYbbZjrJRoTsJCQeU4MxWN+BQ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629795; c=relaxed/simple;
	bh=zu63/HO5H/XHn2gNqdSfG3m9HFKZrZ/TNJWqStmwIjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jy5E8BcIPYObkLHYiInYb8yq+PmwURPq8fV+h4gwHCuCSEVz/+M88js398LaYGwk8vsFN5X7nB3T0vGxAQ3iEoeICBJV1eQJQ5hiV5JRlv6mY4VxrthhwWG/NfmqkpfZQIp0WzwirEtFVfNw1xAv+yeZfALR5edrKkJOtBxt0VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0i5jrNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8916C116D0;
	Mon,  1 Dec 2025 22:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764629795;
	bh=zu63/HO5H/XHn2gNqdSfG3m9HFKZrZ/TNJWqStmwIjw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V0i5jrNwyipNBR0LaCYl+n5qx6SuUPyBcM0Yc6TnLc+5sQ31LExGHPLMzZP4HUU/8
	 G/zKEk1MItTj7ORKYffBXVGDY3wPvMkro1r5REhm8b0fcZemIKwzBOQ+kk3I6d8lsg
	 WAbmSSsYG+mMjv8OpH40sFrJtnOqmbTzpCbl2mfMGWSY3EbvyYM0zIlTmv6qnmKiza
	 GZh4TCGTWg7mK0ZPo0zyskws2UTMMVh8vD9GycBXsRn/9IA62+Zb3ygD7ScZV/i+E7
	 DK+XuNlfq6rWCtVkpD7ZKC1/ZgyNdyWOWHROhTqUJRKGRkKKgfjaECJZIz1tC2jgj1
	 lXbxGFiKDjrwg==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Mon, 01 Dec 2025 23:55:11 +0100
Subject: [PATCH iproute2-next v2 3/7] iplink_can: print_usage: describe the
 CAN bittiming units
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-canxl-netlink-v2-3-dadfac811872@kernel.org>
References: <20251201-canxl-netlink-v2-0-dadfac811872@kernel.org>
In-Reply-To: <20251201-canxl-netlink-v2-0-dadfac811872@kernel.org>
To: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, David Ahern <dsahern@kernel.org>
Cc: Rakuram Eswaran <rakuram.e96@gmail.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>, 
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=zu63/HO5H/XHn2gNqdSfG3m9HFKZrZ/TNJWqStmwIjw=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJl6siyvkyQ5v0/VSpYwe35wjruuuPjaVRUJDj6J+SECU
 emTzK50lLAwiHExyIopsiwr5+RW6Cj0Djv01xJmDisTyBAGLk4BmEisDsP3uiQGUen/0e9L3+yJ
 1z4T4c4xYYXi/P7Vp1g0pTTKgs8wMlySLZ269v7h9dsuJ382tHB3N+6x/+8rU1Nc/2tLULrEY24 A
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

  - "s/mili second/milisecond/g" and "s/nano second/nanosecond/g"
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


