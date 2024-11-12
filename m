Return-Path: <linux-can+bounces-2004-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA369C5EF3
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 18:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB2E28151B
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 17:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAE821500F;
	Tue, 12 Nov 2024 17:28:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E163215C5A;
	Tue, 12 Nov 2024 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432510; cv=none; b=HMOpeKwSO7nCXOrUlfy/x8OcOsnGpj2sQs9JrGNGy6lb2E28dG8ZDxD//6v05aEeZrjs7OHhzJfEdytml5BTk31WwZawFlsOrXR2z+QLzqQ9Bgl7T6CTONsrwKoqGvNUyUomgMRpEnIP6VbIk9N2z5HhbaLuta5ULSpldW/oxpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432510; c=relaxed/simple;
	bh=NxGx5LvNaB+W1MatwU+Reu1ZyoVRJisImSs03EU7MXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flJ7xnOoc58MD4Ty4c6xgjfAeNWq5WFztsKIbgQCeDPWXMcJ9HfBBYQKkaE/1HhuEepdsuaeImTBZFJunQ8r4Puze0p8e4YIOM5MqFWFfFS0DvYXI0QrETn6PlLhUBAHq/TCojYxri6T6/r/Gqk4Ju2buH0wMUuwUGHEG6lGXMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-72041ff06a0so4836824b3a.2;
        Tue, 12 Nov 2024 09:28:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731432507; x=1732037307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8KoOpwkyhRS3PqVqIRjg2hxzpyfF+mN3WNLkLLDJ/8=;
        b=L8leaynAHWCSVrHCV1Oz86mAoWHoHRYDvzN7++6CGL8wdX15EpSYUUoBeo8qX2YfIA
         JCjJw/naWqWeYBum5UeXMMU66gvmqB2BarybTVgV68S7lHonVXGi8o35rbYBD25X7omx
         B4qtEftyp5ueDj/e8lOEmL4/uhW+OfTGYybTxefhryh2HtnrX8tZbLe3wiUYFNDEBfJw
         TGMDHBF3FnKS2sx2NKd8HRc/oKvcJ0P6QyqOBjiM1eWWO8E5B5sNrYYSgGlaJ/jk/seq
         k8EpjpfzRwyY4jBL7Jayz9vN8PrqmVK1OiTDXJTFiE6jLzhx5+53zwbV7uHYhowKUMK6
         xCIA==
X-Forwarded-Encrypted: i=1; AJvYcCX62QztVYMp2R1AjJuMcPRWEhTY3mF5BnDEHbTCpS8Uj4BEpOMHUjIw45qKCWVi4OGEmVsdatt2nbQ=@vger.kernel.org, AJvYcCXHnzqoUACY2enxM+K3w5E4lTghRs869jZ/HuwyYLeZu+3Bzs4uLtcOtQ14wKLyRDLsqG9BQSC7Dt6t4dtH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw97STGRKy5LkehQp2VSjNz1lVxLcCVigvxmLBMjVsglhT53JS+
	K41TItZ3xYPr9zrAWRnYvf83BzMIGgwM2pVLOE0m5YO7U+OUx0vOScTXagcC
X-Google-Smtp-Source: AGHT+IFmQVmWnEvel4LsYHGUNSnQ/WgSxfj3tIuYyobWcVyRdNqd+nzUtfDFoEvK5VEo6wP0CfJnlQ==
X-Received: by 2002:a05:6a00:139f:b0:71e:b1dc:f255 with SMTP id d2e1a72fcca58-7241329a391mr23153863b3a.9.1731432507276;
        Tue, 12 Nov 2024 09:28:27 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407864f78sm11481439b3a.33.2024.11.12.09.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:28:26 -0800 (PST)
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
Subject: [PATCH iproute2-next v1 3/6] iplink_can: remove newline at the end of invarg()'s messages
Date: Wed, 13 Nov 2024 02:27:53 +0900
Message-ID: <20241112172812.590665-11-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112172812.590665-8-mailhol.vincent@wanadoo.fr>
References: <20241112172812.590665-8-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5013; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=NxGx5LvNaB+W1MatwU+Reu1ZyoVRJisImSs03EU7MXI=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOnGE3Ta8yYkLbwp7j/z3A/zLU+2u4dPytyhuXPZX/eoc /s+fmbK6ShhYRDjYpAVU2RZVs7JrdBR6B126K8lzBxWJpAhDFycAjCRDSYM/x2bkzgMxUPXPd0v M1vX+4/tuYd8GnqH7wX3chy5WCS8/CjDZ7acxDkX52nPUXR5l/5Rhb3iaWJUSKp7VuexmE98162 ZAA==
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

invarg() already prints a new line by default. Adding an explicit "\n"
at the end of the message results in two lines being printed. Remove
all newlines at the end of the invarg() messages.

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


