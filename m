Return-Path: <linux-can+bounces-1943-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C95F99C33BF
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 17:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54765B20B8C
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 16:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E870084D34;
	Sun, 10 Nov 2024 16:04:39 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FE4126F0A
	for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254679; cv=none; b=FMjytC6YeWgQUc6EKBX6Y2xiudtAVdG2u8fKJiUMPmjInAM4SV1can1RbPteIYTUyj7a3w5pn5ctm5fXCWge7VHAGwk8HYGiDLwbZxRLES9vYHq86AwOOeTk2+lwQf6+q/enMJAY84ul58dKSc+Y57xW3uUaJ82Vkkt15VELpOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254679; c=relaxed/simple;
	bh=yB8dOh/S0h14VCPN2Z0Xyi5MCcxOOku6xkwBJOfbXfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEcEJ5WM8HRWLa46lt2P0nLOfe5rxtevH0XhRPLlG0NY+cTQJjDSXEUTkee17cfkXw3WjZ65Kw/B6Iy3rqd3MvXF+mDJWKmUxAsDb7C13opvWR/6dAKP+J+X554mDwaLWdMeQjOOCqf0O6sY2/s8DLIWRY1PwqR6tRx53tjIM+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso2797347b3a.3
        for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 08:04:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254677; x=1731859477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3L+eS8jc9562wTLMq36VGe148ngHQ7WlLrQ7bLcnOUM=;
        b=FuRCQDNCJ08z7eWeXanerVnJ9pARXgz3xpPBwTCMtQrTabnPRH6jp+0XPmqKrz2LUz
         UsrXlDfsfwK6Gz9Cu5T2ko67zuCK15ZTjS7awda4N5HE9SMRnNEhwG7KIn0dE2tBD6iz
         ZaWSa7Y8TFGQobyyrfdtjbo+s47nbbEjAWwLq6SRwckU8Uyl7+bu4NTAtcyPFjOzVxZz
         yp02Zoh1l99ydI3P5E8GMAzSFGFjP3JPqblKygczojef/oTd9O7Cjrz2KWbLx/qMPNFN
         7kpPONFmGZa/n1fcy0uAliYYLe4Mutysm6BHxxL8lwwtM51cc9wv1BU3HxbyHFDflbQ8
         PEEw==
X-Gm-Message-State: AOJu0Yx0nmNiuLaO1Jt60J2g6IEgHInjgzsDy/8uOW6r3J3opxDORD58
	7WAkXh+ymk75U1o1BZ9HqVfOa9iLFwKM+lSq8Js//usUKWlAFWGwXjJ8SQ==
X-Google-Smtp-Source: AGHT+IEHMKoJFK0AUwX/MZZ3UG/O3wgyhyBCDm3QhpLC9ZaO9BelG0epulfJFBL8itnMbWHSJWvRbQ==
X-Received: by 2002:aa7:8883:0:b0:71e:69e:596b with SMTP id d2e1a72fcca58-72413362881mr13919130b3a.17.1731254676722;
        Sun, 10 Nov 2024 08:04:36 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a48cbsm7383037b3a.45.2024.11.10.08.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 08:04:36 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH 7/8] iplink_can: rename dbt into fd_dbt in can_parse_opt()
Date: Mon, 11 Nov 2024 01:01:37 +0900
Message-ID: <20241110160406.73584-17-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110160406.73584-10-mailhol.vincent@wanadoo.fr>
References: <20241110160406.73584-10-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3016; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=yB8dOh/S0h14VCPN2Z0Xyi5MCcxOOku6xkwBJOfbXfI=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkGNyue/5KuyO8QjpEqWpmoqPFvZ9uD85oTF594G2dZz hTTeOhhRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgIkc5mJk2DKDrUzRxbEmdJOq 36ztV44tCL+8vvh9tce5wDVn9wXMvsLIcG1Pr5eQQ6f56/NejJp5j+dbNOvH9ig9vBLqqXMupi6 BBQA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

The CAN XL support will introduce another dbt variable. Rename the
current dbt variable into fd_dbt to avoid future confusion.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 ip/iplink_can.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index f7faaf14..54acc65c 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -132,7 +132,7 @@ struct can_tdc {
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


