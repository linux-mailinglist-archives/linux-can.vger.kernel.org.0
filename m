Return-Path: <linux-can+bounces-1944-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA9B9C33BD
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 17:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A1C1C209F1
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 16:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B363855896;
	Sun, 10 Nov 2024 16:04:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A744C3D0
	for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254681; cv=none; b=W+OPB5WBqrnmUv51Jnyvu8+xRyl3dHqd27TbG21abci05aD/x6Vq1A7MdOOmcVQUykYB5IOKGMakbUGusAbAwbj28ZnwptWWS8AwL6CNgIBMYUBi11hzRZ4n+xcXu4+9Nmn31+5uY03AhdzFiuXLWVUxkdQOYjO/0tR2SfbxUeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254681; c=relaxed/simple;
	bh=5OwKrnxEDrHt798BfRCR+y4CIHO4jG6U+1nQ/Hh9wSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoRC0VE/z4ZoZWfazghVOi9m1mWUOejcicIDfmTGGOBBKuh4fmZmvuLvitWGbMNs7i3P2KNJpr8iUXtxyuyHiDU/vcm9jYiPDqYyFVbnRu48Qz9GTLFt3qCNhLc5QhZbWdS0BmtygLG5hNU+WNMgWcEA+pzaePITMs7LMkZ2JR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso2797358b3a.3
        for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 08:04:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254679; x=1731859479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYDRRKCT3x74BG85ECPemvD2h4beG2fbh/Wo/bgVXXw=;
        b=rNKJTwcgkz5LqTAdw0v6+/wNMhTD3AiqTpUKB5fBlDK83n4rkhmi4GeOt9tJaONAGH
         GjWaXij+KwdWOLpKtl7odV7SbayJxY4RONCbMXOsxnreZn+uui2OO4aatluSTBz+QVl/
         1iIn8F2pvEkSRRM9y3P2KYJ2WDO5QyyLy7nibFxM2ARFCH280plDgbg7Z1BtaySvk7cb
         VpPnTAQRLxUwkWGstVuwCeIYMUShSEES1Az5fAp9glkWn4AVwm4kjzUf+kllgqax/Vd9
         0o9+vqnpuVgIgEhW/j3BC+RtFQ1ENzZr2/cudC8kcYHl7JoOVnQRcP93IPcFfkgyVUv2
         e7Jg==
X-Gm-Message-State: AOJu0YyfkvmoekCHBQjrnC0uBTIvkVEb0qFWFAGpJhHTqTO5FjmppBYv
	6ubRQviMcejj3+b46g39NjkBbvlIDXWdmEDaYYlo81nDnSoMG3mVJrgrKQ==
X-Google-Smtp-Source: AGHT+IEuF+TdAXofmA86obFGfTL10Sm97Mm4/ZnScWokOGhfWVcq/bWwaDr6UodAUKdqfLYSlcLXiw==
X-Received: by 2002:a05:6a00:14d3:b0:71d:ee1b:c854 with SMTP id d2e1a72fcca58-724132a134dmr14095549b3a.9.1731254678748;
        Sun, 10 Nov 2024 08:04:38 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a48cbsm7383037b3a.45.2024.11.10.08.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 08:04:38 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH 8/8] iplink_can: add CAN XL
Date: Mon, 11 Nov 2024 01:01:38 +0900
Message-ID: <20241110160406.73584-18-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110160406.73584-10-mailhol.vincent@wanadoo.fr>
References: <20241110160406.73584-10-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13300; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=5OwKrnxEDrHt798BfRCR+y4CIHO4jG6U+1nQ/Hh9wSI=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkGNyuyNwT94FuncHX1f3MVqZ7ff14UTC/4X2s43bF0f 4h06FfRjlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABOJOMjI8C1rr1T4d63wW1cW H+S2u533Va7CfMu9Rdc73lbd/vqFZTXDP9Mt7y+932Oll7x1R/ad6/YmTOoRX28zL7CuuzJP1Pl nBzcA
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 ip/iplink_can.c | 209 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 196 insertions(+), 13 deletions(-)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 54acc65c..43018c54 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -26,6 +26,10 @@ static void print_usage(FILE *f)
 		"\t[ dtq TQ dprop-seg PROP_SEG dphase-seg1 PHASE-SEG1\n \t  dphase-seg2 PHASE-SEG2 [ dsjw SJW ] ]\n"
 		"\t[ tdcv TDCV tdco TDCO tdcf TDCF ]\n"
 		"\n"
