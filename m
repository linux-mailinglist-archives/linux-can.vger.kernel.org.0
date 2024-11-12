Return-Path: <linux-can+bounces-2007-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 803AB9C5EFB
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 18:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E931F23B14
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 17:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7DB21790E;
	Tue, 12 Nov 2024 17:28:37 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F557217910;
	Tue, 12 Nov 2024 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432517; cv=none; b=aHfXzbp+IKUzpGPUS5o3PnRwe4nG/n0qXWZsCjPia2QJQFAAS5ffwDlYltv8uDsfRG9hNrBJgT2ruex35KfHWzaaL4JqeLJ9XTH8PFEHqM3wgNEkoUDF1zdFxArGthYP9h+d0ikgHFNCS/6txK2HfKo6ArfENS/fuxHc876IYCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432517; c=relaxed/simple;
	bh=h+bda6qIP39CBqtuxgK5KdbY/2wZmLIxOqGtJzn4hVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9YBY5alnQsBRo5K2XvEjISCgxadxXZgWXXRIV7Mdhd36C/azs+DIb1E5LbqHR68r2l9mBtN7oZc2dJJqbGQs4VHN2nQx1LLlrqA4W5ltRsLBEx6LBXa08BwEh3rBQHmVWKnSz4I0sgYF3ZRahIVVoHumQ2baCSns8blvewKkMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-720d01caa66so5673340b3a.2;
        Tue, 12 Nov 2024 09:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731432515; x=1732037315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVVQAfQPrTYvBQm2LkvJxBcSdk/2T5k2ovRJfFBvGfY=;
        b=tZlkJ++CcbiGBM2eMNXkMUtfIgDAs0FPU/oe2glZ8J94QursnsBmeZc0BvRoZUmWt6
         OxaXmL5Jg21ByeiaPDsMdDLkc7sKV9/g7a9MpYw+apRuitnZfaGogMEge0Q3LY12REdc
         e1iy2Zc/Ewbp3elM9XNvFUm58Nc8rzIat1mm/zlasihZMWXCdP9y62BQCiaiwP/whWEZ
         HP0JH3xHpC7uBH+rXNZ0OOrO5wapkNPsWwoP5H6Nye99pSeaSbUkHM95SqBlxNBmDdr6
         29Deir+GU44epnNO37MnsljOoGvjub41bu4wilzVGGzS7o8OCZF36roPAcK5W5YuMkxm
         lAbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrCuocFCHJgcEzyDHHJPr/tly5LSE21rQlPG3ImlrJEOy8bNaAIMbeVC5EG7NBmh0ohcXUynJvo0+qLI8d@vger.kernel.org, AJvYcCVAKGwnvIX5XbGZU9HjojYOOrhUGg/tf7pXolMXLsy4akOHuvhQbUW5IxNPKvwEB7OgATFvPiPA2u0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Anb6O6TMfGd+rhvMwUI6UROCXfH84DYWhxGSs7bmsYP6xkiH
	wU0/tpEEZ4q6IA/j3pbDjkzKu3zFEZ1dZWSNIqjTo/xEUa+Zo7xeLdzppvfh
X-Google-Smtp-Source: AGHT+IGsunV8IoVHOLTnCENkEOhjcs0K5xAnvHSjbazIFKYovYw7YrsA6wXC+V1+suzlDgMEFM7vUQ==
X-Received: by 2002:a05:6a20:3952:b0:1db:d9fe:c442 with SMTP id adf61e73a8af0-1dc703a0740mr31898637.23.1731432514937;
        Tue, 12 Nov 2024 09:28:34 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407864f78sm11481439b3a.33.2024.11.12.09.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:28:34 -0800 (PST)
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
Subject: [PATCH iproute2-next v1 6/6] iplink_can: rename dbt into fd_dbt in can_parse_opt()
Date: Wed, 13 Nov 2024 02:27:56 +0900
Message-ID: <20241112172812.590665-14-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112172812.590665-8-mailhol.vincent@wanadoo.fr>
References: <20241112172812.590665-8-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3136; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=h+bda6qIP39CBqtuxgK5KdbY/2wZmLIxOqGtJzn4hVs=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOnGE3Qv1u6U54zfNfFpfl/dRIZfVW47V83fOu3KT9FFD LLh25TqOkpZGMS4GGTFFFmWlXNyK3QUeocd+msJM4eVCWQIAxenAEzk7hyG/37Bpe3r233En3CJ 3bqyIOPGkg9vY1aKfvrbubJkaumfl+8ZGY5avy75Jz6js2/27AnuEYl2gSvmfRJa9u3Sy5szApI edvEAAA==
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

