Return-Path: <linux-can+bounces-1940-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF139C33BB
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 17:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB871F21436
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 16:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE90F1BC2A;
	Sun, 10 Nov 2024 16:04:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0764C3D0
	for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254673; cv=none; b=MNXqVDiBYx5jmrn0oM+teVNRys4moClS/oMgixNbr1qIX0fTNyXOa/bwnB+4LZQqH5A1FmWqef27c8+Oh2KaiU0jjuvV1vASI9njfEqRV/MGMjjDKUy+TCVgKb9i63veA89AZaHuHqBnU+ugrLOC6Cs8XsGV62jMi1AGXuu/Jgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254673; c=relaxed/simple;
	bh=x8FiN2RHUmuTXkRPscFqZ6olzZnxfjUIqoXcH+P74As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EX2m0dCEX+I3p0YtSuDf3BpFDPde/F6ewkrqzAZ+qRo3+9abxcuNtGSmUjTRm3zpwJ2EE4r3iVwO/DSoYVUeovTFq77wo6ERpR6KU2qoAVwrR1FN9tk9sncvldSzA1I2xi+kvMtsf3MOQCguPXr4shCQ0zxyXBqRwi7DvNpX5fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e52582cf8so2975128b3a.2
        for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 08:04:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254671; x=1731859471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAJKPLY6uD7NhBn9LSgorp8vbhRbaFJ10BCnFzuSEZQ=;
        b=ZWEB+pzoBFqWwmte0DBC1FSipZtLA3Vh9h6F/jvuGTIkapL4t9nsgRV7+tEUo45pa+
         4C4YgdlAooU0zgMzwMopqzdetigZm1BG+a2RbVGMl5aeCDYZyfP5fZ+XkBy8jrNxUCUO
         kShn3ld9DItAy56QL9QuwGxfvK+QrMgYuPIf2yWx4KLPkv/IGfvTr6zAVnk3LgjzJHM2
         MQBdZ3arraK2T0ONgiz/EJJxyxKD2+2VirFgt117wmEiiSLG2U+yV43neZ3CW99GmGI6
         3Uc+pFR4KtAFGdV8P/jaKIZffBESSqkHukS5KcT2ETJzIaxErAsf+yU0a2AId0AYLDl6
         9zIg==
X-Gm-Message-State: AOJu0YzXLkNPRFN5MdN8kQsLj4uGTsdOvCr/dMAAXVgEJNBLVpWUQk/r
	CtD92RE5Bj/PZXcxI4eLxmt3ao/lqCOu0s4/gy6k0MpkyQZa2Qw9r7dI0g==
X-Google-Smtp-Source: AGHT+IE2ZKNli4kpCJRBKBvhp1BJLhxOx6a+GMmVTMupnpIpTGvbfUv+bbxhbnk/xH+nh3nzaw58AA==
X-Received: by 2002:a05:6a20:7344:b0:1d2:eb91:c0c1 with SMTP id adf61e73a8af0-1dc22b38ac0mr13578366637.42.1731254671008;
        Sun, 10 Nov 2024 08:04:31 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a48cbsm7383037b3a.45.2024.11.10.08.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 08:04:30 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH 4/8] iplink_can: remove newline at the end of invarg()'s messages
Date: Mon, 11 Nov 2024 01:01:34 +0900
Message-ID: <20241110160406.73584-14-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110160406.73584-10-mailhol.vincent@wanadoo.fr>
References: <20241110160406.73584-10-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5009; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=x8FiN2RHUmuTXkRPscFqZ6olzZnxfjUIqoXcH+P74As=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkGN8u/bjg/dSfnw3VOyeeXvj2RIb1vcZ+yi3em9bHc2 tDvUdXpHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACYS+YiR4eqP2jZD0VlcImwH v/o+9jWZMOn7ZntdnpVrdvFPehTrM4uR4XKgpDyDjkTxoq07l22UmNr++dhks7C3+5nvFPBsC9D RZQQA
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

