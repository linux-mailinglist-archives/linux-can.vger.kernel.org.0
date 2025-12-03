Return-Path: <linux-can+bounces-5815-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B165CA14B8
	for <lists+linux-can@lfdr.de>; Wed, 03 Dec 2025 20:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66AEC30D950B
	for <lists+linux-can@lfdr.de>; Wed,  3 Dec 2025 18:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5831832E739;
	Wed,  3 Dec 2025 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhoX6cMu"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BCE32E727;
	Wed,  3 Dec 2025 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786369; cv=none; b=k29QOxc4DKcKTBxYHszP1pE0CAxTwkzVJ0N/qhC2Uf1etD/l6wVbSNqiS8M+UuaFBD2D+nIJUg/CqtpmygMfxOSySezpfZEMazSy/MHuRpkpMyq1brvRL3bWwjEuvhT0ZtAp6pVgFJvvEwBJUO0wiQBFYlB4ldxEafzG0LBSsOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786369; c=relaxed/simple;
	bh=4EUBV3E88jFzZaKHRIUFav7cr3DT7U8xegEVdEy5mww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XDGfDHsxncW79BIDeW1BR4ckA8kT/lmY2XzKCrswsh56l8qWrBi0tDaKZ4LTyE9iPlQHLmp87/qxptKXZ5SSISsACZuPMZf1eSd86J6kOwaT/jWmUkV5IF/ClVAL8xDIBXi5cTPRvO3NbFLXkBH6Pg6f68bTCw7cK30cK5A9oXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhoX6cMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AE9C116C6;
	Wed,  3 Dec 2025 18:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764786369;
	bh=4EUBV3E88jFzZaKHRIUFav7cr3DT7U8xegEVdEy5mww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AhoX6cMu0ewqhOzvuumhgIY+dkRx0l7a+lN8RWFkLNNpdBxUS+S99t3NzLOm7lInn
	 /+6hRVz5tNclaEgH6lLEBkNXrmMoU8Dgr7vapKaAdGjdrYZakApbbhmiJYQngs19k5
	 gxRnEqTTdzbYUmo7jymL3tbp2Z/fIZ/G4VFhgfuZY1IJzJQzttYcKorgaQsxys/mXd
	 Q9gE1YJs0rPHvCiEP+CUQT1o8j4Qng2WSAvX4QO3phIrtXUmnM1cJ4tCqnMjnQmdJO
	 DuQpDZfaC9kLgQLSZQCA79YReJ+E4YMXw6zMv7XbskeuWme4hAktE1Zo5m8ZLImPdF
	 1dfg8BqL+Foag==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 03 Dec 2025 19:24:32 +0100
Subject: [PATCH iproute2-next v3 5/7] iplink_can: add initial CAN XL
 support
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-canxl-netlink-v3-5-999f38fae8c2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=14776; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=4EUBV3E88jFzZaKHRIUFav7cr3DT7U8xegEVdEy5mww=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJkGDUt3NTAbsZVWTfRidT+y5MMNV4/ml/MbRDfMOHxs3
 b1wP+bFHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACZyqZnhr+xWThnml5KRfxhV
 +BOYTznNrrj2+nFxXtfZY7bTtk6/c5Thv+PFL5Lh/I83r/ggPsX12e/fCw5xXH7r7Xp+44nzWSW
 mISwA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

This is the iproute2 counterpart of Linux kernel's commit e63281614747
("can: netlink: add initial CAN XL support").

CAN XL uses bittiming parameters different from Classical CAN and CAN FD.
Thus, all the data bittiming parameters, including TDC, need to be
duplicated for CAN XL.

Add the "xl" option to iplink_can which controls the CAN_CTRLMODE_XL flag
of the netlink interface. Then add the "xbitrate", "xsample-point", "xtq",
"xprop-seg", "xphase-seg1", "xphase-seg2", "xsjw", "xtdcv", "xtdco",
"xtdcf" and "xtdc-mode" which are all sub options of "xl". Add the logic to
query and print all those values. Update print_usage() accordingly.

All these options behave similarly to their CAN FD equivalent.

The new options which are specific to CAN XL (i.e. not inherited from CAN
FD) will be added in a subsequent change.