+		"\t[ xl-dbitrate BITRATE [ xl-dsample-point SAMPLE-POINT] ] |\n"
+		"\t[ xl-dtq TQ xl-dprop-seg PROP_SEG xl-dphase-seg1 PHASE-SEG1\n \t  xl-dphase-seg2 PHASE-SEG2 [ xl-dsjw SJW ] ]\n"
+		"\t[ xl-tdcv TDCV xl-tdco TDCO xl-tdcf TDCF ]\n"
+		"\n"
 		"\t[ loopback { on | off } ]\n"
 		"\t[ listen-only { on | off } ]\n"
 		"\t[ triple-sampling { on | off } ]\n"
@@ -36,6 +40,8 @@ static void print_usage(FILE *f)
 		"\t[ presume-ack { on | off } ]\n"
 		"\t[ cc-len8-dlc { on | off } ]\n"
 		"\t[ tdc-mode { auto | manual | off } ]\n"
+		"\t[ xl { on | off } ]\n"
+		"\t[ xl-tdc-mode { auto | manual | off } ]\n"
 		"\n"
 		"\t[ restart-ms TIME-MS ]\n"
 		"\t[ restart ]\n"
@@ -116,6 +122,9 @@ static void print_ctrlmode(enum output_type t, __u32 flags, const char* key)
 	print_flag(t, &flags, CAN_CTRLMODE_CC_LEN8_DLC, "CC-LEN8-DLC");
 	print_flag(t, &flags, CAN_CTRLMODE_TDC_AUTO, "TDC-AUTO");
 	print_flag(t, &flags, CAN_CTRLMODE_TDC_MANUAL, "TDC-MANUAL");
+	print_flag(t, &flags, CAN_CTRLMODE_XL, "XL");
+	print_flag(t, &flags, CAN_CTRLMODE_XL_TDC_AUTO, "XL-TDC-AUTO");
+	print_flag(t, &flags, CAN_CTRLMODE_XL_TDC_MANUAL, "XL-TDC-MANUAL");
 
 	if (flags)
 		print_hex(t, NULL, "%x", flags);
