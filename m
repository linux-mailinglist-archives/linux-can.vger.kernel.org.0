Return-Path: <linux-can+bounces-1938-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5429C33B7
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 17:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30091C20A9E
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 16:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BD25C603;
	Sun, 10 Nov 2024 16:04:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8731655C29
	for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254670; cv=none; b=XZU8wBoSMxl/NCFofm4IV8OxwPkapeHn91QqBq1qOf2vkjqfmvXrQ++ia57uousTUD3j5E8PAADbZXtc95ian7HcROkGYY2tm5sR9eh1p6ENnCCP77u6IWiQaqD85vZrvRBxRlwKmJSdguFUb5QriTqrSOY4SHap1GcCXSjJWV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254670; c=relaxed/simple;
	bh=xbgk5hAoqieohPCSfNFhSlP8wiXGZ1l1vbeJYgtQU6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZWI2oiDyWnrK7uNybtlCvZw2qlk/C3SPYxVEiuCyHFR1Ore9ufXQuV2FWmrfTKT5gQRBYG9dg0+cxDtvsyZWaHpNS+h5ymC52u82x2lB742/f5tH9RUMmJJlXw5nUe6LHwlewlXv5EWgnwUnmA4Iyw81VUkyRFkJSPNG4daUK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-72041ff06a0so2994029b3a.2
        for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 08:04:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254665; x=1731859465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5dn6D2PvAkkjUh/aBGO5vR9KleF05rgJT7heCtBroHA=;
        b=pt57RvKD/2NrbRGz06C2uxmbLj2xsr48FjmaWEsKNSmaRkTVTEHKHFGdJqSFgaGqbt
         Yc0LALFadYFHoBrODbvVXYYnql8+VbMnMQwUcDkmDi01uW6bGo3exJ/OZLHjLhS+9O6b
         CBWblUeOSNHoCw27Ndv+PCFILMVZI6Ha7FpRSmIjnwZqDEV5uh2p3ykZXArvy9QULlaX
         IDgMQ+lrZHEgU9seDMeR8hdadanu4sz699bgpHN1V5KZoc3cD0FLNWWDvo9DqiEAYZgs
         M7AH2+6PfuEutBnP+HqLiqFJaspt5PtIqRLCVgspev5FhrzAQJaw70Zu2xVL9AX313u6
         x21Q==
X-Gm-Message-State: AOJu0Yy4njSTAQUJZXDgznK3vif/skDW/Hkb5qkgnEQKyoKfANRAR5Jd
	y/TvWuaUjB7aowBvQkI8sXHeLy6OfBXkzUIm645407RvjQz8Axth0DbCcA==
X-Google-Smtp-Source: AGHT+IFXTQ2BDkOwE7vmAR0Gr2mT5CGmA1peIDgRT79nuYEP1paNNQhY8trswDuQWsVIvdOrX/rQmA==
X-Received: by 2002:a05:6a00:18a1:b0:71e:e4f:3e58 with SMTP id d2e1a72fcca58-72413358923mr14089699b3a.17.1731254665338;
        Sun, 10 Nov 2024 08:04:25 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a48cbsm7383037b3a.45.2024.11.10.08.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 08:04:25 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH 1/8] iplink_can: remove unused FILE *f parameter in three functions
Date: Mon, 11 Nov 2024 01:01:31 +0900
Message-ID: <20241110160406.73584-11-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110160406.73584-10-mailhol.vincent@wanadoo.fr>
References: <20241110160406.73584-10-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2361; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=xbgk5hAoqieohPCSfNFhSlP8wiXGZ1l1vbeJYgtQU6I=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkGN8tPbqroWpB8kSmcL5ex9J8l62a3lEsb0ufZPq0y8 r+/+YhWRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgIloNDEy/Cs13/ohfeE2y4K1 Hfa7oj8e1WQz2Gk55bNz/YIFMydOc2P4Xx5XvOCyZbi8yU/xZbM6tiXdrb6eLWn02H/NBP0FZ6Y 8ZwEA
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

FILE *f, the first parameter of below functions:

 * can_print_tdc_opt()
 * can_print_tdc_const_opt()
 * void can_print_ctrlmode_ext()

is unused. Remove it.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 ip/iplink_can.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index f2967db5..01d977fa 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -337,7 +337,7 @@ can_print_timing_min_max(const char *json_attr, const char *fp_attr,
 	close_json_object();
 }
 
-static void can_print_tdc_opt(FILE *f, struct rtattr *tdc_attr)
+static void can_print_tdc_opt(struct rtattr *tdc_attr)
 {
 	struct rtattr *tb[IFLA_CAN_TDC_MAX + 1];
 
@@ -365,7 +365,7 @@ static void can_print_tdc_opt(FILE *f, struct rtattr *tdc_attr)
 	}
 }
 
-static void can_print_tdc_const_opt(FILE *f, struct rtattr *tdc_attr)
+static void can_print_tdc_const_opt(struct rtattr *tdc_attr)
 {
 	struct rtattr *tb[IFLA_CAN_TDC_MAX + 1];
 
@@ -393,7 +393,7 @@ static void can_print_tdc_const_opt(FILE *f, struct rtattr *tdc_attr)
 	close_json_object();
 }
 
-static void can_print_ctrlmode_ext(FILE *f, struct rtattr *ctrlmode_ext_attr,
+static void can_print_ctrlmode_ext(struct rtattr *ctrlmode_ext_attr,
 				   __u32 cm_flags)
 {
 	struct rtattr *tb[IFLA_CAN_CTRLMODE_MAX + 1];
@@ -417,7 +417,7 @@ static void can_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 
 		print_ctrlmode(PRINT_ANY, cm->flags, "ctrlmode");
 		if (tb[IFLA_CAN_CTRLMODE_EXT])
-			can_print_ctrlmode_ext(f, tb[IFLA_CAN_CTRLMODE_EXT],
+			can_print_ctrlmode_ext(tb[IFLA_CAN_CTRLMODE_EXT],
 					       cm->flags);
 	}
 
@@ -542,7 +542,7 @@ static void can_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 		print_uint(PRINT_ANY, "brp", " dbrp %u", dbt->brp);
 
 		if (tb[IFLA_CAN_TDC])
-			can_print_tdc_opt(f, tb[IFLA_CAN_TDC]);
+			can_print_tdc_opt(tb[IFLA_CAN_TDC]);
 
 		close_json_object();
 	}
@@ -566,7 +566,7 @@ static void can_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 		print_uint(PRINT_ANY, "brp_inc", " dbrp_inc %u", dbtc->brp_inc);
 
 		if (tb[IFLA_CAN_TDC])
-			can_print_tdc_const_opt(f, tb[IFLA_CAN_TDC]);
+			can_print_tdc_const_opt(tb[IFLA_CAN_TDC]);
 
 		close_json_object();
 	}
-- 
2.45.2


