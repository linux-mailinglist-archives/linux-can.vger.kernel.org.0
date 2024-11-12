Return-Path: <linux-can+bounces-2002-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13009C5EED
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 18:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5EC8284281
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 17:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D466C2144A1;
	Tue, 12 Nov 2024 17:28:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AAE2141AD;
	Tue, 12 Nov 2024 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432504; cv=none; b=myhpvTo5idBq5ItWR9lSinqWFVzJrPmmHTWIFaPzwFv5hMx/KlU/2AImPooaqfk2AQbEbzf3SjeYXmab5mk4bIkfxhm8ATYzbW1BxAJxXA1TQKcydZLKSSoyo8Y+2Lt7jqXNfEDzHjnphMsplhFwKXccRisBrVHVZL/Kvj59Thc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432504; c=relaxed/simple;
	bh=xbgk5hAoqieohPCSfNFhSlP8wiXGZ1l1vbeJYgtQU6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sud2cYKN9j/qISLEDz1CCz8cuuAnTxPnlydUds7YoJezOtCOxx6u1PueJJaRJvOq17FBWf29v8NarYSRAoonxemRWlp7SOEz0BLf4S7umQEAVCcyGXX/ubbzTaJTrXNkwZ6Y9wCly0f3bNPpM4tMtVLjwM/76OiH1+q9g6zdznc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-72041ff06a0so4836745b3a.2;
        Tue, 12 Nov 2024 09:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731432502; x=1732037302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5dn6D2PvAkkjUh/aBGO5vR9KleF05rgJT7heCtBroHA=;
        b=NEMFV3R7AraiomzguFA8CfvXcLQjTKvbPpr1CVQUcOfSGfAFk11uI+4QTxCsV2MG2K
         e73i/1IIcQKXIRY4eFK/fE6RpXpxQNO8To7D9e1s4OoViclvbCXNoe+ok+iWxHFMVMJu
         nwFj3itnlix07J0425UlFtkB5bDupDDVpWwpi4mlASl/XdsPYdup8xsO7hXC1FaFMPd4
         npB2QKFMG+jYQYLpaUghqegs/Ry93CBvtcMn2j4zVXvpZ9brooXo99R4xkuW5Rl5jejp
         x2510u92UjXxXj5eVIhTzNejiSgLlqwZm+YExwbHzr0qETs4Knf5i7nK9MwL/wQUtrlj
         lK+A==
X-Forwarded-Encrypted: i=1; AJvYcCWMg6kpZQyxSOYfYy4XK/Uiv86HZl0snRdnj+80D3vU613rtDR+rDS5Q79416lRU93lQj6wmR4YJmpwuNRN@vger.kernel.org, AJvYcCXow8hr63VBI5WprS3PNA4dpkt3SFj59u1GyU3i6g3H37dJG3oWAT7OpY9gUw6NO33M2rUcqSQEiXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YywZR1BCNlKXpxWY2H6jYYlxd/QzJt1s/AndoFx3/x2FHT3uhnt
	SoBMBrLjwfvaaHdoKcjoGtExzCqiwbgSaC4PpZKSa8Pcscsgo+0QQLDXAiEL
X-Google-Smtp-Source: AGHT+IFSNsjE/iTfFwkGzc2xjx4LVmXz4eNCEmZ61WTfvXpPt6p/no7XzV4AWwvmr4PomUrYufaubg==
X-Received: by 2002:a05:6a00:3d56:b0:71e:410:4764 with SMTP id d2e1a72fcca58-7241329bb4cmr24364304b3a.8.1731432502126;
        Tue, 12 Nov 2024 09:28:22 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407864f78sm11481439b3a.33.2024.11.12.09.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:28:21 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>,
	linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH iproute2-next v1 1/6] iplink_can: remove unused FILE *f parameter in three functions
Date: Wed, 13 Nov 2024 02:27:51 +0900
Message-ID: <20241112172812.590665-9-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112172812.590665-8-mailhol.vincent@wanadoo.fr>
References: <20241112172812.590665-8-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2361; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=xbgk5hAoqieohPCSfNFhSlP8wiXGZ1l1vbeJYgtQU6I=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOnGE3RObqroWpB8kSmcL5ex9J8l62a3lEsb0ufZPq0y8 r+/+YhWRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgInE9DAyTNjseGdhnN28ybuO P25bKTVNtGXe75vCfsyqjQ9Cld5Ous3IcG25YoONMyuDH7P+P4XGYy0LmhL9trnfCX3y83f4/Fo BPgA=
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