@@ -132,9 +141,10 @@ struct can_tdc {
 static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 			 struct nlmsghdr *n)
 {
-	struct can_bittiming bt = {}, fd_dbt = {};
+	struct can_bittiming bt = {}, fd_dbt = {}, xl_dbt = {};
 	struct can_ctrlmode cm = { 0 };
 	struct can_tdc fd = { .tdcv = -1, .tdco = -1, .tdcf = -1 };
+	struct can_tdc xl = { .tdcv = -1, .tdco = -1, .tdcf = -1 };
 
 	while (argc > 0) {
 		if (matches(*argv, "bitrate") == 0) {
@@ -212,6 +222,53 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 			NEXT_ARG();
 			if (get_u32(&fd.tdcf, *argv, 0))
 				invarg("invalid \"tdcf\" value", *argv);
+		} else if (matches(*argv, "xl") == 0) {
+			NEXT_ARG();
+			set_ctrlmode("xl", *argv, &cm,
+				     CAN_CTRLMODE_XL);
+		} else if (matches(*argv, "xl-dbitrate") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl_dbt.bitrate, *argv, 0))
+				invarg("invalid \"xl-dbitrate\" value", *argv);
+		} else if (matches(*argv, "xl-dsample-point") == 0) {
+			float sp;
+
+			NEXT_ARG();
+			if (get_float(&sp, *argv))
+				invarg("invalid \"xl-dsample-point\" value", *argv);
+			xl_dbt.sample_point = (__u32)(sp * 1000);
+		} else if (matches(*argv, "xl-dtq") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl_dbt.tq, *argv, 0))
+				invarg("invalid \"xl-dtq\" value", *argv);
+		} else if (matches(*argv, "xl-dprop-seg") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl_dbt.prop_seg, *argv, 0))
+				invarg("invalid \"xl-dprop-seg\" value", *argv);
+		} else if (matches(*argv, "xl-dphase-seg1") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl_dbt.phase_seg1, *argv, 0))
+				invarg("invalid \"xl-dphase-seg1\" value", *argv);
+		} else if (matches(*argv, "xl-dphase-seg2") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl_dbt.phase_seg2, *argv, 0))
+				invarg("invalid \"xl-dphase-seg2\" value", *argv);
+		} else if (matches(*argv, "xl-dsjw") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl_dbt.sjw, *argv, 0))
+				invarg("invalid \"xl-dsjw\" value", *argv);
+		} else if (matches(*argv, "xl-tdcv") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl.tdcv, *argv, 0))
+				invarg("invalid \"xl-tdcv\" value", *argv);
+		} else if (matches(*argv, "xl-tdco") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl.tdco, *argv, 0))
+				invarg("invalid \"xl-tdco\" value", *argv);
+		} else if (matches(*argv, "xl-tdcf") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl.tdcf, *argv, 0))
+				invarg("invalid \"xl-tdcf\" value", *argv);
 		} else if (matches(*argv, "loopback") == 0) {
 			NEXT_ARG();
 			set_ctrlmode("loopback", *argv, &cm,
@@ -263,6 +320,21 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 				invarg("\"tdc-mode\" must be either of \"auto\", \"manual\" or \"off\"",
 					*argv);
 			}
+		} else if (matches(*argv, "xl-tdc-mode") == 0) {
+			NEXT_ARG();
+			if (strcmp(*argv, "auto") == 0) {
+				cm.flags |= CAN_CTRLMODE_XL_TDC_AUTO;
+				cm.mask |= CAN_CTRLMODE_XL_TDC_AUTO;
+			} else if (strcmp(*argv, "manual") == 0) {
+				cm.flags |= CAN_CTRLMODE_XL_TDC_MANUAL;
+				cm.mask |= CAN_CTRLMODE_XL_TDC_MANUAL;
+			} else if (strcmp(*argv, "off") == 0) {
+				cm.mask |= CAN_CTRLMODE_XL_TDC_AUTO |
+					   CAN_CTRLMODE_XL_TDC_MANUAL;
+			} else {
+				invarg("\"xl-tdc-mode\" must be either of \"auto\", \"manual\" or \"off\"",
+					*argv);
+			}
 		} else if (matches(*argv, "restart") == 0) {
 			__u32 val = 1;
 
@@ -297,6 +369,8 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 		addattr_l(n, 1024, IFLA_CAN_BITTIMING, &bt, sizeof(bt));
 	if (fd_dbt.bitrate || fd_dbt.tq)
 		addattr_l(n, 1024, IFLA_CAN_DATA_BITTIMING, &fd_dbt, sizeof(fd_dbt));
+	if (xl_dbt.bitrate || xl_dbt.tq)
+		addattr_l(n, 1024, IFLA_CAN_XL_DATA_BITTIMING, &xl_dbt, sizeof(xl_dbt));
 	if (cm.mask)
 		addattr_l(n, 1024, IFLA_CAN_CTRLMODE, &cm, sizeof(cm));
 
@@ -312,6 +386,18 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 			addattr32(n, 1024, IFLA_CAN_TDC_TDCF, fd.tdcf);
 		addattr_nest_end(n, tdc);
 	}
