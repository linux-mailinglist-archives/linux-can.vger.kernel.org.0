Return-Path: <linux-can+bounces-5811-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F30CA14A4
	for <lists+linux-can@lfdr.de>; Wed, 03 Dec 2025 20:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED72F328DC7D
	for <lists+linux-can@lfdr.de>; Wed,  3 Dec 2025 18:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670E732825C;
	Wed,  3 Dec 2025 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fytO8wms"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309BB3191A8;
	Wed,  3 Dec 2025 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786357; cv=none; b=DM8+2xQe2qz5r4hj99CFqan18S8ufeo0iENriJgBMKzIt6J3hSc0WhyILYZyxLBloeLkygkQkdbPgSzkEgmUUHjGF3d6ZWKAn1HByryB8dlH1NcvDvUqYKoq754bDbZ5qX+npNLcYXWoHmDfKD3bl4OXYgT5UTuwlkdSxFvAzwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786357; c=relaxed/simple;
	bh=buB36Y5Sf5MgYfsXtNeJpE7oy9ZCXNnymdj5sOX4Nkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rF6xamb8LWBFHXro0ih9N72emb9nrTJBR65p82HG9thOpX7lljJMqnpIYiJFJDp4z07MnwQdCR5X0EqvHrJg6AmACz7rvnT8z2sOQdeeg4su/oFu2DozMIG5q04TZFRyIXepmvhjw6SJ7FZEksMRz3qTWR4Lc1anL7NxLyFmPJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fytO8wms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5D8C116B1;
	Wed,  3 Dec 2025 18:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764786356;
	bh=buB36Y5Sf5MgYfsXtNeJpE7oy9ZCXNnymdj5sOX4Nkg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fytO8wmsL8eg89d1gs6JQDUfv5MYtH/IBT4iibOY7tA6K9sksQZaqr27h8akUekGG
	 VqB25Fq9Q5SO9n+Y6CJX8l1RZe4G5/dGgLvgRVTNw5DrMXAwHmrMhKrdIm8VZyesRi
	 343EyKK2AJ19yDZBPihzNkWXTInJVBclnWFaL5a2UT/tmZjr6cUwOQEQNf6tajb2Oq
	 KDgeiH9PC9lPWBHNI0xlJqUCjfgsH9gJ6gqNECBY3LbG18zm4d203TPEorq8dG3VuU
	 f/Lhp/0A++TWY9+LY+2yMG+QY8qrffEaRgss44YOql/ecFSYAr/6Ns9QWVejqAwO7j
	 TlURp0gkW3a4Q==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 03 Dec 2025 19:24:28 +0100
Subject: [PATCH iproute2-next v3 1/7] iplink_can: print_usage: fix the text
 indentation
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-canxl-netlink-v3-1-999f38fae8c2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2576; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=buB36Y5Sf5MgYfsXtNeJpE7oy9ZCXNnymdj5sOX4Nkg=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJkGDTN9u+uk3ty7X+e5TUzv/OJ3M/VUH3FxfJn+9LvE5
 SV9X2V/dpSyMIhxMciKKbIsK+fkVugo9A479NcSZg4rE8gQBi5OAZhIhwbDP93v/49GTdXkZ5sj
 JW9+X/4d7545qZKfkjPDeS/w72D9m8Lwz/DKFrf/Idvt2hZHi/6q7/uxVHE7y79J377y/XSJ47H
 0ZwYA
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


