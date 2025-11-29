Return-Path: <linux-can+bounces-5775-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 257D2C940CD
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 16:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7EE8034719D
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 15:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F67211A09;
	Sat, 29 Nov 2025 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqK6MM9R"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA311AA7BF;
	Sat, 29 Nov 2025 15:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764430192; cv=none; b=IxCv27ze212v9Xv+Mth/XHo5arHN9TGkiNtGwf48OAvqgmobmI/brOeKtWaAkOz2Wov6RlzLp8m7eIH18s0O3nRMAzg2BUEqNOQmdNDaR89EQ71Mbi3XmzacPZezoYiEKv66QQAzyaD6pmSfXjeF1LVT4Jn09tjXBFh2iqUUxaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764430192; c=relaxed/simple;
	bh=buB36Y5Sf5MgYfsXtNeJpE7oy9ZCXNnymdj5sOX4Nkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q7s4+u5CUzu1uBpwolfPeYE9lm8Xc0YLohhcsseY4wTeaOU4etU3EoHEjfj+LHHTi81Nkq18VxHk+aB1/F9ykrAFXg1b4vpNJdqxSqnSVqovamwZd0+gpgFBdSQ1g6HDm6DqEv+ec0HdI7EdRaFPDycvwBZQa2DW8kiIHkUp5Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqK6MM9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D1DC19421;
	Sat, 29 Nov 2025 15:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764430191;
	bh=buB36Y5Sf5MgYfsXtNeJpE7oy9ZCXNnymdj5sOX4Nkg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZqK6MM9Rz3iIjbTnRJRLOLQ5Xl+voEiB6mwseQOzGeShW4XcHZmpZWBM3oxqO/b6m
	 O1HZKKGTWbyahQjTT4ipc8rhRmOJwLty6nEHqgXZGr5mTytV6GxbuK3q8nW6Y+CA8v
	 FRHDkWb76zdhvWv940E7VBmcbQdzUU2GSef++O+ItVdsqIofSwxXBXh/8A1HvSVVx0
	 br0brHPr0Ecnqv3qDUPs7JBVVCf2uAdG0AIB3Lb6n/oOogsdKCkbmh+GDLwMd925lz
	 61tMp/xYFL7z5YUcQPcbyzGBxmIi5kLfnt7FOqR7XrRmPExHLELg3htJTbdQY9lRvs
	 fObV+G4/wCa4w==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Sat, 29 Nov 2025 16:29:06 +0100
Subject: [PATCH 1/7] iplink_can: print_usage: fix the text indentation
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251129-canxl-netlink-v1-1-96f2c0c54011@kernel.org>
References: <20251129-canxl-netlink-v1-0-96f2c0c54011@kernel.org>
In-Reply-To: <20251129-canxl-netlink-v1-0-96f2c0c54011@kernel.org>
To: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, David Ahern <dsahern@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2576; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=buB36Y5Sf5MgYfsXtNeJpE7oy9ZCXNnymdj5sOX4Nkg=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJnagkFHtWU3i29sTn3RWenUwDhzgqJA5Pdb3a9WTjNd9
 sL59lejjlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABNhf8PIcPv9F6cC+buF61Jd
 QhZdDDF7neIiqD9/d+SzjLc5X05s/sXwTzVki9/ExIXtgtedXB693TO/atvZgMuzlZ+JLZc+L+z
 NxgsA
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