+	if (xl.tdcv != -1 || xl.tdco != -1 || xl.tdcf != -1) {
+		struct rtattr *tdc = addattr_nest(n, 1024,
+						  IFLA_CAN_XL_TDC | NLA_F_NESTED);
+
+		if (xl.tdcv != -1)
+			addattr32(n, 1024, IFLA_CAN_TDC_TDCV, xl.tdcv);
+		if (xl.tdco != -1)
+			addattr32(n, 1024, IFLA_CAN_TDC_TDCO, xl.tdco);
+		if (xl.tdcf != -1)
+			addattr32(n, 1024, IFLA_CAN_TDC_TDCF, xl.tdcf);
+		addattr_nest_end(n, tdc);
+	}
 
 	return 0;
 }
@@ -342,58 +428,67 @@ can_print_timing_min_max(const char *json_attr, const char *fp_attr,
 	close_json_object();
 }
 
-static void can_print_tdc_opt(struct rtattr *tdc_attr)
+static void can_print_tdc_opt(struct rtattr *tdc_attr, bool is_xl)
 {
 	struct rtattr *tb[IFLA_CAN_TDC_MAX + 1];
 
 	parse_rtattr_nested(tb, IFLA_CAN_TDC_MAX, tdc_attr);
 	if (tb[IFLA_CAN_TDC_TDCV] || tb[IFLA_CAN_TDC_TDCO] ||
 	    tb[IFLA_CAN_TDC_TDCF]) {
-		open_json_object("tdc");
+		const char *tdc = is_xl ? "xl-tdc" : "tdc";
+
+		open_json_object(tdc);
 		can_print_nl_indent();
 		if (tb[IFLA_CAN_TDC_TDCV]) {
+			const char *tdcv_fmt = is_xl ? " xl-tdcv %u" : " tdcv %u";
 			__u32 *tdcv = RTA_DATA(tb[IFLA_CAN_TDC_TDCV]);
 
-			print_uint(PRINT_ANY, "tdcv", " tdcv %u", *tdcv);
+			print_uint(PRINT_ANY, "tdcv", tdcv_fmt, *tdcv);
 		}
 		if (tb[IFLA_CAN_TDC_TDCO]) {
+			const char *tdco_fmt = is_xl ? " xl-tdco %u" : " tdco %u";
 			__u32 *tdco = RTA_DATA(tb[IFLA_CAN_TDC_TDCO]);
 
-			print_uint(PRINT_ANY, "tdco", " tdco %u", *tdco);
+			print_uint(PRINT_ANY, "tdco", tdco_fmt, *tdco);
 		}
 		if (tb[IFLA_CAN_TDC_TDCF]) {
+			const char *tdcf_fmt = is_xl ? " xl-tdcf %u" : " tdcf %u";
 			__u32 *tdcf = RTA_DATA(tb[IFLA_CAN_TDC_TDCF]);
 
-			print_uint(PRINT_ANY, "tdcf", " tdcf %u", *tdcf);
+			print_uint(PRINT_ANY, "tdcf", tdcf_fmt, *tdcf);
 		}
 		close_json_object();
 	}
 }
 
