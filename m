Return-Path: <linux-can+bounces-5798-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EBCC99756
	for <lists+linux-can@lfdr.de>; Mon, 01 Dec 2025 23:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 847664E2D7C
	for <lists+linux-can@lfdr.de>; Mon,  1 Dec 2025 22:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11EE29A30E;
	Mon,  1 Dec 2025 22:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUqz3B+9"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AA736D503;
	Mon,  1 Dec 2025 22:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629789; cv=none; b=V4865d/gZ2PyrKWMhigkcVX7kmm8lPNyBn4wDPiXj7Zhwl9BnCH6we6g0pvoikBpYgbemXt7AlCCZJPtu5tNRLTr4xcbpK18mKQo61zJE0CqfXO2+CRBbV7xMhnZgkxWkgOpj78LcQgRoCEK3A+DymnuPwviD2d9873FCcnW2j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629789; c=relaxed/simple;
	bh=buB36Y5Sf5MgYfsXtNeJpE7oy9ZCXNnymdj5sOX4Nkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BNdE7ynwX8f0/pr6xasFjjGp//ZqV/m3eiHnvQoQqwMFxFrPdoKsYvAKrN8hYOtT5ZMyA6niNT5voNYjs0ZdQZfEansrVWqRA1M8Fw1Y3MnpRdJSTX937fK5L8RD0oSdI9CTS6S8KLSCm/JsyBAMTGb63VDF8KjAjloZK5hjzBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUqz3B+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858FAC4CEF1;
	Mon,  1 Dec 2025 22:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764629789;
	bh=buB36Y5Sf5MgYfsXtNeJpE7oy9ZCXNnymdj5sOX4Nkg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sUqz3B+9WKgA3fk70gaTlgNKhVnJjQdzbonKejSdP4Da/9Cg+hckBrTVWKjwdHBpj
	 xfwdCxiLlaYKfw4Ysl20mGUD80FGfDA+cKS24puHtOFg/eF3swOPdU1yItkBoIpaGO
	 0TmZdKX03qM38Q9ACOi3LXakzTSgF/vrgTXS/9p+u7p2VSAHMkxmy6LvKXTr0US9JS
	 MwW87f0dzTmZHuBshb3MGuuCqkQWGBWc+Qly7AIBUB9i9rO5KRssgjITiAHfw0z/K7
	 CuxkUiM7IskElBXFJ+UKq5Lf0eR34fjLAbcnWBiqx7pqylFKw5Y3s8FCxE04ZZbLt3
	 sB0E/H6tnoK0w==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Mon, 01 Dec 2025 23:55:09 +0100
Subject: [PATCH iproute2-next v2 1/7] iplink_can: print_usage: fix the text
 indentation
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-canxl-netlink-v2-1-dadfac811872@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2576; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=buB36Y5Sf5MgYfsXtNeJpE7oy9ZCXNnymdj5sOX4Nkg=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJl6Mv9kdRec/qvQ/Sz3X/6NpR9DAo/GFt+28Uk2eDm5n
 OGOaIpQRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgImUxjD8L915YVGu0HsZ6ZKG
 BO5/hzdrzU9WmfZWuHRJrjDTNq9bbYwMn/dH5jaW95z9e/Hytp27jiwT/J2Xe2nNhBT/3L3vfIL
 +MAMA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

The description of the BITRATE variable is not correctly aligned with the
other ones. Put it on a new line with the same indentation as the other
variables.

This done, reindent everything to only one tabulation (was one tabulation
and two spaces before).

Before this patch...:

  $ ip link help can
  Usage: ip link set DEVICE type can

  (...)

  	Where: BITRATE	:= { NUMBER in bps }
  		  SAMPLE-POINT	:= { 0.000..0.999 }
  		  TQ		:= { NUMBER in ns }
  		  PROP-SEG	:= { NUMBER in tq }
  		  PHASE-SEG1	:= { NUMBER in tq }
  		  PHASE-SEG2	:= { NUMBER in tq }
  		  SJW		:= { NUMBER in tq }
  		  TDCV		:= { NUMBER in tc }
  		  TDCO		:= { NUMBER in tc }
  		  TDCF		:= { NUMBER in tc }
  		  RESTART-MS	:= { 0 | NUMBER in ms }

...and after:

  $ ip link help can
  Usage: ip link set DEVICE type can

  (...)

  	Where:
  		BITRATE		:= { NUMBER in bps }
  		SAMPLE-POINT	:= { 0.000..0.999 }
  		TQ		:= { NUMBER in ns }
  		PROP-SEG	:= { NUMBER in tq }
  		PHASE-SEG1	:= { NUMBER in tq }
  		PHASE-SEG2	:= { NUMBER in tq }
  		SJW		:= { NUMBER in tq }
  		TDCV		:= { NUMBER in tc }
  		TDCO		:= { NUMBER in tc }
  		TDCF		:= { NUMBER in tc }
  		RESTART-MS	:= { 0 | NUMBER in ms }

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 ip/iplink_can.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 1afdf088..f3640fe0 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -48,17 +48,18 @@ static void print_usage(FILE *f)
 		"\n"
 		"\t[ termination { 0..65535 } ]\n"
 		"\n"
-		"\tWhere: BITRATE	:= { NUMBER in bps }\n"
-		"\t	  SAMPLE-POINT	:= { 0.000..0.999 }\n"
-		"\t	  TQ		:= { NUMBER in ns }\n"
-		"\t	  PROP-SEG	:= { NUMBER in tq }\n"
-		"\t	  PHASE-SEG1	:= { NUMBER in tq }\n"
-		"\t	  PHASE-SEG2	:= { NUMBER in tq }\n"
-		"\t	  SJW		:= { NUMBER in tq }\n"
-		"\t	  TDCV		:= { NUMBER in tc }\n"
-		"\t	  TDCO		:= { NUMBER in tc }\n"
-		"\t	  TDCF		:= { NUMBER in tc }\n"
-		"\t	  RESTART-MS	:= { 0 | NUMBER in ms }\n"
+		"\tWhere:\n"
+		"\t	BITRATE		:= { NUMBER in bps }\n"
+		"\t	SAMPLE-POINT	:= { 0.000..0.999 }\n"
+		"\t	TQ		:= { NUMBER in ns }\n"
+		"\t	PROP-SEG	:= { NUMBER in tq }\n"
+		"\t	PHASE-SEG1	:= { NUMBER in tq }\n"
+		"\t	PHASE-SEG2	:= { NUMBER in tq }\n"
+		"\t	SJW		:= { NUMBER in tq }\n"
+		"\t	TDCV		:= { NUMBER in tc }\n"
+		"\t	TDCO		:= { NUMBER in tc }\n"
+		"\t	TDCF		:= { NUMBER in tc }\n"
+		"\t	RESTART-MS	:= { 0 | NUMBER in ms }\n"
 		);
 }
 

-- 
2.51.2