Example using the dummy_can driver:

  # modprobe dummy_can
  # ip link set can0 type can bitrate 500000 fd on dbitrate 2000000 xl on xbitrate 8000000
  $ ip --details link show can0
  5: can0: <NOARP> mtu 2060 qdisc noop state DOWN mode DEFAULT group default qlen 10
      link/can  promiscuity 0 allmulti 0 minmtu 76 maxmtu 2060
      can <FD,TDC-AUTO,XL,XL-TDC-AUTO> state STOPPED restart-ms 0
  	  bitrate 500000 sample-point 0.875
  	  tq 12 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 10 brp 2
  	  dummy_can CC: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 brp_inc 1
  	  dbitrate 2000000 dsample-point 0.750
  	  dtq 6 dprop-seg 29 dphase-seg1 30 dphase-seg2 20 dsjw 10 dbrp 1
  	  tdco 60 tdcf 0
  	  dummy_can FD: dtseg1 2..256 dtseg2 2..128 dsjw 1..128 dbrp 1..512 dbrp_inc 1
  	  tdco 0..127 tdcf 0..127
  	  xbitrate 8000000 xsample-point 0.750
  	  xtq 6 xprop-seg 7 xphase-seg1 7 xphase-seg2 5 xsjw 2 xbrp 1
  	  xtdco 15 xtdcf 0
  	  dummy_can XL: xtseg1 2..256 xtseg2 2..128 xsjw 1..128 xbrp 1..512 xbrp_inc 1
  	  xtdco 0..127 xtdcf 0..127
  	  clock 160000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changelog:

v2 -> v3:

  - only use string literals in print_uint(). To achieve this, remove the
    "is_xl" parameter from can_print_xtdc_opt() and instead add
    can_print_xtdc_opt().

v1 -> v2:

  - s/matches/strcmp/g in can_parse_opt().
---
 ip/iplink_can.c | 219 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 212 insertions(+), 7 deletions(-)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 0ba86550..8529a625 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -32,6 +32,10 @@ static void print_usage(FILE *f)
 		"\t[ dtq TQ dprop-seg PROP_SEG dphase-seg1 PHASE-SEG1\n \t  dphase-seg2 PHASE-SEG2 [ dsjw SJW ] ]\n"
 		"\t[ tdcv TDCV tdco TDCO tdcf TDCF ]\n"
 		"\n"
+		"\t[ xbitrate BITRATE [ xsample-point SAMPLE-POINT] ] |\n"
+		"\t[ xtq TQ xprop-seg PROP_SEG xphase-seg1 PHASE-SEG1\n \t  xphase-seg2 PHASE-SEG2 [ xsjw SJW ] ]\n"
+		"\t[ xtdcv TDCV xtdco TDCO xtdcf TDCF ]\n"
+		"\n"
 		"\t[ loopback { on | off } ]\n"
 		"\t[ listen-only { on | off } ]\n"
 		"\t[ triple-sampling { on | off } ]\n"
@@ -43,6 +47,8 @@ static void print_usage(FILE *f)
 		"\t[ cc-len8-dlc { on | off } ]\n"
 		"\t[ tdc-mode { auto | manual | off } ]\n"
 		"\t[ restricted { on | off } ]\n"
+		"\t[ xl { on | off } ]\n"
+		"\t[ xtdc-mode { auto | manual | off } ]\n"
 		"\n"
 		"\t[ restart-ms TIME-MS ]\n"
 		"\t[ restart ]\n"
@@ -118,6 +124,9 @@ static void print_ctrlmode(enum output_type t, __u32 flags, const char *key)
 	print_flag(t, &flags, CAN_CTRLMODE_TDC_AUTO, "TDC-AUTO");
 	print_flag(t, &flags, CAN_CTRLMODE_TDC_MANUAL, "TDC-MANUAL");
 	print_flag(t, &flags, CAN_CTRLMODE_RESTRICTED, "RESTRICTED");
+	print_flag(t, &flags, CAN_CTRLMODE_XL, "XL");
+	print_flag(t, &flags, CAN_CTRLMODE_XL_TDC_AUTO, "XL-TDC-AUTO");
+	print_flag(t, &flags, CAN_CTRLMODE_XL_TDC_MANUAL, "XL-TDC-MANUAL");
 
 	if (flags)
 		print_hex(t, NULL, "%x", flags);
@@ -128,9 +137,10 @@ static void print_ctrlmode(enum output_type t, __u32 flags, const char *key)
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
@@ -208,6 +218,52 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 			NEXT_ARG();
 			if (get_u32(&fd.tdcf, *argv, 0))
 				invarg("invalid \"tdcf\" value", *argv);