-static void can_print_tdc_const_opt(struct rtattr *tdc_attr)
+static void can_print_tdc_const_opt(struct rtattr *tdc_attr, bool is_xl)
 {
+	const char *tdc = is_xl ? "xl-tdc" : "tdc";
 	struct rtattr *tb[IFLA_CAN_TDC_MAX + 1];
 
 	parse_rtattr_nested(tb, IFLA_CAN_TDC_MAX, tdc_attr);
-	open_json_object("tdc");
+	open_json_object(tdc);
 	can_print_nl_indent();
 	if (tb[IFLA_CAN_TDC_TDCV_MIN] && tb[IFLA_CAN_TDC_TDCV_MAX]) {
 		__u32 *tdcv_min = RTA_DATA(tb[IFLA_CAN_TDC_TDCV_MIN]);
 		__u32 *tdcv_max = RTA_DATA(tb[IFLA_CAN_TDC_TDCV_MAX]);
+		const char *tdcv = is_xl ? " xl-tdcv" : " tdcv";
 
-		can_print_timing_min_max("tdcv", " tdcv", *tdcv_min, *tdcv_max);
+		can_print_timing_min_max("tdcv", tdcv, *tdcv_min, *tdcv_max);
 	}
 	if (tb[IFLA_CAN_TDC_TDCO_MIN] && tb[IFLA_CAN_TDC_TDCO_MAX]) {
 		__u32 *tdco_min = RTA_DATA(tb[IFLA_CAN_TDC_TDCO_MIN]);
 		__u32 *tdco_max = RTA_DATA(tb[IFLA_CAN_TDC_TDCO_MAX]);
+		const char *tdco = is_xl ? " xl-tdco" : " tdco";
 
-		can_print_timing_min_max("tdco", " tdco", *tdco_min, *tdco_max);
+		can_print_timing_min_max("tdco", tdco, *tdco_min, *tdco_max);
 	}
 	if (tb[IFLA_CAN_TDC_TDCF_MIN] && tb[IFLA_CAN_TDC_TDCF_MAX]) {
 		__u32 *tdcf_min = RTA_DATA(tb[IFLA_CAN_TDC_TDCF_MIN]);
 		__u32 *tdcf_max = RTA_DATA(tb[IFLA_CAN_TDC_TDCF_MAX]);
+		const char *tdcf = is_xl ? " xl-tdcf" : " tdcf";
 
-		can_print_timing_min_max("tdcf", " tdcf", *tdcf_min, *tdcf_max);
+		can_print_timing_min_max("tdcf", tdcf, *tdcf_min, *tdcf_max);
 	}
 	close_json_object();
 }
@@ -547,7 +642,7 @@ static void can_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 		print_uint(PRINT_ANY, "brp", " dbrp %u", dbt->brp);
 
 		if (tb[IFLA_CAN_TDC])
-			can_print_tdc_opt(tb[IFLA_CAN_TDC]);
+			can_print_tdc_opt(tb[IFLA_CAN_TDC], false);
 
 		close_json_object();
 	}
@@ -571,7 +666,7 @@ static void can_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 		print_uint(PRINT_ANY, "brp_inc", " dbrp_inc %u", dbtc->brp_inc);
 
 		if (tb[IFLA_CAN_TDC])
-			can_print_tdc_const_opt(tb[IFLA_CAN_TDC]);
+			can_print_tdc_const_opt(tb[IFLA_CAN_TDC], false);
 
 		close_json_object();
 	}
@@ -610,6 +705,94 @@ static void can_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 		close_json_array(PRINT_ANY, " ]");
 	}
 