The CAN XL support will introduce another dbt variable. Rename the
current dbt variable into fd_dbt to avoid future confusion. When
introduced, the CAN XL variable will be named xl_dbt.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 ip/iplink_can.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 325a4007..fcffa852 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -132,7 +132,7 @@ static void print_ctrlmode(enum output_type t, __u32 flags, const char* key)
 static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 			 struct nlmsghdr *n)
 {
-	struct can_bittiming bt = {}, dbt = {};
+	struct can_bittiming bt = {}, fd_dbt = {};
 	struct can_ctrlmode cm = { 0 };
 	struct can_tdc fd = { .tdcv = -1, .tdco = -1, .tdcf = -1 };
 
@@ -171,7 +171,7 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 				invarg("invalid \"sjw\" value", *argv);
 		} else if (matches(*argv, "dbitrate") == 0) {
 			NEXT_ARG();
-			if (get_u32(&dbt.bitrate, *argv, 0))
+			if (get_u32(&fd_dbt.bitrate, *argv, 0))
 				invarg("invalid \"dbitrate\" value", *argv);
 		} else if (matches(*argv, "dsample-point") == 0) {
 			float sp;
@@ -179,26 +179,26 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 			NEXT_ARG();
 			if (get_float(&sp, *argv))
 				invarg("invalid \"dsample-point\" value", *argv);
-			dbt.sample_point = (__u32)(sp * 1000);
+			fd_dbt.sample_point = (__u32)(sp * 1000);
 		} else if (matches(*argv, "dtq") == 0) {
 			NEXT_ARG();
-			if (get_u32(&dbt.tq, *argv, 0))
+			if (get_u32(&fd_dbt.tq, *argv, 0))
 				invarg("invalid \"dtq\" value", *argv);
 		} else if (matches(*argv, "dprop-seg") == 0) {
 			NEXT_ARG();
-			if (get_u32(&dbt.prop_seg, *argv, 0))
+			if (get_u32(&fd_dbt.prop_seg, *argv, 0))
 				invarg("invalid \"dprop-seg\" value", *argv);
 		} else if (matches(*argv, "dphase-seg1") == 0) {
 			NEXT_ARG();
-			if (get_u32(&dbt.phase_seg1, *argv, 0))
+			if (get_u32(&fd_dbt.phase_seg1, *argv, 0))
 				invarg("invalid \"dphase-seg1\" value", *argv);
 		} else if (matches(*argv, "dphase-seg2") == 0) {
 			NEXT_ARG();
-			if (get_u32(&dbt.phase_seg2, *argv, 0))
+			if (get_u32(&fd_dbt.phase_seg2, *argv, 0))
 				invarg("invalid \"dphase-seg2\" value", *argv);
 		} else if (matches(*argv, "dsjw") == 0) {
 			NEXT_ARG();
-			if (get_u32(&dbt.sjw, *argv, 0))
+			if (get_u32(&fd_dbt.sjw, *argv, 0))
 				invarg("invalid \"dsjw\" value", *argv);
 		} else if (matches(*argv, "tdcv") == 0) {
 			NEXT_ARG();
@@ -295,8 +295,8 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 
 	if (bt.bitrate || bt.tq)
 		addattr_l(n, 1024, IFLA_CAN_BITTIMING, &bt, sizeof(bt));
-	if (dbt.bitrate || dbt.tq)
-		addattr_l(n, 1024, IFLA_CAN_DATA_BITTIMING, &dbt, sizeof(dbt));
+	if (fd_dbt.bitrate || fd_dbt.tq)
+		addattr_l(n, 1024, IFLA_CAN_DATA_BITTIMING, &fd_dbt, sizeof(fd_dbt));
 	if (cm.mask)
 		addattr_l(n, 1024, IFLA_CAN_CTRLMODE, &cm, sizeof(cm));
 
-- 
2.45.2