invarg() already prints a new line by default. Adding an explicit "\n"
at the end of the message results in two lines being printed. Remove
all newlines at the end of invarg() messages.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 ip/iplink_can.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 3414d6c3..6c6fcf61 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -134,78 +134,78 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 		if (matches(*argv, "bitrate") == 0) {
 			NEXT_ARG();
 			if (get_u32(&bt.bitrate, *argv, 0))
-				invarg("invalid \"bitrate\" value\n", *argv);
+				invarg("invalid \"bitrate\" value", *argv);
 		} else if (matches(*argv, "sample-point") == 0) {
 			float sp;
 
 			NEXT_ARG();
 			if (get_float(&sp, *argv))
-				invarg("invalid \"sample-point\" value\n",
+				invarg("invalid \"sample-point\" value",
 				       *argv);
 			bt.sample_point = (__u32)(sp * 1000);
 		} else if (matches(*argv, "tq") == 0) {
 			NEXT_ARG();
 			if (get_u32(&bt.tq, *argv, 0))
-				invarg("invalid \"tq\" value\n", *argv);
+				invarg("invalid \"tq\" value", *argv);
 		} else if (matches(*argv, "prop-seg") == 0) {
 			NEXT_ARG();
 			if (get_u32(&bt.prop_seg, *argv, 0))
-				invarg("invalid \"prop-seg\" value\n", *argv);
+				invarg("invalid \"prop-seg\" value", *argv);
 		} else if (matches(*argv, "phase-seg1") == 0) {
 			NEXT_ARG();
 			if (get_u32(&bt.phase_seg1, *argv, 0))
-				invarg("invalid \"phase-seg1\" value\n", *argv);
+				invarg("invalid \"phase-seg1\" value", *argv);
 		} else if (matches(*argv, "phase-seg2") == 0) {
 			NEXT_ARG();
 			if (get_u32(&bt.phase_seg2, *argv, 0))
-				invarg("invalid \"phase-seg2\" value\n", *argv);
+				invarg("invalid \"phase-seg2\" value", *argv);
 		} else if (matches(*argv, "sjw") == 0) {
 			NEXT_ARG();
 			if (get_u32(&bt.sjw, *argv, 0))
-				invarg("invalid \"sjw\" value\n", *argv);
+				invarg("invalid \"sjw\" value", *argv);
 		} else if (matches(*argv, "dbitrate") == 0) {
 			NEXT_ARG();
 			if (get_u32(&dbt.bitrate, *argv, 0))
-				invarg("invalid \"dbitrate\" value\n", *argv);
+				invarg("invalid \"dbitrate\" value", *argv);
 		} else if (matches(*argv, "dsample-point") == 0) {
 			float sp;
 
 			NEXT_ARG();
 			if (get_float(&sp, *argv))
-				invarg("invalid \"dsample-point\" value\n", *argv);
+				invarg("invalid \"dsample-point\" value", *argv);
 			dbt.sample_point = (__u32)(sp * 1000);
 		} else if (matches(*argv, "dtq") == 0) {
 			NEXT_ARG();
 			if (get_u32(&dbt.tq, *argv, 0))
-				invarg("invalid \"dtq\" value\n", *argv);
+				invarg("invalid \"dtq\" value", *argv);
 		} else if (matches(*argv, "dprop-seg") == 0) {
 			NEXT_ARG();
 			if (get_u32(&dbt.prop_seg, *argv, 0))
-				invarg("invalid \"dprop-seg\" value\n", *argv);
+				invarg("invalid \"dprop-seg\" value", *argv);
 		} else if (matches(*argv, "dphase-seg1") == 0) {
 			NEXT_ARG();
 			if (get_u32(&dbt.phase_seg1, *argv, 0))
-				invarg("invalid \"dphase-seg1\" value\n", *argv);
+				invarg("invalid \"dphase-seg1\" value", *argv);
 		} else if (matches(*argv, "dphase-seg2") == 0) {
 			NEXT_ARG();
 			if (get_u32(&dbt.phase_seg2, *argv, 0))
-				invarg("invalid \"dphase-seg2\" value\n", *argv);
+				invarg("invalid \"dphase-seg2\" value", *argv);
 		} else if (matches(*argv, "dsjw") == 0) {
 			NEXT_ARG();
 			if (get_u32(&dbt.sjw, *argv, 0))
-				invarg("invalid \"dsjw\" value\n", *argv);
+				invarg("invalid \"dsjw\" value", *argv);
 		} else if (matches(*argv, "tdcv") == 0) {
 			NEXT_ARG();
 			if (get_u32(&tdcv, *argv, 0))
-				invarg("invalid \"tdcv\" value\n", *argv);
+				invarg("invalid \"tdcv\" value", *argv);
 		} else if (matches(*argv, "tdco") == 0) {
 			NEXT_ARG();
 			if (get_u32(&tdco, *argv, 0))
-				invarg("invalid \"tdco\" value\n", *argv);
+				invarg("invalid \"tdco\" value", *argv);
 		} else if (matches(*argv, "tdcf") == 0) {
 			NEXT_ARG();
 			if (get_u32(&tdcf, *argv, 0))
-				invarg("invalid \"tdcf\" value\n", *argv);
+				invarg("invalid \"tdcf\" value", *argv);
 		} else if (matches(*argv, "loopback") == 0) {
 			NEXT_ARG();
 			set_ctrlmode("loopback", *argv, &cm,
@@ -268,14 +268,14 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 
 			NEXT_ARG();
 			if (get_u32(&val, *argv, 0))
-				invarg("invalid \"restart-ms\" value\n", *argv);
+				invarg("invalid \"restart-ms\" value", *argv);
 			addattr32(n, 1024, IFLA_CAN_RESTART_MS, val);
 		} else if (matches(*argv, "termination") == 0) {
 			__u16 val;
 
 			NEXT_ARG();
 			if (get_u16(&val, *argv, 0))
-				invarg("invalid \"termination\" value\n",
+				invarg("invalid \"termination\" value",
 				       *argv);
 			addattr16(n, 1024, IFLA_CAN_TERMINATION, val);
 		} else if (matches(*argv, "help") == 0) {
-- 
2.45.2


