Return-Path: <linux-can+bounces-5816-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29178CA147D
	for <lists+linux-can@lfdr.de>; Wed, 03 Dec 2025 20:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2675132BC474
	for <lists+linux-can@lfdr.de>; Wed,  3 Dec 2025 18:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DCE32ED58;
	Wed,  3 Dec 2025 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJLoFv5O"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D7231D38F;
	Wed,  3 Dec 2025 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786372; cv=none; b=pPZsXlr4qSxOBPYgtcolu/4y3MK9NIInN53DthrEuEOO/x6sfQQqcP43hjAth/gErS+jXfuSN9MpFUHk1FVLsn0YahZaKHTkoMMiOabRiJx3OmAtkX3CJxGlmNhG0uyRjPlHC3cWBnocd5c8yKohG+/klE4cap9vCjm8JJZFTGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786372; c=relaxed/simple;
	bh=1jWXwr1gVj2S7XBrBxYiIEU01oeX+alq3ZTjJB6hOx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hwd3B8WpeLP6f5RltNVaoZkn1NXouAq3RcxCEc8vsGHZQhbFTKIQltDOPDxEnveDGP7KVIubeIsJVDk4IdnePqDhLOe3K9KbvpUYeWE4QFU7HLuwjA1p2OsuvieOEx85Dq1Vp7rqRKPpkWl2Oei86N9eGrh26rtyTxAr+aUJc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJLoFv5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991E6C4CEF5;
	Wed,  3 Dec 2025 18:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764786372;
	bh=1jWXwr1gVj2S7XBrBxYiIEU01oeX+alq3ZTjJB6hOx0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tJLoFv5OWrd4Ugq8IBobQkfO9KvIs4vlCcGhjj1C2Te80RasIZeesPOLC2uvQbFQt
	 yssB2HD2ram8DK7ZLj40BO8mtFdYk6di7QJmeWZnfBCrXjML0F3AAdVbtbNY9WSM72
	 7M5gHHPgCetN/2+7SXwJDiJ38LJPnWnqT+J1nyRCgW2vD8wmyjMtx8T2vI811qWN7z
	 hm3Rp5wrtQfY4W8NLoEEh1GRVUNkUyue5Jp79dMoFytrOwu6LBr/dwFdfZxEdZ0Qgq
	 3rgmsSRLgAbyrrogQW5cblUelIwxLik2vJUSo0QjqxcX/DOvyjidWpk9/G0PRbz1C5
	 nK1ceIH26TNvw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 03 Dec 2025 19:24:33 +0100
Subject: [PATCH iproute2-next v3 6/7] iplink_can: add CAN XL transceiver
 mode setting (TMS) support
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-canxl-netlink-v3-6-999f38fae8c2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1995; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=1jWXwr1gVj2S7XBrBxYiIEU01oeX+alq3ZTjJB6hOx0=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJkGDSu0pi2u7g3hEC2dffx3wvQF+eYTS3tfseZ5JYoor
 ZTx+SrcUcrCIMbFICumyLKsnJNboaPQO+zQX0uYOaxMIEMYuDgFYCL2rQy/WSvsw5wO7Lj/0Lb7
 oqzB4TQjE8650ntX6cYprSx7IBURwshwMirdy/l+iqw129LTNzVs36sIZtcdXhS1NPzQxEymRjY
 mAA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

This is the iproute2 counterpart of Linux kernel's commit 233134af2086
("can: netlink: add CAN_CTRLMODE_XL_TMS flag").

The Transceiver Mode Switching (TMS) indicates whether the CAN XL
controller shall use the PWM or NRZ encoding during the data phase.

The term "transceiver mode switching" is used in both ISO 11898-1 and CiA
612-2 (although only the latter one uses the abbreviation TMS). We adopt
the same naming convention here for consistency.

Add the "tms" option to iplink_can which controls the CAN_CTRLMODE_XL_TMS
flag of the CAN netlink interface.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changelog:

v1 -> v2:

  - s/XL-TMS/TMS/g in print_ctrlmode()
  - s/matches/strcmp/g in can_parse_opt()
---
 ip/iplink_can.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 8529a625..1cc943bb 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -49,6 +49,7 @@ static void print_usage(FILE *f)
 		"\t[ restricted { on | off } ]\n"
 		"\t[ xl { on | off } ]\n"
 		"\t[ xtdc-mode { auto | manual | off } ]\n"
+		"\t[ tms { on | off } ]\n"
 		"\n"
 		"\t[ restart-ms TIME-MS ]\n"
 		"\t[ restart ]\n"
@@ -127,6 +128,7 @@ static void print_ctrlmode(enum output_type t, __u32 flags, const char *key)
 	print_flag(t, &flags, CAN_CTRLMODE_XL, "XL");
 	print_flag(t, &flags, CAN_CTRLMODE_XL_TDC_AUTO, "XL-TDC-AUTO");
 	print_flag(t, &flags, CAN_CTRLMODE_XL_TDC_MANUAL, "XL-TDC-MANUAL");
+	print_flag(t, &flags, CAN_CTRLMODE_XL_TMS, "TMS");
 
 	if (flags)
 		print_hex(t, NULL, "%x", flags);
@@ -333,6 +335,9 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 				invarg("\"xtdc-mode\" must be either of \"auto\", \"manual\" or \"off\"",
 					*argv);
 			}
+		} else if (strcmp(*argv, "tms") == 0) {
+			NEXT_ARG();
+			set_ctrlmode("tms", *argv, &cm, CAN_CTRLMODE_XL_TMS);
 		} else if (matches(*argv, "restart") == 0) {
 			__u32 val = 1;
 

-- 
2.51.2