+	/* data bittiming is irrelevant if fixed bitrate is defined */
+	if (tb[IFLA_CAN_XL_DATA_BITTIMING] &&
+	    !tb[IFLA_CAN_XL_DATA_BITRATE_CONST]) {
+		struct can_bittiming *dbt =
+			RTA_DATA(tb[IFLA_CAN_XL_DATA_BITTIMING]);
+		char dsp[6];
+
+		open_json_object("xl_data_bittiming");
+		can_print_nl_indent();
+		print_uint(PRINT_ANY, "bitrate", " xl-dbitrate %u", dbt->bitrate);
+		snprintf(dsp, sizeof(dsp), "%.3f", dbt->sample_point / 1000.);
+		print_string(PRINT_ANY, "sample_point", " xl-dsample-point %s",
+			     dsp);
+		can_print_nl_indent();
+		print_uint(PRINT_ANY, "tq", " xl-dtq %u", dbt->tq);
+		print_uint(PRINT_ANY, "prop_seg", " xl-dprop-seg %u",
+			   dbt->prop_seg);
+		print_uint(PRINT_ANY, "phase_seg1", " xl-dphase-seg1 %u",
+			   dbt->phase_seg1);
+		print_uint(PRINT_ANY, "phase_seg2", " xl-dphase-seg2 %u",
+			   dbt->phase_seg2);
+		print_uint(PRINT_ANY, "sjw", " xl-dsjw %u", dbt->sjw);
+		print_uint(PRINT_ANY, "brp", " xl-dbrp %u", dbt->brp);
+
+		if (tb[IFLA_CAN_XL_TDC])
+			can_print_tdc_opt(tb[IFLA_CAN_XL_TDC], true);
+
+		close_json_object();
+	}
+
+	/* data bittiming const is irrelevant if fixed bitrate is defined */
+	if (tb[IFLA_CAN_XL_DATA_BITTIMING_CONST] &&
+	    !tb[IFLA_CAN_XL_DATA_BITRATE_CONST]) {
+		struct can_bittiming_const *dbtc =
+			RTA_DATA(tb[IFLA_CAN_XL_DATA_BITTIMING_CONST]);
+
+		open_json_object("xl_data_bittiming_const");
+		can_print_nl_indent();
+		print_string(PRINT_ANY, "name", " %s:", dbtc->name);
+		can_print_timing_min_max("tseg1", " xl-dtseg1",
+					 dbtc->tseg1_min, dbtc->tseg1_max);
+		can_print_timing_min_max("tseg2", " xl-dtseg2",
+					 dbtc->tseg2_min, dbtc->tseg2_max);
+		can_print_timing_min_max("sjw", " xl-dsjw", 1, dbtc->sjw_max);
+		can_print_timing_min_max("brp", " xl-dbrp",
+					 dbtc->brp_min, dbtc->brp_max);
+		print_uint(PRINT_ANY, "brp_inc", " xl-dbrp_inc %u", dbtc->brp_inc);
+
+		if (tb[IFLA_CAN_XL_TDC])
+			can_print_tdc_const_opt(tb[IFLA_CAN_XL_TDC], true);
+
+		close_json_object();
+	}
+
+	if (tb[IFLA_CAN_XL_DATA_BITRATE_CONST]) {
+		__u32 *dbitrate_const =
+			RTA_DATA(tb[IFLA_CAN_XL_DATA_BITRATE_CONST]);
+		int dbitrate_cnt =
+			RTA_PAYLOAD(tb[IFLA_CAN_XL_DATA_BITRATE_CONST]) /
+			sizeof(*dbitrate_const);
+		int i;
+		__u32 dbitrate = 0;
+
+		if (tb[IFLA_CAN_XL_DATA_BITTIMING]) {
+			struct can_bittiming *dbt =
+				RTA_DATA(tb[IFLA_CAN_XL_DATA_BITTIMING]);
+			dbitrate = dbt->bitrate;
+		}
+
+		can_print_nl_indent();
+		print_uint(PRINT_ANY, "xl_data_bittiming_bitrate", " xl-dbitrate %u",
+			   dbitrate);
+		can_print_nl_indent();
+		open_json_array(PRINT_ANY, is_json_context() ?
+				"data_bitrate_const" : "    [");
+		for (i = 0; i < dbitrate_cnt; ++i) {
+			/* This will keep lines below 80 signs */
+			if (!(i % 6) && i) {
+				can_print_nl_indent();
+				print_string(PRINT_FP, NULL, "%s", "     ");
+			}
+			print_uint(PRINT_ANY, NULL,
+				   i < dbitrate_cnt - 1 ? "%8u, " : "%8u",
+				   dbitrate_const[i]);
+		}
+		close_json_array(PRINT_ANY, " ]");
+	}
+
 	if (tb[IFLA_CAN_TERMINATION_CONST] && tb[IFLA_CAN_TERMINATION]) {
 		__u16 *trm = RTA_DATA(tb[IFLA_CAN_TERMINATION]);
 		__u16 *trm_const = RTA_DATA(tb[IFLA_CAN_TERMINATION_CONST]);
-- 
2.45.2