+		} else if (strcmp(*argv, "xl") == 0) {
+			NEXT_ARG();
+			set_ctrlmode("xl", *argv, &cm, CAN_CTRLMODE_XL);
+		} else if (strcmp(*argv, "xbitrate") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl_dbt.bitrate, *argv, 0))
+				invarg("invalid \"xbitrate\" value", *argv);
+		} else if (strcmp(*argv, "xsample-point") == 0) {
+			float sp;
+
+			NEXT_ARG();
+			if (get_float(&sp, *argv))
+				invarg("invalid \"xsample-point\" value", *argv);
+			xl_dbt.sample_point = (__u32)(sp * 1000);
+		} else if (strcmp(*argv, "xtq") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl_dbt.tq, *argv, 0))
+				invarg("invalid \"xtq\" value", *argv);
+		} else if (strcmp(*argv, "xprop-seg") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl_dbt.prop_seg, *argv, 0))
+				invarg("invalid \"xprop-seg\" value", *argv);
+		} else if (strcmp(*argv, "xphase-seg1") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl_dbt.phase_seg1, *argv, 0))
+				invarg("invalid \"xphase-seg1\" value", *argv);
+		} else if (strcmp(*argv, "xphase-seg2") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl_dbt.phase_seg2, *argv, 0))
+				invarg("invalid \"xphase-seg2\" value", *argv);
+		} else if (strcmp(*argv, "xsjw") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl_dbt.sjw, *argv, 0))
+				invarg("invalid \"xsjw\" value", *argv);
+		} else if (strcmp(*argv, "xtdcv") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl.tdcv, *argv, 0))
+				invarg("invalid \"xtdcv\" value", *argv);
+		} else if (strcmp(*argv, "xtdco") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl.tdco, *argv, 0))
+				invarg("invalid \"xtdco\" value", *argv);
+		} else if (strcmp(*argv, "xtdcf") == 0) {
+			NEXT_ARG();
+			if (get_u32(&xl.tdcf, *argv, 0))
+				invarg("invalid \"xtdcf\" value", *argv);
 		} else if (matches(*argv, "loopback") == 0) {
 			NEXT_ARG();
 			set_ctrlmode("loopback", *argv, &cm,
@@ -262,6 +318,21 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 		} else if (strcmp(*argv, "restricted") == 0) {
 			NEXT_ARG();
 			set_ctrlmode("restricted", *argv, &cm, CAN_CTRLMODE_RESTRICTED);
+		} else if (strcmp(*argv, "xtdc-mode") == 0) {
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
+				invarg("\"xtdc-mode\" must be either of \"auto\", \"manual\" or \"off\"",
+					*argv);
+			}
 		} else if (matches(*argv, "restart") == 0) {
 			__u32 val = 1;
 
@@ -296,6 +367,8 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 		addattr_l(n, 1024, IFLA_CAN_BITTIMING, &bt, sizeof(bt));
 	if (fd_dbt.bitrate || fd_dbt.tq)
 		addattr_l(n, 1024, IFLA_CAN_DATA_BITTIMING, &fd_dbt, sizeof(fd_dbt));
+	if (xl_dbt.bitrate || xl_dbt.tq)
+		addattr_l(n, 1024, IFLA_CAN_XL_DATA_BITTIMING, &xl_dbt, sizeof(xl_dbt));
 	if (cm.mask)
 		addattr_l(n, 1024, IFLA_CAN_CTRLMODE, &cm, sizeof(cm));
 
@@ -311,6 +384,18 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
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
@@ -369,30 +454,62 @@ static void can_print_tdc_opt(struct rtattr *tdc_attr)
 	}
 }
 
-static void can_print_tdc_const_opt(struct rtattr *tdc_attr)
+static void can_print_xtdc_opt(struct rtattr *tdc_attr)
 {
 	struct rtattr *tb[IFLA_CAN_TDC_MAX + 1];
 
 	parse_rtattr_nested(tb, IFLA_CAN_TDC_MAX, tdc_attr);
-	open_json_object("tdc");
+	if (tb[IFLA_CAN_TDC_TDCV] || tb[IFLA_CAN_TDC_TDCO] ||
+	    tb[IFLA_CAN_TDC_TDCF]) {
+		open_json_object("xtdc");
+		can_print_nl_indent();
+		if (tb[IFLA_CAN_TDC_TDCV]) {
+			__u32 *tdcv = RTA_DATA(tb[IFLA_CAN_TDC_TDCV]);
+
+			print_uint(PRINT_ANY, "tdcv", " xtdcv %u", *tdcv);
+		}
+		if (tb[IFLA_CAN_TDC_TDCO]) {
+			__u32 *tdco = RTA_DATA(tb[IFLA_CAN_TDC_TDCO]);
+
+			print_uint(PRINT_ANY, "tdco", " xtdco %u", *tdco);
+		}
+		if (tb[IFLA_CAN_TDC_TDCF]) {
+			__u32 *tdcf = RTA_DATA(tb[IFLA_CAN_TDC_TDCF]);
+
+			print_uint(PRINT_ANY, "tdcf", " xtdcf %u", *tdcf);
+		}
+		close_json_object();
+	}
+}
+
+static void can_print_tdc_const_opt(struct rtattr *tdc_attr, bool is_xl)
+{
+	const char *tdc = is_xl ? "xtdc" : "tdc";
+	struct rtattr *tb[IFLA_CAN_TDC_MAX + 1];
+
+	parse_rtattr_nested(tb, IFLA_CAN_TDC_MAX, tdc_attr);
+	open_json_object(tdc);
 	can_print_nl_indent();
 	if (tb[IFLA_CAN_TDC_TDCV_MIN] && tb[IFLA_CAN_TDC_TDCV_MAX]) {
 		__u32 *tdcv_min = RTA_DATA(tb[IFLA_CAN_TDC_TDCV_MIN]);
 		__u32 *tdcv_max = RTA_DATA(tb[IFLA_CAN_TDC_TDCV_MAX]);
+		const char *tdcv = is_xl ? " xtdcv" : " tdcv";
 
-		can_print_timing_min_max("tdcv", " tdcv", *tdcv_min, *tdcv_max);
+		can_print_timing_min_max("tdcv", tdcv, *tdcv_min, *tdcv_max);
 	}
 	if (tb[IFLA_CAN_TDC_TDCO_MIN] && tb[IFLA_CAN_TDC_TDCO_MAX]) {
 		__u32 *tdco_min = RTA_DATA(tb[IFLA_CAN_TDC_TDCO_MIN]);
 		__u32 *tdco_max = RTA_DATA(tb[IFLA_CAN_TDC_TDCO_MAX]);
+		const char *tdco = is_xl ? " xtdco" : " tdco";
 
-		can_print_timing_min_max("tdco", " tdco", *tdco_min, *tdco_max);
+		can_print_timing_min_max("tdco", tdco, *tdco_min, *tdco_max);
 	}
 	if (tb[IFLA_CAN_TDC_TDCF_MIN] && tb[IFLA_CAN_TDC_TDCF_MAX]) {
 		__u32 *tdcf_min = RTA_DATA(tb[IFLA_CAN_TDC_TDCF_MIN]);
 		__u32 *tdcf_max = RTA_DATA(tb[IFLA_CAN_TDC_TDCF_MAX]);
+		const char *tdcf = is_xl ? " xtdcf" : " tdcf";
 
-		can_print_timing_min_max("tdcf", " tdcf", *tdcf_min, *tdcf_max);
+		can_print_timing_min_max("tdcf", tdcf, *tdcf_min, *tdcf_max);
 	}
 	close_json_object();
 }
@@ -570,7 +687,7 @@ static void can_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 		print_uint(PRINT_ANY, "brp_inc", " dbrp_inc %u", dbtc->brp_inc);
 
 		if (tb[IFLA_CAN_TDC])
-			can_print_tdc_const_opt(tb[IFLA_CAN_TDC]);
+			can_print_tdc_const_opt(tb[IFLA_CAN_TDC], false);
 
 		close_json_object();
 	}
@@ -609,6 +726,94 @@ static void can_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
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
+		print_uint(PRINT_ANY, "bitrate", " xbitrate %u", dbt->bitrate);
+		snprintf(dsp, sizeof(dsp), "%.3f", dbt->sample_point / 1000.);
+		print_string(PRINT_ANY, "sample_point", " xsample-point %s",
+			     dsp);
+		can_print_nl_indent();
+		print_uint(PRINT_ANY, "tq", " xtq %u", dbt->tq);
+		print_uint(PRINT_ANY, "prop_seg", " xprop-seg %u",
+			   dbt->prop_seg);
+		print_uint(PRINT_ANY, "phase_seg1", " xphase-seg1 %u",
+			   dbt->phase_seg1);
+		print_uint(PRINT_ANY, "phase_seg2", " xphase-seg2 %u",
+			   dbt->phase_seg2);
+		print_uint(PRINT_ANY, "sjw", " xsjw %u", dbt->sjw);
+		print_uint(PRINT_ANY, "brp", " xbrp %u", dbt->brp);
+
+		if (tb[IFLA_CAN_XL_TDC])
+			can_print_xtdc_opt(tb[IFLA_CAN_XL_TDC]);
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
+		can_print_timing_min_max("tseg1", " xtseg1",
+					 dbtc->tseg1_min, dbtc->tseg1_max);
+		can_print_timing_min_max("tseg2", " xtseg2",
+					 dbtc->tseg2_min, dbtc->tseg2_max);
+		can_print_timing_min_max("sjw", " xsjw", 1, dbtc->sjw_max);
+		can_print_timing_min_max("brp", " xbrp",
+					 dbtc->brp_min, dbtc->brp_max);
+		print_uint(PRINT_ANY, "brp_inc", " xbrp_inc %u", dbtc->brp_inc);
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
+		print_uint(PRINT_ANY, "xl_data_bittiming_bitrate", " xbitrate %u",
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
2.51.2


